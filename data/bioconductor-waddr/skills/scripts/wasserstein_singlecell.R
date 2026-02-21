# Code example from 'wasserstein_singlecell' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
    library("waddR")
    library("SingleCellExperiment")
    library("BiocFileCache")
})

## -----------------------------------------------------------------------------
url.base <- "https://github.com/goncalves-lab/waddR-data/blob/master/data/"
sce.blood.url <- paste0(url.base, "data_blood.rda?raw=true")
sce.decidua.url <- paste0(url.base, "data_decidua.rda?raw=true")

getCachedPath <- function(url, rname){
    bfc <- BiocFileCache() # fire up cache
    res <- bfcquery(bfc, url, field="fpath", exact=TRUE)
    if (bfccount(res) == 0L)
        cachedFilePath <- bfcadd(bfc, rname=rname, fpath=url)
    else
        cachedFilePath <- bfcpath(bfc, res[["rid"]])
    cachedFilePath
}

load(getCachedPath(sce.blood.url, "data_blood"))
load(getCachedPath(sce.decidua.url, "data_decidua"))

## -----------------------------------------------------------------------------
set.seed(28)
randgenes <- sample(rownames(data_blood), 1000, replace=FALSE)
sce.blood <- data_blood[randgenes, ]
sce.decidua <- data_decidua[randgenes, ]

## -----------------------------------------------------------------------------
assays(sce.blood)
assays(sce.decidua)

## -----------------------------------------------------------------------------
res <- wasserstein.sc(sce.blood, sce.decidua, method="TS",permnum=1000,seed=24)
head(res, n=10L)

## ----session-info-------------------------------------------------------------
sessionInfo()

