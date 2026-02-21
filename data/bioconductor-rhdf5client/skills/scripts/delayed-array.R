# Code example from 'delayed-array' vignette. See references/ for full tutorial.

## ----setup,echo=FALSE,results="hide"------------------------------------------
suppressPackageStartupMessages({
suppressMessages({
library(rhdf5client)
library(DelayedArray)
})
})

## ----lkdela3------------------------------------------------------------------
if (check_hsds()) {
 da <- HSDSArray(URL_hsds(), 'hsds', 
      '/shared/bioconductor/patelGBMSC.h5', '/assay001')
 da
}

## ----lkdel3-------------------------------------------------------------------
if (check_hsds()) {
 apply(da[,1:4],2,sum)
}

