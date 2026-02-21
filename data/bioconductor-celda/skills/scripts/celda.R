# Code example from 'celda' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, dev = "png")

## ----install, eval= FALSE-----------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# BiocManager::install("celda")

## ----library, message = FALSE-------------------------------------------------
library(celda)

## ----help, eval = FALSE-------------------------------------------------------
# help(package = celda)

## ----simulate-----------------------------------------------------------------
simsce <- simulateCells("celda_CG",
    S = 5, K = 5, L = 10, G = 200, CRange = c(30, 50))

## ----assay, message = FALSE---------------------------------------------------
library(SingleCellExperiment)
dim(counts(simsce))

## ----cell_numbers-------------------------------------------------------------
table(colData(simsce)$celda_cell_cluster)
table(colData(simsce)$celda_sample_label)

## ----module_numbers-----------------------------------------------------------
table(rowData(simsce)$celda_feature_module)

## ----warning = FALSE, message = FALSE-----------------------------------------
simsce <- selectFeatures(simsce)

## ----celda_cg, warning = FALSE, message = FALSE-------------------------------
sce <- celda_CG(x = simsce, K = 5, L = 10, verbose = FALSE, nchains = 1)

## ----accuracy-----------------------------------------------------------------
table(celdaClusters(sce), celdaClusters(simsce))
table(celdaModules(sce), celdaModules(simsce))

## ----umap---------------------------------------------------------------------
sce <- celdaUmap(sce)

## ----plot_umap, eval = TRUE, fig.width = 7, fig.height = 7--------------------
plotDimReduceCluster(x = sce, reducedDimName = "celda_UMAP")

plotDimReduceModule(x = sce, reducedDimName = "celda_UMAP", rescale = TRUE)

plotDimReduceFeature(x = sce, reducedDimName = "celda_UMAP",
    normalize = TRUE, features = "Gene_1")

## ----celda_heatmap, eval = TRUE, fig.width = 7, fig.height = 7----------------
plot(celdaHeatmap(sce = sce, nfeatures = 10))

## ----propmap, eval = TRUE, fig.width = 7, fig.height = 7----------------------
celdaProbabilityMap(sce)

## ----module_heatmap, eval = TRUE, fig.width = 7, fig.height = 7---------------
moduleHeatmap(sce, featureModule = c(1,2), topCells = 100)

## ----message = FALSE----------------------------------------------------------
moduleSplit <- recursiveSplitModule(simsce, initialL = 2, maxL = 15)

## -----------------------------------------------------------------------------
plotGridSearchPerplexity(moduleSplit)

## ----module_split_rpc, message = FALSE, warning = FALSE-----------------------
plotRPC(moduleSplit)

## ----module_split_select, message = FALSE-------------------------------------
moduleSplitSelect <- subsetCeldaList(moduleSplit, params = list(L = 10))

cellSplit <- recursiveSplitCell(moduleSplitSelect,
    initialK = 3,
    maxK = 12,
    yInit = celdaModules(moduleSplitSelect))

## ----rpc_cell-----------------------------------------------------------------
plotGridSearchPerplexity(cellSplit)
plotRPC(cellSplit)

## ----subset_celda, eval = TRUE------------------------------------------------
sce <- subsetCeldaList(cellSplit, params = list(K = 5, L = 10))

## ----grid_search, eval = TRUE, message = FALSE--------------------------------
cgs <- celdaGridSearch(simsce,
    paramsTest = list(K = seq(4, 6), L = seq(9, 11)),
    cores = 1,
    model = "celda_CG",
    nchains = 2,
    maxIter = 100,
    verbose = FALSE,
    bestOnly = TRUE)

## ----plot_grid_search, eval = TRUE, fig.width = 8, fig.height = 8, warning = FALSE, message = FALSE----
plotGridSearchPerplexity(cgs)

## ----subset_grid_search, eval = TRUE------------------------------------------
sce <- subsetCeldaList(cgs, params = list(K = 5, L = 10))

## ----best_only_cgs, eval = FALSE, message=FALSE-------------------------------
# cgs <- celdaGridSearch(simsce,
#     paramsTest = list(K = seq(4, 6), L = seq(9, 11)),
#     cores = 1,
#     model = "celda_CG",
#     nchains = 2,
#     maxIter = 100,
#     verbose = FALSE,
#     bestOnly = FALSE)
# 
# cgs <- resamplePerplexity(cgs, celdaList = cgs, resample = 2)
# 
# cgsK5L10 <- subsetCeldaList(cgs, params = list(K = 5, L = 10))
# 
# sce <- selectBestModel(cgsK5L10)

## ----module_lookup------------------------------------------------------------
featureModuleLookup(sce, feature = c("Gene_99"))

## ----recode_clusters----------------------------------------------------------
sceZRecoded <- recodeClusterZ(sce,
    from = c(1, 2, 3, 4, 5), to = c(2, 1, 3, 4, 5))

## ----recode_clusters_show-----------------------------------------------------
table(celdaClusters(sce), celdaClusters(sceZRecoded))

## ----session_info-------------------------------------------------------------
sessionInfo()

