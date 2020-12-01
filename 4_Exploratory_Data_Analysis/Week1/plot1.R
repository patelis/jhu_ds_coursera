# Plot 1

## Load libraries
library(dplyr)
library(magrittr)
library(readr)
library(here)

## Check if inputs are available and download and unzip if not



if (!file.exists(here("4_Exploratory_Data_Analysis", "Week1", "exdata_data_household_power_consumption.zip"))) {
  
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = here("4_Exploratory_Data_Analysis", "Week1", "exdata_data_household_power_consumption.zip"))
  
  unzip(here("4_Exploratory_Data_Analysis", "Week1", "exdata_data_household_power_consumption.zip"), exdir = here("4_Exploratory_Data_Analysis", "Week1"))
  
}

## Import the dataset

df <- read_delim(here("4_Exploratory_Data_Analysis", "Week1", "household_power_consumption.txt"), ";", escape_double = FALSE, trim_ws = TRUE, col_types = cols(
                  Date = col_character(),
                  Time = col_time(format = ""),
                  Global_active_power = col_double(),
                  Global_reactive_power = col_double(),
                  Voltage = col_double(),
                  Global_intensity = col_double(),
                  Sub_metering_1 = col_double(),
                  Sub_metering_2 = col_double(),
                  Sub_metering_3 = col_double()
))
 
# Convert date and time to the appropriate data type and filter for the specified dates

df <- df %>% 
  mutate(
         Date = as.Date(Date, format = "%d/%m/%Y"), 
         Time = as.character(paste0(Date, " ", Time)), 
         Time = strptime(Time, format = "%Y-%m-%d %H:%M:%S")
         ) %>% 
  filter(Date == "2007-02-01" | Date == "2007-02-02")


# Open png device, create the plot with base graphics and close the device

png(filename = here("4_Exploratory_Data_Analysis", "Week1", "plot1.png"), width = 480, height = 480, units = "px")

hist(df$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()