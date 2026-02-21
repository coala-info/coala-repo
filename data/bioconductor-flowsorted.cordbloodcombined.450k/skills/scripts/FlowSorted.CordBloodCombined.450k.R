# Code example from 'FlowSorted.CordBloodCombined.450k' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(cache = FALSE, warning = FALSE, message = FALSE, 
                        cache.lazy = FALSE,collapse = TRUE, comment = "#>"
)
library(FlowSorted.CordBloodCombined.450k)

## ----eval=TRUE----------------------------------------------------------------
if (memory.limit()>8000){
FlowSorted.CordBloodCombined.450k<-
    libraryDataGet('FlowSorted.CordBloodCombined.450k')
FlowSorted.CordBloodCombined.450k
}

## ----eval=FALSE---------------------------------------------------------------
# data("IDOLOptimizedCpGsCordBlood")
# head(IDOLOptimizedCpGsCordBlood)

## -----------------------------------------------------------------------------
sessionInfo()

