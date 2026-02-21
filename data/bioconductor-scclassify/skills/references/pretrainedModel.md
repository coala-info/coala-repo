# Performing scClassify using pretrained model

Yingxin Lin1

1School of Mathematics and Statistics, The University of Sydney, Australia

#### 30 October 2025

# 1 Introduction

A common application of single-cell RNA sequencing (RNA-seq) data is
to identify discrete cell types. To take advantage of the large collection
of well-annotated scRNA-seq datasets, `scClassify` package implements
a set of methods to perform accurate cell type classification based on
*ensemble learning* and *sample size calculation*.

This vignette will provide an example showing how users can use a pretrained
model of scClassify to predict cell types. A pretrained model is a
`scClassifyTrainModel` object returned by `train_scClassify()`.
A list of pretrained model can be found in
<https://sydneybiox.github.io/scClassify/index.html>.

First, install `scClassify`, install `BiocManager` and use
`BiocManager::install` to install `scClassify` package.

```
# installation of scClassify
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("scClassify")
```

# 2 Setting up the data

We assume that you have *log-transformed* (size-factor normalized) matrices as
query datasets, where each row refers to a gene and each column a cell.
For demonstration purposes, we will take a subset of single-cell pancreas
datasets from one independent study (Wang et al.).

```
library(scClassify)
data("scClassify_example")
wang_cellTypes <- scClassify_example$wang_cellTypes
exprsMat_wang_subset <- scClassify_example$exprsMat_wang_subset
exprsMat_wang_subset <- as(exprsMat_wang_subset, "dgCMatrix")
```

Here, we load our pretrained model using a subset of the Xin et al.
human pancreas dataset as our reference data.

First, let us check basic information relating to our pretrained model.

```
data("trainClassExample_xin")
trainClassExample_xin
#> Class: scClassifyTrainModel
#> Model name: training
#> Feature selection methods: limma
#> Number of cells in the training data: 674
#> Number of cell types in the training data: 4
```

In this pretrained model, we have selected the genes based on Differential
Expression using limma. To check the genes that are available
in the pretrained model:

```
features(trainClassExample_xin)
#> [1] "limma"
```

We can also visualise the cell type tree of the reference data.

```
plotCellTypeTree(cellTypeTree(trainClassExample_xin))
```

![](data:image/png;base64...)

# 3 Running scClassify

Next, we perform `predict_scClassify` with our pretrained model
`trainRes = trainClassExample` to predict the cell types of our
query data matrix `exprsMat_wang_subset_sparse`. Here,
we used `pearson` and `spearman` as similarity metrics.

```
pred_res <- predict_scClassify(exprsMat_test = exprsMat_wang_subset,
                               trainRes = trainClassExample_xin,
                               cellTypes_test = wang_cellTypes,
                               algorithm = "WKNN",
                               features = c("limma"),
                               similarity = c("pearson", "spearman"),
                               prob_threshold = 0.7,
                               verbose = TRUE)
#> Performing unweighted ensemble learning...
#> Using parameters:
#> similarity  algorithm   features
#>  "pearson"     "WKNN"    "limma"
#> [1] "Using dynamic correlation cutoff..."
#> [1] "Using dynamic correlation cutoff..."
#> classify_res
#>                correct   correctly unassigned           intermediate
#>            0.704590818            0.239520958            0.000000000
#> incorrectly unassigned         error assigned          misclassified
#>            0.000000000            0.051896208            0.003992016
#> Using parameters:
#> similarity  algorithm   features
#> "spearman"     "WKNN"    "limma"
#> [1] "Using dynamic correlation cutoff..."
#> [1] "Using dynamic correlation cutoff..."
#> classify_res
#>                correct   correctly unassigned           intermediate
#>            0.702594810            0.013972056            0.000000000
#> incorrectly unassigned         error assigned          misclassified
#>            0.001996008            0.277445110            0.003992016
#> weights for each base method:
#> [1] NA NA
```

Noted that the `cellType_test` is not a required input.
For datasets with unknown labels, users can simply leave it
as `cellType_test = NULL`.

Prediction results for pearson as the similarity metric:

```
table(pred_res$pearson_WKNN_limma$predRes, wang_cellTypes)
#>                   wang_cellTypes
#>                    acinar alpha beta delta ductal gamma stellate
#>   alpha                 0   206    0     0      0     2        0
#>   beta                  0     0  118     0      1     0        0
#>   beta_delta_gamma      0     0    0     0     25     0        0
#>   delta                 0     0    0    10      0     0        0
#>   gamma                 0     0    0     0      0    19        0
#>   unassigned            5     0    0     0     70     0       45
```

