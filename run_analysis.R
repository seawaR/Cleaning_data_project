#########################################################
########### Getting and cleaning data project ###########
################ Author: Adriana Clavijo ################
#########################################################

### Load libraries
library("tidyr")
library("dplyr")


### Download data

if(!file.exists("./raw-data")){dir.create("./raw-data")}

data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url = data_url, destfile="./raw-data/Project_data.zip")

unzip(zipfile = "./raw-data/Project_data.zip", exdir = "./raw-data")


### Load data

## Train data

train_folder <- "./raw-data/UCI HAR Dataset/train/"

subject_train <- read.table(file = paste0(train_folder, "subject_train.txt"))

x_train <- read.table(file = paste0(train_folder, "X_train.txt"))

y_train <- read.table(file = paste0(train_folder, "y_train.txt"))

## Test data

test_folder <- "./raw-data/UCI HAR Dataset/test/"

subject_test <- read.table(file = paste0(test_folder, "subject_test.txt"))

x_test <- read.table(file = paste0(test_folder, "X_test.txt"))

y_test <- read.table(file = paste0(test_folder, "y_test.txt"))

## Features and activities

features <- read.table("./raw-data/UCI HAR Dataset/features.txt")

activity_labels = read.table("./raw-data/UCI HAR Dataset/activity_labels.txt")


### Set columns names and merge data 

colnames(x_train) <- features[, 2] 

colnames(y_train) <- "Activity_code"

colnames(subject_train) <- "Subject_ID"

colnames(x_test) <- features[,2] 

colnames(y_test) <- "Activity_code"

colnames(subject_test) <- "Subject_ID"

colnames(activity_labels) <- c("Activity_code", "Activity_name")

complete_data <- rbind(cbind(y_train, subject_train, x_train),
                       cbind(y_test, subject_test, x_test))


### Extraction of mean and sd measurements

mean_sd_ind <- grep(pattern = "Activity_code|Subject_ID|mean\\(\\)|std\\(\\)", 
                    x = colnames(complete_data))

measures_data <- complete_data[, mean_sd_ind]


### Label activity names

measures_data <- measures_data %>% 
  left_join(activity_labels,
            by = "Activity_code") %>% 
  select(-Activity_code)


### Averages for each activity and subject

## Calculations

measures_averages <- measures_data %>% 
  gather(Measure, Value, -Subject_ID, -Activity_name) %>% 
  group_by(Activity_name, Subject_ID, Measure) %>% 
  summarise(Average = mean(Value)) %>% 
  spread(Measure, Average)

## Save new dataset

write.table(x = measures_averages, 
            file = "measures_averages.txt", 
            row.names = FALSE)
