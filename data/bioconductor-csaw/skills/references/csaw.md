# Introducing the csaw package

Aaron Lun1

1Walter and Eliza Hall Institute for Medical Research, Melbourne, Australia

#### Revised: 17 February 2019

#### Package

csaw 1.44.0

# Contents

* [1 Introduction](#introduction)
* [2 Documentation](#documentation)
* [3 Session information](#session-information)

# 1 Introduction

The *[csaw](https://bioconductor.org/packages/3.22/csaw)* package is designed for the *de novo* detection of differentially bound regions from ChIP-seq data.
It uses a sliding window approach to count reads across the genome from sorted and indexed BAM files.
Each window is then tested for significant differences between libraries, using the methods in the *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* package.
It implements statistical methods for:

* normalization of window counts between libraries
* independent filtering of uninteresting windows
* controlling the false discovery rate across aggregated windows

*[csaw](https://bioconductor.org/packages/3.22/csaw)* can be applied to any data set containing multiple conditions with biological replication.
While intended for ChIP-seq data, the methods in this package can also be applied to any type of sequencing data where changes in genomic coverage are of interest.

# 2 Documentation

The full user’s guide is available as part of the online documentation in the *[csawBook](http://bioconductor.org/books/3.22/csawBook)* package.
It can be obtained by typing:

```
library(csaw)
if (interactive()) csawUsersGuide()
```

Documentation for speicific functions is available through the usual R help system, e.g., `?windowCounts`.
Further questions about the package should be directed to the [Bioconductor support site](https://support.bioconductor.org).

# 3 Session information

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
##  [1] csaw_1.44.0                 SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [5] matrixStats_1.5.0           GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4        limma_3.66.0        jsonlite_2.0.0
##  [4] crayon_1.5.3        compiler_4.5.1      BiocManager_1.30.26
##  [7] Rcpp_1.1.0          Biostrings_2.78.0   bitops_1.0-9
## [10] Rsamtools_2.26.0    parallel_4.5.1      jquerylib_0.1.4
## [13] statmod_1.5.1       BiocParallel_1.44.0 yaml_2.3.10
## [16] fastmap_1.2.0       lattice_0.22-7      R6_2.6.1
## [19] XVector_0.50.0      S4Arrays_1.10.0     knitr_1.50
## [22] DelayedArray_0.36.0 bookdown_0.45       bslib_0.9.0
## [25] rlang_1.1.6         cachem_1.1.0        xfun_0.53
## [28] sass_0.4.10         SparseArray_1.10.0  cli_3.6.5
## [31] locfit_1.5-9.12     digest_0.6.37       grid_4.5.1
## [34] edgeR_4.8.0         metapod_1.18.0      lifecycle_1.0.4
## [37] evaluate_1.0.5      codetools_0.2-20    abind_1.4-8
## [40] rmarkdown_2.30      tools_4.5.1         htmltools_0.5.8.1
```