# Introduction to netSmooth package

Jonathan Ronen1 and Altuna Akalin1

1Berlin Institute for Medical Systems Biology, Max Delbrück Center

#### 2025-10-30

# 1 Introduction

*netSmooth* implements a network-smoothing framework to smooth
single-cell gene expression data as well as other omics datasets.
The algorithm is a graph based diffusion process on networks. The
intuition behind the algorithm is that gene networks encoding
coexpression patterns may be used to smooth scRNA-seq expression
data, since the gene expression values of connected nodes in the
network will be predictive of each other. Protein-protein interaction
(PPI) networks and coexpression networks are among the networks that
could be used for such procedure.

More precisely, *netSmooth* works as follows. First, the gene
expression values or other quantitative values per gene from each
sample is projected on to the provided network. Then, the diffusion
process is used to smooth the expression values of adjacent
genes in the graph, so that a genes expression value
represent an estimate of expression levels based the gene it self,
as well as the expression
values of the neighbors in the graph. The rate at which expression
values of genes diffuse to their neighbors is degree-normalized, so
that genes with many edges will affect their neighbors less than
genes with more specific interactions. The implementation has one
free parameter, `alpha`, which controls if the diffusion will be
local or will reach further in the graph. Higher the value, the
further the diffusion will reach. The *netSmooth* package
implements strategies to optimize the value of `alpha`.

![Network-smoothing concept](data:image/png;base64...)

Figure 1: Network-smoothing concept

In summary, *netSmooth* enables users to smooth quantitative values
associated with genes using a gene interaction network such as a
protein-protein interaction network. The following sections of this
vignette demonstrate functionality of `netSmooth` package.

# 2 Smoothing single-cell gene expression data with netSmooth() function

The workhorse of the *netSmooth* package is the `netSmooth()`
function. This function takes at least two arguments,
a network and genes-by-samples matrix as input, and performs
smoothing on genes-by-samples matrix. The network should be
organized
as an adjacency matrix and its row and column names should match
the row names of genes-by-samples matrix.

We will demonstrate the usage of the `netSmooth()` function using
a subset of human PPI and a subset of single-cell RNA-seq data from
GSE44183-GPL11154. We will first load the example datasets that are available
through *netSmooth* package.

```
data(smallPPI)
data(smallscRNAseq)
```

We can now smooth the gene expression network now with `netSmooth()` function.
We will use `alpha=0.5`.

```
smallscRNAseq.sm.se <- netSmooth(smallscRNAseq, smallPPI, alpha=0.5)
```

```
## Using given alpha: 0.5
```

```
smallscRNAseq.sm.sce <- SingleCellExperiment(
    assays=list(counts=assay(smallscRNAseq.sm.se)),
    colData=colData(smallscRNAseq.sm.se)
)
```

Now, we can look at the smoothed and raw expression values using
a heatmap.

```
anno.df <- data.frame(cell.type=colData(smallscRNAseq)$source_name_ch1)
rownames(anno.df) <- colnames(smallscRNAseq)
pheatmap(log2(assay(smallscRNAseq)+1), annotation_col = anno.df,
         show_rownames = FALSE, show_colnames = FALSE,
         main="before netSmooth")
```

![](data:image/png;base64...)

```
pheatmap(log2(assay(smallscRNAseq.sm.sce)+1), annotation_col = anno.df,
         show_rownames = FALSE, show_colnames = FALSE,
         main="after netSmooth")
```

![](data:image/png;base64...)

## 2.1 Optimizing the smoothing parameter `alpha`

By default, the parameter `alpha` will be optimized using a robust
clustering statistic. Briefly, this approach will try different
clustering algorithms and/or parameters and find clusters that can be reproduced
with different algorithms. The `netSmooth()` function will try different `alpha`
values controlled by additional arguments to maximize the number of samples in
robust clusters.

Now, we smooth the expression values using automated alpha optimization and plot
the heatmaps of raw and smooth versions.

```
smallscRNAseq.sm.se <- netSmooth(smallscRNAseq, smallPPI, alpha='auto')
smallscRNAseq.sm.sce <- SingleCellExperiment(
    assays=list(counts=assay(smallscRNAseq.sm.se)),
    colData=colData(smallscRNAseq.sm.se)
)

pheatmap(log2(assay(smallscRNAseq.sm.sce)+1), annotation_col = anno.df,
         show_rownames = FALSE, show_colnames = FALSE,
         main="after netSmooth (optimal alpha)")
```

# 3 Getting robust clusters from data

