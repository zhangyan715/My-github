library(dygraphs)
library(shiny)
library(shinydashboard)
user=readRDS('exercise1//user.rds')
lost=readRDS('exercise1//lost.rds')
idspl=readRDS('exercise1//idspl.rds')
header <- dashboardHeader(title = 'Abnormal Observation',
                          dropdownMenu(type = 'messages',
                                       messageItem(from = 'Zhang Yan',message = "it's just the beginnig of our project.",icon = icon('th'),time='2015-06-10 12:00:00')
                                       )
                          )
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem('User',tabName = 'u',badgeLabel = 'View',badgeColor = 'green',icon = icon('dashboard'),newtab = T),
    menuItem('Lost',tabName = 'l',badgeLabel = 'View',badgeColor = 'green',icon = icon('dashboard'),newtab = T)
    ),
  strong(h5('Please Choose your ID')),
  tags$br(),
  selectizeInput('ID1','ID prefix',choices=list('4'=unique(idspl$id.1[grepl(idspl[,1],pattern = '^4',perl = T)]),'8'=unique(idspl$id.1[grepl(idspl[,1],pattern = '^8',perl = T)])),selected=T),
  selectizeInput('ID2','Id infix',choices=unique(idspl$id.2)),
  selectizeInput('ID3','Id postfix',choices=unique(idspl$id.3)),
  h5('Your ID is:'),
  tags$span(strong(textOutput('text')),style='color:orange'),
  br(),
  dateRangeInput('date','Date Range',start =range(user[,5])[1],end=range(user[,5])[2])
  )

body <- dashboardBody(width=100,
  tabItems(
    tabItem(tabName = 'u',
            h1('User Information'),
            dygraphOutput('plot1')),
    tabItem(tabName = 'l',
            h1('Lost Information'),
            dygraphOutput('plot2')
            )
    )
  )
ui <-dashboardPage(
  header,
  sidebar,
  body) 

server <- function(input,output,session){
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
    t <- user[which(paste(input$ID1,input$ID2,input$ID3,sep = '/')==user[,4] & user[,5]>=input$date[1] & user[,5]<=input$date[2]),]
    return(ts(t[,6],frequency = 1,start =input$date[1],end =input$date[2]))
  })
  inputdata2 <- reactive({
    t1 <- lost[which(lost[,1]>=input$date[1] & lost[,1]<=input$date[2]),]
    return(ts(t1[,2:5],frequency = 1,start =input$date[1],end =input$date[2]))
  })
  output$plot1 <- renderDygraph({
    dygraph(inputdata1(),xlab = 'Date',ylab = 'Volume')%>%
      dySeries('V1',label = 'USED',strokePattern = 'dotdash')%>%
      dyRoller(showRoller = 'T',rollPeriod = 3)%>%
      dyRangeSelector(fillColor = 'grey')
  })
  output$plot2 <- renderDygraph({
    dygraph(inputdata2(),xlab = 'Date')%>%
      dySeries('SUPPLY_Q',label = 'Supply',strokePattern = 'dashed',color='grey') %>%
      dySeries('SALE_Q',label = 'Sale',color = 'lightgreen') %>%
      dySeries('LOST_R',label = 'Lost Rate',axis = 'y2',color = 'pink') %>%
      dySeries('LOST_Q',label = 'Lost',color = 'darkyellow')%>%
      dyAxis('y2',label = 'Rate',independentTicks = T) %>%
      dyAxis('y',label = 'Thousands',independentTicks = F) %>%
      dyHighlight(highlightCircleSize = 5, highlightSeriesBackgroundAlpha = 0.4,hideOnMouseOut = F,highlightSeriesOpts = list(strokeWidth=3)) %>%
      dyOptions(includeZero = T,axisLineWidth = 1.5,drawGrid = T,axisLineColor = 'black',gridLineColor = 'lightblue')%>%
      dyLegend(show = ,width = 550,hideOnMouseOut = T)%>%dyRoller(showRoller = T,rollPeriod = 7)%>%
      dyRangeSelector(fillColor = 'grey')
    
  })
}

shinyApp(ui, server)
