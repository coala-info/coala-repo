# Saving `SummarizedExperiment`s to artifacts and back again

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: September 22, 2022

#### Package

alabaster.se 1.10.0

# Contents

* [1 Overview](#overview)
* [2 Quick start](#quick-start)
* [Session information](#session-information)

# 1 Overview

The *[alabaster.se](https://bioconductor.org/packages/3.22/alabaster.se)* package implements methods to save `SummarizedExperiment` objects to file artifacts and load them back into R.
Check out the *[alabaster.base](https://bioconductor.org/packages/3.22/alabaster.base)* for more details on the motivation and concepts of the **alabaster** framework.

# 2 Quick start

Given a `(Ranged)SummarizedExperiment`, we can use `saveObject()` to save it inside a staging directory:

```
# Example taken from ?SummarizedExperiment
library(SummarizedExperiment)
nrows <- 200
ncols <- 6
counts <- matrix(rpois(nrows * ncols, 10), nrows, ncols)
rowRanges <- GRanges(
    rep(c("chr1", "chr2"), c(50, 150)),
    IRanges(floor(runif(200, 1e5, 1e6)), width=100),
    strand=sample(c("+", "-"), 200, TRUE)
)
colData <- DataFrame(
    Treatment=rep(c("ChIP", "Input"), 3),
    row.names=LETTERS[1:6]
)
rse <- SummarizedExperiment(
    assays=SimpleList(counts=counts),
    rowRanges=rowRanges,
    colData=colData
)
rownames(rse) <- sprintf("GENE_%03d", 1:200)
rse
```

```
## class: RangedSummarizedExperiment
## dim: 200 6
## metadata(0):
## assays(1): counts
## rownames(200): GENE_001 GENE_002 ... GENE_199 GENE_200
## rowData names(0):
## colnames(6): A B ... E F
## colData names(1): Treatment
```

```
library(alabaster.se)
tmp <- tempfile()
saveObject(rse, tmp)

list.files(tmp, recursive=TRUE)
```

```
##  [1] "OBJECT"
##  [2] "_environment.json"
##  [3] "assays/0/OBJECT"
##  [4] "assays/0/array.h5"
##  [5] "assays/names.json"
##  [6] "column_data/OBJECT"
##  [7] "column_data/basic_columns.h5"
##  [8] "row_data/OBJECT"
##  [9] "row_data/basic_columns.h5"
## [10] "row_ranges/OBJECT"
## [11] "row_ranges/ranges.h5"
## [12] "row_ranges/sequence_information/OBJECT"
## [13] "row_ranges/sequence_information/info.h5"
```

We can then load it back into the session with `readObject()`.

```
roundtrip <- readObject(tmp)
roundtrip
```

```
## class: RangedSummarizedExperiment
## dim: 200 6
## metadata(0):
## assays(1): counts
## rownames(200): GENE_001 GENE_002 ... GENE_199 GENE_200
## rowData names(0):
## colnames(6): A B ... E F
## colData names(1): Treatment
```

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
##  [1] alabaster.se_1.10.0         alabaster.base_1.10.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4             jsonlite_2.0.0           compiler_4.5.1
##  [4] BiocManager_1.30.26      Rcpp_1.1.0               rhdf5filters_1.22.0
##  [7] alabaster.matrix_1.10.0  jquerylib_0.1.4          yaml_2.3.10
## [10] fastmap_1.2.0            lattice_0.22-7           R6_2.6.1
## [13] XVector_0.50.0           S4Arrays_1.10.0          knitr_1.50
## [16] DelayedArray_0.36.0      bookdown_0.45            h5mread_1.2.0
## [19] bslib_0.9.0              rlang_1.1.6              HDF5Array_1.38.0
## [22] cachem_1.1.0             xfun_0.53                alabaster.ranges_1.10.0
## [25] sass_0.4.10              SparseArray_1.10.0       cli_3.6.5
## [28] Rhdf5lib_1.32.0          digest_0.6.37            grid_4.5.1
## [31] alabaster.schemas_1.10.0 rhdf5_2.54.0             lifecycle_1.0.4
## [34] evaluate_1.0.5           abind_1.4-8              rmarkdown_2.30
## [37] tools_4.5.1              htmltools_0.5.8.1
```