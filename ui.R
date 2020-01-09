library(shiny)

shinyUI(fluidPage(
    titlePanel("Model Uncertainty with Varying Sample Sizes"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderSampleSize",
                        "What proportion of samples to use?",
                        min = 0,
                        max = 100, 
                        post  = " %",
                        value = 100),
            submitButton("Submit")
        ),
        mainPanel(
            tabsetPanel(
                tabPanel(
                    "Main",
                    plotOutput("plot1"),
                    h3("Coefficient Statistics:"),
                    tableOutput("coefStatsRes")
                    ),
                tabPanel(
                    "Documentation",
                    h4("Slide button"),
                    helpText("Slide the button to choose the percentage of samples
                             to use in regression."),
                    br(),
                    h4("Model fit"),
                    helpText("Under the hood, a linear model is fit to the log of the
                             mean (glm(y~x, family = poisson)). Please take this into
                             consideration when interpreting the coefficients."),
                    br(),
                    h4("Plot"),
                    helpText("In blue is the fitted line, in gray is the 95% confidence
                             interval of the mean."),
                    br(),
                    h4("Data Source"),
                    helpText("Seatbelts in the datasets package. Please type ?Seatbelts
                             in R for details."))
            )))
))