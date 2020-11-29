# Getting and Cleaning Data Course

## Intro to Project

> In this project we present how to import, clean and combine different datasets into one tidy data frame. We create two dataframes; one that combines all information in a tidy wide format, and another that is a summarised version of the former, in accordance to project specification. The R script needs to perform the following (not necessarily in below order):
>
> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set.
> 4. Appropriately labels the data set with descriptive activity names.
> 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

> For clarifications on different steps of the assignment, I relied on information from this blogpost: https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/

## Code walkthrough

The script first loads the necessary libraries. Library `tidyverse` contains useful libraries such as `dplyr`, `readr`, etc. and package `here` which is very useful in keeping track of relative paths built into your project. Highly recommended if you are using RStudio and RStudio projects.

```R
library(tidyverse) # Tidyverse includes packages like dplyr, tidyr and ggplot2
library(here) # here package is used to easily navigate across directories, irrespective of OS
``` 

Next, to make sure that the data is available for the analysis, I check whether the file exists, and if not I download the .zip and extract it. Furthermore, I set up the paths to the project folder, the .zip file and the data folder.

```R
## Set up paths and download the dataset if not already available in the folder

path_to_project_folder <- here("3_Data_Cleaning", "Project")
path_to_zip <- paste0(path_to_project_folder, "/getdata_projectfiles_UCI HAR Dataset.zip")

if (!file.exists(path_to_zip)) {
  
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  download.file(url, destfile = path_to_zip)
  
  unzip(path_to_zip, exdir = path_to_project_folder)
  
}

## Set up path to the datasets

path <- paste0(path_to_project_folder, "/UCI HAR Dataset")
```

I read the data using functions from the `readr` package, which are more efficient implementations of the base equivalents. It is important that we specify `col_names = FALSE`, because our data does not contain headers. That way, we avoid reading in the first line of the data as the header. The training and test datasets for each respective table is merged together. This corresponds to part of step 1 for the project. To complete step 1, we need to combine the data in a single dataframe.

```R
## Read train data

train_x <- read_table2(paste0(path, "/train/X_train.txt"), col_names = FALSE, col_types = cols(.default = col_double()))
train_y <- read_table2(paste0(path, "/train/y_train.txt"), col_names = FALSE, col_types = cols(.default = col_double()))
train_subject <- read_csv(paste0(path, "/train/subject_train.txt"), col_names = FALSE)

## Read test data

test_x <- read_table2(paste0(path, "/test/X_test.txt"), col_names = FALSE, col_types = cols(.default = col_double()))
test_y <- read_table2(paste0(path, "/test/y_test.txt"), col_names = FALSE, col_types = cols(.default = col_double()))
test_subject <- read_csv(paste0(path, "/test/subject_test.txt"), col_names = FALSE)

## Combine train and test data for x, y and the subject info

x <- bind_rows(train_x, test_x) # similar to rbind
y <- bind_rows(train_y, test_y)
subject <- bind_rows(train_subject, test_subject)
```

I import the features file, which contains the labels for the features in our dataset, corresponding to the x dataset. We perform a light clean of the labels and assign them as headers to the x dataset.

```R
## Read labels for x data, assign them and clean them

x_labels <- read_table2(paste0(path, "/features.txt"), 
                        col_names = FALSE, 
                        col_types = cols(
                          X1 = col_double(),
                          X2 = col_character()
                          )
                        ) %>% 
  select(-X1) %>% 
  as.vector() %>% 
  flatten()

colnames(x) <- x_labels %>% 
  str_replace_all("\\(", "") %>% 
  str_replace_all("\\)", "") %>% 
  str_replace_all("-", "_") %>% 
  str_replace_all(",", "")
```

I assign names to the remaining two columns, corresponding to the activity id (1-6) and the id of each subject (1-30).


```R
## Assign names to the rest of the data

colnames(y) <- "activity_id"
colnames(subject) <- "subject_id"
```

The three datasets (x, y, subject) are combined in a single dataframe. This completes step 1.

```R
## 1. Merges the training and the test sets to create one data set.

## Create a single data.frame (tibble) with all the data by combining all columns of equal length

df <- bind_cols(subject, y, x) # similar to cbind
```

Next, I extract the mean and standard deviation of each measurement. Since this step is ambiguous with respect to some variables and it is not further specified, I decided to simply include all variables that contain either mean or std in the name. This is also motivated from the blogpost that discusses the assignment.

```R
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

## The assignment is requests to keep only variables that correspond to the mean and std.
## The assumption is made (in accordance with below), that all variables that contain mean and std in the column name need to be kept.
## https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/

df <- df %>% 
  select(activity_id, subject_id, contains("mean"), contains("std")) # select only the columns of interest according to what is asked in the assignment
```

I import the descriptive names for each activity and join them in the dataset. The data is arranged in order in terms of subject and activity id.
The final dataframe is created, in a wide tidy format, where each metric for an activity performed by a subject is stored in a separate column.

```R
## 3. Uses descriptive activity names to name the activities in the data set

## Read and add the activity labels

activity_labels <- read_table2(paste0(path, "/activity_labels.txt"), col_names = FALSE)

colnames(activity_labels) <- c("activity_id", "activity_name")

df <- df %>% 
  left_join(activity_labels, by = "activity_id") %>% 
  relocate("activity_name", .after = "activity_id")

df <- df %>% 
  relocate(c("activity_id", "activity_name"), .after = "subject_id") %>% 
  arrange(subject_id, activity_id)
```  

```R
## 4. Appropriately labels the data set with descriptive variable names.

## This step has already been completed above, before joining the data in a single table.
```

Grouping by subject and activity, I summarise all metrics by calculating their mean.

```R
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Group the data.frame by each activity and each test subject and calculate the mean across all variables

df_2 <- df %>% 
  group_by(subject_id, activity_id, activity_name) %>% 
  summarise(across(.cols = everything(), .fns = list(mean = mean), .names = "{.fn}_{.col}"), .groups = "drop")
```

Finally, we can remove the raw data and save the summarised dataset in a txt file for upload to Coursera.

```R
## Remove raw datasets from the environment

write.table(df_2, paste0(path_to_project_folder, "/table.txt"), row.names = FALSE)

rm(activity_labels, subject, train_subject, test_subject, test_x, test_y, train_x, train_y, x, y, x_labels)
```
