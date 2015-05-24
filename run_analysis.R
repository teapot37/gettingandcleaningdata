run_analysis <- function(){
  
  ## read in the datasets
  if(file.exists("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//test//X_test.txt")){
    Xtest <- read.table("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//test//X_test.txt")
  } else return("Error: could not read X_test")
  if(file.exists("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//test//Y_test.txt")){
    Ytest <- read.table("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//test//Y_test.txt")
  } else return("Error: could not read Y_test")
  if(file.exists("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//test//subject_test.txt")){
    subjtest <- read.table("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//test//subject_test.txt")
  } else return("Error: could not read subject_test")
  if(file.exists("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//train//X_train.txt")){
    Xtrain <- read.table("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//train//X_train.txt")
  } else return("Error: could not read X_train")
  if(file.exists("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//train//Y_train.txt")){
    Ytrain <- read.table("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//train//Y_train.txt")
  } else return("Error: could not read Y_train")
  if(file.exists("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//train//subject_train.txt")){
    subjtrain <- read.table("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//train//subject_train.txt")
  } else return("Error: could not read subject_train")

  ## combine the test and train datasets together
  combinedX <- rbind(Xtest, Xtrain)
  combinedY <- rbind(Ytest, Ytrain)
  combinedsubj <- rbind(subjtest, subjtrain)

  ## read in the column names for the X data set and use them to name the X columns
  if(file.exists("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//features.txt")){
    features <- read.table("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//features.txt")
  } else return("Error: could not read features")

  colnames(combinedX) <- features[,2]

  ## strip out any X columns that aren't related to the mean or standard deviation
  meanstdnames <- grep("mean\\(\\)|std\\(\\)", colnames(combinedX))
  stripcombX <- combinedX[meanstdnames]

  ## read in the descriptive labels for the Y data and replace the numbers with them
  if(file.exists("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//activity_labels.txt")){
    actlabels <- read.table("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//activity_labels.txt")
  } else return("Error: could not read activity_labels")
      
  colnames(combinedY) <- "activity"
  colnames(combinedsubj) <- "subject"

  for(i in length(combinedY)){
    combinedY$activity <- actlabels[combinedY$activity,2]
  }

  ## make the column names more descriptive
  colnames(stripcombX) <- gsub("^t", "Time", colnames(stripcombX))
  colnames(stripcombX) <- gsub("^f", "Frequency", colnames(stripcombX))
  colnames(stripcombX) <- gsub("Acc", "Acceleration", colnames(stripcombX))
  colnames(stripcombX) <- gsub("Gyro", "Gyroscope", colnames(stripcombX))
  colnames(stripcombX) <- gsub("Mag", "Magnitude", colnames(stripcombX))
  colnames(stripcombX) <- gsub("-", "_", colnames(stripcombX))
  colnames(stripcombX) <- gsub("\\(", "", colnames(stripcombX))
  colnames(stripcombX) <- gsub("\\)", "", colnames(stripcombX))
  
  ## merge the X, Y, and subject data sets together
  mergeddata <- cbind(stripcombX, combinedY)
  mergeddata <- cbind(mergeddata, combinedsubj)
  
  ## group the data by subject and activity, and then get the mean of each column per group
  mergeddata <- group_by(mergeddata, subject, activity) %>% summarise_each(funs(mean))
  mergeddata
}