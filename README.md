README
========================================================

Coursera course: Getting and Cleaning Data April 25, 2014

Data Set: Human Activity Recognition Using Smartphones

Data set for project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

derrived from the original data set:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Citation:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Assignment Objective:
- **Create a tidy data set with the average of each mean and std variable for each activy and each subejct**

Once downloaded and unzipped, sourcing and running the run_analyis.R script in the same working directory as the unzipped raw data set will produce the tidy data set required by the assignment *as long as the Samsung data flie structure is not altered.*

**run_analysis.R assumes the data set is in the working directory and the file structure is unalterted.**

From the README.txt file in the UIC HAR data folder, the 
- X_<test/train>.txt files contain the observational data. Details on processing by authors can be found in features_info.txt
- features.txt file contains the variable names for the X_<test/train>.txt data
- activity_labels.txt contains the row descriptions for each observation in X_<test/train>.txt as defined in y_<test/train>.txt
- subject_<test/train>.txt contain the subject generating each observation in X_<test/train>.txt 


Required Libraries:
```
library(reshape2)
```

The output of run_analysis.R is a 180 x 68 data.frame. See CodeBook.md for more detail on the Tidy Data Set variables and original variables and data used for this analysis.

To generate the output, run_analysis.R does the following data manipulations:

1. Loads into R from the UCI HAR data files the variable names, subject keys, activity names, and only the mean() and std() columns required for analysis per the assignment.
2. Combines test and train data, appending subject and activty keys to each observation, merging activity descriptions by activty key, and finally adding column names and deleting the activity key column.
3. Melting the combined data frame with subject and activity as ids and the test and train variables as the measured variables.
4. d-casts the melted data frame using activity + subject ~ variables with the aggregate function mean. 


