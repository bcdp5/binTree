####################
## SERVER.R
## Developed by bcdp5
####################

library(shiny)
source("euCall.R")

shinyServer(function(input, output) {

  #PLOT Multiperiods Binomial Model for European option
  output$treePlot <- renderPlot({
    #Initialize the plot
    plot(x = c(1, input$N+1), y = c(-input$N , input$N +1), type = "n", 
         axes=F,
         ylab="", xlab="Time")
    axis(1,at = 0:input$N+1, labels=0:input$N)
    #Create 1st point at t=0
    points(x = 1, y = 0)
    text(1.05, 0.6, round(Value(n=input$N, t=input$t, s0=input$s0, K=input$K, u=input$u, r=input$r)[1,1],digits = 2))
    
    for (i in 1:(input$N )) {
      y = seq(from = -i, by = 2, length = i + 1)
      x = rep(i, times = length(y)) + 1
      points(x, y, col = 1)
      for (j in 1:length(x)) {
        text(x[j], y[j] + 0.6, 
             round(Value(n=input$N, t=input$t, s0=input$s0, K=input$K, u=input$u, r=input$r)[length(x) + 1 - j, i + 1],digits = 2))
      }
      y = (-i):i
      x = rep(c(i + 1, i), times = 2 * i)[1:length(y)]
      lines(x, y, col = "deepskyblue")
    }
        
  })
  
  #TABLE of the values of a European option
  output$table <- renderTable({
    as.data.frame(Value(n=input$N, t=input$t, s0=input$s0, K=input$K, u=input$u, r=input$r))
  })
  
})



