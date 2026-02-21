# E. Issues & Solutions

Original version: 16 October, 2023

```
library(AlphaMissenseR)
```

# Updating [duckdb](https://CRAN.R-project.org/package%3Dduckdb) to 0.9.1

The R duckdb client version 0.9.1 cannot read databases created with previous versions of the package. The duckdb error message indicates

> > am\_available() Error in h(simpleError(msg, call)) : error in evaluating the argument ‘drv’ in selecting a method for function ‘dbConnect’: rapi\_startup: Failed to open database: IO Error: Trying to read a database file with version number 51, but we can only read version 64.
>
> The database file was created with DuckDB version v0.8.0 or v0.8.1.
>
> The storage of DuckDB is not yet stable; newer versions of DuckDB cannot read old database files and vice versa. The storage will be stabilized when version 1.0 releases.
>
> For now, we recommend that you load the database file in a supported version of DuckDB, and use the EXPORT DATABASE command followed by IMPORT DATABASE on the current version of DuckDB.

> See the storage page for more information: <https://duckdb.org/internals/storage>

but in practice the most straight-forward solution is to remove existing AlphaMissenseR data resources and ‘start again’.

The following attempts to identify AlphaMissenseR data resources cached locally

```
am_rids <-
    bfcinfo() |>
    dplyr::filter(
        grepl("zenodo", rname) |
        startsWith(rname, "AlphaMissense_")
    ) |>
    pull(rid)
```

After verifying that these resources have not been created outside AlphaMissenseR, remove them.

```
BiocFileCache::bfcremove(rids = am_rids)
```

Commands such as `am_available()` should report no files cached. The command

```
am_data("gene_hg38")
#> # Source:   table<gene_hg38> [?? x 2]
#> # Database: DuckDB 1.4.2 [biocbuild@Linux 6.8.0-79-generic:R 4.5.2//home/biocbuild/.cache/R/BiocFileCache/19e9f02faae911_19e9f02faae911]
#>    transcript_id      mean_am_pathogenicity
#>    <chr>                              <dbl>
#>  1 ENST00000000233.10                 0.742
#>  2 ENST00000000412.8                  0.378
#>  3 ENST00000001008.6                  0.422
#>  4 ENST00000001146.6                  0.467
#>  5 ENST00000002125.9                  0.351
#>  6 ENST00000002165.11                 0.406
#>  7 ENST00000002501.10                 0.320
#>  8 ENST00000002596.6                  0.471
#>  9 ENST00000002829.8                  0.524
#> 10 ENST00000003084.10                 0.405
#> # ℹ more rows
```

will re-download the file and insert it into a database that functions with duckdb 0.9.1.

# Resource temporarily unavailable

Trying to access a data resource with `am_data()` may sometimes result in a DuckDB errors about “Resource unavailable”.

```
> am_data("hg38")

* [10:05:09][warning] error in evaluating the argument 'drv' in selecting a
    method for function 'dbConnect': rapi_startup: Failed to open database:
    IO Error: Could not set lock on file
    ".../Caches/org.R-project.R/R/BiocFileCache/1ec5157ddaa2_1ec5157ddaa2":
    Resource unavailable

Error in value[[3L]](cond) :
    failed to connect to DuckDB database, see 'Issues & Solutions' vignette
```

This occures when the database is being used by an independent *R* process. The solution is to identify the process and disconnect from the database using, e.g., `db_disconnect_all()`.

# Finally

Remember to disconnect and shutdown all managed DuckDB connections.

```
db_disconnect_all()
#> * [16:17:59][info] disconnecting all registered connections
```

Database connections that are not closed correctly trigger warning messages.

