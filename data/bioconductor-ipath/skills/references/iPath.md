# The iPath User’s Guide

Kenong Su\* and Steve Qin\*\*

\*kenong.su@emory.edu
\*\*zhaohui.qin@emory.edu

#### 19 January 2026

#### Abstract

This vignette introduces the usage of the Bioconductor package iPath (individualized pathway analysis), which is capable of identifying highly predictive biomarkers for clinical outcomes. It includes two major steps: calculating the personalized iES for each sample and each pathway, and investigating whether stratified tumor samples are associated with clinical. Here, we introduce iPath, or individual-level pathway analysis, to quantify the magnitude of alteration occurring for a particular pathway at the individual sample level. Our goal is to understand cancer one tumor sample at a time outcomes.

#### Package

iPath 1.16.0

# 1 Installation and help

## 1.1 Install iPath

To install this package, start R (version > “4.0”) and enter:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("iPath")
```

## 1.2 Help for iPath

If you have any iPath-related questions, please post to the GitHub Issue section of iPath at <https://github.com/suke18/iPath/issues>, which will be helpful for the construction of iPath.

# 2 Introduction

## 2.1 Background

Identifying biomarkers to predict the clinical outcomes of individual patients is a fundamental problem in clinical oncology. Multiple single-gene biomarkers have already been identified and used in the clinics. However, multiple oncogenes or tumor-suppressor genes are involved during the process of tumorigenesis. Additionally, the efficacy of single-gene biomarkers is limited by the extensively variable expression levels measured by high-throughput assays. In this study, we hypothesize that in individual tumor samples, the disruption of transcription homeostasis in key pathways or gene set plays an important role in tumorigenesis and has profound implications for the patient’s clinical outcome. We devised a computational method named iPath to identify, at the individual sample level, which pathways or gene sets significantly deviate from their norms. We conducted a pan-cancer analysis and demonstrated that iPath is capable of identifying highly predictive biomarkers for clinical outcomes, including overall survival, tumor subtypes, and tumor stage classifications.

## 2.2 Citation

* For using (**iPath**) feature selection procedure, DOI is 10.1016/j.crmeth.2021.100050
* For downloading TCGA dataset, <https://www.bioconductor.org/packages/release/bioc/html/RTCGA.html>

# 3 Calculate iES

iPath requires an normalized expression matrix with rows representing the genes and columns representing the samples. To preprocess the expression matrix, iPath filters out the genes depending on standard deviations (sd). Here, we sampled PRAD TCGA dataset for illustration. It is noted that iPath requires a gene set database (GSDB) as another input, which can be obtained by the MSigDB database.

## 3.1 Load the data

The `PRAD_data` dataset is loaded with three objects including the RPKM expression matrix (`prad_exprs`), corresponding phenotype information (prad\_inds). `prad_inds` is the binary vector with 0 representing normal and 1 representing tumor sample, and simulated clinical dataset (`prad_cli`).

```
library(iPath)
data(PRAD_data)
dim(prad_exprs)
data(GSDB_example)
head(prad_cli)
```

## 3.2 Calculate iES per sample per pathway

The core of iPath is to calculate the iES score for each patient and pathway. The function *iES\_cal2* requires two input an expression matrix and gene set database (GSDB). The returned matrix contains iES with rows corresponding to the pathways and columns corresponding to the samples.

```
iES_mat = iES_cal2(Y = prad_exprs, GSDB = GSDB_example)
iES_mat[1:2, 1:4]
```

# 4 Test association with survival outcomes

After computing iES matrix, it is important to investigate whether the classified normal-like and perturbed groups exist significance different in terms of survival outcomes. To perform the classifcaiton in tumor samples, we use normal sampels as reference by fiting a Guassian Mixture. The investigation is conducted for each individual pathway. `iES_surv` function inputs the iES matrix from the `iES_cal2` step, the clinical data, and the binary vector indicating the patient phenotypes; for example, 0 represents normal sample and 1 represents tumor sample.

```
surv_outcomes = iES_surv(iES_mat = iES_mat, cli = prad_cli, indVec = prad_inds)
#> Warning in coxph.fit(X, Y, istrat, offset, init, control, weights = weights, :
#> Loglik converged before variable 1 ; coefficient may be infinite.
head(surv_outcomes)
#>             nPerturb   c-index        coef      pval
#> SimPathway1        8 0.5418719  -0.6874565 0.5041147
#> SimPathway2        5 0.5615764 -18.2110687 0.1970832
#> SimPathway3       11 0.4802956  -0.2586764 0.7386278
```

# 5 Data visualization

## 5.1 waterfall

We also provide two forms of visualization for iES scores. One is the waterfall plot ranked from the smallest to the largest.

```
water_fall(iES_mat, gs_str = "SimPathway2", indVec = prad_inds)
```

![](data:image/png;base64...)

```
density_fall(iES_mat, gs_str = "SimPathway2", indVec = prad_inds)
```

![](data:image/png;base64...)

## 5.2 one survival outcomes

```
iES_survPlot(iES_mat = iES_mat, cli = prad_cli, gs_str = "SimPathway1", indVec = prad_inds, title = TRUE)
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the ggpubr package.
#>   Please report the issue at <https://github.com/kassambara/ggpubr/issues>.
#> This warning is displayed once per session.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

# 6 Session Info

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#> [1] iPath_1.16.0        survival_3.8-6      BiocParallel_1.44.0
#> [4] mclust_6.1.2        BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        xfun_0.56           bslib_0.9.0
#>  [4] ggplot2_4.0.1       rstatix_0.7.3       lattice_0.22-7
#>  [7] vctrs_0.7.0         tools_4.5.2         generics_0.1.4
#> [10] parallel_4.5.2      tibble_3.3.1        pkgconfig_2.0.3
#> [13] Matrix_1.7-4        data.table_1.18.0   RColorBrewer_1.1-3
#> [16] S7_0.2.1            lifecycle_1.0.5     compiler_4.5.2
#> [19] farver_2.1.2        tinytex_0.58        codetools_0.2-20
#> [22] carData_3.0-5       htmltools_0.5.9     sass_0.4.10
#> [25] yaml_2.3.12         Formula_1.2-5       pillar_1.11.1
#> [28] car_3.1-3           ggpubr_0.6.2        jquerylib_0.1.4
#> [31] tidyr_1.3.2         cachem_1.1.0        survminer_0.5.1
#> [34] magick_2.9.0        abind_1.4-8         km.ci_0.5-6
#> [37] tidyselect_1.2.1    digest_0.6.39       dplyr_1.1.4
#> [40] purrr_1.2.1         bookdown_0.46       labeling_0.4.3
#> [43] splines_4.5.2       fastmap_1.2.0       grid_4.5.2
#> [46] cli_3.6.5           magrittr_2.0.4      dichromat_2.0-0.1
#> [49] broom_1.0.11        withr_3.0.2         scales_1.4.0
#> [52] backports_1.5.0     rmarkdown_2.30      matrixStats_1.5.0
#> [55] otel_0.2.0          gridExtra_2.3       ggsignif_0.6.4
#> [58] zoo_1.8-15          evaluate_1.0.5      knitr_1.51
#> [61] KMsurv_0.1-6        survMisc_0.5.6      rlang_1.1.7
#> [64] Rcpp_1.1.1          xtable_1.8-4        glue_1.8.0
#> [67] BiocManager_1.30.27 jsonlite_2.0.0      R6_2.6.1
```