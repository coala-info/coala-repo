# Code example from 'tomoda' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
Sys.setlocale("LC_TIME", "English")
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message=FALSE-----------------------------------------------------
library(SummarizedExperiment)
library(tomoda)

## -----------------------------------------------------------------------------
data(zh.data)
head(zh.data)

## -----------------------------------------------------------------------------
zh <- createTomo(zh.data)
zh

## -----------------------------------------------------------------------------
head(assay(zh, 'scaled'), 2)

## -----------------------------------------------------------------------------
corHeatmap(zh, max.cor=0.3)

## -----------------------------------------------------------------------------
zh <- runPCA(zh)
embedPlot(zh, method="PCA")
head(colData(zh))

## -----------------------------------------------------------------------------
set.seed(1)
zh <- runTSNE(zh)
embedPlot(zh, method="TSNE")
zh <- runUMAP(zh)
embedPlot(zh, method="UMAP")

## -----------------------------------------------------------------------------
hc_zh <- hierarchClust(zh)
plot(hc_zh)

## -----------------------------------------------------------------------------
zh <- kmeansClust(zh, centers=3)
head(colData(zh))
embedPlot(zh, group='kmeans_cluster')

## -----------------------------------------------------------------------------
peak_genes <- findPeakGene(zh, threshold = 1, length = 4, nperm = 1e5)
head(peak_genes)

## -----------------------------------------------------------------------------
expHeatmap(zh, peak_genes$gene, size=0)

## -----------------------------------------------------------------------------
geneCorHeatmap(zh, peak_genes, size=0)
# Use variable 'start' to group genes
geneCorHeatmap(zh, peak_genes, group='start', size=0)

## -----------------------------------------------------------------------------
zh <- runTSNE(zh, peak_genes$gene)
geneEmbedPlot(zh, peak_genes)

zh <- runUMAP(zh, peak_genes$gene)
geneEmbedPlot(zh, peak_genes, method="UMAP")

## -----------------------------------------------------------------------------
linePlot(zh, peak_genes$gene[1:3])

## -----------------------------------------------------------------------------
linePlot(zh, peak_genes$gene[1:3], span=0)

## -----------------------------------------------------------------------------
linePlot(zh, peak_genes$gene[1:3], facet=TRUE)

## -----------------------------------------------------------------------------
library(ggplot2)
exp_heat <- expHeatmap(zh, peak_genes$gene, size=0)
exp_heat + scale_fill_gradient2(low='magenta', mid='black', high='yellow')

## -----------------------------------------------------------------------------
line <- linePlot(zh, peak_genes$gene[1:3])
line + 
  theme_classic() + 
  scale_x_discrete(breaks=paste('X', seq(5,40,5), sep=''), labels=seq(5,40,5))

## -----------------------------------------------------------------------------
sessionInfo()

