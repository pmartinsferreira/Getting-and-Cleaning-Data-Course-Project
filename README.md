# Getting-and-Cleaning-Data-Course-Project

'run_analysis.R' script prepares a tidy data for further analysis

The script is divided into 6 parts (P1-P6)

- *P1) Load meta-data*: loads features and activity labels;
- *P2) Load train data set*: loads X_train file and adds features labels. Then remove all variables that are not mean or sd; then concatenates it with y_train data and subject data;
- *P3) Load test data set*: same as P2 but for the test data file;
- *P4) Merge test and train data sets*: merges test and train data;
- *P5) Create tidy data set*: compute means of all variables by subject and activity;
- *P6) Write output file*: write tidyDataSet.csv file as an output.
