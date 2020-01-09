library(shiny)
library(dplyr)
library(ggplot2)
shinyServer(function(input, output) {
    seatbelts <- as.data.frame(Seatbelts)
    seatbelts <- mutate(seatbelts,
                        kmsNorm = (kms - mean(kms))/1000)
    
    coefStats <- reactive({
        set.seed(2019)
        if(input$sliderSampleSize > 0){
        propInput <- input$sliderSampleSize
        seatbeltsProp <- seatbelts[sample(dim(seatbelts)[1],
                                          size = (dim(seatbelts)[1]*(propInput/100)) %>%
                                              as.integer(.)),]
        coefStatsRes <- glm(formula = DriversKilled ~ kmsNorm, 
                            family = "poisson",
                            data = seatbeltsProp) %>%
            summary(.) %>%
            .$coef
        coefStatsRes <- ifelse(abs(coefStatsRes) < 1e-3,
                               yes = formatC(coefStatsRes,
                                             format = "e",
                                             digits = 1),
                               no = round(coefStatsRes,3))
        rownames(coefStatsRes) <- c("intercept", "distance driven")
        } else {
            coefStatsRes <- "Please pick a value > 0"
        }
        return(coefStatsRes)
    })
    
    output$plot1 <- renderPlot({
        set.seed(2019)
        propInput <- input$sliderSampleSize
        seatbeltsProp <- seatbelts[sample(dim(seatbelts)[1],
                                          size = (dim(seatbelts)[1]*(propInput/100)) %>%
                                              as.integer(.)),]
        
        ggplot(data = seatbeltsProp,
               aes(kmsNorm,
                   DriversKilled)) +
            geom_point() +
            geom_smooth(method = "glm",
                        method.args = list(family = 'poisson')) +
            theme_bw() +
            xlab("distance driven (centered; 1000km)") +
            ylab("drivers killed/month") +
            xlim(c(-7.4,6.7)) +
            ylim(c(59,199))

    })
    
    output$coefStatsRes <- renderTable({
        coefStats()
    },
    rownames = TRUE)
    
})