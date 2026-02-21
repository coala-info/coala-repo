# Saving arrays to artifacts and back again

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: November 28, 2023

#### Package

alabaster.matrix 1.10.0

# Contents

* [1 Overview](#overview)
* [2 Quick start](#quick-start)
* [3 Saving delayed operations](#saving-delayed-operations)
* [Session information](#session-information)

# 1 Overview

The *[alabaster.matrix](https://github.com/ArtifactDB/alabaster.matrix)* package implements methods to save matrix-like objects to file artifacts and load them back into R.
Check out the *[alabaster.base](https://github.com/ArtifactDB/alabaster.base)* for more details on the motivation and the **alabaster** framework.

# 2 Quick start

Given an array-like object, we can use `saveObject()` to save it inside a staging directory:

```
library(Matrix)
y <- rsparsematrix(1000, 100, density=0.05)

library(alabaster.matrix)
tmp <- tempfile()
saveObject(y, tmp)

list.files(tmp, recursive=TRUE)
```

```
## [1] "OBJECT"            "_environment.json" "matrix.h5"
```

We then load it back into our R session with `loadObject()`.
This creates a HDF5-backed S4 array that can be easily coerced into the desired format, e.g., a `dgCMatrix`.

```
roundtrip <- readObject(tmp)
class(roundtrip)
```

```
## [1] "ReloadedMatrix"
## attr(,"package")
## [1] "alabaster.matrix"
```

This process is supported for all base arrays, *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* objects and *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* objects.

# 3 Saving delayed operations

For `DelayedArray`s, we may instead choose to save the delayed operations themselves to file.
This creates a HDF5 file following the [**chihaya**](https://ltla.github.io/chihaya) format, containing the delayed operations rather than the results of their evaluation.

```
library(DelayedArray)
y <- DelayedArray(rsparsematrix(1000, 100, 0.05))
y <- log1p(abs(y) / 1:100) # adding some delayed ops.

tmp <- tempfile()
saveObject(y, tmp, DelayedArray.preserve.ops=TRUE)

# Inspecting the HDF5 file reveals many delayed operations:
rhdf5::h5ls(file.path(tmp, "array.h5"))
```

```
##                            group          name       otype  dclass   dim
## 0                              / delayed_array   H5I_GROUP
## 1                 /delayed_array        method H5I_DATASET  STRING ( 0 )
## 2                 /delayed_array          seed   H5I_GROUP
## 3            /delayed_array/seed         along H5I_DATASET INTEGER ( 0 )
## 4            /delayed_array/seed        method H5I_DATASET  STRING ( 0 )
## 5            /delayed_array/seed          seed   H5I_GROUP
## 6       /delayed_array/seed/seed        method H5I_DATASET  STRING ( 0 )
## 7       /delayed_array/seed/seed          seed   H5I_GROUP
## 8  /delayed_array/seed/seed/seed     by_column H5I_DATASET INTEGER ( 0 )
## 9  /delayed_array/seed/seed/seed          data H5I_DATASET   FLOAT  5000
## 10 /delayed_array/seed/seed/seed      dimnames   H5I_GROUP
## 11 /delayed_array/seed/seed/seed       indices H5I_DATASET INTEGER  5000
## 12 /delayed_array/seed/seed/seed        indptr H5I_DATASET INTEGER   101
## 13 /delayed_array/seed/seed/seed         shape H5I_DATASET INTEGER     2
## 14           /delayed_array/seed          side H5I_DATASET  STRING ( 0 )
## 15           /delayed_array/seed         value H5I_DATASET INTEGER  1000
```

```
# And indeed, we can recover those same operations.
readObject(tmp)
```

```
## <1000 x 100> sparse ReloadedMatrix object of type "double":
##           [,1]   [,2]   [,3] ...     [,99]    [,100]
##    [1,]      0      0      0   . 0.0000000 0.0000000
##    [2,]      0      0      0   . 0.4700036 0.0000000
##    [3,]      0      0      0   . 0.0000000 0.0000000
##    [4,]      0      0      0   . 0.0000000 0.0000000
##    [5,]      0      0      0   . 0.0000000 0.0000000
##     ...      .      .      .   .         .         .
##  [996,]      0      0      0   .         0         0
##  [997,]      0      0      0   .         0         0
##  [998,]      0      0      0   .         0         0
##  [999,]      0      0      0   .         0         0
## [1000,]      0      0      0   .         0         0
```

This allows users to avoid evaluation of the operations when saving objects,
which may improve efficiency, e.g., by avoiding loss of sparsity or casting to a larger type.

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
##  [1] DelayedArray_0.36.0     SparseArray_1.10.0      S4Arrays_1.10.0
##  [4] abind_1.4-8             IRanges_2.44.0          S4Vectors_0.48.0
##  [7] MatrixGenerics_1.22.0   matrixStats_1.5.0       BiocGenerics_0.56.0
## [10] generics_0.1.4          alabaster.matrix_1.10.0 alabaster.base_1.10.0
## [13] Matrix_1.7-4            BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] jsonlite_2.0.0           compiler_4.5.1           BiocManager_1.30.26
##  [4] Rcpp_1.1.0               rhdf5filters_1.22.0      jquerylib_0.1.4
##  [7] yaml_2.3.10              fastmap_1.2.0            lattice_0.22-7
## [10] R6_2.6.1                 XVector_0.50.0           knitr_1.50
## [13] bookdown_0.45            h5mread_1.2.0            bslib_0.9.0
## [16] rlang_1.1.6              cachem_1.1.0             HDF5Array_1.38.0
## [19] xfun_0.53                sass_0.4.10              cli_3.6.5
## [22] Rhdf5lib_1.32.0          digest_0.6.37            grid_4.5.1
## [25] alabaster.schemas_1.10.0 rhdf5_2.54.0             lifecycle_1.0.4
## [28] evaluate_1.0.5           rmarkdown_2.30           tools_4.5.1
## [31] htmltools_0.5.8.1
```