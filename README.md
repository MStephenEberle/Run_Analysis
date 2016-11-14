# README
###  Repository contents:
0. CodeBook.md
1. README.md
2. run_analysis.R
3. tidy_data.txt

### CodeBook.md
Updates original dataset codebook.<br>
Includes relevant updates and information for tidy_data.txt

### run_analysis.R
R script run_analysis.R does the following.

0. Downloads and unzips dataset from UCI Machine Learning Repository
1. Merges the training and the test sets to create one data set 
2. Extracts only the measurements on the mean and standard deviation for each measurement
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

### Dependencies
R script run_analysis.R will automatically install dependencies if necessary.

Package "data.table" is used to aggregate data

Package "reshape2" is used to aggregate data using functions melt and dcast

### tidy_data.txt
Dataset generated by running R script run_analysis.R .
File tidy_data.txt contains a tidy data set with the average of each variable for each activity and each subject, using mean and standard deviation measurements from the UCI HAR Dataset (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

