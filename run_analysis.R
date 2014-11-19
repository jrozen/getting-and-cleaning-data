## file for analysis of samsung data
processData <- function() {
  ## Read all column descriptions
  columns <- read.csv("UCI HAR DataSet/features.txt", header=FALSE, sep="")
  
  ## Extract columns that contains mean or std
  columnNames <- columns[grepl("mean|std", columns[[2]], ignore.case=FALSE),]
  
  ## Read test data
  testData<-read.table("UCI HAR DataSet/test/X_test.txt", header=FALSE, sep="")
  
  ## select test data and set column names
  sTestData <- testData[,grepl("mean|std", columns[[2]], ignore.case=FALSE)]
  colnames(sTestData)<-columnNames[[2]]
  
  ## Read test activity data and add to test data with column name "Activity"
  activityTestData <- read.table("UCI HAR DataSet/test/y_test.txt", header=FALSE, sep="")
  sTestData["Activity"] <- activityTestData
  
  ## Read train data
  trainData<-read.table("UCI HAR DataSet/train/X_train.txt", header=FALSE, sep="")
  
  ## filter train data and set column names
  sTrainData <- trainData[,grepl("mean|std", columns[[2]], ignore.case=FALSE)]
  colnames(sTrainData)<-columnNames[[2]]
  
  ## Read test activity data and add to test data with column name "Activity"
  activityTrainData <- read.table("UCI HAR DataSet/train/y_train.txt", header=FALSE, sep="")
  sTrainData["Activity"] <- activityTrainData
  
  ## combine the two data sets
  data <- rbind(sTrainData, sTestData)
  
  write.table(data, file="tidy-data-set.txt", row.names=FALSE)
}
