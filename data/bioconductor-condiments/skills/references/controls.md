# More controls for the tests used in the condiments workflow

#### Hector Roux de Bézieux

#### 29 October , 2025

* [Toy dataset](#toy-dataset)
* [The **topologyTest** function](#the-topologytest-function)
  + [Changing the method or the threshold](#changing-the-method-or-the-threshold)
  + [Passing arguments to the test method](#passing-arguments-to-the-test-method)
  + [Using parallelisation](#using-parallelisation)
* [Differential progression and fate selection](#differential-progression-and-fate-selection)
  + [Default](#default)
  + [Changing the method and / or threshold](#changing-the-method-and-or-threshold)
  + [Passing more parameters to the test methods](#passing-more-parameters-to-the-test-methods)
* [Conclusion](#conclusion)
* [Session Info](#session-info)
* [References](#references)

This vignette is made for users that are already familiar with the basic *condiments* workflow described in [the first vignette](https://hectorrdb.github.io/condiments/articles/condiments.html). Here, we will show how to modify the default parameters for the first two steps of the workflow

```
# For analysis
library(condiments)
library(slingshot)
set.seed(21)
```

# Toy dataset

We rely on the same toy dataset as the first vignette

```
data("toy_dataset", package = "condiments")
df <- toy_dataset$sd
rd <- as.matrix(df[, c("Dim1", "Dim2")])
sds <- slingshot(rd, df$cl)
```

# The **topologyTest** function

By default, the **topologyTest** function requires only two inputs, the `sds` object and the `condition` labels. To limit run time for the vignette, we also change the default number of permutations used to generate trajectories under the null by setting the `rep` argument to \(10\) instead of the default \(100\). As such, the test statistics might be more variable.

```
top_res <- topologyTest(sds = sds, conditions = df$conditions, rep = 10)
```

```
## Generating permuted trajectories
```

```
## Running KS-mean test
```

```
knitr::kable(top_res)
```

| method | thresh | statistic | p.value |
| --- | --- | --- | --- |
| KS\_mean | 0.01 | 0 | 1 |

## Changing the method or the threshold

The **topologyTest** function can be relatively slow on large datasets. Moreover, when changing the method used to test the null hypothesis that a common trajectory should be fitted, the first permutation part of generating `rep` trajectories under the null is identical. Therefore, we allow users to specify more than one method and one value of the threshold. Here, we will use both the Kolmogorov-Smirnov test test(Smirnov 1939) and the classifier-test(Lopez-Paz and Oquab 2016).

```
top_res <- topologyTest(sds = sds, conditions = df$conditions, rep = 10,
                        methods = c("KS_mean", "Classifier"),
                        threshs = c(0, .01, .05, .1))
```

```
## Generating permuted trajectories
```

```
## Running KS-mean test
```

```
## Running Classifier test
```

```
knitr::kable(top_res)
```

| method | thresh | statistic | p.value |
| --- | --- | --- | --- |
| KS\_mean | 0 | 0.0070000 | 1.0000000 |
| KS\_mean | 0.01 | 0.0000000 | 1.0000000 |
| KS\_mean | 0.05 | 0.0000000 | 1.0000000 |
| KS\_mean | 0.1 | 0.0000000 | 1.0000000 |
| Classifier | 0 | 0.4150000 | 0.9999821 |
| Classifier | 0.01 | 0.3800000 | 1.0000000 |
| Classifier | 0.05 | 0.3333333 | 1.0000000 |
| Classifier | 0.1 | 0.2833333 | 1.0000000 |

To see all methods avaible, use /tmp/RtmpBAf1J8/Rinst3c25c576331424/condiments/help/topologyTest and look at the `methods` argument.

## Passing arguments to the test method

For all methods but the KS test, additional paramters can be specified, using a custom argument: `args_classifier`, `args_wass` or `args_mmd`. See the help file for given test more information on those parameters. For example, since the default test based on the wasserstein distance and permutation test is quite slow, we can pass a `fast` argument.

```
top_res <- topologyTest(sds = sds, conditions = df$conditions, rep = 10,
                        methods = "wasserstein_permutation",
                        args_wass = list(fast = TRUE, S = 100, iterations  = 10^2))
```

```
## Generating permuted trajectories
```

```
## Running wassertsein permutation test
```

```
knitr::kable(top_res)
```

| method | thresh | statistic | p.value |
| --- | --- | --- | --- |
| wasserstein\_permutation | NA | 1.356861 | 0.85 |

## Using parallelisation

For now, the first part of the **topologyTest** has been designed for parallelisation using the *BiocParallel* package. For example, to run with 4 cores, you can run the following command

```
library(BiocParallel)
BPPARAM <- bpparam()
BPPARAM$progressbar <- TRUE
BPPARAM$workers <- 4
top_res <- topologyTest(sds = sds, conditions = df$conditions, rep = 100,
                        parallel = TRUE, BPPARAM = BPPARAM)
knitr::kable(top_res)
```

# Differential progression and fate selection

The tests for the second test are much less compute-intensive, therefore there is no parallelisation. However, the other changes introduce in the previous section are still possible

## Default

```
prog_res <- progressionTest(sds, conditions = df$conditions)
knitr::kable(prog_res)
```

| lineage | statistic | p.value |
| --- | --- | --- |
| All | 5.504172 | 0 |

```
dif_res <- fateSelectionTest(sds, conditions = df$conditions)
```

```
## note: only 1 unique complexity parameters in default grid. Truncating the grid to 1 .
##
## note: only 1 unique complexity parameters in default grid. Truncating the grid to 1 .
```

```
knitr::kable(dif_res)
```

| pair | statistic | p.value |
| --- | --- | --- |
| 1vs2 | 0.6386486 | 1.9e-05 |

## Changing the method and / or threshold

```
prog_res <- progressionTest(sds, conditions = df$conditions, method = "Classifier")
knitr::kable(prog_res)
```

| lineage | statistic | p.value |
| --- | --- | --- |
| All | 0.5890991 | 0.0043539 |

```
dif_res <- fateSelectionTest(sds, conditions = df$conditions, thresh = .05)
```

```
## note: only 1 unique complexity parameters in default grid. Truncating the grid to 1 .
##
## note: only 1 unique complexity parameters in default grid. Truncating the grid to 1 .
```

```
knitr::kable(dif_res)
```

| pair | statistic | p.value |
| --- | --- | --- |
| 1vs2 | 0.6121622 | 0.0004817 |

## Passing more parameters to the test methods

```
prog_res <- progressionTest(sds, conditions = df$conditions, method = "Classifier",
                            args_classifier = list(method = "rf"))
```

```
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
## Warning in randomForest.default(x, y, mtry = param$mtry, ...): invalid mtry:
## reset to within valid range
```

```
## note: only 1 unique complexity parameters in default grid. Truncating the grid to 1 .
```

```
knitr::kable(prog_res)
```

| lineage | statistic | p.value |
| --- | --- | --- |
| All | 0.517027 | 0.3192952 |

```
dif_res <- fateSelectionTest(sds, conditions = df$conditions)
```

```
## note: only 1 unique complexity parameters in default grid. Truncating the grid to 1 .
##
## note: only 1 unique complexity parameters in default grid. Truncating the grid to 1 .
```

```
knitr::kable(dif_res)
```

| pair | statistic | p.value |
| --- | --- | --- |
| 1vs2 | 0.6611712 | 8e-07 |

# Conclusion

For all of the above procedures, it is important to note that we are making multiple comparisons. The p-values we obtain from these tests should be corrected for multiple testing, especially for trajectories with a large number of lineages.

That said, trajectory inference is often one of the last computational methods in a very long analysis pipeline (generally including gene-level quantification, gene filtering / feature selection, and dimensionality reduction). Hence, we strongly discourage the reader from putting too much faith in any p-value that comes out of this analysis. Such values may be useful suggestions, indicating particular features or cells for follow-up study, but should generally not be treated as meaningful statistical quantities.

If some commands and parameters are still unclear after going through this vignette, do not hesitate to open an issue on the *condiments* [Github repository](https://​github.com/%E2%80%8BHectorRDB/%E2%80%8Bcondiments/issues).

# Session Info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] caret_7.0-1                 lattice_0.22-7
##  [3] viridis_0.6.5               viridisLite_0.4.2
##  [5] RColorBrewer_1.1-3          ggplot2_4.0.0
##  [7] tidyr_1.3.1                 dplyr_1.1.4
##  [9] slingshot_2.18.0            TrajectoryUtils_1.18.0
## [11] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [13] Biobase_2.70.0              GenomicRanges_1.62.0
## [15] Seqinfo_1.0.0               IRanges_2.44.0
## [17] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [19] generics_0.1.4              MatrixGenerics_1.22.0
## [21] matrixStats_1.5.0           princurve_2.1.6
## [23] condiments_1.18.0           knitr_1.50
##
## loaded via a namespace (and not attached):
##   [1] jsonlite_2.0.0            magrittr_2.0.4
##   [3] spatstat.utils_3.2-0      ggbeeswarm_0.7.2
##   [5] farver_2.1.2              rmarkdown_2.30
##   [7] vctrs_0.6.5               DelayedMatrixStats_1.32.0
##   [9] htmltools_0.5.8.1         S4Arrays_1.10.0
##  [11] BiocNeighbors_2.4.0       SparseArray_1.10.0
##  [13] pROC_1.19.0.1             sass_0.4.10
##  [15] parallelly_1.45.1         bslib_0.9.0
##  [17] plyr_1.8.9                lubridate_1.9.4
##  [19] cachem_1.1.0              igraph_2.2.1
##  [21] lifecycle_1.0.4           iterators_1.0.14
##  [23] pkgconfig_2.0.3           rsvd_1.0.5
##  [25] Matrix_1.7-4              R6_2.6.1
##  [27] fastmap_1.2.0             future_1.67.0
##  [29] digest_0.6.37             scater_1.38.0
##  [31] irlba_2.3.5.1             beachmat_2.26.0
##  [33] labeling_0.4.3            randomForest_4.7-1.2
##  [35] timechange_0.3.0          abind_1.4-8
##  [37] mgcv_1.9-3                compiler_4.5.1
##  [39] rngtools_1.5.2            proxy_0.4-27
##  [41] withr_3.0.2               doParallel_1.0.17
##  [43] S7_0.2.0                  BiocParallel_1.44.0
##  [45] MASS_7.3-65               lava_1.8.1
##  [47] DelayedArray_0.36.0       ModelMetrics_1.2.2.2
##  [49] tools_4.5.1               vipor_0.4.7
##  [51] beeswarm_0.4.0            future.apply_1.20.0
##  [53] nnet_7.3-20               glue_1.8.0
##  [55] nlme_3.1-168              grid_4.5.1
##  [57] reshape2_1.4.4            recipes_1.3.1
##  [59] gtable_0.3.6              class_7.3-23
##  [61] data.table_1.17.8         BiocSingular_1.26.0
##  [63] ScaledMatrix_1.18.0       XVector_0.50.0
##  [65] ggrepel_0.9.6             RANN_2.6.2
##  [67] foreach_1.5.2             pillar_1.11.1
##  [69] stringr_1.5.2             limma_3.66.0
##  [71] Ecume_0.9.2               splines_4.5.1
##  [73] survival_3.8-3            tidyselect_1.2.1
##  [75] scuttle_1.20.0            pbapply_1.7-4
##  [77] transport_0.15-4          gridExtra_2.3
##  [79] xfun_0.53                 statmod_1.5.1
##  [81] hardhat_1.4.2             distinct_1.22.0
##  [83] timeDate_4051.111         stringi_1.8.7
##  [85] yaml_2.3.10               evaluate_1.0.5
##  [87] codetools_0.2-20          kernlab_0.9-33
##  [89] tibble_3.3.0              cli_3.6.5
##  [91] rpart_4.1.24              jquerylib_0.1.4
##  [93] dichromat_2.0-0.1         Rcpp_1.1.0
##  [95] globals_0.18.0            spatstat.univar_3.1-4
##  [97] parallel_4.5.1            gower_1.0.2
##  [99] doRNG_1.8.6.2             sparseMatrixStats_1.22.0
## [101] listenv_0.9.1             ipred_0.9-15
## [103] scales_1.4.0              prodlim_2025.04.28
## [105] e1071_1.7-16              purrr_1.1.0
## [107] crayon_1.5.3              rlang_1.1.6
```

# References

Lopez-Paz, David, and Maxime Oquab. 2016. “Revisiting Classifier Two-Sample Tests.” *Arxiv*, October, 1–15. <http://arxiv.org/abs/1610.06545>.

Smirnov, Nikolai V. 1939. “On the Estimation of the Discrepancy Between Empirical Curves of Distribution for Two Independent Samples.” *Bull. Math. Univ. Moscou* 2 (2): 3–14.