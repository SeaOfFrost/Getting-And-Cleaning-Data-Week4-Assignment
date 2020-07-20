if(!require(dplyr)){install.packages('dplyr')}
library(dplyr)

##### 1. Merge the training and test sets #####

# Read Train Data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Read Test Data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Read Variable Labels
features <- read.table("./UCI HAR Dataset/features.txt")

# Read Activity Labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Merge the data
dataset <- rbind(
        cbind(sub_train, x_train, y_train), 
        cbind(sub_test, x_test, y_test)
)
# Rename the columns
colnames(dataset) <- c("subject", features[,2], "activity")

# Remove old variables
rm(x_train, y_train, sub_train, x_test, y_test, sub_test)

##### 2. Extract only the measurements on the mean and standard deviation #####

requiredCols <- grep("subject|activity|mean|std", colnames(dataset))
dataset <- dataset[, requiredCols]

##### 3. Give descriptive names for the activities #####
dataset$activity <- factor(dataset$activity, labels = activity_labels[,2])

##### 4. Label the dataset with descriptive column names #####
cols <- colnames(dataset)
# Remove Special Characters
cols <- gsub("-|\\(|\\)", "", cols)
# Expand contractions
cols <- gsub("^t", "time", cols)
cols <- gsub("^f", "frequency", cols)
cols <- gsub("Acc", "Accelerometer", cols)
cols <- gsub("Gyro", "Gyroscope", cols)
cols <- gsub("mean", "Mean", cols)
cols <- gsub("std", "StandardDeviation", cols)
cols <- gsub("Mag", "Magnitude", cols)
cols <- gsub("Freq", "Frequency", cols)
cols <- gsub("BodyBody", "Body", cols)
# Rename columns
colnames(dataset) <- cols

##### 5. Create dataset with the average of each variable for each activity and each subject#####
ActivityMeans <- dataset %>% group_by(activity, subject) %>% summarise_all(list(mean))
write.table(ActivityMeans, "./tidy data.txt", row.name = FALSE)
