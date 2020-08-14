# 'run_analysis.R': 
the R script to make two tidy datasets from the UCI HAR Dataset; the script is documented and breaks into sections

To run the R script, please download dplyr package (I use R version 4.0.2 and dplyr version 1.0.1)

# files used: 
'features.txt'; 

'activity_labels.txt';

'X_test.txt'; 

'y_test.txt'; 

'subject_test.txt'; 

'X_train.txt'; 

'y_train.txt'; 

'subject_train.txt'

# 'run_analysis.R' will do the following step.

# Step 0: 

download dataset, unzip the file, and change the working directory into the dataset file;

# Step 1.1: 
load 'features.txt' as variable names and load 'activity_lable.txt';
# Step 1.2: 
load and combine 'X_test.txt', 'y_test.txt', and 'subject_test.txt'; merge the activity labels with 'y_test.txt';
# Step 1.3: 
load and combine 'X_train.txt', 'y_train.txt', and 'subject_train.txt'; merge the activity lables with 'y_train.txt';
# Step 1.4: 
merge test data and train data. 

# Step 2: 
select out mean and standard deviation measure, make a subject from the merged data from Step 1.4, write the first tidy dataset

# Step 3: 
Create the average of selected measures across the group of each subject and each activity

# Step 4: 
Rename the varibles from Step 3, and write the second tidy dataset. 

# Code Book: the definition of the variables
# first_tidy_dataset.txt: dataset from Step 2
# second_tidy_dataset.txt: dataset from Step 4