# Code example from 'iSEEde' vignette. See references/ for full tutorial.

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

## ----"install", eval = FALSE----------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("iSEEde")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----"citation"-----------------------------------------------------------------------------------
## Citation info
citation("iSEEde")

## ----"start", message=FALSE, warning=FALSE--------------------------------------------------------
library("iSEEde")
library("airway")
library("DESeq2")
library("iSEE")

# Example data ----

data("airway")
airway$dex <- relevel(airway$dex, "untrt")

dds <- DESeqDataSet(airway, ~ 0 + dex + cell)

dds <- DESeq(dds)
res_deseq2 <- results(dds, contrast = list("dextrt", "dexuntrt"))
head(res_deseq2)

# iSEE / iSEEde ---

airway <- embedContrastResults(res_deseq2, airway, name = "dex: trt vs untrt")
contrastResults(airway)

app <- iSEE(airway, initial = list(
  DETable(ContrastName="dex: trt vs untrt", HiddenColumns = c("baseMean", 
    "lfcSE", "stat"), PanelWidth = 4L),
  VolcanoPlot(ContrastName="dex: trt vs untrt", PanelWidth = 4L),
  MAPlot(ContrastName="dex: trt vs untrt", PanelWidth = 4L)
))

if (interactive()) {
    shiny::runApp(app)
}

## ----echo=FALSE, out.width="100%"-----------------------------------------------------------------
SCREENSHOT("screenshots/landing_page.png", delay = 20)

## ----createVignette, eval=FALSE-------------------------------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("iSEEde.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("iSEEde.Rmd", tangle = TRUE)

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

