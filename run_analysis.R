#run_analysis.R does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.

library(dplyr)
library(data.table)

#Read Training Data
X_train_data <- read.table("train/X_train.txt", header = FALSE) 
y_train_data <- read.table("train/y_train.txt", header = FALSE) 
subject_train_data <- read.table("train/subject_train.txt", header = FALSE) 

#Read Test Data
X_test_data <- read.table("test/X_test.txt", header = FALSE) 
y_test_data <- read.table("test/y_test.txt", header = FALSE) 
subject_test_data <- read.table("test/subject_test.txt", header = FALSE) 

#Merge Training and Test Data
subjectdata <- rbind(subject_train_data, subject_test_data)
activitydata <- rbind(y_train_data, y_test_data)
featuresdata <- rbind(X_train_data, X_test_data)

#Read Activity and Features Label Data
activity_labels <- read.table("activity_labels.txt", header = TRUE) 
features <- read.table("features.txt")

#Use features column 2 transposed as features data column headers
colnames(featuresdata) <-  t(features[2])
colnames(subjectdata)<-"SubjectData"
colnames(activitydata)<-"ActivityData"
allMergedData <-cbind(featuresdata,activitydata,subjectdata)
#allMergedData <-cbind(subjectdata,activitydata,featuresdata)

#View(activitydata)
#View(subjectdata)
#View(featuresdata)

meanAndStdcols <- c((grep(".*Mean.*|.*Std.*", names(allMergedData), ignore.case=TRUE)),562,563)
View(allMergedData)
View(meanAndStdcols)

requiredData <- allMergedData[,meanAndStdcols]
View(requiredData)

names(requiredData)<-gsub("^t", "Time", names(requiredData))
names(requiredData)<-gsub("^f", "Frequency", names(requiredData))

#Use Activity Labels to assign descriptive names to the Activity Data Column
requiredData$ActivityData <- as.character(requiredData$ActivityData)
labelslength = length(activity_labels)
for (i in 1:6){
  requiredData$ActivityData[requiredData$ActivityData == i] <- as.character(activity_labels[i,2])
}

requiredData$SubjectData <- as.factor(requiredData$SubjectData)
requireddData <- data.table(requiredData)

write.table(requiredData,file="tidy.txt",row.names=FALSE)

allData <- aggregate(. ~SubjectData + ActivityData, requiredData, mean)
allData <- allData[order(allData$SubjectData,allData$ActivityData),]
write.table(allData, file = "tidy.txt", row.names = FALSE)
