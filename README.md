# Getting and Cleaning Data
This is a repo containing project artefacts from the Getting and Cleaning Data course


Script: run_analysis.R 

The script results in a tidy data set from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Measurements were captured using the embedded accelerometer and gyroscope. 

This data set contains a record containing the means and standard deviations of particular measurements for each activity a subject was performing.


Steps
1. The original test and train data is merged.
2. The measurement names are made to be the column names for the 561 types of measurement
3. Duplicate column names are removed
4. The activity name is used to replace the numeric equivalent
5. Mesasurements that do not relate to mean and standard deviation are removed
6. The datset is formatted according to a subject and a unique activty

