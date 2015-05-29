shinyUI(fluidPage(
  titlePanel(strong("censusVis")),
  sidebarLayout(
    sidebarPanel(width=5,
           helpText('Create demographic maps with information from the 2010 US Census.'),
           br(),
           selectInput('text',label='Choose a variable to display',choices = list('Percent White','Percent Black','Percent Hispanic','Percent Asian'),selected = 'Percent White'),
           sliderInput('interest',label='range of interest', min = 0, max = 100,value=c(0,100))
          

),mainPanel())
))