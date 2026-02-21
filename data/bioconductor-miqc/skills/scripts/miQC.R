# Code example from 'miQC' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("miQC")

## ----options, include=FALSE, message=FALSE, warning=FALSE---------------------
knitr::opts_chunk$set(cache=FALSE, error=FALSE, message=FALSE, warning=FALSE)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
    library(SingleCellExperiment)
    library(scRNAseq)
    library(scater)
    library(flexmix)
    library(splines)
    library(miQC)
})

## -----------------------------------------------------------------------------
sce <- ZeiselBrainData()
sce

## -----------------------------------------------------------------------------
mt_genes <- grepl("^mt-",  rownames(sce))
feature_ctrls <- list(mito = rownames(sce)[mt_genes])

feature_ctrls

## -----------------------------------------------------------------------------
sce <- addPerCellQC(sce, subsets = feature_ctrls)
head(colData(sce))

## -----------------------------------------------------------------------------
plotMetrics(sce)

## -----------------------------------------------------------------------------
model <- mixtureModel(sce)

## -----------------------------------------------------------------------------
parameters(model)
head(posterior(model))

## -----------------------------------------------------------------------------
plotModel(sce, model)

## -----------------------------------------------------------------------------
plotFiltering(sce, model)

## -----------------------------------------------------------------------------
sce <- filterCells(sce, model)
sce

## -----------------------------------------------------------------------------
sce <- ZeiselBrainData()
sce <- addPerCellQC(sce, subsets = feature_ctrls)

model2 <- mixtureModel(sce, model_type = "spline")
plotModel(sce, model2)
plotFiltering(sce, model2)

model3 <- mixtureModel(sce, model_type = "polynomial")
plotModel(sce, model3)
plotFiltering(sce, model3)

## -----------------------------------------------------------------------------
model4 <- mixtureModel(sce, model_type = "one_dimensional")
plotModel(sce, model4)
plotFiltering(sce, model4)
get1DCutoff(sce, model4)

## -----------------------------------------------------------------------------
plotFiltering(sce, model4, posterior_cutoff = 0.9)

## -----------------------------------------------------------------------------
data("hgsoc_metrics")
sce <- SingleCellExperiment(colData = metrics)
model <- mixtureModel(sce)
plotFiltering(sce, model, posterior_cutoff = 0.6, enforce_left_cutoff = FALSE,
                keep_all_below_boundary = FALSE)

## -----------------------------------------------------------------------------
plotFiltering(sce, model, posterior_cutoff = 0.6, enforce_left_cutoff = FALSE,
                keep_all_below_boundary = TRUE)

## -----------------------------------------------------------------------------
plotFiltering(sce, model, posterior_cutoff = 0.6, enforce_left_cutoff = TRUE,
                keep_all_below_boundary = TRUE)

## -----------------------------------------------------------------------------
sce <- BuettnerESCData()
mt_genes <- grepl("^mt-", rowData(sce)$AssociatedGeneName)
feature_ctrls <- list(mito = rownames(sce)[mt_genes])
sce <- addPerCellQC(sce, subsets = feature_ctrls)

plotMetrics(sce)

## ----echo=FALSE-------------------------------------------------------------------------------------------------------
## Session info
options(width = 120)
sessionInfo()

