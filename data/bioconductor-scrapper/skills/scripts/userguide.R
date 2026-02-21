# Code example from 'userguide' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

library(BiocStyle)
self <- Biocpkg("scrapper")

## -----------------------------------------------------------------------------
library(scRNAseq)
sce.z <- ZeiselBrainData()
sce.z

## -----------------------------------------------------------------------------
# Finding the mitochondrial genes for QC purposes.
is.mito <- grepl("^mt-", rownames(sce.z))

# We can set the number of threads higher in real applications, but
# we want to avoid stressing out Bioconductor's build system.
nthreads <- 2

library(scrapper)
res <- analyze(
    sce.z,
    rna.subsets=list(mito=is.mito),
    num.threads=nthreads
)

## -----------------------------------------------------------------------------
tabulate(res$clusters)
plot(res$tsne[,1], res$tsne[,2], col=res$clusters)

## -----------------------------------------------------------------------------
# Top markers for each cluster, say, based on the median AUC:
top.markers <- lapply(res$rna.markers$auc, function(x) {
    head(rownames(x)[order(x$median, decreasing=TRUE)], 10)
})
head(top.markers)

# Aggregating all marker statistics for the first cluster
# (delta.mean is the same as the log-fold change in this case).
df1 <- reportGroupMarkerStatistics(res$rna.markers, 1)
df1 <- df1[order(df1$auc.median, decreasing=TRUE),]
head(df1[,c("mean", "detected", "auc.median", "delta.mean.median")])

## -----------------------------------------------------------------------------
sce <- convertAnalyzeResults(res)
sce

## -----------------------------------------------------------------------------
counts <- assay(sce.z)
rna.qc.metrics <- computeRnaQcMetrics(counts, subsets=list(mt=is.mito), num.threads=nthreads)
rna.qc.thresholds <- suggestRnaQcThresholds(rna.qc.metrics)
rna.qc.filter <- filterRnaQcMetrics(rna.qc.thresholds, rna.qc.metrics)
filtered <- counts[,rna.qc.filter,drop=FALSE]

## -----------------------------------------------------------------------------
size.factors <- centerSizeFactors(rna.qc.metrics$sum[rna.qc.filter])
normalized <- normalizeCounts(filtered, size.factors)

## -----------------------------------------------------------------------------
gene.var <- modelGeneVariances(normalized, num.threads=nthreads)
top.hvgs <- chooseHighlyVariableGenes(gene.var$statistics$residuals)
pca <- runPca(normalized[top.hvgs,], num.threads=nthreads)

## -----------------------------------------------------------------------------
umap.out <- runUmap(pca$components, num.threads=nthreads)
tsne.out <- runTsne(pca$components, num.threads=nthreads)
snn.graph <- buildSnnGraph(pca$components, num.threads=nthreads)
clust.out <- clusterGraph(snn.graph)

## -----------------------------------------------------------------------------
markers <- scoreMarkers(normalized, groups=clust.out$membership, num.threads=nthreads)

## -----------------------------------------------------------------------------
sce.t <- TasicBrainData()
common <- intersect(rownames(sce.z), rownames(sce.t))
combined <- cbind(assay(sce.t)[common,], assay(sce.z)[common,])
block <- rep(c("tasic", "zeisel"), c(ncol(sce.t), ncol(sce.z)))

## -----------------------------------------------------------------------------
# No mitochondrial genes in the combined set, so we'll just skip it.
blocked_res <- analyze(combined, block=block, num.threads=nthreads)

# Visually check whether the datasets were suitably merged together.
# Note that these two datasets don't have the same cell types, so
# complete overlap should not be expected.
plot(blocked_res$tsne[,1], blocked_res$tsne[,2], pch=16, col=factor(blocked_res$block))

## -----------------------------------------------------------------------------
library(scrapper)
rna.qc.metrics <- computeRnaQcMetrics(combined, subsets=list(), num.threads=nthreads)
rna.qc.thresholds <- suggestRnaQcThresholds(rna.qc.metrics, block=block)
rna.qc.filter <- filterRnaQcMetrics(rna.qc.thresholds, rna.qc.metrics, block=block)

filtered <- combined[,rna.qc.filter,drop=FALSE]
filtered.block <- block[rna.qc.filter]
size.factors <- centerSizeFactors(rna.qc.metrics$sum[rna.qc.filter], block=filtered.block)
normalized <- normalizeCounts(filtered, size.factors)

