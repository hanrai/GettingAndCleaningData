Getting And Cleaning Data course project
======================

## Files:
* README.md:            Readme file. Describe how script works.
* run_analysis.R:       Script for this course project
* tidy.csv.txt:         The result tidy file. It's a csv file, so you can just remove the '.txt' then view it in excel.
* Cookbook.md:          Cookbook for tidy dataset.

## run_analysis.R
### Usage:
1. Download data file from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. Unzip this file to your working dir. So you got the 'UCI HAR Dataset' folder in your working directory.
3. Use 'source("run_analysis.R")' to run the script. It will take you about one minute.
4. You got the tidy dataset 'tidy.csv.txt'.

### How script working:
This script will archive these goals:
* Goal 1. Merges the training and the test sets to create one data set.
* Goal 2. Extracts only the measurements on the mean and standard deviation for  each measurement. 
* Goal 3. Uses descriptive activity names to name the activities in the data set
* Goal 4. Appropriately labels the data set with descriptive variable names. 
* Goal 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

I was trying to keep this script simple and short. So it's working in order 1, 4, 3, 2, 5. It will save some lines of code in this order(one goal one directive).

#### First, I create some virables for filenames, it will makes your code looks beautiful. 
And if you unzip your data to somewhere else, you juse need to change data.dir to point to your data dir. Easy to change. :)

#### Goal 1: Merges the training and the test sets to create one data set. 
I use read.table here, because I don't need to change any default option here. See the document for read.table, you will see head = FALSE, sep = "", it's perfect for this project, the shortest solution. And read.table will return a data.frame, so I can use cbind to bind subject and activity together directly. Why? Because cbind(read.table("filename"), read.table("filename2")) means cbind(data.frame returned by read.table("filename"), and data.frame returned by read.table("filename2")). And then the same for rbind, it will connect train data and test data together. Because rbind(cbind(...), cbind(...)) means rbind(data.frame returnd by the 1st cbind, and data.frame returned by the 2nd cbind). Finally I got a big and complete data.frame. The code look nice right?

#### Goal 4: Appropriately labels the data set with descriptive variable names. 
After Goal 1 finished, all datas are ready now. It's a good time to add names to columns. Why here? Because I can use column name for reference later if I done it here. It means I can use data$activity instead of data$Vxxx or data[[xxx]]. I read the features file and add 'subject' and 'activity' as colnames. Now every column have their name. 
colnames(data) will return or set the colnames, I will set the colnames. read.table will return a data frame, so read.table(...)$V2 will return the 2nd col of that data frame. If you see the file, you will know it's a string vector. Great. This sentence means I'll read the file 'features.txt' as colnames for data. But data have two more column I added from Goal 1, so I need to add these column names to that vector returned by read.table()$V2. To combine vectors, use c(). 
#### Activity file is arranged in right order, so I can use them directly. Use data$activity as index, replay data$activity column with descriptive names. (Goal 3)
#### Then extract required data for tidy data. But I have to add two columns, 'subject' and 'activity'. I can create new variable to save them, but keep them in data frame will be nice. (Goal 2)
#### Calculate the mean for each activity and each subject. All datas are ready to use, what you need is just a beautiful formula. (Goal 5)
#### Last step, save the data.
