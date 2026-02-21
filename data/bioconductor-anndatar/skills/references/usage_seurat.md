# Read/write Seurat objects using anndataR

#### 29 January 2026

#### Package

anndataR 1.0.1

# Contents

* [1 Introduction](#introduction)
  + [1.1 Prerequisites](#prerequisites)
* [2 Reading H5AD files to a `Seurat` Object](#reading-h5ad-files-to-a-seurat-object)
* [3 Mapping between `AnnData` and `Seurat`](#mapping-between-anndata-and-seurat)
* [4 Customizing the conversion](#customizing-the-conversion)
* [5 Writing a `Seurat` object to a H5AD file](#writing-a-seurat-object-to-a-h5ad-file)
* [6 Session info](#session-info)

# 1 Introduction

This vignette demonstrates how to read and write `Seurat` objects using the *[anndataR](https://bioconductor.org/packages/3.22/anndataR)* package, leveraging the interoperability between `Seurat` and the `AnnData` format.

*[Seurat](https://CRAN.R-project.org/package%3DSeurat)* is a widely used toolkit for single-cell analysis in R.
*[anndataR](https://bioconductor.org/packages/3.22/anndataR)* enables conversion between `Seurat` objects and `AnnData` objects, allowing you to leverage the strengths of both the [scverse](https://scverse.org/) and [Seurat](https://satijalab.org/seurat/) ecosystems.

## 1.1 Prerequisites

This vignette requires the *[Seurat](https://CRAN.R-project.org/package%3DSeurat)* package in addition to *[anndataR](https://bioconductor.org/packages/3.22/anndataR)*.
You can install them using the following code:

```
install.packages("Seurat")
```

# 2 Reading H5AD files to a `Seurat` Object

Using an example `.h5ad` file included in the package, we will demonstrate how to read an `.h5ad` file and convert it to a `Seurat` object.

```
library(anndataR)
library(Seurat)
#>
#> Attaching package: 'Seurat'
#> The following object is masked from 'package:SummarizedExperiment':
#>
#>     Assays

h5ad_file <- system.file("extdata", "example.h5ad", package = "anndataR")
```

Read the `.h5ad` file as a `Seurat` object:

```
seurat_obj <- read_h5ad(h5ad_file, as = "Seurat")
seurat_obj
#> An object of class Seurat
#> 100 features across 50 samples within 1 assay
#> Active assay: RNA (100 features, 0 variable features)
#>  5 layers present: counts, csc_counts, dense_X, dense_counts, X
#>  2 dimensional reductions calculated: X_pca, X_umap
```

This is equivalent to reading in the `.h5ad` file as an `AnnData` and explicitly converting:

```
adata <- read_h5ad(h5ad_file)
seurat_obj <- adata$as_Seurat()
seurat_obj
#> An object of class Seurat
#> 100 features across 50 samples within 1 assay
#> Active assay: RNA (100 features, 0 variable features)
#>  5 layers present: counts, csc_counts, dense_X, dense_counts, X
#>  2 dimensional reductions calculated: X_pca, X_umap
```

# 3 Mapping between `AnnData` and `Seurat`

Figure [1](#fig:mapping) shows the structures of the `AnnData` and `Seurat` objects and how *[anndataR](https://bioconductor.org/packages/3.22/anndataR)* maps between them.
It is important to note that matrices in the two objects are transposed relative to each other.

![Mapping between `AnnData` and `Seurat` objects](data:image/png;base64...)

Figure 1: Mapping between `AnnData` and `Seurat` objects

By default, all items in most slots are converted using the same names.
An exception is the `varp` slot which doesn’t have a corresponding slot in `Seurat`.
Items in the `varm` slot are only converted when they are specified in a mapping argument.
The `Neighbors` and `Images` slots are not mapped when converting from `Seurat`.
See `?as_Seurat` for more details on the default mapping.

# 4 Customizing the conversion

You can customize the conversion process by providing specific mappings for each slot in the `Seurat` object.

Each of the mapping arguments can be provided with one of the following:

* `TRUE`: all items in the slot will be copied using the default mapping
* `FALSE`: the slot will not be copied
* A (named) character vector: the names are the names of the slot in the `Seurat` object, the values are the names of the slot in the `AnnData` object.

See `?as_Seurat` for more details on how to customize the conversion process. For instance:

```
seurat_obj <- adata$as_Seurat(
  layers_mapping = c("counts", "dense_counts"),
  object_metadata_mapping = c(metadata1 = "Int", metadata2 = "Float"),
  assay_metadata_mapping = FALSE,
  reduction_mapping = list(
    pca = c(key = "PC_", embeddings = "X_pca", loadings = "PCs"),
    umap = c(key = "UMAP_", embeddings = "X_umap")
  ),
  graph_mapping = TRUE,
  misc_mapping = c(misc1 = "Bool", misc2 = "IntScalar")
)
seurat_obj
#> An object of class Seurat
#> 100 features across 50 samples within 1 assay
#> Active assay: RNA (100 features, 0 variable features)
#>  3 layers present: counts, dense_counts, X
#>  2 dimensional reductions calculated: pca, umap
```

The mapping arguments can also be passed directly to `read_h5ad()`.

# 5 Writing a `Seurat` object to a H5AD file

The reverse conversion is also possible, allowing you to convert the `Seurat` object back to an `AnnData` object, or to just write out the `Seurat` object as an `.h5ad` file.

```
write_h5ad(seurat_obj, tempfile(fileext = ".h5ad"))
```

This is equivalent to converting the `Seurat` object to an `AnnData` object and then writing it out:

```
adata <- as_AnnData(seurat_obj)
adata$write_h5ad(tempfile(fileext = ".h5ad"))
```

You can again customize the conversion process by providing specific mappings for each slot in the `AnnData` object.
For more details, see `?as_AnnData`.

Here’s an example:

```
adata <- as_AnnData(
  seurat_obj,
  assay_name = "RNA",
  x_mapping = "counts",
  layers_mapping = c("dense_counts"),
  obs_mapping = c(RNA_count = "nCount_RNA", metadata1 = "metadata1"),
  var_mapping = FALSE,
  obsm_mapping = list(X_pca = "pca", X_umap = "umap"),
  obsp_mapping = TRUE,
  uns_mapping = c("misc1", "misc2")
)
adata
#> InMemoryAnnData object with n_obs × n_vars = 50 × 100
#>     obs: 'RNA_count', 'metadata1'
#>     uns: 'misc1', 'misc2'
#>     obsm: 'X_pca', 'X_umap'
#>     layers: 'dense_counts'
#>     obsp: 'connectivities', 'distances'
```

The mapping arguments can also be passed directly to `write_h5ad()`.

# 6 Session info

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#>  [1] Seurat_5.4.0                anndataR_1.0.1
#>  [3] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [5] Biobase_2.70.0              GenomicRanges_1.62.1
#>  [7] Seqinfo_1.0.0               IRanges_2.44.0
#>  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [11] generics_0.1.4              MatrixGenerics_1.22.0
#> [13] matrixStats_1.5.0           SeuratObject_5.3.0
#> [15] sp_2.2-0                    BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3     jsonlite_2.0.0         magrittr_2.0.4
#>   [4] spatstat.utils_3.2-1   farver_2.1.2           rmarkdown_2.30
#>   [7] vctrs_0.7.1            ROCR_1.0-12            spatstat.explore_3.7-0
#>  [10] htmltools_0.5.9        S4Arrays_1.10.1        Rhdf5lib_1.32.0
#>  [13] SparseArray_1.10.8     rhdf5_2.54.1           sass_0.4.10
#>  [16] sctransform_0.4.3      parallelly_1.46.1      KernSmooth_2.23-26
#>  [19] bslib_0.10.0           htmlwidgets_1.6.4      ica_1.0-3
#>  [22] plyr_1.8.9             plotly_4.12.0          zoo_1.8-15
#>  [25] cachem_1.1.0           igraph_2.2.1           mime_0.13
#>  [28] lifecycle_1.0.5        pkgconfig_2.0.3        Matrix_1.7-4
#>  [31] R6_2.6.1               fastmap_1.2.0          fitdistrplus_1.2-6
#>  [34] future_1.69.0          shiny_1.12.1           digest_0.6.39
#>  [37] patchwork_1.3.2        tensor_1.5.1           RSpectra_0.16-2
#>  [40] irlba_2.3.5.1          progressr_0.18.0       spatstat.sparse_3.1-0
#>  [43] httr_1.4.7             polyclip_1.10-7        abind_1.4-8
#>  [46] compiler_4.5.2         withr_3.0.2            S7_0.2.1
#>  [49] fastDummies_1.7.5      MASS_7.3-65            DelayedArray_0.36.0
#>  [52] tools_4.5.2            lmtest_0.9-40          otel_0.2.0
#>  [55] httpuv_1.6.16          future.apply_1.20.1    goftest_1.2-3
#>  [58] glue_1.8.0             nlme_3.1-168           rhdf5filters_1.22.0
#>  [61] promises_1.5.0         grid_4.5.2             Rtsne_0.17
#>  [64] cluster_2.1.8.1        reshape2_1.4.5         gtable_0.3.6
#>  [67] spatstat.data_3.1-9    tidyr_1.3.2            data.table_1.18.2.1
#>  [70] XVector_0.50.0         spatstat.geom_3.7-0    RcppAnnoy_0.0.23
#>  [73] ggrepel_0.9.6          RANN_2.6.2             pillar_1.11.1
#>  [76] stringr_1.6.0          spam_2.11-3            RcppHNSW_0.6.0
#>  [79] later_1.4.5            splines_4.5.2          dplyr_1.1.4
#>  [82] lattice_0.22-7         survival_3.8-6         deldir_2.0-4
#>  [85] tidyselect_1.2.1       miniUI_0.1.2           pbapply_1.7-4
#>  [88] knitr_1.51             gridExtra_2.3          bookdown_0.46
#>  [91] scattermore_1.2        xfun_0.56              stringi_1.8.7
#>  [94] lazyeval_0.2.2         yaml_2.3.12            evaluate_1.0.5
#>  [97] codetools_0.2-20       tibble_3.3.1           BiocManager_1.30.27
#> [100] cli_3.6.5              uwot_0.2.4             xtable_1.8-4
#> [103] reticulate_1.44.1      jquerylib_0.1.4        dichromat_2.0-0.1
#> [106] Rcpp_1.1.1             globals_0.18.0         spatstat.random_3.4-4
#> [109] png_0.1-8              spatstat.univar_3.1-6  parallel_4.5.2
#> [112] ggplot2_4.0.1          dotCall64_1.2          listenv_0.10.0
#> [115] viridisLite_0.4.2      scales_1.4.0           ggridges_0.5.7
#> [118] purrr_1.2.1            rlang_1.1.7            cowplot_1.2.0
```