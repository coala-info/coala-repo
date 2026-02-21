# Code example from 'overview' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>", fig.align = "center"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# 
# #BiocManager::install("concordexR", version="devel")
# devtools::install_github("pachterlab/concordexR")

## ----example------------------------------------------------------------------
library(concordexR)
library(SFEData)

sfe <- McKellarMuscleData("small")

## -----------------------------------------------------------------------------
res <- calculateConcordex(sfe, labels=colData(sfe)[["in_tissue"]])

## -----------------------------------------------------------------------------
sessionInfo()

