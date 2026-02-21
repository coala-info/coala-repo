# Plotting single cell data with schex

#### Saskia Freytag

Reduced dimension plotting is one of the essential tools for the analysis of single cell data. However, as the number of cells/nuclei in these these plots increases, the usefulness of these plots decreases. Many cells are plotted on top of each other obscuring information, even when taking advantage of transparency settings. This package provides binning strategies of cells/nuclei into hexagon cells. Plotting summarized information of all cells/nuclei in their respective hexagon cells presents information without obstructions. The package seemlessly works with the two most common object classes for the storage of single cell data; `SingleCellExperiment` from the [SingleCellExperiment](https://bioconductor.org/packages/3.9/bioc/html/SingleCellExperiment.html) package and `Seurat` from the [Seurat](https://satijalab.org/seurat/) package.

## Load libraries

```
library(igraph)
library(schex)
library(TENxPBMCData)
library(scater)
library(scran)
library(ggrepel)
```

## Setup single cell data

In order to demonstrate the capabilities of the schex package, I will use the a dataset of Peripheral Blood Mononuclear Cells (PBMC) freely available from 10x Genomics. There are 2,700 single cells that were sequenced on the Illumina NextSeq 500. This data is handly availabe in the [`TENxPBMCData` package](http://bioconductor.org/packages/release/data/experiment/html/TENxPBMCData.html).

```
tenx_pbmc3k <- TENxPBMCData(dataset = "pbmc3k")
#> see ?TENxPBMCData and browseVignettes('TENxPBMCData') for documentation
#> loading from cache

rownames(tenx_pbmc3k) <- uniquifyFeatureNames(
    rowData(tenx_pbmc3k)$ENSEMBL_ID,
    rowData(tenx_pbmc3k)$Symbol_TENx
)
```

In the next few sections, I will perform some simple quality control steps including filtering and normalization. I will then calculate various dimension reductions and cluster the data. These steps do by no means constitute comprehensive handling of the data. For a more detailed guide the reader is referred to the following guides:

* [Luecken MD and Theis FJ; Current best practices in single‐cell RNA‐seq analysis: a tutorial; Molecular Systems Biology, 2019](https://www.embopress.org/doi/10.15252/msb.20188746)
* [Lun ATL, McCarthy DJ and Marioni JC; A step-by-step workflow for low-level analysis of single-cell RNA-seq data with Bioconductor; F1000 Research, 2016](https://f1000research.com/articles/5-2122)

### Filtering

I filter cells with high mitochondrial content as well as cells with low library size or feature count.

```
rowData(tenx_pbmc3k)$Mito <- grepl("^MT-", rownames(tenx_pbmc3k))
colData(tenx_pbmc3k) <- cbind(
    colData(tenx_pbmc3k),
    perCellQCMetrics(tenx_pbmc3k,
        subsets = list(Mt = rowData(tenx_pbmc3k)$Mito)
    )
)
rowData(tenx_pbmc3k) <- cbind(
    rowData(tenx_pbmc3k),
    perFeatureQCMetrics(tenx_pbmc3k)
)

tenx_pbmc3k <- tenx_pbmc3k[, !colData(tenx_pbmc3k)$subsets_Mt_percent > 50]

libsize_drop <- isOutlier(tenx_pbmc3k$total,
    nmads = 3, type = "lower", log = TRUE
)
feature_drop <- isOutlier(tenx_pbmc3k$detected,
    nmads = 3, type = "lower", log = TRUE
)

tenx_pbmc3k <- tenx_pbmc3k[, !(libsize_drop | feature_drop)]
```

I filter any genes that have 0 count for all cells.

```
rm_ind <- calculateAverage(tenx_pbmc3k) < 0
tenx_pbmc3k <- tenx_pbmc3k[!rm_ind, ]
```

### Normalization

I normalize the data by using a simple library size normalization.

```
tenx_pbmc3k <- scater::logNormCounts(tenx_pbmc3k)
```

### Dimension reduction

I use both Principal Components Analysis (PCA) and Uniform Manifold Approximation and Projection (UMAP) in order to obtain reduced dimension representations of the data. Since there is a random component in the UMAP, I will also set a seed.

```
tenx_pbmc3k <- runPCA(tenx_pbmc3k)
set.seed(10)
tenx_pbmc3k <- runUMAP(tenx_pbmc3k,
    dimred = "PCA", spread = 1,
    min_dist = 0.4
)
```

### Clustering

I will cluster the data on the PCA representation using Louvain clustering.

```
snn_gr <- buildSNNGraph(tenx_pbmc3k, use.dimred = "PCA", k = 50)
clusters <- cluster_louvain(snn_gr)
tenx_pbmc3k$cluster <- factor(clusters$membership)
```

## Plotting single cell data

At this stage in the workflow we usually would like to plot aspects of our data in one of the reduced dimension representations. Instead of plotting this in an ordinary fashion, I will demonstrate how schex can provide a better way of plotting this.

#### Calculate hexagon cell representation

First, I will calculate the hexagon cell representation for each cell for a specified dimension reduction representation. I decide to use `nbins=40` which specifies that I divide my x range into 40 bins. Note that this might be a parameter that you want to play around with depending on the number of cells/ nuclei in your dataset. Generally, for more cells/nuclei, `nbins` should be increased.

```
tenx_pbmc3k <- make_hexbin(tenx_pbmc3k,
    nbins = 40,
    dimension_reduction = "UMAP", use_dims = c(1, 2)
)
```

#### Plot number of cells/nuclei in each hexagon cell

First I plot how many cells are in each hexagon cell. This should be relatively even, otherwise change the `nbins` parameter in the previous calculation.

```
plot_hexbin_density(tenx_pbmc3k)
```

![](data:image/png;base64...)

#### Plot meta data in hexagon cell representation

Next I colour the hexagon cells by some meta information, such as the majority of cells cluster membership and the median total count in each hexagon cell.

```
plot_hexbin_meta(tenx_pbmc3k, col = "cluster", action = "majority")
```

![](data:image/png;base64...)

```
plot_hexbin_meta(tenx_pbmc3k, col = "total", action = "median")
```

![](data:image/png;base64...)

While for plotting the cluster membership the outcome is not too different from the classic plot, it is much easier to observe differences in the total count.

```
plotUMAP(tenx_pbmc3k, colour_by = "cluster")
```

![](data:image/png;base64...)

```
plotUMAP(tenx_pbmc3k, colour_by = "total")
```

![](data:image/png;base64...)

For convenience there is also a function that allows the calculation of label positions for factor variables. These can be overlayed with the package `ggrepel`.

```
label_df <- make_hexbin_label(tenx_pbmc3k, col = "cluster")
pp <- plot_hexbin_meta(tenx_pbmc3k, col = "cluster", action = "majority")
pp + ggrepel::geom_label_repel(
    data = label_df, aes(x = x, y = y, label = label),
    colour = "black", label.size = NA, fill = NA
)
```

![](data:image/png;base64...)

#### Plot gene expression in hexagon cell representation

Finally, I will visualize the gene expression of the POMGNT1 gene in the hexagon cell representation.

```
gene_id <- "POMGNT1"
plot_hexbin_feature(tenx_pbmc3k,
    type = "logcounts", feature = gene_id,
    action = "mean", xlab = "UMAP1", ylab = "UMAP2",
    title = paste0("Mean of ", gene_id)
)
```

![](data:image/png;base64...)

Again it is much easier to observe differences in gene expression using the hexagon cell representation than the classic representation.

```
plotUMAP(tenx_pbmc3k, by_exprs_values = "logcounts", colour_by = gene_id)
```

![](data:image/png;base64...)

We can overlay the gene expression data with the clusters for convenience.

```
plot_hexbin_feature_plus(tenx_pbmc3k,
    col = "cluster", type = "logcounts",
    feature = "POMGNT1", action = "mean"
)
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the schex package.
#>   Please report the issue at <https://github.com/SaskiaFreytag/schex/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

### Understanding `schex` output as `ggplot` objects

The `schex` packages renders ordinary `ggplot` objects and thus these can be treated and manipulated using the [`ggplot` grammar](https://ggplot2.tidyverse.org/). For example the non-data components of the plots can be changed using the function `theme`.

```
gene_id <- "CD19"
gg <- schex::plot_hexbin_feature(tenx_pbmc3k,
    type = "logcounts", feature = gene_id,
    action = "mean", xlab = "UMAP1", ylab = "UMAP2",
    title = paste0("Mean of ", gene_id)
)
gg + theme_void()
```

![](data:image/png;base64...)

The fact that `schex` renders `ggplot` objects can also be used to save these plots. Simply use `ggsave` in order to save any created plot.

```
ggsave(gg, file = "schex_plot.pdf")
```

To find the details of the session for reproducibility, use this:

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
#>  [1] ggrepel_0.9.6               scran_1.38.0
#>  [3] scater_1.38.0               scuttle_1.20.0
#>  [5] TENxPBMCData_1.27.0         HDF5Array_1.38.0
#>  [7] h5mread_1.2.0               rhdf5_2.54.0
#>  [9] DelayedArray_0.36.0         SparseArray_1.10.0
#> [11] S4Arrays_1.10.0             abind_1.4-8
#> [13] Matrix_1.7-4                igraph_2.2.1
#> [15] Seurat_5.3.1                SeuratObject_5.2.0
#> [17] sp_2.2-0                    dplyr_1.1.4
#> [19] schex_1.24.0                SingleCellExperiment_1.32.0
#> [21] SummarizedExperiment_1.40.0 Biobase_2.70.0
#> [23] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [25] IRanges_2.44.0              S4Vectors_0.48.0
#> [27] BiocGenerics_0.56.0         generics_0.1.4
#> [29] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [31] ggplot2_4.0.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RcppAnnoy_0.0.22       splines_4.5.1          later_1.4.4
#>   [4] filelock_1.0.3         tibble_3.3.0           polyclip_1.10-7
#>   [7] fastDummies_1.7.5      httr2_1.2.1            lifecycle_1.0.4
#>  [10] edgeR_4.8.0            globals_0.18.0         lattice_0.22-7
#>  [13] MASS_7.3-65            magrittr_2.0.4         limma_3.66.0
#>  [16] plotly_4.11.0          sass_0.4.10            rmarkdown_2.30
#>  [19] jquerylib_0.1.4        yaml_2.3.10            metapod_1.18.0
#>  [22] httpuv_1.6.16          otel_0.2.0             sctransform_0.4.2
#>  [25] spam_2.11-1            spatstat.sparse_3.1-0  reticulate_1.44.0
#>  [28] cowplot_1.2.0          pbapply_1.7-4          DBI_1.2.3
#>  [31] RColorBrewer_1.1-3     Rtsne_0.17             purrr_1.1.0
#>  [34] rappdirs_0.3.3         tweenr_2.0.3           irlba_2.3.5.1
#>  [37] listenv_0.9.1          spatstat.utils_3.2-0   goftest_1.2-3
#>  [40] RSpectra_0.16-2        dqrng_0.4.1            spatstat.random_3.4-2
#>  [43] fitdistrplus_1.2-4     parallelly_1.45.1      codetools_0.2-20
#>  [46] ggforce_0.5.0          tidyselect_1.2.1       farver_2.1.2
#>  [49] viridis_0.6.5          ScaledMatrix_1.18.0    BiocFileCache_3.0.0
#>  [52] spatstat.explore_3.5-3 jsonlite_2.0.0         BiocNeighbors_2.4.0
#>  [55] progressr_0.17.0       ggridges_0.5.7         survival_3.8-3
#>  [58] systemfonts_1.3.1      tools_4.5.1            ica_1.0-3
#>  [61] Rcpp_1.1.0             glue_1.8.0             gridExtra_2.3
#>  [64] xfun_0.53              withr_3.0.2            BiocManager_1.30.26
#>  [67] fastmap_1.2.0          bluster_1.20.0         rhdf5filters_1.22.0
#>  [70] rsvd_1.0.5             entropy_1.3.2          digest_0.6.37
#>  [73] R6_2.6.1               mime_0.13              scattermore_1.2
#>  [76] tensor_1.5.1           dichromat_2.0-0.1      spatstat.data_3.1-9
#>  [79] RSQLite_2.4.3          tidyr_1.3.1            hexbin_1.28.5
#>  [82] data.table_1.17.8      FNN_1.1.4.1            httr_1.4.7
#>  [85] htmlwidgets_1.6.4      uwot_0.2.3             pkgconfig_2.0.3
#>  [88] gtable_0.3.6           blob_1.2.4             lmtest_0.9-40
#>  [91] S7_0.2.0               XVector_0.50.0         htmltools_0.5.8.1
#>  [94] dotCall64_1.2          scales_1.4.0           png_0.1-8
#>  [97] spatstat.univar_3.1-4  knitr_1.50             reshape2_1.4.4
#> [100] curl_7.0.0             nlme_3.1-168           cachem_1.1.0
#> [103] zoo_1.8-14             stringr_1.5.2          BiocVersion_3.22.0
#> [106] KernSmooth_2.23-26     vipor_0.4.7            parallel_4.5.1
#> [109] miniUI_0.1.2           concaveman_1.2.0       AnnotationDbi_1.72.0
#> [112] pillar_1.11.1          grid_4.5.1             vctrs_0.6.5
#> [115] RANN_2.6.2             promises_1.4.0         BiocSingular_1.26.0
#> [118] beachmat_2.26.0        dbplyr_2.5.1           xtable_1.8-4
#> [121] cluster_2.1.8.1        beeswarm_0.4.0         evaluate_1.0.5
#> [124] locfit_1.5-9.12        cli_3.6.5              compiler_4.5.1
#> [127] rlang_1.1.6            crayon_1.5.3           future.apply_1.20.0
#> [130] labeling_0.4.3         ggbeeswarm_0.7.2       plyr_1.8.9
#> [133] stringi_1.8.7          BiocParallel_1.44.0    viridisLite_0.4.2
#> [136] deldir_2.0-4           Biostrings_2.78.0      lazyeval_0.2.2
#> [139] spatstat.geom_3.6-0    ExperimentHub_3.0.0    RcppHNSW_0.6.0
#> [142] patchwork_1.3.2        bit64_4.6.0-1          future_1.67.0
#> [145] Rhdf5lib_1.32.0        statmod_1.5.1          KEGGREST_1.50.0
#> [148] shiny_1.11.1           AnnotationHub_4.0.0    ROCR_1.0-11
#> [151] memoise_2.0.1          bslib_0.9.0            bit_4.6.0
```