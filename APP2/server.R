library(shiny)

# Define server logic required to draw a histogram

  shinyServer(function(input, output) {
    
    # You can access the value of the widget with input$action, e.g.
    output$text1 <- renderText({
      paste('You have select',input$text)})
    output$text2 <- renderText({
        paste('You have selected a range that goes from',input$interest[1],'to',input$interest[2])
      })
    
  })
  
