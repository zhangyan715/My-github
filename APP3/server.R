# server.R
library(maps)
library(mapproj)
source('helpers.R')
counties <- readRDS('data//counties.rds')

shinyServer(
  function(input,output){
    output$map <- renderPlot({
      percent_map(counties$white,'red','% White')
    })
    
  }
    )
