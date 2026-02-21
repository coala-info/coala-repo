# Code example from 'overview' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)
library(BiocStyle)

## -----------------------------------------------------------------------------
library(scater)
library(scran)
library(scRNAseq)
sce <- KotliarovPBMCData()
sce <- sce[,1:1000] # subset for speed.
sce

## -----------------------------------------------------------------------------
stats <- perCellQCMetrics(sce, subsets=list(Mito=grep("^MT-", rownames(sce))))
filter <- quickPerCellQC(stats, sub.fields="subsets_Mito_percent")
sce <- sce[,!filter$discard]
sce <- logNormCounts(sce)
dec <- modelGeneVar(sce)
set.seed(10000)
sce <- runPCA(sce, ncomponents=25, subset_row=getTopHVGs(dec, n=5000))

## -----------------------------------------------------------------------------
# TODO: sync this with the book.
sceA <- as(altExp(sce), "SingleCellExperiment")
statsA <- perCellQCMetrics(sceA)
keep <- statsA$detected > 50 
sceA <- sceA[,keep]

library(DropletUtils)
amb <- inferAmbience(assay(sceA))
sceA <- computeMedianFactors(sceA, reference=amb)
sceA <- logNormCounts(sceA)

set.seed(10000)
sceA <- runPCA(sceA, ncomponents=15)

## -----------------------------------------------------------------------------
sce2 <- sce[,keep]
altExp(sce2) <- sceA

## -----------------------------------------------------------------------------
library(mumosa)
output <- rescaleByNeighbors(list(reducedDim(sce2), reducedDim(altExp(sce2))))
dim(output)

## -----------------------------------------------------------------------------
set.seed(100001)
library(bluster)
sce2$combined.clustering <- clusterRows(output, NNGraphParam())

reducedDim(sce2, "combined") <- output
sce2 <- runTSNE(sce2, dimred="combined")
plotTSNE(sce2, colour_by="combined.clustering")

## -----------------------------------------------------------------------------
g.rna <- buildSNNGraph(sce2, use.dimred="PCA")
rna.clusters <- igraph::cluster_walktrap(g.rna)$membership
table(rna.clusters)

g.adt <- buildSNNGraph(altExp(sce2), use.dimred='PCA')
adt.clusters <- igraph::cluster_walktrap(g.adt)$membership
table(adt.clusters)

## -----------------------------------------------------------------------------
intersected <- paste0(adt.clusters, ".", rna.clusters)
table(intersected)

## -----------------------------------------------------------------------------
intersected2 <- intersectClusters(list(rna.clusters, adt.clusters),
    list(reducedDim(sce2), reducedDim(altExp(sce2))))
table(intersected2)

## -----------------------------------------------------------------------------
set.seed(100002)
umap.out <- calculateMultiUMAP(list(reducedDim(sce2), reducedDim(altExp(sce2))), 
    n_components=20)
dim(umap.out)

## -----------------------------------------------------------------------------
library(bluster)
sce2$umap.clustering <- clusterRows(umap.out, NNGraphParam())

## -----------------------------------------------------------------------------
set.seed(100002)
sce2 <- runMultiUMAP(sce2, dimred="PCA", extras=list(reducedDim(altExp(sce2))))
plotReducedDim(sce2, "MultiUMAP", colour_by="umap.clustering")

## -----------------------------------------------------------------------------
g.com <- intersectGraphs(g.rna, g.adt)

## -----------------------------------------------------------------------------
com.clusters <- igraph::cluster_walktrap(g.com)$membership
table(com.clusters)

## -----------------------------------------------------------------------------
cor.all <- computeCorrelations(sce2, altExp(sce2)[1:5,])
cor.all[order(cor.all$p.value),]

## -----------------------------------------------------------------------------
b <- rep(1:3, length.out=ncol(sce2))
cor.all.batch <- computeCorrelations(sce2, altExp(sce2)[1:5,], block=b)

## -----------------------------------------------------------------------------
set.seed(100001) # for IRLBA.
top.cor <- findTopCorrelations(sce2[1:100,], y=altExp(sce2), number=10)
top.cor
top.cor$positive

## -----------------------------------------------------------------------------
sessionInfo()

