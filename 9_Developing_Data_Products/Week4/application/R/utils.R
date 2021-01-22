library(shiny)
library(tidyverse)
library(plotly)
library(glue)
library(COVID19)

# Load COVID19 data, select desired metrics and convert to long format

data <- covid19(verbose = FALSE) %>% 
  mutate(date = as.Date(date, "%Y-%m-%d")) %>% 
  select(1:10) %>% 
  pivot_longer(cols = (3:10), 
               names_to = "key", 
               values_to = "value") #%>% 
  # filter(!is.na(value))
