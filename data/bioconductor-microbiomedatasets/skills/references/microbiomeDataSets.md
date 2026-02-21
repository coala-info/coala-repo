# microbiomeDataSets

#### 2025-11-04

#### Package

microbiomeDataSets 1.18.0

# Contents

* [1 Microbiome example data sets](#microbiome-example-data-sets)

```
library(microbiomeDataSets)
```

# 1 Microbiome example data sets

The data sets are primarily named by the first author of the
associated publication, together with a descriptive suffix. Aliases
are provided for some of the data sets.

A table of the available data sets is available through the `availableDataSets`
function.

```
availableDataSets()
#>             Dataset
#> 1  GrieneisenTSData
#> 2       LahtiMLData
#> 3        LahtiMData
#> 4      OKeefeDSData
#> 5 SilvermanAGutData
#> 6        SongQAData
#> 7   SprockettTHData
```

All data are downloaded from ExperimentHub and cached for local
re-use. Check the [man pages of each
function](https://microbiome.github.io/microbiomeDataSets/reference/index.html)
for a detailed documentation of the data contents and original source.

The microbiome data is usually loaded as a
*[TreeSummarizedExperiment](https://bioconductor.org/packages/3.22/TreeSummarizedExperiment)*. If other associated data tables
(metabolomic, biomarker..) are provided, the integrated data
collection is provided as *[MultiAssayExperiment](https://bioconductor.org/packages/3.22/MultiAssayExperiment)*.

For more information on how to use these objects, please refer to the
vignettes of those packages.

```
#rebook::prettySessionInfo()
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
#>  [1] microbiomeDataSets_1.18.0       MultiAssayExperiment_1.36.0
#>  [3] TreeSummarizedExperiment_2.18.0 Biostrings_2.78.0
#>  [5] XVector_0.50.0                  SingleCellExperiment_1.32.0
#>  [7] SummarizedExperiment_1.40.0     Biobase_2.70.0
#>  [9] GenomicRanges_1.62.0            Seqinfo_1.0.0
#> [11] IRanges_2.44.0                  S4Vectors_0.48.0
#> [13] BiocGenerics_0.56.0             generics_0.1.4
#> [15] MatrixGenerics_1.22.0           matrixStats_1.5.0
#> [17] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0      httr2_1.2.1          xfun_0.54
#>  [4] bslib_0.9.0          lattice_0.22-7       vctrs_0.6.5
#>  [7] tools_4.5.1          yulab.utils_0.2.1    curl_7.0.0
#> [10] parallel_4.5.1       AnnotationDbi_1.72.0 RSQLite_2.4.3
#> [13] tibble_3.3.0         blob_1.2.4           pkgconfig_2.0.3
#> [16] BiocBaseUtils_1.12.0 Matrix_1.7-4         dbplyr_2.5.1
#> [19] lifecycle_1.0.4      compiler_4.5.1       treeio_1.34.0
#> [22] codetools_0.2-20     htmltools_0.5.8.1    sass_0.4.10
#> [25] yaml_2.3.10          lazyeval_0.2.2       pillar_1.11.1
#> [28] crayon_1.5.3         jquerylib_0.1.4      tidyr_1.3.1
#> [31] BiocParallel_1.44.0  DelayedArray_0.36.0  cachem_1.1.0
#> [34] abind_1.4-8          nlme_3.1-168         AnnotationHub_4.0.0
#> [37] ExperimentHub_3.0.0  tidyselect_1.2.1     digest_0.6.37
#> [40] BiocVersion_3.22.0   dplyr_1.1.4          purrr_1.1.0
#> [43] bookdown_0.45        fastmap_1.2.0        grid_4.5.1
#> [46] cli_3.6.5            SparseArray_1.10.1   magrittr_2.0.4
#> [49] S4Arrays_1.10.0      ape_5.8-1            filelock_1.0.3
#> [52] rappdirs_0.3.3       bit64_4.6.0-1        httr_1.4.7
#> [55] rmarkdown_2.30       bit_4.6.0            png_0.1-8
#> [58] memoise_2.0.1        evaluate_1.0.5       knitr_1.50
#> [61] BiocFileCache_3.0.0  rlang_1.1.6          Rcpp_1.1.0
#> [64] DBI_1.2.3            glue_1.8.0           tidytree_0.4.6
#> [67] BiocManager_1.30.26  jsonlite_2.0.0       R6_2.6.1
#> [70] fs_1.6.6
```