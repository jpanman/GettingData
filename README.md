# GettingData
The run_analysis.R file creates a tidy data set from the UCI HAR data (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

# Structure
The run_analysis.R file can be run as long as the Samsung data is in your main repository.
The data is combined using rbind and and cbind to preserve the ordering of the data. 
All columns with "std" or "mean" in the title are filtered and saved in a separate data set.

# Output
The final filtered file is called 'combined', which is then passed through the dplyr group_by and sumarise_all functions to create the final tidy data set 'tidyset'
