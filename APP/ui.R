library(shiny)

shinyUI(fluidPage(
  titlePanel(strong("My Shiny App")),
  sidebarLayout(
    sidebarPanel(
                 h2(strong('Installation')),
                 p(h5('Shiny is available on CRAN,so you can install it in the usual way from your R console:')),
                 code('install.packages("shiny")'),
                 br(),
                 br(),
                 br(),
                 br(),
                 img(src='r.png',height=50,weight=50),
                 'chiny is a product of',
                 span('RStudio',style='color:blue')
                 ),
    mainPanel(
      br(),
      h1(strong('introducing Shiny')),
      p('Shiny is a new package from RStudio that makes it ',em('incredibly easy'),'to build interactive web applications with R.'),
      br(),
      p('For an introduction and live examples,visit the ',a("Shiny homepage.", 
                                                             href = "http://www.rstudio.com/shiny")),
      br(),
      h1(strong('Feartures')),
      tags$ul(tags$li('Build useful....'),tags$li('Shiny'))
    )
  )
)
)
