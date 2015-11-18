##
## ### COURSERA - Getting and Cleaning Data - COURSE PROJECT 
##
## ### DEPENDENCIES - reshape2
## install.packages("reshape2")
##

library(reshape2)

## CLEAN THE WORK SPACE ##
rm(list = ls())

## DOWNLOAD AND UNZIP THE DATASET IN THE CURRENT WORK DIRECTORY
UCIzip <- "UCI_dataset.zip"

if(!file.exists(UCIzip)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, UCIzip, method = 'curl')
}
if(!file.exists("UCI HAR Dataset")){
  unzip(UCIzip)
}

## LOAD activity_labels.txt (SUBJECT ACTIVITIES) AND features.txt (COLUMN NAMES - VARIABLES)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityID", "activity"), colClasses = "character")
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("featureID", "feature"), colClasses = "character")

## GET THE COLUMNS FOR mean AND standard deviation
meanStdCols <- grep(".*mean.*|.*std.*", features[,2])
meanStdCols.names <- features[meanStdCols,2]
## RENAME THE COLUMNS
meanStdCols.names = gsub('-mean', 'Mean', meanStdCols.names)
meanStdCols.names = gsub('-std', 'Std', meanStdCols.names)
meanStdCols.names <- gsub('[-()]', '', meanStdCols.names)

## LOAD THE DATASETS ONLY WITH THE DESIRED COLUMNS
train <- read.table("UCI HAR Dataset/train/X_train.txt")[meanStdCols]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[meanStdCols]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

## MERGE TRAIN AND TEST DATASETS
allData <- rbind(train, test)
## ADD COLUMN NAMES
colnames(allData) <- c("subject", "activity", meanStdCols.names)

## PARSE activity AND subject TO factors
allData$activity <- factor(allData$activity, levels = activity_labels[,1], labels = activity_labels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy_ds.txt", row.names = FALSE, quote = FALSE)
