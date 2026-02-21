# ILoReg package manual

Johannes Smolander

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Example: Peripheral Blood Mononuclear Cells](#example-peripheral-blood-mononuclear-cells)
  + [3.1 Setup a SingleCellExperiment object and prepare it for ILoReg analysis](#setup-a-singlecellexperiment-object-and-prepare-it-for-iloreg-analysis)
  + [3.2 Run the ICP clustering algorithm \(L\) times](#run-the-icp-clustering-algorithm-l-times)
  + [3.3 PCA transformation of the joint probability matrix](#pca-transformation-of-the-joint-probability-matrix)
  + [3.4 Nonlinear dimensionality reduction](#nonlinear-dimensionality-reduction)
  + [3.5 Gene expression visualization](#gene-expression-visualization)
  + [3.6 Hierarchical clustering using the Ward’s method](#hierarchical-clustering-using-the-wards-method)
  + [3.7 Extracting a consensus clustering with \(K\) clusters](#extracting-a-consensus-clustering-with-k-clusters)
  + [3.8 Identification of gene markers](#identification-of-gene-markers)
  + [3.9 Selecting top gene markers](#selecting-top-gene-markers)
  + [3.10 Gene marker heatmap](#gene-marker-heatmap)
  + [3.11 Renaming clusters](#renaming-clusters)
  + [3.12 Violin plot visualization](#violin-plot-visualization)
* [4 Additional functionality](#additional-functionality)
  + [4.1 Estimating the optimal number of clusters](#estimating-the-optimal-number-of-clusters)
  + [4.2 Renaming one cluster](#renaming-one-cluster)
  + [4.3 Visualize with a custom annotation](#visualize-with-a-custom-annotation)
  + [4.4 Merging clusters](#merging-clusters)
  + [4.5 Identification of differentially expressed genes between two arbitrary sets of clusters](#identification-of-differentially-expressed-genes-between-two-arbitrary-sets-of-clusters)
  + [4.6 Session info](#session-info)
* [5 References](#references)
* **Appendix**
* [A Contact information](#contact-information)

# 1 Introduction

`ILoReg` is a tool for cell population identification from single-cell RNA-seq (scRNA-seq) data. In our paper [1], we showed that `ILoReg` was able to identify, by both unsupervised clustering and visually, rare cell populations that other scRNA-seq data analysis pipelines were unable to identify.

The figure below illustrates the workflows of `ILoReg` and a typical pipeline that applies feature selection prior to dimensionality reduction by principal component analysis (PCA).

![](data:image/png;base64...)

*Figure: Workflows of `ILoReg` and a feature-selection based approach.*

In contrast to most scRNA-seq data analysis pipelines, `ILoReg` does not reduce the dimensionality of the gene expression matrix by feature selection. Instead, it performs probabilistic feature extraction using **iterative clustering projection (ICP)**, generating an \(N \times k\) -dimensional probability matrix, which contains probabilities of each of the \(N\) cells belonging to the \(k\) clusters. ICP is a novel self-supervised learning algorithm that iteratively seeks a clustering with \(k\) clusters that maximizes the adjusted Rand index (ARI) between the clustering \(C\) and its projection \(C'\) by L1-regularized logistic regression. In the ILoReg consensus approach, ICP is run \(L\) times and the \(L\) probability matrices are merged into a joint probability matrix and subsequently transformed by principal component analysis (PCA) into a lower dimensional (\(N \times p\)) matrix (consensus matrix). The final clustering step is performed using hierarhical clustering by the Ward’s method, after which the user can extract a clustering with \(K\) consensus clusters. However, the user can also use any other clustering method at this point. Two-dimensional visualization is supported using two popular nonlinear dimensionality reduction methods: *t*-distributed stochastic neighbor embedding (t-SNE) and uniform manifold approximation and projection (UMAP). Additionally, ILoReg provides user-friendly functions that enable identification of differentially expressed (DE) genes and visualization of gene expression.

# 2 Installation

`ILoReg` can be downloaded from Bioconductor and installed by executing the following command in the R console.

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ILoReg")
```

# 3 Example: Peripheral Blood Mononuclear Cells

In the following, we go through the different steps of `ILoReg`’s workflow and demonstrate it using a peripheral blood mononuclear cell (PBMC) dataset. The toy dataset included in the `ILoReg` R package (`pbmc3k_500`) contains 500 cells that have been downsampled from the pbmc3k dataset [2]. The preprocessing was rerun with a newer reference genome (GRCh38.p12) and Cell Ranger v2.2.0 [3] to identify different immunoglobulin subpopulations in B-cells.

## 3.1 Setup a SingleCellExperiment object and prepare it for ILoReg analysis

The only required input for `ILoReg` is a log-transformed, normalized gene expression matrix that has been, with genes/features in rows and cells/samples in columns. The input can be of `matrix`, `data.frame` or `dgCMatrix` class, which is then transformed into a sparse object of `dgCMatrix` class. Please note that the method has been designed to work with **sparse data**, i.e. with a high proportion of zero values. If, for example, the features of your dataset have been standardized, the run time and the memory usage of `ILoReg` will likely be much higher.

```
suppressMessages(library(ILoReg))
```

```
## Warning: replacing previous import 'Matrix::det' by 'SparseM::det' when loading
## 'ILoReg'
```

```
suppressMessages(library(SingleCellExperiment))
suppressMessages(library(cowplot))
# The dataset was normalized using the LogNormalize method from the Seurat R package.
sce <- SingleCellExperiment(assays = list(logcounts = pbmc3k_500))
sce <- PrepareILoReg(sce)
```

```
## Data in `logcounts` slot already of `dgCMatrix` class...
```

```
## 13865/13865 genes remain after filtering genes with only zero values.
```

## 3.2 Run the ICP clustering algorithm \(L\) times

Running ICP \(L\) times in parallel is the most computationally demanding part of the workflow.

In the following, we give a brief summary of the parameters.

* \(k\): The number of initial clusters in ICP (default \(15\)). Along with decreasing \(d\), increasing \(k\) increases the resolution of the outcome, i.e. more sub-populations with subtle differences are identifiable in the result.
* \(d\): A real number greater than \(0\) and smaller than \(1\) that determines how many cells \(n\) are down- or oversampled from each cluster into the training data (\(n= \lceil Nd/k \rceil\)), where \(N\) is the total number of cells (default \(0.3\)). Decreasing \(d\) below \(0.2\) is not recommended due to the increased risk of ICP becoming unstable (\(k\) starts to decrease during the iteration). By contrast, increasing \(d\) above 0.3 will generate more dissimilar ICP runs, which will decrease the resolution of the result.
* \(C\): A positive real number that rules the trade-off between correct classification and regularization in L1-regularized logistic regression: \[\displaystyle \min\_w {\Vert w \Vert}\_1 + C \sum\_{i=1}^{n} \log (1+ e^{-y\_i w^T w})\] with the default value being \(0.3\). Decreasing \(C\) increases the stringency of the L1-regularized feature selection, i.e. less genes are selected into the logistic regression model. With a lower \(C\) the outcome will be determined by fewer genes.
* \(r\): A positive integer that denotes the maximum number of reiterations performed until the ICP algorithm stops (default \(500\)).
* \(L\): The number of ICP runs. The default is \(200\), which should be generally used in all situations. For the toy dataset used in this example \(L=30\) is enough.
* \(reg.type\): “L1” or “L2”. “L2” denotes L2-regularization (ridge regression). The default is “L1” (lasso regresssion).
* \(threads\): The number of threads to use in parallel computing. The default is \(0\): use all available threads but one. The parallelization can be disabled with \(threads=1\).
* \(icp.batch.size\): The batch size, i.e. how many cells to use in ICP. The default is \(Inf\): use all cells from the data set. A smaller number decreases the run time. This is an experimental feature and has not been validated properly.

As general guidelines on how to adjust the parameters, we recommend leaving \(r\) and \(L\) to their defaults (\(r=5\) and \(L=200\)). However, increasing \(k\) from 15 to e.g. 30 can reveal new cell subsets that are of interest. Regarding \(d\), increasing it to somewhere between 0.4-0.6 helps if the user wants lower resolution (less distinguishable populations). Increasing \(C\) from 0.3 to 1 reduces the number of distinguishable populations, as the logistic regression model filters out fewer genes.

```
# ICP is stochastic. To obtain reproducible results, use set.seed().
set.seed(1)
# Run ICP L times. This is  the slowest step of the workflow,
# and parallel processing can be used to greatly speed it up.
sce <- RunParallelICP(object = sce, k = 15,
                      d = 0.3, L = 30,
                      r = 5, C = 0.3,
                      reg.type = "L1", threads = 0)
```

```
##
  |
  |                                                                      |   0%
  |
  |==                                                                    |   3%
  |
  |=====                                                                 |   7%
  |
  |=======                                                               |  10%
  |
  |==========                                                            |  14%
  |
  |============                                                          |  17%
  |
  |==============                                                        |  21%
  |
  |=================                                                     |  24%
  |
  |===================                                                   |  28%
  |
  |======================                                                |  31%
  |
  |========================                                              |  34%
  |
  |===========================                                           |  38%
  |
  |=============================                                         |  41%
  |
  |===============================                                       |  45%
  |
  |==================================                                    |  48%
  |
  |====================================                                  |  52%
  |
  |=======================================                               |  55%
  |
  |=========================================                             |  59%
  |
  |===========================================                           |  62%
  |
  |==============================================                        |  66%
  |
  |================================================                      |  69%
  |
  |===================================================                   |  72%
  |
  |=====================================================                 |  76%
  |
  |========================================================              |  79%
  |
  |==========================================================            |  83%
  |
  |============================================================          |  86%
  |
  |===============================================================       |  90%
  |
  |=================================================================     |  93%
  |
  |====================================================================  |  97%
  |
  |======================================================================| 100%
```

## 3.3 PCA transformation of the joint probability matrix

The \(L\) probability matrices are merged into a joint probability matrix, which is then transformed into a lower dimensionality by PCA. Before applying PCA, the user can optionally scale the cluster probabilities to unit-variance.

```
# p = number of principal components
sce <- RunPCA(sce,p=50,scale = FALSE)
```

**Optional**: PCA requires the user to specify the number of principal components, for which we selected the default value \(p=50\). To aid in decision making, the elbow plot is commonly used to seek an elbow point, of which proximity the user selects \(p\). In this case the point would be close to \(p=10\). Trying both a \(p\) that is close to the elbow point and the default \(p=50\) is recommended.

```
PCAElbowPlot(sce)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the ILoReg package.
##   Please report the issue at <https://github.com/elolab/ILoReg/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

## 3.4 Nonlinear dimensionality reduction

To visualize the data in two-dimensional space, nonlinear dimensionality reduction is performed using t-SNE or UMAP. The input data for this step is the \(N \times p\) -dimensional consensus matrix.

```
sce <- RunUMAP(sce)
sce <- RunTSNE(sce,perplexity=30)
```

## 3.5 Gene expression visualization

Visualize the t-SNE and UMAP transformations using the `GeneScatterPlot` function, highlighting expression levels of *CD3D* (T cells), *CD79A* (B cells), *CST3* (monocytes, dendritic cells, platelets), *FCER1A* (myeloid dendritic cells).

```
GeneScatterPlot(sce,c("CD3D","CD79A","CST3","FCER1A"),
                dim.reduction.type = "umap",
                point.size = 0.3)
```

![](data:image/png;base64...)

```
GeneScatterPlot(sce,c("CD3D","CD79A","CST3","FCER1A"),
                dim.reduction.type = "tsne",
                point.size = 0.3)
```

![](data:image/png;base64...)

## 3.6 Hierarchical clustering using the Ward’s method

The \(N \times p\) -dimensional consensus matrix is hierarchically clustered using the Ward’s method.

```
sce <- HierarchicalClustering(sce)
```

## 3.7 Extracting a consensus clustering with \(K\) clusters

After the hierarchical clustering, the user needs to define how many consensus clusters (\(K\)) to extract from the tree dendrogram. The `SelectKClusters` function enables extracting a consensus clustering with \(K\) clusters. Please note that the clustering is **overwritten** every time the function is called.

```
# Extract K=13 clusters.
sce <- SelectKClusters(sce,K=13)
```

Next, we use the `ClusteringScatterPlot` function to draw the t-SNE and UMAP transformations and color each cell according to the cluster labels.

```
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
```

![](data:image/png;base64...)

## 3.8 Identification of gene markers

The`ILoReg` R package provides functions for the identification of gene markers of clusters. This is accomplished by DE analysis, where gene expression levels of the cells from each cluster are compared against the rest of the cells. Currently, the only supported statistical test is the the Wilcoxon rank-sum test (aka Mann-Whitney U test). The *p*-values are corrected for multiple comparisons using the Bonferroni method. To accelerate the analysis, genes that are less likely to be DE can be filtered out prior to the statistical testing using multiple criteria.

```
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
```

```
## -----------------------------------
## testing cluster 1
## 885 genes left after min.pct filtering
## 885 genes left after min.diff.pct filtering
## 230 genes left after log2fc.threshold filtering
## -----------------------------------
## -----------------------------------
## testing cluster 2
## 873 genes left after min.pct filtering
## 873 genes left after min.diff.pct filtering
## 350 genes left after log2fc.threshold filtering
## -----------------------------------
## -----------------------------------
## testing cluster 3
## 858 genes left after min.pct filtering
## 858 genes left after min.diff.pct filtering
## 313 genes left after log2fc.threshold filtering
## -----------------------------------
## -----------------------------------
## testing cluster 4
## 973 genes left after min.pct filtering
## 973 genes left after min.diff.pct filtering
## 543 genes left after log2fc.threshold filtering
## -----------------------------------
## -----------------------------------
## testing cluster 5
## 1366 genes left after min.pct filtering
## 1366 genes left after min.diff.pct filtering
## 782 genes left after log2fc.threshold filtering
## -----------------------------------
## -----------------------------------
## testing cluster 6
## 1005 genes left after min.pct filtering
## 1005 genes left after min.diff.pct filtering
## 485 genes left after log2fc.threshold filtering
## -----------------------------------
## -----------------------------------
## testing cluster 7
## 993 genes left after min.pct filtering
## 993 genes left after min.diff.pct filtering
## 519 genes left after log2fc.threshold filtering
## -----------------------------------
## -----------------------------------
## testing cluster 8
## 918 genes left after min.pct filtering
## 918 genes left after min.diff.pct filtering
## 452 genes left after log2fc.threshold filtering
## -----------------------------------
## -----------------------------------
## testing cluster 9
## 1180 genes left after min.pct filtering
## 1180 genes left after min.diff.pct filtering
## 622 genes left after log2fc.threshold filtering
## -----------------------------------
## -----------------------------------
## testing cluster 10
## 1069 genes left after min.pct filtering
## 1069 genes left after min.diff.pct filtering
## 481 genes left after log2fc.threshold filtering
## -----------------------------------
## -----------------------------------
## testing cluster 11
## 948 genes left after min.pct filtering
## 948 genes left after min.diff.pct filtering
## 223 genes left after log2fc.threshold filtering
## -----------------------------------
## -----------------------------------
## testing cluster 12
## 879 genes left after min.pct filtering
## 879 genes left after min.diff.pct filtering
## 336 genes left after log2fc.threshold filtering
## -----------------------------------
## -----------------------------------
## testing cluster 13
## 1654 genes left after min.pct filtering
## 1654 genes left after min.diff.pct filtering
## 931 genes left after log2fc.threshold filtering
## -----------------------------------
```

## 3.9 Selecting top gene markers

Select top 10 and 1 gene markers based on the log2 fold-change and the Bonferroni adjusted p-value.

```
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
```

Draw the t-SNE and UMAP transformations, highlighting expression levels of the top 1 gene markers based on the log2 fold-change.

```
GeneScatterPlot(sce,
                genes = unique(top1_log2FC$gene),
                dim.reduction.type = "tsne",
                point.size = 0.5,ncol=2)
```

![](data:image/png;base64...)

## 3.10 Gene marker heatmap

`GeneHeatmap` function enables visualizing gene markers in a heatmap,
where cells and genes are grouped by the clustering.

```
GeneHeatmap(sce,
            clustering.type = "manual",
            gene.markers = top10_log2FC)
```

## 3.11 Renaming clusters

`RenameAllClusters` enables renaming all clusters at once.

```
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
```

Draw the gene heatmap again, but with the clusters renamed.

```
GeneHeatmap(sce,gene.markers = top10_log2FC)
```

![](data:image/png;base64...)

## 3.12 Violin plot visualization

`VlnPlot` enables visualization of gene expression with cells grouped by clustering.

```
# Visualize CD3D: a marker of T cells
VlnPlot(sce,genes = c("CD3D"),return.plot = FALSE,rotate.x.axis.labels = TRUE)
```

![](data:image/png;base64...)

# 4 Additional functionality

`ILoReg` provides additional functionality for performing tasks, which are sometimes required in scRNA-seq data analysis.

## 4.1 Estimating the optimal number of clusters

The optimal number of clusters can be estimated by calculating the average silhouette value across the cells for a set of clusterings within a range of different \(K\) values (e.g. \([2,50]\)). The clustering mathing to the highest average silhouette is saved to `clustering.optimal` slot. Therefore, the clustering acquired using the
`SelectKClusters` function is not overwritten.

```
sce <- CalcSilhInfo(sce,K.start = 2,K.end = 50)
```

```
## optimal K: 5, average silhouette score: 0.418375297485223
```

```
SilhouetteCurve(sce,return.plot = FALSE)
```

![](data:image/png;base64...)

## 4.2 Renaming one cluster

```
sce <- SelectKClusters(sce,K=20)
# Rename cluster 1 as A
sce <- RenameCluster(sce,old.cluster.name = 1,new.cluster.name = "A")
```

## 4.3 Visualize with a custom annotation

```
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
```

![](data:image/png;base64...)

## 4.4 Merging clusters

```
# Merge clusters 3 and 4
sce <- SelectKClusters(sce,K=20)
sce <- MergeClusters(sce,clusters.to.merge  = c(3,4))
```

## 4.5 Identification of differentially expressed genes between two arbitrary sets of clusters

```
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
```

```
## clustering.type='manual'testing cluster group.1
## 918 genes left after min.pct filtering
## 918 genes left after min.diff.pct filtering
## 242 genes left after logfc.threshold filtering
```

```
# Find gene markers for dendritic cells
GM_dendritic <- FindGeneMarkers(sce,
                                clusters.1 = "Dendritic cells",
                                logfc.threshold = 0.25,
                                min.pct = 0.25,
                                return.thresh = 0.01,
                                only.pos = TRUE)
```

```
## clustering.type='manual'testing cluster group.1
## 1654 genes left after min.pct filtering
## 1654 genes left after min.diff.pct filtering
## 931 genes left after logfc.threshold filtering
```

## 4.6 Session info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] cowplot_1.2.0               SingleCellExperiment_1.32.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] ILoReg_1.20.0               knitr_1.50
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] gridExtra_2.3         gld_2.6.8             readxl_1.4.5
##   [4] rlang_1.1.6           magrittr_2.0.4        e1071_1.7-16
##   [7] compiler_4.5.1        parallelDist_0.2.7    png_0.1-8
##  [10] reshape2_1.4.4        vctrs_0.6.5           stringr_1.5.2
##  [13] crayon_1.5.3          pkgconfig_2.0.3       fastmap_1.2.0
##  [16] magick_2.9.0          XVector_0.50.0        labeling_0.4.3
##  [19] rmarkdown_2.30        tzdb_0.5.0            haven_2.5.5
##  [22] tinytex_0.57          xfun_0.53             cachem_1.1.0
##  [25] jsonlite_2.0.0        DelayedArray_0.36.0   parallel_4.5.1
##  [28] aricode_1.0.3         cluster_2.1.8.1       DescTools_0.99.60
##  [31] R6_2.6.1              stringi_1.8.7         bslib_0.9.0
##  [34] RColorBrewer_1.1-3    reticulate_1.44.0     boot_1.3-32
##  [37] jquerylib_0.1.4       cellranger_1.1.0      Rcpp_1.1.0
##  [40] bookdown_0.45         iterators_1.0.14      snow_0.4-4
##  [43] readr_2.1.5           Matrix_1.7-4          tidyselect_1.2.1
##  [46] rstudioapi_0.17.1     dichromat_2.0-0.1     abind_1.4-8
##  [49] yaml_2.3.10           viridis_0.6.5         codetools_0.2-20
##  [52] doRNG_1.8.6.2         plyr_1.8.9            lattice_0.22-7
##  [55] tibble_3.3.0          withr_3.0.2           S7_0.2.0
##  [58] askpass_1.2.1         evaluate_1.0.5        Rtsne_0.17
##  [61] proxy_0.4-27          RcppParallel_5.1.11-1 pillar_1.11.1
##  [64] BiocManager_1.30.26   rngtools_1.5.2        foreach_1.5.2
##  [67] hms_1.1.4             ggplot2_4.0.0         scales_1.4.0
##  [70] rootSolve_1.8.2.4     class_7.3-23          glue_1.8.0
##  [73] pheatmap_1.0.13       lmom_3.2              LiblineaR_2.10-24
##  [76] tools_4.5.1           dendextend_1.19.1     data.table_1.17.8
##  [79] SparseM_1.84-2        RSpectra_0.16-2       forcats_1.0.1
##  [82] Exact_3.3             fs_1.6.6              mvtnorm_1.3-3
##  [85] fastcluster_1.3.0     grid_4.5.1            umap_0.2.10.0
##  [88] cli_3.6.5             expm_1.0-0            S4Arrays_1.10.0
##  [91] viridisLite_0.4.2     dplyr_1.1.4           doSNOW_1.0.20
##  [94] gtable_0.3.6          sass_0.4.10           digest_0.6.37
##  [97] SparseArray_1.10.0    farver_2.1.2          htmltools_0.5.8.1
## [100] lifecycle_1.0.4       httr_1.4.7            openssl_2.3.4
## [103] MASS_7.3-65
```

# 5 References

# Appendix

1. Johannes Smolander, Sini Junttila, Mikko S Venäläinen, Laura L Elo, ILoReg: a tool for high-resolution cell population identification from single-cell RNA-seq data, Bioinformatics, Volume 37, Issue 8, 15 April 2021, Pages 1107–1114, <https://doi.org/10.1093/bioinformatics/btaa919>
2. “3k PBMCs from a Healthy Donor”. [10X Genomics](https://support.10xgenomics.com/single-cell-gene-expression/datasets/1.1.0/pbmc3k).
3. “What is Cell Ranger?” [10X Genomics](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/what-is-cell-ranger).

# A Contact information

If you have questions related to `ILoReg`, please contact us [here](https://github.com/elolab/ILoReg).