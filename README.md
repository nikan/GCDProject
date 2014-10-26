#Getting and Cleaning Data Course Project

##Introduction
The project contains an R script (run_analysis.R) that performs a number of actions on the dataset downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

After deflating the zip file, the script should be put in the directory that will be created in order to work properly (=course assumption).

Once the script is run, it produces a file named 'tidy.txt' that is the required filed by the project.

##How it works
The run_analysis.R script first loads the libraries required (= dplyr and reshape2) and then the data.

First loads the metadata (activites_labels and features, assigning variable names to the activities_labels data frame) and then the test and train data.

For each of the test and train sets, the subject, activity (=y) are added as columns in the beggining of the data frame of the bulk data.

Then the train and test data are merged and the resulting data frame (CombinedTestTrain) is assinged labels too.

Since there are duplicate columns in this data frame, these columns are purged and from the result we retrieve only the variables that have the word mean or std inside them.

Then  the activity ids are replaced with activity labels  and, finally, we data frame is melted and dcasted so that it produces a table with the averages of all mean and std related variables by subject and activity.

##Notes
In the script the various steps are marked with relevant comments. 

The intermediate dataframes created by the script are the following (in alphabetical order):
activity_labels 
castedData                         
CleanData
CleanDataMeanStd                   
CleanDataMeanStd_withActivityLabels
CombinedTestTrain                  
duplicateCols
features                           
meltData
subject_test                       
subject_train
syX_test                           
syX_train
X_test                             
X_train
y_test                        
y_train