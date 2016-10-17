---
output: html_document
---

## CodeBook by Jianlei(John), Mon Oct 17 2016 CST

This code book describes the variables, the data, and any transformations or work that you performed to clean up the data called. 

### Description of the variables, datasets and transformations

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


### 1. Description of the datasets

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

### 2. Decription of the variables

In this project, the following signals were used to estimate variables of the feature vector for each pattern. The '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from the above signals are: 

- mean(): Mean value
- std(): Standard deviation

In total, there are 82 variables after data transformation. Please see "3. Description of the transformations" for detailed names of these variables.

### 3. Description of the transformations

#### 3.1 Merge the training and the test sets to create one data set

- Donwload the datasets from the "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";

- Load the "subject_train.txt" and "subject_test.txt with data.table(..) function with the name "subjectTrain" and "subjectTest".
    - nrow(subjectTrain) = 7352;
	- ncol(subjectTrain) = 1;
	- ColName = V1
	- nrow(subjectTest) = 2947;
	- ncol(subjectTest) = 1;
	- ColName = V1
- Merge "subjectTrain" and "subjectTest" into "dataSubject":
	- nrow(dataSubject) = 10299;
	- ncol(dataSubject) = 1;
    - ColName = V1
- Change the column name of the table dataframe "dataSubject" from "V1" to "dataSubject".

- Load "Y_train.txt" and "Y_test.txt" with data.table(..) function with the name "yTrain" and "yTest", respectively:
	- nrow(yTrain) = 7352
	- ncol(yTrain) = 1
	- ColName = V1
	- nrow(yTest) = 2947
	- ncol(yTest) = 1
    - ColName = V1
- Merge yTrain and yTest into dataY:
	- nrow(dataY) = 10229
	- ncol(dataY) = 1
	- ColName = V1
- Change the column name of the table dataframe "dataY" from "V1" to "dataY"

- Load "X_train.txt" and "X_test.txt" with data.table(..) function with the name "xTrain" and "xTest", respectively:
	- nrow(xTrain) = 7352
	- ncol(xTrain) = 561
	- ColName = From "V1" to "V561"
	- nrow(xTest) = 2947
	- ncol(xTest) = 561
	- ColName = From "V1" to "V561"
- Merge "xTrain" and "xTest" into "dataX":
	- nrow(dataX) = 10229
	- ncol(dataX) = 561
    - ColName = From "V1" to "V561" 
- Change the column name of the table dataframe "dataX" from "V1" to "dataX"

- Merge all three tables (e.g., dataSubject, dataY and dataX) and name it as "data":
	- nrow(data) = 10299
	- ncol(data) = 563 
	- ColName = "dataSubject" + "dataY" + "dataX" + From "V2" to "V561"

#### 3.2 Extract only the measurements on the mean and standard deviation for each measurement

- Load the colnames from "features.txt" with the name "dataFeature";
- Select all colnames from "dataFeature" with the strings "mean" or "std" on it. Prepare a vector "locMeanStd" with the position of the colnames selected.
- Subset "data" using the vector "locMeanStd", including also the first two column of "data". Naming this subset as "dataMeanStd"
- 	- nrow(dataMeanStd) = 10299
	- ncol(dataMeanStd) = 81
	- names(dataMeanStd) = 
 [1] "dataSubject" "dataY" "dataX"    "V2"       "V3"       "V4"       "V5"       "V6"      
 [9] "V41"      "V42"      "V43"      "V44"      "V45"      "V46"      "V81"      "V82"     
[17] "V83"      "V84"      "V85"      "V86"      "V121"     "V122"     "V123"     "V124"    
[25] "V125"     "V126"     "V161"     "V162"     "V163"     "V164"     "V165"     "V166"    
[33] "V201"     "V202"     "V214"     "V215"     "V227"     "V228"     "V240"     "V241"    
[41] "V253"     "V254"     "V266"     "V267"     "V268"     "V269"     "V270"     "V271"    
[49] "V294"     "V295"     "V296"     "V345"     "V346"     "V347"     "V348"     "V349"    
[57] "V350"     "V373"     "V374"     "V375"     "V424"     "V425"     "V426"     "V427"    
[65] "V428"     "V429"     "V452"     "V453"     "V454"     "V503"     "V504"     "V513"    
[73] "V516"     "V517"     "V526"     "V529"     "V530"     "V539"     "V542"     "V543"    
[81] "V552" 

#### 3.3 Use descriptive activity names to name the activities in the data set

- Load labels from "activity_labels.txt" with the name "activityNames".
	- nrow(activityNames) = 6
	- ncol(activityNames) = 2
	- names(activityNames) = "V1" "V2"
- Changing "activityNames" col names from "V1" and "V2" to "dataY" and "activityName";
- Set "dataY" as the key of the table "dataMeanStd";
- Set "dataY" as the key of the table "activityNames";
- Merge "dataMeanStd" and "activityNames" by the key "dataY", and thus add a new collumn with the name "activityName" into "dataMeanStd".
	- nrow(dataMeanStd) = 10229
	- ncol(dataMeanStd) = 82

