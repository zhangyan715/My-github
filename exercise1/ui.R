library(ggplot2)
library(shiny)
user=readRDS('user.rds')
lost=readRDS('lost.rds')
idspl=readRDS('idspl.rds')
shinyUI(fluidPage(
  titlePanel('Abnormal Observation'),
  sidebarLayout(
    sidebarPanel(width=4,
      h3('Please Choose your ID'),
      tags$br(),
      selectizeInput('ID1','ID prefix',choices=list('4'=unique(idspl$id.1[grepl(idspl[,1],pattern = '^4',perl = T)]),'8'=unique(idspl$id.1[grepl(idspl[,1],pattern = '^8',perl = T)])),selected=T),
      selectizeInput('ID2','Id infix',choices=unique(idspl$id.2)),
      selectizeInput('ID3','Id postfix',choices=unique(idspl$id.3)),
      h4('Your ID is:'),
      tags$span(strong(textOutput('text')),style='color:red'),
      tags$br(),
    dateRangeInput('date','Date Range',start =range(user[,5])[1],end=range(user[,5])[2]),
    tags$strong('By:'),
    radioButtons('d','',choices=list('1 week'=1,'2 weeks'=2,'3 weeks'=3,'4 weeks'=4,'5 weeks'=5,'6 weeks'=6,'7 weeks'=7,'8 weeks'=8,'9 weeks'=9,'10 weeks'=10,'11 weeks'=11,'12 weeks'=12),selected=1)
    ),
    mainPanel(
      tags$img(src='labixiaoxin.jpg',height=120),
      h2('Graph',align='center'),
     tabsetPanel(
               tabPanel('User97',plotOutput('plot1')),
               #sliderInput('alpha',label = 'Opacity',min = 0,max = 1,value = 0.5),
               #sliderInput('size',label = 'Size',min = 0,max = 5,value = 1),
               tabPanel('lost97',  h5(strong(span('Green line',style='color:green')) ,'is SALE_Q', ',Point=LOST_Q'),plotOutput('plot2'))
       )
     )
    
     ) 
  ))



