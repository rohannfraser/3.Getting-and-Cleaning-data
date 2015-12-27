#Code Book

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
* Table_Averages - Final tidy file, where the mean has been taken over all variable, split by subject and activity description (30 subjects * 6 activities = 180 rows). The output file is called averages_data.txt, and uploaded to this repository.

## Units of variables
No changes where made to the units of variables compared to the original files.