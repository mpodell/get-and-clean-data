CodeBook: Peer Assignment Getting and Cleaning Data
========================================================

Coursera course: Getting and Cleaning Data May 6, 2014

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

See the README.txt and the features_info.txt files in the UCI HAR Dataset folders for details on the original data and variables.

##Original Data Used##
This analysis is restricted to use of the data in the following files:
- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The Inertial Signals data is not used.

Notes on the original data: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about the original dataset contact: activityrecognition@smartlab.ws

##Original Variables##
This analysis is limited to the mean() and std() variables related to the 20 time domain signals and 13 frequency domain signals derrived from the raw accelerometer and gyroscope data. There are 66 total original variables used for this analysis. In the following list -XYZ represents three axial signals: -X, -Y, -Z.

- 20 time domain signals: 

```
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
```

and 13 frequency domain signals:

```
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
```
The complete list of original variables calculated for each of the 33 signals is as follows. However, as mentioned above, only the mean() and std() variables are used for this analysis.
**(by my interpretation of the assignments all meanFreq() variables are not included in the analysis)** 

The complete set of variables that were estimated from these signals are: 

```
mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.
```

Finally, these variables were were calculated for multiple observations of 30 volunteer subjects performing 6 activities. Those activities are: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

##The Tidy Data Set Variables##
The output of run_analysis.R is a 180 x 68 data.frame. The variables are as follows:
```
activity: Factor w/6 levels "LAYING", "SITTING", "STANDING", "WALKING", "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS" 
```
representing the 6 activities in which subjects enagaged to generate the observational data
```
subject: int 1:30
```
representing the 30 subjects that participated in the trials generating the observational data. One row of data is generated for each of the 6 x 30 combinations of activites and subjects.

For each activity/subject combination, averages of all observations for each of the 33 mean() and std() time and frequency domain signals are calculated. The resulting 66 variables are:

```
 [1] "tbodyacc-mean-x-ave"           "tbodyacc-mean-y-ave"           "tbodyacc-mean-z-ave"          
 [4] "tbodyacc-std-x-ave"            "tbodyacc-std-y-ave"            "tbodyacc-std-z-ave"           
 [7] "tgravityacc-mean-x-ave"        "tgravityacc-mean-y-ave"        "tgravityacc-mean-z-ave"       
[10] "tgravityacc-std-x-ave"         "tgravityacc-std-y-ave"         "tgravityacc-std-z-ave"        
[13] "tbodyaccjerk-mean-x-ave"       "tbodyaccjerk-mean-y-ave"       "tbodyaccjerk-mean-z-ave"      
[16] "tbodyaccjerk-std-x-ave"        "tbodyaccjerk-std-y-ave"        "tbodyaccjerk-std-z-ave"       
[19] "tbodygyro-mean-x-ave"          "tbodygyro-mean-y-ave"          "tbodygyro-mean-z-ave"         
[22] "tbodygyro-std-x-ave"           "tbodygyro-std-y-ave"           "tbodygyro-std-z-ave"          
[25] "tbodygyrojerk-mean-x-ave"      "tbodygyrojerk-mean-y-ave"      "tbodygyrojerk-mean-z-ave"     
[28] "tbodygyrojerk-std-x-ave"       "tbodygyrojerk-std-y-ave"       "tbodygyrojerk-std-z-ave"      
[31] "tbodyaccmag-mean-ave"          "tbodyaccmag-std-ave"           "tgravityaccmag-mean-ave"      
[34] "tgravityaccmag-std-ave"        "tbodyaccjerkmag-mean-ave"      "tbodyaccjerkmag-std-ave"      
[37] "tbodygyromag-mean-ave"         "tbodygyromag-std-ave"          "tbodygyrojerkmag-mean-ave"    
[40] "tbodygyrojerkmag-std-ave"      "fbodyacc-mean-x-ave"           "fbodyacc-mean-y-ave"          
[43] "fbodyacc-mean-z-ave"           "fbodyacc-std-x-ave"            "fbodyacc-std-y-ave"           
[46] "fbodyacc-std-z-ave"            "fbodyaccjerk-mean-x-ave"       "fbodyaccjerk-mean-y-ave"      
[49] "fbodyaccjerk-mean-z-ave"       "fbodyaccjerk-std-x-ave"        "fbodyaccjerk-std-y-ave"       
[52] "fbodyaccjerk-std-z-ave"        "fbodygyro-mean-x-ave"          "fbodygyro-mean-y-ave"         
[55] "fbodygyro-mean-z-ave"          "fbodygyro-std-x-ave"           "fbodygyro-std-y-ave"          
[58] "fbodygyro-std-z-ave"           "fbodyaccmag-mean-ave"          "fbodyaccmag-std-ave"          
[61] "fbodybodyaccjerkmag-mean-ave"  "fbodybodyaccjerkmag-std-ave"   "fbodybodygyromag-mean-ave"    
[64] "fbodybodygyromag-std-ave"      "fbodybodygyrojerkmag-mean-ave" "fbodybodygyrojerkmag-std-ave" 
```

All are numeric variables, each the average of all observations of the original UCI HAR variables for the given activity and subject. Since each observation is normalized to a range of [-1,1], so too the 66 signal variables of the Tidy Data Set fall within the range [-1,1].

The naming convention for the averaged variable names is  the original variable name stripped of parenthases, converted to all lower case, and appended with "-ave".
