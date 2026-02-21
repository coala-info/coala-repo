# Code example from 'ILoReg' vignette. See references/ for full tutorial.

## ----knitr-options, echo=FALSE, message=FALSE, warning=FALSE------------------
library(knitr)
opts_chunk$set(fig.align = 'center', fig.width = 6, fig.height = 5)

## ----eval = FALSE-------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("ILoReg")

## -----------------------------------------------------------------------------
suppressMessages(library(ILoReg))
suppressMessages(library(SingleCellExperiment))
suppressMessages(library(cowplot))
# The dataset was normalized using the LogNormalize method from the Seurat R package.
sce <- SingleCellExperiment(assays = list(logcounts = pbmc3k_500))
sce <- PrepareILoReg(sce)

## ----eval = TRUE--------------------------------------------------------------
# ICP is stochastic. To obtain reproducible results, use set.seed().
set.seed(1)
# Run ICP L times. This is  the slowest step of the workflow, 
# and parallel processing can be used to greatly speed it up.
sce <- RunParallelICP(object = sce, k = 15,
                      d = 0.3, L = 30, 
                      r = 5, C = 0.3, 
                      reg.type = "L1", threads = 0)

## -----------------------------------------------------------------------------
# p = number of principal components
sce <- RunPCA(sce,p=50,scale = FALSE)

## ----fig.height=5, fig.width=7, out.width = '100%',fig.align = "center"-------
PCAElbowPlot(sce)

## -----------------------------------------------------------------------------
sce <- RunUMAP(sce)
sce <- RunTSNE(sce,perplexity=30)

## ----fig.height=5, fig.width=7.2, out.width = '100%'--------------------------
GeneScatterPlot(sce,c("CD3D","CD79A","CST3","FCER1A"),
                dim.reduction.type = "umap",
                point.size = 0.3)
GeneScatterPlot(sce,c("CD3D","CD79A","CST3","FCER1A"),
                dim.reduction.type = "tsne",
                point.size = 0.3)


## -----------------------------------------------------------------------------
sce <- HierarchicalClustering(sce)

## -----------------------------------------------------------------------------
# Extract K=13 clusters.
sce <- SelectKClusters(sce,K=13)

## ----FigUMAP_TSNE, echo=TRUE, fig.height=10, fig.width=6, out.width = '100%'----
# Use plot_grid function from the cowplot R package to combine the two plots into one.
plot_grid(ClusteringScatterPlot(sce,
                                dim.reduction.type = "umap",
                                return.plot = TRUE,
                                title = "UMAP",
                                show.legend=FALSE),
          ClusteringScatterPlot(sce,
                                dim.reduction.type = "tsne",
                                return.plot = TRUE
                                ,title="t-SNE",
                                show.legend=FALSE),
          ncol = 1
)


## ----eval = TRUE--------------------------------------------------------------

gene_markers <- FindAllGeneMarkers(sce,
                                   clustering.type = "manual",
                                   test = "wilcox",
                                   log2fc.threshold = 0.25,
                                   min.pct = 0.25,
                                   min.diff.pct = NULL,
                                   min.cells.group = 3,
                                   return.thresh = 0.01,
                                   only.pos = TRUE,
                                   max.cells.per.cluster = NULL)


## ----eval = TRUE--------------------------------------------------------------
top10_log2FC <- SelectTopGenes(gene_markers,
                               top.N = 10,
                               criterion.type = "log2FC",
                               inverse = FALSE)
top1_log2FC <- SelectTopGenes(gene_markers,
                              top.N = 1,
                              criterion.type = "log2FC",
                              inverse = FALSE)
top10_adj.p.value <- SelectTopGenes(gene_markers,
                                    top.N = 10,
                                    criterion.type = "adj.p.value",
                                    inverse = TRUE)
top1_adj.p.value <- SelectTopGenes(gene_markers,
                                   top.N = 1,
                                   criterion.type = "adj.p.value",
                                   inverse = TRUE)

## ----FigTop1Scatter, echo=TRUE, fig.height=21, fig.width=8, out.width = '100%', eval = TRUE----
GeneScatterPlot(sce,
                genes = unique(top1_log2FC$gene),
                dim.reduction.type = "tsne",
                point.size = 0.5,ncol=2)

