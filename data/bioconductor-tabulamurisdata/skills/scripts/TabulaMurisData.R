# Code example from 'TabulaMurisData' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
    library(ExperimentHub)
    library(SingleCellExperiment)
    library(TabulaMurisData)
})

eh <- ExperimentHub()
query(eh, "TabulaMurisData")

## -----------------------------------------------------------------------------
droplet <- eh[["EH1617"]]
droplet
droplet <- TabulaMurisDroplet()
droplet

## -----------------------------------------------------------------------------
set.seed(1234)
se <- droplet[, sample(seq_len(ncol(droplet)), 250, replace = FALSE)]
se

## -----------------------------------------------------------------------------
se <- scran::computeSumFactors(se)
se <- scater::logNormCounts(se)
se <- scater::runPCA(se)
se <- scater::runTSNE(se)

## ----eval=FALSE---------------------------------------------------------------
# if (require(iSEE)) {
#     iSEE(se)
# }

## -----------------------------------------------------------------------------
sessionInfo()

