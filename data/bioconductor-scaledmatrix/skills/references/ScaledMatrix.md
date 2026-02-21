# Using the `ScaledMatrix` class

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: 12 December 2020

#### Package

ScaledMatrix 1.18.0

# 1 Overview

The `ScaledMatrix` provides yet another method of running `scale()` on a matrix.
In other words, these three operations are equivalent:

```
mat <- matrix(rnorm(10000), ncol=10)

smat1 <- scale(mat)
head(smat1)
```

```
##            [,1]        [,2]       [,3]       [,4]        [,5]       [,6]
## [1,] -0.7251220  0.72759388  0.3668116 -0.1542521  1.58708808 -0.2726665
## [2,] -0.3979559  1.45146704  0.2153044  0.3668748 -1.39408505 -1.3524080
## [3,]  1.4785756 -0.07980622 -2.3625184 -1.1910559 -0.03258645  0.1058521
## [4,] -0.5048398 -0.61096453  0.3409149  0.3015561  1.30315775  0.7816783
## [5,]  0.7961888 -2.30039779 -0.6781330  0.9851077  0.50213710 -0.5125673
## [6,] -1.3404375 -0.76069412 -0.1767665  1.4147528 -1.56838699 -1.9639587
##             [,7]        [,8]       [,9]      [,10]
## [1,] -0.02280075 -1.21200394 -1.5652425  0.3101434
## [2,]  1.03145382  1.46298933 -0.8846673 -0.9675083
## [3,]  0.04221679 -0.61790543 -0.1599154 -1.0517121
## [4,] -0.05428009  0.03478435 -0.2271617 -0.3375126
## [5,]  0.43037327  1.10591112 -0.7932041  0.3594490
## [6,]  0.53651810  0.01722595 -0.1027613  2.5609915
```

```
library(DelayedArray)
smat2 <- scale(DelayedArray(mat))
head(smat2)
```

```
## <6 x 10> DelayedMatrix object of type "double":
##             [,1]        [,2]        [,3] ...       [,9]      [,10]
## [1,] -0.72512198  0.72759388  0.36681162   . -1.5652425  0.3101434
## [2,] -0.39795586  1.45146704  0.21530441   . -0.8846673 -0.9675083
## [3,]  1.47857560 -0.07980622 -2.36251837   . -0.1599154 -1.0517121
## [4,] -0.50483978 -0.61096453  0.34091494   . -0.2271617 -0.3375126
## [5,]  0.79618883 -2.30039779 -0.67813296   . -0.7932041  0.3594490
## [6,] -1.34043751 -0.76069412 -0.17676648   . -0.1027613  2.5609915
```

```
library(ScaledMatrix)
smat3 <- ScaledMatrix(mat, center=TRUE, scale=TRUE)
head(smat3)
```

```
## <6 x 10> ScaledMatrix object of type "double":
##             [,1]        [,2]        [,3] ...       [,9]      [,10]
## [1,] -0.72512198  0.72759388  0.36681162   . -1.5652425  0.3101434
## [2,] -0.39795586  1.45146704  0.21530441   . -0.8846673 -0.9675083
## [3,]  1.47857560 -0.07980622 -2.36251837   . -0.1599154 -1.0517121
## [4,] -0.50483978 -0.61096453  0.34091494   . -0.2271617 -0.3375126
## [5,]  0.79618883 -2.30039779 -0.67813296   . -0.7932041  0.3594490
## [6,] -1.34043751 -0.76069412 -0.17676648   . -0.1027613  2.5609915
```

The biggest difference lies in how they behave in downstream matrix operations.

* `smat1` is an ordinary matrix, with the scaled and centered values fully realized in memory.
  Nothing too unusual here.
* `smat2` is a `DelayedMatrix` and undergoes block processing whereby chunks are realized and operated on, one at a time.
  This sacrifices speed for greater memory efficiency by avoiding a copy of the entire matrix.
  In particular, it preserves the structure of the original `mat`, e.g., from a sparse or file-backed representation.
* `smat3` is a `ScaledMatrix` that refactors certain operations so that they can be applied to the original `mat` without any scaling or centering.
  This takes advantage of the original data structure to speed up matrix multiplication and row/column sums,
  albeit at the cost of numerical precision.

# 2 Matrix multiplication

Given an original matrix \(\mathbf{X}\) with \(n\) columns, a vector of column centers \(\mathbf{c}\) and a vector of column scaling values \(\mathbf{s}\),
our scaled matrix can be written as:

\[
\mathbf{Y} = (\mathbf{X} - \mathbf{c} \cdot \mathbf{1}\_n^T) \mathbf{S}
\]

where \(\mathbf{S} = \text{diag}(s\_1^{-1}, ..., s\_n^{-1})\).
If we wanted to right-multiply it with another matrix \(\mathbf{A}\), we would have:

\[
\mathbf{YA} = \mathbf{X}\mathbf{S}\mathbf{A} - \mathbf{c} \cdot \mathbf{1}\_n^T \mathbf{S}\mathbf{A}
\]

