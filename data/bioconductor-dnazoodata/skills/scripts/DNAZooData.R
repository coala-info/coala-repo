# Code example from 'DNAZooData' vignette. See references/ for full tutorial.

## ----eval = TRUE, echo=FALSE, results="hide", message = FALSE, warning = FALSE----
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
suppressPackageStartupMessages({
    library(DNAZooData)
})

## -----------------------------------------------------------------------------
library(DNAZooData)
head(DNAZooData())
hicfile <- DNAZooData(species = 'Hypsibius_dujardini')
S4Vectors::metadata(hicfile)$organism
S4Vectors::metadata(hicfile)$assemblyURL

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("DNAZooData")

## -----------------------------------------------------------------------------
availableResolutions(hicfile)
availableChromosomes(hicfile)
x <- import(hicfile, resolution = 10000, focus = 'HiC_scaffold_4')
x
interactions(x)
as(x, 'ContactMatrix')

## -----------------------------------------------------------------------------
sessionInfo()

