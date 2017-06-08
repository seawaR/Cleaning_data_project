# Code Book for the file `measures_averages.txt`

The file contains a dataset with the following variables:

- `Activity_name`: indicates the name of the activity that was being performed during the measurement.
- `Subject_ID`: indicates the ID of the participant of the study.

The remainig variables are averages of the means or standards deviations for each one of the measurements.

This dataset was generated with the original train and test data for the study **Human Activity Recognition Using Smartphones Data Set** that is available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The steps to produce it are the following:
- Train and test data from `X`, `y` and `subject` were merged together.
- Then the names of the measurements were taken from the file `features.txt`.
- Next, only the measurements ending with `mean()` or `std()` were preserved.
- The names of the activities were added to the dataset.
- Averages were taken for all the measurements for each subject and activity.
