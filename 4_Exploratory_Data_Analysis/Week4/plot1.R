# Plot 1

## Load libraries
library(dplyr)
library(magrittr)
library(here)

## Check if inputs are available and download and unzip if not

path <- here("4_Exploratory_Data_Analysis", "Week4")

if (!file.exists(paste0(path, "/", "exdata_data_NEI_data.zip"))) {
  
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste0(path, "/", "exdata_data_NEI_data.zip"))
  
  unzip(paste0(path, "/", "exdata_data_NEI_data.zip"), exdir = path)
  
}

## Import the dataset

NEI <- readRDS(paste0(path, "/", "summarySCC_PM25.rds"))

# Summarise the data

summarised <- NEI %>% 
  group_by(year) %>% 
  summarise(emissions = sum(Emissions), .groups = "drop")

# Open png device, create the plot with base graphics and close the device

png(filename = paste0(path, "/", "plot1.png"), width = 480, height = 480, units = "px")

with(summarised, plot(year, emissions, type = "l", main = "Evolution of PM2.5 emissions between 1999 and 2008", xlab = "Year", ylab = "PM2.5 Emissions"))

dev.off()
