# Code example from 'MarrVignette' vignette. See references/ for full tutorial.

## ----include=FALSE, echo=FALSE------------------------------------------------
# date: "`r doc_date()`"
# "`r pkg_ver('BiocStyle')`"
# <style>
#     pre {
#     white-space: pre !important;
#     overflow-y: scroll !important;
#     height: 50vh !important;
#     }
# </style>

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----echo=FALSE, fig.cap="Reproducible Signal matrix", out.width = '100%'-----
knitr::include_graphics("Marr_schematic.png")

## ----load-lib, message=FALSE--------------------------------------------------
library(marr) 

## ----data-1, message=FALSE, warning=FALSE-------------------------------------
data("msprepCOPD")
msprepCOPD

## ----Marr_output--------------------------------------------------------------
library(marr)
Marr_output<- Marr(msprepCOPD, pSamplepairs =
                   0.75, pFeatures = 0.75, alpha=0.05)
Marr_output
## Head of reproducible sample pairs per metabolite (feature)
head(MarrFeatures(Marr_output))
## Head of reproducible metabolites (features) per sample pair
head(MarrSamplepairs(Marr_output))
## Percent of reproducible sample pairs per metabolite (feature)
##greater than 75%
MarrFeaturesfiltered(Marr_output)
## Percent of reproducible metabolites (features) per sample pair
## greater than 75%
MarrSamplepairsfiltered(Marr_output)

## ----fig.cap="Distribution of reproducible metabolites", plot-Marr-Samplepairs----
MarrPlotSamplepairs(Marr_output) 

## ----fig.cap="Distribution of reproducible sample pairs",plot-Marr-Metabolites----
MarrPlotFeatures(Marr_output) 

## ----byFeatures---------------------------------------------------------------
## Filtering the data by reproducible features
MarrFilterData(Marr_output, by = "features")

## Filtering the data by reproducible sample pairs
MarrFilterData(Marr_output, by = "samplePairs")

## Filtering the data by both features and sample pairs
MarrFilterData(Marr_output, by = "both")

## ----session-info-------------------------------------------------------------
sessionInfo() 

