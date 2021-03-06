unzip("getdata-projectfiles-UCI HAR Dataset.zip")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
dataset <- rbind(X_test,X_train)
traininglab <- read.table("./UCI HAR Dataset/train/y_train.txt")
testlab <- read.table("./UCI HAR Dataset/test/y_test.txt")
lab <- rbind(testlab,traininglab)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject <- rbind(subject_test,subject_train)
variables <- read.table("./UCI HAR Dataset/features.txt")
names(dataset) <- variables[,2]
x <- grep(("(mean|std)[^Freq]"),names(dataset))
dataset <- dataset[,x]
activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity_label[,2]<- as.character(activity_label[,2])
source('C:/Users/dimitri/datasciencecoursera/Getting et Cleaning Data/giveactivityname.R')
lab <- give_activity_name(lab[,1])
names(dataset) <- tolower(names(dataset))
names(dataset) <- gsub("bodybody","body",names(dataset))
names(dataset) <- gsub("-","",names(dataset))
dataset <- cbind(subject,lab,dataset)
names(dataset)[1] <- "subject"
names(dataset)[2] <- "activity"
library(dplyr)
dataset <- tbl_df(dataset)
dataset2 <- group_by(dataset,subject,activity)
tidydata <- summarise_each(dataset2,funs(mean))
write.table(tidydata, file = "tidydata.txt",row.name=FALSE)
tidydata