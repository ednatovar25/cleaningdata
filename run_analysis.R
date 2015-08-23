
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
colnames(subjectdata)<-"Subject Data"
colnames(activitydata)<-"Activity Data"
allMergedData <-cbind(featuresdata,activitydata,subjectdata)

#View(activitydata)
#View(subjectdata)
#View(featuresdata)

meanAndStdcols <- c((grep(".*Mean.*|.*Std.*", names(allMergedData), ignore.case=TRUE)),562,563)
View(allMergedData)
View(meanAndStdcols)

requiredData <- allMergedData[,meanAndStdcols]
View(requiredData)

write.table(requiredData,file="tidy.txt",row.names=FALSE)
