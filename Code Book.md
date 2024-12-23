# Code Book

This code book describes the variables, the data, and the transformations performed.

## Data

The dataset contains measurements from the accelerometers from the Samsung Galaxy S smartphone.

## Variables

- `subject`: Subject identifier
- `activity`: Activity label
- `timeBodyAccelerometer-mean()-X`: Mean of time domain body accelerometer X-axis
- `timeBodyAccelerometer-mean()-Y`: Mean of time domain body accelerometer Y-axis
- `timeBodyAccelerometer-mean()-Z`: Mean of time domain body accelerometer Z-axis
- ... (and so on for each measurement)

## Transformations

1. Merged the training and test sets.
2. Extracted only the measurements on the mean and standard deviation.
3. Used descriptive activity names to name the activities.
4. Labeled the data set with descriptive variable names.
5. Created a tidy data set with the average of each variable for each activity and each subject.
