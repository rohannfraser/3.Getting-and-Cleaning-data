#Introduction
The script run_analysis.R arrives at step 5 described in the course project's definition by performing a series of steps (0-12 below):
Note: The step numbers don't correspond to those descibed in the question, but the end result is the same.

##Code and comments
0.Read in all the required data supplied 
```{r}
X_train       <- read.table("train/X_train.txt",       header = FALSE)
Y_train       <- read.table("train/Y_train.txt",       header = FALSE)
X_test        <- read.table("test/X_test.txt",         header = FALSE)
Y_test        <- read.table("test/Y_test.txt",         header = FALSE)
Subject_train <- read.table("train/subject_train.txt", header = FALSE)
Subject_test  <- read.table("test/subject_test.txt",   header = FALSE)
features      <- read.table("features.txt"    ,        header = FALSE)
act_lab       <- read.table("activity_labels.txt",     header = FALSE)
```
1. Combine test and training datasets

```{r}
X_total       <- rbind(X_train,       X_test)
Y_total       <- rbind(Y_train,       Y_test)
Subject_total <- rbind(Subject_train, Subject_test)
```
2. Merge activity numbers (Y) with activity names(act_lab)
```{r}
Y_total  <- data.frame(Y_total, ActivityDescr = act_lab[Y_total[,1],2])
```
3. Create a vector indicating whether observation comes from the original
   training or test dataset
```{r}
train_test    <- c(rep("train",dim(Y_train)[1]), rep("test", dim(Y_test)[1]))
```
4. Create a vector indicating training or test dataset (not essential but handy)
```{r}
train_test    <- c(rep("train",dim(Y_train)[1]), rep("test", dim(Y_test)[1]))
```
5. Combine all columns to form one big dataset
```{r}
data          <- cbind(train_test, Subject_total, Y_total, X_total)
```
6. Set the correct column names for the created dataset
```{r}
ColumnNames <- c("Set", "Subject", "Activity", "ActivityDescr", as.vector(features[,2]))
names(data) <- ColumnNames
```
7. Remove all intermediary variables to free up RAM and tidy up environment
```{r}
rm(Y_total,       X_total,
   X_test,        Y_test, 
   X_train,       Y_train,
   Subject_train, Subject_test,
   Subject_total, features, 
   ColumnNames, train_test,
   act_lab)
```
8. Extract only the measurements on the mean and standa
   Use the grep funtcion on the columnames of data to return on
   of the columns that contain the substrings "mean" or "std"
```{r}
Columns_MuSigma <- grep("-(mean|std)\\(\\)", names(data))
```
9.Also return the first 4 columns to maintain readability
```{r}
Columns <- c(1:4, Columns_MuSigma)
data_MuSigma <- data[,Columns]
```
10.Remove all intermediary variables to free up RAM and tidy up environment
```{r}
rm(Columns, Columns_MuSigma)
```
11.create a second, independent tidy data set with the average of each variable for each activity and each subject.
The first four columns should not be averaged.
```{r}
library(plyr)
Table_Averages <- ddply(data_MuSigma, .(Subject, ActivityDescr), function(x) colMeans(x[,5:70]))
```
12. Write to file. 
write.table(Table_Averages, "Table_Averages.txt", row.name=FALSE)

##Variables
* X_train        - Original train data file loaded into R. This contains the observations
* Y_train        - Original train data file loaded into R. This contains the activitiets
* X_test         - Original test  data file loaded into R. This contains the observations
* Y_test         - Original test  data file loaded into R. This contains the activitiets
* Subject_train  - Original train data file loaded into R. This contains the people in the study (subject)
* Subject_test   - Original test  data file loaded into R. This contains the people in the study (subject)
* features       - Original       data file loaded into R. This contains the names of all the calculated variables
* act_lab        - Original       data file loaded into R. This contains the a description for the activities (number to text description)
 
* X_total        - Merged data for the training and test dataset
* Y_total        - Merged data for the training and test dataset
* Subject_total  - Merged data for the training and test dataset

* data           - total file, including all variables
* data_MuSigma   - File including only the mean and standard deviation variables
* Table_Averages - Final tidy file, where the mean has been taken over all variable, split by subject and activity description

## Units of variables
No changes where made to the units of variables compared to the original files.