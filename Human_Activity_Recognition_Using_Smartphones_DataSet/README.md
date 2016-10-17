## Project of Getting and Cleaning Data 

### by Jianlei(John) Sun, Mon Oct 17 2016 CST

> 
- You should create one R script called run_analysis.R that does the following;
- Merges the training and the test sets to create one data set;
- Extracts only the measurements on the mean and standard deviation for each measurement;
- Uses descriptive activity names to name the activities in the data set;
- Appropriately labels the data set with descriptive variable names;
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Run the script "run_analysis.R""

The R script will first load the following two libraries - "data.table" and "reshape2".

Then, the following steps will be performed by the R script.

> 1) Merge the training and the test datasets to create one dataset:
- Download and unzip the data from the given website link into the work directory;
- Merge by rows the tables in the files "subject_train.txt" and "subject_test.txt" into one table;
- Merge by rows the tables in the files "Y_train.txt" and "Y_test.txt" into one table;
- Merge by rows the tables in the files "X_train.txt" and "X_test.txt" into one table;
- Merge by columns the above three tables into one table named "data".

> 2) Extract only the measurements on the mean and standard deviation for each measurement:
- Load the file "features.txt";
- Compute a position vector "locMeanStd" corresponding to the column names that include "mean" or "std";
- Subset the "data" table into "dataMeanStd"

> 3) Uses descriptive activity names to name the activities in the data set:
- Load the file "activity_labels.txt";
- Merge it with the table "dataMeanStd".

> 4) Appropriately labels the data set with descriptive variable names:
- Change all "-" into "_";
- Remove "()";
- Remove redudante names, i.e., "BodyBody" to "Body";
- Change "Acc" to "Acc_";
- Change "Body" to "Body_";
- Change "Gyro" to "Gyro_";
- Change "Jerk" to "Jerk_";
- Change "meanFreq" to "mean_Freq";
- Change the names of the first two columns to "Activity_ID" and "Subject".

> 5) Create a second, independent tidy data set with the average of each variable for each activity and each subject:
- All but the first two columns from "dataMeanStd" will be defined as the measure Variables;
- Melt "dataMeanStd" using the measure variables defined and as id the columns "Subject", "Activity_ID" and "Activity_Name"; create a new variable "dataMelt";
- Apply the "dcast" to the "dataMelt" using the formula, "Subject + Activity_Name ~ variable", and the aggregate function "mean";
- Finally, the R script will save the processed tidy data into a file named "dataTidy.txt".


