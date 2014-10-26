#Loading required libraries
library(dplyr)
library(reshape2)

#Metadata
activity_labels <- read.table("./activity_labels.txt", quote="\"")
names(activity_labels) <- c("activity_id","activity_label")
features <- read.table("./features.txt", quote="\"")

#Getting the test data
subject_test <- read.table("./test/subject_test.txt", quote="\"")
X_test <- read.table("./test/X_test.txt", quote="\"")
y_test <- read.table("./test/y_test.txt", quote="\"")
#Combining X and y test data
syX_test <- cbind(subject_test, y_test, X_test)

#Getting the train data
subject_train <- read.table("./train/subject_train.txt", quote="\"")
X_train <- read.table("./train/X_train.txt", quote="\"")
y_train <- read.table("./train/y_train.txt", quote="\"")
#Combining X and y train data
syX_train <- cbind(subject_train,y_train,X_train)

#Merging test and train data
CombinedTestTrain <- rbind(syX_test,syX_train)

#Assigning variable names
names(CombinedTestTrain) <- c("subject", "activity_id", as.character(features$V2))

#Cleaning duplicate columns
duplicateCols <- duplicated(names(CombinedTestTrain))
CleanData <- CombinedTestTrain[,!duplicateCols]

#Retrieving only cols with mean or std in their labels
CleanDataMeanStd <- select(CleanData, matches("(subject|activity|std|mean)", ignore.case=TRUE))
CleanDataMeanStd_withActivityLabels <- inner_join(activity_labels,CleanDataMeanStd, by="activity_id")
CleanDataMeanStd_withActivityLabels <- select(CleanDataMeanStd_withActivityLabels, -contains("activity_id"))


meltData <- melt(CleanDataMeanStd_withActivityLabels, id=c("subject","activity_label"))
castedData <- dcast(meltData, subject + activity_label ~ variable, mean)

write.table(castedData, "tidy.csv", row.name=FALSE)

