
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(dygraphs)
source('./scripts/Utility.R')

shinyServer(function(input, output) {
    
  df <- reactive({
      
      dtout <- ""
      
      if(input$abSubmit > 0) {
        stckName <- isolate(input$siStockChoice)
        tsStock <- get(stckName)
        tsStock <- tail(tsStock[,4], 252)
        ar = as.numeric(isolate(input$siAR))
        ma = as.numeric(isolate(input$siMA))
         lfwd = as.numeric(isolate(input$siFwdDays))
         dtout <- CreateModel(tsStock, ar = ar, ma = ma, lookfwd = lfwd)
        
      }
      
      dtout
  })
   
  output$fcstPlot <- renderDygraph({
     
      if(df() != "" ) {
        dttoGraph <- tail(df(),200)
        stckName <- isolate(input$siStockChoice)
        headLine <- paste("Stock Forecast of ", stckName, sep = "")
        dygraph(dttoGraph, headLine) %>%dySeries("Actual", label = "Actual") %>%
            dySeries(c("Predicted.lower", "Predicted.mean", "Predicted.upper"), 
                   label = "Predicted")
      }
  })
  
  
})
