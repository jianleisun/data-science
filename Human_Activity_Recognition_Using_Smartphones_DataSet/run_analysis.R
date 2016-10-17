# ----------  Getting and Cleaning Data Course Project ----------  

# by Jianlei(John) Sun, Oct 18, 2016


# --- Functions --- 

# 1. Merge data files together
funMergeData <- function(folderDir) {
    
    dirTrain  <- paste0(folderDir,"/train")              
    dirTest   <- paste0(folderDir,"/test")          
    
    # read subject data
    dataTrain <- paste0(dirTrain,"/subject_train.txt")
    dataTest  <- paste0(dirTest,"/subject_test.txt")   
    
    subjectTrain <- data.table(read.table(dataTrain))    
    subjectTest <- data.table(read.table(dataTest))    

    dataSubject <- rbind(subjectTrain, subjectTest)          
    setnames(dataSubject, "V1", "dataSubject")          
        
    # read Y data 
             
    dataTrain <- paste0(dirTrain,"/Y_train.txt")       
    dataTest  <- paste0(dirTest,"/Y_test.txt")
    
    yTrain  <- data.table(read.table(dataTrain))
    yTest   <- data.table(read.table(dataTest))
    
    dataY <- rbind(yTrain, yTest)
    setnames(dataY, "V1", "dataY")
        
    # read X data
    
    dataTrain <- paste0(dirTrain,"/X_train.txt")
    dataTest  <- paste0(dirTest,"/X_test.txt")
    
    xTrain  <- data.table(read.table(dataTrain))
    xTest   <- data.table(read.table(dataTest))

    dataX <- rbind(xTrain, xTest)
    setnames(dataX, "V1", "dataX")
        
    data <- cbind(dataSubject, dataY, dataX)      
}

# 2. Name the descriptive activities 
funNameActivities <- function (folderDir, dataMeanStd){
    
    activityNames<- fread(paste0(folderDir,"/activity_labels.txt") )                       
    names(activityNames) <- c("dataY", "activityName")    
    
    setkey(dataMeanStd, dataY)                                 
    setkey(activityNames, dataY)  
    
    dataMeanStd <- merge(dataMeanStd, activityNames)               
}

# 3. Cleaning labels
funLabelNames <- function (dataFeature, locMeanStd, dataMeanStd){

        tempNames <- dataFeature$V2[locMeanStd]                  
        tempNames <- gsub("-","_",tempNames)                 
        tempNames <- gsub("\\(\\)","",tempNames)              
        tempNames <- gsub("BodyBody","Body",tempNames)        
        tempNames <- gsub("Acc","_Acc_",tempNames) 
        tempNames <- gsub("Body","Body_",tempNames)
        tempNames <- gsub("Gyro","Gyro_",tempNames)
        tempNames <- gsub("Jerk","Jerk_",tempNames)
        tempNames <- gsub("meanFreq","mean_Freq",tempNames)
        tempNames <- gsub("__","_",tempNames)
        tempNames <- append(c("Activity_ID","Subject"),tempNames) 
        tempNames <- append(tempNames,"Activity_Name")
        
        names(dataMeanStd) <- tempNames                            
        dataMeanStd
}

# 4. Function to create tidy data
funOutputTidyData <- function(dataMeanStd)
{
    measureVars <- names(dataMeanStd)[3:(length(dataMeanStd)-1)] 
    
    dataMelt    <- melt(dataMeanStd, id = c("Subject","Activity_ID","Activity_Name"), 
                        measure.vars = measureVars)

    dataTidy   <- dcast(dataMelt, Subject + Activity_Name ~ variable, mean)
}

# --- Functions --- 


main <- function()
{  
    library("data.table")
    library("reshape2")
    
    URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    destfile <- "dataset.zip"
        
    if (!file.exists(destfile)) {
        download.file(URL, destfile,"curl")      
        file <- unzip(destfile)                      
        folderDir <- unlist(strsplit(file[1],"/"))[2]    
    }
    else folderDir <- "UCI HAR Dataset"       
    
    # 1. Merges the training and the test sets to create one data set
    
    data <- funMergeData(folderDir)             
        
    # 2. Extracts only the measurements on the mean and standard deviation for each measurement
    
    dataFeature  <- fread(paste0(folderDir,"/features.txt"))          
    locMeanStd   <- grep("mean|std",dataFeature$V2)                
    dataColumn <- c(c(1,2), locMeanStd+2)
    dataMeanStd   <- subset(data, select = dataColumn, with = FALSE)  
        
    # 3. Uses descriptive activity names to name the activities in the data set
    
    dataMeanStd <- funNameActivities(folderDir,dataMeanStd)
       
    # 4. Appropriately labels the data set with descriptive variable names
    
    dataMeanStd <- funLabelNames (dataFeature, locMeanStd, dataMeanStd)

    # 5. From the data set in step 4, creates a second, independent tidy data set with the average 
    #       of each variable for each activity and each subject. 
        
    dataTidy <- funOutputTidyData(dataMeanStd)
    write.table(dataTidy, paste0(folderDir,"/dataTidy.txt"),row.name=FALSE)
    
}