Prediction results for spearman as the similarity metric:

```
table(pred_res$spearman_WKNN_limma$predRes, wang_cellTypes)
#>                   wang_cellTypes
#>                    acinar alpha beta delta ductal gamma stellate
#>   alpha                 0   206    0     0      0     2        2
#>   beta                  2     0  118     0     29     0        6
#>   beta_delta_gamma      1     0    0     0     66     0       31
#>   delta                 0     0    0    10      0     0        2
#>   gamma                 0     0    0     0      0    18        0
#>   unassigned            2     0    0     0      1     1        4
```

# 4 Session Info

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] scClassify_1.22.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] gridExtra_2.3               rlang_1.1.6
#>   [3] magrittr_2.0.4              matrixStats_1.5.0
#>   [5] compiler_4.5.1              mgcv_1.9-3
#>   [7] DelayedMatrixStats_1.32.0   vctrs_0.6.5
#>   [9] reshape2_1.4.4              stringr_1.5.2
#>  [11] pkgconfig_2.0.3             fastmap_1.2.0
#>  [13] magick_2.9.0                XVector_0.50.0
#>  [15] labeling_0.4.3              ggraph_2.2.2
#>  [17] rmarkdown_2.30              tinytex_0.57
#>  [19] purrr_1.1.0                 xfun_0.53
#>  [21] cachem_1.1.0                jsonlite_2.0.0
#>  [23] rhdf5filters_1.22.0         DelayedArray_0.36.0
#>  [25] Rhdf5lib_1.32.0             BiocParallel_1.44.0
#>  [27] tweenr_2.0.3                parallel_4.5.1
#>  [29] cluster_2.1.8.1             R6_2.6.1
#>  [31] bslib_0.9.0                 stringi_1.8.7
#>  [33] RColorBrewer_1.1-3          limma_3.66.0
#>  [35] diptest_0.77-2              GenomicRanges_1.62.0
#>  [37] jquerylib_0.1.4             Rcpp_1.1.0
#>  [39] Seqinfo_1.0.0               bookdown_0.45
#>  [41] SummarizedExperiment_1.40.0 knitr_1.50
#>  [43] mixtools_2.0.0.1            IRanges_2.44.0
#>  [45] Matrix_1.7-4                splines_4.5.1
#>  [47] igraph_2.2.1                tidyselect_1.2.1
#>  [49] dichromat_2.0-0.1           abind_1.4-8
#>  [51] yaml_2.3.10                 hopach_2.70.0
#>  [53] viridis_0.6.5               codetools_0.2-20
#>  [55] minpack.lm_1.2-4            Cepo_1.16.0
#>  [57] lattice_0.22-7              tibble_3.3.0
#>  [59] plyr_1.8.9                  Biobase_2.70.0
#>  [61] withr_3.0.2                 S7_0.2.0
#>  [63] evaluate_1.0.5              survival_3.8-3
#>  [65] proxy_0.4-27                polyclip_1.10-7
#>  [67] kernlab_0.9-33              pillar_1.11.1
#>  [69] BiocManager_1.30.26         MatrixGenerics_1.22.0
#>  [71] stats4_4.5.1                plotly_4.11.0
#>  [73] generics_0.1.4              S4Vectors_0.48.0
#>  [75] ggplot2_4.0.0               sparseMatrixStats_1.22.0
#>  [77] scales_1.4.0                glue_1.8.0
#>  [79] lazyeval_0.2.2              proxyC_0.5.2
#>  [81] tools_4.5.1                 data.table_1.17.8
#>  [83] graphlayouts_1.2.2          tidygraph_1.3.1
#>  [85] rhdf5_2.54.0                grid_4.5.1
#>  [87] tidyr_1.3.1                 SingleCellExperiment_1.32.0
#>  [89] nlme_3.1-168                patchwork_1.3.2
#>  [91] ggforce_0.5.0               HDF5Array_1.38.0
#>  [93] cli_3.6.5                   segmented_2.1-4
#>  [95] S4Arrays_1.10.0             viridisLite_0.4.2
#>  [97] dplyr_1.1.4                 gtable_0.3.6
#>  [99] sass_0.4.10                 digest_0.6.37
#> [101] BiocGenerics_0.56.0         SparseArray_1.10.0
#> [103] ggrepel_0.9.6               htmlwidgets_1.6.4
#> [105] farver_2.1.2                memoise_2.0.1
#> [107] htmltools_0.5.8.1           lifecycle_1.0.4
#> [109] h5mread_1.2.0               httr_1.4.7
#> [111] statmod_1.5.1               MASS_7.3-65
```