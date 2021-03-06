# Create one R script called run_analysis.R that does the following.
#
# (0) Downloads and unzips dataset from UCI Machine Learning Repository
# (1) Merges the training and the test sets to create one data set.
# (2) Extracts only the measurements on the mean and standard deviation 
#     for each measurement.
# (3) Uses descriptive activity names to name the activities in the data set
# (4) Appropriately labels the data set with descriptive variable names.
# (5) From the data set in step 4, creates a second, independent tidy data set 
#     with the average of each variable for each activity and each subject.
#
#     data.table used to aggregate data
#     reshape2 used to aggregate data using functions melt and dcast


if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")


# Download and unzip dataset
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
		   dest="dataset.zip", mode="wb")
unzip(zipfile="dataset.zip")


# Load activity labels and data column names
# Extract only the measurements on the mean and standard deviation
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
extract_features <- grepl("mean|std", features)

# Load test data and assign col names
# Extract only the measurements on the mean and standard deviation
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(X_test) = features

X_test = X_test[,extract_features]

# Load and assign activity labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

# Bind data by columns
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# Load train data and assign column names
# Extract only the measurements on the mean and standard deviation
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(X_train) = features

X_train = X_train[,extract_features]

# Load activity data and assign column names
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# Bind data by columns and rows 
train_data <- cbind(as.data.table(subject_train), y_train, X_train)
data = rbind(test_data, train_data)

#Merge test and train data using rshape package
id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast function and write to file
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)
write.table(tidy_data, file = "./tidy_data.txt")