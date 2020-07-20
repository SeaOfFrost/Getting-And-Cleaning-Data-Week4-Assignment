# Getting-And-Cleaning-Data-Week4-Assignment
Assignment submission for peer-reviewed assignment

# Files included in this repository

* `README.md`- Gives an overview of the repository and how to run the code
* `Codebook.md` - Codebook that gives information of the variables and transformations used in the sc
* `run_analysis.R` - The script as required for the assignment to get the tidy, cleaned data
* `tidy data.txt` - The output file of the above mentioned script

# Requirements to Run 

The script requires the `dpylr` library to run. It'll be installed if it isn't installed already.

In addition, it requires the unzipped UCI HAR Dataset to be in the same working directory. The dataset can be downloaded from [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzipped. 

# Working of the Script

The script does the following:

* First, it loads and reads the dataset from the disk
* It then merges the training and testing data into one complete dataset
* Then, it extracts only the measurements that have mean or the standard deviation
* The activities column is given a descriptive description using the `activity_labels.txt` file from the dataset
* Descriptive labels are given to all the columns for better understanding
* A new dataset is made with the average of each variable for each activity and subject 
* This is saved to `tidy data.txt`
