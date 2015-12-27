#setwd("D:/Stuff/Persoonlik/Study/2.Coursera/3.Getting and Cleaning data/Week3/Course Project/UCI HAR Dataset")
# Read in all required datafiles into R
X_train       <- read.table("train/X_train.txt",         header = FALSE)
Y_train       <- read.table("train/Y_train.txt",         header = FALSE)
X_test        <- read.table("test/X_test.txt",          header = FALSE)
Y_test        <- read.table("test/Y_test.txt",          header = FALSE)
Subject_train <- read.table("train/subject_train.txt",   header = FALSE)
Subject_test  <- read.table("test/subject_test.txt",    header = FALSE)
features      <- read.table("features.txt"    ,    header = FALSE)
act_lab       <- read.table("activity_labels.txt", header = FALSE)

# Step 1: Combine test and training datasets
X_total       <- rbind(X_train,       X_test)
Y_total       <- rbind(Y_train,       Y_test)
Subject_total <- rbind(Subject_train, Subject_test)



# Step 2: Merge activity numbers (Y) with activity names(act_lab)
Y_total  <- data.frame(Y_total, ActivityDescr = act_lab[Y_total[,1],2])

# Step 3: Create a vector indicating whehter observation comes from the original
#        training or test dataset
train_test    <- c(rep("train",dim(Y_train)[1]), rep("test", dim(Y_test)[1]))

# Step 4: Combine all columns to form one big dataset
data          <- cbind(train_test, Subject_total, Y_total, X_total)

# Step 5: Set the correct column names for the created dataset
ColumnNames <- c("Set", "Subject", "Activity", "ActivityDescr", as.vector(features[,2]))
names(data) <- ColumnNames

# Step 6: Remove all intermediary variables to free up RAM and tidy up environment
rm(Y_total,       X_total,
   X_test,        Y_test, 
   X_train,       Y_train,
   Subject_train, Subject_test,
   Subject_total, features, 
   ColumnNames, train_test,
   act_lab)

# Step 7: Extract only the measurements on the mean and standard deviation for each measurement.
# Use the grep funtcion on the columnames of data to return only the numbers 
# of the columns that contain the substrings "mean" or "std"
Columns_MuSigma <- grep("-(mean|std)\\(\\)", names(data))

# Step 8: Also return the first 4 columns to maintain readability
Columns <- c(1:4, Columns_MuSigma)
data_MuSigma <- data[,Columns]

# Step 9: Remove all intermediary variables to free up RAM and tidy up environment
rm(Columns, Columns_MuSigma)

# Step 10: create a second, independent tidy data set 
#          with the average of each variable for each activity and each subject.
#          The first four columns should not be averaged.

library(plyr)
Table_Averages <- ddply(data_MuSigma, .(Subject, ActivityDescr), function(x) colMeans(x[,5:70]))

#Step 11: Write to file. 
write.table(Table_Averages, "Table_Averages.txt", row.name=FALSE)

## A loop for reading in original data quickly
# Note: not needed to complete the Coursera assignment since this data has already
# been pre-processed
# ag  <- c("acc",  "gyro")
# xyz <- c("x",    "y",    "z")
# tt  <- c("test", "train")
# for (iag in 1:length(ag)){
#      for(ixyz in 1:length(xyz)){
#           for (itt in 1:length(tt)){
#                name = paste("body_", ag[iag],"_",xyz[ixyz],"_",tt[itt],".txt",sep="")
#                assign(name, read.table(name,header=FALSE))
#                if(ag[iag]=="acc"){
#                     name = paste("total_", ag[iag],"_",xyz[ixyz],"_",tt[itt],".txt",sep="")
#                     assign(name, read.table(name,header=FALSE))
#                }
#                  
#           }
#      }
# }