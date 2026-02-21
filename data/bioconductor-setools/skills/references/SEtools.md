# SEtools

Pierre-Luc Germain1,2

1D-HEST Institute for Neurosciences, ETH Zürich
2Laboratory of Statistical Bioinformatics, University Zürich

#### 30 October 2025

#### Abstract

Showcases the use of SEtools to merge objects of the SummarizedExperiment class.

#### Package

SEtools 1.24.0

# Contents

* [1 Getting started](#getting-started)
  + [1.1 Package installation](#package-installation)
  + [1.2 Example data](#example-data)
  + [1.3 Merging and aggregating SEs](#merging-and-aggregating-ses)
    - [1.3.1 Merging by rowData columns](#merging-by-rowdata-columns)
    - [1.3.2 Aggregating a SE](#aggregating-a-se)
  + [1.4 Other convenience functions](#other-convenience-functions)
* [Session info](#session-info)

# 1 Getting started

The *SEtools* package is a set of convenience functions for the *Bioconductor* class *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*. It facilitates merging, melting, and plotting `SummarizedExperiment` objects.

**NOTE that the heatmap-related and melting functions have been moved to a standalone package, *[sechm](https://bioconductor.org/packages/3.22/sechm)*.**
The old `sehm` function of `SEtools` should be considered deprecated, and most `SEtools` functions are conserved for legacy/reproducibility reasons (or until they find a better home).

## 1.1 Package installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SEtools")
```

Or, to install the latest development version:

```
BiocManager::install("plger/SEtools")
```

## 1.2 Example data

To showcase the main functions, we will use an example object which contains (a subset of) whole-hippocampus RNAseq of mice after different stressors:

```
suppressPackageStartupMessages({
  library(SummarizedExperiment)
  library(SEtools)
})
data("SE", package="SEtools")
SE
```

```
## class: SummarizedExperiment
## dim: 100 20
## metadata(0):
## assays(2): counts logcpm
## rownames(100): Egr1 Nr4a1 ... CH36-200G6.4 Bhlhe22
## rowData names(2): meanCPM meanTPM
## colnames(20): HC.Homecage.1 HC.Homecage.2 ... HC.Swim.4 HC.Swim.5
## colData names(2): Region Condition
```

This is taken from [Floriou-Servou et al., Biol Psychiatry 2018](https://doi.org/10.1016/j.biopsych.2018.02.003).

## 1.3 Merging and aggregating SEs

```
se1 <- SE[,1:10]
se2 <- SE[,11:20]
se3 <- mergeSEs( list(se1=se1, se2=se2) )
se3
```

```
## class: SummarizedExperiment
## dim: 100 20
## metadata(3): se1 se2 anno_colors
## assays(2): counts logcpm
## rownames(100): AC139063.2 Actr6 ... Zfp667 Zfp930
## rowData names(2): meanCPM meanTPM
## colnames(20): se1.HC.Homecage.1 se1.HC.Homecage.2 ... se2.HC.Swim.4
##   se2.HC.Swim.5
## colData names(3): Dataset Region Condition
```

All assays were merged, along with rowData and colData slots.

By default, row z-scores are calculated for each object when merging. This can be prevented with:

```
se3 <- mergeSEs( list(se1=se1, se2=se2), do.scale=FALSE)
```

If more than one assay is present, one can specify a different scaling behavior for each assay:

```
se3 <- mergeSEs( list(se1=se1, se2=se2), use.assays=c("counts", "logcpm"), do.scale=c(FALSE, TRUE))
```

Differences to the `cbind` method include prefixes added to column names, optional scaling, handling of metadata (e.g. for `sechm`)

### 1.3.1 Merging by rowData columns

It is also possible to merge by rowData columns, which are specified through the `mergeBy` argument.
In this case, one can have one-to-many and many-to-many mappings, in which case two behaviors are possible:

* By default, all combinations will be reported, which means that the same feature of one object might appear multiple times in the output because it matches multiple features of another object.
* If a function is passed through `aggFun`, the features of each object will by aggregated by `mergeBy` using this function before merging.

```
rowData(se1)$metafeature <- sample(LETTERS,nrow(se1),replace = TRUE)
rowData(se2)$metafeature <- sample(LETTERS,nrow(se2),replace = TRUE)
se3 <- mergeSEs( list(se1=se1, se2=se2), do.scale=FALSE, mergeBy="metafeature", aggFun=median)
```

```
## Aggregating the objects by metafeature
```

```
## Merging...
```

```
sechm::sechm(se3, features=row.names(se3))
```

![](data:image/png;base64...)

### 1.3.2 Aggregating a SE

A single SE can also be aggregated by using the `aggSE` function:

```
se1b <- aggSE(se1, by = "metafeature")
```

```
## Aggregation methods for each assay:
## counts: sum; logcpm: expsum
```

```
se1b
```

```
## class: SummarizedExperiment
## dim: 24 10
## metadata(0):
## assays(2): counts logcpm
## rownames(24): A B ... Y Z
## rowData names(0):
## colnames(10): HC.Homecage.1 HC.Homecage.2 ... HC.Handling.4
##   HC.Handling.5
## colData names(2): Region Condition
```

If the aggregation function(s) are not specified, `aggSE` will try to guess decent aggregation functions from the assay names.

This is similar to `scuttle::sumCountsAcrossFeatures`, but preserves other SE slots.

---

## 1.4 Other convenience functions

Calculate an assay of log-foldchanges to the controls:

```
SE <- log2FC(SE, fromAssay="logcpm", controls=SE$Condition=="Homecage")
```

# Session info

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] SEtools_1.24.0              sechm_1.18.0
##  [3] ComplexHeatmap_2.26.0       SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3            rlang_1.1.6          magrittr_2.0.4
##   [4] clue_0.3-66          GetoptLong_1.0.5     RSQLite_2.4.3
##   [7] compiler_4.5.1       mgcv_1.9-3           png_0.1-8
##  [10] vctrs_0.6.5          sva_3.58.0           stringr_1.5.2
##  [13] pkgconfig_2.0.3      shape_1.4.6.1        crayon_1.5.3
##  [16] fastmap_1.2.0        magick_2.9.0         XVector_0.50.0
##  [19] ca_0.71.1            rmarkdown_2.30       tinytex_0.57
##  [22] bit_4.6.0            xfun_0.53            cachem_1.1.0
##  [25] jsonlite_2.0.0       blob_1.2.4           DelayedArray_0.36.0
##  [28] BiocParallel_1.44.0  parallel_4.5.1       cluster_2.1.8.1
##  [31] R6_2.6.1             bslib_0.9.0          stringi_1.8.7
##  [34] RColorBrewer_1.1-3   limma_3.66.0         genefilter_1.92.0
##  [37] jquerylib_0.1.4      Rcpp_1.1.0           bookdown_0.45
##  [40] iterators_1.0.14     knitr_1.50           splines_4.5.1
##  [43] Matrix_1.7-4         tidyselect_1.2.1     dichromat_2.0-0.1
##  [46] abind_1.4-8          yaml_2.3.10          TSP_1.2-5
##  [49] doParallel_1.0.17    codetools_0.2-20     curl_7.0.0
##  [52] lattice_0.22-7       tibble_3.3.0         KEGGREST_1.50.0
##  [55] S7_0.2.0             evaluate_1.0.5       Rtsne_0.17
##  [58] survival_3.8-3       zip_2.3.3            Biostrings_2.78.0
##  [61] circlize_0.4.16      pillar_1.11.1        BiocManager_1.30.26
##  [64] foreach_1.5.2        ggplot2_4.0.0        scales_1.4.0
##  [67] xtable_1.8-4         glue_1.8.0           pheatmap_1.0.13
##  [70] tools_4.5.1          data.table_1.17.8    openxlsx_4.2.8
##  [73] annotate_1.88.0      locfit_1.5-9.12      registry_0.5-1
##  [76] XML_3.99-0.19        Cairo_1.7-0          seriation_1.5.8
##  [79] AnnotationDbi_1.72.0 edgeR_4.8.0          colorspace_2.1-2
##  [82] nlme_3.1-168         randomcoloR_1.1.0.1  cli_3.6.5
##  [85] S4Arrays_1.10.0      dplyr_1.1.4          V8_8.0.1
##  [88] gtable_0.3.6         DESeq2_1.50.0        sass_0.4.10
##  [91] digest_0.6.37        SparseArray_1.10.0   rjson_0.2.23
##  [94] farver_2.1.2         memoise_2.0.1        htmltools_0.5.8.1
##  [97] lifecycle_1.0.4      httr_1.4.7           GlobalOptions_0.1.2
## [100] statmod_1.5.1        bit64_4.6.0-1
```