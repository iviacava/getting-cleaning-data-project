library(plyr)

#set working directory on windows
setwd('c:\\iv\\coursera\\gettcleaning\\UCI HAR Dataset');

# 1 ) 
# Merge all 
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# create x, y, subject  data sets
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# 2 ) 
# Extract the measurements on the mean and standard deviation 

features <- read.table("features.txt")

# 1) get only columns with mean() or std() in their names
# 2) subset the columns 
# 3) correct the column names
mean_and_std_feats <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, mean_and_std_feats]
names(x_data) <- features[mean_and_std_feats, 2]


# Step 3

# 1) Use descriptive activity names to name the activities in the data set
# 2) update values with correct activity names
# 3 )correct column name
activities <- read.table("activity_labels.txt")
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"

# Step 4
# 1) correct column name
# 2) bind all the data in a single data set
names(subject_data) <- "subject"
all_data <- cbind(x_data, y_data, subject_data)

# Step 5
# Create a second, the last file with tidy data set 

averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
# write the output
write.table(averages_data, "avgs_data.txt", row.name=FALSE)