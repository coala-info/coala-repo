# Code example from 'condcomp' vignette. See references/ for full tutorial.

## ----setup, include=FALSE--------------------------------------------------
knitr::opts_chunk$set(
    collapse=TRUE,
    comment="#>"
)

## ----install, eval=FALSE---------------------------------------------------
#  BiocManager::install("condcomp")

## ----load_data, results='hide', message=FALSE------------------------------
library(condcomp)
library(monocle)
library(HSMMSingleCell)
library(Seurat)

# Load the dataset
hsmm <- load_HSMM()
# Encapsulate data in a Seurat object
hsmm <- exportCDS(hsmm, export_to = "Seurat")
# Set ident to 'Hours'
hsmm <- SetAllIdent(hsmm, id = "Hours")
# Subset the Seurat object to have cells only from 24 and 48 hours
hsmm <- SubsetData(hsmm, ident.use = c("24", "48"))
# Stores this ident as a 'Condition' column in 'meta.data'
hsmm <- StashIdent(hsmm, save.name = "Condition")

## ----cluster, results='hide'-----------------------------------------------
hsmm <- FindVariableGenes(hsmm, do.plot = FALSE)
hsmm <- RunPCA(hsmm)

hsmm <- FindClusters(hsmm, reduction.type = "pca", dims.use = 1:5,
                resolution = 2)
hsmm <- StashIdent(hsmm, save.name = "Cluster")
hsmm <- RunTSNE(hsmm, reduction.use = "pca", dims.use = 1:5, do.fast = TRUE,
                perplexity = 15)
TSNEPlot(hsmm, group.by = "Condition", do.return = TRUE, pt.size = 0.5)
TSNEPlot(hsmm, do.return = TRUE, pt.size = 0.5, do.label = TRUE,
                label.size = 5)

## ----cluster_cond_barplot, fig.width=6, fig.height=4-----------------------
hsmm <- SetAllIdent(hsmm, "Cluster")
counts <- as.data.frame(table(hsmm@meta.data$Condition, hsmm@ident))
names(counts) <- c("Condition", "Cluster", "Cells")
ggplot(data = counts, aes(x = Cluster, y = Cells, fill = Condition)) +
    geom_bar(stat="identity", position = position_dodge()) +
    geom_text(aes(label = Cells), vjust = 1.6, color = "black",
                position = position_dodge(0.9), size = 2.5)

## ----condcomp, message=FALSE-----------------------------------------------
# Computes the euclidean distance matrix
dmatrix <- dist(
    GetDimReduction(hsmm, reduction.type = "pca", slot = "cell.embeddings"),
    method = "euclidean")
dmatrix <- as.matrix(dmatrix)
hsmm <- SetAllIdent(hsmm, "Cluster")
ccomp <- condcomp(hsmm@ident, hsmm@meta.data$Condition, dmatrix, n = 1000)
# It is pertinent to compute the adjusted p-value, given the computation method
# (see the manual for 'condcomp')
ccomp$pval_adj <- p.adjust(ccomp$pval, method = "bonferroni")
knitr::kable(ccomp)

## ----condcomp_plot, fig.width=5, fig.height=4------------------------------
condcompPlot(ccomp, main = "Intra-cluster heterogeneity between conditions")

