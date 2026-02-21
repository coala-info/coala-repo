# Code example from 'GSE103322' vignette. See references/ for full tutorial.

## ----get-sce------------------------------------------------------------------
library(ExperimentHub)
library(SingleCellExperiment)
eh = ExperimentHub()
dset <- query(eh , "GSE103322")
dset

## ----download-sce-------------------------------------------------------------
sce <- dset[[1]]

## ----metadata-----------------------------------------------------------------
head(SummarizedExperiment::colData(sce))

## ----non-tumor----------------------------------------------------------------
table(SummarizedExperiment::colData(sce)$non.cancer.cell.type)

## ----data---------------------------------------------------------------------
dset <- SummarizedExperiment::assays(sce)$TPM
dim(dset)
dset[1:4, 1:3]

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

