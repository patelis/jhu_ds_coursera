# Codebook for the Script to analyze the HAR dataset

Information on the raw data is directly pulled from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Data Source for Raw Data

> Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
> 1. Smartlab - Non-Linear Complex Systems Laboratory DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy.
> 2. CETpD - Technical Research Centre for Dependency Care and Autonomous Living Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain activityrecognition '@' smartlab.ws


## Information on Raw Dataset

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


## Information on Raw Attributes

> For each record in the dataset it is provided:
> - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
> - Triaxial Angular velocity from the gyroscope.
> - A 561-feature vector with time and frequency domain variables.
> - Its activity label.
> - An identifier of the subject who carried out the experiment.


## Script for codecook table

The below script was used to generate the table with information on each variable in the merged dataset.

```R

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

```


|Column Name                       |Variable Class |Summary                                                                  |Description                                                            |
|:---------------------------------|:--------------|:------------------------------------------------------------------------|:----------------------------------------------------------------------|
|subject_id                        |numeric        |mean: 16.1464219827168                                                   |ID for each of 30 subjects                                             |
|activity_id                       |numeric        |mean: 3.62462374987863                                                   |ID for each of 6 activities                                            |
|activity_name                     |character      |WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING |Name of each activity                                                  |
|tBodyAcc_mean_X                   |numeric        |mean: 0.274347260646063                                                  |Mean of body linear acceleration across X axis                         |
|tBodyAcc_mean_Y                   |numeric        |mean: -0.0177434918458972                                                |Mean of body linear acceleration across Y axis                         |
|tBodyAcc_mean_Z                   |numeric        |mean: -0.108925032737064                                                 |Mean of body linear acceleration across Z axis                         |
|tGravityAcc_mean_X                |numeric        |mean: 0.669226222373046                                                  |Mean of gravity acceleration across X axis                             |
|tGravityAcc_mean_Y                |numeric        |mean: 0.00403879092060517                                                |Mean of gravity acceleration across Y axis                             |
|tGravityAcc_mean_Z                |numeric        |mean: 0.0921508600211059                                                 |Mean of gravity acceleration across Z axis                             |
|tBodyAccJerk_mean_X               |numeric        |mean: 0.0789381220355816                                                 |Mean of linear acceleration jerk signal across X axis                  |
|tBodyAccJerk_mean_Y               |numeric        |mean: 0.0079481069090025                                                 |Mean of linear acceleration jerk signal across Y axis                  |
|tBodyAccJerk_mean_Z               |numeric        |mean: -0.00467469823628666                                               |Mean of linear acceleration jerk signal across Z axis                  |
|tBodyGyro_mean_X                  |numeric        |mean: -0.0309824871713436                                                |Mean of angular velocity across X axis                                 |
|tBodyGyro_mean_Y                  |numeric        |mean: -0.0747194855994359                                                |Mean of angular velocity across Y axis                                 |
|tBodyGyro_mean_Z                  |numeric        |mean: 0.088357304227173                                                  |Mean of angular velocity across Z axis                                 |
|tBodyGyroJerk_mean_X              |numeric        |mean: -0.0967092754729682                                                |Mean of angular velocity jerk signal across X axis                     |
|tBodyGyroJerk_mean_Y              |numeric        |mean: -0.0423181079782632                                                |Mean of angular velocity jerk signal across Y axis                     |
|tBodyGyroJerk_mean_Z              |numeric        |mean: -0.0548303497968374                                                |Mean of angular velocity jerk signal across Z axis                     |
|tBodyAccMag_mean                  |numeric        |mean: -0.54822165976717                                                  |Mean of linear acceleration magnitude                                  |
|tGravityAccMag_mean               |numeric        |mean: -0.54822165976717                                                  |Mean of gravity acceleration magnitude                                 |
|tBodyAccJerkMag_mean              |numeric        |mean: -0.649417950650692                                                 |Mean of linear acceleration jerk magnitude                             |
|tBodyGyroMag_mean                 |numeric        |mean: -0.60524856977632                                                  |Mean of angular velocity magnitude                                     |
|tBodyGyroJerkMag_mean             |numeric        |mean: -0.762137610987416                                                 |Mean of angular velocity jerk magnitude                                |
|fBodyAcc_mean_X                   |numeric        |mean: -0.622761658493734                                                 |Mean of linear acceleration frequency across X axis                    |
|fBodyAcc_mean_Y                   |numeric        |mean: -0.53749328145871                                                  |Mean of linear acceleration frequency across Y axis                    |
|fBodyAcc_mean_Z                   |numeric        |mean: -0.665033506271952                                                 |Mean of linear acceleration frequency across Z axis                    |
|fBodyAcc_meanFreq_X               |numeric        |mean: -0.2214691368263                                                   |Mean frequency of linear acceleration across X axis                    |
|fBodyAcc_meanFreq_Y               |numeric        |mean: 0.015400588735675                                                  |Mean frequency of linear acceleration across Y axis                    |
|fBodyAcc_meanFreq_Z               |numeric        |mean: 0.0473098698476722                                                 |Mean frequency of linear acceleration across Z axis                    |
|fBodyAccJerk_mean_X               |numeric        |mean: -0.656713524546605                                                 |Mean of linear acceleration jerk frequency across X axis               |
|fBodyAccJerk_mean_Y               |numeric        |mean: -0.628961179980356                                                 |Mean of linear acceleration jerk frequency across Y axis               |
|fBodyAccJerk_mean_Z               |numeric        |mean: -0.743608246170053                                                 |Mean of linear acceleration jerk frequency across Z axis               |
|fBodyAccJerk_meanFreq_X           |numeric        |mean: -0.0477062917542325                                                |Mean frequency of linear acceleration jerk across X axis               |
|fBodyAccJerk_meanFreq_Y           |numeric        |mean: -0.213392904926883                                                 |Mean frequency of linear acceleration jerk across Y axis               |
|fBodyAccJerk_meanFreq_Z           |numeric        |mean: -0.123828014584147                                                 |Mean frequency of linear acceleration jerk across Z axis               |
|fBodyGyro_mean_X                  |numeric        |mean: -0.672094306818974                                                 |Mean of angular velocity frequency across X axis                       |
|fBodyGyro_mean_Y                  |numeric        |mean: -0.70621663959074                                                  |Mean of angular velocity frequency across Y axis                       |
|fBodyGyro_mean_Z                  |numeric        |mean: -0.644192752866115                                                 |Mean of angular velocity frequency across Z axis                       |
|fBodyGyro_meanFreq_X              |numeric        |mean: -0.101042702224631                                                 |Mean frequency of angular velocity across X axis                       |
|fBodyGyro_meanFreq_Y              |numeric        |mean: -0.174277577553958                                                 |Mean frequency of angular velocity across Y axis                       |
|fBodyGyro_meanFreq_Z              |numeric        |mean: -0.0513928953203266                                                |Mean frequency of angular velocity across Z axis                       |
|fBodyAccMag_mean                  |numeric        |mean: -0.585962696268539                                                 |Mean of linear acceleration frequency                                  |
|fBodyAccMag_meanFreq              |numeric        |mean: 0.0768760112631957                                                 |Mean frequency of linear acceleration                                  |
|fBodyBodyAccJerkMag_mean          |numeric        |mean: -0.620789916331592                                                 |Mean of linear acceleration jerk frequency                             |
|fBodyBodyAccJerkMag_meanFreq      |numeric        |mean: 0.173219742700723                                                  |Mean frequency of linear acceleration jerk                             |
|fBodyBodyGyroMag_mean             |numeric        |mean: -0.697411069729937                                                 |Mean angular velocity frequency                                        |
|fBodyBodyGyroMag_meanFreq         |numeric        |mean: -0.0415636227771787                                                |Mean frequency of angular velocity                                     |
|fBodyBodyGyroJerkMag_mean         |numeric        |mean: -0.779767633083527                                                 |Mean angular velocity jerk frequency                                   |
|fBodyBodyGyroJerkMag_meanFreq     |numeric        |mean: 0.126707820497791                                                  |Mean frequency of angular velocity jerk                                |
|angletBodyAccMeangravity          |numeric        |mean: 0.00770513730366637                                                |Angle between linear acceleration and mean gravity                     |
|angletBodyAccJerkMeangravityMean  |numeric        |mean: 0.00264770963963395                                                |Angle between linear acceleration jerk mean and mean gravity           |
|angletBodyGyroMeangravityMean     |numeric        |mean: 0.0176831301958708                                                 |Angle between angular velocity mean and mean gravity                   |
|angletBodyGyroJerkMeangravityMean |numeric        |mean: -0.00921912899702262                                               |Angle between angular velocity jerk mean and mean gravity              |
|angleXgravityMean                 |numeric        |mean: -0.496522166185746                                                 |Angle between x and gravity mean                                       |
|angleYgravityMean                 |numeric        |mean: 0.0632551738495058                                                 |Angle between y and gravity mean                                       |
|angleZgravityMean                 |numeric        |mean: -0.0542842821505305                                                |Angle between z and gravity mean                                       |
|tBodyAcc_std_X                    |numeric        |mean: -0.607783818968688                                                 |Standard Deviation of body linear acceleration across X axis           |
|tBodyAcc_std_Y                    |numeric        |mean: -0.510191378479501                                                 |Standard Deviation of body linear acceleration across Y axis           |
|tBodyAcc_std_Z                    |numeric        |mean: -0.61306429934125                                                  |Standard Deviation of body linear acceleration across Z axis           |
|tGravityAcc_std_X                 |numeric        |mean: -0.965207115039421                                                 |Standard Deviation of gravity acceleration across X axis               |
|tGravityAcc_std_Y                 |numeric        |mean: -0.95440802665318                                                  |Standard Deviation of gravity acceleration across Y axis               |
|tGravityAcc_std_Z                 |numeric        |mean: -0.938900969424022                                                 |Standard Deviation of gravity acceleration across Z axis               |
|tBodyAccJerk_std_X                |numeric        |mean: -0.63978102073413                                                  |Standard Deviation of linear acceleration jerk signal across X axis    |
|tBodyAccJerk_std_Y                |numeric        |mean: -0.607971599340832                                                 |Standard Deviation of linear acceleration jerk signal across Y axis    |
|tBodyAccJerk_std_Z                |numeric        |mean: -0.762820240449202                                                 |Standard Deviation of linear acceleration jerk signal across Z axis    |
|tBodyGyro_std_X                   |numeric        |mean: -0.721192598029789                                                 |Standard Deviation of angular velocity across X axis                   |
|tBodyGyro_std_Y                   |numeric        |mean: -0.682653506899942                                                 |Standard Deviation of angular velocity across Y axis                   |
|tBodyGyro_std_Z                   |numeric        |mean: -0.653665674372188                                                 |Standard Deviation of angular velocity across Z axis                   |
|tBodyGyroJerk_std_X               |numeric        |mean: -0.731348533131935                                                 |Standard Deviation of angular velocity jerk signal across X axis       |
|tBodyGyroJerk_std_Y               |numeric        |mean: -0.786062320321895                                                 |Standard Deviation of angular velocity jerk signal across Y axis       |
|tBodyGyroJerk_std_Z               |numeric        |mean: -0.739932395222129                                                 |Standard Deviation of angular velocity jerk signal across Z axis       |
|tBodyAccMag_std                   |numeric        |mean: -0.591225327146546                                                 |Standard Deviation of linear acceleration magnitude                    |
|tGravityAccMag_std                |numeric        |mean: -0.591225327146546                                                 |Standard Deviation of gravity acceleration magnitude                   |
|tBodyAccJerkMag_std               |numeric        |mean: -0.627762945785391                                                 |Standard Deviation of linear acceleration jerk magnitude               |
|tBodyGyroMag_std                  |numeric        |mean: -0.662533062898382                                                 |Standard Deviation of angular velocity magnitude                       |
|tBodyGyroJerkMag_std              |numeric        |mean: -0.77799317279698                                                  |Standard Deviation of angular velocity jerk magnitude                  |
|fBodyAcc_std_X                    |numeric        |mean: -0.603356276555826                                                 |Standard Deviation of linear acceleration frequency across X axis      |
|fBodyAcc_std_Y                    |numeric        |mean: -0.528420009576204                                                 |Standard Deviation of linear acceleration frequency across Y axis      |
|fBodyAcc_std_Z                    |numeric        |mean: -0.617874813333395                                                 |Standard Deviation of linear acceleration frequency across Z axis      |
|fBodyAccJerk_std_X                |numeric        |mean: -0.654979816705833                                                 |Standard Deviation of linear acceleration jerk frequency across X axis |
|fBodyAccJerk_std_Y                |numeric        |mean: -0.612243590244114                                                 |Standard Deviation of linear acceleration jerk frequency across Y axis |
|fBodyAccJerk_std_Z                |numeric        |mean: -0.780928428167213                                                 |Standard Deviation of linear acceleration jerk frequency across Z axis |
|fBodyGyro_std_X                   |numeric        |mean: -0.738594816501343                                                 |Standard Deviation of angular velocity frequency across X axis         |
|fBodyGyro_std_Y                   |numeric        |mean: -0.674226934551517                                                 |Standard Deviation of angular velocity frequency across Y axis         |
|fBodyGyro_std_Z                   |numeric        |mean: -0.690446312501126                                                 |Standard Deviation of angular velocity frequency across Z axis         |
|fBodyAccMag_std                   |numeric        |mean: -0.659531216655476                                                 |Standard Deviation of linear acceleration frequency                    |
|fBodyBodyAccJerkMag_std           |numeric        |mean: -0.640076803144351                                                 |Standard Deviation of linear acceleration jerk frequency               |
|fBodyBodyGyroMag_std              |numeric        |mean: -0.699976372277643                                                 |Standard Deviation angular velocity frequency                          |
|fBodyBodyGyroJerkMag_std          |numeric        |mean: -0.792190209274884                                                 |Standard Deviation angular velocity jerk frequency                     
