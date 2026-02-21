# 2-Wasserstein distance calculation

## Background

The 2-Wasserstein distance \(W\) is a metric to describe the distance between two distributions, representing e.g. two different conditions \(A\) and \(B\).

For continuous distributions, it is given by

\[W := W(F\_A, F\_B)
= \bigg( \int\_0^1 \big|F\_A^{-1}(u)
- F\_B^{-1}(u) \big|^2 du \bigg)^\frac{1}{2},\]

where \(F\_A\) and \(F\_B\) are the corresponding cumulative distribution functions (CDFs) and \(F\_A^{-1}\) and \(F\_B^{-1}\) the respective quantile functions.

We specifically consider the squared 2-Wasserstein distance \(d := W^2\) which offers the following decomposition into location, size, and shape terms: \[d := d(F\_A, F\_B)
= \int\_0^1 \big|F^{-1}(u) - F^{-1}(u) \big|^2 du
= \underbrace{\big(\mu\_A - \mu\_B\big)^2}\_{\text{location}}
+ \underbrace{\big(\sigma\_A - \sigma\_B\big)^2}\_{\text{size}}
+ \underbrace{2\sigma\_A \sigma\_B \big(1 - \rho^{A,B}\big)}\_{\text{shape}},\]

where \(\mu\_A\) and \(\mu\_B\) are the respective means, \(\sigma\_A\) and \(\sigma\_B\) are the respective standard deviations, and \(\rho^{A,B}\) is the Pearson correlation of the points in the quantile-quantile plot of \(F\_A\) and \(F\_B\).

## Usage in two-sample setting

In case the distributions \(F\_A\) and \(F\_B\) are not explicitly given and information is only availbale in the form of samples from \(F\_A\) and \(F\_B\), respectively, we use the corresponding empirical CDFs \(\hat{F}\_A\) and \(\hat{F}\_B\). Then, the 2-Wasserstein distance is computed by

\[d(\hat{F}\_A, \hat{F}\_B)
\approx \frac{1}{K} \sum\_{k=1}^K \big(Q\_A^{\alpha\_k} - Q\_B^{\alpha\_k} \big)
\approx \big(\hat{\mu}\_A - \hat{\mu}\_B\big)^2
+ \big(\hat{\sigma}\_A - \hat{\sigma}\_B\big)^2
+ 2\hat{\sigma}\_A \hat{\sigma}\_B \big(1 - \hat{\rho}^{A,B}\big).\]

Here, \(Q\_A\) and \(Q\_B\) denote equidistant quantiles of \(F\_A\) and \(F\_B\), respectively, at the levels \(\alpha\_k := \frac{k-0.5}{K}, k = 1, \dots , K\), where we use \(K:=1000\) in our implementation. Moreover, \(\hat{\mu}\_A, \hat{\mu}\_B, \hat{\sigma}\_A, \hat{\sigma}\_B\) and \(\hat{\rho}\_{A,B}\) denote the empirical versions of the corresponding quantities.

## Three implementations

The `waddR` package offers three functions to compute the 2-Wasserstein distance in two-sample settings.

We will use samples from normal distributions to illustrate them.

```
library(waddR)

set.seed(24)
x <- rnorm(100,mean=0,sd=1)
y <- rnorm(100,mean=2,sd=1)
```

The first function, `wasserstein_metric`, offers a faster reimplementation in C++ of the `wasserstein1d` function from the R package `transport`, which is able to compute general \(p\)-Wasserstein distances. For \(p=2\), we obtain the 2-Wasserstein distance \(W\).

```
wasserstein_metric(x,y,p=2)
#> [1] 2.044457
```

The corresponding value of the squared 2-Wasserstein distance \(d\) is then computed as:

```
wasserstein_metric(x,y,p=2)^2
#> [1] 4.179803
```

The second function, `squared_wass_approx`, computes the squared 2-Wasserstein distance by calculating the mean squared difference of the equidistant quantiles (first approximation in the previous formula). This function is currently used to compute the 2-Wasserstein distances in the testing procedures.

```
squared_wass_approx(x,y)
#> [1] 4.179803
```

The third function, `squared_wass_decomp`, approximates the squared 2-Wasserstein distance using the location, size, and shape terms from the above decomposition (second apporximation in the previous formula). It also returns the respective decomposition values.

```
squared_wass_decomp(x,y)
#> $distance
#> [1] 4.180458
#>
#> $location
#> [1] 4.114983
#>
#> $size
#> [1] 0.002307
#>
#> $shape
#> [1] 0.06316766
```

In the considered example, the decomposition results suggest that the two distributions differ with respect to location (mean), but not in terms of size and shape, thus confirming the underlying normal model.

## See also

* The [`waddR` package](waddR.html)
* [Two-sample tests](wasserstein_test.html) to check for differences between two distributions
* Detection of [differential gene expression distributions](wasserstein_singlecell.html) in scRNAseq data

## Session Info

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