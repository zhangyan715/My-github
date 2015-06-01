
shinyUI(fluidPage(
  titlePanel('Abnormal Observation'),
  sidebarLayout(
    sidebarPanel(
                 fluidRow(
                   column(6,

                          selectInput('in4', 'ID prefix',choices=idspl[,1],selected = T )
                   ),
                   column(4,

                          selectInput('in5', 'ID infix', choices = idspl[,2],selected = T )
                   ),
                   column(6,

                          selectInput('in6', 'ID postfix',choices = idspl[,3],selected = T )
                   )),
                 dateRangeInput('Range',label ='Time period',min = as.Date('2013-01-01'),max = as.Date('2015-02-04'),start =as.Date('2013-01-01') ,end =as.Date('2015-02-04') )
    ),
    mainPanel(
      plotOutput('map')
    ))

))




