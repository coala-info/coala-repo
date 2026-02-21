# Code example from 'iSEEpathways' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-------------------------------------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----eval=!exists("SCREENSHOT"), include=FALSE------------------------------------------------------------------------
# SCREENSHOT <- function(x, ...) knitr::include_graphics(x)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE--------------------------------------------------------
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
    iSEEpathways = citation("iSEEpathways")[1]
)

## ----"install", eval = FALSE------------------------------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#       install.packages("BiocManager")
#   }
# 
# BiocManager::install("iSEEpathways")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----"citation"-------------------------------------------------------------------------------------------------------
## Citation info
citation("iSEEpathways")

## ----"start", message=FALSE, warning=FALSE----------------------------------------------------------------------------
library("iSEEpathways")
library("fgsea")
library("iSEE")

# Example data ----

set.seed(1)
simulated_data <- simulateExampleData()

pathways_list <- simulated_data[["pathwaysList"]]
features_stat <- simulated_data[["featuresStat"]]
se <- simulated_data[["summarizedexperiment"]]

# fgsea ----

set.seed(42)
fgseaRes <- fgsea(pathways = pathways_list, 
                  stats    = features_stat,
                  minSize  = 15,
                  maxSize  = 500)
fgseaRes <- fgseaRes[order(pval), ]
head(fgseaRes)

# iSEE ---

se <- embedPathwaysResults(fgseaRes, se, name = "fgsea", class = "fgsea", pathwayType = "simulated",
                           pathwaysList = pathways_list, featuresStats = features_stat)

app <- iSEE(se, initial = list(
  PathwaysTable(ResultName="fgsea", Selected = "pathway_1350 ", PanelWidth = 6L),
  FgseaEnrichmentPlot(ResultName="fgsea", PathwayId = "pathway_1350", PanelWidth = 6L)
))

if (interactive()) {
  shiny::runApp(app)
}

## ----echo=FALSE, out.width="100%"-------------------------------------------------------------------------------------
SCREENSHOT("screenshots/get_started.png", delay=20)

## ----createVignette, eval=FALSE---------------------------------------------------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("iSEEpathways.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("iSEEpathways.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE-------------------------------------------------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE-------------------------------------------------------------------------------------------
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

