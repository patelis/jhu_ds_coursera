# Script to clean and tidy the data for Human Activity Recognition Using Smartphones

# Load libraries to tidy the data

library(tidyverse) # Tidyverse includes packages like dplyr, tidyr and ggplot2
library(here) # here package is used to easily navigate across directories, irrespective of OS

path_to_project_folder <- here("3_Data_Cleaning", "Project")
path_to_zip <- paste0(path_to_project_folder, "/getdata_projectfiles_UCI HAR Dataset.zip")

if (!file.exists(path_to_zip)) {
  
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  download.file(url, destfile = path_to_zip)
  
  unzip(path_to_zip, exdir = path_to_project_folder)
  
}

# Set up path 

path <- paste0(path_to_project_folder, "/UCI HAR Dataset")


# Read train data

train_x <- read_table2(paste0(path, "/train/X_train.txt"), col_names = FALSE, col_types = cols(
  .default = col_double()))
                    
train_y <- read_table2(paste0(path, "/train/y_train.txt"), col_names = FALSE, col_types = cols(
  .default = col_double()))


# Read test data

test_x <- read_table2(paste0(path, "/test/X_test.txt"), col_names = FALSE, col_types = cols(
  .default = col_double()))

test_y <- read_table2(paste0(path, "/test/y_test.txt"), col_names = FALSE, col_types = cols(
  .default = col_double()))


x <- bind_rows(train_x, test_x) # similar to rbind
y <- bind_rows(train_y, test_y)

# Read labels for x data and assign them to dataset

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

colnames(x) <- x_labels
