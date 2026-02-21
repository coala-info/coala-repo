# Code example from 'interactivate_indirect' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    error = FALSE,
    tidy  = FALSE,
    message = FALSE,
    warning = FALSE,
    fig.width = 6,
    fig.height = 6,
    fig.align = "center"
)
library(GetoptLong)
options(digits = 4)

## ----echo = FALSE-------------------------------------------------------------
library(SC3)
library(GOexpress)

## ----eval = FALSE-------------------------------------------------------------
# ComplexHeatmap::pheatmap(...)
# htShiny()

## ----eval = FALSE-------------------------------------------------------------
# library(SingleCellExperiment)
# library(SC3)
# library(scater)
# 
# sce <- SingleCellExperiment(
#     assays = list(
#         counts = as.matrix(yan),
#         logcounts = log2(as.matrix(yan) + 1)
#     ),
#     colData = ann
# )
# 
# rowData(sce)$feature_symbol <- rownames(sce)
# sce <- sce[!duplicated(rowData(sce)$feature_symbol), ]
# sce <- runPCA(sce)
# sce <- sc3(sce, ks = 2:4, biology = TRUE)
# 
# sc3_plot_expression(sce, k = 3)

## ----eval = FALSE-------------------------------------------------------------
# assignInNamespace("pheatmap", ComplexHeatmap::pheatmap, ns = "pheatmap")
# library(InteractiveComplexHeatmap)
# sc3_plot_expression(sce, k = 3)
# htShiny()

## -----------------------------------------------------------------------------
selectMethod("sc3_plot_expression", signature = "SingleCellExperiment")

## ----eval = FALSE-------------------------------------------------------------
# library(GOexpress)
# data(AlvMac)
# set.seed(4543)
# AlvMac_results <- GO_analyse(
# 	eSet = AlvMac, f = "Treatment",
# 	GO_genes=AlvMac_GOgenes, all_GO=AlvMac_allGO, all_genes=AlvMac_allgenes)
# BP.5 <- subset_scores(
# 	result = AlvMac_results.pVal,
# 	namespace = "biological_process",
# 	total = 5,
# 	p.val=0.05)
# heatmap_GO(
# 	go_id = "GO:0034142", result = BP.5, eSet=AlvMac, cexRow=0.4,
# 	cexCol=1, cex.main=1, main.Lsplit=30)

## -----------------------------------------------------------------------------
heatmap_GO

## ----eval = FALSE-------------------------------------------------------------
# detach("package:GOexpress", unload = TRUE)
# assignInNamespace("heatmap.2", ComplexHeatmap:::heatmap.2, ns = "gplots")
# library(GOexpress)
# 
# library(InteractiveComplexHeatmap)
# heatmap_GO(
# 	go_id = "GO:0034142", result = BP.5, eSet=AlvMac, cexRow=0.4,
# 	cexCol=1, cex.main=1, main.Lsplit=30)
# htShiny()

## ----eval = FALSE-------------------------------------------------------------
# library(pheatmap)
# library(gplots)
# assignInNamespace("heatmap", ComplexHeatmap:::heatmap, ns = "stats")
# assignInNamespace("heatmap.2", ComplexHeatmap:::heatmap.2, ns = "gplots")
# assignInNamespace("pheatmap", ComplexHeatmap::pheatmap, ns = "pheatmap")

