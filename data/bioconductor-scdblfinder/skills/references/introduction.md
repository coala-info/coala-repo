# Introduction to the scDblFinder package

Pierre-Luc Germain1\* and Aaron Lun\*\*

1University and ETH Zürich

\*pierre-luc.germain@hest.ethz.ch
\*\*infinite.monkeys.with.keyboards@gmail.com

#### 30 October 2025

#### Abstract

An introduction to the various methods included in the scDblFinder package.

#### Package

scDblFinder 1.24.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 computeDoubletDensity](#computedoubletdensity)
  + [1.2 recoverDoublets](#recoverdoublets)
  + [1.3 scDblFinder](#scdblfinder)
  + [1.4 directDblClassification](#directdblclassification)
  + [1.5 findDoubletClusters](#finddoubletclusters)
* [2 Installation](#installation)
* [3 Which method to choose?](#which-method-to-choose)
* [Session information](#session-information)

# 1 Introduction

The `scDblFinder` package gathers various methods for the detection and handling of doublets/multiplets in single-cell sequencing data (i.e. multiple cells captured within the same droplet or reaction volume).
This vignette provides a brief overview of the different approaches (which are each covered in their own vignettes) for single-cell RNA sequencing.
*For doublet detection in genomic data, see the [scATACseq vignette](scATAC.html)*.
For a more general introduction to the topic of doublets, refer to the [OCSA book](https://osca.bioconductor.org/doublet-detection.html).

All methods require as an input either a matrix of counts or a *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* containing count data. With the exception of [findDoubletClusters](findDoubletClusters.html), which operates at the level of clusters (and consequently requires clustering information), all methods try to assign each cell a score indicating its likelihood (broadly understood) of being a doublet.

The approaches described here are *complementary* to doublets identified via cell hashes and SNPs in multiplexed samples: while hashing/genotypes can identify doublets formed by cells of the same type (homotypic doublets) from two samples, which are often nearly undistinguishable from real cells transcriptionally (and hence generally unidentifiable through the present package), it cannot identify doublets made by cells of the same sample, even if they are heterotypic (formed by different cell types). Indeed, recent evidence suggests that doublets are for instance a serious and strongly underestimated issue in 10x Flex datasets (see [Howitt et al., 2024](https://www.biorxiv.org/content/10.1101/2024.10.03.616596v2)). Instead, the methods presented here are primarily geared towards the identification of heterotypic doublets, which for most purposes are also the most critical ones.

## 1.1 computeDoubletDensity

The `computeDoubletDensity` method (formerly `scran::doubletCells`) generates random artificial doublets from the real cells, and tries to identify cells whose neighborhood has a high local density of articial doublets. See [computeDoubletDensity](computeDoubletDensity.html) for more information.

## 1.2 recoverDoublets

The `recoverDoublets` method is meant to be used when some doublets are already known, for instance through genotype-based calls or cell hashing in multiplexed experiments. The function then tries to identify intra-sample doublets that are neighbors to the known inter-sample doublets. See [recoverDoublets](recoverDoublets.html) for more information.

## 1.3 scDblFinder

The `scDblFinder` method combines both known doublets (if available) and cluster-based artificial doublets to identify doublets. The approach builds and improves on a variety of earlier efforts, and is at present the most accurate approach included in this package. See [scDblFinder](scDblFinder.html) for more information.

## 1.4 directDblClassification

The `directDblClassification` method identifies doublets by training a classifier directly on gene expression.
This follows the same procedure as `scDblFinder` for doublet generation and iterative training, but skips the *k*-nearest neighbor step and directly uses the matrix of real cells and artificial doublets.
This is computationally more intensive and generally leads to worse predictions than `scDblFinder`, and it is included chiefly for comparative purposes.
See `?directDblClassification` for more information.

## 1.5 findDoubletClusters

The `findDoubletClusters` method identifies clusters that are likely to be composed of doublets by estimating whether their expression profile lies between two other clusters. See [findDoubletClusters](findDoubletClusters.html) for more information.

# 2 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scDblFinder")

# or, to get that latest developments:
BiocManager::install("plger/scDblFinder")
```

# 3 Which method to choose?

A benchmark of the main methods available in the package is presented in the [scDblFinder paper](https://f1000research.com/articles/10-979/).
While the different methods included here have their values, overall the `scDblFinder` method had the best performance (also superior to other methods not included in this package), and should be used by default.

# Session information

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
##  [1] bluster_1.20.0              scDblFinder_1.24.0
##  [3] scater_1.38.0               ggplot2_4.0.0
##  [5] scran_1.38.0                scuttle_1.20.0
##  [7] ensembldb_2.34.0            AnnotationFilter_1.34.0
##  [9] GenomicFeatures_1.62.0      AnnotationDbi_1.72.0
## [11] scRNAseq_2.23.1             SingleCellExperiment_1.32.0
## [13] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [15] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [17] IRanges_2.44.0              S4Vectors_0.48.0
## [19] BiocGenerics_0.56.0         generics_0.1.4
## [21] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [23] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       jsonlite_2.0.0           magrittr_2.0.4
##   [4] magick_2.9.0             ggbeeswarm_0.7.2         gypsum_1.6.0
##   [7] farver_2.1.2             rmarkdown_2.30           BiocIO_1.20.0
##  [10] vctrs_0.6.5              memoise_2.0.1            Rsamtools_2.26.0
##  [13] RCurl_1.98-1.17          tinytex_0.57             htmltools_0.5.8.1
##  [16] S4Arrays_1.10.0          AnnotationHub_4.0.0      curl_7.0.0
##  [19] BiocNeighbors_2.4.0      xgboost_1.7.11.1         Rhdf5lib_1.32.0
##  [22] SparseArray_1.10.0       rhdf5_2.54.0             sass_0.4.10
##  [25] alabaster.base_1.10.0    bslib_0.9.0              alabaster.sce_1.10.0
##  [28] httr2_1.2.1              cachem_1.1.0             GenomicAlignments_1.46.0
##  [31] igraph_2.2.1             lifecycle_1.0.4          pkgconfig_2.0.3
##  [34] rsvd_1.0.5               Matrix_1.7-4             R6_2.6.1
##  [37] fastmap_1.2.0            digest_0.6.37            dqrng_0.4.1
##  [40] irlba_2.3.5.1            ExperimentHub_3.0.0      RSQLite_2.4.3
##  [43] beachmat_2.26.0          labeling_0.4.3           filelock_1.0.3
##  [46] httr_1.4.7               abind_1.4-8              compiler_4.5.1
##  [49] bit64_4.6.0-1            withr_3.0.2              S7_0.2.0
##  [52] BiocParallel_1.44.0      viridis_0.6.5            DBI_1.2.3
##  [55] HDF5Array_1.38.0         alabaster.ranges_1.10.0  alabaster.schemas_1.10.0
##  [58] MASS_7.3-65              rappdirs_0.3.3           DelayedArray_0.36.0
##  [61] rjson_0.2.23             tools_4.5.1              vipor_0.4.7
##  [64] beeswarm_0.4.0           glue_1.8.0               h5mread_1.2.0
##  [67] restfulr_0.0.16          rhdf5filters_1.22.0      grid_4.5.1
##  [70] Rtsne_0.17               cluster_2.1.8.1          gtable_0.3.6
##  [73] data.table_1.17.8        BiocSingular_1.26.0      ScaledMatrix_1.18.0
##  [76] metapod_1.18.0           XVector_0.50.0           ggrepel_0.9.6
##  [79] BiocVersion_3.22.0       pillar_1.11.1            limma_3.66.0
##  [82] dplyr_1.1.4              BiocFileCache_3.0.0      lattice_0.22-7
##  [85] rtracklayer_1.70.0       bit_4.6.0                tidyselect_1.2.1
##  [88] locfit_1.5-9.12          Biostrings_2.78.0        knitr_1.50
##  [91] gridExtra_2.3            bookdown_0.45            ProtGenerics_1.42.0
##  [94] edgeR_4.8.0              xfun_0.53                statmod_1.5.1
##  [97] UCSC.utils_1.6.0         lazyeval_0.2.2           yaml_2.3.10
## [100] evaluate_1.0.5           codetools_0.2-20         cigarillo_1.0.0
## [103] tibble_3.3.0             alabaster.matrix_1.10.0  BiocManager_1.30.26
## [106] cli_3.6.5                jquerylib_0.1.4          dichromat_2.0-0.1
## [109] Rcpp_1.1.0               GenomeInfoDb_1.46.0      dbplyr_2.5.1
## [112] png_0.1-8                XML_3.99-0.19            parallel_4.5.1
## [115] blob_1.2.4               bitops_1.0-9             viridisLite_0.4.2
## [118] alabaster.se_1.10.0      scales_1.4.0             purrr_1.1.0
## [121] crayon_1.5.3             rlang_1.1.6              cowplot_1.2.0
## [124] KEGGREST_1.50.0
```