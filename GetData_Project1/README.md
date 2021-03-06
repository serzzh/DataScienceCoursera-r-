---
title: "Getting an Cleaning Data: Course Project 1"
output: 
html_document:
keep_md: true
---

# GetData_Project1
## Getting and Cleaning Data. Course Project 1.

This document explains how all of the scripts work and how they are connected.   
Please download data archive https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip    

## Scripts

### (chscr.R) Checking if the data exists and unzipping archive 
1) checking if the folder "UCI HAR Dataset" exists and number of files in it 
2) if the folder is missing checking if zip archive exists and unzipping it  
3) if no data exits alerts error message  


```r
## Function chsrc for checking if the data exists
source('chsrc.R')
```

### (read_var.R) Function for reading data from txt files 
1) choosing .txt files from the 'files' vector for given variable (e.g. body_acc_x) and option(train or test)  
2) reading data from .txt (fixed row width file) using laf_open_fwf() function. Please install LaF library, this method works faster than read.fwf or read.table. Function fread() data.table packages gives error on this data due to the problem of leading spaces.  
3) returning only the mean and the median for each observation  


```r
## Function for reading variable data from file and returning mean and median
source('read_var.R')
```

### (run_analysis.R) Main program block
If the data exists (using chdir)  
1) Reading filenames into a vector  
For test and train sets  
2) Reading subjects for observations  
3) Reading activities for observations and descriptive lables  
4) Reading data for each variable (using read.var)  



```r
if(chsrc(destfile, dir)) {
        
        ## Reading filenames to a vector
        files <- as.vector(dir(dir, full.names = TRUE, recursive = TRUE))
        
        ## 1. Merging the training and the test sets to create one data set.  
        ## 1. Merging the training and the test sets to create one data set.  
        for (i in c(1,2)){
                             
                ## Reading subjects
                subj_file <- files[grepl(paste0('subject', options[i]), files)]
                subject <- read.table(subj_file, header=FALSE)[,1]
                
                ## 3. Using descriptive activity names to name the activities in the data set.   
                y_file <- files[grepl(paste0('/y',options[i]), files)]
                act_file <- files[grepl('activity_labels', files)]
                activity <- read.table(y_file, header=FALSE)
                labels <- read.table(act_file, header=FALSE)
                colnames(activity) <-c('act_id')
                colnames(labels) <-c('act_id', 'activity')
                
                ## Writing data to the dataset
                data <- cbind(subject, merge(activity,labels))[c(1,3)]
                               
                for (j in 1:10){
                        rdata <- read.var(vars[j], files, option=options[i])               
                        data <- cbind(data, rdata)
                }
                resdata <- rbind(resdata, data)
         }
        
}
```

5) Creating second dataset with averages for subject, activity and variable  

```r
        ## 5. Creating a second (from data set in step 4), independent tidy data set with the average of each variable for each activity and each subject.
        library(plyr)
        resdata$subject <- factor(resdata$subject)
        resdata$activity <- factor(resdata$activity) 
        resdata2 <- ddply(resdata,.(activity, subject), colwise(mean))
        write.table(resdata2, file='result_data.txt', row.name=FALSE)
```

## Codebook

Please see file Codebook.md

## Assignment

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following.   
1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.   
3. Uses descriptive activity names to name the activities in the data set.  
4. Appropriately labels the data set with descriptive variable names.   
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

Good luck!
