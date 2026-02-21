# Code example from 'scRNAseqApp' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", warning=FALSE, message=FALSE-----------------
suppressPackageStartupMessages({
    library(scRNAseqApp)
})
knitr::opts_chunk$set(warning=FALSE, message=FALSE, fig.width=5, fig.height=3.5)

## ----eval=FALSE---------------------------------------------------------------
# library(BiocManager)
# BiocManager::install("scRNAseqApp")

## -----------------------------------------------------------------------------
library(scRNAseqApp)

## -----------------------------------------------------------------------------
publish_folder=tempdir()
scInit(app_path=publish_folder)

## -----------------------------------------------------------------------------
scRNAseqApp(app_path = publish_folder)

## -----------------------------------------------------------------------------
library(Seurat)
appconf <- createAppConfig(
            title="pbmc_small_test",
            destinationFolder = "pbmc_small_test",
            species = "Homo sapiens",
            doi="10.1038/nbt.3192",
            datatype = "scRNAseq",
            abstract = 'Put the description of the data here.')
createDataSet(
    appconf,
    pbmc_small,
    datafolder=file.path(publish_folder, "data"))
dir(file.path(publish_folder, 'data'))

## -----------------------------------------------------------------------------
sessionInfo()

