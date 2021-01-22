#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("COVID19 Explorer"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            dateRangeInput("date_range", 
                      label = "Select a date range:", 
                      start = min(data$date), 
                      end = max(data$date), 
                      min = min(data$date), 
                      max = max(data$date), 
                      autoclose = FALSE
                      ), 
            selectInput("country", 
                        label = "Select a country:", 
                        choices = unique(data$id), 
                        selected = "USA"
                        ), 
            selectInput("metric", 
                        label = "Select a metric:", 
                        choices = unique(data$key), 
                        selected = "confirmed"
            ), 
            textOutput("instructions")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotlyOutput("covidPlot")
        )
    )
))
