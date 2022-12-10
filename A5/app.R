#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(tidyverse)
library(ggplot2)
library(plotly)
library(shiny)
library(shinythemes)

source("server.R")
source("ui.R")

# Run the application 
shinyApp(ui = ui, server = server)
