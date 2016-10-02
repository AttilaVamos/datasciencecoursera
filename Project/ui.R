library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Data set mean guessing game"),
  
  sidebarPanel(
    h3('What is your guess for the mean of this histogram?'),
    sliderInput('mu', "Set the slider to your guess", value = 50, min = 1, max = 100, step = 0.5),
    actionButton("check", "Check my guess"),
    actionButton("nextGame", "Next histogram")
  ),
  mainPanel(
    plotOutput('newHist'),
    verbatimTextOutput('yourGuess'),
    verbatimTextOutput('realMean'),
    verbatimTextOutput('mse')
  )
))