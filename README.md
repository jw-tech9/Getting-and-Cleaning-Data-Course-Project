# Getting-and-Cleaning-Data-Course-Project

Peer-graded Assignment: Getting and Cleaning Data Course Project
Submitted by John Wang

Data for the project:	

	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  	
	
Files

	CodeBook.md - Indicate all the variables and summaries calculated, along with units, and any other relevant information.  It include step by step data manipulations performed in run_analysis.R file.
	
	run_analysis.R - R scripts that perform the following 5 tasks
	1.  Merges the training and the test sets to create one data set.
	2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
	3.  Uses descriptive activity names to name the activities in the data set
	4.  Appropriately labels the data set with descriptive variable names. 
	5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	
	tidyData.txt - Final result after running run_analysis.R, which is an independent tidy data set with the average of each variable for each activity and each subject.  You ca load the tidyData.txt vir R read.Tabble command.
