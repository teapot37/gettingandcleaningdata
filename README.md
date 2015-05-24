# How to use run_analysis.R
This script assumes that the Samsung data directory is in your working directory.
The following files should exist inside that directory:
* getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt
* getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt
* getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt
* getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt
* getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt
* getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt
* getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt
* getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt

The script will return a data frame containing the means of each of the variables in the data set pertaining to mean or standard deviation, per activity, per subject.