## ----FigHM1, echo=TRUE, fig.height=15, fig.width=15, out.width = '100%', eval = FALSE----
# GeneHeatmap(sce,
#             clustering.type = "manual",
#             gene.markers = top10_log2FC)
# 

## -----------------------------------------------------------------------------
sce <- RenameAllClusters(sce,
                         new.cluster.names = c("GZMK+/CD8+ T cells",
                                               "IGKC+ B cells",
                                               "Naive CD4+ T cells",
                                               "NK cells",
                                               "CD16+ monocytes",
                                               "CD8+ T cells",
                                               "CD14+ monocytes",
                                               "IGLC+ B cells",
                                               "Intermediate monocytes",
                                               "IGKC+/IGLC+ B cells",
                                               "Memory CD4+ T cells",
                                               "Naive CD8+ T cells",
                                               "Dendritic cells"))

## ----FigHM2, echo=TRUE, fig.height=15, fig.width=15, out.width = '100%', eval = TRUE----
GeneHeatmap(sce,gene.markers = top10_log2FC)


## ----FigVlnPlot, echo=TRUE, fig.height=5, fig.width=8, out.width = '100%'-----
# Visualize CD3D: a marker of T cells
VlnPlot(sce,genes = c("CD3D"),return.plot = FALSE,rotate.x.axis.labels = TRUE)

## ----fig.height=5, fig.width=7, out.width = '100%',fig.align = "center"-------
sce <- CalcSilhInfo(sce,K.start = 2,K.end = 50)
SilhouetteCurve(sce,return.plot = FALSE)

## ----FigRenaming2, echo=TRUE, fig.height=10, fig.width=12, out.width = '100%',eval = TRUE----
sce <- SelectKClusters(sce,K=20)
# Rename cluster 1 as A
sce <- RenameCluster(sce,old.cluster.name = 1,new.cluster.name = "A")

## ----FigAnnotation, echo=TRUE, fig.height=5, fig.width=6, out.width = '100%',fig.align = "center",eval = TRUE----
# Select a clustering with K=5 clusters
sce <- SelectKClusters(sce,K=5)
# Generate a custom annotation with K=5 clusters and change the names to the five first alphabets.
custom_annotation <- plyr::mapvalues(metadata(sce)$iloreg$clustering.manual,c(1,2,3,4,5),LETTERS[1:5])
# Visualize the annotation
AnnotationScatterPlot(sce,
                      annotation = custom_annotation,
                      return.plot = FALSE,
                      dim.reduction.type = "tsne",
                      show.legend = FALSE)

## ----eval = TRUE--------------------------------------------------------------
# Merge clusters 3 and 4
sce <- SelectKClusters(sce,K=20)
sce <- MergeClusters(sce,clusters.to.merge  = c(3,4))

## ----eval = TRUE--------------------------------------------------------------
sce <- SelectKClusters(sce,K=13)
sce <- RenameAllClusters(sce,
                         new.cluster.names = c("GZMK+/CD8+ T cells",
                                               "IGKC+ B cells",
                                               "Naive CD4+ T cells",
                                               "NK cells",
                                               "CD16+ monocytes",
                                               "CD8+ T cells",
                                               "CD14+ monocytes",
                                               "IGLC+ B cells",
                                               "Intermediate monocytes",
                                               "IGKC+/IGLC+ B cells",
                                               "Memory CD4+ T cells",
                                               "Naive CD8+ T cells",
                                               "Dendritic cells"))
# Identify DE genes between naive and memory CD4+ T cells
GM_naive_memory_CD4 <- FindGeneMarkers(sce,
                                       clusters.1 = "Naive CD4+ T cells",
                                       clusters.2 = "Memory CD4+ T cells",
                                       logfc.threshold = 0.25,
                                       min.pct = 0.25,
                                       return.thresh = 0.01,
                                       only.pos = TRUE)


# Find gene markers for dendritic cells
GM_dendritic <- FindGeneMarkers(sce,
                                clusters.1 = "Dendritic cells",
                                logfc.threshold = 0.25,
                                min.pct = 0.25,
                                return.thresh = 0.01,
                                only.pos = TRUE)


## ----eval = TRUE--------------------------------------------------------------
sessionInfo()

