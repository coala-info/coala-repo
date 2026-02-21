# Saving `SingleCellExperiment`s to artifacts and back again

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: November 29, 2023

#### Package

alabaster.sce 1.10.0

# Contents

* [1 Overview](#overview)
* [2 Quick start](#quick-start)
* [Session information](#session-information)

# 1 Overview

The *[alabaster.sce](https://bioconductor.org/packages/3.22/alabaster.sce)* package implements methods to save `SingleCellExperiment` objects to file artifacts and load them back into R.
Check out the *[alabaster.base](https://bioconductor.org/packages/3.22/alabaster.base)* for more details on the motivation and concepts of the **alabaster** framework.

# 2 Quick start

Given a `SingleCellExperiment`, we can use `saveObject()` to save it inside a staging directory:

```
library(SingleCellExperiment)
mat <- matrix(rpois(10000, 10), ncol=10)
colnames(mat) <- letters[1:10]
rownames(mat) <- sprintf("GENE_%i", seq_len(nrow(mat)))

sce <- SingleCellExperiment(list(counts=mat))
sce$stuff <- LETTERS[1:10]
sce$blah <- runif(10)
reducedDims(sce) <- list(
 PCA=matrix(rnorm(ncol(sce)*10), ncol=10),
 TSNE=matrix(rnorm(ncol(sce)*2), ncol=2)
)
altExps(sce) <- list(spikes=SummarizedExperiment(list(counts=mat[1:2,])))
sce
```

```
## class: SingleCellExperiment
## dim: 1000 10
## metadata(0):
## assays(1): counts
## rownames(1000): GENE_1 GENE_2 ... GENE_999 GENE_1000
## rowData names(0):
## colnames(10): a b ... i j
## colData names(2): stuff blah
## reducedDimNames(2): PCA TSNE
## mainExpName: NULL
## altExpNames(1): spikes
```

```
library(alabaster.sce)
tmp <- tempfile()
saveObject(sce, tmp)

list.files(tmp, recursive=TRUE)
```

```
##  [1] "OBJECT"
##  [2] "_environment.json"
##  [3] "alternative_experiments/0/OBJECT"
##  [4] "alternative_experiments/0/assays/0/OBJECT"
##  [5] "alternative_experiments/0/assays/0/array.h5"
##  [6] "alternative_experiments/0/assays/names.json"
##  [7] "alternative_experiments/0/column_data/OBJECT"
##  [8] "alternative_experiments/0/column_data/basic_columns.h5"
##  [9] "alternative_experiments/0/row_data/OBJECT"
## [10] "alternative_experiments/0/row_data/basic_columns.h5"
## [11] "alternative_experiments/names.json"
## [12] "assays/0/OBJECT"
## [13] "assays/0/array.h5"
## [14] "assays/names.json"
## [15] "column_data/OBJECT"
## [16] "column_data/basic_columns.h5"
## [17] "reduced_dimensions/0/OBJECT"
## [18] "reduced_dimensions/0/array.h5"
## [19] "reduced_dimensions/1/OBJECT"
## [20] "reduced_dimensions/1/array.h5"
## [21] "reduced_dimensions/names.json"
## [22] "row_data/OBJECT"
## [23] "row_data/basic_columns.h5"
```

We can then load it back into the session with `loadObject()`.

```
roundtrip <- readObject(tmp)
class(roundtrip)
```

```
## [1] "SingleCellExperiment"
## attr(,"package")
## [1] "SingleCellExperiment"
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
##  [1] alabaster.sce_1.10.0        alabaster.base_1.10.0
##  [3] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocStyle_2.38.0
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
## [34] alabaster.se_1.10.0      evaluate_1.0.5           abind_1.4-8
## [37] rmarkdown_2.30           tools_4.5.1              htmltools_0.5.8.1
```