#Getting and Cleaning Data - Course Project
This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

* Download the dataset if it does not already exist in the working directory
* Load all required data files
* including the training and test datasets
* Merges the two datasets
* Add a column saying whether an observation is originally from the training or dataset
* Keeping only those columns which reflect a mean or standard deviation
* Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
* The end result is shown in the file Table_Averages.txt