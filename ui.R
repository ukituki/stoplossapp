library(shiny)
shinyUI(pageWithSidebar(
        headerPanel("Stop Loss App"),
        sidebarPanel(
                h3('Settings'), 
                numericInput(inputId = 'totalPortfolio', label = 'Total value of portfolio (in USD)', 
                             50000, min=0, step = 1000),
                sliderInput(inputId = "riskPerc", label ="Max. risk per trade (% of Total Portfolio)", 
                            min = 0, max = .2, value = 0.02, step = 0.005, round = FALSE,
                            format = "#,##0.#####", locale = "us", ticks = TRUE, animate = FALSE),
                selectInput("stock", "Select stock:",
                            c("Google" = "goog",
                              "Facebook" = "fb",
                              "Microsoft" = "msft",
                              "IBM" = "ibm",
                              "Tiwtter" = "twtr"
                              )),
                sliderInput(inputId = "stopPerc", label = "Stop Loss (% of current stock price)", 
                            min = 0, max = .2, value = 0.02, step = 0.005),
                submitButton("Update", icon("refresh"))
#                 dateRangeInput("dateRange", "Date Range", start = "2011-01-01", end = "2013-11-01",
#                                min = NULL, max = NULL, format = "yyyy-mm-dd",
#                                startview = "month", weekstart = 0, language = "en",
#                                separator = " to "),
#                 numericInput(inputId = 'stopPrice', label = 'Stop Loss Price (in USD)', 
#                              closePrice * (1-stopPerc), min=0, step = 1000)
        ),
        mainPanel(
                tabsetPanel(
                        tabPanel("Results",
                                 plotOutput("priceChart"),
                                 h4('Shares to buy:', textOutput("sharesToBuy")),
                                 h5("Stop loss:", textOutput("stopPrice")),
                                 h5('Acceptable risk per trade (1R)', textOutput("R"))
                                 ),
                        tabPanel("Instructions", 
                                 h3("Postion sizing"),
                                 p("The main purpose of this application is to answer a
                                   question investors face before almost every transaction: 
                                Given my risk tolerance of X USD per single trade and the current prices of stocks, 
                                   how many shares should I buy to avoid exposing my portfolio to an excessive risk?"),
                                 h4("Settings"),
                                 h5("Total value of portfolio (in USD)"), 
                                 p("Total value of all liquid financial assets - this is a sum of the cash and 
                                   the market value of all financial instruments in portfolio (stocks, bonds, etc,)"),
                                 h5("Max. risk per trade (% of Total Portfolio)"),
                                 p("How much per cent of your total portfolio value are you willing to risk in a single trade?"),
                                 h5("Select stock"), p("Which stock do you consider buying?"),
                                 h5("Stop Loss (% of current stock price)"), 
                                 p("How far from the last closing price do you want to place you protective order (stop loss order). 
                                   The higher the number, the more room against the downward movement of price you have. It means you accept
                                   higher losess and that's why you should buy less shares of the given company that in case of very thight stop loss orders (close to the current price.) ")
                        ))
                )))




