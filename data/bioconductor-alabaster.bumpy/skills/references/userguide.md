# Saving BumpyMatrices to file

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: January 1, 2024

#### Package

alabaster.bumpy 1.10.0

# Contents

* [1 Overview](#overview)
* [2 Saving a `BumpyMatrix`](#saving-a-bumpymatrix)
* [3 Loading a `BumpyMatrix`](#loading-a-bumpymatrix)
* [Session info](#session-info)

# 1 Overview

The `BumpyMatrix` class provides a representation of complex ragged data structures - see the *[BumpyMatrix](https://bioconductor.org/packages/3.22/BumpyMatrix)* package for more information.
This is used to coerce immune repertoire, spatial transcriptomics and drug response data into a familiar 2D array for easy manipulation.
The *[alabaster.bumpy](https://github.com/ArtifactDB/alabaster.bumpy)* package allows users to save a `BumpyMatrix` to file within the [**alabaster** framework](https://github.com/ArtifactDB/alabaster.base).

# 2 Saving a `BumpyMatrix`

Let’s make a `BumpyMatrix` to demonstrate:

```
library(BumpyMatrix)
library(S4Vectors)
df <- DataFrame(x=runif(100), y=runif(100))
f <- factor(sample(letters[1:20], nrow(df), replace=TRUE), letters[1:20])
mat <- BumpyMatrix(split(df, f), c(5, 4))
```

Saving it to file involves calling `saveObject`:

```
library(alabaster.bumpy)
tmp <- tempfile()
saveObject(mat, tmp)
list.files(tmp, recursive=TRUE)
```

```
## [1] "OBJECT"                        "_environment.json"
## [3] "concatenated/OBJECT"           "concatenated/basic_columns.h5"
## [5] "partitions.h5"
```

# 3 Loading a `BumpyMatrix`

The loading procedure is even simpler as the metadata of the saved `BumpyMatrix` remembers how it was saved.
We can just use `alabaster.base::readObject()` or related functions, and the R interface will automatically do the rest.

```
readObject(tmp)
```

```
## 5 x 4 BumpyDataFrameMatrix
## rownames: NULL
## colnames: NULL
## preview [1,1]:
##   DataFrame with 10 rows and 2 columns
##              x         y
##      <numeric> <numeric>
##   1  0.9502241  0.838870
##   2  0.4375776  0.933197
##   3  0.6178964  0.728964
##   4  0.0379372  0.942614
##   5  0.0419248  0.740767
##   6  0.6475286  0.472497
##   7  0.6683326  0.106972
##   8  0.2927920  0.939912
##   9  0.6588346  0.653017
##   10 0.1122884  0.492108
```

# Session info

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
## [1] alabaster.bumpy_1.10.0 alabaster.base_1.10.0  S4Vectors_0.48.0
## [4] BiocGenerics_0.56.0    generics_0.1.4         BumpyMatrix_1.18.0
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5                knitr_1.50               rlang_1.1.6
##  [4] xfun_0.53                jsonlite_2.0.0           htmltools_0.5.8.1
##  [7] sass_0.4.10              rmarkdown_2.30           grid_4.5.1
## [10] evaluate_1.0.5           jquerylib_0.1.4          fastmap_1.2.0
## [13] Rhdf5lib_1.32.0          alabaster.schemas_1.10.0 yaml_2.3.10
## [16] IRanges_2.44.0           lifecycle_1.0.4          bookdown_0.45
## [19] BiocManager_1.30.26      compiler_4.5.1           Rcpp_1.1.0
## [22] rhdf5filters_1.22.0      rhdf5_2.54.0             lattice_0.22-7
## [25] digest_0.6.37            R6_2.6.1                 bslib_0.9.0
## [28] Matrix_1.7-4             tools_4.5.1              cachem_1.1.0
```