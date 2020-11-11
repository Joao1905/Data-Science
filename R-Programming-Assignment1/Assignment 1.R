##Downloading archives

fileName <- "getdata_dataset.zip"
FileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists(fileName)) {
    download.file(FileURL, fileName)
}

if (!file.exists("UCI HAR Dataset")) {
    unzip(fileName)
}


##Organizing Features

activityLabels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt", col.names = c("Number", "Label"))
features <- read.table(".\\UCI HAR Dataset\\features.txt", col.names = c("Number", "Feature"))

features.MS <- grep("(mean|std)\\(\\)", features$Feature)
features.MS.names <- features[features.MS, 2] 
features.MS.names <- gsub("-", " ", features.MS.names, fixed = T)
features.MS.names <- gsub("mean()", "Mean", features.MS.names, fixed = T)
features.MS.names <- gsub("std()", "StD", features.MS.names, fixed = T)


##Reading Data Set

Train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")
TrainX <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")[,features.MS]
TrainY <- read.table(".\\UCI HAR Dataset\\train\\Y_train.txt")
Train <- cbind(Train,TrainY,TrainX)
colnames(Train) = c("Subject", "Activity", features.MS.names)

Test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
TestX <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")[,features.MS]
TestY <- read.table(".\\UCI HAR Dataset\\test\\Y_test.txt")
Test <- cbind(Test,TestY,TestX)
colnames(Test) = c("Subject", "Activity", features.MS.names)


##Merging Data Sets

Data <- rbind(Test, Train)


#Avarage table (participant x activity x feature)

Data.Melted <- melt(Data, id = c("Subject", "Activity"))
Data.Mean <- dcast(Data.Melted, Subject + Activity ~ variable, mean)

write.table(Data.Mean, "Tidy Data.txt", row.names = FALSE, quote = FALSE)

