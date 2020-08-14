## This script is to do the assignment of Getting and Cleaning Data on Coursera.

# Step 0: Download Dataset & Set Working Directory into the Datase --------

dataurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(dataurl, "./Dataset.zip", method = "curl")
unzip(zipfile="./Dataset.zip")
file.remove("Dataset.zip")
odir <- getwd()
setwd("./UCI HAR Dataset")

# Step 1: Read, Merge Data, Descriptive Name for Activities ---------------

namesfile <- c("features.txt", "activity_labels.txt")
feature <- read.table(namesfile[1], colClasses = "character")$V2
feature <- gsub("\\()","",feature)
feature <- gsub("-","_", feature)

activity_lbl <- read.table(namesfile[2], col.names = c("activity_label", "act"))

testfiles <- c("./test/X_test.txt", "./test/y_test.txt", "./test/subject_test.txt")
trainfiles <- c("./train/X_train.txt","./train/y_train.txt", "./train/subject_train.txt")

#################### Read test data #############################
x_test <- read.table(testfiles[1], col.names = feature)
# Read actitivity from test folder
y_test <- read.table(testfiles[2], col.names = "activity_label")

# Use mearge function to make activity label descriptive
test_act <- merge(activity_lbl, y_test)
activity <- tolower(test_act[,2])

# Read subjective data 
subjectID <- read.table(testfiles[3], col.names = "subjectID")

# combine x_test, activity, and subjective ID 
test <- cbind(subjectID, activity, x_test)

# Create a new variable called type to specify the test data
test$type <- rep("Test", nrow(test))
rm(x_test, y_test, test_act, activity, subjectID)

#################### Read Train Data #############################
x_train <- read.table(trainfiles[1],col.names = feature)

# Read activity data from train folder
y_train <- read.table(trainfiles[2], col.names = "activity_label")

# Use mearge function to make activity label descriptive
train_act <- merge(activity_lbl , y_train)
activity <- tolower(train_act[,2])

# Read subject ID from train folder
subjectID <- read.table(trainfiles[3], col.names = "subjectID")
train <- cbind(subjectID, activity, x_train)

# Create a new variable called type to specify the train data
train$type <- rep("Train", nrow(train))
rm(x_train, y_train, train_act, activity, subjectID)

#################### Merge Test and Train Data####################

test_train <- rbind(test, train)
rm(test, train, activity_lbl)

# Step 2: Select out the MEAN & STD Measure -------------------------------

# Collect Mean measure and STD measure
varnam <- grep("_mean|_std|subject|activity|type", names(test_train), value = TRUE)
meanfrq_measure <- grep("meanFreq",names(test_train), value = TRUE)
varnam <- setdiff(varnam, meanfrq_measure)
test_train_select <- test_train[,varnam]

setwd(odir)

# write.table(test_train_select, "./FinalAssign/first_tidy_dataset.txt", row.names = FALSE)

# Step 3: Avg of  variable for each activity and each subject -------------
        
library(dplyr)

tidy_test_train <- test_train_select %>% 
        select(-type) %>%
        group_by(subjectID,activity)%>% 
        summarise_all(funs(mean)) %>% 
        ungroup


# Step 4: New Variable Names & Second Tidy Data set -----------------------

ren_var <- setdiff(names(tidy_test_train), c("subjectID","activity"))
newnames <- paste0("avg_",ren_var)
names_all <- c(c("subjectID","activity"),newnames)
names(tidy_test_train) <- names_all

write.table(tidy_test_train, "./FinalAssign/second_tidy_dataset.txt", row.names = FALSE)
