# Probability plot usage

Jakob Theorell1,2

1Oxford Autoimmune Neurology Group, Nuffield Department of Clinical Neurosciences, University of Oxford, Oxford, United Kingdom
2Department of Clinical Neurosciences, Karolinska Institutet, Stockholm, Sweden

#### 2025-10-29

# 1 Introduction

In this document, a typical analysis using the groupProbPlot function is shown.
The indention with this function is to display differences between groups,
tissues, stimulations or similar, with a single-cell resolution. The idea is
that a cell that comes from a cell type that is specific for one of the two
investigated groups will be surrounded exclusively by euclidean nearest
neighbors that come from the same group. This is the basis for the analysis:
in the standard case, the individual cell is given a number between -1 and 1
that reflects which fraction of the 100 closest neighbors in the euclidean space
created by all the input markers that come from one group (-1) or the other (1).
The scale is tweaked to reflect that the middle in this case corresponds to a
likelihood of a perfect mix with 50% of the cells from each group. For an
introduction to the package and example data description, see the general
DepecheR package vinjette.

# 2 Installation

This is how to install the package, if that has not already been done:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DepecheR")
```

# 3 Preparations of example data

For visualization purposes, some 2-dimensional representation of the data is
necessary. This could just be two of the variables used to construct the
probability vector, but it is more informative to include data on all variables,
aided by e.g. tSNE or UMAP. In this case, we will display the data with tSNE.

```
library(DepecheR)
data("testData")
data("testDataSNE")
```

# 4 Group probability plotting

This function differs from the other group differentiation functions in the
DepecheR package in that no clustering output from the depeche function or any
other clustering algorithm is needed as input. Instead, all the indata that the
euclidean nearest neighbors should be identified from needs to be added,
together with a group identity vector and the 2D data used to display the data.
Optionally, the resulting group probability vector can be returned, which will
be the case in this example.

```
dataTrans <-
  testData[, c("SYK", "CD16", "CD57", "EAT.2", "CD8", "NKG2C", "CD2", "CD56")]

testData$groupProb <- groupProbPlot(xYData = testDataSNE$Y,
                                    groupVector = testData$label,
                                    groupName1 = "Group_1",
                                    groupName2 = "Group_2",
                                    dataTrans = dataTrans)
## [1] "Done with k-means"
## [1] "Now the first bit is done, and the iterative part takes off"
## [1] "Clusters 1 to 7 smoothed in 2.9159369468689 . Now, 13 clusters are
## [1] left."
## [1] "Clusters 8 to 14 smoothed in 0.925199031829834 . Now, 6 clusters are
## [1] left."
## [1] "Clusters 15 to 20 smoothed in 0.905373096466064 . Now, 0 clusters are
## [1] left."
```

When running this function, the output is a high-resolution plot saved to disc.
A low resolution variant of the result (made small for BioConductor size
constraint reasons) is shown here. In this case, the groups are so separated,
that almost all cells show a 100% probability of belonging to one of the groups
or the other. This is unusual with real data, so the white fields are generally
larger.

![](data:image/png;base64...)

Group probaility plot

# 5 Session information

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
## [1] DepecheR_1.26.0  knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        ellipse_0.5.0       xfun_0.53
##  [4] bslib_0.9.0         ggplot2_4.0.0       gmodels_2.19.1
##  [7] caTools_1.18.3      ggrepel_0.9.6       collapse_2.1.4
## [10] lattice_0.22-7      vctrs_0.6.5         tools_4.5.1
## [13] doSNOW_1.0.20       bitops_1.0-9        generics_0.1.4
## [16] parallel_4.5.1      tibble_3.3.0        DEoptimR_1.1-4
## [19] rARPACK_0.11-0      pkgconfig_2.0.3     Matrix_1.7-4
## [22] KernSmooth_2.23-26  RColorBrewer_1.1-3  S7_0.2.0
## [25] mixOmics_6.34.0     lifecycle_1.0.4     compiler_4.5.1
## [28] farver_2.1.2        stringr_1.5.2       FNN_1.1.4.1
## [31] gplots_3.2.0        codetools_0.2-20    snow_0.4-4
## [34] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
## [37] beanplot_1.3.1      gmp_0.7-5           tidyr_1.3.1
## [40] pillar_1.11.1       jquerylib_0.1.4     MASS_7.3-65
## [43] BiocParallel_1.44.0 gdata_3.0.1         cachem_1.1.0
## [46] viridis_0.6.5       iterators_1.0.14    foreach_1.5.2
## [49] robustbase_0.99-6   RSpectra_0.16-2     gtools_3.9.5
## [52] tidyselect_1.2.1    digest_0.6.37       stringi_1.8.7
## [55] purrr_1.1.0         dplyr_1.1.4         reshape2_1.4.4
## [58] bookdown_0.45       fastmap_1.2.0       grid_4.5.1
## [61] cli_3.6.5           magrittr_2.0.4      dichromat_2.0-0.1
## [64] corpcor_1.6.10      scales_1.4.0        rmarkdown_2.30
## [67] matrixStats_1.5.0   igraph_2.2.1        gridExtra_2.3
## [70] moments_0.14.1      evaluate_1.0.5      viridisLite_0.4.2
## [73] rlang_1.1.6         Rcpp_1.1.0          glue_1.8.0
## [76] BiocManager_1.30.26 jsonlite_2.0.0      R6_2.6.1
## [79] ClusterR_1.3.5      plyr_1.8.9
```