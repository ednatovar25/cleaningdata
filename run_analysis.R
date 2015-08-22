
X_train_data <- read.table("train/X_train.txt", header = FALSE) 
y_train_data <- read.table("train/y_train.txt", header = FALSE) 
subject_train_data <- read.table("train/subject_train.txt", header = FALSE) 

X_test_data <- read.table("test/X_test.txt", header = FALSE) 
y_test_data <- read.table("test/y_test.txt", header = FALSE) 
subject_test_data <- read.table("test/subject_test.txt", header = FALSE) 

subjectdata <- rbind(subject_train_data, subject_test_data)
activitydata <- rbind(y_train_data, y_test_data)
featuresdata <- rbind(X_train_data, X_test_data)

View(featuresdata)


activity_labels <- read.table("activity_labels.txt", header = TRUE) 


features <- read.table("features.txt")
View(features)