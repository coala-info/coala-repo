# Code example from 'rounding' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-----------------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)
options(width = 100)

## ----eval=!exists("SCREENSHOT"), include=FALSE----------------------------------------------------
# SCREENSHOT <- function(x, ...) knitr::include_graphics(x)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE------------------------------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle")[1],
    knitr = citation("knitr")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1],
    iSEEde = citation("iSEEde")[1]
)

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
library("airway")
data("airway")
airway$dex <- relevel(airway$dex, "untrt")

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
library("edgeR")

design <- model.matrix(~ 0 + dex + cell, data = colData(airway))

fit <- glmFit(airway, design, dispersion = 0.1)
lrt <- glmLRT(fit, contrast = c(-1, 1, 0, 0, 0))
res_edger <- topTags(lrt, n = Inf)
head(res_edger)

## ----message=FALSE--------------------------------------------------------------------------------
library(iSEEde)
airway <- embedContrastResults(res_edger, airway, name = "edgeR")
contrastResults(airway)
contrastResults(airway, "edgeR")

## -------------------------------------------------------------------------------------------------
panelDefaults(RoundDigits = TRUE, SignifDigits = 2L)

## ----message=FALSE--------------------------------------------------------------------------------
library(iSEE)
app <- iSEE(airway, initial = list(
  DETable(ContrastName="edgeR", HiddenColumns = c("logCPM", "LR"),
          PanelWidth = 12L)
))

if (interactive()) {
  shiny::runApp(app)
}

## ----echo=FALSE, out.width="100%"-----------------------------------------------------------------
SCREENSHOT("screenshots/rounding_default.png", delay = 20)

## ----message=FALSE--------------------------------------------------------------------------------
library(iSEE)
app <- iSEE(airway, initial = list(
  DETable(ContrastName="edgeR", HiddenColumns = c("logCPM", "LR"),
          PanelWidth = 6L, RoundDigits = TRUE),
  DETable(ContrastName="edgeR", HiddenColumns = c("logCPM", "LR"),
          PanelWidth = 6L, RoundDigits = TRUE, SignifDigits = 3L)
))

if (interactive()) {
  shiny::runApp(app)
}

## ----echo=FALSE, out.width="100%"-----------------------------------------------------------------
SCREENSHOT("screenshots/rounding_panel.png", delay = 20)

## ----createVignette, eval=FALSE-------------------------------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("rounding.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("rounding.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE-----------------------------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE-----------------------------------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results = "asis", echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

