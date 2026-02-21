# Code example from 'chromhmmData' vignette. See references/ for full tutorial.

## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----installation,eval=FALSE--------------------------------------------------
#  if(!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("chromhmmData")

## ----setup--------------------------------------------------------------------
library(chromhmmData)

## ----example------------------------------------------------------------------
# access a directory
chromsizes <- system.file('extdata/CHROMSIZES', package = 'chromhmmData')
dir(chromsizes)

# access a file
system.file('extdata/CHROMSIZES', 'hg19.txt', package = 'chromhmmData')

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

