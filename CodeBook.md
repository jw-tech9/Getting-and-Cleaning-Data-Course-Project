Dowload and read data set files
	Download and unzip files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

Read data files in R
	features <- features.txt, col.names = c("n","feature")
	activities <- activity_labels.txt, col.names = c("label", "activity")
  
	subject_test <- subject_test.txt, col.names = "subject"
	x_test <- X_test.txt", col.names = features$feature
	y_test <- y_test.txt", col.names = "label"

	subject_train <- subject_train.txt", col.names = "subject"
	x_train <- X_train.txt", col.names = features$feature
	y_train <- y_train.txt", col.names = "label"

Merges the training and the test sets to create one data set.
	# merge 4 train and test data together
	x <- rbind(x_train, x_test)
	y <- rbind(y_train, y_test)
	subject <- rbind(subject_train, subject_test)
	
	# merge all data into one data frame
	mergedData <- cbind(subject, y, x)
	
Extracts only the measurements on the mean and standard deviation for each measurement. 

	subData <- dplyr::select(mergedData, subject, label, contains("mean"), contains("std"))


Uses descriptive activity names to name the activities in the data set

	# replace activity label with descriptive text
	subData$label <- activities[subData$label, 2]

Appropriately labels the data set with descriptive variable names. 

	#use gsub function to replce abbrivated column names to the more descriptive names
	names(subData)[2] = "activity"
	names(subData) <- gsub("^t", "Time", names(subData))
	names(subData) <- gsub("^f", "Frequency", names(subData))
	names(subData) <- gsub("Acc", "Acceleration", names(subData), ignore.case = FALSE)
	names(subData) <- gsub("Jerk", "JerkSignals", names(subData), ignore.case = FALSE)
	names(subData) <- gsub("BodyBody", "Body", names(subData), ignore.case = FALSE)
	names(subData) <- gsub("Gyro", "Gyroscope", names(subData), ignore.case = FALSE)
	names(subData) <- gsub("Mag", "Magnitude", names(subData), ignore.case = FALSE)
	names(subData) <- gsub("mean", "Mean", names(subData))
	names(subData) <- gsub("std", "StandardDeviation", names(subData))
	names(subData) <- gsub("Freq", "Frequency", names(subData))
	
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

	# group data by activity and subject, and take mean of all columns
	# then export data frame to external table file.
	tidyData <- subData %>% 
	  group_by(activity, subject) %>%
	  summarize_all(list(mean))
	write.table(tidyData, file="tidyData.txt", row.name=FALSE ) 