gene.var <- modelGeneVariances(normalized, num.threads=nthreads, block=filtered.block)
top.hvgs <- chooseHighlyVariableGenes(gene.var$statistics$residuals)
pca <- runPca(normalized[top.hvgs,], num.threads=nthreads, block=filtered.block)

# Now we do a MNN correction to get rid of the batch effect.
corrected <- correctMnn(pca$components, block=filtered.block, num.threads=nthreads)

umap.out <- runUmap(corrected$corrected, num.threads=nthreads)
tsne.out <- runTsne(corrected$corrected, num.threads=nthreads)
snn.graph <- buildSnnGraph(corrected$corrected, num.threads=nthreads)
clust.out <- clusterGraph(snn.graph)

markers <- scoreMarkers(normalized, groups=clust.out$membership, block=filtered.block, num.threads=nthreads)

## -----------------------------------------------------------------------------
aggregates <- aggregateAcrossCells(filtered, list(cluster=clust.out$membership, dataset=filtered.block))

## -----------------------------------------------------------------------------
sce.s <- StoeckiusHashingData(mode=c("human", "adt1", "adt2"))
sce.s <- sce.s[,1:5000]
sce.s

## -----------------------------------------------------------------------------
rna.counts <- assay(sce.s)
adt.counts <- rbind(assay(altExp(sce.s, "adt1")), assay(altExp(sce.s, "adt2")))

## -----------------------------------------------------------------------------
is.mito <- grepl("^MT-", rownames(rna.counts))
is.igg <- grepl("^IgG", rownames(adt.counts))
multi_res <- analyze(
    rna.counts,
    adt.x=adt.counts,
    rna.subsets=list(mito=is.mito),
    adt.subsets=list(igg=is.igg),
    num.threads=nthreads
)

## -----------------------------------------------------------------------------
# QC in both modalities, only keeping the cells that pass in both.
library(scrapper)
rna.qc.metrics <- computeRnaQcMetrics(rna.counts, subsets=list(MT=is.mito), num.threads=nthreads)
rna.qc.thresholds <- suggestRnaQcThresholds(rna.qc.metrics)
rna.qc.filter <- filterRnaQcMetrics(rna.qc.thresholds, rna.qc.metrics)

adt.qc.metrics <- computeAdtQcMetrics(adt.counts, subsets=list(IgG=is.igg), num.threads=nthreads)
adt.qc.thresholds <- suggestAdtQcThresholds(adt.qc.metrics)
adt.qc.filter <- filterAdtQcMetrics(adt.qc.thresholds, adt.qc.metrics)

keep <- rna.qc.filter & adt.qc.filter
rna.filtered <- rna.counts[,keep,drop=FALSE]
adt.filtered <- adt.counts[,keep,drop=FALSE]

rna.size.factors <- centerSizeFactors(rna.qc.metrics$sum[keep])
rna.normalized <- normalizeCounts(rna.filtered, rna.size.factors)

adt.size.factors <- computeClrm1Factors(adt.filtered, num.threads=nthreads)
adt.size.factors <- centerSizeFactors(adt.size.factors)
adt.normalized <- normalizeCounts(adt.filtered, adt.size.factors)

gene.var <- modelGeneVariances(rna.normalized, num.threads=nthreads)
top.hvgs <- chooseHighlyVariableGenes(gene.var$statistics$residuals)
rna.pca <- runPca(rna.normalized[top.hvgs,], num.threads=nthreads)

# Combining the RNA-derived PCs with ADT expression. Here, there's very few ADT
# tags so there's no need for further dimensionality reduction.
combined <- scaleByNeighbors(list(rna.pca$components, as.matrix(adt.normalized)), num.threads=nthreads)

umap.out <- runUmap(combined$combined, num.threads=nthreads)
tsne.out <- runTsne(combined$combined, num.threads=nthreads)
snn.graph <- buildSnnGraph(combined$combined, num.threads=nthreads)
clust.out <- clusterGraph(snn.graph)

rna.markers <- scoreMarkers(rna.normalized, groups=clust.out$membership, num.threads=nthreads)
adt.markers <- scoreMarkers(adt.normalized, groups=clust.out$membership, num.threads=nthreads)

## -----------------------------------------------------------------------------
sessionInfo()

