# Matrix representations to support decomposition

Aaron Lun1

1Cancer Research UK Cambridge Institute, Cambridge, United Kingdom

#### Revised: 26 May 2019

#### Package

BiocSingular 1.26.1

# 1 Overview

*[BiocSingular](https://bioconductor.org/packages/3.22/BiocSingular)* implements several useful `DelayedMatrix` backends for dealing with principal components analysis (PCA).
This vignette aims to provide an overview of these classes and how they can be used in other packages to improve efficiency prior to or after PCA.

# 2 The `DeferredMatrix` class

This has now been moved to its own *[ScaledMatrix](https://bioconductor.org/packages/3.22/ScaledMatrix)* package.
Check it out, it’s pretty cool.

# 3 The `LowRankMatrix` class

Once a PCA is performed, it is occasionally desirable to obtain a low-rank approximation of the input matrix by taking the cross-product of the rotation vectors and PC scores.
Naively doing so results in the formation of a dense matrix of the same dimensions as the input.
This may be prohibitively memory-consuming for a large data set.
Instead, we can construct a `LowRankMatrix` class that mimics the output of the cross-product without actually computing it.

```
library(Matrix)
a <- rsparsematrix(10000, 1000, density=0.01)
out <- runPCA(a, rank=5, BSPARAM=IrlbaParam(deferred=TRUE)) # deferring for speed.
recon <- LowRankMatrix(out$rotation, out$x)
recon
```

```
## <1000 x 10000> LowRankMatrix object of type "double":
##                  [,1]          [,2]          [,3] ...       [,9999]
##    [1,] -6.607941e-05 -3.309660e-03 -2.509974e-04   .  0.0006029616
##    [2,] -7.794603e-04 -1.556315e-03  4.616200e-04   .  0.0028565633
##    [3,] -5.427039e-04  9.868561e-04 -1.863603e-03   . -0.0031250885
##    [4,] -3.779873e-03 -8.401240e-05 -2.049993e-03   .  0.0028219708
##    [5,]  1.047063e-03  2.053309e-03  1.583250e-03   . -0.0010803753
##     ...             .             .             .   .             .
##  [996,]  4.693951e-03 -1.163595e-02  6.549077e-03   . -7.600833e-03
##  [997,]  2.929351e-04 -3.241344e-03  1.434765e-03   .  7.972958e-06
##  [998,] -2.177646e-03 -9.159261e-04 -1.859687e-03   . -1.206412e-04
##  [999,] -6.839735e-05  2.387144e-03  4.641709e-04   .  1.017343e-03
## [1000,]  2.363621e-03  7.373208e-04  5.527227e-04   . -5.160522e-03
##              [,10000]
##    [1,]  0.0049807597
##    [2,]  0.0003094826
##    [3,]  0.0045562989
##    [4,]  0.0026209457
##    [5,] -0.0034867483
##     ...             .
##  [996,]  9.029046e-03
##  [997,]  4.252964e-04
##  [998,]  5.170815e-03
##  [999,] -4.509402e-03
## [1000,]  4.960680e-04
```

This is useful for convenient extraction of row- or column vectors without needing to manually perform a cross-product.
A `LowRankMatrix` is thus directly interoperable with downstream procedures (e.g., for visualization) that expect a matrix of the same dimensionality as the input.

```
summary(recon[,1])
```

```
##       Min.    1st Qu.     Median       Mean    3rd Qu.       Max.
## -5.118e-02 -1.946e-03 -5.443e-05 -1.168e-04  1.766e-03  7.390e-02
```

```
summary(recon[2,])
```

```
##       Min.    1st Qu.     Median       Mean    3rd Qu.       Max.
## -3.090e-02 -1.191e-03 -5.502e-05  0.000e+00  1.110e-03  5.060e-02
```

Again, most operations will cause the `LowRankMatrix` to collapse gracefully into `DelayedMatrix` for further processing.

# 4 The `ResidualMatrix` class

This has now been moved to its own *[ResidualMatrix](https://bioconductor.org/packages/3.22/ResidualMatrix)* package.
Check it out, it’s pretty cool.

# 5 Session information

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] Matrix_1.7-4        BiocParallel_1.44.0 BiocSingular_1.26.1
## [4] knitr_1.50          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] jsonlite_2.0.0        compiler_4.5.2        BiocManager_1.30.27
##  [4] rsvd_1.0.5            Rcpp_1.1.0            parallel_4.5.2
##  [7] jquerylib_0.1.4       IRanges_2.44.0        yaml_2.3.10
## [10] fastmap_1.2.0         lattice_0.22-7        R6_2.6.1
## [13] XVector_0.50.0        S4Arrays_1.10.0       generics_0.1.4
## [16] ScaledMatrix_1.18.0   BiocGenerics_0.56.0   DelayedArray_0.36.0
## [19] bookdown_0.45         MatrixGenerics_1.22.0 bslib_0.9.0
## [22] rlang_1.1.6           cachem_1.1.0          xfun_0.54
## [25] sass_0.4.10           SparseArray_1.10.2    cli_3.6.5
## [28] digest_0.6.38         grid_4.5.2            irlba_2.3.5.1
## [31] lifecycle_1.0.4       S4Vectors_0.48.0      evaluate_1.0.5
## [34] codetools_0.2-20      beachmat_2.26.0       abind_1.4-8
## [37] stats4_4.5.2          rmarkdown_2.30        matrixStats_1.5.0
## [40] tools_4.5.2           htmltools_0.5.8.1
```