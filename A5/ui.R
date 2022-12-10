library(shiny)
library(plotly)
library(shinythemes)


# Page 1
intro_panel <- tabPanel(
  "Introduction",
  img(src = "https://raw.githubusercontent.com/info201a-au2022/a5-shuneng/main/A5/pollution.jpg", width = 682.5, length = 1024),
  h4(strong(("Values of interest"))),
  textOutput("intro"),
  hr(),
  textOutput("value_one"),
  textOutput("value_two"),
  textOutput("value_three")
)

main_content <- mainPanel(
  plotlyOutput(outputId = "line_graph"),
  sliderInput(inputId = "years",
              label = "Year range:",
              min = 1950,
              max = 2021,
              value = c(1950,2021),
              animate = animationOptions(interval = 1000),
              width = '100%',
              sep = ""),
  h3("Caption"),
  p("From this interactive graph, we can get a good idea of the carbon emissions of different countries in different regions, we can select a certain interval of years, or we can select several different countries to compare, from which we can learn if most of the regions increase their carbon emissions as the years grow. By comparing different countries we can also see more visually which regions are higher and which are lower.")
)

side_control <- sidebarPanel(
  selectInput(inputId = "select_country",
              label = "Please select a country",
              choices = climate_df$country,
              multiple = TRUE,
              selected = "Africa (GCP)"),
  img(src = "https://www.qubiaoqing.cn/uploads/756965a8cb3737274b411098da7a332e.jpg", width = 350, length = 350),
)

# Page 2
chart_panel <- tabPanel(
  "Interactive visualization",
  sidebarLayout(
    side_control,
    main_content
  )
)

ui <- navbarPage(
  theme = shinythemes::shinytheme("paper"),
  "Climate Change Analysis",
  intro_panel,
  chart_panel
)

