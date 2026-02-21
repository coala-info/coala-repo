# Code example from 'my-vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, eval=FALSE--------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("EasyCellType")

## ----results=FALSE, warning=FALSE, message=FALSE------------------------------
library(devtools)
install_github("rx-li/EasyCellType")

## ----results=FALSE, warning=FALSE, message=FALSE------------------------------
library(EasyCellType)

## ----results=FALSE, warning=FALSE, message=FALSE------------------------------
data(pbmc_data)

## ----results=FALSE, warning=FALSE, message=FALSE------------------------------
library(Seurat)
# Initialize the Seurat object
pbmc <- CreateSeuratObject(counts = pbmc_data, project = "pbmc3k", min.cells = 3, min.features = 200)
# QC and select samples
pbmc[["percent.mt"]] <- PercentageFeatureSet(pbmc, pattern = "^MT-")
pbmc <- subset(pbmc, subset = nFeature_RNA > 200 & nFeature_RNA < 2500 & percent.mt < 5)
# Normalize the data
pbmc <- NormalizeData(pbmc)
# Identify highly variable features
pbmc <- FindVariableFeatures(pbmc, selection.method = "vst", nfeatures = 2000)
# Scale the data
all.genes <- rownames(pbmc)
pbmc <- ScaleData(pbmc, features = all.genes)
# Perfom linear dimensional reduction
pbmc <- RunPCA(pbmc, features = VariableFeatures(object = pbmc))
# Cluster the cells
pbmc <- FindNeighbors(pbmc, dims = 1:10)
pbmc <- FindClusters(pbmc, resolution = 0.5)
# Find differentially expressed features
markers <- FindAllMarkers(pbmc, only.pos = TRUE, min.pct = 0.25, logfc.threshold = 0.25)

## ----results=FALSE, warning=FALSE, message=FALSE------------------------------
library(org.Hs.eg.db)
library(AnnotationDbi)
markers$entrezid <- mapIds(org.Hs.eg.db,
                           keys=markers$gene, #Column containing Ensembl gene ids
                           column="ENTREZID",
                           keytype="SYMBOL",
                           multiVals="first")
markers <- na.omit(markers)

## ----results=FALSE, warning=FALSE, message=FALSE------------------------------
library(dplyr)
markers_sort <- data.frame(gene=markers$entrezid, cluster=markers$cluster, 
                      score=markers$avg_log2FC) %>% 
  group_by(cluster) %>% 
  mutate(rank = rank(score),  ties.method = "random") %>% 
  arrange(desc(rank)) 
input.d <- as.data.frame(markers_sort[, 1:3])

## ----results=FALSE, warning=FALSE, message=FALSE------------------------------
data("gene_pbmc")
input.d <- gene_pbmc

## ----results=FALSE, warning=FALSE, message=FALSE------------------------------
annot.GSEA <- easyct(input.d, db="cellmarker", species="Human", 
                    tissue=c("Blood", "Peripheral blood", "Blood vessel",
                      "Umbilical cord blood", "Venous blood"), p_cut=0.3,
                    test="GSEA")

## ----results=FALSE, warning=FALSE, message=FALSE------------------------------
plot_dot(test="GSEA", annot.GSEA)

## ----results=FALSE, warning=FALSE, message=FALSE, fig.show='hide'-------------
plot_bar(test="GSEA", annot.GSEA)

## -----------------------------------------------------------------------------
sessionInfo()

