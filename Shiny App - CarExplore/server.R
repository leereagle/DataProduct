library(shiny)
library(ggplot2)

function(input, output) {
  
  dataset <- reactive({
    mtcars[sample(nrow(mtcars), input$sampleSize),]
  })
  
  output$data <- renderTable({
    mtcars
  })
  
  output$summary1 <- renderText({
    a <- "'mtcars' dataset is one of the default dataset for practicing and demostration of R programming language. The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspectsof automobile design and performance for 32 automobiles (1973-74 models)."
    b <- "To learn more about 'mtcars' dataset, type 'help(mtcars)' or '??mtcars' in your R console."
    c <- "Choose MPG and HP then you will see the information. Choose color to differentiate the dimension with different colors. You can also tick 'Jitter' and 'Smooth' to see their effect. If you wish to compare the data in different facets. 'facet row' and 'facet column' are also available to choose."
    d <- "'Summary' tab - This page;"
    e <- "'Plot' tab - contains the plot with smooth trend;"
    f <- "'Data Table' tab - contains the complete mtcars dataset in a table"
    
    paste(a,"",b,"",c,"",d,e,f,sep="\n")
    
  })
  

  output$plot <- renderPlot({
    
    p <- ggplot(dataset(), aes_string(x=input$mpg, y=input$hp)) + geom_point() + geom_smooth()
    
    if (input$wt != 'None')
      p <- p + aes_string(color=input$wt)
    
    facets <- paste(input$facet_row, '~', input$facet_col)
    if (facets != '. ~ .')
      p <- p + facet_grid(facets)
    
    print(p)
    
  }, height=700)
  
}