#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a plot

shinyServer(function(input, output) {
    
    output$covidPlot <- renderPlotly({
        
      df <- data %>% 
           filter(id == input$country, 
                  key == input$metric, 
                  date >= input$date_range[1], 
                  date <= input$date_range[2])
      
      p <- ggplot(df, aes(date, value)) + 
            geom_line(colour = "green") + 
            theme_bw() + 
            labs(title = "Evolution of COVID19 Cases", 
                 x = "", 
                 y = glue("Cumulative # of {input$metric}"))
        
      ggplotly(p)

    })
    
    output$instructions <- renderText({
        
        text <- "This is a shiny application to visualise the evolution of various metrics related to the COVID19 pandemic, 
                 across different countries. The user is able to select a country based on its id, a metric (e.g. # of deaths, 
                 # of confirmed cases, etc). The user can also specify the date range to view. The output is a plot presenting 
                 the selected metric cumulatively across the dates the user has specified, for the desired country."
        
        text
        
    })

})
