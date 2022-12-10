#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(shinythemes)


climate_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# Three relevant Values
# Which country has the highest annual rate of individual CO2 emissions? (Value 1)
highest_co2_country <- climate_df %>% 
  filter(co2_per_capita == max(co2_per_capita, na.rm = T)) %>% 
  pull(country)

# what is the average co2 emissions across all countries (Value 2)
avg_co2 <- climate_df %>% 
  summarise(avg_co2 = mean(co2, na.rm =T)) %>% 
  mutate(avg_co2 = round(avg_co2, 2)) %>% 
  pull(avg_co2)

# What year has the highest co2 level (Value 3)
highest_year <- climate_df %>% 
  group_by(year) %>% 
  summarise(highest_year = max(co2, na.rm = T)) %>% 
  filter(highest_year == max(highest_year)) %>% 
  pull(year)


server <- (function(input, output) {
  
  output$intro <- renderText({return(
    paste("In this climate change report, I will show the total annual CO2 emissions for different countries over different timelines."))
  })
  
  output$value_one <- renderText({return(
    paste("In the first variable, I calculated which country has the highest annual personal CO2 emission rate and came up with the result that",
    highest_co2_country, "has the highest personal CO2 emissions. 
    Calculating this value allows us to see if the region has higher CO2 emissions than other countries."))
  })
  
  output$value_two <- renderText({return(
    paste("In the second value I calculated the average value of global CO2 emissions as", avg_co2, "and calculated this value as a reference value for us to compare the CO2 emissions of a particular country."))
  })
  
  output$value_three <- renderText({return(
    paste("In the third value, I calculate that the year with the highest emissions is", highest_year,". Calculating the highest value proves whether global carbon emissions are gradually increasing from year to year."))
  })

  output$line_graph <- renderPlotly({
    
    validate(
      need(input$select_country, "")
    )
    
    plot_df <- climate_df %>% 
      filter(country %in% input$select_country) %>% 
      filter(year >= input$years[1] & year <= input$years[2])
    
    plot <- ggplot(data = plot_df) +
      geom_line(mapping = aes(x = year, y = co2, color = country)) +
      labs(x = "Year",
           y = "Emissions of carbon dioxide (million t)", 
           title = "Annual CO2 emissions by Country (1950 - 2021)")
    
    
    new_plot <- ggplotly(plot)
    return(new_plot)
  })
  
})
