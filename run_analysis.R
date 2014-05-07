run_analysis <- function( ) {
  # assumes that the data is unziped into the working directory and the file structure is unaltered

  # To get the data if not already downloaded:
  # fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  # download.file(fileURL, destfile = "./HARUS.zip", method = "curl")
  # unzip(zipfile = "./HARUS.zip", exdir = "./")
  
  library(reshape2)
  
  # 1. Load the variable names, subject keys, and activity names, into R:
  testFile <- "./UCI HAR Dataset/test/X_test.txt"
  trainFile <-"./UCI HAR Dataset/train/X_train.txt"
  colFile <- "./UCI HAR Dataset/features.txt"
  testRowFile <- "./UCI HAR Dataset/test/y_test.txt"
  trainRowFile <- "./UCI HAR Dataset/train/y_train.txt"
  activityFile <- "./UCI HAR Dataset/activity_labels.txt"
  testSubFile <- "./UCI HAR Dataset/test/subject_test.txt"
  trainSubFile <- "./UCI HAR Dataset/train/subject_train.txt"
  
  colNames <- read.table(colFile, colClasses = "character")
  testRowKeys <- read.table(testRowFile)
  trainRowKeys <- read.table(trainRowFile)
  activities <- read.table(activityFile)
  testSub <- read.table(testSubFile)
  trainSub <- read.table(trainSubFile)
  
  # 2. Identify the variable columns to keep and load only those data:
  myCols <- grep("[A-Z0-9-]+mean[^F]|[A-Z0-9-]+std", colNames[,2])
  myColNames <- grep("[A-Z0-9-]+mean[^F]|[A-Z0-9-]+std", colNames[,2], value = TRUE)
  nCols <- ( 1:nrow(colNames ))[ -myCols ]
  colClass <- character(nrow(colNames))
  colClass[nCols] <- "NULL"
  colClass[myCols] <- "numeric"
  trainData <- read.table(trainFile, colClasses = colClass)
  testData <- read.table(testFile,, colClasses = colClass)
  
  # 3. Tidy up the column names:
  myColNames <- sub("\\(","", myColNames)  # remove left bracktes
  myColNames <- sub("\\)","", myColNames)  # remove right brackets
  # myColNames <- sub("-","",myColNames)     # leaving dashes in for legibility
  myColNames <- tolower(myColNames)        # make all lower case
  
  # 4. Combine test and train data adding column names and activity descriptions to the rows.
  testDataKeyed <- cbind(testRowKeys, testData)
  testDataKeyed <- cbind(testSub, testDataKeyed)
  trainDataKeyed <- cbind(trainRowKeys, trainData)
  trainDataKeyed <- cbind(trainSub, trainDataKeyed)
  colNamesKeyed <- c("subject", "akey", myColNames)
  combined <- rbind(testDataKeyed, trainDataKeyed)
  names(combined) <- colNamesKeyed
  acombined<- merge(combined, activities, by.x = "akey", by.y = "V1")
  names(acombined)[length(names(acombined))] <- "activity"
  acombined <- acombined[, 2:69]   # removes the activity key column 'akey' now redundant with activities column
  
  # 5. Melt the data frame for easy averaging of variables, cast the data, and return the desired data.frame.
  phoneMelt <- melt(acombined, id = c("activity", "subject"))
  saData <- dcast(phoneMelt, activity + subject ~ variable, mean)
  
  for (i in 3:68) {
    names(saData)[i] <- paste(names(saData)[i], "-ave", sep="")
  }
  
  return(saData)
}