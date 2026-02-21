# Code example from 'v01.stockGenome' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-------------------------------------------------------------------------------------------
options(width=120)
knitr::opts_chunk$set(
   collapse = TRUE,
   eval=interactive(),
   echo=TRUE,
   comment = "#>"
)

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# library(igvR)
# igv <- igvR()
# setBrowserWindowTitle(igv, "Stock Genomes")
# print(sort(getSupportedGenomes(igv)))

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# setGenome(igv, "hg38_1Kg")
# showGenomicRegion(igv, "APOE")
# zoomOut(igv)
# 

## ----eval=TRUE, echo=FALSE, out.width="95%"---------------------------------------------------------------------------
knitr::include_graphics("stockGenomes.png")

## ----eval=TRUE--------------------------------------------------------------------------------------------------------
sessionInfo()

