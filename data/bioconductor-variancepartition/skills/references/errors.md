# Error handling

#### Developed by [Gabriel Hoffman](http://gabrielhoffman.github.io/)

#### Run on 2025-12-11 21:40:16

* [Errors in `dream()`](#errors-in-dream)
  + [Gene-level errors](#gene-level-errors)
* [Shared by multiple functions](#shared-by-multiple-functions)
  + [Warnings](#warnings)
  + [Errors](#errors)
    - [Errors: Problems removing samples with NA/NaN/Inf values](#errors-problems-removing-samples-with-nananinf-values)
    - [Errors with BiocParallel multithreading backend](#errors-with-biocparallel-multithreading-backend)
* [Session Info](#session-info)

Errors and warnings in `variancePartition` are mostly designed to let the user know that there is an isssue with the model. Note that some of these warnings and errors can be overridden by specifying `hideErrorsInBackend=TRUE` for `dream()` and `showWarnings=FALSE` for `fitExtractVarPartModel()` and `fitVarPartModel()`.

# Errors in `dream()`

The linear mixed model used by `dream()` can be a little fragile for small sample sizes and correlated covariates.

* `Initial model failed: the fixed-effects model matrix is column rank deficient (rank(X) = 3 < 4 = p); the fixed effects will be jointly unidentifiable`

  The design matrix has redundant variables, so the model is singular and coefficients can’t be estimated. Fix by dropping one or more variables. Use `canCorPairs()` to examine correlation betweeen variables.

## Gene-level errors

The most common issue is when `dream()` analysis succeeds for most genes, but a handful of genes fail. These genes can fail if the iterative process of fitting the linear mixed model does not converge, or if the estimated covariance matrix that is supposed be positive definite has an eigen-value that is negative or too close to zero due to rounding errors in floating point arithmetic.

In these cases, `dream()` gives a warning that the model has failed for a subset of genes, and also provides the gene-level errors. All **successful** model fits are returned to be used for downstream analysis.

Here we demonstrate how `dream()` handles model fits:

```
library(variancePartition)
data(varPartData)

# Redundant formula
# This example is an extreme example of redundancy
# but more subtle cases often show up in real data
form <- ~ Tissue + (1 | Tissue)

fit <- dream(geneExpr[1:30, ], form, info)

## Warning in dream(geneExpr[1:30, ], form, info): Model failed for 29 responses.
##   See errors with attr(., 'errors')

# Extract gene-level errors
attr(fit, "errors")[1:2]

## gene1
## "Error in lmerTest:::as_lmerModLT(model, devfun, tol = tol): (converted from warning)
## Model may not have converged with 1 eigenvalue close to zero: -2.0e-09\n"

## gene2
## "Error: (converted from warning) Model failed to converge
##   with 1 negative eigenvalue: -1.5e-08\n"
```

# Shared by multiple functions

These are shared by `dream()`, `fitVarPartModel()` and `fitExtractVarPartModel()`. Note that some of the these can be found in “1) Tutorial on using variancePartition”.

## Warnings

* `No Intercept term was specified in the formula: The results will not behave as expected and may be very wrong!!`

  An intercept (i.e. mean term) must be specified order for the results to be statistically valid. Otherwise, the variance percentages will be *very* overestimated.
* `Categorical variables modeled as fixed effect: The results will not behave as expected and may be very wrong!!`

  If a linear mixed model is used, all categorical variables must be modeled as a random effect. Alternatively, a fixed effect model can be used by modeling all variables as fixed.
* `Cannot have more than one varying coefficient term:\newline The results will not behave as expected and may be very wrong!!`

  Only one varying coefficient term can be specified. For example, the formula `~(Tissue+0|Individual) + (Batch+0|Individual)` contains two varying coefficient terms and the results from this analysis are not easily interpretable. Only a formula with one term like `(Tissue+0|Individual)` is allowed.

## Errors

* `Colinear score > .99: Covariates in the formula are so strongly correlated that the parameter estimates from this model are not meaningful. Dropping one or more of the covariates will fix this problem`
* `Error in asMethod(object) : not a positive definite matrix`
* `In vcov.merMod(fit) : Computed variance-covariance matrix problem: not a positive definite matrix; returning NA matrix`
* `fixed-effect model matrix is rank deficient so dropping 26 columns / coefficients`

  Including variables that are highly correlated can produce misleading results (see Section “Detecting problems caused by collinearity of variables”). In this case, parameter estimates from this model are not meaningful. Dropping one or more of the covariates will fix this problem.
* `Error in checkNlevels(reTrms$flist, n = n, control): number of levels of each grouping factor must be < number of observations`

  This arises when using a varying coefficient model that examines the effect of one variable inside subsets of the data defined by another: `~(A+0|B)`. See Section “Variation within multiple subsets of the data”. There must be enough observations of each level of the variable B with each level of variable A. Consider an example with samples from multiple tissues from a set of individual where we are interested in the variation across individuals within each tissue using the formula: `~(Tissue+0|Individual)`. This analysis will only work if there are multiple samples from the same individual in at least one tissue. If all tissues only have one sample per individual, the analysis will fail and `variancePartition` will give this error.
* `Problem with varying coefficient model in formula: should have form (A+0|B)`

  When analyzing the variation of one variable inside another (see Section “Variation within multiple subsets of the data”.), the formula most be specified as `(Tissue+0|Individual)`. This error occurs when the formula contains `(Tissue|Individual)` instead.
* `fatal error in wrapper code`
* `Error in mcfork() : unable to fork, possible reason: Cannot allocate memory`
* `Error: cannot allocate buffer`

  This error occurs when `fitVarPartModel` uses too many threads and takes up too much memory. The easiest solution is to use `fitExtractVarPartModel` instead. Occasionally there is an issue in the parallel backend that is out of my control. Using fewer threads or restarting R will solve the problem.

### Errors: Problems removing samples with NA/NaN/Inf values

`variancePartition` fits a regression model for each gene and drops samples that have NA/NaN/Inf values in each model fit. This is generally seamless but can cause an issue when a variable specified in the formula no longer varies within the subset of samples that are retained. Consider an example with variables for sex and age where age is NA for all males samples. Dropping samples with invalid values for variables included in the formula will retain only female samples. This will cause `variancePartition` to throw an error because there is now no variation in sex in the retained subset of the data. This can be resolved by removing either age or sex from the formula.

This situtation is indicated by the following errors:

* `Error: grouping factors must have > 1 sampled level`
* `Error: Invalid grouping factor specification, Individual`
* `Error in contrasts<-(*tmp*, value = contr.funs[1 + isOF[nn]]): contrasts can be applied only to factors with 2 or more levels`
* `Error in checkNlevels(reTrms\$flist, n = n, control): grouping factors must have > 1 sampled level`

### Errors with BiocParallel multithreading backend

* `Error: 'bpiterate' receive data failed: error reading from connection`
* `Error in serialize(data, node$con, xdr = FALSE) : ignoring SIGPIPE signal`

  `variancePartition` uses the `BiocParallel` package to run analysis in parallel across multiple cores. If there is an issue with the parallel backend you might see these errors. This often occurs in long interactive sessions, or if you manually kill a function running in parallel. There are two ways to address this issue.

  + **Global**: set the number of threads to be a smaller number. I have found that reducing the number of threads reduces the chance of random failures like this.

    ```
    library(BiocParallel)

    # globally specify that all multithreading using bpiterate from BiocParallel
    # should use 8 cores
    register(SnowParam(8))
    ```
  + **Local**: set the number of theads at each function call. This re-initializes the parallel backend and should address the error

    ```
    fitExtractVarPartModel(..., BPPARAM = SnowParam(8))

    fitVarPartModel(..., BPPARAM = SnowParam(8))

    dream(..., BPPARAM = SnowParam(8))

    voomWithDreamWeights(..., BPPARAM = SnowParam(8))
    ```

# Session Info

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] edgeR_4.8.1              pander_0.6.6             variancePartition_1.40.1
## [4] BiocParallel_1.44.0      limma_3.66.0             ggplot2_4.0.1
## [7] knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1    dplyr_1.1.4         farver_2.1.2        S7_0.2.1
##  [5] bitops_1.0-9        fastmap_1.2.0       digest_0.6.39       lifecycle_1.0.4
##  [9] statmod_1.5.1       magrittr_2.0.4      compiler_4.5.2      rlang_1.1.6
## [13] sass_0.4.10         tools_4.5.2         yaml_2.3.12         labeling_0.4.3
## [17] plyr_1.8.9          RColorBrewer_1.1-3  KernSmooth_2.23-26  withr_3.0.2
## [21] purrr_1.2.0         numDeriv_2016.8-1.1 BiocGenerics_0.56.0 grid_4.5.2
## [25] aod_1.3.3           caTools_1.18.3      scales_1.4.0        gtools_3.9.5
## [29] iterators_1.0.14    MASS_7.3-65         dichromat_2.0-0.1   cli_3.6.5
## [33] mvtnorm_1.3-3       rmarkdown_2.30      reformulas_0.4.2    generics_0.1.4
## [37] reshape2_1.4.5      minqa_1.2.8         cachem_1.1.0        stringr_1.6.0
## [41] splines_4.5.2       parallel_4.5.2      matrixStats_1.5.0   vctrs_0.6.5
## [45] boot_1.3-32         Matrix_1.7-4        jsonlite_2.0.0      pbkrtest_0.5.5
## [49] locfit_1.5-9.12     jquerylib_0.1.4     tidyr_1.3.1         snow_0.4-4
## [53] glue_1.8.0          nloptr_2.2.1        codetools_0.2-20    stringi_1.8.7
## [57] gtable_0.3.6        EnvStats_3.1.0      lme4_1.1-38         lmerTest_3.1-3
## [61] tibble_3.3.0        remaCor_0.0.20      pillar_1.11.1       htmltools_0.5.9
## [65] gplots_3.3.0        R6_2.6.1            Rdpack_2.6.4        evaluate_1.0.5
## [69] lattice_0.22-7      Biobase_2.70.0      rbibutils_2.4       backports_1.5.0
## [73] RhpcBLASctl_0.23-42 broom_1.0.11        fANCOVA_0.6-1       corpcor_1.6.10
## [77] bslib_0.9.0         Rcpp_1.1.0          nlme_3.1-168        xfun_0.54
## [81] pkgconfig_2.0.3
```