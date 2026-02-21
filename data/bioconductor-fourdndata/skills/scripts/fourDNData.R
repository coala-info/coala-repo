# Code example from 'fourDNData' vignette. See references/ for full tutorial.

## ----eval = TRUE, echo=FALSE, results="hide", message = FALSE, warning = FALSE----
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
suppressPackageStartupMessages({
    library(fourDNData)
})

## -----------------------------------------------------------------------------
library(fourDNData)
head(fourDNData())
cool_file <- fourDNData('4DNESDP9ECMN')
cool_file

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("fourDNData")

## -----------------------------------------------------------------------------
library(HiCExperiment)
ID <- '4DNESDP9ECMN'
cf <- CoolFile(
    path = fourDNData(ID, type = 'mcool'), 
    metadata = as.list(fourDNData()[fourDNData()$experimentSetAccession == ID,])
)
x <- import(cf, resolution = 250000, focus = 'chr5:10000000-50000000')
x
interactions(x)
as(x, 'ContactMatrix')

## -----------------------------------------------------------------------------
library(HiCExperiment)
x <- fourDNHiCExperiment('4DNESDP9ECMN')

## -----------------------------------------------------------------------------
sessionInfo()

