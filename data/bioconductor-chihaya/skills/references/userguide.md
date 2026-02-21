# Saving and reloading DelayedArray objects

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: 2021-05-02

#### Package

chihaya 1.10.0

# Contents

* [1 Motivation](#motivation)
* [2 Quick start](#quick-start)
* [3 More interesting seeds](#more-interesting-seeds)
* [Session information](#session-information)

# 1 Motivation

The *[chihaya](https://bioconductor.org/packages/3.22/chihaya)* package saves `DelayedArray` objects for efficient, portable and stable reproduction of delayed operations in a new R session or other programming frameworks.

* **Portability**.
  We provide a file specification in a standard format (HDF5) that enables other languages to easily interpret and reproduce the delayed operations.
* **Stability**.
  By converting *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* operations into our specification, we provide a layer of protection against changes in the S4 class structure that would invalidate serialized RDS objects.
* **Efficiency**.
  We avoid any realization of the delayed operations, enabling quick saving and avoiding loss of data structure in the seed (e.g., sparsity).

Check out the [specification](https://artifactdb.github.io/chihaya/) for more details.

# 2 Quick start

Make a `DelayedArray` object with some operations:

```
library(DelayedArray)
x <- DelayedArray(matrix(runif(1000), ncol=10))
x <- x[11:15,] / runif(5)
x <- log2(x + 1)
x
```

```
## <5 x 10> DelayedMatrix object of type "double":
##           [,1]      [,2]      [,3] ...      [,9]     [,10]
## [1,] 1.1899686 1.5698827 0.8275821   . 1.2824674 0.9683646
## [2,] 1.0037850 0.5142570 0.8555715   . 0.6095258 0.2094640
## [3,] 1.3526268 0.8644846 1.2478741   . 1.1056674 1.0217450
## [4,] 3.0969519 2.5377715 3.2643459   . 3.2784429 3.0626132
## [5,] 0.6662444 0.3274014 0.7252926   . 0.8326257 0.7793437
```

```
showtree(x)
```

```
## 5x10 double: DelayedMatrix object
## └─ 5x10 double: Stack of 2 unary iso op(s)
##    └─ 5x10 double: Unary iso op with args
##       └─ 5x10 double: Subset
##          └─ 100x10 double: [seed] matrix object
```

Save it into a HDF5 file with `saveDelayed()`:

```
library(chihaya)
tmp <- tempfile(fileext=".h5")
saveDelayed(x, tmp)
rhdf5::h5ls(tmp)
```

```
##                            group    name       otype  dclass      dim
## 0                              / delayed   H5I_GROUP
## 1                       /delayed    base H5I_DATASET   FLOAT    ( 0 )
## 2                       /delayed  method H5I_DATASET  STRING    ( 0 )
## 3                       /delayed    seed   H5I_GROUP
## 4                  /delayed/seed  method H5I_DATASET  STRING    ( 0 )
## 5                  /delayed/seed    seed   H5I_GROUP
## 6             /delayed/seed/seed   along H5I_DATASET INTEGER    ( 0 )
## 7             /delayed/seed/seed  method H5I_DATASET  STRING    ( 0 )
## 8             /delayed/seed/seed    seed   H5I_GROUP
## 9        /delayed/seed/seed/seed   index   H5I_GROUP
## 10 /delayed/seed/seed/seed/index       0 H5I_DATASET INTEGER        5
## 11       /delayed/seed/seed/seed    seed   H5I_GROUP
## 12  /delayed/seed/seed/seed/seed    data H5I_DATASET   FLOAT 100 x 10
## 13  /delayed/seed/seed/seed/seed  native H5I_DATASET INTEGER    ( 0 )
## 14            /delayed/seed/seed    side H5I_DATASET  STRING    ( 0 )
## 15            /delayed/seed/seed   value H5I_DATASET   FLOAT        5
## 16                 /delayed/seed    side H5I_DATASET  STRING    ( 0 )
## 17                 /delayed/seed   value H5I_DATASET   FLOAT    ( 0 )
```

And then load it back in later:

```
y <- loadDelayed(tmp)
y
```

```
## <5 x 10> DelayedMatrix object of type "double":
##           [,1]      [,2]      [,3] ...      [,9]     [,10]
## [1,] 1.1899686 1.5698827 0.8275821   . 1.2824674 0.9683646
## [2,] 1.0037850 0.5142570 0.8555715   . 0.6095258 0.2094640
## [3,] 1.3526268 0.8644846 1.2478741   . 1.1056674 1.0217450
## [4,] 3.0969519 2.5377715 3.2643459   . 3.2784429 3.0626132
## [5,] 0.6662444 0.3274014 0.7252926   . 0.8326257 0.7793437
```

Of course, this is not a particularly interesting case as we end up saving the original array inside our HDF5 file anyway.
The real fun begins when you have some more interesting seeds.

# 3 More interesting seeds

We can use the delayed nature of the operations to avoid breaking sparsity.
For example:

```
library(Matrix)
x <- rsparsematrix(1000, 1000, density=0.01)
x <- DelayedArray(x) + runif(1000)

tmp <- tempfile(fileext=".h5")
saveDelayed(x, tmp)
rhdf5::h5ls(tmp)
```

```
##            group     name       otype  dclass   dim
## 0              /  delayed   H5I_GROUP
## 1       /delayed    along H5I_DATASET INTEGER ( 0 )
## 2       /delayed   method H5I_DATASET  STRING ( 0 )
## 3       /delayed     seed   H5I_GROUP
## 4  /delayed/seed     data H5I_DATASET   FLOAT 10000
## 5  /delayed/seed dimnames   H5I_GROUP
## 6  /delayed/seed  indices H5I_DATASET INTEGER 10000
## 7  /delayed/seed   indptr H5I_DATASET INTEGER  1001
## 8  /delayed/seed    shape H5I_DATASET INTEGER     2
## 9       /delayed     side H5I_DATASET  STRING ( 0 )
## 10      /delayed    value H5I_DATASET   FLOAT  1000
```

```
file.info(tmp)[["size"]]
```

```
## [1] 102103
```

```
# Compared to a dense array.
tmp2 <- tempfile(fileext=".h5")
out <- HDF5Array::writeHDF5Array(x, tmp2, "data")
file.info(tmp2)[["size"]]
```

```
## [1] 280288
```

```
# Loading it back in.
y <- loadDelayed(tmp)
showtree(y)
```

```
## 1000x1000 double: DelayedMatrix object
## └─ 1000x1000 double: Unary iso op with args
##    └─ 1000x1000 double, sparse: [seed] dgCMatrix object
```

We can also store references to external files, thus avoiding data duplication:

```
library(HDF5Array)
test <- HDF5Array(tmp2, "data")
stuff <- log2(test + 1)
stuff
```

```
## <1000 x 1000> DelayedMatrix object of type "double":
##               [,1]       [,2]       [,3] ...     [,999]    [,1000]
##    [1,] 0.56951851 0.56951851 0.56951851   . 0.56951851 0.56951851
##    [2,] 0.76883903 0.76883903 0.76883903   . 0.76883903 0.76883903
##    [3,] 0.63612146 0.63612146 0.63612146   . 0.63612146 0.63612146
##    [4,] 0.05424798 0.05424798 0.05424798   . 0.05424798 0.05424798
##    [5,] 0.01297024 0.01297024 0.01297024   . 0.01297024 0.01297024
##     ...          .          .          .   .          .          .
##  [996,]  0.8678783  0.8678783  0.8678783   .  0.8678783  0.8678783
##  [997,]  0.3228298  0.3228298  0.3228298   .  0.3228298  0.3228298
##  [998,]  0.0455498  0.0455498  0.0455498   .  0.0455498  0.0455498
##  [999,]  0.7663056  0.7663056  0.7663056   .  0.7663056  0.7663056
## [1000,]  0.3255779  0.3255779  0.3255779   .  0.3255779  0.3255779
```

```
tmp <- tempfile(fileext=".h5")
saveDelayed(stuff, tmp)
rhdf5::h5ls(tmp)
```

```
##                 group       name       otype  dclass   dim
## 0                   /    delayed   H5I_GROUP
## 1            /delayed       base H5I_DATASET   FLOAT ( 0 )
## 2            /delayed     method H5I_DATASET  STRING ( 0 )
## 3            /delayed       seed   H5I_GROUP
## 4       /delayed/seed     method H5I_DATASET  STRING ( 0 )
## 5       /delayed/seed       seed   H5I_GROUP
## 6  /delayed/seed/seed dimensions H5I_DATASET INTEGER     2
## 7  /delayed/seed/seed       file H5I_DATASET  STRING ( 0 )
## 8  /delayed/seed/seed       name H5I_DATASET  STRING ( 0 )
## 9  /delayed/seed/seed     sparse H5I_DATASET INTEGER ( 0 )
## 10 /delayed/seed/seed       type H5I_DATASET  STRING ( 0 )
## 11      /delayed/seed       side H5I_DATASET  STRING ( 0 )
## 12      /delayed/seed      value H5I_DATASET   FLOAT ( 0 )
```

```
file.info(tmp)[["size"]] # size of the delayed operations + pointer to the actual file
```

```
## [1] 49642
```

```
y <- loadDelayed(tmp)
y
```

```
## <1000 x 1000> DelayedMatrix object of type "double":
##               [,1]       [,2]       [,3] ...     [,999]    [,1000]
##    [1,] 0.56951851 0.56951851 0.56951851   . 0.56951851 0.56951851
##    [2,] 0.76883903 0.76883903 0.76883903   . 0.76883903 0.76883903
##    [3,] 0.63612146 0.63612146 0.63612146   . 0.63612146 0.63612146
##    [4,] 0.05424798 0.05424798 0.05424798   . 0.05424798 0.05424798
##    [5,] 0.01297024 0.01297024 0.01297024   . 0.01297024 0.01297024
##     ...          .          .          .   .          .          .
##  [996,]  0.8678783  0.8678783  0.8678783   .  0.8678783  0.8678783
##  [997,]  0.3228298  0.3228298  0.3228298   .  0.3228298  0.3228298
##  [998,]  0.0455498  0.0455498  0.0455498   .  0.0455498  0.0455498
##  [999,]  0.7663056  0.7663056  0.7663056   .  0.7663056  0.7663056
## [1000,]  0.3255779  0.3255779  0.3255779   .  0.3255779  0.3255779
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
##  [1] HDF5Array_1.38.0      h5mread_1.2.0         rhdf5_2.54.0
##  [4] chihaya_1.10.0        DelayedArray_0.36.0   SparseArray_1.10.0
##  [7] S4Arrays_1.10.0       abind_1.4-8           IRanges_2.44.0
## [10] S4Vectors_0.48.0      MatrixGenerics_1.22.0 matrixStats_1.5.0
## [13] BiocGenerics_0.56.0   generics_0.1.4        Matrix_1.7-4
## [16] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] xfun_0.53           jsonlite_2.0.0      htmltools_0.5.8.1
##  [7] sass_0.4.10         rmarkdown_2.30      grid_4.5.1
## [10] evaluate_1.0.5      jquerylib_0.1.4     fastmap_1.2.0
## [13] Rhdf5lib_1.32.0     yaml_2.3.10         lifecycle_1.0.4
## [16] bookdown_0.45       BiocManager_1.30.26 compiler_4.5.1
## [19] Rcpp_1.1.0          rhdf5filters_1.22.0 XVector_0.50.0
## [22] lattice_0.22-7      digest_0.6.37       R6_2.6.1
## [25] bslib_0.9.0         tools_4.5.1         cachem_1.1.0
```