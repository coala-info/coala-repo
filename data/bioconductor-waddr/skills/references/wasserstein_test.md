# Two-sample tests based on the 2-Wasserstein distance

## Testing procedures

The `waddR` package provides two testing procedures using the 2-Wasserstein distance to test whether two distributions \(F\_A\) and \(F\_B\) given in the form of samples are different by specifically testing the null hypothesis \(H\_0: F\_A = F\_B\) against the alternative \(H\_1: F\_A \neq F\_B\).

The first, semi-parametric (SP), procedure uses a test based on permutations combined with a generalized Pareto distribution approximation to estimate small p-values accurately.

The second procedure (ASY) uses a test based on asymptotic theory which is valid only if the samples can be assumed to come from continuous distributions.

## Examples

To demonstrate the capabilities of the testing procedures, we consider models based on normal distributions here. We exemplarily construct three cases in which two distributions (samples) differ with respect to location, size, and shape, respectively, and one case without a difference. For convenience, we focus on the p-value, the value of the (squared) 2-Wasserstein distance, and the fractions of the location, size, and shape terms (in %) with respect to the (squared) 2-Wasserstein distance here, while the functions also provide additional output.

```
library(waddR)

spec.output<-c("pval","d.wass^2","perc.loc","perc.size","perc.shape")
```

We start with an example, in which the two distributions (samples) are supposed to only differ with respect to the location, and show the results for the two testing procedures (SP and ASY).

Note that the semi-parametric method “SP” with a permutation number of 10000 is used by default in `wasserstein.test` if nothing else is specified. The permutation procedure in the “SP” method uses a random group assignment step, and to obtain reproducible results, a seed can be set from the user environment before calling `wasserstein.test`.

```
set.seed(24)
ctrl<-rnorm(300,0,1)
dd1<-rnorm(300,1,1)
set.seed(32)
wasserstein.test(ctrl,dd1,method="SP",permnum=10000)[spec.output]
#>       pval   d.wass^2   perc.loc  perc.size perc.shape
#>   0.000000   1.162487  98.100000   0.070000   1.830000
wasserstein.test(ctrl,dd1,method="ASY")[spec.output]
#>       pval   d.wass^2   perc.loc  perc.size perc.shape
#>   0.000000   1.162487  98.100000   0.070000   1.830000
```

We obtain a very low p-value, clearly pointing at the existence of a difference, and see that differences with respect to location make up by far the major part of the 2-Wasserstein distance.

Analogously, we look at a case in which the two distributions (samples) are supposed to only differ with respect to the size.

```
set.seed(24)
ctrl<-rnorm(300,0,1)
dd2<-rnorm(300,0,2)
set.seed(32)
wasserstein.test(ctrl,dd2)[spec.output]
#>         pval     d.wass^2     perc.loc    perc.size   perc.shape
#> 2.931697e-12 1.148397e+00 1.200000e-01 9.618000e+01 3.700000e+00
wasserstein.test(ctrl,dd2,method="ASY")[spec.output]
#>       pval   d.wass^2   perc.loc  perc.size perc.shape
#>   0.000005   1.148397   0.120000  96.180000   3.700000
```

Similarly, we consider an example in which the two distributions (samples) are supposed to only differ with respect to the shape.

```
set.seed(24)
ctrl<-rnorm(300,6.5,sqrt(13.25))
sam1<-rnorm(300,3,1)
sam2<-rnorm(300,10,1)
dd3<-sapply(1:300,
              function(n) {
                sample(c(sam1[n],sam2[n]),1,prob=c(0.5, 0.5))})
set.seed(32)
wasserstein.test(ctrl,dd3)[spec.output]
#>         pval     d.wass^2     perc.loc    perc.size   perc.shape
#> 2.633310e-06 2.573153e+00 1.164000e+01 0.000000e+00 8.836000e+01
wasserstein.test(ctrl,dd3,method="ASY")[spec.output]
#>       pval   d.wass^2   perc.loc  perc.size perc.shape
#>   0.000006   2.573153  11.640000   0.000000  88.360000
```

Finally, we show an example in which the two distributions (samples) are supposed to be equal. We obtain a high p-value, indicating that the null hypothesis cannot be rejected.

```
set.seed(24)
ctrl<-rnorm(300,0,1)
nodd<-rnorm(300,0,1)
set.seed(32)
wasserstein.test(ctrl,nodd)[spec.output]
#>        pval    d.wass^2    perc.loc   perc.size  perc.shape
#>  0.48560000  0.02772574 17.06000000  3.01000000 79.93000000
wasserstein.test(ctrl,nodd,method="ASY")[spec.output]
#>        pval    d.wass^2    perc.loc   perc.size  perc.shape
#>  0.73892700  0.02772574 17.06000000  3.01000000 79.93000000
```

## See also

* The [`waddR` package](waddR.html)
* [Calculation of the Wasserstein distance](wasserstein_metric.html)
* Detection of [differential gene expression distributions](wasserstein_singlecell.html) in scRNAseq data

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] BiocFileCache_3.0.0         dbplyr_2.5.1
#>  [3] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [5] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [7] Seqinfo_1.0.0               IRanges_2.44.0
#>  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [11] generics_0.1.4              MatrixGenerics_1.22.0
#> [13] matrixStats_1.5.0           waddR_1.24.0
#>
#> loaded via a namespace (and not attached):
#>  [1] xfun_0.53           bslib_0.9.0         httr2_1.2.1
#>  [4] lattice_0.22-7      Rdpack_2.6.4        vctrs_0.6.5
#>  [7] tools_4.5.1         curl_7.0.0          parallel_4.5.1
#> [10] tibble_3.3.0        RSQLite_2.4.3       blob_1.2.4
#> [13] pkgconfig_2.0.3     Matrix_1.7-4        arm_1.14-4
#> [16] lifecycle_1.0.4     compiler_4.5.1      codetools_0.2-20
#> [19] eva_0.2.6           htmltools_0.5.8.1   sass_0.4.10
#> [22] yaml_2.3.10         nloptr_2.2.1        pillar_1.11.1
#> [25] jquerylib_0.1.4     MASS_7.3-65         BiocParallel_1.44.0
#> [28] cachem_1.1.0        DelayedArray_0.36.0 reformulas_0.4.2
#> [31] boot_1.3-32         abind_1.4-8         nlme_3.1-168
#> [34] tidyselect_1.2.1    digest_0.6.37       purrr_1.1.0
#> [37] dplyr_1.1.4         splines_4.5.1       fastmap_1.2.0
#> [40] grid_4.5.1          cli_3.6.5           SparseArray_1.10.0
#> [43] magrittr_2.0.4      S4Arrays_1.10.0     withr_3.0.2
#> [46] filelock_1.0.3      rappdirs_0.3.3      bit64_4.6.0-1
#> [49] rmarkdown_2.30      XVector_0.50.0      bit_4.6.0
#> [52] lme4_1.1-37         memoise_2.0.1       coda_0.19-4.1
#> [55] evaluate_1.0.5      knitr_1.50          rbibutils_2.3
#> [58] rlang_1.1.6         Rcpp_1.1.0          glue_1.8.0
#> [61] DBI_1.2.3           minqa_1.2.8         jsonlite_2.0.0
#> [64] R6_2.6.1
```