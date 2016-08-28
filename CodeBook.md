title: "CodeBook.md"
author: "CB"
date: "28 August 2016"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Getting and Cleaning Data Course Project

##Original Data set:
## Here is the link to the data for the project:
## Link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Overview for the Human Activity Recognition Using Smartphones Dataset
## Version 1.0

   The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.      Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING,        LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and          gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.    The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly    partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30%    the test data. 

## Information about the original data set:

The dataset includes the following files:
===============================================================================================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
===============================================================================================================
## run_analysis

## R Software Packages require for run_analysis.

## Install CRAN Module:

##install.packages("stringr")
##library("stringr")
The stringr package will install & load when the script is loaded.
## Package Description: ## stringr package: provides pattern matching functions to detect, locate, extract, match, replace, and split strings.

##Step 1:  Downloading the data and unzipping to a folder

Variables defined and their purpose are given below:
   
1.1:Check for a folder called data, if the folder does not exist it creates a folder called data -   if(!file.exists("./data")){dir.create("./data")}

1.2: Downloads the data zip file contained in - fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

1.3 Unzipping the data zip file & defining the directory for the data contained - unzip(zipfile="./data/Dataset.zip",exdir="./data")

1.4  List all the files of UCI HAR Dataset in the folder for path contain in - 
File_list <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(File_list , recursive=TRUE)
files

## Step 2:Reading all of the required files:

## 2.1 Reading the Activity files -
Y_train Holds Data fetched by <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
y_test  Holds Data fetched by<- read.table("./data/UCI HAR Dataset/test/y_test.txt")

## 2.2: Reading the features files

X_train Holds Data fetched by <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
X_test Holds Data fetched by <- read.table("./data/UCI HAR Dataset/test/X_test.txt")

## 2.3: Reading the Subject Files

subject_train Holds Data fetched by <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")  
subject_test Holds Data fetched by <- read.table("./data/UCI HAR Dataset/test/subject_test.txt") 

## 2:4 Reading the Activity_labels

activity_labels Holds Data fetched by <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

## 2:5 Reading the features

features Holds Data fetched by <- read.table("./data/UCI HAR Dataset/features.txt")

Not used: 

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

Combining_train uses Cbind function to merge the Train data - <- cbind(Y_train,subject_train,X_train)
Combining_Test uses Cbind function to merge the test data <- cbind(y_test, subject_test, X_test)
Combined uses the rbind function to merge the train & test data <- rbind(Combining_train,Combining_Test)

## 3.3 Getting colnames
colNames1 uses the colname function to extract the column names<- colnames(Combined)

## 4.1 Getting the means using Str_detect:

Getting_Mean_and_Std uses the function  str_detect from the stringr packages
to extract the Training_labels,subject_train_IDs Mean & Std .
          (<- (str_detect(colNames1,"Training_labels")|
          str_detect(colNames1,"subject_train_IDs")|
          str_detect(colNames1,"mean..")|
          str_detect(colNames1,"std..")  
                
## 4.2 Getting the Means & Std results   

setting_up_ForMeanAndStd obtain the matches <- Combined[ , Getting_Mean_and_Std == TRUE]


## 4.3 Mergeing Mean And Std data with the activity_labels.

setting_up_WithActivityNames uses the merge function to combine the
Getting the Means & Std results wit the activity_labels
<- merge(setting_up_ForMeanAndStd,activity_labels,
                              all.x=TRUE)

## 5: Getting the Tidy Data set

Notes: ##5.1
## Many times that error will appear when you previously created an object called "mean" in the R environment.
## This creates a conflict when calling the function "mean". To stop this error use 
## rm(mean)# this remove the object "mean" from the environment and allow R to call the function "mean"

uses this function to  bypass the R mean function :rm(mean)

Message to Ignore Warning
## Ignore Warning message:
## In rm(mean) : object 'mean' not found

## 5.2 Creating the data set

Creates a second, independent tide set with the aeverage of each variable for
each activity and each Subject:

secTidySet <- aggregate(. ~subject_train_IDs + Training_labels, setting_up_WithActivityNames,mean)
secTidySet <- secTidySet[order(secTidySet$subject_train_IDs, secTidySet$Training_labels),]

## 5.3  Creates the sectidySet data outout:
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)

Output: secTidySet