The right-most expression is simply the outer product of \(\mathbf{c}\) with the column sums of \(\mathbf{SA}\).
More important is the fact that we can use the matrix multiplication operator for \(\mathbf{X}\) with \(\mathbf{SA}\),
as this allows us to use highly efficient algorithms for certain data representations, e.g., sparse matrices.

```
library(Matrix)
mat <- rsparsematrix(20000, 10000, density=0.01)
smat <- ScaledMatrix(mat, center=TRUE, scale=TRUE)

blob <- matrix(runif(ncol(mat) * 5), ncol=5)
system.time(out <- smat %*% blob)
```

```
##    user  system elapsed
##   0.049   0.002   0.080
```

```
# The slower way with block processing.
da <- scale(DelayedArray(mat))
system.time(out2 <- da %*% blob)
```

```
##    user  system elapsed
##  19.873   5.879  25.754
```

The same logic applies for left-multiplication and cross-products.
This allows us to easily speed up high-level operations involving matrix multiplication by just switching to a `ScaledMatrix`,
e.g., in approximate PCA algorithms from the *[BiocSingular](https://bioconductor.org/packages/3.22/BiocSingular)* package.

```
library(BiocSingular)
set.seed(1000)
system.time(pcs <- runSVD(smat, k=10, BSPARAM=IrlbaParam()))
```

```
##    user  system elapsed
##   6.558   0.188   6.746
```

# 3 Other utilities

Row and column sums are special cases of matrix multiplication and can be computed quickly:

```
system.time(rowSums(smat))
```

```
##    user  system elapsed
##   0.007   0.000   0.007
```

```
system.time(rowSums(da))
```

```
##    user  system elapsed
##  16.857   3.240  20.098
```

Subsetting, transposition and renaming of the dimensions are all supported without loss of the `ScaledMatrix` representation:

```
smat[,1:5]
```

```
## <20000 x 5> ScaledMatrix object of type "double":
##                   [,1]          [,2]          [,3]          [,4]          [,5]
##     [1,]   0.007159289  -0.001241387  -0.015310715   0.005649453   0.002605662
##     [2,]   0.007159289  -0.001241387  -0.015310715   0.005649453   0.002605662
##     [3,]   0.007159289  -0.001241387  -0.015310715   0.005649453   0.002605662
##     [4,]   0.007159289  -0.001241387  -0.015310715   0.005649453   0.002605662
##     [5,]   0.007159289  -0.001241387  -0.015310715   0.005649453   0.002605662
##      ...             .             .             .             .             .
## [19996,]   0.007159289  -0.001241387  -0.015310715   0.005649453   0.002605662
## [19997,]   0.007159289  -0.001241387  -0.015310715   0.005649453 -23.819877072
## [19998,]   0.007159289  -0.001241387  -0.015310715   0.005649453   0.002605662
## [19999,]   0.007159289  -0.001241387  -0.015310715   0.005649453   0.002605662
## [20000,]   0.007159289  -0.001241387  -0.015310715   0.005649453   0.002605662
```

```
t(smat)
```

```
## <10000 x 20000> ScaledMatrix object of type "double":
##                  [,1]         [,2]         [,3] ...     [,19999]     [,20000]
##     [1,]  0.007159289  0.007159289  0.007159289   .  0.007159289  0.007159289
##     [2,] -0.001241387 -0.001241387 -0.001241387   . -0.001241387 -0.001241387
##     [3,] -0.015310715 -0.015310715 -0.015310715   . -0.015310715 -0.015310715
##     [4,]  0.005649453  0.005649453  0.005649453   .  0.005649453  0.005649453
##     [5,]  0.002605662  0.002605662  0.002605662   .  0.002605662  0.002605662
##      ...            .            .            .   .            .            .
##  [9996,]  0.001502809  0.001502809  0.001502809   .  0.001502809  0.001502809
##  [9997,] -0.011580561 -0.011580561 -0.011580561   . -0.011580561 -0.011580561
##  [9998,] -0.014750696 -0.014750696 -0.014750696   . -0.014750696 -0.014750696
##  [9999,] -0.001369840 -0.001369840 -0.001369840   . -0.001369840 -0.001369840
## [10000,]  0.005792906  0.005792906  0.005792906   .  0.005792906  0.005792906
```

```
rownames(smat) <- paste0("GENE_", 1:20000)
smat
```

```
## <20000 x 10000> ScaledMatrix object of type "double":
##                    [,1]         [,2]         [,3] ...      [,9999]     [,10000]
##     GENE_1  0.007159289 -0.001241387 -0.015310715   . -0.001369840  0.005792906
##     GENE_2  0.007159289 -0.001241387 -0.015310715   . -0.001369840  0.005792906
##     GENE_3  0.007159289 -0.001241387 -0.015310715   . -0.001369840  0.005792906
##     GENE_4  0.007159289 -0.001241387 -0.015310715   . -0.001369840  0.005792906
##     GENE_5  0.007159289 -0.001241387 -0.015310715   . -0.001369840  0.005792906
##        ...            .            .            .   .            .            .
## GENE_19996  0.007159289 -0.001241387 -0.015310715   . -0.001369840  0.005792906
## GENE_19997  0.007159289 -0.001241387 -0.015310715   . -0.001369840  0.005792906
## GENE_19998  0.007159289 -0.001241387 -0.015310715   . -0.001369840  0.005792906
## GENE_19999  0.007159289 -0.001241387 -0.015310715   . -0.001369840  0.005792906
## GENE_20000  0.007159289 -0.001241387 -0.015310715   . -0.001369840  0.005792906
```

Other operations will cause the `ScaledMatrix` to collapse to the general `DelayedMatrix` representation, after which point block processing will be used.

```
smat + 1
```

```
## <20000 x 10000> DelayedMatrix object of type "double":
##                 [,1]      [,2]      [,3] ...   [,9999]  [,10000]
##     GENE_1 1.0071593 0.9987586 0.9846893   . 0.9986302 1.0057929
##     GENE_2 1.0071593 0.9987586 0.9846893   . 0.9986302 1.0057929
##     GENE_3 1.0071593 0.9987586 0.9846893   . 0.9986302 1.0057929
##     GENE_4 1.0071593 0.9987586 0.9846893   . 0.9986302 1.0057929
##     GENE_5 1.0071593 0.9987586 0.9846893   . 0.9986302 1.0057929
##        ...         .         .         .   .         .         .
## GENE_19996 1.0071593 0.9987586 0.9846893   . 0.9986302 1.0057929
## GENE_19997 1.0071593 0.9987586 0.9846893   . 0.9986302 1.0057929
## GENE_19998 1.0071593 0.9987586 0.9846893   . 0.9986302 1.0057929
## GENE_19999 1.0071593 0.9987586 0.9846893   . 0.9986302 1.0057929
## GENE_20000 1.0071593 0.9987586 0.9846893   . 0.9986302 1.0057929
```

# 4 Caveats

For most part, the implementation of the multiplication assumes that the \(\mathbf{A}\) matrix and the matrix product are small compared to \(\mathbf{X}\).
It is also possible to multiply two `ScaledMatrix`es together if the underlying matrices have efficient operators for their product.
However, if this is not the case, the `ScaledMatrix` offers little benefit for increased overhead.

It is also worth noting that this speed-up is not entirely free.
The expression above involves subtracting two matrix with potentially large values, which runs the risk of catastrophic cancellation.
The example below demonstrates how `ScaledMatrix` is more susceptible to loss of precision than a normal `DelayedArray`:

```
set.seed(1000)
mat <- matrix(rnorm(1000000), ncol=100000)
big.mat <- mat + 1e12

# The 'correct' value, unaffected by numerical precision.
ref <- rowMeans(scale(mat))
head(ref)
```

```
## [1] -0.0025584703 -0.0008570664 -0.0019225335 -0.0001039903  0.0024761772
## [6]  0.0032943203
```

```
# The value from scale'ing a DelayedArray.
library(DelayedArray)
smat2 <- scale(DelayedArray(big.mat))
head(rowMeans(smat2))
```

```
## [1] -0.0025583534 -0.0008571123 -0.0019226040 -0.0001039539  0.0024761618
## [6]  0.0032943783
```

```
# The value from a ScaledMatrix.
library(ScaledMatrix)
smat3 <- ScaledMatrix(big.mat, center=TRUE, scale=TRUE)
head(rowMeans(smat3))
```

```
## [1] -0.00480  0.00848  0.00544 -0.00976 -0.01056  0.01520
```

In most practical applications, though, this does not seem to be a major concern,
especially as most values (e.g., log-normalized expression matrices) lie close to zero anyway.

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
##  [1] BiocSingular_1.26.0   ScaledMatrix_1.18.0   DelayedArray_0.36.0
##  [4] SparseArray_1.10.0    S4Arrays_1.10.0       abind_1.4-8
##  [7] IRanges_2.44.0        S4Vectors_0.48.0      MatrixGenerics_1.22.0
## [10] matrixStats_1.5.0     BiocGenerics_0.56.0   generics_0.1.4
## [13] Matrix_1.7-4          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] jsonlite_2.0.0            compiler_4.5.1
##  [3] BiocManager_1.30.26       rsvd_1.0.5
##  [5] Rcpp_1.1.0                DelayedMatrixStats_1.32.0
##  [7] parallel_4.5.1            jquerylib_0.1.4
##  [9] BiocParallel_1.44.0       yaml_2.3.10
## [11] fastmap_1.2.0             lattice_0.22-7
## [13] R6_2.6.1                  XVector_0.50.0
## [15] knitr_1.50                bookdown_0.45
## [17] bslib_0.9.0               rlang_1.1.6
## [19] cachem_1.1.0              xfun_0.53
## [21] sass_0.4.10               cli_3.6.5
## [23] digest_0.6.37             grid_4.5.1
## [25] irlba_2.3.5.1             sparseMatrixStats_1.22.0
## [27] lifecycle_1.0.4           evaluate_1.0.5
## [29] codetools_0.2-20          beachmat_2.26.0
## [31] rmarkdown_2.30            tools_4.5.1
## [33] htmltools_0.5.8.1
```