## R script for Getting and cleaning data project

## Install CRAN Module:

install.packages("stringr")
library("stringr")

## stringr package: provides pattern matching functions to detect, locate, extract, match, replace,
## and split strings.


##Step 1:  Downloading the data and unzipping to a folder

## 1.1:Check for a folder called data, if the folder does not exist it creates a folder called data

if(!file.exists("./data")){dir.create("./data")}

##  1.2: Downloading the data zip file

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

## 1.3 Unzipping the data zip file & defining the directory for the data.
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## 1.4  List all the files of UCI HAR Dataset in the folder.
File_list <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(File_list , recursive=TRUE)
files

## Step 2:Reading all of the required files:

## 2.1 Reading the Activity files

Y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

## 2.2: Reading the features files

X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")

## 2.3: Reading the Subject Files

subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")  
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt") 

## 2:4 Reading the Activity_labels

activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

## 2:5 Reading the features

features <- read.table("./data/UCI HAR Dataset/features.txt")


## Test: Check properties
##str(Y_train)
##str(y_test)
##str(X_train)
##str(X_test)
##str(subject_train)
##str(activity_labels)
##str(features)

## Step 3: Adding Colnames & Combining data sets

## 3.1  Adding Colnames 
colnames(X_train) <- features[,2]
colnames(Y_train) <- "Training_labels"
colnames(subject_train) <- "subject_train_IDs"
colnames(X_test) <- features[,2]
colnames(y_test) <- "Training_labels"
colnames(subject_test) <- "subject_train_IDs"

## 3.2 Combining data sets

Combining_train <- cbind(Y_train,subject_train,X_train)
Combining_Test <- cbind(y_test, subject_test, X_test)
Combined <- rbind(Combining_train,Combining_Test)

## 3.3 Getting colnames

colNames1 <- colnames(Combined)

## Step 4: Getting the Means & Std

## 4.1 Getting the means using Str_detect:
                        
Getting_Mean_and_Std <- (str_detect(colNames1,"Training_labels")|
                str_detect(colNames1,"subject_train_IDs")|
                str_detect(colNames1,"mean..")|
                str_detect(colNames1,"std..")  
                
                
)

## 4.2 Getting the Means & Std results
setting_up_ForMeanAndStd <- Combined[ , Getting_Mean_and_Std == TRUE]

## 4.3 Mergeing Mean And Std data with the activity_labels.
setting_up_WithActivityNames <- merge(setting_up_ForMeanAndStd,activity_labels,
                              all.x=TRUE)

## 5: Getting the Tidy Data set

##5.1
## Many times that error will appear when you previously created an object called "mean" in the R environment.
## This creates a conflict when calling the function "mean". To stop this error use 
## rm(mean)# this remove the object "mean" from the environment and allow R to call the function "mean"

rm(mean)

## Ignore Warning message:
## In rm(mean) : object 'mean' not found

## 5.2 Creating the data set

secTidySet <- aggregate(. ~subject_train_IDs + Training_labels, setting_up_WithActivityNames,mean)
secTidySet <- secTidySet[order(secTidySet$subject_train_IDs, secTidySet$Training_labels),]

## 5.3  Creates the sectidySet data out 
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)



