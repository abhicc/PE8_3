library(tidyverse)   
library(shiny)

gpmdata <- read_csv("Gapminder_data.csv")

# user interface
ui3 <- fluidPage(
  
  # application title
  titlePanel("Life Expectancy by Log of GDP per Capita"),
  
  sidebarLayout(
    sidebarPanel(
      
      # input for year
      sliderInput(inputId = "year",
                  label = "Year:",
                  min = 1800,
                  max = 2020,
                  value = 1800)
    ),
    
    # show plot
    mainPanel(
      plotOutput("plot")
    )
  )
)


# server logic
server3 <- function(input, output) {
  
  output$plot <- renderPlot({
    
    # create plot
    ggplot(data = gpmdata %>% filter(year == input$year)) + 
      geom_point(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
      scale_x_continuous(trans='log2') +
      xlab("Log GDP per capita") + ylab("Life Expectancy") 
  })
}


# run the application 
shinyApp(ui = ui3, server = server3)