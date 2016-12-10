setwd("~/Documents/Coursera/GettingData/Assignment/UCI HAR Dataset")

#Load necessary libraries
library(dplyr)
library(tidyr)

### Loading test and training data sets, and features file
# Loads test data files
subjecttest<-read.table("./test/subject_test.txt",header = FALSE)
xtest<-read.table("./test/X_test.txt", header = FALSE)
ytest<-read.table("./test/Y_test.txt", header = FALSE)


# Loads training data files
subjecttrain<-read.table("./train/subject_train.txt")
xtrain<-read.table("./train/X_train.txt")
ytrain<-read.table("./train/Y_train.txt")


# Load variable names in the 2nd column of the "features.txt"
features = read.table("./features.txt", header = FALSE)[2]




## Combining xtest and xtrain data sets
# Combines test and training data together using rbind to keep ordering
combined<-rbind(xtest,xtrain)


# Combines the subjecttest and subjecttrain files, in this order to keep the ordering.
subject<-rbind(subjecttest,subjecttrain)


# Combines ytest and ytrain labels for actions
actions<-rbind(ytest,ytrain)


## Filtering the columns that include mean and std
## Since the combined data set is 561 variables and the features are 561 observations, we use the fact
## that they are in the same order to determine which positions in the features vector have the 
## "mean" and "standard" deviation and extract those columns from the combined data. 
## Viewing the features file shows that all the labels are in the format "-mean()" or "-std()", so 
## no need to worry about different capitalizations or spellings.
names(combined) <- features[ ,1]
combined <- combined[grepl("std|mean", names(combined), ignore.case = TRUE)] 


# Change variable name in subject test to "subject_ID"
subject<-rename(subject,subject_ID=V1)


# Change variable name in ytest to be "activity"
actions<-rename(actions,activity=V1)


# Now we need to combine the actions and subject vectors to the combined test-train dataset.
# This uses cbind to preserve the ordering of the data.
combined<-cbind(subject,actions,combined)


## Replacing activity numbers with descriptive names, 
# Loading the "activity_labels.txt" files
activity_labels<-read.table("./activity_labels.txt",header = FALSE)


# Match activity labels to appropriate values in "actions"
combined<-merge(combined,activity_labels,by.x="activity",by.y="V1")


# Remove obsolete activity code and rename the descriptive activity column
combined$activity<- NULL
combined<-rename(combined,activity=V2)  


## Create second independent tidy data set with average of each variable for 
## each activity and each subject:
tidyset<-group_by(combined, subject_ID, activity) %>%
        summarise_all(mean) 


## End