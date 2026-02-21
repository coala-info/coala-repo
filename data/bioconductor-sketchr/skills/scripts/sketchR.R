# Code example from 'sketchR' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = TRUE,
  crop = NULL
)
library(BiocStyle)

## ----installation-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("sketchR")

## ----load-pkg-----------------------------------------------------------------
suppressPackageStartupMessages({
    library(sketchR)
    library(TENxPBMCData)
    library(scuttle)
    library(scran)
    library(scater)
    library(SingleR)
    library(celldex)
    library(cowplot)
    library(SummarizedExperiment)
    library(SingleCellExperiment)
    library(beachmat.hdf5)
})

## ----process-data-------------------------------------------------------------
## Load data
pbmc3k <- TENxPBMCData(dataset = "pbmc3k")

## Set row and column names
colnames(pbmc3k) <- paste0("Cell", seq_len(ncol(pbmc3k)))
rownames(pbmc3k) <- uniquifyFeatureNames(
    ID = rowData(pbmc3k)$ENSEMBL_ID,
    names = rowData(pbmc3k)$Symbol_TENx
)

## Normalize and log-transform counts
pbmc3k <- logNormCounts(pbmc3k)

## Find highly variable genes
dec <- modelGeneVar(pbmc3k)
top.hvgs <- getTopHVGs(dec, n = 2000)

## Perform dimensionality reduction
set.seed(100)
pbmc3k <- runPCA(pbmc3k, subset_row = top.hvgs)
pbmc3k <- runTSNE(pbmc3k, dimred = "PCA")

## Predict cell type labels
ref_monaco <- MonacoImmuneData()
pred_monaco_main <- SingleR(test = pbmc3k, ref = ref_monaco, 
                            labels = ref_monaco$label.main)
pbmc3k$labels_main <- pred_monaco_main$labels

dim(pbmc3k)

## ----geosketch----------------------------------------------------------------
idx800gs <- geosketch(reducedDim(pbmc3k, "PCA"), 
                      N = 800, seed = 123)
head(idx800gs)
length(idx800gs)

## ----plot-tsne, fig.width = 10, fig.height = 4--------------------------------
plot_grid(
    plotTSNE(pbmc3k, colour_by = "labels_main"),
    plotTSNE(pbmc3k[, idx800gs], colour_by = "labels_main")
)

## ----plot-abundance, fig.width = 6, fig.height = 8----------------------------
compareCompositionPlot(colData(pbmc3k), 
                       idx = list(geosketch = idx800gs), 
                       column = "labels_main")

## ----plot-diagnostics---------------------------------------------------------
set.seed(123)
hausdorffDistPlot(mat = reducedDim(pbmc3k, "PCA"), 
                  Nvec = c(400, 800, 2000),
                  Nrep = 3, methods = c("geosketch", "uniform"))

## ----session-info-------------------------------------------------------------
sessionInfo()

