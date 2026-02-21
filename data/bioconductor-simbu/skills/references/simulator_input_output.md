# Inputs and Outputs

## Alexander Dietrich

```
library(Seurat)
#> Loading required package: SeuratObject
#> Loading required package: sp
#>
#> Attaching package: 'SeuratObject'
#> The following objects are masked from 'package:base':
#>
#>     intersect, t
library(curl)
#> Using libcurl 8.5.0 with GnuTLS/3.8.3
library(SimBu)
```

This chapter covers the different input and output options of the package in detail.

# Input

The input for your simulations is always a `SummarizedExperiment` object. You can create this object with different constructing functions, which will explained below. It is also possible to merge multiple datasets objects into one.
Sfaira is not covered in this vignette, but in [“Public Data Integration”](sfaira_vignette.html).\

## Custom data

Using existing count matrices and annotations is already covered in the [“Getting started”](simulator_documentation.html) vignette; this section will explain some minor details.\

When generating a dataset with your own data, you need to provide the `count_matrix` parameter of `dataset()`; additionally you can provide a TPM matrix with the `tpm_matrix`. This will then lead to two simulations, one based on counts and one based on TPMs. For either of them, genes are located in the rows, cells in the columns.
Additionally, an annotation table is needed, with the cell-type annotations. It needs to consist of at least out of 2 columns: `ID` and `cell_type`, where `ID` has to be identical to the column names of the provides matrix/matrices. If not all cells appear in the annotation or matrix, the intersection of both is used to generate the dataset. \

Here is some example data:

```
counts <- Matrix::Matrix(matrix(stats::rpois(3e5, 5), ncol = 300), sparse = TRUE)
tpm <- Matrix::Matrix(matrix(stats::rpois(3e5, 5), ncol = 300), sparse = TRUE)
tpm <- Matrix::t(1e6 * Matrix::t(tpm) / Matrix::colSums(tpm))
colnames(counts) <- paste0("cell-", rep(1:300))
colnames(tpm) <- paste0("cell-", rep(1:300))
rownames(counts) <- paste0("gene-", rep(1:1000))
rownames(tpm) <- paste0("gene-", rep(1:1000))
annotation <- data.frame(
  "ID" = paste0("cell-", rep(1:300)),
  "cell_type" = c(
    rep("T cells CD4", 50),
    rep("T cells CD8", 50),
    rep("Macrophages", 100),
    rep("NK cells", 10),
    rep("B cells", 70),
    rep("Monocytes", 20)
  ),
  row.names = paste0("cell-", rep(1:300))
)
seurat_obj <- Seurat::CreateSeuratObject(counts = counts, assay = "gene_expression", meta.data = annotation)
# store normalized matrix in the 'data' layer
SeuratObject::LayerData(seurat_obj, assay = "gene_expression", layer = "data") <- tpm
seurat_obj
#> An object of class Seurat
#> 1000 features across 300 samples within 1 assay
#> Active assay: gene_expression (1000 features, 0 variable features)
#>  2 layers present: counts, data
```

### Seurat

It is possible to use a Seurat object to build a dataset; give the name of the assay containing count data in the `counts` slot, the name of the column in the meta table with the unique cell IDs and the name of the column in the meta table with the cell type identifier. Additionally you may give the name of the assay containing TPM data in the `counts` slot.

```
ds_seurat <- SimBu::dataset_seurat(
  seurat_obj = seurat_obj,
  counts_layer = "counts",
  cell_id_col = "ID",
  cell_type_col = "cell_type",
  tpm_layer = "data",
  name = "seurat_dataset"
)
#> Filtering genes...
#> Created dataset.
```

### h5ad files

