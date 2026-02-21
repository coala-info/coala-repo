# Code example from 'Getting-Started' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
collapse = TRUE,
comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# library(remotes)
# remotes::install_github("ilia-kats/MuData")

## ----setup, message = FALSE---------------------------------------------------
library(MuData)
library(MultiAssayExperiment)

library(rhdf5)

## -----------------------------------------------------------------------------
data(miniACC)
miniACC

## -----------------------------------------------------------------------------
writeH5MU(miniACC, "miniacc.h5mu")

## -----------------------------------------------------------------------------
rhdf5::h5ls("miniacc.h5mu", recursive = FALSE)

## -----------------------------------------------------------------------------
h5 <- rhdf5::H5Fopen("miniacc.h5mu")
h5&'mod'
rhdf5::H5close()

## -----------------------------------------------------------------------------
acc <- readH5MU("miniacc.h5mu")
acc

## -----------------------------------------------------------------------------
head(colData(miniACC)[,1:4])
head(colData(acc)[,1:4])

## -----------------------------------------------------------------------------
head(rowData(miniACC[["gistict"]]))
head(rowData(acc[["gistict"]]))

## -----------------------------------------------------------------------------
acc_b <- readH5MU("miniacc.h5mu", backed = TRUE)
assay(acc_b, "RNASeq2GeneNorm")[1:5,1:3]

## -----------------------------------------------------------------------------
class(assay(acc_b, "RNASeq2GeneNorm"))

## -----------------------------------------------------------------------------
assay(acc, "RNASeq2GeneNorm")[1:5,1:3]
class(assay(acc, "RNASeq2GeneNorm"))

## -----------------------------------------------------------------------------
sessionInfo()

