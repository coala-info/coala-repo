# switchde: inference of switch-like gene behaviour along single-cell trajectories

Kieran Campbell

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Pre-filtering of genes](#pre-filtering-of-genes)
* [4 Example usage](#example-usage)
  + [4.1 Non-zero inflated](#non-zero-inflated)
  + [4.2 Zero-inflation](#zero-inflation)
    - [4.2.1 Controlling the EM algorithm](#controlling-the-em-algorithm)
* [5 Use cases](#use-cases)
* [6 Technical info](#technical-info)

# 1 Introduction

`switchde` is an `R` package for detecting switch-like differential expression along single-cell RNA-seq trajectories. It assumes genes follow a sigmoidal pattern of gene expression and tests for differential expression using a likelihood ratio test. It also returns maximum likelihood estimates (MLE) for the sigmoid parameters, which allows filtering of genes for up or down regulation as well as where along the trajectory the regulation occurs.

The parametric form of gene expression assumed is a sigmoid:

```
example_sigmoid()
```

![](data:image/png;base64...)

Governed by three parameters:

* \(\mu\_0\) The half-peak expression
* \(k\) The ‘activation strength’. If positive, the gene is upregulated along the trajectory; if negative, the gene is downregulated. The magnitude of \(k\) corresponds to how fast the gene is up or down regulated.
* \(t\_0\) The ‘activation time’, or where in the trajectory this behaviour occurs. Note this parameter should be interpreted with respect to the overall range of the pseudotimes supplied.

# 2 Installation

`switchde` can be installed from both Bioconductor and Github.

Example installation from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("switchde")
```

Example installation from Github:

```
devtools::install_github("kieranrcampbell/switchde")
```

# 3 Pre-filtering of genes

Several inputs will cause issues in maximum likelihood and expecatation maximisation algorithms typically leading to error messages such as ‘finite gradient required’. To avoid these, strict pre-filtering of genes is advised such as retaining genes with a certain mean expression and expressed in a certain proportion of cells. For example, if the matrix `X` represents logged expression data, we can retain only genes with mean expression greater than 1 and expressed in 20% of cells via

```
X_filtered <- X[rowMeans(X) > 0.1 & rowMeans(X > 0) > 0.2,]
```

By default, `switchde` also sets any expression less than 0.01 to 0. This can be controlled via the `lower_threshold` parameter.

# 4 Example usage

We provide a brief example on some synthetic single-cell data bundled with the package. `synth_gex` contains a 12-by-100 expression matrix of 12 genes, and `ex_pseudotime` contains a pseudotime vector of length 100. We can start by plotting the expression:

```
data(synth_gex)
data(ex_pseudotime)

gex_cleaned <- as_data_frame(t(synth_gex)) %>%
  dplyr::mutate(Pseudotime = ex_pseudotime) %>%
  tidyr::gather(Gene, Expression, -Pseudotime)
```

```
## Warning: `as_data_frame()` was deprecated in tibble 2.0.0.
## ℹ Please use `as_tibble()` (with slightly different semantics) to convert to a
##   tibble, or `as.data.frame()` to convert to a data frame.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
ggplot(gex_cleaned, aes(x = Pseudotime, y = Expression)) +
  facet_wrap(~ Gene) + geom_point(shape = 21, fill = 'grey', color = 'black') +
  theme_bw() + stat_smooth(color = 'darkred', se = FALSE)
```

```
## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

![](data:image/png;base64...)

## 4.1 Non-zero inflated

Model fitting and differential expression testing is provided by a call to the `switchde` function:

```
sde <- switchde(synth_gex, ex_pseudotime)
```

```
## Input gene-by-cell matrix: 12 genes and  100 cells
```

This can equivalently be called using an `SingleCellExperiment` from the package `SingleCellExperiment`:

```
sce <- SingleCellExperiment(assays = list(exprs = synth_gex))
sde <- switchde(sce, ex_pseudotime)
```

This returns a `data.frame` with 6 columns:

* `gene` The gene name, taken from either `featureNames(sce)` or `rowNames(X)`
* `pval` The p-value associated with differential expression
* `qval` The Benjamini-Hochberg corrected q-value associated with differential expression
* `mu0` The MLE estimate of \(\mu\_0\)
* `k` The MLE estimate of \(k\)
* `t0` The MLE estimate of \(t\_0\)

We can use the function `arrange` from `dplyr` to order this by q-value:

```
dplyr::arrange(sde, qval)
```

```
## # A tibble: 12 × 6
##    gene       pval     qval   mu0     k     t0
##    <chr>     <dbl>    <dbl> <dbl> <dbl>  <dbl>
##  1 Gene8  6.51e-21 7.81e-20  5.32 -9.22  0.168
##  2 Gene2  1.03e-12 6.18e-12  3.45  6.79  0.701
##  3 Gene9  3.39e-12 1.36e-11  5.53 -5.05  0.318
##  4 Gene1  9.48e-12 2.84e-11  3.86  7.51  0.567
##  5 Gene5  1.54e-11 3.71e-11  3.51 10.3   0.475
##  6 Gene4  4.83e-10 9.66e-10 12.8  -3.22 -0.211
##  7 Gene3  2.20e- 8 3.76e- 8  4.20 -5.00  0.558
##  8 Gene10 4.47e- 8 6.71e- 8  3.18  8.47  0.380
##  9 Gene7  4.27e- 6 5.70e- 6  3.78  7.42  0.302
## 10 Gene12 3.36e- 4 4.04e- 4  4.86 -4.05  0.779
## 11 Gene11 1.02e- 3 1.12e- 3  2.69 -7.27  0.832
## 12 Gene6  1.91e- 2 1.91e- 2  1.76 -8.87  0.870
```

We may then wish to plot the expression of a particular gene and the MLE model. This is acheived using the `switchplot` function, which takes three arguments:

* `x` Vector of expression values
* `pseudotime` Pseudotime vector of the same length as `x`
* `pars` The (`mu_0`, `k`, `t0`) parameter tuple

We can easily extract the parameters using the `extract_pars` function and pass this to `switchplot`, which plots the maximum likelihood sigmoidal mean:

```
gene <- sde$gene[which.min(sde$qval)]
pars <- extract_pars(sde, gene)
print(pars)
```

```
##        mu0          k         t0
##  5.3206036 -9.2179954  0.1675885
```

```
switchplot(synth_gex[gene, ], ex_pseudotime, pars)
```

```
## Warning: `data_frame()` was deprecated in tibble 1.1.0.
## ℹ Please use `tibble()` instead.
## ℹ The deprecated feature was likely used in the switchde package.
##   Please report the issue at <https://github.com/kieranrcampbell/switchde>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

Note that `switchplot` returns a `ggplot` which can be further customised (e.g. using `theme_xxx()`, etc).

## 4.2 Zero-inflation

We can also model zero inflation in the data with a dropout probability proportional to the latent gene expression magnitude. To enable this set `zero_inflation = TRUE`. While this model is more appropriate for single-cell RNA-seq data, it requires use of the EM algorithm so takes typically 20x longer.

```
zde <- switchde(synth_gex, ex_pseudotime, zero_inflated = TRUE)
```

```
## Input gene-by-cell matrix: 12 genes and  100 cells
```

As before it returns a `data_frame`, this time with an additional parameter \(\lambda\) corresponding to the dropout probability (see manuscript):

```
dplyr::arrange(zde, qval)
```

```
## # A tibble: 12 × 8
##    gene       pval     qval   mu0     k     t0 lambda EM_converged
##    <chr>     <dbl>    <dbl> <dbl> <dbl>  <dbl>  <dbl> <lgl>
##  1 Gene8  6.67e-21 8.00e-20  5.32 -9.21  0.168  9.78  TRUE
##  2 Gene2  6.21e-13 3.73e-12  3.46  6.78  0.702  5.80  TRUE
##  3 Gene9  2.32e-12 9.26e-12  5.52 -5.06  0.320  3.20  TRUE
##  4 Gene1  3.66e-12 1.10e-11  3.89  7.44  0.568  1.49  TRUE
##  5 Gene5  1.01e-11 2.41e-11  3.52 10.4   0.475  2.06  TRUE
##  6 Gene4  1.55e-10 3.11e-10 12.6  -3.24 -0.198  1.87  TRUE
##  7 Gene3  1.45e- 8 2.49e- 8  4.23 -4.98  0.557  1.46  TRUE
##  8 Gene10 2.26e- 8 3.39e- 8  3.19  8.43  0.377  0.899 TRUE
##  9 Gene7  3.83e- 6 5.11e- 6  3.78  7.40  0.303  2.87  TRUE
## 10 Gene12 2.96e- 4 3.55e- 4  4.90 -3.97  0.776  0.803 TRUE
## 11 Gene11 9.38e- 4 1.02e- 3  2.70 -7.18  0.832  1.86  TRUE
## 12 Gene6  1.43e- 2 1.43e- 2  1.78 -8.67  0.869  1.57  TRUE
```

We can plot the gene with the largest dropout effect and compare it to the non-zero-inflated model:

```
gene <- zde$gene[which.min(zde$lambda)]
pars <- extract_pars(sde, gene)
zpars <- extract_pars(zde, gene)

switchplot(synth_gex[gene, ], ex_pseudotime, pars)
```

![](data:image/png;base64...)

```
switchplot(synth_gex[gene, ], ex_pseudotime, zpars)
```

![](data:image/png;base64...)

### 4.2.1 Controlling the EM algorithm

For zero-inflation the expectation-maximisation algorithm is used which will converge up to a user-supplied change in the log-likelihood after a given number of iterations. These are controlled by the parameters `maxiter` and `log_lik_tol` in the call to `switchde`. Most genes will converge after very few iterations, but some - particularly those with many zeros where a well defined ‘step’ can be fit - may take much longer. The default parameters are designed as a trade-off between accuracy and speed.

If any genes do not converge using the default parameters, the user is warned and should expect the `EM_converged` column of the output. In this case, three options are available:

1. Trust that after 1000 EM iterations, the parameter estimates will be good enough
2. Refit the genes for which `EM_converged == FALSE` with either increasing `maxiter` or increased `log_lik_tol`
3. Discard those genes altogether

# 5 Use cases

Most pseudotime algorithms will infer something similar to principal component 1 or 2 of the data. Therefore, *by definition*, many genes will vary across pseudotime leading to a large proportion passing a strict FDR adjusted significance threshold. Genes designated as significant should therefore be treated with appropriate skepticism and ideally experimentally validated.

We further suggest some use cases that might be of interest to researchers:

1. Take all genes passing some FDR threshold and perform GO analysis (using packages such as [topGO](https://bioconductor.org/packages/release/bioc/html/topGO.html) or [goseq](http://bioconductor.org/packages/release/bioc/html/goseq.html)) to find out what a particular pseudotime or principal component in their data corresponds to
2. Select genes with *interesting behaviour*. For example, genes could be identified that most exhibit switch or step-like behaviour along the trajectory, using `dplyr` calls such as `filter(sde, qval < 0.01, abs(k) > quantile(abs(k), 0.95))`
3. Find which genes govern different parts of the pseudotime trajectory. This can be accomplished by filtering for significant genes in different time points. For example, to find genes regulated in the first quarter of the trajectory, one could call

```
pst_quantiles <- quantile(pst, c(0, 0.25))
filter(sde, qval < 0.01, t0 > pst_quantiles[1], t0 < pst_quantiles[2])
```

# 6 Technical info

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
##  [1] ggplot2_4.0.0               switchde_1.36.0
##  [3] tidyr_1.3.1                 dplyr_1.1.4
##  [5] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
##  [4] lattice_0.22-7      vctrs_0.6.5         tools_4.5.1
##  [7] tibble_3.3.0        pkgconfig_2.0.3     Matrix_1.7-4
## [10] RColorBrewer_1.1-3  S7_0.2.0            lifecycle_1.0.4
## [13] compiler_4.5.1      farver_2.1.2        tinytex_0.57
## [16] codetools_0.2-20    htmltools_0.5.8.1   sass_0.4.10
## [19] yaml_2.3.10         pillar_1.11.1       crayon_1.5.3
## [22] jquerylib_0.1.4     DelayedArray_0.36.0 cachem_1.1.0
## [25] magick_2.9.0        abind_1.4-8         nlme_3.1-168
## [28] tidyselect_1.2.1    digest_0.6.37       purrr_1.1.0
## [31] bookdown_0.45       labeling_0.4.3      splines_4.5.1
## [34] fastmap_1.2.0       grid_4.5.1          cli_3.6.5
## [37] SparseArray_1.10.0  magrittr_2.0.4      S4Arrays_1.10.0
## [40] dichromat_2.0-0.1   utf8_1.2.6          withr_3.0.2
## [43] scales_1.4.0        rmarkdown_2.30      XVector_0.50.0
## [46] evaluate_1.0.5      knitr_1.50          mgcv_1.9-3
## [49] rlang_1.1.6         Rcpp_1.1.0          glue_1.8.0
## [52] BiocManager_1.30.26 jsonlite_2.0.0      R6_2.6.1
```