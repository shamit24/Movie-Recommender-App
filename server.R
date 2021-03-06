#server.R
library(shiny)
source("helpercode.R")

shinyServer(function(input, output) {
  
  output$table <- renderTable({
    movie_recommendation(input$movie1, input$movie2, input$movie3)
  })
  
}
)

