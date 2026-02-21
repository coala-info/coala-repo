# Code example from 'concordex-nonspatial' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message=FALSE-----------------------------------------------------
library(concordexR)
library(TENxPBMCData)
library(BiocNeighbors)
library(bluster)
library(scater)
library(patchwork)
library(ggplot2)
theme_set(theme_bw())

## -----------------------------------------------------------------------------
sce <- TENxPBMCData("pbmc3k")

## -----------------------------------------------------------------------------
sce$nCounts <- colSums(counts(sce))
sce$nGenes <- colSums(counts(sce) > 0)
mito_inds <- grepl("^MT-", rowData(sce)$Symbol_TENx)
sce$pct_mito <- colSums(counts(sce)[mito_inds,])/sce$nCounts * 100

## -----------------------------------------------------------------------------
plotColData(sce, "nCounts") +
  plotColData(sce, "nGenes") +
  plotColData(sce, "pct_mito")

## -----------------------------------------------------------------------------
p1 <- plotColData(sce, x = "nCounts", y = "nGenes") +
  geom_density2d()
p2 <- plotColData(sce, x = "nCounts", y = "pct_mito") +
  geom_density2d()

p1 + p2

## -----------------------------------------------------------------------------
sce <- sce[, sce$nCounts < 10000 & sce$pct_mito < 8]
sce <- sce[rowSums(counts(sce)) > 0,]

## -----------------------------------------------------------------------------
sce <- logNormCounts(sce)

## -----------------------------------------------------------------------------
sce <- runPCA(sce, ncomponents = 30, ntop = 500, scale = TRUE)

## -----------------------------------------------------------------------------
plot(attr(reducedDim(sce, "PCA"), "percentVar"), ylab = "Percentage of variance explained")

## -----------------------------------------------------------------------------
set.seed(29)
sce$cluster <- clusterRows(reducedDim(sce, "PCA")[,seq_len(10)],
                           NNGraphParam(k = 10, cluster.fun = "leiden",
                                        cluster.args = list(
                                          objective_function = "modularity"
                                        )))

## ----fig.width=7, fig.height=6------------------------------------------------
plotPCA(sce, color_by = "cluster", ncomponents = 4)

## -----------------------------------------------------------------------------
sce <- runUMAP(sce, dimred = "PCA", n_dimred = 10, n_neighbors = 10)

## -----------------------------------------------------------------------------
plotUMAP(sce, color_by = "cluster")

## -----------------------------------------------------------------------------
g <- findKNN(reducedDim(sce, "PCA")[,seq_len(10)], k = 10)

## -----------------------------------------------------------------------------
res <- calculateConcordex(
    sce, 
    labels="cluster", 
    use.dimred="PCA",
    compute_similarity=TRUE
)

## -----------------------------------------------------------------------------
sim <- res[["SIMILARITY"]]

round(sim, 2)

## -----------------------------------------------------------------------------
sessionInfo()

