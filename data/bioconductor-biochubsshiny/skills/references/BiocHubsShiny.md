# BiocHubsShiny: Interactive Display of Hub Resources

Marcel Ramos1 and Vincent J. Carey2

1CUNY Graduate School of Public Health and Health Policy, New York, NY USA
2Channing Lab, Brigham and Womens Hospital, Harvard University, Boston, MA USA

#### 29 October 2025

#### Package

BiocHubsShiny 1.10.0

# 1 BiocHubsShiny

The `BiocHubsShiny` package allows users to visually explore the `AnnotationHub`
and `ExperimentHub` resources via `shiny`. It provides a tabular display of the
available resources with the ability to filter and search through the column
fields.

# 2 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BiocHubsShiny")
```

# 3 Loading the package

```
library(BiocHubsShiny)
```

# 4 Display of resources

Resources are displayed interactively using the eponymous function:

```
BiocHubsShiny()
```

![](data:image/png;base64...)

# 5 Filtering

You can filter by any of the columns in the table. For example, you can search
for ‘Mus musculus’ to get resources only for that species:

![](data:image/png;base64...)

# 6 Selection

Click on the rows to select the resources. They will show up as highlighted
rows.

![](data:image/png;base64...)

# 7 Import

Once the selection is highlighted, the code at the bottom of the app
will be updated to show the commands for entering (reproducibly) into
the R session.

![](data:image/png;base64...)

# 8 Session Info

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
#> [1] BiocHubsShiny_1.10.0 shiny_1.11.1         BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] rappdirs_0.3.3       sass_0.4.10          generics_0.1.4
#>  [4] BiocVersion_3.22.0   RSQLite_2.4.3        digest_0.6.37
#>  [7] magrittr_2.0.4       evaluate_1.0.5       bookdown_0.45
#> [10] fastmap_1.2.0        blob_1.2.4           AnnotationHub_4.0.0
#> [13] jsonlite_2.0.0       AnnotationDbi_1.72.0 DBI_1.2.3
#> [16] promises_1.4.0       BiocManager_1.30.26  httr_1.4.7
#> [19] Biostrings_2.78.0    codetools_0.2-20     httr2_1.2.1
#> [22] jquerylib_0.1.4      cli_3.6.5            crayon_1.5.3
#> [25] rlang_1.1.6          XVector_0.50.0       dbplyr_2.5.1
#> [28] Biobase_2.70.0       bit64_4.6.0-1        cachem_1.1.0
#> [31] yaml_2.3.10          otel_0.2.0           tools_4.5.1
#> [34] memoise_2.0.1        dplyr_1.1.4          filelock_1.0.3
#> [37] httpuv_1.6.16        ExperimentHub_3.0.0  BiocGenerics_0.56.0
#> [40] curl_7.0.0           png_0.1-8            vctrs_0.6.5
#> [43] R6_2.6.1             mime_0.13            stats4_4.5.1
#> [46] lifecycle_1.0.4      BiocFileCache_3.0.0  Seqinfo_1.0.0
#> [49] KEGGREST_1.50.0      IRanges_2.44.0       S4Vectors_0.48.0
#> [52] bit_4.6.0            pkgconfig_2.0.3      bslib_0.9.0
#> [55] pillar_1.11.1        later_1.4.4          glue_1.8.0
#> [58] Rcpp_1.1.0           xfun_0.53            tibble_3.3.0
#> [61] tidyselect_1.2.1     knitr_1.50           xtable_1.8-4
#> [64] htmltools_0.5.8.1    rmarkdown_2.30       compiler_4.5.1
```