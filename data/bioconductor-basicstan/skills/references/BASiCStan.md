# An introduction to BASiCStan

### A Stan implementation of BASiCS

# Outline

This package implements alternative inference methods for [BASiCS](https://bioconductor.org/packages/release/bioc/html/BASiCS.html). The original package uses adaptive Metropolis within Gibbs sampling, while BASiCStan uses Stan to enable the use of maximum *a posteriori* estimation, variational inference, and Hamiltonian Monte Carlo. These each have advantages for different use cases.

# Use

To use `BASiCStan`, we can first use `BASICS_MockSCE()` to generate an toy example dataset. We will also set a seed for reproducibility.

```
suppressPackageStartupMessages(library("BASiCStan"))
set.seed(42)
sce <- BASiCS_MockSCE()
```

The interface for running MCMC using BASiCS and using alternative inference methods using Stan is very similar. It is worth noting that the joint prior between mean and over-dispersion parameters, corresponding to `Regression = TRUE`, is the only supported mode in `BASiCStan()`.

```
amwg_fit <- BASiCS_MCMC(
    sce,
    N = 200,
    Thin = 10,
    Burn = 100,
    Regression = TRUE
)
#> altExp 'spike-ins' is assumed to contain spike-in genes.
#> see help(altExp) for details.
#> Running with spikes BASiCS sampler (regression case) ...
#> -------------------------------------------------------------
#> MCMC running time
#> -------------------------------------------------------------
#> user: 0.341
#> system: 0.002
#> elapsed: 0.343
#> -------------------------------------------------------------
#> Output
#> -------------------------------------------------------------
#> -------------------------------------------------------------
#> BASiCS version 2.22.0 :
#> vertical integration (spikes case)
#> -------------------------------------------------------------
stan_fit <- BASiCStan(sce, Method = "sampling", iter = 10)
#> Warning: There were 5 divergent transitions after warmup. See
#> https://mc-stan.org/misc/warnings.html#divergent-transitions-after-warmup
#> to find out why this is a problem and how to eliminate them.
#> Warning: Examine the pairs() plot to diagnose sampling problems
```

The output of `BASiCStan()` is an object of class `BASiCS_Chain`, similar to the output of `BASiCS_MCMC()`. Therefore, you could use these as you would an object generated using Metropolis within Gibbs sampling. For example, we can plot the relationship between mean and over-dispersion estimated using the joint regression prior:

```
BASiCS_ShowFit(amwg_fit)
```

![](data:image/png;base64...)

```
BASiCS_ShowFit(stan_fit)
```

![](data:image/png;base64...)

# Stan MCMC diagnostics

Using Stan has advantages outside of the variety of inference engines available. By returning a Stan object that we can later convert to a `BASiCS_Chain` object, we can leverage an even broader set of functionality. For example, Stan has the ability to easily generate MCMC diagnostics using simple functions. For example, `summary()` outputs a number of useful per-chain and across-chain diagnostics:

```
stan_obj <- BASiCStan(sce, ReturnBASiCS = FALSE, Method = "sampling", iter = 10)
#>
#> SAMPLING FOR MODEL 'basics_regression' NOW (CHAIN 1).
#> Chain 1:
#> Chain 1: Gradient evaluation took 0.003146 seconds
#> Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 31.46 seconds.
#> Chain 1: Adjust your expectations accordingly!
#> Chain 1:
#> Chain 1:
#> Chain 1: WARNING: No variance estimation is
#> Chain 1:          performed for num_warmup < 20
#> Chain 1:
#> Chain 1: Iteration: 1 / 10 [ 10%]  (Warmup)
#> Chain 1: Iteration: 2 / 10 [ 20%]  (Warmup)
#> Chain 1: Iteration: 3 / 10 [ 30%]  (Warmup)
#> Chain 1: Iteration: 4 / 10 [ 40%]  (Warmup)
#> Chain 1: Iteration: 5 / 10 [ 50%]  (Warmup)
#> Chain 1: Iteration: 6 / 10 [ 60%]  (Sampling)
#> Chain 1: Iteration: 7 / 10 [ 70%]  (Sampling)
#> Chain 1: Iteration: 8 / 10 [ 80%]  (Sampling)
#> Chain 1: Iteration: 9 / 10 [ 90%]  (Sampling)
#> Chain 1: Iteration: 10 / 10 [100%]  (Sampling)
#> Chain 1:
#> Chain 1:  Elapsed Time: 0.045 seconds (Warm-up)
#> Chain 1:                0.027 seconds (Sampling)
#> Chain 1:                0.072 seconds (Total)
#> Chain 1:
#> Warning: There were 5 divergent transitions after warmup. See
#> https://mc-stan.org/misc/warnings.html#divergent-transitions-after-warmup
#> to find out why this is a problem and how to eliminate them.
#> Warning: Examine the pairs() plot to diagnose sampling problems
head(summary(stan_obj)$summary)
#>               mean se_mean sd     2.5%      25%      50%      75%    97.5%
#> log_mu[1] 3.098420     NaN  0 3.098420 3.098420 3.098420 3.098420 3.098420
#> log_mu[2] 1.058488     NaN  0 1.058488 1.058488 1.058488 1.058488 1.058488
#> log_mu[3] 2.107672     NaN  0 2.107672 2.107672 2.107672 2.107672 2.107672
#> log_mu[4] 2.245089     NaN  0 2.245089 2.245089 2.245089 2.245089 2.245089
#> log_mu[5] 2.002693     NaN  0 2.002693 2.002693 2.002693 2.002693 2.002693
#> log_mu[6] 1.457520     NaN  0 1.457520 1.457520 1.457520 1.457520 1.457520
#>           n_eff Rhat
#> log_mu[1]   NaN  NaN
#> log_mu[2]   NaN  NaN
#> log_mu[3]   NaN  NaN
#> log_mu[4]   NaN  NaN
#> log_mu[5]   NaN  NaN
#> log_mu[6]   NaN  NaN
```

We can then convert this object to a `BASiCS_Chain` and carry on a workflow as before:

```
Stan2BASiCS(stan_obj)
#> An object of class BASiCS_Chain
#>  5 MCMC samples.
#>  Dataset contains 100 biological genes and 100 cells (2 batches).
#>  Object stored using BASiCS version:  2.22.0
#>  Parameters:  mu delta s nu theta epsilon phi beta
```

# Session info

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
#>  [1] BASiCStan_1.12.0            rstan_2.32.7
#>  [3] StanHeaders_2.32.10         BASiCS_2.22.0
#>  [5] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [7] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [9] Seqinfo_1.0.0               IRanges_2.44.0
#> [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [13] generics_0.1.4              MatrixGenerics_1.22.0
#> [15] matrixStats_1.5.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gridExtra_2.3             inline_0.3.21
#>  [3] rlang_1.1.6               magrittr_2.0.4
#>  [5] otel_0.2.0                compiler_4.5.1
#>  [7] DelayedMatrixStats_1.32.0 loo_2.8.0
#>  [9] vctrs_0.6.5               pkgconfig_2.0.3
#> [11] fastmap_1.2.0             backports_1.5.0
#> [13] XVector_0.50.0            labeling_0.4.3
#> [15] scuttle_1.20.0            promises_1.4.0
#> [17] rmarkdown_2.30            xfun_0.53
#> [19] bluster_1.20.0            cachem_1.1.0
#> [21] beachmat_2.26.0           jsonlite_2.0.0
#> [23] later_1.4.4               DelayedArray_0.36.0
#> [25] BiocParallel_1.44.0       irlba_2.3.5.1
#> [27] parallel_4.5.1            cluster_2.1.8.1
#> [29] R6_2.6.1                  bslib_0.9.0
#> [31] RColorBrewer_1.1-3        limma_3.66.0
#> [33] jquerylib_0.1.4           Rcpp_1.1.0
#> [35] assertthat_0.2.1          knitr_1.50
#> [37] splines_4.5.1             httpuv_1.6.16
#> [39] Matrix_1.7-4              igraph_2.2.1
#> [41] tidyselect_1.2.1          dichromat_2.0-0.1
#> [43] abind_1.4-8               yaml_2.3.10
#> [45] viridis_0.6.5             codetools_0.2-20
#> [47] miniUI_0.1.2              curl_7.0.0
#> [49] pkgbuild_1.4.8            lattice_0.22-7
#> [51] tibble_3.3.0              withr_3.0.2
#> [53] shiny_1.11.1              S7_0.2.0
#> [55] posterior_1.6.1           coda_0.19-4.1
#> [57] evaluate_1.0.5            RcppParallel_5.1.11-1
#> [59] pillar_1.11.1             tensorA_0.36.2.1
#> [61] checkmate_2.3.3           distributional_0.5.0
#> [63] ggplot2_4.0.0             sparseMatrixStats_1.22.0
#> [65] rstantools_2.5.0          scales_1.4.0
#> [67] xtable_1.8-4              glue_1.8.0
#> [69] metapod_1.18.0            tools_4.5.1
#> [71] hexbin_1.28.5             BiocNeighbors_2.4.0
#> [73] ScaledMatrix_1.18.0       locfit_1.5-9.12
#> [75] scran_1.38.0              cowplot_1.2.0
#> [77] grid_4.5.1                QuickJSR_1.8.1
#> [79] edgeR_4.8.0               BiocSingular_1.26.0
#> [81] cli_3.6.5                 rsvd_1.0.5
#> [83] S4Arrays_1.10.0           viridisLite_0.4.2
#> [85] dplyr_1.1.4               V8_8.0.1
#> [87] glmGamPoi_1.22.0          gtable_0.3.6
#> [89] sass_0.4.10               digest_0.6.37
#> [91] SparseArray_1.10.0        dqrng_0.4.1
#> [93] farver_2.1.2              htmltools_0.5.8.1
#> [95] lifecycle_1.0.4           statmod_1.5.1
#> [97] mime_0.13                 ggExtra_0.11.0
#> [99] MASS_7.3-65
```