# TidyDataProject
        All necessary files are already downloaded and unzipped in 'Data' directory in the current working directory.
        First of all, 'tidyverse' package is loaded, and the paths to 'train' and 'test' directory are created as work.dir(working directory), data.dir, train.dir and test.dir.

### Importing the common files and training/test set files
        'activity_labels.txt' file is loaded into R using read_fwf function with the columns as character. Similarly, 'features.txt' file is imported into R as a tibble containing only the features column. This 'features' object will be used to name the columns of the training/test data set. 'features_mean_std' object is created from 'features' by selecting the variables that contain "mean" or "std" (standard deviation). 'c_type' is a character vector containing a single character 'n' 561 times, and is used to set the column types of the main data files.
        'y_train.txt' file contains the activity types and is loaded as 'y_train'. 'subject_train.txt' file contains the code of the subjects that performed the training activity and ranges from 1 to 30. This is imported as 'subject_train'. The main data for training is 'X_train.txt', and it is imported as 'x_train' into R.The column names of the 'x_train' is set by 'features'.
        Similar procedure is done for the files in test directory and they are loaded into R as 'y_test', 'subject_test', and 'x_test'. The column names of the 'x_test' is set by 'features'.
        
### Combining the training and test data
        After loading the files into R, the train data are combined into 'training_set' data frame, by inner joining the 'activity_labels' with 'y_train', and the column binding the result with the 'subject_train' and finally with the 'x_train'. 'activity code' column is dropped in the process, because it is represented by more descriptive column of 'activity'. The same is done to combine the test data into 'test_set'. The two sets are combined by row binding and creating a new column showing test/training. This combined data set is subsetted for the columns containing 'mean' and 'std' and assigned to 'train_plus_test' data frame.