There is no standard method especially for clustering single cell RNAseq data,
as different studies produce data with different topologies, which respond
differently to the various clustering algorithms. In order to avoid optimizing
different clustering routines for the different datasets, we have implemented a
robust clustering routine based on [clusterExperiment](https://www.bioconductor.org/packages/3.6/bioc/html/clusterExperiment.html "clusterExperiment").
The *clusterExperiment* framework for robust clustering is based on consensus
clustering of clustering assignments obtained from different views of the data
and different clustering algorithms. The different views are different reduced
dimensionality projections of the data based on different techniques; thus, no
single clustering result will dominate the data, and only cluster structures
which are robust to different analyses will prevail. We implemented a clustering
framework using the components of *clusterExperiment* and different
dimensionality reduction methods.

We can directly use the robust clustering function `robustClusters`.

```
yhat <- robustClusters(smallscRNAseq, makeConsensusMinSize=2, makeConsensusProportion=.9)$clusters
```

```
## Picked dimReduceFlavor: tsne
```

```
## 6 parameter combinations, 0 use sequential method, 0 use subsampling method
## Running Clustering on Parameter Combinations...
## done.
```

```
## Note: Merging will be done on ' makeConsensus ', with clustering index 1
```

```
yhat.sm <- robustClusters(smallscRNAseq.sm.se, makeConsensusMinSize=2, makeConsensusProportion=.9)$clusters
```

```
## Picked dimReduceFlavor: pca
```

```
## 6 parameter combinations, 0 use sequential method, 0 use subsampling method
## Running Clustering on Parameter Combinations...
## done.
```

```
## Warning in (function (A, nv = 5, nu = nv, maxit = 1000, work = nv + 7, reorth =
## TRUE, : You're computing too large a percentage of total singular values, use a
## standard svd instead.
```

```
## Note: Merging will be done on ' makeConsensus ', with clustering index 1
```

```
cell.types <- colData(smallscRNAseq)$source_name_ch1
knitr::kable(
  table(cell.types, yhat), caption = 'Cell types and `robustClusters` in the raw data.'
)
```

Table 1: Cell types and `robustClusters` in the raw data.

|  | -1 | 1 | 2 |
| --- | --- | --- | --- |
| 2-cell blastomere | 0 | 3 | 0 |
| 4-cell blastomere | 1 | 3 | 0 |
| 8-cell blastomere | 6 | 0 | 4 |
| 8-cell embryo | 1 | 0 | 0 |
| morula | 0 | 0 | 3 |
| oocyte | 0 | 3 | 0 |
| pronucleus | 0 | 3 | 0 |
| zygote | 0 | 2 | 0 |

```
knitr::kable(
  table(cell.types, yhat.sm), caption = 'Cell types and `robustClusters` in the smoothed data.'
)
```

Table 1: Cell types and `robustClusters` in the smoothed data.

|  | -1 | 1 | 2 | 3 | 4 |
| --- | --- | --- | --- | --- | --- |
| 2-cell blastomere | 1 | 0 | 2 | 0 | 0 |
| 4-cell blastomere | 3 | 0 | 1 | 0 | 0 |
| 8-cell blastomere | 6 | 0 | 0 | 2 | 2 |
| 8-cell embryo | 1 | 0 | 0 | 0 | 0 |
| morula | 0 | 3 | 0 | 0 | 0 |
| oocyte | 0 | 0 | 3 | 0 | 0 |
| pronucleus | 0 | 0 | 3 | 0 | 0 |
| zygote | 0 | 0 | 2 | 0 | 0 |

A cluster assignment of `-1` indicates that the cell could not be placed in a robust cluster, and has consequently been omitted. We see that the clusters are completely uninformative in the raw data, while the smoothed data at least permitted the `robustClusters` procedure to identify a subset of the 8-cell blastomeres as a separate cluster.

# 4 Deciding for the best dimension reduction method for visualization and clustering

The `robustClusters()` function works by clustering samples in a lower dimension
embedding using either PCA or t-SNE. Different single cell datasets might respond
better to different dimensionality reduction techniques. In order to pick the
right technique algorithmically, we compute the entropy in a 2D embedding. We
obtained 2D embeddings from the 500 most variable genes using either PCA or
t-SNE, binned them in a 20x20 grid, and computed the entropy. The entropy in the
2D embedding is a measure for the information captured by it. We pick the
embedding with the highest information content. `pickDimReduction()` function
implements this
strategy and returns the best embedding according to this strategy.

Below, we pick the best embedding for our example dataset and plot scatter plots
for different 2D embedding methods.

```
smallscRNAseq <- runPCA(smallscRNAseq, ncomponents=2)
smallscRNAseq <- runTSNE(smallscRNAseq, ncomponents=2)
smallscRNAseq <- runUMAP(smallscRNAseq, ncomponents=2)

plotPCA(smallscRNAseq, colour_by='source_name_ch1') + ggtitle("PCA plot")
```

![](data:image/png;base64...)

```
plotTSNE(smallscRNAseq, colour_by='source_name_ch1') + ggtitle("tSNE plot")
```

![](data:image/png;base64...)

```
plotUMAP(smallscRNAseq, colour_by='source_name_ch1') + ggtitle("UMAP plot")
```

![](data:image/png;base64...)

The `pickDimReduction` method picks the dimensionality reduction method which
produces the highest entropy embedding:

```
pickDimReduction(smallscRNAseq)
```

```
## [1] "tsne"
```

# 5 Frequently asked questions

### 5.0.1 How can I make smoothing faster ?

Make sure you compile R with openBLAS or variants that are faster.

### 5.0.2 What happens if all the genes are not in my network ?

The smoothing will only be done using the genes in the network then
unsmoothed genes will be attached to the gene expression matrix.

---

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
##  [1] pheatmap_1.0.13             netSmooth_1.30.0
##  [3] clusterExperiment_2.30.0    bigmemory_4.6.4
##  [5] scater_1.38.0               ggplot2_4.0.0
##  [7] scuttle_1.20.0              SingleCellExperiment_1.32.0
##  [9] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [11] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [13] IRanges_2.44.0              S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3   jsonlite_2.0.0       magrittr_2.0.4
##   [4] magick_2.9.0         ggbeeswarm_0.7.2     farver_2.1.2
##   [7] rmarkdown_2.30       vctrs_0.6.5          locfdr_1.1-8
##  [10] memoise_2.0.1        tinytex_0.57         htmltools_0.5.8.1
##  [13] S4Arrays_1.10.0      progress_1.2.3       BiocNeighbors_2.4.0
##  [16] Rhdf5lib_1.32.0      rhdf5_2.54.0         SparseArray_1.10.0
##  [19] sass_0.4.10          bslib_0.9.0          plyr_1.8.9
##  [22] cachem_1.1.0         uuid_1.2-1           lifecycle_1.0.4
##  [25] iterators_1.0.14     pkgconfig_2.0.3      rsvd_1.0.5
##  [28] Matrix_1.7-4         R6_2.6.1             fastmap_1.2.0
##  [31] digest_0.6.37        colorspace_2.1-2     AnnotationDbi_1.72.0
##  [34] phylobase_0.8.12     irlba_2.3.5.1        RSQLite_2.4.3
##  [37] beachmat_2.26.0      labeling_0.4.3       httr_1.4.7
##  [40] abind_1.4-8          compiler_4.5.1       rngtools_1.5.2
##  [43] bit64_4.6.0-1        withr_3.0.2          doParallel_1.0.17
##  [46] S7_0.2.0             BiocParallel_1.44.0  viridis_0.6.5
##  [49] DBI_1.2.3            HDF5Array_1.38.0     MASS_7.3-65
##  [52] MAST_1.36.0          DelayedArray_0.36.0  zinbwave_1.32.0
##  [55] tools_4.5.1          vipor_0.4.7          rncl_0.8.7
##  [58] beeswarm_0.4.0       ape_5.8-1            glue_1.8.0
##  [61] h5mread_1.2.0        rhdf5filters_1.22.0  nlme_3.1-168
##  [64] grid_4.5.1           Rtsne_0.17           gridBase_0.4-7
##  [67] cluster_2.1.8.1      reshape2_1.4.4       ade4_1.7-23
##  [70] gtable_0.3.6         tidyr_1.3.1          data.table_1.17.8
##  [73] hms_1.1.4            BiocSingular_1.26.0  ScaledMatrix_1.18.0
##  [76] xml2_1.4.1           XVector_0.50.0       ggrepel_0.9.6
##  [79] foreach_1.5.2        pillar_1.11.1        stringr_1.5.2
##  [82] limma_3.66.0         genefilter_1.92.0    softImpute_1.4-3
##  [85] splines_4.5.1        dplyr_1.1.4          lattice_0.22-7
##  [88] FNN_1.1.4.1          survival_3.8-3       bit_4.6.0
##  [91] annotate_1.88.0      tidyselect_1.2.1     registry_0.5-1
##  [94] locfit_1.5-9.12      Biostrings_2.78.0    knitr_1.50
##  [97] bigmemory.sri_0.1.8  gridExtra_2.3        bookdown_0.45
## [100] edgeR_4.8.0          xfun_0.53            statmod_1.5.1
## [103] NMF_0.28             stringi_1.8.7        yaml_2.3.10
## [106] evaluate_1.0.5       codetools_0.2-20     kernlab_0.9-33
## [109] entropy_1.3.2        tibble_3.3.0         BiocManager_1.30.26
## [112] cli_3.6.5            uwot_0.2.3           xtable_1.8-4
## [115] jquerylib_0.1.4      dichromat_2.0-0.1    Rcpp_1.1.0
## [118] png_0.1-8            XML_3.99-0.19        parallel_4.5.1
## [121] RNeXML_2.4.11        blob_1.2.4           prettyunits_1.2.0
## [124] viridisLite_0.4.2    scales_1.4.0         purrr_1.1.0
## [127] crayon_1.5.3         rlang_1.1.6          cowplot_1.2.0
## [130] KEGGREST_1.50.0
```