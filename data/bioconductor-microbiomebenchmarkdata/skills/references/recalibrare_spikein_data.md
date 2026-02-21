# Recalibration of the Stammler\_2016\_16S\_spikein dataset

Samuel D. Gamboa-Tuz\*

\*Samuel.Gamboa.Tuz@gmail.com

#### 4 November 2025

# Contents

* [0.1 Import data](#import-data)
* [0.2 Ids of the spike-in bacteria](#ids-of-the-spike-in-bacteria)
* [0.3 Recalibrate based on *Salinibacter ruber* abundance.](#recalibrate-based-on-salinibacter-ruber-abundance.)
* [0.4 A more convenient way using the scml function included in the package:](#a-more-convenient-way-using-the-scml-function-included-in-the-package)
* [1 Session information](#session-information)

One of the main characteristics of the Stammler\_2016\_16S\_spikein
dataset is the presence of spike-in bacteria with a known fixed amount of
bacterial cells. These known loads of bacteria can be used to recalibrate the
raw counts of the matrix and obtain recalibrated absolute counts. In this
vignette, we provide an example of how to recalibrate the counts of the count
matrix based on the read counts of *Salinibacter ruber*. This procedure is
referred to as Spike-in-based calibration to total microbial load (SCML) in
[Sammler et al., 2016](https://doi.org/10.1186/s40168-016-0175-0).

```
library(MicrobiomeBenchmarkData)
library(dplyr)
library(ggplot2)
library(tidyr)
```

## 0.1 Import data

```
tse <- getBenchmarkData('Stammler_2016_16S_spikein', dryrun = FALSE)[[1]]
#> Warning: No taxonomy_tree available for Stammler_2016_16S_spikein.
#> Finished Stammler_2016_16S_spikein.
counts <- assay(tse)
```

## 0.2 Ids of the spike-in bacteria

Identifiers of the spiked-in bacteria have the suffix ‘XXXX’.

| Bacteria | ID | Load |
| --- | --- | --- |
| *Salinibacter ruber* | AF323500XXXX | 3.0 x 108 |
| *Rhizobium radiobacter* | AB247615XXXX | 5.0 x 108 |
| *Alicyclobacillus acidiphilus* | AB076660XXXX | 1.0 x 108 |

## 0.3 Recalibrate based on *Salinibacter ruber* abundance.

This recalibration is based on the original article. The only difference is that
the numbers have been rounded up to obtain counts.

```
## AF323500XXXX is the unique OTU corresponding to S. ruber
s_ruber <- counts['AF323500XXXX', ]
size_factor <- s_ruber/mean(s_ruber)

SCML_data <- counts
for(i in seq(ncol(SCML_data))){
    SCML_data[,i] <- round(SCML_data[,i] / size_factor[i])
}
```

Brief comparison of counts

```
no_cal <- counts |>
    colSums() |>
    as.data.frame() |>
    tibble::rownames_to_column(var = 'sample_id') |>
    magrittr::set_colnames(c('sample_id', 'colSum')) |>
    mutate(calibrated = 'no') |>
    as_tibble()

cal <-  SCML_data |>
    colSums() |>
    as.data.frame() |>
    tibble::rownames_to_column(var = 'sample_id') |>
    magrittr::set_colnames(c('sample_id', 'colSum')) |>
    mutate(calibrated = 'yes') |>
    as_tibble()

data <- bind_rows(no_cal, cal)

data |>
    ggplot(aes(sample_id, colSum)) +
    geom_col(aes(fill = calibrated), position = 'dodge') +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
```

![](data:image/png;base64...)

The counts matrix can be replaced in the original tse in order to preserve the
same metadata.

```
assay(tse) <- SCML_data
tse
#> class: TreeSummarizedExperiment
#> dim: 4036 17
#> metadata(0):
#> assays(1): counts
#> rownames(4036): GQ448052 EU458484 ... DQ795992 GQ492848
#> rowData names(1): taxonomy
#> colnames(17): MID26 MID27 ... MID42 MID43
#> colData names(12): dataset subject_id ... country description
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
#> rowLinks: NULL
#> rowTree: NULL
#> colLinks: NULL
#> colTree: NULL
```

## 0.4 A more convenient way using the scml function included in the package:

```
tse <- getBenchmarkData('Stammler_2016_16S_spikein', dryrun = FALSE)[[1]]
#> Warning: No taxonomy_tree available for Stammler_2016_16S_spikein.
#> Finished Stammler_2016_16S_spikein.
tse <- scml(tse,bac = "s")
#> Re-calibrating counts with Salinibacter ruber (AF323500)
```

# 1 Session information

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
#>  [1] tidyr_1.3.1                     ggplot2_4.0.0
#>  [3] dplyr_1.1.4                     purrr_1.1.0
#>  [5] MicrobiomeBenchmarkData_1.12.0  TreeSummarizedExperiment_2.18.0
#>  [7] Biostrings_2.78.0               XVector_0.50.0
#>  [9] SingleCellExperiment_1.32.0     SummarizedExperiment_1.40.0
#> [11] Biobase_2.70.0                  GenomicRanges_1.62.0
#> [13] Seqinfo_1.0.0                   IRanges_2.44.0
#> [15] S4Vectors_0.48.0                BiocGenerics_0.56.0
#> [17] generics_0.1.4                  MatrixGenerics_1.22.0
#> [19] matrixStats_1.5.0               BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        httr2_1.2.1         xfun_0.54
#>  [4] bslib_0.9.0         lattice_0.22-7      vctrs_0.6.5
#>  [7] tools_4.5.1         yulab.utils_0.2.1   curl_7.0.0
#> [10] parallel_4.5.1      tibble_3.3.0        RSQLite_2.4.3
#> [13] blob_1.2.4          pkgconfig_2.0.3     Matrix_1.7-4
#> [16] RColorBrewer_1.1-3  dbplyr_2.5.1        S7_0.2.0
#> [19] lifecycle_1.0.4     farver_2.1.2        compiler_4.5.1
#> [22] treeio_1.34.0       tinytex_0.57        codetools_0.2-20
#> [25] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
#> [28] lazyeval_0.2.2      pillar_1.11.1       crayon_1.5.3
#> [31] jquerylib_0.1.4     BiocParallel_1.44.0 DelayedArray_0.36.0
#> [34] cachem_1.1.0        magick_2.9.0        abind_1.4-8
#> [37] nlme_3.1-168        tidyselect_1.2.1    digest_0.6.37
#> [40] bookdown_0.45       labeling_0.4.3      fastmap_1.2.0
#> [43] grid_4.5.1          cli_3.6.5           SparseArray_1.10.1
#> [46] magrittr_2.0.4      S4Arrays_1.10.0     dichromat_2.0-0.1
#> [49] ape_5.8-1           withr_3.0.2         scales_1.4.0
#> [52] filelock_1.0.3      rappdirs_0.3.3      bit64_4.6.0-1
#> [55] rmarkdown_2.30      bit_4.6.0           memoise_2.0.1
#> [58] evaluate_1.0.5      knitr_1.50          BiocFileCache_3.0.0
#> [61] rlang_1.1.6         Rcpp_1.1.0          glue_1.8.0
#> [64] tidytree_0.4.6      DBI_1.2.3           BiocManager_1.30.26
#> [67] jsonlite_2.0.0      R6_2.6.1            fs_1.6.6
```