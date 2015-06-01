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
    dateRangeInput('date','Date Range',start =range(user[,5])[1],end=range(user[,5])[2])
    ),
    
    mainPanel(
      h2('PLOT',align='center'),
     
       
               plotOutput('plot1'),
               #sliderInput('alpha',label = 'Opacity',min = 0,max = 1,value = 0.5),
               #sliderInput('size',label = 'Size',min = 0,max = 5,value = 1),
      
               plotOutput('plot2')
        
      
      ))
  ))



