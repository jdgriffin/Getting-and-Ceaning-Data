### Getting and Cleaning Data - Project ###
### 25 Spetember 2015 ###

# This is to set the working directory
projectWD <- "~/Coursera/Data Science/3. Getting and Cleaning Data/Project"
setwd(projectWD)
getwd()

# Load the previous workspace session
load(Project.Rdata)

# Check the previous workspace
ls()

# This is to list the files required
dir <- "./UCI HAR Dataset/test/"
filelist <- list.files(dir, pattern = "txt")

#Read in the Test data

subjectTest <- read.table(paste(dir,filelist[1],sep=""), header=FALSE)
colnames(subjectTest) <- "subject"

x_test <- read.table(paste(dir,filelist[2],sep=""), header=FALSE)
columnlist <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
colnames(x_test) <- columnlist$V2

y_test <- read.table(paste(dir,filelist[3],sep=""), header=FALSE)
colnames(y_test) <- "activity"

# Bind test data into a single data frame
testData <- cbind(subjectTest,y_test)
testData <- cbind(testData,x_test)

# Train data

# This is to list the train files required
dir <- "./UCI HAR Dataset/train/"
filelist <- list.files(dir, pattern = "txt")

# Read in the Test data
subjectTrain <- read.table(paste(dir,filelist[1],sep=""), header=FALSE)
colnames(subjectTrain) <- "subject"

x_train <- read.table(paste(dir,filelist[2],sep=""), header=FALSE)

# APply column names to x_train data 
#columnlist <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
colnames(x_train) <- columnlist$V2

y_train <- read.table(paste(dir,filelist[3],sep=""), header=FALSE)
colnames(y_train) <- "activity"

# Bind test data into a single data frame
trainData <- cbind(subjectTrain,y_train)
trainData <- cbind(trainData,x_train)

# Merge Test and train data
T_Data <- rbind(testData,trainData)

# Remove duplicate columns
T_Data <- T_Data[, !duplicated(colnames(T_Data))]

# Switch the number activity with a character activity
T_Data$activity <- sapply(T_Data$activity ,switch,"1"="walking", "2"="walking_upstairs","3"="walking_downstairs", 
                          "4"="sitting", "5"="standing","6"="laying")

# Filter the dataframe so it only contains "subject, activity" and remaining 
# columns containing the string "std" and "mean"
library(dplyr)
T_Data <- select(T_Data, contains("subject", ignore.case=TRUE), contains("activity", 
                  ignore.case=TRUE),contains("mean()", ignore.case=TRUE),contains("std()", ignore.case=TRUE))

#Order the rows by subject and activity
T_Data <- arrange(T_Data, subject, activity)

write.table(T_Data, "Overall_Data.txt",sep = "\t", row.names = FALSE)

# Reshape the data into dsitinct records relating each subject and activity
library(reshape2)
temp <-colnames(T_Data)
T_DataMelt <- melt(T_Data, id=c("subject","activity"), measure.vars = temp[3:length(temp)])

# Cast into a dataframe - group by subject and activity with the mean of all variable values
Tidy_Data <- dcast(T_DataMelt, subject + activity ~ variable,mean)

# OUtput the results of the Tidy_Test_Data as a tab delimited file
write.table(Tidy_Data, "Tidy_Data.txt",sep = "\t", quote=FALSE, row.names = FALSE)

# Save the workspace session
#save.image(".Rdata")

# Clear the workspace
#rm(list=ls())

