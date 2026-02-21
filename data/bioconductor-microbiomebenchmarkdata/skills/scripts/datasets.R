# Code example from 'datasets' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----echo=FALSE, message=FALSE------------------------------------------------
## This code is to import the description of the datasets
## Only the table should be displayed on the vignette
library(MicrobiomeBenchmarkData)
fname <- system.file(
    'extdata/datasets.tsv', package = 'MicrobiomeBenchmarkData'
)
datasets <- read.table(
    fname, header = TRUE, sep = '\t', check.names = FALSE
)
data('sampleMetadata', package = 'MicrobiomeBenchmarkData')
PMID <- dplyr::distinct(
    sampleMetadata[, c('dataset', 'pmid')]
)
datasets <- dplyr::left_join(datasets, PMID, by = c('Dataset' = 'dataset'))
datasets <- dplyr::rename(datasets, PMID = pmid)

## ----echo=FALSE---------------------------------------------------------------
## Show table
knitr::kable(datasets, filter = 'top')

## ----echo=FALSE, include=FALSE------------------------------------------------
sessionInfo()

