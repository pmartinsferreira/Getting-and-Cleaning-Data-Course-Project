# INTRO -----
rm(list = ls())

setwd("~/Dropbox/coursera/03_getting_and_cleaning_data/W04/courseProject/")
dataFilesPath <- "./UCI HAR Dataset/"

if (!require("reshape2")) {
  install.packages("reshape2")
}
require("reshape2")


# P1) Load meta-data -----
features <- read.table(paste(dataFilesPath, "features.txt",sep = ""))[,2]
relevantFeatures <- grepl("mean|std", features)
activityLabels <- read.table(paste(dataFilesPath, "activity_labels.txt",sep = ""))[,2]

# P2) Load test data ----------
X_test <- read.table(paste(dataFilesPath, "test/X_test.txt", sep = ""))
names(X_test) <- features
X_test <- X_test[,relevantFeatures]

y_test <- read.table(paste(dataFilesPath, "test/y_test.txt", sep = ""))
y_test[,2] <- activityLabels[y_test[,1]]; names(y_test) = c("activityID", "activityLabel")

subjectTest <- read.table(paste(dataFilesPath, "test/subject_test.txt", sep = ""))
names(subjectTest) = "subject"

testDataSet <- cbind(subjectTest, y_test, X_test)
rm(list = c("X_test", "y_test", "subjectTest"))


# P3) Load train data ----------
X_train <- read.table(paste(dataFilesPath, "train/X_train.txt", sep = ""))
names(X_train) <- features
X_train <- X_train[,relevantFeatures]

y_train <- read.table(paste(dataFilesPath, "train/y_train.txt", sep = ""))
y_train[,2] <- activityLabels[y_train[,1]]; names(y_train) = c("activityID", "activityLabel")

subjectTrain <- read.table(paste(dataFilesPath, "train/subject_train.txt", sep = ""))
names(subjectTrain) = "subject"

trainDataSet <- cbind(subjectTrain, y_train, X_train)
rm(list = c("X_train", "y_train", "subjectTrain"))

# P4) Merge test and train data sets -------
dataSet <- rbind(trainDataSet, testDataSet)
rm(list = c("trainDataSet", "testDataSet"))

# P5) Create tidy data set ------
idLabels <- c("subject", "activityID", "activityLabel")
dataLabels <- setdiff(colnames(dataSet), idLabels)
meltData <- melt(dataSet, id = idLabels, measure.vars = dataLabels)

tidyDataSet <- dcast(meltData, subject + activityLabel ~ variable, mean)
rm(list=c("dataSet", "meltData"))

# P6) Write output file ------
write.csv(tidyDataSet, paste(dataFilesPath, "tidyDataSet.csv", sep = ""), row.names = FALSE)
# END ------
