#Read in the features and activity labels
features <- read.table("UCI\ HAR\ Dataset/features.txt")
activities <- read.table("UCI\ HAR\ Dataset/activity_labels.txt")

#Read in the training data set
train <- read.table("UCI\ HAR\ Dataset/train/X_train.txt")
train_labels <- read.table("UCI\ HAR\ Dataset/train/y_train.txt")
train_subject <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt")
#Set the column names to the descriptive labels
names(train) <- features$V2
#Use descriptive labels for the activities
translated_train_labels <- merge(activities, train_labels, by.x="V1", by.y="V1")

#Read in the testing data set
test <- read.table("UCI\ HAR\ Dataset/test/X_test.txt")
test_labels <- read.table("UCI\ HAR\ Dataset/test/y_test.txt")
test_subject <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt")
#Set the column names to the descriptive labels
names(test) <- features$V2
#Use descriptive labels for the activities
translated_test_labels <- merge(activities, test_labels, by.x="V1", by.y="V1")

#Merge the training and testing data sets into one
merged <- rbind(train, test)

#Make a new data set that includes only the mean and std features
meanFeatures <- sapply(features$V2, function(str, pattern) {grepl(pattern, str, fixed=TRUE)}, "mean()")
stdFeatures <- sapply(features$V2, function(str, pattern) {grepl(pattern, str, fixed=TRUE)}, "std()")
tidy <- merged[, which(stdFeatures | meanFeatures)]
#Include a column with the descriptive activities
allLabels <- rbind(translated_train_labels, translated_test_labels)
tidy$label <- allLabels$V2
#Include a column with the subjects
allSubjects <- rbind(train_subject, test_subject)
tidy$subject <- allSubjects$V1

library(reshape2)
library(plyr)
#Transform the data set into a long data set
tidyMelt <- melt(tidy, id=c("subject", "label"), measure.vars=names(merged)[which(meanFeatures | stdFeatures)])
#Reshape it to summarize multiple observations from the same subject and activity into one average
tidySummary <- ddply(tidyMelt, .(subject, label, variable), summarize, mean=mean(value))
#Write the output to a file
write.table(tidySummary, file="summary.txt", row.name=FALSE)