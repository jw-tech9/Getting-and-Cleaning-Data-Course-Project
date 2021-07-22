library(dylyr)

# downloand and unzip files
#
# Checking if archieve already exists.
filename <- "UCI_HAR_Dataset.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  
# unzip file
unzip(filename) 

#
#Read data
#
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","feature"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("label", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "label")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "label")

#
# 1.  Merges the training and the test sets to create one data set.
#
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
mergedData <- cbind(subject, y, x)
#
# 2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
#
subData <- dplyr::select(mergedData, subject, label, contains("mean"), contains("std"))
#
# 3.  Uses descriptive activity names to name the activities in the data set
#
subData$label <- activities[subData$label, 2]
#
# 4.  Appropriately labels the data set with descriptive variable names. 
#
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
#
# 5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
tidyData <- subData %>% 
  group_by(activity, subject) %>%
  summarize_all(list(mean))
write.table(tidyData, file="tidyData.txt", row.name=FALSE )  