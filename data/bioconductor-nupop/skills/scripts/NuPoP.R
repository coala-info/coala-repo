# Code example from 'NuPoP' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
library(NuPoP)
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## -----------------------------------------------------------------------------
library(NuPoP)

## ----eval=FALSE---------------------------------------------------------------
# predNuPoP(system.file("extdata", "test.seq", package="NuPoP"),species=7,model=4)

## ----eval=FALSE---------------------------------------------------------------
# predNuPoP(file="/Users/jon/DNA/test.seq",species=7,model=4)

## ----eval=FALSE---------------------------------------------------------------
# predNuPoP_chem(file="/Users/jon/DNA/test.seq",species=7,model=4)

## ----eval=TRUE----------------------------------------------------------------
results=readNuPoP(system.file("extdata", "test.seq_Prediction4.txt", package="NuPoP"),startPos=1,endPos=5000)
results[1:5,]

## -----------------------------------------------------------------------------
#par(mar=c(2,2,2,2))
plotNuPoP(results)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

