# Additional visualizations of variance structure

#### Developed by [Gabriel Hoffman](http://gabrielhoffman.github.io/)

#### Run on 2025-12-11 21:37:01

* [Plot variance structure](#plot-variance-structure)
  + [By Individual](#by-individual)
  + [By Tissue](#by-tissue)
  + [By Individual and Tissue](#by-individual-and-tissue)
* [Session Info](#session-info)

The correlation structure between samples in complex study designs can be decomposed into the contribution of multiple dimensions of variation. `variancePartition` provides a statistical and visualization framework to interpret sources of variation. Here I describe a visualization of the correlation structure between samples for a single gene.

In the example dataset described in the main vignette, samples are correlated because they can come from the same individual or the same tissue. The function `plotCorrStructure()` shows the correlation structure caused by each variable as well and the joint correlation structure. Figure 1 shows the correlation between samples from the same individual where (a) shows the samples sorted based on clustering of the correlation matrix and (b) shows the original order. Figure 1 c) and d) shows the same type of plot except demonstrating the effect of tissue. The total correlation structure from summing individual and tissue correlation matricies is shown in Figure 2. The code to generate these plots is shown below.

# Plot variance structure

```
# Fit linear mixed model and examine correlation stucture
# for one gene
data(varPartData)

form <- ~ Age + (1 | Individual) + (1 | Tissue)

fitList <- fitVarPartModel(geneExpr[1:2, ], form, info)

# focus on one gene
fit <- fitList[[1]]
```

## By Individual

### Reorder samples

```
# Figure 1a
# correlation structure based on similarity within Individual
# reorder samples based on clustering
plotCorrStructure(fit, "Individual")
```

![](data:image/png;base64...)

### Original order of samples

```
# Figure 1b
# use original order of samples
plotCorrStructure(fit, "Individual", reorder = FALSE)
```

![](data:image/png;base64...)

## By Tissue

### Reorder samples

```
# Figure 1c
# correlation structure based on similarity within Tissue
# reorder samples based on clustering
plotCorrStructure(fit, "Tissue")
```

![](data:image/png;base64...)

### Original order of samples

```
# Figure 1d
# use original order of samples
plotCorrStructure(fit, "Tissue", reorder = FALSE)
```

![](data:image/png;base64...)

## By Individual and Tissue

### Reorder samples

```
# Figure 2a
# correlation structure based on similarity within
# Individual *and* Tissue, reorder samples based on clustering
plotCorrStructure(fit)
```

![](data:image/png;base64...)

### Original order of samples

```
# Figure 2b
# use original order of samples
plotCorrStructure(fit, reorder = FALSE)
```

![](data:image/png;base64...)

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
## [1] variancePartition_1.40.1 BiocParallel_1.44.0      limma_3.66.0
## [4] ggplot2_4.0.1            knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        xfun_0.54           bslib_0.9.0         caTools_1.18.3
##  [5] Biobase_2.70.0      lattice_0.22-7      numDeriv_2016.8-1.1 vctrs_0.6.5
##  [9] tools_4.5.2         Rdpack_2.6.4        bitops_1.0-9        generics_0.1.4
## [13] parallel_4.5.2      pbkrtest_0.5.5      tibble_3.3.0        pkgconfig_2.0.3
## [17] Matrix_1.7-4        KernSmooth_2.23-26  RColorBrewer_1.1-3  S7_0.2.1
## [21] lifecycle_1.0.4     stringr_1.6.0       compiler_4.5.2      farver_2.1.2
## [25] gplots_3.3.0        statmod_1.5.1       RhpcBLASctl_0.23-42 codetools_0.2-20
## [29] lmerTest_3.1-3      htmltools_0.5.9     sass_0.4.10         yaml_2.3.12
## [33] tidyr_1.3.1         pillar_1.11.1       nloptr_2.2.1        jquerylib_0.1.4
## [37] MASS_7.3-65         aod_1.3.3           cachem_1.1.0        reformulas_0.4.2
## [41] iterators_1.0.14    boot_1.3-32         nlme_3.1-168        gtools_3.9.5
## [45] tidyselect_1.2.1    digest_0.6.39       stringi_1.8.7       mvtnorm_1.3-3
## [49] fANCOVA_0.6-1       reshape2_1.4.5      purrr_1.2.0         dplyr_1.1.4
## [53] splines_4.5.2       fastmap_1.2.0       grid_4.5.2          cli_3.6.5
## [57] magrittr_2.0.4      dichromat_2.0-0.1   broom_1.0.11        corpcor_1.6.10
## [61] withr_3.0.2         backports_1.5.0     scales_1.4.0        remaCor_0.0.20
## [65] rmarkdown_2.30      matrixStats_1.5.0   lme4_1.1-38         evaluate_1.0.5
## [69] EnvStats_3.1.0      rbibutils_2.4       rlang_1.1.6         Rcpp_1.1.0
## [73] glue_1.8.0          BiocGenerics_0.56.0 minqa_1.2.8         jsonlite_2.0.0
## [77] plyr_1.8.9          R6_2.6.1
```