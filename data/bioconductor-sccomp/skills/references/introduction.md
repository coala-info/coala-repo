# sccomp: Differential Composition and Variability Analysis for Single-Cell Data

#### Stefano Mangiola

#### 2025-10-30

Abstract

Sccomp is a comprehensive R package for differential composition and variability analysis in single-cell RNA sequencing, CyTOF, and microbiome data. It provides robust Bayesian modeling with outlier detection, random effects, and advanced statistical methods for cell type proportion analysis. Perfect for cancer research, immunology, and single-cell genomics.

* [1 ![](data:image/png;base64...)](#section)
  + [1.1 Why sccomp?](#why-sccomp)
* [2 Installation Guide](#installation-guide)
  + [2.1 Core Functions](#core-functions)
* [3 Analysis Tutorial](#analysis-tutorial)
  + [3.1 Binary Factor Analysis](#binary-factor-analysis)
  + [3.2 Outlier Identification](#outlier-identification)
  + [3.3 Visualization and Summary Plots](#visualization-and-summary-plots)
  + [3.4 Model Proportions Directly (e.g. from deconvolution)](#model-proportions-directly-e.g.-from-deconvolution)
  + [3.5 Continuous Factor Analysis](#continuous-factor-analysis)
  + [3.6 Random Effect Modeling (Mixed-Effect Modeling)](#random-effect-modeling-mixed-effect-modeling)
  + [3.7 Result Interpretation and Communication](#result-interpretation-and-communication)
  + [3.8 Contrasts Analysis](#contrasts-analysis)
  + [3.9 Categorical Factor Analysis (Bayesian ANOVA)](#categorical-factor-analysis-bayesian-anova)
  + [3.10 Differential Variability Analysis](#differential-variability-analysis)
* [4 Recommended Settings for Different Data Types](#recommended-settings-for-different-data-types)
  + [4.1 For Single-Cell RNA Sequencing](#for-single-cell-rna-sequencing)
  + [4.2 For CyTOF and Microbiome Data](#for-cytof-and-microbiome-data)
  + [4.3 MCMC Chain Visualization](#mcmc-chain-visualization)

[![Lifecycle:maturing](data:image/svg+xml;charset=utf-8;base64...)](https://www.tidyverse.org/lifecycle/#maturing) [![R build status](data:image/svg+xml; charset=utf-8;base64...)](https://github.com/stemangiola/sccomp/actions/)

# 1 ![](data:image/png;base64...)

**sccomp** is a powerful R package designed for comprehensive differential composition and variability analysis in single-cell genomics, proteomics, and microbiomics data.

## 1.1 Why sccomp?

For cellular omic data, no method for differential variability analysis exists, and methods for differential composition analysis only take a few fundamental data properties into account. Here we introduce **sccomp**, a generalised method for differential composition and variability analyses capable of jointly modelling data count distribution, compositionality, group-specific variability, and proportion mean-variability association, while being robust to outliers.

![](data:image/png;base64...)

### 1.1.1 Comprehensive Method Comparison

* **I**: Data are modelled as counts.
* **II**: Group proportions are modelled as compositional.
* **III**: The proportion variability is modelled as cell-type specific.
* **IV**: Information sharing across cell types, mean–variability association.
* **V**: Outlier detection or robustness.
* **VI**: Differential variability analysis.
* **VII** Mixed effect modelling
* **VIII** Removal unwanted effects

| Method | Year | Model | I | II | III | IV | V | VI | VII | VIII |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **sccomp** | 2023 | Sum-constrained Beta-binomial | ● | ● | ● | ● | ● | ● | ● | ● |
| **scCODA** | 2021 | Dirichlet-multinomial | ● | ● |  |  |  |  |  |  |
| **quasi-binom.** | 2021 | Quasi-binomial | ● |  | ● |  |  |  |  |  |
| **rlm** | 2021 | Robust-log-linear |  | ● |  |  | ● |  |  |  |
| **propeller** | 2021 | Logit-linear + limma |  | ● | ● | ● |  |  |  |  |
| **ANCOM-BC** | 2020 | Log-linear |  | ● | ● |  |  |  |  |  |
| **corncob** | 2020 | Beta-binomial | ● |  | ● |  |  |  |  |  |
| **scDC** | 2019 | Log-linear |  | ● | ● |  |  |  |  |  |
| **dmbvs** | 2017 | Dirichlet-multinomial | ● | ● |  |  |  |  |  |  |
| **MixMC** | 2016 | Zero-inflated Log-linear |  | ● | ● |  |  |  |  |  |
| **ALDEx2** | 2014 | Dirichlet-multinomial | ● | ● |  |  |  |  |  |  |

### 1.1.2 Scientific Citation

Mangiola, Stefano, Alexandra J. Roth-Schulze, Marie Trussart, Enrique Zozaya-Valdés, Mengyao Ma, Zijie Gao, Alan F. Rubin, Terence P. Speed, Heejung Shim, and Anthony T. Papenfuss. 2023. “Sccomp: Robust Differential Composition and Variability Analysis for Single-Cell Data.” Proceedings of the National Academy of Sciences of the United States of America 120 (33): e2203828120. <https://doi.org/10.1073/pnas.2203828120> [PNAS - sccomp: Robust differential composition and variability analysis for single-cell data](https://www.pnas.org/doi/full/10.1073/pnas.2203828120)

### 1.1.3 Talk

[![Watch the video](data:image/jpeg;base64...)](https://www.youtube.com/watch?v=R_lt58We9nA&ab_channel=RConsortium)

# 2 Installation Guide

`sccomp` is based on `cmdstanr` which provides the latest version of `cmdstan` the Bayesian modelling tool. `cmdstanr` is not on CRAN, so we need to have 3 simple step process (that will be prompted to the user is forgot).

1. R installation of `sccomp`
2. R installation of `cmdstanr`
3. `cmdstanr` call to `cmdstan` installation

**Bioconductor**

```
if (!requireNamespace("BiocManager")) install.packages("BiocManager")

# Step 1
BiocManager::install("sccomp")

# Step 2
install.packages("cmdstanr", repos = c("https://stan-dev.r-universe.dev/", getOption("repos")))

# Step 3
cmdstanr::check_cmdstan_toolchain(fix = TRUE) # Just checking system setting
cmdstanr::install_cmdstan()
```

**Github**

```
# Step 1
devtools::install_github("MangiolaLaboratory/sccomp")

# Step 2
install.packages("cmdstanr", repos = c("https://stan-dev.r-universe.dev/", getOption("repos")))

# Step 3
cmdstanr::check_cmdstan_toolchain(fix = TRUE) # Just checking system setting
cmdstanr::install_cmdstan()
```

## 2.1 Core Functions

| Function | Description |
| --- | --- |
| `sccomp_estimate` | Fit the model onto the data, and estimate the coefficients |
| `sccomp_remove_outliers` | Identify outliers probabilistically based on the model fit, and exclude them from the estimation |
| `sccomp_test` | Calculate the probability that the coefficients are outside the H0 interval (i.e. test\_composition\_above\_logit\_fold\_change) |
| `sccomp_replicate` | Simulate data from the model, or part of the model |
| `sccomp_predict` | Predicts proportions, based on the model, or part of the model |
| `sccomp_remove_unwanted_effects` | Removes the variability for unwanted factors |
| `plot` | Plots summary plots to assess significance |

# 3 Analysis Tutorial

```
library(dplyr)
library(sccomp)
library(ggplot2)
library(forcats)
library(tidyr)
data("seurat_obj")
data("sce_obj")
data("counts_obj")
```

## 3.1 Binary Factor Analysis

Of the output table, the estimate columns start with the prefix `c_` indicate `composition`, or with `v_` indicate `variability` (when formula\_variability is set).

### 3.1.1 From Seurat, SingleCellExperiment, metadata objects

```
sccomp_result =
  sce_obj |>
  sccomp_estimate(
    formula_composition = ~ type,
    sample = "sample",
    cell_group = "cell_group",
    cores = 1,
    verbose = FALSE
  ) |>
  sccomp_test()
```

### 3.1.2 From counts

```
sccomp_result =
  counts_obj |>
  sccomp_estimate(
    formula_composition = ~ type,
    sample = "sample",
    cell_group = "cell_group",
    abundance = "count",
    cores = 1, verbose = FALSE
  ) |>
  sccomp_test()
```

Here you see the results of the fit, the effects of the factor on composition and variability. You also can see the uncertainty around those effects.

The output is a tibble containing the **Following columns**

* `cell_group` - The cell groups being tested.
* `parameter` - The parameter being estimated from the design matrix described by the input `formula_composition` and `formula_variability`.
* `factor` - The covariate factor in the formula, if applicable (e.g., not present for Intercept or contrasts).
* `c_lower` - Lower (2.5%) quantile of the posterior distribution for a composition (c) parameter.
* `c_effect` - Mean of the posterior distribution for a composition (c) parameter.
* `c_upper` - Upper (97.5%) quantile of the posterior distribution for a composition (c) parameter.
* `c_pH0` - Probability of the null hypothesis (no difference) for a composition (c). This is not a p-value.
* `c_FDR` - False-discovery rate of the null hypothesis for a composition (c).
* `v_lower` - Lower (2.5%) quantile of the posterior distribution for a variability (v) parameter.
* `v_effect` - Mean of the posterior distribution for a variability (v) parameter.
* `v_upper` - Upper (97.5%) quantile of the posterior distribution for a variability (v) parameter.
* `v_pH0` - Probability of the null hypothesis for a variability (v).
* `v_FDR` - False-discovery rate of the null hypothesis for a variability (v).
* `count_data` - Nested input count data.

```
sccomp_result
```

## 3.2 Outlier Identification

`sccomp` can identify outliers probabilistically and exclude them from the estimation.

```
sccomp_result =
  counts_obj |>
  sccomp_estimate(
    formula_composition = ~ type,
    sample = "sample",
    cell_group = "cell_group",
    abundance = "count",
    cores = 1, verbose = FALSE
  ) |>

  # max_sampling_iterations is used her to not exceed the maximum file size for GitHub action of 100Mb
  sccomp_remove_outliers(cores = 1, verbose = FALSE, max_sampling_iterations = 2000) |> # Optional
  sccomp_test()
```

## 3.3 Visualization and Summary Plots

A plot of group proportions, faceted by groups. The blue boxplots represent the posterior predictive check. If the model is descriptively adequate for the data, the blue boxplots should roughly overlay the black boxplots, which represent the observed data. The outliers are coloured in red. A boxplot will be returned for every (discrete) covariate present in formula\_composition. The colour coding represents the significant associations for composition and/or variability.

```
sccomp_result |>
  sccomp_boxplot(factor = "type")
```

You can plot proportions adjusted for unwanted effects. This is helpful especially for complex models, where multiple factors can significantly impact the proportions.

```
sccomp_result |>
  sccomp_boxplot(factor = "type", remove_unwanted_effects = TRUE)
```

A plot of estimates of differential composition (c\_) on the x-axis and differential variability (v\_) on the y-axis. The error bars represent 95% credible intervals. The dashed lines represent the minimal effect that the hypothesis test is based on. An effect is labelled as significant if it exceeds the minimal effect according to the 95% credible interval. Facets represent the covariates in the model.

```
sccomp_result |>
  plot_1D_intervals()
```

We can plot the relationship between abundance and variability. As we can see below, they are positively correlated. sccomp models this relationship to obtain a shrinkage effect on the estimates of both the abundance and the variability. This shrinkage is adaptive as it is modelled jointly, thanks to Bayesian inference.

```
sccomp_result |>
  plot_2D_intervals()
```

You can produce the series of plots calling the `plot` method.

```
sccomp_result |> plot()
```

## 3.4 Model Proportions Directly (e.g. from deconvolution)

**Note:** If counts are available, we strongly discourage the use of proportions, as an important source of uncertainty (i.e., for rare groups/cell types) is not modeled.

The use of proportions is better suited for modelling deconvolution results (e.g., of bulk RNA data), in which case counts are not available.

Proportions should be greater than 0. Assuming that zeros derive from a precision threshold (e.g., deconvolution), zeros are converted to the smallest non-zero value.

```
sccomp_result =
  counts_obj |>
  sccomp_estimate(
    formula_composition = ~ type,
    sample = "sample",
    cell_group = "cell_group",
    abundance = "proportion",
    cores = 1, verbose = FALSE
  ) |>
  sccomp_test()
```

## 3.5 Continuous Factor Analysis

`sccomp` is able to fit arbitrary complex models. In this example we have a continuous and binary covariate.

```
res =
    seurat_obj |>
    sccomp_estimate(
      formula_composition = ~ type + continuous_covariate,
      sample = "sample",
      cell_group = "cell_group",
      cores = 1, verbose=FALSE
    )

res
```

## 3.6 Random Effect Modeling (Mixed-Effect Modeling)

`sccomp` supports multilevel modeling by allowing the inclusion of random effects in the compositional and variability formulas. This is particularly useful when your data has hierarchical or grouped structures, such as measurements nested within subjects, batches, or experimental units. By incorporating random effects, sccomp can account for variability at different levels of your data, improving model fit and inference accuracy.

### 3.6.1 Random Intercept Model

In this example, we demonstrate how to fit a random intercept model using sccomp. We’ll model the cell-type proportions with both fixed effects (e.g., treatment) and random effects (e.g., subject-specific variability).

Here is the input data

```
seurat_obj[[]] |> as_tibble()
```

```
res =
  seurat_obj |>
  sccomp_estimate(
    formula_composition = ~ type + (1 | group__),
    sample = "sample",
    cell_group = "cell_group",
    bimodal_mean_variability_association = TRUE,
    cores = 1, verbose = FALSE
  )

res
```

### 3.6.2 Random Effect Model (random slopes)

`sccomp` can model random slopes. We provide an example below.

```
res =
  seurat_obj |>
  sccomp_estimate(
      formula_composition = ~ type + (type | group__),
      sample = "sample",
      cell_group = "cell_group",
      bimodal_mean_variability_association = TRUE,
      cores = 1, verbose = FALSE
    )

res
```

### 3.6.3 Nested Random Effects

If you have a more complex hierarchy, such as measurements nested within subjects and subjects nested within batches, you can include multiple grouping variables. Here `group2__` is nested within `group__`.

```
res =
  seurat_obj |>
  sccomp_estimate(
      formula_composition = ~ type + (type | group__) + (1 | group2__),
      sample = "sample",
      cell_group = "cell_group",
      bimodal_mean_variability_association = TRUE,
      cores = 1, verbose = FALSE
    )

res
```

## 3.7 Result Interpretation and Communication

The estimated effects are expressed in the unconstrained space of the parameters, similar to differential expression analysis that expresses changes in terms of log fold change. However, for differences in proportion, logit fold change must be used, which is harder to interpret and understand.

Therefore, we provide a more intuitive proportional fold change that can be more easily understood. However, these cannot be used to infer significance (use sccomp\_test() instead), and a lot of care must be taken given the nonlinearity of these measures (a 1-fold increase from 0.0001 to 0.0002 carries a different weight than a 1-fold increase from 0.4 to 0.8).

From your estimates, you can specify which effects you are interested in (this can be a subset of the full model if you wish to exclude unwanted effects), and the two points you would like to compare.

In the case of a categorical variable, the starting and ending points are categories.

```
res |>
   sccomp_proportional_fold_change(
     formula_composition = ~  type,
     from =  "healthy",
     to = "cancer"
    ) |>
  select(cell_group, statement)
```

## 3.8 Contrasts Analysis

```
seurat_obj |>
  sccomp_estimate(
    formula_composition = ~ 0 + type,
    sample = "sample",
    cell_group = "cell_group",
    cores = 1, verbose = FALSE
  ) |>
  sccomp_test( contrasts =  c("typecancer - typehealthy", "typehealthy - typecancer"))
```

## 3.9 Categorical Factor Analysis (Bayesian ANOVA)

This is achieved through model comparison with `loo`. In the following example, the model with association with factors better fits the data compared to the baseline model with no factor association. For model comparisons `sccomp_remove_outliers()` must not be executed as the leave-one-out must work with the same amount of data, while outlier elimination does not guarantee it.

If `elpd_diff` is away from zero of > 5 `se_diff` difference of 5, we are confident that a model is better than the other [reference](https://discourse.mc-stan.org/t/interpreting-elpd-diff-loo-package/1628/2?u=stemangiola). In this case, -79.9 / 11.5 = -6.9, therefore we can conclude that model one, the one with factor association, is better than model two.

```
library(loo)

# Fit first model
model_with_factor_association =
  seurat_obj |>
  sccomp_estimate(
    formula_composition = ~ type,
    sample = "sample",
    cell_group = "cell_group",
    inference_method = "hmc",
    enable_loo = TRUE,
    verbose = FALSE
  )

# Fit second model
model_without_association =
  seurat_obj |>
  sccomp_estimate(
    formula_composition = ~ 1,
    sample = "sample",
    cell_group = "cell_group",
    inference_method = "hmc",
    enable_loo = TRUE,
    verbose = FALSE
  )

# Compare models
loo_compare(
   attr(model_with_factor_association, "fit")$loo(),
   attr(model_without_association, "fit")$loo()
)
```

## 3.10 Differential Variability Analysis

We can model the cell-group variability also dependent on the type, and so test differences in variability

```
res =
  seurat_obj |>
  sccomp_estimate(
    formula_composition = ~ type,
    formula_variability = ~ type,
    sample = "sample",
    cell_group = "cell_group",
    cores = 1, verbose = FALSE
  )

res
```

**Plot 1D significance plot**

```
plots = res |> sccomp_test() |> plot()

plots$credible_intervals_1D
```

**Plot 2D significance plot** Data points are cell groups. Error bars are the 95% credible interval. The dashed lines represent the default threshold fold change for which the probabilities (c\_pH0, v\_pH0) are calculated. pH0 of 0 represent the rejection of the null hypothesis that no effect is observed.

This plot is provided only if differential variability has been tested. The differential variability estimates are reliable only if the linear association between mean and variability for `(intercept)` (left-hand side facet) is satisfied. A scatterplot (besides the Intercept) is provided for each category of interest. For each category of interest, the composition and variability effects should be generally uncorrelated.

```
plots$credible_intervals_2D
```

# 4 Recommended Settings for Different Data Types

## 4.1 For Single-Cell RNA Sequencing

We recommend setting `bimodal_mean_variability_association = TRUE`. The bimodality of the mean-variability association can be confirmed from the plots$credible\_intervals\_2D (see below).

## 4.2 For CyTOF and Microbiome Data

We recommend setting `bimodal_mean_variability_association = FALSE` (Default).

## 4.3 MCMC Chain Visualization

It is possible to directly evaluate the posterior distribution. In this example, we plot the Monte Carlo chain for the slope parameter of the first cell type. We can see that it has converged and is negative with probability 1.

```
library(cmdstanr)
library(posterior)
library(bayesplot)

# Assuming res contains the fit object from cmdstanr
fit <- res |> attr("fit")

# Extract draws for 'beta[2,1]'
draws <- as_draws_array(fit$draws("beta[2,1]"))

# Create a traceplot for 'beta[2,1]'
mcmc_trace(draws, pars = "beta[2,1]") + theme_bw()
```

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] tidyr_1.3.1       forcats_1.0.1     ggplot2_4.0.0     sccomp_2.2.0
## [5] instantiate_0.2.3 dplyr_1.1.4
##
## loaded via a namespace (and not attached):
##  [1] dotCall64_1.2               SummarizedExperiment_1.40.0
##  [3] spam_2.11-1                 gtable_0.3.6
##  [5] xfun_0.53                   bslib_0.9.0
##  [7] processx_3.8.6              ggrepel_0.9.6
##  [9] Biobase_2.70.0              lattice_0.22-7
## [11] callr_3.7.6                 tzdb_0.5.0
## [13] vctrs_0.6.5                 tools_4.5.1
## [15] ps_1.9.1                    generics_0.1.4
## [17] stats4_4.5.1                parallel_4.5.1
## [19] tibble_3.3.0                pkgconfig_2.0.3
## [21] Matrix_1.7-4                RColorBrewer_1.1-3
## [23] S7_0.2.0                    S4Vectors_0.48.0
## [25] lifecycle_1.0.4             stringr_1.5.2
## [27] compiler_4.5.1              farver_2.1.2
## [29] prettydoc_0.4.1             codetools_0.2-20
## [31] Seqinfo_1.0.0               SeuratObject_5.2.0
## [33] htmltools_0.5.8.1           sass_0.4.10
## [35] yaml_2.3.10                 pillar_1.11.1
## [37] crayon_1.5.3                jquerylib_0.1.4
## [39] SingleCellExperiment_1.32.0 cachem_1.1.0
## [41] DelayedArray_0.36.0         abind_1.4-8
## [43] parallelly_1.45.1           tidyselect_1.2.1
## [45] digest_0.6.37               future_1.67.0
## [47] stringi_1.8.7               listenv_0.9.1
## [49] purrr_1.1.0                 fastmap_1.2.0
## [51] grid_4.5.1                  cli_3.6.5
## [53] SparseArray_1.10.0          magrittr_2.0.4
## [55] patchwork_1.3.2             S4Arrays_1.10.0
## [57] dichromat_2.0-0.1           future.apply_1.20.0
## [59] withr_3.0.2                 readr_2.1.5
## [61] scales_1.4.0                sp_2.2-0
## [63] rmarkdown_2.30              XVector_0.50.0
## [65] globals_0.18.0              matrixStats_1.5.0
## [67] progressr_0.17.0            hms_1.1.4
## [69] evaluate_1.0.5              knitr_1.50
## [71] GenomicRanges_1.62.0        IRanges_2.44.0
## [73] rlang_1.1.6                 Rcpp_1.1.0
## [75] glue_1.8.0                  BiocGenerics_0.56.0
## [77] jsonlite_2.0.0              R6_2.6.1
## [79] MatrixGenerics_1.22.0       fs_1.6.6
```