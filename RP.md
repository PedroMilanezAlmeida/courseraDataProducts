Course Project: Shiny Application and Reproducible Pitch
========================================================
author: PMA
date: Jan 9, 2020
autosize: true


Objectives
========================================================
To create a web page using Slidify or Rstudio Presenter with an html5 slide deck.

These are the requirements:
- 5 slides to pitch an idea done in Slidify or Rstudio Presenter
- Presentation pushed to github or Rpubs
- A link to the github or Rpubs presentation pasted into the provided text box

What is the app
========================================================
The app illustrates the loss in model certainty with reductions in sample size.

Please note the changes in the standard error (up), z-values (down) and p-values (up) of the coefficients when reducing the number of samples used in the fit.

Also, please note in the plot how the confidence interval of the fitted line increases when sample size decreases.

Links to github and shinyapps.io
========================================================

The source code for the app can be found here:
https://github.com/PedroMilanezAlmeida/courseraDataProducts

The app can be found here:
https://pedromilanezalmeida.shinyapps.io/courseraDataProducts/

Example
========================================================
The following shows how the model was fit.
<font size=3>

```r
# Poisson regression
as.data.frame(Seatbelts) %>% #get data into data.frame format 
  mutate(., kmsNorm = (kms - mean(kms))/1000) %>% #center and scale to 1000km
  glm(formula = DriversKilled ~ kmsNorm, family = "poisson", data = .) %>% #fit model
  summary(.) %>% .$coef %>% {ifelse(abs(.) < 1e-3, yes = formatC(., format = "e", digits = 1), no = round(.,3))}
```

```
            Estimate Std. Error z value   Pr(>|z|) 
(Intercept) "4.808"  "0.007"    "736.718" "0.0e+00"
kmsNorm     "-0.023" "0.002"    "-10.161" "3.0e-24"
```
</font>
