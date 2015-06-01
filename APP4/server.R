library(ggplot2)
library(magrittr)
library(shiny)
user=readRDS('user.rds')
lost=readRDS('lost.rds')
idspl=readRDS('idspl.rds')
shinyServer(
  function(input,output){
      data <- reactive({user[which(user$USER_ID==paste(input$in4,input$in5,input$in6,collapse = '/')),]})
    output$map <- renderPlot((
      ggplot(data(),aes(x=input$Range,y=user[which(DATE_TIME==input$Range),3]))+geom_point()
    ))
})
