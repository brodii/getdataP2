getAllData <- function(){
     testData <- getTestData() #get the test data
     trainData <- getTrainData() #get the train data
     allData <- rbind(testData, trainData) #merge the data together
     
     #call function to find means and write new dataset to .txt
     newDataSet(allData)
}


getTestData <- function(){
     ##this function will gather all the data for test subjects and clean
     ##get the person identifier
     subject <-
          read.fwf(file="getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", 
                   widths=2)
     ##get the activity identifier, need to convert to text later.  this is from the y_test file
     activity <- 
          read.fwf(file="getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", 
                   widths=1)
     actLabels <- read.table(file="getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", 
                             header=F, sep=" ")
     ##add the label variable to the activity DF
     activity$label <- actLabels$V2[match(activity$V1, actLabels$V1)]
     
     ##combine the person with their acitity identifiers
     completeData <- cbind(subject, activity$label)
     
     ##REading in all the data for the observations takes a long time
     
     resultsLabels <- read.table(file="getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", 
                                 header=F, sep="")
     featuresWidths <- rep(16, times=561)
     
     results <- read.table(file="getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", 
                           header=FALSE, col.names=as.vector(resultsLabels[,2]))
     
     subResults <- results[,c(grep("mean",names(results),ignore.case=TRUE),
                              grep("std",names(results),ignore.case=TRUE))]
     
     completeData <- cbind(completeData, subResults)
     colnames(completeData)[1:2] <- c("Subject", "Activity")
     completeData
     
}

getTrainData <- function(){
     ##this function will gather all the data for test subjects and clean
     ##program could be simplified by reducing redundancy and passing the 
     ##directory to the sub-function
     
     ##get the person identifier
     subject <-
          read.fwf(file="getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", 
                   widths=2)
     ##get the activity identifier, need to convert to text later.  this is from the y_test file
     activity <- 
          read.fwf(file="getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", 
                   widths=1)
     actLabels <- read.table(file="getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", 
                             header=F, sep=" ")
     ##add the label variable to the activity DF
     activity$label <- actLabels$V2[match(activity$V1, actLabels$V1)]
     
     ##combine the person with their acitity identifiers
     completeData <- cbind(subject, activity$label)
     
     ##REading in all the data for the observations takes a long time
     
     resultsLabels <- read.table(file="getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", 
                                 header=F, sep="")
     featuresWidths <- rep(16, times=561)
     
     results <- read.table(file="getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", 
                           header=FALSE, col.names=as.vector(resultsLabels[,2]))
     
     subResults <- results[,c(grep("mean",names(results),ignore.case=TRUE),
                              grep("std",names(results),ignore.case=TRUE))]
     
     completeData <- cbind(completeData, subResults)
     colnames(completeData)[1:2] <- c("Subject", "Activity")
     completeData
     
}

newDataSet <- function(mergedResults){
     ## this function takes the complete results of Test and Train data
     ##and calculates the mean for each variable (86) for the combination
     ##of Subject and Activity
     ##It writes the results to the file "meanResults.txt"
     library(reshape2)
     
     
     mergedMelt <- melt(mergedResults, id=c("Subject","Activity"))
     meanResults <- dcast(mergedMelt, Subject + Activity ~ variable, mean)
     write.table(meanResults, file="meanResults.txt", row.names=F)
     
}