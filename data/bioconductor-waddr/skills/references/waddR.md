# The `waddR` package

## Introduction

The `waddR` package offers statistical tests based on the 2-Wasserstein distance for detecting and characterizing differences between two distributions given in the form of samples. Functions for calculating the 2-Wasserstein distance and testing for differential distributions are provided, as well as a specifically tailored test for differential expression in single-cell RNA sequencing data.

`waddR` provides tools to address the following tasks, each described in a separate vignette:

* [Calculation of the 2-Wasserstein distance](wasserstein_metric.html),
* [Two-sample tests](wasserstein_test.html) to check for differences between two distributions,
* Detection of [differential gene expression distributions](wasserstein_singlecell.html) in single-cell RNA sequencing (scRNAseq) data.

These are bundled into one package, because they are internally dependent: The procedure for detecting differential distributions in scRNAseq data is an adaptation of the general two-sample test, which itself uses the 2-Wasserstein distance to compare two distributions.

### 2-Wasserstein distance functions

The 2-Wasserstein distance is a metric to describe the distance between two distributions, representing e.g. two diferent conditions \(A\) and \(B\). The `waddR` package specifically considers the squared 2-Wasserstein distance which can be decomposed into location, size, and shape terms, thus providing a characterization of potential differences.

The `waddR` package offers three functions to calculate the (squared) 2-Wasserstein distance, which are implemented in C++ and exported to R with Rcpp for faster computation. The function `wasserstein_metric` is a Cpp reimplementation of the `wasserstein1d` function from the R package `transport`. The functions `squared_wass_approx` and `squared_wass_decomp` compute approximations of the squared 2-Wasserstein distance, with `squared_wass_decomp` also returning the decomposition terms for location, size, and shape.

See `?wasserstein_metric`, `?squared_wass_aprox`, and `?squared_wass_decomp` for more details.

### Testing for differences between two distributions

The `waddR` package provides two testing procedures using the 2-Wasserstein distance to test whether two distributions \(F\_A\) and \(F\_B\) given in the form of samples are different by testing the null hypothesis \(H\_0: F\_A = F\_B\) against the alternative hypothesis \(H\_1: F\_A != F\_B\).

The first, semi-parametric (SP), procedure uses a permutation-based test combined with a generalized Pareto distribution approximation to estimate small p-values accurately.

The second procedure uses a test based on asymptotic theory (ASY) which is valid only if the samples can be assumed to come from continuous distributions.

See `?wasserstein.test` for more details.

### Testing for differences between two distributions in the context of scRNAseq data

The `waddR` package provides an adaptation of the semi-parametric testing procedure based on the 2-Wasserstein distance which is specifically tailored to identify differential distributions in scRNAseq data. In particular, a two-stage (TS) approach is implemented that takes account of the specific nature of scRNAseq data by separately testing for differential proportions of zero gene expression (using a logistic regression model) and differences in non-zero gene expression (using the semiparametric 2-Wasserstein distance-based test) between two conditions.

See `?wasserstein.sc` and `?testZeroes` for more details.

## Installation

To install `waddR` from Bioconductor, use `BiocManager` with the following commands:

```
if (!requireNamespace("BiocManager"))
 install.packages("BiocManager")
BiocManager::install("waddR")
```

Using `BiocManager`, the package can also be installed from GitHub directly:

```
BiocManager::install("goncalves-lab/waddR")
```

The package `waddR` can then be used in R:

```
library("waddR")
```

## Session info

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
#> [1] waddR_1.24.0
#>
#> loaded via a namespace (and not attached):
#>  [1] SummarizedExperiment_1.40.0 xfun_0.53
#>  [3] bslib_0.9.0                 httr2_1.2.1
#>  [5] Biobase_2.70.0              lattice_0.22-7
#>  [7] Rdpack_2.6.4                vctrs_0.6.5
#>  [9] tools_4.5.1                 generics_0.1.4
#> [11] stats4_4.5.1                curl_7.0.0
#> [13] parallel_4.5.1              tibble_3.3.0
#> [15] RSQLite_2.4.3               blob_1.2.4
#> [17] pkgconfig_2.0.3             Matrix_1.7-4
#> [19] arm_1.14-4                  dbplyr_2.5.1
#> [21] S4Vectors_0.48.0            lifecycle_1.0.4
#> [23] compiler_4.5.1              Seqinfo_1.0.0
#> [25] codetools_0.2-20            eva_0.2.6
#> [27] htmltools_0.5.8.1           sass_0.4.10
#> [29] yaml_2.3.10                 nloptr_2.2.1
#> [31] pillar_1.11.1               jquerylib_0.1.4
#> [33] MASS_7.3-65                 BiocParallel_1.44.0
#> [35] SingleCellExperiment_1.32.0 cachem_1.1.0
#> [37] DelayedArray_0.36.0         reformulas_0.4.2
#> [39] boot_1.3-32                 abind_1.4-8
#> [41] nlme_3.1-168                tidyselect_1.2.1
#> [43] digest_0.6.37               purrr_1.1.0
#> [45] dplyr_1.1.4                 splines_4.5.1
#> [47] fastmap_1.2.0               grid_4.5.1
#> [49] cli_3.6.5                   SparseArray_1.10.0
#> [51] magrittr_2.0.4              S4Arrays_1.10.0
#> [53] withr_3.0.2                 filelock_1.0.3
#> [55] rappdirs_0.3.3              bit64_4.6.0-1
#> [57] rmarkdown_2.30              XVector_0.50.0
#> [59] matrixStats_1.5.0           bit_4.6.0
#> [61] lme4_1.1-37                 memoise_2.0.1
#> [63] coda_0.19-4.1               evaluate_1.0.5
#> [65] knitr_1.50                  rbibutils_2.3
#> [67] GenomicRanges_1.62.0        IRanges_2.44.0
#> [69] BiocFileCache_3.0.0         rlang_1.1.6
#> [71] Rcpp_1.1.0                  glue_1.8.0
#> [73] DBI_1.2.3                   BiocGenerics_0.56.0
#> [75] minqa_1.2.8                 jsonlite_2.0.0
#> [77] R6_2.6.1                    MatrixGenerics_1.22.0
```