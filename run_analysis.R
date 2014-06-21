## Prepare file names
data.dir <- "UCI HAR Dataset"   # Data folder
filename.features <- paste(data.dir, "features.txt", sep = "/")
filename.activity.labels <- paste(data.dir, "activity_labels.txt", sep = "/")
filename.train.data <- paste(data.dir, "train", "X_train.txt", sep = "/")
filename.train.labels <- paste(data.dir, "train", "y_train.txt", sep = "/")
filename.train.subject <- paste(data.dir, "train", "subject_train.txt", sep ="/")
filename.test.data <- paste(data.dir, "test", "X_test.txt", sep = "/")
filename.test.labels <- paste(data.dir, "test", "y_test.txt", sep = "/")
filename.test.subject <- paste(data.dir, "test", "subject_test.txt", sep ="/")

## 1 Merges the training and the test sets to create one data set.
data <- rbind(cbind(read.table(filename.train.data),
                    read.table(filename.train.subject),
                    read.table(filename.train.labels)),
              cbind(read.table(filename.test.data),
                    read.table(filename.test.subject),
                    read.table(filename.test.labels)))

## 4 Appropriately labels the data set with descriptive variable names. 
colnames(data) <- c(read.table(filename.features, stringsAsFactors=FALSE)$V2,
                    "subject", "activity")

## 3 Uses descriptive activity names to name the activities in the data set
data$activity <- read.table(filename.activity.labels)$V2[data$activity]

## 2 Extracts only the measurements on the mean and standard deviation 
## for each measurement. 
data.extracted <- data[, c(grep("(mean|std)\\(",colnames(data)), 
                           grep("subject|activity", colnames(data)))]

## 5 Creates a second, independent tidy data set with the average of 
## each variable for each activity and each subject. 
data.tidy <- aggregate(. ~ subject + activity, data = data.extracted, mean)

## Save the tidy data
write.csv(data.tidy, file = "tidy.csv.txt")