#### 3.4 Appropriately label the data set with descriptive variable names

- Change "dataMeanStd" collumn names to the following:

 [1] "Activity_ID"                   "Subject"                      
 [3] "tBody_Acc_mean_X"              "tBody_Acc_mean_Y"             
 [5] "tBody_Acc_mean_Z"              "tBody_Acc_std_X"              
 [7] "tBody_Acc_std_Y"               "tBody_Acc_std_Z"              
 [9] "tGravity_Acc_mean_X"           "tGravity_Acc_mean_Y"          
[11] "tGravity_Acc_mean_Z"           "tGravity_Acc_std_X"           
[13] "tGravity_Acc_std_Y"            "tGravity_Acc_std_Z"           
[15] "tBody_Acc_Jerk_mean_X"         "tBody_Acc_Jerk_mean_Y"        
[17] "tBody_Acc_Jerk_mean_Z"         "tBody_Acc_Jerk_std_X"         
[19] "tBody_Acc_Jerk_std_Y"          "tBody_Acc_Jerk_std_Z"         
[21] "tBody_Gyro_mean_X"             "tBody_Gyro_mean_Y"            
[23] "tBody_Gyro_mean_Z"             "tBody_Gyro_std_X"             
[25] "tBody_Gyro_std_Y"              "tBody_Gyro_std_Z"             
[27] "tBody_Gyro_Jerk_mean_X"        "tBody_Gyro_Jerk_mean_Y"       
[29] "tBody_Gyro_Jerk_mean_Z"        "tBody_Gyro_Jerk_std_X"        
[31] "tBody_Gyro_Jerk_std_Y"         "tBody_Gyro_Jerk_std_Z"        
[33] "tBody_Acc_Mag_mean"            "tBody_Acc_Mag_std"            
[35] "tGravity_Acc_Mag_mean"         "tGravity_Acc_Mag_std"         
[37] "tBody_Acc_Jerk_Mag_mean"       "tBody_Acc_Jerk_Mag_std"       
[39] "tBody_Gyro_Mag_mean"           "tBody_Gyro_Mag_std"           
[41] "tBody_Gyro_Jerk_Mag_mean"      "tBody_Gyro_Jerk_Mag_std"      
[43] "fBody_Acc_mean_X"              "fBody_Acc_mean_Y"             
[45] "fBody_Acc_mean_Z"              "fBody_Acc_std_X"              
[47] "fBody_Acc_std_Y"               "fBody_Acc_std_Z"              
[49] "fBody_Acc_mean_Freq_X"         "fBody_Acc_mean_Freq_Y"        
[51] "fBody_Acc_mean_Freq_Z"         "fBody_Acc_Jerk_mean_X"        
[53] "fBody_Acc_Jerk_mean_Y"         "fBody_Acc_Jerk_mean_Z"        
[55] "fBody_Acc_Jerk_std_X"          "fBody_Acc_Jerk_std_Y"         
[57] "fBody_Acc_Jerk_std_Z"          "fBody_Acc_Jerk_mean_Freq_X"   
[59] "fBody_Acc_Jerk_mean_Freq_Y"    "fBody_Acc_Jerk_mean_Freq_Z"   
[61] "fBody_Gyro_mean_X"             "fBody_Gyro_mean_Y"            
[63] "fBody_Gyro_mean_Z"             "fBody_Gyro_std_X"             
[65] "fBody_Gyro_std_Y"              "fBody_Gyro_std_Z"             
[67] "fBody_Gyro_mean_Freq_X"        "fBody_Gyro_mean_Freq_Y"       
[69] "fBody_Gyro_mean_Freq_Z"        "fBody_Acc_Mag_mean"           
[71] "fBody_Acc_Mag_std"             "fBody_Acc_Mag_mean_Freq"      
[73] "fBody_Acc_Jerk_Mag_mean"       "fBody_Acc_Jerk_Mag_std"       
[75] "fBody_Acc_Jerk_Mag_mean_Freq"  "fBody_Gyro_Mag_mean"          
[77] "fBody_Gyro_Mag_std"            "fBody_Gyro_Mag_mean_Freq"     
[79] "fBody_Gyro_Jerk_Mag_mean"      "fBody_Gyro_Jerk_Mag_std"      
[81] "fBody_Gyro_Jerk_Mag_mean_Freq" "Activity_Name" 

#### 3.5 From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject. 

- Set columns from 3 to penultimate as measure variables;
- Set columns "Subject","Activity_ID", and "Activity_Name" as ids;
- Melt "dataMeanStd" with the ids and measure variables, and create the "dataMelt" variable;
- Apply the "dcast"" funciton to the "dataMelt" by using the formula "Subject + Activity_Name ~ variable" and the agglomerate function "mean".
	- nrow(dataTidy) = 180
	- ncol(dataTidy) = 81
