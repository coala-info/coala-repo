# Code example from 'iSEEtree' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("iSEEtree")

## ----start, message=FALSE, warning=FALSE--------------------------------------
library(iSEEtree)
library(mia)
library(scater)

# Import TreeSE
data("Tengeler2020", package = "mia")
tse <- Tengeler2020

# Add relabundance assay
tse <- transformAssay(tse, method = "relabundance")

# Add reduced dimensions
tse <- runMDS(tse, assay.type = "relabundance")

# Launch iSEE
if (interactive()) {
  iSEE(tse)
}

## ----screenfun, eval=!exists("SCREENSHOT"), include=FALSE---------------------
SCREENSHOT <- function(x, ...) knitr::include_graphics(x)

## ----screenplot, echo=FALSE, out.width="100%"---------------------------------
SCREENSHOT("screenshots/get_started.png", delay=20)

## ----citation-----------------------------------------------------------------
citation("iSEEtree")

## ----reproduce, echo=FALSE--------------------------------------------------------------------------------------------
## Session info
options(width = 120)
sessionInfo()

