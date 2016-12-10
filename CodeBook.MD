### Loading test and training data sets, and features file
# Loading the test and train datasets:
All 3 test files are loaded with the appendix 'test':
* subjecttest: vector with 2941 subject IDs
* xtest: matrix of (561,2941) dimension with variables for different sensors and measurements
* ytest : type of action being performed by the subject, see codes in UCI HAR zip file 'activity_labels.txt'

Similarly, the training files are loaded and appended with 'train':
* subjecttrain: vector with 7352 subject IDs
* xtrain: matrix of (561,7352) dimension with variables for different sensors and measurements
* ytrain: vector with 7352 type of action being performed by the subject, see codes in UCI HAR zip file 'activity_labels.txt'

# Loading variable names in the 2nd column of the "features.txt"
The 'features.txt' file is loaded to determine the descriptive variable names.

## Combining datasets
# Combining xtest and xtrain data sets
rbind is used to combine test and training data together to keep ordering, followed by the subject ID files, also using rbind to keep ordering.
Finally the subjecttest and subjecttrain files, in this order to keep the ordering.
Combines ytest and ytrain labels for actions, also using rbind.

# Filtering the columns that include mean and std
Since the combined data set is 561 variables and the features are 561 observations, we use the fact
that they are in the same order to determine which positions in the features vector have the 
"mean" and "standard" deviation and extract those columns from the combined data. 
Viewing the features file shows that all the labels are in the format "-mean()" or "-std()", so 
no need to worry about different capitalizations or spellings.

#Changing variable names and combining actions and subject vectors
Change variable name in subject test to "subject_ID" and actions using 'rename'

Now we need to combine the actions and subject vectors to the combined test-train dataset.
This uses cbind to preserve the ordering of the data.

# Replacing activity numbers with descriptive names, 
Loading the "activity_labels.txt" files and matching the activity labels in the 'actions' using merge. Since the ordering doesn't matter anymore we can use this function.
The obsolete activity code column is removed, and the descriptive activity column is renamed.