# Session information

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
#>  [1] ensembldb_2.34.0        AnnotationFilter_1.34.0 GenomicFeatures_1.62.0
#>  [4] AnnotationDbi_1.72.0    Biobase_2.70.0          GenomicRanges_1.62.0
#>  [7] Seqinfo_1.0.0           IRanges_2.44.0          S4Vectors_0.48.0
#> [10] ProteinGymR_1.4.0       ggplot2_4.0.1           ggdist_3.3.3
#> [13] tidyr_1.3.1             ExperimentHub_3.0.0     AnnotationHub_4.0.0
#> [16] BiocFileCache_3.0.0     dbplyr_2.5.1            BiocGenerics_0.56.0
#> [19] generics_0.1.4          AlphaMissenseR_1.6.1    dplyr_1.1.4
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.3                   bitops_1.0-9
#>   [3] httr2_1.2.1                 rlang_1.1.6
#>   [5] magrittr_2.0.4              otel_0.2.0
#>   [7] matrixStats_1.5.0           compiler_4.5.2
#>   [9] RSQLite_2.4.4               png_0.1-8
#>  [11] vctrs_0.6.5                 ProtGenerics_1.42.0
#>  [13] stringr_1.6.0               pkgconfig_2.0.3
#>  [15] crayon_1.5.3                fastmap_1.2.0
#>  [17] XVector_0.50.0              labeling_0.4.3
#>  [19] utf8_1.2.6                  Rsamtools_2.26.0
#>  [21] promises_1.5.0              rmarkdown_2.30
#>  [23] UCSC.utils_1.6.0            purrr_1.2.0
#>  [25] bit_4.6.0                   xfun_0.54
#>  [27] cachem_1.1.0                cigarillo_1.0.0
#>  [29] queryup_1.0.5               GenomeInfoDb_1.46.1
#>  [31] jsonlite_2.0.0              blob_1.2.4
#>  [33] later_1.4.4                 DelayedArray_0.36.0
#>  [35] BiocParallel_1.44.0         parallel_4.5.2
#>  [37] spdl_0.0.5                  R6_2.6.1
#>  [39] bslib_0.9.0                 stringi_1.8.7
#>  [41] RColorBrewer_1.1-3          rtracklayer_1.70.0
#>  [43] jquerylib_0.1.4             SummarizedExperiment_1.40.0
#>  [45] Rcpp_1.1.0                  knitr_1.50
#>  [47] BiocBaseUtils_1.12.0        Matrix_1.7-4
#>  [49] httpuv_1.6.16               tidyselect_1.2.1
#>  [51] abind_1.4-8                 dichromat_2.0-0.1
#>  [53] yaml_2.3.10                 codetools_0.2-20
#>  [55] curl_7.0.0                  rjsoncons_1.3.2
#>  [57] lattice_0.22-7              tibble_3.3.0
#>  [59] shiny_1.11.1                bio3d_2.4-5
#>  [61] withr_3.0.2                 KEGGREST_1.50.0
#>  [63] S7_0.2.1                    evaluate_1.0.5
#>  [65] r3dmol_0.1.2                Biostrings_2.78.0
#>  [67] pillar_1.11.1               BiocManager_1.30.27
#>  [69] filelock_1.0.3              MatrixGenerics_1.22.0
#>  [71] whisker_0.4.1               distributional_0.5.0
#>  [73] RCurl_1.98-1.17             BiocVersion_3.22.0
#>  [75] scales_1.4.0                xtable_1.8-4
#>  [77] glue_1.8.0                  lazyeval_0.2.2
#>  [79] tools_4.5.2                 BiocIO_1.20.0
#>  [81] GenomicAlignments_1.46.0    XML_3.99-0.20
#>  [83] grid_4.5.2                  colorspace_2.1-2
#>  [85] RcppSpdlog_0.0.23           duckdb_1.4.2
#>  [87] restfulr_0.0.16             cli_3.6.5
#>  [89] rappdirs_0.3.3              shiny.gosling_1.6.0
#>  [91] S4Arrays_1.10.0             viridisLite_0.4.2
#>  [93] gtable_0.3.6                sass_0.4.10
#>  [95] digest_0.6.39               SparseArray_1.10.3
#>  [97] rjson_0.2.23                htmlwidgets_1.6.4
#>  [99] farver_2.1.2                memoise_2.0.1
#> [101] htmltools_0.5.8.1           lifecycle_1.0.4
#> [103] httr_1.4.7                  mime_0.13
#> [105] bit64_4.6.0-1
```