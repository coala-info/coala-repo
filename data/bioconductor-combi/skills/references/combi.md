* [combi package: vignette](#combi-package-vignette)
* [Introduction](#introduction)
* [Installation](#installation)
  + [Unconstrained integration](#unconstrained-integration)
  + [Adding projections](#adding-projections)
  + [Coordinates](#coordinates)
  + [Constrained integration](#constrained-integration)
  + [Diagnostics](#diagnostics)
* [FAQ](#faq)
  + [Why are not all my samples shown in the constrained ordination?](#why-are-not-all-my-samples-shown-in-the-constrained-ordination)
  + [The combi function crashes, what should I do](#the-combi-function-crashes-what-should-i-do)
* [Session info](#session-info)

# combi package: vignette

# Introduction

This package implements a novel data integration model for sample-wise integration of different views. It accounts for compositionality and employs a non-parametric mean-variance trend for sequence count data. The resulting model can be conveniently plotted to allow for explorative visualization of variability shared over different views.

# Installation

The package can be installed and loaded using the following commands:

```
library(BiocManager)
BiocManager::install("combi", update = FALSE)
```

```
library(devtools)
install_github("CenterForStatistics-UGent/combi")
```

```
suppressPackageStartupMessages(library(combi))
cat("combi package version", as.character(packageVersion("combi")), "\n")
```

```
## combi package version 1.22.0
```

```
data(Zhang)
```

## Unconstrained integration

For an unconstrained ordination, a named list of datasets with overlapping samples must be supplied. The datasets can currently be supplied as a raw data matrix (with features in the columns), or as a phyloseq, SummarizedExperiment or ExpressionSet object. In addition, information on the required distribution (“quasi” for quasi-likelihood fitting, “gaussian” for normal data) and compositional nature (TRUE/FALSE) should be supplied

```
microMetaboInt = combi(list(microbiome = zhangMicrobio, metabolomics = zhangMetabo),
    distributions = c("quasi", "gaussian"), compositional = c(TRUE, FALSE), logTransformGaussian = FALSE)
```

One can print basic infor about the ordination

```
microMetaboInt
```

```
## Unconstrained combi ordination of 2 dimensions on 2 views with 42 samples.
## Views and number of features were:
##  microbiome: 130
##  metabolomics: 174
##  Importance parameters of dimensions 1 to 2 are 117 and 44.9
```

A simple plot function is available for the result, for samples and shapes, a data frame should also be supplied

```
plot(microMetaboInt)
```

![](data:image/png;base64...)

```
plot(microMetaboInt, samDf = zhangMetavars, samCol = "ABX")
```

![](data:image/png;base64...)

By default, only the most important features (furthest away from the origin) are shown. To show all features, one can resort to point cloud plots or density plots as follows:

```
plot(microMetaboInt, samDf = zhangMetavars, samCol = "ABX", featurePlot = "points")
```

![](data:image/png;base64...)

```
plot(microMetaboInt, samDf = zhangMetavars, samCol = "ABX", featurePlot = "density")
```

![](data:image/png;base64...)

The drawback is that now no feature labels are shown.

## Adding projections

As an aid to interpretation of compositional views, links between features can be plotted and projected onto samples by providing their names or approximate coordinates

```
# First define the plot, and return the coordinates
mmPlot = plot(microMetaboInt, samDf = zhangMetavars, samCol = "ABX", returnCoords = TRUE,
    featNum = 10)
# Providing feature names, and sample coordinates, but any combination is
# allowed
addLink(mmPlot, links = cbind("Staphylococcus_819c11", "OTU929ffc"), Views = 1, samples = c(0,
    1))
```

![](data:image/png;base64...)

## Coordinates

Finally, one can extract the coordinates for use in third-party software

```
coords = extractCoords(microMetaboInt, Dim = c(1, 2))
```

## Constrained integration

For a constrained ordination also a data frame of sample variables should be supplied

```
microMetaboIntConstr = combi(list(microbiome = zhangMicrobio, metabolomics = zhangMetabo),
    distributions = c("quasi", "gaussian"), compositional = c(TRUE, FALSE), logTransformGaussian = FALSE,
    covariates = zhangMetavars)
```

Also here we can get a quick overview

```
microMetaboIntConstr
```

```
## Constrained combi ordination of 2 dimensions on 2 views with 42 samples.
## Views and number of features were:
##  microbiome: 130
##  metabolomics: 174
##  Number of sample variables included was 4,
## for which 6 parameters were estimated per dimension.
##  Importance parameters of dimensions 1 to 2 are 34.2 and 21.4
```

and plot the ordination

```
plot(microMetaboIntConstr, samDf = zhangMetavars, samCol = "ABX")
```

![](data:image/png;base64...)

## Diagnostics

Convergence of the iterative algorithm can be assessed as follows:

```
convPlot(microMetaboInt)
```

![](data:image/png;base64...)

Influence of the different views can be investigated through

```
inflPlot(microMetaboInt, samples = 1:20, plotType = "boxplot")
```

![](data:image/png;base64...)

# FAQ

## Why are not all my samples shown in the constrained ordination?

Confusion often arises as to why less distinct sample dots are shown than there are samples in the constrained ordination. This occurs when few, categorical constraining variables are supplied as below.

```
# Linear with only 2 variables
microMetaboIntConstr2Vars = combi(list(microbiome = zhangMicrobio, metabolomics = zhangMetabo),
    distributions = c("quasi", "gaussian"), compositional = c(TRUE, FALSE), logTransformGaussian = FALSE,
    covariates = zhangMetavars[, c("Sex", "ABX")])
```

Every constrained sample score is a linear combination of constraining variables, and in this case there are only 2x2=4 distinct sample scores possible, leading to the sample dots from the same gender and treatment to be plotted on top of each other.

```
plot(microMetaboIntConstr2Vars, samDf = zhangMetavars, samCol = "ABX")
```

![](data:image/png;base64...)

In general, it is best to include all measured sample variables in a constrained analysis, and let the combi-algorithm find out which ones are the most important drivers of variability.

## The combi function crashes, what should I do

The *combi* method works by iteratively solving systems of non-linear equations through Newton-Raphson. This can lead to numerical instability, with errors like “infinite values returned by jacobian” in the *nleqslv* function. This class of problems has no general solution, but is mainly a matter of trial and error. Following two things can be tried:

1. Tweaking the *prevCutOff* and *minFraction* parameters to remove more sparse features.
2. Tweaking the *initPower* parameter, which will lead to different starting values, and hopefully a solution path that is numerically more stable.

```
# Linear with only 2 variables
microMetaboTweak = combi(list(microbiome = zhangMicrobio, metabolomics = zhangMetabo),
    distributions = c("quasi", "gaussian"), compositional = c(TRUE, FALSE), logTransformGaussian = FALSE,
    initPower = 1.5, minFraction = 0.25, prevCutOff = 0.8)
```

# Session info

This vignette was generated with following version of R:

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
## [1] combi_1.22.0 DBI_1.2.3
##
## loaded via a namespace (and not attached):
##  [1] ade4_1.7-23                 tidyselect_1.2.1
##  [3] dplyr_1.1.4                 farver_2.1.2
##  [5] Biostrings_2.78.0           S7_0.2.0
##  [7] fastmap_1.2.0               phyloseq_1.54.0
##  [9] digest_0.6.37               lifecycle_1.0.4
## [11] cluster_2.1.8.1             survival_3.8-3
## [13] statmod_1.5.1               magrittr_2.0.4
## [15] compiler_4.5.1              rlang_1.1.6
## [17] sass_0.4.10                 tools_4.5.1
## [19] igraph_2.2.1                yaml_2.3.10
## [21] data.table_1.17.8           knitr_1.50
## [23] BB_2019.10-1                labeling_0.4.3
## [25] S4Arrays_1.10.0             DelayedArray_0.36.0
## [27] alabama_2023.1.0            plyr_1.8.9
## [29] RColorBrewer_1.1-3          abind_1.4-8
## [31] withr_3.0.2                 nleqslv_3.3.5
## [33] numDeriv_2016.8-1.1         BiocGenerics_0.56.0
## [35] grid_4.5.1                  stats4_4.5.1
## [37] multtest_2.66.0             biomformat_1.38.0
## [39] Rhdf5lib_1.32.0             ggplot2_4.0.0
## [41] scales_1.4.0                iterators_1.0.14
## [43] MASS_7.3-65                 isoband_0.2.7
## [45] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
## [47] cli_3.6.5                   vegan_2.7-2
## [49] rmarkdown_2.30              crayon_1.5.3
## [51] generics_0.1.4              reshape2_1.4.4
## [53] ape_5.8-1                   cachem_1.1.0
## [55] rhdf5_2.54.0                stringr_1.5.2
## [57] splines_4.5.1               parallel_4.5.1
## [59] formatR_1.14                XVector_0.50.0
## [61] matrixStats_1.5.0           vctrs_0.6.5
## [63] Matrix_1.7-4                jsonlite_2.0.0
## [65] SparseM_1.84-2              IRanges_2.44.0
## [67] S4Vectors_0.48.0            tensor_1.5.1
## [69] foreach_1.5.2               limma_3.66.0
## [71] jquerylib_0.1.4             glue_1.8.0
## [73] codetools_0.2-20            stringi_1.8.7
## [75] gtable_0.3.6                GenomicRanges_1.62.0
## [77] quadprog_1.5-8              tibble_3.3.0
## [79] pillar_1.11.1               cobs_1.3-9-1
## [81] htmltools_0.5.8.1           quantreg_6.1
## [83] Seqinfo_1.0.0               rhdf5filters_1.22.0
## [85] R6_2.6.1                    evaluate_1.0.5
## [87] lattice_0.22-7              Biobase_2.70.0
## [89] bslib_0.9.0                 MatrixModels_0.5-4
## [91] Rcpp_1.1.0                  permute_0.9-8
## [93] SparseArray_1.10.0          nlme_3.1-168
## [95] mgcv_1.9-3                  xfun_0.53
## [97] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```