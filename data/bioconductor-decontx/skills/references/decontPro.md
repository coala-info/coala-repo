# Decontamination of single cell protein expression data with DecontPro

Yuan Yin1 and Joshua Campbell1\*

1Boston University School of Medicine

\*camp@bu.edu

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Importing data](#importing-data)
* [4 Generate cell clusters](#generate-cell-clusters)
* [5 Run DecontPro](#run-decontpro)
* [6 Plot Results](#plot-results)
* [7 Session Information](#session-information)

# 1 Introduction

DecontPro assess and decontaminate single-cell protein expression data, such as
those generated from CITE-seq or Total-seq. The count matrix is decomposed into
three matrices, the native, the ambient and the background that represent the
contribution from the true protein expression on cells, the ambient material and
other non-specific background contamination.

# 2 Installation

DecontX Package can be installed from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("decontX")
```

Then the package can be loaded in R using the following command:

```
library(decontX)
```

To see the latest updates and releases or to post a bug, see our GitHub page at <https://github.com/campbio/decontX>.

# 3 Importing data

Here we use an example dataset from `SingleCellMultiModal` package.

```
library(SingleCellMultiModal)
dat <- CITEseq("cord_blood", dry.run = FALSE)
#> Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
#>   potential for errors with mixed data types
counts <- experiments(dat)$scADT
```

For this tutorial, we sample only 1000 droplets from the dataset to demonstrate the use of functions. When analyzing your dataset, sub-sampling should be done with caution, as `decontPro` approximates contamination profile using the dataset. A biased sampling may introduce bias to the contamination profile approximation.

```
set.seed(42)
sample_id <- sample(dim(counts)[2], 1000, replace = FALSE)
counts_sample <- counts[, sample_id]
```

# 4 Generate cell clusters

`decontPro` requires a vector indicating the cell types of each droplet. Here we use `Seurat` for clustering.

```
library(Seurat)
library(dplyr)
adt_seurat <- CreateSeuratObject(counts_sample, assay = "ADT")
#> Warning: Data is of class matrix. Coercing to dgCMatrix.
adt_seurat <- NormalizeData(adt_seurat, normalization.method = "CLR", margin = 2) %>%
  ScaleData(assay = "ADT") %>%
  RunPCA(assay = "ADT", features = rownames(adt_seurat), npcs = 10,
  reduction.name = "pca_adt") %>%
  FindNeighbors(dims = 1:10, assay = "ADT", reduction = "pca_adt") %>%
  FindClusters(resolution = 0.5)
#> Warning in svd.function(A = t(x = object), nv = npcs, ...): You're computing
#> too large a percentage of total singular values, use a standard svd instead.
#> Warning: Requested number is larger than the number of available items (13).
#> Setting to 13.
#> Warning: Requested number is larger than the number of available items (13).
#> Setting to 13.
#> Warning: Requested number is larger than the number of available items (13).
#> Setting to 13.
#> Warning: Requested number is larger than the number of available items (13).
#> Setting to 13.
#> Warning: Requested number is larger than the number of available items (13).
#> Setting to 13.
#> Modularity Optimizer version 1.3.0 by Ludo Waltman and Nees Jan van Eck
#>
#> Number of nodes: 1000
#> Number of edges: 32498
#>
#> Running Louvain algorithm...
#> Maximum modularity in 10 random starts: 0.8567
#> Number of communities: 9
#> Elapsed time: 0 seconds
```

```
adt_seurat <- RunUMAP(adt_seurat,
                      dims = 1:10,
                      assay = "ADT",
                      reduction = "pca_adt",
                      reduction.name = "adtUMAP",
                      verbose = FALSE)
#> Warning: The default method for RunUMAP has changed from calling Python UMAP via reticulate to the R-native UWOT using the cosine metric
#> To use Python UMAP via reticulate, set umap.method to 'umap-learn' and metric to 'correlation'
#> This message will be shown once per session
DimPlot(adt_seurat, reduction = "adtUMAP", label = TRUE)
```

![](data:image/png;base64...)

```
FeaturePlot(adt_seurat,
            features = c("CD3", "CD4", "CD8", "CD19", "CD14", "CD16", "CD56"))
```

![](data:image/png;base64...)

```
clusters <- as.integer(Idents(adt_seurat))
```

# 5 Run DecontPro

You can run `DecontPro` by simply:

```
counts <- as.matrix(counts_sample)
out <- decontPro(counts,
                clusters)
```

Priors (`delta_sd` and `background_sd`) may need tuning with the help of plotting the decontaminated results. The two priors encode belief if a more spread-out count should be considered contamination vs. native. We tested the default values on datasets ranging 5k to 10k droplets and 10 to 30 ADTs and the results are reasonable. A more contaminated or a smaller dataset may need larger priors. In this tutorial, since we sampled only 1k droplets from the original 10k droplets, we use slightly larger priors:

```
counts <- as.matrix(counts_sample)
out <- decontPro(counts,
                 clusters,
                 delta_sd = 2e-4,
                 background_sd = 2e-5)
#> Chain 1: ------------------------------------------------------------
#> Chain 1: EXPERIMENTAL ALGORITHM:
#> Chain 1:   This procedure has not been thoroughly tested and may be unstable
#> Chain 1:   or buggy. The interface is subject to change.
#> Chain 1: ------------------------------------------------------------
#> Chain 1:
#> Chain 1:
#> Chain 1:
#> Chain 1: Gradient evaluation took 0.016582 seconds
#> Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 165.82 seconds.
#> Chain 1: Adjust your expectations accordingly!
#> Chain 1:
#> Chain 1:
#> Chain 1: Begin eta adaptation.
#> Chain 1: Iteration:   1 / 250 [  0%]  (Adaptation)
#> Chain 1: Iteration:  50 / 250 [ 20%]  (Adaptation)
#> Chain 1: Iteration: 100 / 250 [ 40%]  (Adaptation)
#> Chain 1: Iteration: 150 / 250 [ 60%]  (Adaptation)
#> Chain 1: Iteration: 200 / 250 [ 80%]  (Adaptation)
#> Chain 1: Success! Found best value [eta = 1] earlier than expected.
#> Chain 1:
#> Chain 1: Begin stochastic gradient ascent.
#> Chain 1:   iter             ELBO   delta_ELBO_mean   delta_ELBO_med   notes
#> Chain 1:    100   -513803659.665             1.000            1.000
#> Chain 1:    200     -7177548.141            35.792           70.585
#> Chain 1:    300      -342758.348            30.508           19.941
#> Chain 1:    400      -253644.497            22.969           19.941
#> Chain 1:    500      -223785.346            18.402            1.000
#> Chain 1:    600      -212411.740            15.344            1.000
#> Chain 1:    700      -206476.954            13.156            0.351
#> Chain 1:    800      -202104.000            11.514            0.351
#> Chain 1:    900      -199781.145            10.236            0.133
#> Chain 1:   1000      -198758.154             9.213            0.133
#> Chain 1:   1100      -198020.264             8.376            0.054   MAY BE DIVERGING... INSPECT ELBO
#> Chain 1:   1200      -197397.014             7.678            0.054   MAY BE DIVERGING... INSPECT ELBO
#> Chain 1:   1300      -196906.436             7.088            0.029   MAY BE DIVERGING... INSPECT ELBO
#> Chain 1:   1400      -196442.570             6.582            0.029   MAY BE DIVERGING... INSPECT ELBO
#> Chain 1:   1500      -196230.683             6.143            0.022   MAY BE DIVERGING... INSPECT ELBO
#> Chain 1:   1600      -195981.145             5.759            0.022   MAY BE DIVERGING... INSPECT ELBO
#> Chain 1:   1700      -195830.350             5.420            0.012   MAY BE DIVERGING... INSPECT ELBO
#> Chain 1:   1800      -195732.312             5.119            0.012   MAY BE DIVERGING... INSPECT ELBO
#> Chain 1:   1900      -195651.552             4.850            0.005   MEDIAN ELBO CONVERGED   MAY BE DIVERGING... INSPECT ELBO
#> Chain 1:
#> Chain 1: Drawing a sample of size 1000 from the approximate posterior...
#> Chain 1: COMPLETED.
#> Warning: Pareto k diagnostic value is 41.49. Resampling is disabled. Decreasing
#> tol_rel_obj may help if variational algorithm has terminated prematurely.
#> Otherwise consider using sampling instead.
```

The output contains three matrices, and model parameters after inference.
`decontaminated_counts` represent the true protein expression on cells.

```
decontaminated_counts <- out$decontaminated_counts
```

# 6 Plot Results

Plot ADT density before and after decontamination. For bimodal ADTs, the background peak should be removed. Note CD4 is tri-modal with the intermediate mode corresponding to monocytes. This can be used as a QC metric for decontamination as only the lowest mode should be removed.

```
plotDensity(counts,
            decontaminated_counts,
            c("CD3", "CD4", "CD8", "CD14", "CD16", "CD19"))
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the decontX package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

We can also visualize the decontamination by each cell cluster.

```
plotBoxByCluster(counts,
                 decontaminated_counts,
                 clusters,
                 c("CD3", "CD4", "CD8", "CD16"))
```

![](data:image/png;base64...)

# 7 Session Information

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
#>  [1] future_1.67.0               dplyr_1.1.4
#>  [3] Seurat_5.3.1                SeuratObject_5.2.0
#>  [5] sp_2.2-0                    SingleCellMultiModal_1.21.4
#>  [7] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
#>  [9] Biobase_2.70.0              GenomicRanges_1.62.0
#> [11] Seqinfo_1.0.0               IRanges_2.44.0
#> [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [15] generics_0.1.4              MatrixGenerics_1.22.0
#> [17] matrixStats_1.5.0           decontX_1.8.0
#> [19] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RcppAnnoy_0.0.22            splines_4.5.1
#>   [3] later_1.4.4                 filelock_1.0.3
#>   [5] tibble_3.3.0                polyclip_1.10-7
#>   [7] fastDummies_1.7.5           httr2_1.2.1
#>   [9] lifecycle_1.0.4             StanHeaders_2.32.10
#>  [11] globals_0.18.0              lattice_0.22-7
#>  [13] MASS_7.3-65                 magrittr_2.0.4
#>  [15] plotly_4.11.0               sass_0.4.10
#>  [17] rmarkdown_2.30              jquerylib_0.1.4
#>  [19] yaml_2.3.10                 httpuv_1.6.16
#>  [21] otel_0.2.0                  sctransform_0.4.2
#>  [23] spam_2.11-1                 pkgbuild_1.4.8
#>  [25] spatstat.sparse_3.1-0       reticulate_1.44.0
#>  [27] cowplot_1.2.0               pbapply_1.7-4
#>  [29] DBI_1.2.3                   RColorBrewer_1.1-3
#>  [31] abind_1.4-8                 Rtsne_0.17
#>  [33] purrr_1.1.0                 rappdirs_0.3.3
#>  [35] ggrepel_0.9.6               inline_0.3.21
#>  [37] irlba_2.3.5.1               listenv_0.9.1
#>  [39] spatstat.utils_3.2-0        goftest_1.2-3
#>  [41] RSpectra_0.16-2             spatstat.random_3.4-2
#>  [43] fitdistrplus_1.2-4          parallelly_1.45.1
#>  [45] codetools_0.2-20            DelayedArray_0.36.0
#>  [47] tidyselect_1.2.1            farver_2.1.2
#>  [49] BiocFileCache_3.0.0         spatstat.explore_3.5-3
#>  [51] jsonlite_2.0.0              progressr_0.17.0
#>  [53] ggridges_0.5.7              survival_3.8-3
#>  [55] tools_4.5.1                 ica_1.0-3
#>  [57] Rcpp_1.1.0                  glue_1.8.0
#>  [59] gridExtra_2.3               SparseArray_1.10.0
#>  [61] BiocBaseUtils_1.12.0        xfun_0.53
#>  [63] loo_2.8.0                   withr_3.0.2
#>  [65] combinat_0.0-8              BiocManager_1.30.26
#>  [67] fastmap_1.2.0               MCMCprecision_0.4.2
#>  [69] digest_0.6.37               R6_2.6.1
#>  [71] mime_0.13                   scattermore_1.2
#>  [73] tensor_1.5.1                dichromat_2.0-0.1
#>  [75] spatstat.data_3.1-9         RSQLite_2.4.3
#>  [77] tidyr_1.3.1                 data.table_1.17.8
#>  [79] httr_1.4.7                  htmlwidgets_1.6.4
#>  [81] S4Arrays_1.10.0             uwot_0.2.3
#>  [83] pkgconfig_2.0.3             gtable_0.3.6
#>  [85] blob_1.2.4                  lmtest_0.9-40
#>  [87] S7_0.2.0                    SingleCellExperiment_1.32.0
#>  [89] XVector_0.50.0              htmltools_0.5.8.1
#>  [91] dotCall64_1.2               bookdown_0.45
#>  [93] scales_1.4.0                png_0.1-8
#>  [95] SpatialExperiment_1.20.0    spatstat.univar_3.1-4
#>  [97] knitr_1.50                  rjson_0.2.23
#>  [99] reshape2_1.4.4              nlme_3.1-168
#> [101] curl_7.0.0                  cachem_1.1.0
#> [103] zoo_1.8-14                  stringr_1.5.2
#> [105] BiocVersion_3.22.0          KernSmooth_2.23-26
#> [107] parallel_4.5.1              miniUI_0.1.2
#> [109] AnnotationDbi_1.72.0        pillar_1.11.1
#> [111] grid_4.5.1                  vctrs_0.6.5
#> [113] RANN_2.6.2                  promises_1.4.0
#> [115] dbplyr_2.5.1                xtable_1.8-4
#> [117] cluster_2.1.8.1             evaluate_1.0.5
#> [119] tinytex_0.57                magick_2.9.0
#> [121] cli_3.6.5                   compiler_4.5.1
#> [123] crayon_1.5.3                rlang_1.1.6
#> [125] rstantools_2.5.0            future.apply_1.20.0
#> [127] labeling_0.4.3              plyr_1.8.9
#> [129] stringi_1.8.7               rstan_2.32.7
#> [131] viridisLite_0.4.2           deldir_2.0-4
#> [133] QuickJSR_1.8.1              Biostrings_2.78.0
#> [135] lazyeval_0.2.2              spatstat.geom_3.6-0
#> [137] V8_8.0.1                    Matrix_1.7-4
#> [139] ExperimentHub_3.0.0         RcppHNSW_0.6.0
#> [141] patchwork_1.3.2             bit64_4.6.0-1
#> [143] ggplot2_4.0.0               KEGGREST_1.50.0
#> [145] shiny_1.11.1                AnnotationHub_4.0.0
#> [147] ROCR_1.0-11                 memoise_2.0.1
#> [149] igraph_2.2.1                RcppParallel_5.1.11-1
#> [151] bslib_0.9.0                 bit_4.6.0
```