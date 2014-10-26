library(shiny)
# library(PerformanceAnalytics)

library(zoo)
library(tseries)
library(quantmod)

calculateR <- function(totalPortfolio, riskPerc){
        return(riskPerc * totalPortfolio)
}

calculateSharesToBuy <- function(closePrice, stopPrice, R){
        return(R/(closePrice-stopPrice))
}

# R = 0.02
# totalPortfolio = 50000
# R*totalPortfolio
# closePrice = 593
# stopPrice = 553
# riskPerShare = closePrice - stopPrice
# riskPerShare
# (R*totalPortfolio)/riskPerShare

shinyServer(
        function(input, output) {
                output$priceChart <- renderPlot({
                        stock.prices <- get.hist.quote(instrument=input$stock, quote=c("Cl"))
                        closePrice <<- tail(stock.prices, 1)
                        stopPrice <<- {closePrice} *(1-{input$stopPerc})
                        plot(stock.prices)
                        abline(h=stopPrice, col = "red")
                        text(x=index(stock.prices)[length(stock.prices)*0.8],
                             y= {stopPrice}*0.98, 
                             label = paste("Stop Loss:", round({stopPrice},2)), 
                             col="red")})
                output$totalPortfolio <- renderPrint({input$totalPortfolio})
                output$R <- renderText({input$totalPortfolio} * {input$riskPerc})
                output$stock <- renderText({input$stock})
                output$stopPrice <- renderText({round(closePrice *(1-input$stopPerc),2)})
                output$sharesToBuy <- renderText({round({input$totalPortfolio} * {input$riskPerc}
                                                        /({closePrice-stopPrice}),0)})
                output$stock <- renderText({input$stock})
                output$stock <- renderText({input$stock})
        }
)