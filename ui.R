library(shiny)
getwd()

movies = read.csv("movies.csv", header = TRUE, stringsAsFactors = FALSE)
fluidRow(
  titlePanel("Movie Recommendation"),

  h3("Choose Three Movies You Like and hit the select button"),
  selectInput("movie1", label = NA,choices = as.character(movies$title[1:9742]),width="500px"),
  selectInput("movie2", label = NA,choices = as.character(movies$title[1:9742]),width="500px"),
  selectInput("movie3", label = NA,choices = as.character(movies$title[1:9742]),width="500px"),
  submitButton("Submit"),
      
  
  h3("You Might Like These Too!"),
  tableOutput("table")
  
)