It is possible to use an h5ad file directly, a file format which stores [AnnData](https://anndata.readthedocs.io/en/latest/) objects. As h5ad files can store cell specific information in the `obs` layer, no additional annotation input for SimBu is needed.
Note: if you want both counts and tpm data as input, you will have to provide two files; the cell annotation has to match between these two files. As SimBu expects the cells to be in the columns and genes/features in the rows of the input matrix, but this is not necessarily the case for anndata objects <https://falexwolf.de/img/scanpy/anndata.svg>, SimBu can handle h5ad files with cells in the `obs` or `var` layer. If your cells are in `obs`, use `cells_in_obs=TRUE` and `FALSE` otherwise. This will also automatically transpose the matrix.
To know, which columns in the cell annotation layer correspond to the cell identifiers and cell type labels, use the `cell_id_col` and `cell_type_col` parameters, respectively.\

As this function uses the `SimBu` python environment to read the h5ad files and extract the data, it may take some more time to initialize the conda environment at the *first* usage only.

```
# example h5ad file, where cell type info is stored in `obs` layer
# h5 <- system.file("extdata", "anndata.h5ad", package = "SimBu")
# ds_h5ad <- SimBu::dataset_h5ad(
#  h5ad_file_counts = h5,
#  name = "h5ad_dataset",
#  cell_id_col = 0, # this will use the rownames of the metadata as cell identifiers
#  cell_type_col = "group", # this will use the 'group' column of the metadata as cell type info
#  cells_in_obs = TRUE # in case your cell information is stored in the var layer, switch to FALSE
# )
```

## Merging datasets

You are able to merge multiple datasets by using the `dataset_merge` function:

```
ds <- SimBu::dataset(
  annotation = annotation,
  count_matrix = counts,
  tpm_matrix = tpm,
  name = "test_dataset"
)
#> Filtering genes...
#> Created dataset.
ds_multiple <- SimBu::dataset_merge(
  dataset_list = list(ds_seurat, ds),
  name = "ds_multiple"
)
#> Filtering genes...
#> Created dataset.
```

# Output

The `simulation` object contains three named entries: \

* `bulk`: a SummarizedExperiment object with the pseudo-bulk dataset(s) stored in the `assays`. They can be accessed like this:

```
simulation <- SimBu::simulate_bulk(
  data = ds_multiple,
  scenario = "random",
  scaling_factor = "NONE",
  nsamples = 10, ncells = 100
)
#> Finished simulation.
dim(SummarizedExperiment::assays(simulation$bulk)[["bulk_counts"]])
#> [1] 1000   10
dim(SummarizedExperiment::assays(simulation$bulk)[["bulk_tpm"]])
#> [1] 1000   10
```

If only the count matrix was given to the dataset initially, only the `bulk_counts` assay is filled.

* `cell_fractions`: a table where rows represent the simulated samples and columns represent the different simulated cell-types. The entries in the table store the specific cell-type fraction per sample.\
* `scaling_vector`: a named list, with the used scaling value for each cell from the single cell dataset. \

```
utils::sessionInfo()
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
#> [1] curl_7.0.0         Seurat_5.3.1       SeuratObject_5.2.0 sp_2.2-0
#> [5] SimBu_1.12.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
#>   [3] magrittr_2.0.4              spatstat.utils_3.2-0
#>   [5] farver_2.1.2                rmarkdown_2.30
#>   [7] vctrs_0.6.5                 ROCR_1.0-11
#>   [9] spatstat.explore_3.5-3      htmltools_0.5.8.1
#>  [11] S4Arrays_1.10.0             SparseArray_1.10.0
#>  [13] sass_0.4.10                 sctransform_0.4.2
#>  [15] parallelly_1.45.1           KernSmooth_2.23-26
#>  [17] bslib_0.9.0                 htmlwidgets_1.6.4
#>  [19] ica_1.0-3                   plyr_1.8.9
#>  [21] plotly_4.11.0               zoo_1.8-14
#>  [23] cachem_1.1.0                igraph_2.2.1
#>  [25] mime_0.13                   lifecycle_1.0.4
#>  [27] pkgconfig_2.0.3             Matrix_1.7-4
#>  [29] R6_2.6.1                    fastmap_1.2.0
#>  [31] MatrixGenerics_1.22.0       fitdistrplus_1.2-4
#>  [33] future_1.67.0               shiny_1.11.1
#>  [35] digest_0.6.37               patchwork_1.3.2
#>  [37] S4Vectors_0.48.0            tensor_1.5.1
#>  [39] RSpectra_0.16-2             irlba_2.3.5.1
#>  [41] GenomicRanges_1.62.0        labeling_0.4.3
#>  [43] progressr_0.17.0            spatstat.sparse_3.1-0
#>  [45] httr_1.4.7                  polyclip_1.10-7
#>  [47] abind_1.4-8                 compiler_4.5.1
#>  [49] withr_3.0.2                 S7_0.2.0
#>  [51] BiocParallel_1.44.0         fastDummies_1.7.5
#>  [53] MASS_7.3-65                 proxyC_0.5.2
#>  [55] DelayedArray_0.36.0         tools_4.5.1
#>  [57] lmtest_0.9-40               otel_0.2.0
#>  [59] httpuv_1.6.16               future.apply_1.20.0
#>  [61] goftest_1.2-3               glue_1.8.0
#>  [63] nlme_3.1-168                promises_1.4.0
#>  [65] grid_4.5.1                  Rtsne_0.17
#>  [67] cluster_2.1.8.1             reshape2_1.4.4
#>  [69] generics_0.1.4              gtable_0.3.6
#>  [71] spatstat.data_3.1-9         tidyr_1.3.1
#>  [73] data.table_1.17.8           XVector_0.50.0
#>  [75] BiocGenerics_0.56.0         spatstat.geom_3.6-0
#>  [77] RcppAnnoy_0.0.22            ggrepel_0.9.6
#>  [79] RANN_2.6.2                  pillar_1.11.1
#>  [81] stringr_1.5.2               spam_2.11-1
#>  [83] RcppHNSW_0.6.0              later_1.4.4
#>  [85] splines_4.5.1               dplyr_1.1.4
#>  [87] lattice_0.22-7              survival_3.8-3
#>  [89] deldir_2.0-4                tidyselect_1.2.1
#>  [91] miniUI_0.1.2                pbapply_1.7-4
#>  [93] knitr_1.50                  gridExtra_2.3
#>  [95] IRanges_2.44.0              Seqinfo_1.0.0
#>  [97] SummarizedExperiment_1.40.0 scattermore_1.2
#>  [99] stats4_4.5.1                xfun_0.53
#> [101] Biobase_2.70.0              matrixStats_1.5.0
#> [103] stringi_1.8.7               lazyeval_0.2.2
#> [105] yaml_2.3.10                 evaluate_1.0.5
#> [107] codetools_0.2-20            tibble_3.3.0
#> [109] cli_3.6.5                   uwot_0.2.3
#> [111] xtable_1.8-4                reticulate_1.44.0
#> [113] jquerylib_0.1.4             dichromat_2.0-0.1
#> [115] Rcpp_1.1.0                  spatstat.random_3.4-2
#> [117] globals_0.18.0              png_0.1-8
#> [119] spatstat.univar_3.1-4       parallel_4.5.1
#> [121] ggplot2_4.0.0               dotCall64_1.2
#> [123] sparseMatrixStats_1.22.0    listenv_0.9.1
#> [125] viridisLite_0.4.2           scales_1.4.0
#> [127] ggridges_0.5.7              purrr_1.1.0
#> [129] crayon_1.5.3                rlang_1.1.6
#> [131] cowplot_1.2.0
```