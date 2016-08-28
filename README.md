---
title: "README.md"
author: "CB"
date: "28 August 2016"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Getting and Cleaning Data - Coursera Project

This is for the Getting and Cleaning Data course for Coursera. The Code written in R file.

Source file is run_analysis.R. 

##Step 1:  Downloading the data and unzipping to a folder

        * 1.1 Check for a folder called data, if the folder does not exist it creates a folder called data
        * 1.2 Downloading the data zip file
        * 1.3 Unzipping the data zip file & defining the directory for the data.
        * 1.4 List all the files of UCI HAR Dataset in the folder.
        
## Step 1: Notes: lists all of the files that are in the UCI HAR Dataset folder. These files that will be used to load data are listed below:

        * test/subject_test.txt
        * test/X_test.txt
        * test/y_test.txt
        * train/subject_train.txt
        * train/X_train.txt
        * train/y_train.txt


## Step 2:Reading all of the required files:

      * 2.1 Reading the Activity files
      * 2.2 Reading the features files   
      * 2.3 Reading the Subject Files
      * 2:4 Reading the Activity_labels
      * 2:5 Reading the features

## Step 3: Adding Colnames & Combining data sets:

      * 3.1  Adding Colnames (Sets names to variables)
      * 3.2 Combining data sets (Merge columns to get the data frame Data for all data, then by row)
      * 3.3 Getting colnames
      
###Notes: Merges the training and the test sets to create one data set.

## Step 4: Getting the Means & Std:
        # Extracts only the measurements on the mean and standard deviation for each measurement
        * 4.1 Gets the means using Str_detect:
        * 4.2 Gets the Means & Std results
        * 4.3 Mergeing Mean And Std data with the activity_labels
        
## 5: Getting the Tidy Data set
        * 5.1 rm(mean)# this remove the object "mean" from the environment and allow R to call the function              "mean"
        * 5.2 Creating the Tidy data set
        * 5.3 Creates the sectidySet data out 
        