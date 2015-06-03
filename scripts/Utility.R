library(forecast)
library(quantmod)

getSymbols(c('IBM','GE','T','BA','DAL'))

CreateModel <- function(tsStock, ar =2, dff = 1, ma =2, lookfwd = 30){
    
    fit <- arima(tsStock, order = c(ar,dff,ma))
    fcst <- forecast(fit, h = lookfwd, level = c(68))
    
    vcStock <- c(as.numeric(coredata(tsStock)),rep(NA, lookfwd))
    stopgap <- matrix(NA, nrow = dim(tsStock)[1], ncol = 3)
    fcstDT <- with(fcst, cbind(lower, mean, upper))
    mtfcst <- rbind(stopgap,fcstDT)
    
    indStock <- index(tsStock)
    addOnDt <- tail(indStock,1) + 1:lookfwd
    indDtStock <- c(indStock, addOnDt)
    
    all <- data.frame(Actual = vcStock, Predicted = mtfcst)
    all <- xts(x = all, order.by = indDtStock)
    
    all 
    
}

