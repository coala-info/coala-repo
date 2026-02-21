# Using concordex in to assess cluster boundaries in scRNA-seq

Lambda Moses, Kayla Jackson

#### Oct 29, 2025

# 1 Introduction

UMAP is commonly used in scRNA-seq data analysis as a visualization tool
projecting high dimensional data onto 2 dimensions to visualize cell clustering.
However, UMAP is prone to showing spurious clustering and distorting distances
(Chari, Banerjee, and Pachter [2021](#ref-Chari2021-hb)). Moreover, UMAP shows clustering that seems to correspond to
graph-based clusters from Louvain and Leiden because the k nearest neighbor
graph is used in both clustering and UMAP. We have developed `concordex` as a
quantitative alternative to UMAP cluster visualization without the misleading
problems of UMAP. This package is the R implementation of the original Python
command line tool.

In a nutshell, `concordex` finds the proportion of cells among the k-nearest
neighbors of each cell with the same cluster or label as the cell itself. This
is computed across all labels and the average of all labels is returned as a
metric that indicates the quality of clustering. If the clustering separates cells
well, then the observed similarity matrix should be diagonal dominant.

```
library(concordexR)
library(TENxPBMCData)
library(BiocNeighbors)
library(bluster)
library(scater)
library(patchwork)
library(ggplot2)
theme_set(theme_bw())
```

# 2 Preprocessing

In this vignette, we demonstrate the usage of `concordex` on a human peripheral
blood mononuclear cells (PBMC) scRNA-seq dataset from 10X Genomics. The data is
loaded as a `SingleCellExperiment` object.

```
sce <- TENxPBMCData("pbmc3k")
#> see ?TENxPBMCData and browseVignettes('TENxPBMCData') for documentation
#> loading from cache
```

Here we plot the standard QC metrics: total number of UMIs detected per cell
(`nCounts`), number of genes detected (`nGenes`), and percentage of UMIs from
mitochondrially encoded genes (`pct_mito`).

```
sce$nCounts <- colSums(counts(sce))
sce$nGenes <- colSums(counts(sce) > 0)
mito_inds <- grepl("^MT-", rowData(sce)$Symbol_TENx)
sce$pct_mito <- colSums(counts(sce)[mito_inds,])/sce$nCounts * 100
```

```
plotColData(sce, "nCounts") +
  plotColData(sce, "nGenes") +
  plotColData(sce, "pct_mito")
```

![](data:image/png;base64...)

```
p1 <- plotColData(sce, x = "nCounts", y = "nGenes") +
  geom_density2d()
p2 <- plotColData(sce, x = "nCounts", y = "pct_mito") +
  geom_density2d()

p1 + p2
```

![](data:image/png;base64...)

Remove the outliers and cells with high percentage of mitochondrial counts as
the high percentage is not expected biologically from the cell type:

```
sce <- sce[, sce$nCounts < 10000 & sce$pct_mito < 8]
sce <- sce[rowSums(counts(sce)) > 0,]
```

Then normalize the data:

```
sce <- logNormCounts(sce)
```

# 3 Graph based clustering in PCA space

For simplicity, the top 500 highly variable genes are used to perform PCA:

```
sce <- runPCA(sce, ncomponents = 30, ntop = 500, scale = TRUE)
```

See the number of PCs to use later from the elbow plot:

```
plot(attr(reducedDim(sce, "PCA"), "percentVar"), ylab = "Percentage of variance explained")
```

![](data:image/png;base64...)

Percentage of variance explained drops sharply from PC1 to PC5, and definitely
levels off after PC10, so we use the top 10 PCs for clustering here. The graph
based Leiden clustering uses a k nearest neighbor graph. For demonstration here,
we use `k = 10`.

```
set.seed(29)
sce$cluster <- clusterRows(reducedDim(sce, "PCA")[,seq_len(10)],
                           NNGraphParam(k = 10, cluster.fun = "leiden",
                                        cluster.args = list(
                                          objective_function = "modularity"
                                        )))
```

See what the clusters look like in PCA space:

```
plotPCA(sce, color_by = "cluster", ncomponents = 4)
#> Warning in data.frame(gg1$all, df_to_plot[, -reddim_cols]): row names were
#> found from a short variable and have been discarded
```

![](data:image/png;base64...)

Some of the clusters seem well-separated along the first 4 PCs.

Since UMAP is commonly used to visualize the clusters, we plot UMAP here
although we don’t recommend UMAP because it’s prone to showing spurious clusters
and distorting distances. UMAP also uses a k nearest neighbor graph, and we use
the same `k = 10` here:

```
sce <- runUMAP(sce, dimred = "PCA", n_dimred = 10, n_neighbors = 10)
```

```
plotUMAP(sce, color_by = "cluster")
```

![](data:image/png;base64...)

For the most part, the clusters are clearly separated on UMAP.

# 4 Enter `concordex`

Since UMAP is prone to showing spurious clusters, we’ll see what the `concordex`
metric says about the clustering and whether it agrees with UMAP visualization.
Here we explicitly obtain the k nearest neighbor graph, as clustering and UMAP
above did not store the graph itself.

```
g <- findKNN(reducedDim(sce, "PCA")[,seq_len(10)], k = 10)
```

The result here is a list of two `n` (number of cell) by `k` matrices. The first
is the indices of each cell’s neighbors, as in an adjacency list that can be
matrix here due to the fixed number of neighbors, and the second is the
distances between each cell and its neighbors. For `concordex`, only the first
matrix is relevant. An adjacency matrix, either sparse of dense, as stored in
the `Seurat` object, can also be used. Here the cluster labels are permuted 100
times.

```
res <- calculateConcordex(
    sce,
    labels="cluster",
    use.dimred="PCA",
    compute_similarity=TRUE
)
```

Here the argument `compute_similarity` indicates that we concordex will return
the cluster-cluster similarity matrix. The entries in this matrix itself represent
the proportion of cells with each label in the neighborhood of other cells with the
same label.

```
sim <- res[["SIMILARITY"]]

round(sim, 2)
#>      1    2    3    4    5    6    7    8
#> 1 0.80 0.00 0.00 0.00 0.03 0.00 0.18 0.00
#> 2 0.01 0.98 0.00 0.00 0.00 0.00 0.00 0.00
#> 3 0.00 0.00 0.97 0.00 0.00 0.03 0.00 0.00
#> 4 0.00 0.00 0.00 0.94 0.06 0.00 0.00 0.00
#> 5 0.15 0.00 0.00 0.02 0.76 0.00 0.07 0.00
#> 6 0.00 0.00 0.07 0.00 0.00 0.93 0.00 0.00
#> 7 0.12 0.00 0.00 0.00 0.00 0.00 0.88 0.00
#> 8 0.00 0.00 0.28 0.29 0.00 0.08 0.00 0.33
```

# 5 Session info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] patchwork_1.3.2             scater_1.38.0
#>  [3] ggplot2_4.0.0               scuttle_1.20.0
#>  [5] bluster_1.20.0              BiocNeighbors_2.4.0
#>  [7] TENxPBMCData_1.27.0         HDF5Array_1.38.0
#>  [9] h5mread_1.2.0               rhdf5_2.54.0
#> [11] DelayedArray_0.36.0         SparseArray_1.10.0
#> [13] S4Arrays_1.10.0             abind_1.4-8
#> [15] Matrix_1.7-4                SingleCellExperiment_1.32.0
#> [17] SummarizedExperiment_1.40.0 Biobase_2.70.0
#> [19] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [21] IRanges_2.44.0              S4Vectors_0.48.0
#> [23] BiocGenerics_0.56.0         generics_0.1.4
#> [25] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [27] concordexR_1.10.0           BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] DBI_1.2.3                gridExtra_2.3            httr2_1.2.1
#>  [4] rlang_1.1.6              magrittr_2.0.4           compiler_4.5.1
#>  [7] RSQLite_2.4.3            png_0.1-8                vctrs_0.6.5
#> [10] pkgconfig_2.0.3          SpatialExperiment_1.20.0 crayon_1.5.3
#> [13] fastmap_1.2.0            dbplyr_2.5.1             magick_2.9.0
#> [16] XVector_0.50.0           labeling_0.4.3           rmarkdown_2.30
#> [19] ggbeeswarm_0.7.2         tinytex_0.57             purrr_1.1.0
#> [22] bit_4.6.0                xfun_0.53                cachem_1.1.0
#> [25] beachmat_2.26.0          jsonlite_2.0.0           blob_1.2.4
#> [28] rhdf5filters_1.22.0      Rhdf5lib_1.32.0          BiocParallel_1.44.0
#> [31] irlba_2.3.5.1            parallel_4.5.1           cluster_2.1.8.1
#> [34] R6_2.6.1                 bslib_0.9.0              RColorBrewer_1.1-3
#> [37] jquerylib_0.1.4          Rcpp_1.1.0               bookdown_0.45
#> [40] knitr_1.50               FNN_1.1.4.1              igraph_2.2.1
#> [43] tidyselect_1.2.1         viridis_0.6.5            dichromat_2.0-0.1
#> [46] yaml_2.3.10              codetools_0.2-20         curl_7.0.0
#> [49] lattice_0.22-7           tibble_3.3.0             withr_3.0.2
#> [52] KEGGREST_1.50.0          S7_0.2.0                 evaluate_1.0.5
#> [55] isoband_0.2.7            BiocFileCache_3.0.0      ExperimentHub_3.0.0
#> [58] Biostrings_2.78.0        pillar_1.11.1            BiocManager_1.30.26
#> [61] filelock_1.0.3           BiocVersion_3.22.0       sparseMatrixStats_1.22.0
#> [64] scales_1.4.0             glue_1.8.0               tools_4.5.1
#> [67] AnnotationHub_4.0.0      ScaledMatrix_1.18.0      cowplot_1.2.0
#> [70] grid_4.5.1               AnnotationDbi_1.72.0     beeswarm_0.4.0
#> [73] BiocSingular_1.26.0      vipor_0.4.7              rsvd_1.0.5
#> [76] cli_3.6.5                rappdirs_0.3.3           viridisLite_0.4.2
#> [79] dplyr_1.1.4              uwot_0.2.3               gtable_0.3.6
#> [82] sass_0.4.10              digest_0.6.37            ggrepel_0.9.6
#> [85] rjson_0.2.23             farver_2.1.2             memoise_2.0.1
#> [88] htmltools_0.5.8.1        lifecycle_1.0.4          httr_1.4.7
#> [91] MASS_7.3-65              bit64_4.6.0-1
```

# References

Chari, Tara, Joeyta Banerjee, and Lior Pachter. 2021. “The Specious Art of Single-Cell Genomics.” *bioRxiv*.