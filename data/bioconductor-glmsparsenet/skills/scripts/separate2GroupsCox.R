# Code example from 'separate2GroupsCox' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager")) {
#     install.packages("BiocManager")
# }
# BiocManager::install("glmSparseNet")

## ----packages, message=FALSE, warning=FALSE, results='hide'-------------------
library(futile.logger)
library(ggplot2)
library(glmSparseNet)
library(survival)

# Some general options for futile.logger the debugging package
flog.layout(layout.format("[~l] ~m"))
options("glmSparseNet.show_message" = FALSE)
# Setting ggplot2 default theme as minimal
theme_set(ggplot2::theme_minimal())

## -----------------------------------------------------------------------------
data("cancer", package = "survival")
xdata <- survival::ovarian[, c("age", "resid.ds")]
ydata <- data.frame(
    time = survival::ovarian$futime,
    status = survival::ovarian$fustat
)

## -----------------------------------------------------------------------------
resAge <- separate2GroupsCox(c(age = 1, 0), xdata, ydata)

## ----echo=FALSE---------------------------------------------------------------
resAge$km

## ----echo=FALSE---------------------------------------------------------------
resAge$plot

## -----------------------------------------------------------------------------
resAge4060 <-
    separate2GroupsCox(c(age = 1, 0),
        xdata,
        ydata,
        probs = c(.4, .6)
    )

## ----echo=FALSE---------------------------------------------------------------
resAge4060$km

## ----echo=FALSE---------------------------------------------------------------
resAge4060$plot

## -----------------------------------------------------------------------------
resAge6040 <- separate2GroupsCox(
    chosenBetas = c(age = 1, 0),
    xdata,
    ydata,
    probs = c(.6, .4),
    stopWhenOverlap = FALSE
)

## ----echo=FALSE---------------------------------------------------------------
cat("Kaplan-Meier results", "\n")
resAge6040$km

## ----echo=FALSE---------------------------------------------------------------
resAge6040$plot

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

