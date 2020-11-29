library(purrr)


description <- c(
  "ID for each of 30 subjects", 
  "ID for each of 6 activities", 
  "Name of each activity", 
  "Mean of body linear acceleration across X axis", 
  "Mean of body linear acceleration across Y axis", 
  "Mean of body linear acceleration across Z axis", 
  "Mean of gravity acceleration across X axis", 
  "Mean of gravity acceleration across Y axis", 
  "Mean of gravity acceleration across Z axis",
  "Mean of linear acceleration jerk signal across X axis", 
  "Mean of linear acceleration jerk signal across Y axis", 
  "Mean of linear acceleration jerk signal across Z axis", 
  "Mean of angular velocity across X axis",   
  "Mean of angular velocity across Y axis", 
  "Mean of angular velocity across Z axis", 
  "Mean of angular velocity jerk signal across X axis", 
  "Mean of angular velocity jerk signal across Y axis", 
  "Mean of angular velocity jerk signal across Z axis", 
  "Mean of linear acceleration magnitude", 
  "Mean of gravity acceleration magnitude", 
  "Mean of linear acceleration jerk magnitude", 
  "Mean of angular velocity magnitude", 
  "Mean of angular velocity jerk magnitude", 
  "Mean of linear acceleration frequency across X axis", 
  "Mean of linear acceleration frequency across Y axis", 
  "Mean of linear acceleration frequency across Z axis", 
  "Mean frequency of linear acceleration across X axis", 
  "Mean frequency of linear acceleration across Y axis", 
  "Mean frequency of linear acceleration across Z axis", 
  "Mean of linear acceleration jerk frequency across X axis", 
  "Mean of linear acceleration jerk frequency across Y axis", 
  "Mean of linear acceleration jerk frequency across Z axis", 
  "Mean frequency of linear acceleration jerk across X axis", 
  "Mean frequency of linear acceleration jerk across Y axis", 
  "Mean frequency of linear acceleration jerk across Z axis",
  "Mean of angular velocity frequency across X axis", 
  "Mean of angular velocity frequency across Y axis", 
  "Mean of angular velocity frequency across Z axis", 
  "Mean frequency of angular velocity across X axis", 
  "Mean frequency of angular velocity across Y axis", 
  "Mean frequency of angular velocity across Z axis", 
  "Mean of linear acceleration frequency", 
  "Mean frequency of linear acceleration", 
  "Mean of linear acceleration jerk frequency", 
  "Mean frequency of linear acceleration jerk", 
  "Mean angular velocity frequency", 
  "Mean frequency of angular velocity",
  "Mean angular velocity jerk frequency", 
  "Mean frequency of angular velocity jerk", 
  "Angle between linear acceleration and mean gravity", 
  "Angle between linear acceleration jerk mean and mean gravity", 
  "Angle between angular velocity mean and mean gravity", 
  "Angle between angular velocity jerk mean and mean gravity", 
  "Angle between x and gravity mean", 
  "Angle between y and gravity mean", 
  "Angle between z and gravity mean", 
  "Standard Deviation of body linear acceleration across X axis", 
  "Standard Deviation of body linear acceleration across Y axis", 
  "Standard Deviation of body linear acceleration across Z axis", 
  "Standard Deviation of gravity acceleration across X axis", 
  "Standard Deviation of gravity acceleration across Y axis", 
  "Standard Deviation of gravity acceleration across Z axis",
  "Standard Deviation of linear acceleration jerk signal across X axis", 
  "Standard Deviation of linear acceleration jerk signal across Y axis", 
  "Standard Deviation of linear acceleration jerk signal across Z axis", 
  "Standard Deviation of angular velocity across X axis",   
  "Standard Deviation of angular velocity across Y axis", 
  "Standard Deviation of angular velocity across Z axis", 
  "Standard Deviation of angular velocity jerk signal across X axis", 
  "Standard Deviation of angular velocity jerk signal across Y axis", 
  "Standard Deviation of angular velocity jerk signal across Z axis", 
  "Standard Deviation of linear acceleration magnitude", 
  "Standard Deviation of gravity acceleration magnitude", 
  "Standard Deviation of linear acceleration jerk magnitude", 
  "Standard Deviation of angular velocity magnitude", 
  "Standard Deviation of angular velocity jerk magnitude", 
  "Standard Deviation of linear acceleration frequency across X axis", 
  "Standard Deviation of linear acceleration frequency across Y axis", 
  "Standard Deviation of linear acceleration frequency across Z axis", 
  "Standard Deviation of linear acceleration jerk frequency across X axis", 
  "Standard Deviation of linear acceleration jerk frequency across Y axis", 
  "Standard Deviation of linear acceleration jerk frequency across Z axis", 
  "Standard Deviation of angular velocity frequency across X axis", 
  "Standard Deviation of angular velocity frequency across Y axis", 
  "Standard Deviation of angular velocity frequency across Z axis", 
  "Standard Deviation of linear acceleration frequency", 
  "Standard Deviation of linear acceleration jerk frequency", 
  "Standard Deviation angular velocity frequency", 
  "Standard Deviation angular velocity jerk frequency"
)

table <- tibble(
  `Column Name` = colnames(df), 
  `Variable Class` = map_chr(df, class), 
   Summary = map_chr(df, function(x) 
      if (class(x) == "numeric") {
      
        paste0("mean: ", mean(x))
      
      } else {
      
        paste(unique(x), collapse = ", ")
      
      }
    ), 
  ) %>% 
  bind_cols(tibble(Description = description)) 

ktable <- table %>% knitr::kable("pipe")

            