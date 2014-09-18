getdataP2
=========

Project for Get Data course

This directory contains a single R script for manipulating the Samsung data provided at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script and working directory should be in the same directory that the above dataset is unzipped.  When unzipping you must accept all defaults, and include directories.

The R script included is called run_analysis.R, with 4 functions:
getAllData() - this is the main function and the only one that needs to be called to complete the analysis.  In turn this function will call the functions identified below in order to get, manipulate, and write the necessary data as called for in the assignment.

getTestData() - this function will read the files in the test dataset provided, eliminate columns that do not include 'mean' or 'std' in their names, appropriate label columns, and return the clean dataset to the getAllData() function

getTrainData() - this function will read the files in the train dataset provided, eliminate columns that do not include 'mean' or 'std' in their names, appropriate label columns, and return the clean dataset to the getAllData() function

newDataSet() - this function will use the merged data collected from the above two function for test and train data, and calculate the mean of each of 86 variables (those with 'mean' or 'std' in their names) and create new data frame with the mean data sumarized by Subject and Activity.  Creating a new file with that data set with 180 observations and 88 columns.

