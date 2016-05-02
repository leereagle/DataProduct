library(shiny)
library(ggplot2)

dataset <- mtcars

fluidPage(
  
  titlePanel("Cars Explorer"),
  
  sidebarPanel(
    
    sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                value=nrow(dataset), step=1, round=0),
    
    selectInput('mpg', 'MPG', names(dataset)),
    selectInput('hp', 'HP', names(dataset), names(dataset)[[2]]),
    selectInput('facet_row', 'Facet By Row', c(None='.', names(dataset))),
    selectInput('facet_col', 'Facet By Column', c(None='.', names(dataset))),
    selectInput('wt', 'Color', c('None', names(dataset)))
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Summary", verbatimTextOutput("summary1")),
      tabPanel("Plot", plotOutput("plot")),
      tabPanel("Data Table", tableOutput("data"))
    )
  )
)
