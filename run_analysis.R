library(dplyr)

# Set the URL and download the dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "dataset.zip")

# Unzip the dataset
unzip("dataset.zip")

# Read the training and test data
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Read the features and activity labels
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# Merge the datasets
data <- rbind(train_data, test_data)
labels <- rbind(train_labels, test_labels)
subjects <- rbind(train_subjects, test_subjects)

# Assign column names
colnames(data) <- features$V2
colnames(labels) <- "activity"
colnames(subjects) <- "subject"

# Combine data, labels, and subjects into one dataset
combined_data <- cbind(subjects, labels, data)

# Extract columns with mean and standard deviation
selected_columns <- grepl("mean\\(\\)|std\\(\\)", features$V2)
selected_data <- combined_data[, c(TRUE, TRUE, selected_columns)]

# Apply descriptive activity names
selected_data$activity <- factor(selected_data$activity, levels = activity_labels$V1, labels = activity_labels$V2)

# Update the column names to be more descriptive
colnames(selected_data) <- gsub("^t", "time", colnames(selected_data))
colnames(selected_data) <- gsub("^f", "frequency", colnames(selected_data))
colnames(selected_data) <- gsub("Acc", "Accelerometer", colnames(selected_data))
colnames(selected_data) <- gsub("Gyro", "Gyroscope", colnames(selected_data))
colnames(selected_data) <- gsub("Mag", "Magnitude", colnames(selected_data))
colnames(selected_data) <- gsub("BodyBody", "Body", colnames(selected_data))

# Create tidy data set with the average of each variable for each activity and each subject
tidy_data <- selected_data %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean = mean))

# Write the tidy data to a file
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)

