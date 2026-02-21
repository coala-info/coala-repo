# Code example from 'tLOH_vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library('tLOH')
library('purrr')
library('dplyr')
library('GenomicRanges')
library('VariantAnnotation')

## ----dataImport, eval=FALSE, warnings = FALSE---------------------------------
# exampleData <- tLOHDataImport('../inst/extdata/Example.vcf')
# # The VCF file in inst/extdata must be decompressed before running this command

## ----marginalCalculations, eval=TRUE------------------------------------------
load("../data/humanGBMsampleAC.rda")
df <- tLOHCalc(humanGBMsampleAC)
head(df)

## ----plotting, eval=TRUE------------------------------------------------------
alleleFrequencyPlot(df, "Example")

aggregateCHRPlot(df, "Example")

