library(shiny)

genParams <- function()
{
  # Generate random mean in between 25 and 75
  mu = ceiling(runif(1, 25, 75))
  # Generate random standard deviation in between 1 and 10
  sd = ceiling(runif(1, 0, 10))
  
  return(list(r_mu = mu, r_sd = sd))
}

genData <- function (aNumber, aMu, aSd)
{
  # random generation for the normal distribution with mean equal to mean 
  # and standard deviation equal to sd
  x <- rnorm(aNumber, mean = aMu, sd = aSd)
  
  #if the range of the generated data is too samll generate again
  while( 5 > diff(range(x)))
  {
    x <- rnorm(aNumber, mean = aMu, sd = aSd)
  }
  # The real mean and Sd for the generated dataset isn't exactly same as
  # the parameters were. Calculate the real values
  r_mu = mean(x)
  r_sd = sd(x)
  
  return(list(my_x = x, my_mu = r_mu, my_sd = r_sd))
}

# Control to show result
showRes <<- FALSE

showResult <- function()
{
  return(showRes)
}

shinyServer(
  function(input, output, session)
  {
    # Generate new mean and sd
    par <- genParams()
    
    # Generate dataset wit 1000 elements using par
    res <- genData(1000, par$r_mu, par$r_sd)
    
    # Calculate boundary values to update slider
    my_min <- round(min(res$my_x))
    my_max <- round(max(res$my_x))
    # generate random value for slider initial value
    my_val <- ceiling(runif(1, my_min, my_max))
    
    #my_range <- round(range(res$my_x))
    updateSliderInput(session, 'mu', value = my_val, min = my_min , max = my_max, step = 0.5)
    
    # Handle click on "Check it" button
    observeEvent(input$check, {
      cat("Check pressed observer\n") # debug message to the console
      
      # Enable to reveal real values
      showRes <<- TRUE
    })
    
    # Handle click on "Next Histogram" button
    observeEvent(input$nextGame, {
      cat("Next pressed observer\n") # debug message to the console
      
      # Regenerate paremeters, data and calculate other parameters
      par <<- genParams()
      res <<- genData(5000, par$r_mu, par$r_sd)
      my_min <<- round(min(res$my_x))
      my_max <<- round(max(res$my_x))
      my_val <<- ceiling(runif(1, my_min, my_max))
      #my_range <<- round(range(res$my_x))
      updateSliderInput(session, 'mu', value = my_val, min = my_min , max = my_max, step = 0.5)
    })
    
    # Render a histogram
    output$newHist <- renderPlot({
      input$check  # Activate every time when 'Check' pushed
      input$nextGame  # Activate every time when 'nextGame' pushed
      
      list_hist <- hist(res$my_x, xlab="Values", col='lightblue', main = 'Histogram')
      
      # Calculate largest frequency value of the histogramm to draw
      # user guest and real mean value lines
      max_freq <- max(list_hist$counts)
      
      # Display histogram
      list_hist
      
      mu <- input$mu  # Activate if slider changed
      
      # Draw a vertical red line at the user guess
      lines(c(mu, mu), c(0, max_freq), col='red', lwd=5)
      
      # if reveal real values, draw a blue vertical line at the real mean
      if(showResult()) 
      {
        cat("show result\n")  # debug message to the console
        lines(c(res$my_mu, res$my_mu), c(0, max_freq), col='blue', lwd=5)
      }
      
      # Disable to reveal real values at next update
      showRes <<- FALSE
    })
    
    # Display user guest value
    output$yourGuess <- renderText({
      mu <- input$mu # Render every time when mu/slider chaged
      paste("Your guess =", mu)
      })
    
    # Display real mean value if it is enabled
    output$realMean <- renderText({
      input$check  # Activate every time when 'Check' pushed
      input$nextGame # Activate every time when 'nextGame' pushed
      if(showResult()) 
      {
        paste("Real mean =", round(res$my_mu,2))
      }
      else
      {
        " "
      }
    })
    
    # Display mse (Mean Square Error) value if it is enabled
    output$mse <- renderText({
      input$nextGame # Activate every time when 'nextGame' pushed
      input$check  # Activate every time when 'Check' pushed
      if(showResult()) 
      {
        mu <- input$mu
        mse <- mean((res$my_mu - mu ) ^ 2)
        cat("mse:", mse, "\n")
        paste("MSE =", round(mse, 2))
      }
      else
      {
        " "
      }
    })

  }
)