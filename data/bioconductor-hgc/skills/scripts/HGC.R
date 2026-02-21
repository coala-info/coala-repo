# Code example from 'HGC' vignette. See references/ for full tutorial.

## ----knitr-options, echo=FALSE, message=FALSE, warning=FALSE------------------
library(knitr)
opts_chunk$set(fig.align = 'center', 
                fig.width = 4.5, fig.height = 3, dev = 'png')

## ----Bioconductor install, eval = FALSE---------------------------------------
# if (!requireNamespace("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("HGC")

## ----Github install, eval = FALSE---------------------------------------------
# if(!require(devtools))
#     install.packages("devtools")
# devtools::install_github("XuegongLab/HGC")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(HGC)

data(Pollen)
Pollen.PCs <- Pollen[["PCs"]]
Pollen.Label.Tissue <- Pollen[["Tissue"]]
Pollen.Label.CellLine <- Pollen[["CellLine"]]

dim(Pollen.PCs)
table(Pollen.Label.Tissue)
table(Pollen.Label.CellLine)

## -----------------------------------------------------------------------------
Pollen.SNN <- SNN.Construction(mat = Pollen.PCs, k = 25, threshold = 0.15)
Pollen.ClusteringTree <- HGC.dendrogram(G = Pollen.SNN)

## -----------------------------------------------------------------------------
cluster.k5 <- cutree(Pollen.ClusteringTree, k = 5)

## ----eval = FALSE-------------------------------------------------------------
# library(dplyr)
# library(Seurat)
# library(patchwork)
# library(HGC)
# 
# # Load the PBMC dataset
# pbmc.data <- Read10X(data.dir =
#                 "../data/pbmc3k/filtered_gene_bc_matrices/hg19/")
# # Initialize the Seurat object with the raw (non-normalized data).
# pbmc <- CreateSeuratObject(counts = pbmc.data, project = "pbmc3k",
#                             min.cells = 3, min.features = 200)
# 
# # QC and selecting cells for further analysis
# pbmc[["percent.mt"]] <- PercentageFeatureSet(pbmc, pattern = "^MT-")
# pbmc <- subset(pbmc, subset = nFeature_RNA > 200 &
#                 nFeature_RNA < 2500 & percent.mt < 5)
# 
# # Normalizing the data
# pbmc <- NormalizeData(pbmc, normalization.method = "LogNormalize",
#                         scale.factor = 10000)
# 
# # Identification of highly variable features (feature selection)
# pbmc <- FindVariableFeatures(pbmc, selection.method = "vst",
#                                 nfeatures = 2000)
# 
# # Scaling the data
# all.genes <- rownames(pbmc)
# pbmc <- ScaleData(pbmc, features = all.genes)
# 
# # Perform linear dimensional reduction
# pbmc <- RunPCA(pbmc, features = VariableFeatures(object = pbmc))
# 
# # Determine the ‘dimensionality’ of the dataset
# pbmc <- JackStraw(pbmc, num.replicate = 100)
# pbmc <- ScoreJackStraw(pbmc, dims = 1:20)
# 
# # Construct the graph and cluster the cells with HGC
# pbmc <- FindNeighbors(pbmc, dims = 1:10)
# pbmc <- FindClusteringTree(pbmc, graph.type = "SNN")
# 
# # Output the tree
# pbmc.tree <- pbmc@graphs$ClusteringTree

## ----eval = FALSE-------------------------------------------------------------
# # Setting up the data
# library(scRNAseq)
# sce <- GrunPancreasData()
# 
# library(scuttle)
# qcstats <- perCellQCMetrics(sce)
# qcfilter <- quickPerCellQC(qcstats,
#                             percent_subsets="altexps_ERCC_percent")
# sce <- sce[,!qcfilter$discard]
# 
# library(scran)
# clusters <- quickCluster(sce)
# sce <- computeSumFactors(sce, clusters=clusters)
# sce <- logNormCounts(sce)
# 
# # Variance modelling
# dec <- modelGeneVar(sce)
# plot(dec$mean, dec$total, xlab="Mean log-expression",
#         ylab="Variance")
# curve(metadata(dec)$trend(x), col="blue", add=TRUE)
# 
# # Get the top 10% of genes.
# top.hvgs <- getTopHVGs(dec, prop=0.1)
# 
# sce <- fixedPCA(sce, subset.row=top.hvgs)
# reducedDimNames(sce)
# 
# # Automated PC choice
# output <- getClusteredPCs(reducedDim(sce))
# npcs <- metadata(output)$chosen
# reducedDim(sce, "PCAsub") <-
#     reducedDim(sce, "PCA")[,1:npcs,drop=FALSE]
# 
# 
# library(HGC)
# # Graph construction
# g <- buildSNNGraph(sce, use.dimred="PCAsub")
# # Graph-based clustering
# cluster.tree <- HGC.dendrogram(G = g)
# cluster.k12 <- cutree(cluster.tree, k = 12)
# 
# colLabels(sce) <- factor(cluster.k12)
# 
# library(scater)
# sce <- runTSNE(sce, dimred="PCAsub")
# plotTSNE(sce, colour_by="label", text_by="label")

## ----fig.height = 4.5---------------------------------------------------------
Pollen.ClusteringTree$height = log(Pollen.ClusteringTree$height + 1)
Pollen.ClusteringTree$height = log(Pollen.ClusteringTree$height + 1)

HGC.PlotDendrogram(tree = Pollen.ClusteringTree,
                    k = 5, plot.label = FALSE)

## ----fig.height = 4.5---------------------------------------------------------
Pollen.labels <- data.frame(Tissue = Pollen.Label.Tissue,
                            CellLine = Pollen.Label.CellLine)
HGC.PlotDendrogram(tree = Pollen.ClusteringTree,
                    k = 5, plot.label = TRUE, 
                    labels = Pollen.labels)

## -----------------------------------------------------------------------------
ARI.mat <- HGC.PlotARIs(tree = Pollen.ClusteringTree,
                        labels = Pollen.labels)

## -----------------------------------------------------------------------------
Pollen.ParameterRecord <- HGC.parameter(G = Pollen.SNN)

HGC.PlotParameter(Pollen.ParameterRecord, parameter = "CL")
HGC.PlotParameter(Pollen.ParameterRecord, parameter = "ANN")

