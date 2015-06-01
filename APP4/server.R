library(ggplot2)
library(shiny)
user=readRDS('user.rds')
lost=readRDS('lost.rds')
idspl=readRDS('idspl.rds')
shinyServer(
  function(input,output,session){
    output$text <- renderText({
      if(input$ID1!='' & input$ID2!='' & input$ID3!='' )
        paste(input$ID1,input$ID2,input$ID3,sep = '/')
      else
        print('')
    })
    observe({
      updateSelectizeInput(session,'ID2',choices = unique(user[which(input$ID1==user[,1]),2]))
      updateSelectizeInput(session,'ID3',choices = unique(user[which(input$ID2==user[,2] & input$ID1==user[,1]),3]))
      if(any(paste(input$ID1,input$ID2,input$ID3,sep = '/')%in%user[,4]))
      updateDateRangeInput(session,'date',label = paste('  Corresponding','Date Range:',sep = ' '),min =range(user[,5])[1],max=range(user[,5])[2],start=range(user[which(paste(input$ID1,input$ID2,input$ID3,sep='/')==user[,4]),5])[1]+1,end=range(user[which(paste(input$ID1,input$ID2,input$ID3,sep='/')==user[,4]),5])[2]+1)
        
  })
  inputdata1 <- reactive({
    user[which(paste(input$ID1,input$ID2,input$ID3,sep = '/')==user[,4] & user[,5]>=input$date[1] & user[,5]<=input$date[2]),]
  })
  inputdata2 <- reactive({
    lost[which(lost[,1]>=input$date[1] & lost[,1]<=input$date[2]),]
  })
  output$plot1 <- renderPlot({
    ggplot(inputdata1(),aes(x=DATE_TIME,y=USED_Q))+geom_point(color='pink')+geom_line(color='blue')
  })
  output$plot2 <- renderPlot({
    ggplot(inputdata2(),aes(x=DATE_TIME,y=LOST_Q))+geom_point(aes(color=Normal))
    
  })
  })