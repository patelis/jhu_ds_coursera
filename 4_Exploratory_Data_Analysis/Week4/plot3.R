# Plot 3

## Load libraries
library(dplyr)
library(magrittr)
library(ggplot2)
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
  filter(fips == "24510") %>% # filter for Baltimore City
  mutate(type = tolower(type)) %>% 
  group_by(year, type) %>% 
  summarise(emissions = sum(Emissions), .groups = "drop")

p <- ggplot(summarised, aes(year, emissions, colour = type)) + 
  geom_line() + 
  labs(title = "Evolution of PM2.5 Emissions in Baltimore City \nby type between 1999 and 2008", 
       x = "Year", 
       y = "PM2.5 Emissions") + 
  theme_bw() + 
  theme(legend.position = "bottom")
  

# Open png device, create the plot with base graphics and close the device

png(filename = paste0(path, "/", "plot3.png"), width = 480, height = 480, units = "px")

p

dev.off()
