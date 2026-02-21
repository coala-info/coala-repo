# Code example from 'quickstart' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(SMAD)
data("TestDatInput")
head(TestDatInput)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
scoreCompPASS <- CompPASS(TestDatInput)
head(scoreCompPASS)

## ----CompPASS output figure, echo=FALSE, fig.height=7, fig.width=7, message=FALSE, warning=FALSE, paged.print=FALSE----
par(mfrow = c(2, 2))
plot(sort(scoreCompPASS$scoreZ, decreasing = TRUE), pch = 16,
     xlab = "Ranked bait-prey interactions",
     ylab = "Z-score")
plot(sort(scoreCompPASS$scoreS, decreasing = TRUE), pch = 16,
     xlab = "Ranked bait-prey interactions",
     ylab = "S-score")
plot(sort(scoreCompPASS$scoreD, decreasing = TRUE), pch = 16,
     xlab = "Ranked bait-prey interactions",
     ylab = "D-score")
plot(sort(scoreCompPASS$scoreWD, decreasing = TRUE), pch = 16,
     xlab = "Ranked bait-prey interactions",
     ylab = "WD-score")


## -----------------------------------------------------------------------------
scoreHG <- HG(TestDatInput)
head(scoreHG)

## ----HG output figure, echo=FALSE, fig.height=7, fig.width=7, message=FALSE, warning=FALSE, paged.print=FALSE----

plot(sort(scoreHG$HG, decreasing = TRUE), pch = 16,
     xlab = "Ranked prey-prey interactions",
     ylab = "HGscore")


