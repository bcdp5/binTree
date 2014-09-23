####################
## UI.R
## Developed by bcdp5
####################

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Binomial Tree of a European Option"),
  
  div("Based on: ", em("Stochastic Calculus for Finance - S.Shreve")),
  
  br(),
  
  # Sidebar 
  sidebarLayout(
    sidebarPanel(
      selectInput("t", "European Option type:", 
                  choices=c("Call","Put")),
      hr(),
      sliderInput("N",
                  "Number of periods:",
                  min = 1,
                  max = 15,
                  value = 2),
      br(),
      numericInput("s0",
                   "Initial Value of the Asset:",
                   value = 100),
      br(),
      numericInput("K",
                   "Strike Price:",
                   value = 99),
      numericInput("u",
                  "Up factor:",
                  value = 2),
      numericInput("d",
                   "Down factor:",
                   value = 0.5),
      numericInput("r",
                   "Risk Free:",
                   value = 0.05),
      hr(),
      helpText("Code here:"),
      a(href="https://github.com/bcdp5/binTree", "https://github.com/bcdp5/binTree") 
    ),
      
  # Main Panel 
  mainPanel(
    tabsetPanel(type = "tabs", 
                  tabPanel("Plot",plotOutput("treePlot")), 
                  tabPanel("Table", tableOutput("table"))
      )
    )
  )
))
