
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(dygraphs)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Forecasting Stock Prices from an ARIMA model"),
  #Plot output
  dygraphOutput("fcstPlot"),
  br(),
  br(),
  # Select stock and parameter choices
  fluidRow(
      column(4,
             selectInput("siStockChoice", "Choose a Stock",
                            choices = list('IBM','GE','T','BA','DAL'),
                            selected = "IBM"),
             selectInput('siFwdDays', 'Forecast Days',
                         choices = list(10,20,30,40,50), selected = 20),
             selectInput('siAR','AR (auto-regressive) parameter',
                             choices = list(2,3,4), selected = 2),
             selectInput('siMA', 'MA (moving average) parameter',
                             choices = list(2,3,4)),
             actionButton('abSubmit', 'Submit')
        ),
      column(7, 
             h4("Step by step guide to using this application"),
             h5("General Explanation"),
             p("An ARIMA model is utilized to model the price time series
               of a selected stock. The user can select the ",em('AR')," and
                ",em('MA'), " parameters to rebuild the model and forecast the stock                    price. Forecasting requires selecting the ",em('Forecast Days'),"                 with the parameters and then clicking the", em('Submit')," button"),
             p(strong('Step 1:'), "Choose a stock code from the drop down box."),
             p(strong('Step 2:'), "Select the Forecast Days from drop down box"),
             p(strong('Step 3:'), "Select the AR and MA parameters from stock from the                   drop down box."),
             p(strong('Step 4:'), "Click the Submit button and the graph will appear with                 the required forecast."),
             p(strong('Note:'), "The graph is interactive, so highlight to zoom-in and               double click to restore to normal. Enjoy.")
             )
      )
))
