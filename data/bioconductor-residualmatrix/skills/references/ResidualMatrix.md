# Using the `ResidualMatrix` class

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: 30 August 2020

#### Package

ResidualMatrix 1.20.0

# 1 Overview

A common step in genomics involves computing residuals to regress out uninteresting factors of variation.
However, doing so naively would discard aspects of the underlying matrix representation.
The most obvious example is the loss of sparsity when a dense matrix of residuals is computed,
increasing memory usage and compute time in downstream applications.
The *[ResidualMatrix](https://bioconductor.org/packages/3.22/ResidualMatrix)* package implements the `ResidualMatrix` class (duh),
which provides an efficient alternative to explicit calculation of the residuals.
Users can install this package by following the usual Bioconductor installation process:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("ResidualMatrix")
```

# 2 Using the `ResidualMatrix`

The constructor takes a matrix of input values and a design matrix,
where residuals are conceptually computed by fitting the linear model to the columns of the input matrix.
However, the actual calculation of the residuals is delayed until they are explictly required.

```
design <- model.matrix(~gl(5, 10000))

# Making up a large-ish sparse matrix.
library(Matrix)
set.seed(100)
y0 <- rsparsematrix(nrow(design), 30000, 0.01)

library(ResidualMatrix)
resids <- ResidualMatrix(y0, design)
resids
```

```
## <50000 x 30000> ResidualMatrix object of type "double":
##                  [,1]         [,2]         [,3] ...   [,29999]   [,30000]
##     [1,]  -0.00176859  -0.00061002  -0.00145170   .  0.0014689 -0.0001879
##     [2,]  -0.00176859  -0.00061002  -0.00145170   .  0.0014689 -0.0001879
##     [3,]  -0.00176859  -0.00061002  -0.00145170   .  0.0014689 -0.0001879
##     [4,]  -0.00176859  -0.00061002  -0.00145170   .  0.0014689 -0.0001879
##     [5,]  -0.00176859  -0.00061002  -0.00145170   .  0.0014689 -0.0001879
##      ...            .            .            .   .          .          .
## [49996,] -0.000179354  0.000624710  0.001578000   . -5.773e-04  6.741e-05
## [49997,] -0.000179354  0.000624710  0.001578000   . -5.773e-04  6.741e-05
## [49998,] -0.000179354  0.000624710  0.001578000   . -5.773e-04  6.741e-05
## [49999,] -0.000179354  0.000624710  0.001578000   . -5.773e-04  6.741e-05
## [50000,] -0.000179354  0.000624710  0.001578000   . -5.773e-04  6.741e-05
```

It is simple to obtain the residuals for, say, a single column.
We could also use the *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* block processing machinery to do this for chunks of columns at a time,
allowing downstream code to compute on the residuals within memory limits.

```
hist(resids[,1])
```

![](data:image/png;base64...)

In fact, matrix multiplication steps involving a `ResidualMatrix` do not need to compute the residuals at all.
This means that `ResidualMatrix` objects can be efficiently used in approximate PCA algorithms based on multiplication,
as shown below for randomized SVD via *[BiocSingular](https://bioconductor.org/packages/3.22/BiocSingular)*’s `runPCA()` function.
The only requirement is that the original matrix has a reasonably efficient matrix multiplication operator.
(We set `center=FALSE` for efficiency as the residuals are already column-centered.)

```
set.seed(100)
system.time(pc.out <- BiocSingular::runPCA(resids, 10, center=FALSE,
    BSPARAM=BiocSingular::RandomParam()))
```

```
##    user  system elapsed
##   5.580   0.226   5.806
```

```
str(pc.out)
```

```
## List of 3
##  $ sdev    : num [1:10] 0.16 0.159 0.159 0.159 0.159 ...
##  $ rotation: num [1:30000, 1:10] 0.001048 -0.010312 -0.000749 0.000831 -0.003602 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:10] "PC1" "PC2" "PC3" "PC4" ...
##  $ x       : num [1:50000, 1:10] -0.0172 -0.1613 0.0576 -0.1764 -0.0826 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:10] "PC1" "PC2" "PC3" "PC4" ...
```

Similarly, the row and column sums/means can be computed efficiently,
based on the matrix multiplication machinery and the original matrix’s row and column sum functions.

```
hist(rowSums(resids))
```

![](data:image/png;base64...)

Other operations will cause the `ResidualMatrix` to collapse into `DelayedMatrix` for further processing.

# 3 Retaining certain factors

We can also specify that we only want to regress out some factors in our `design`.
For example, let’s say we have a dataset with an interesting two-group structure and an uninteresting continuous covariate `BAD`:

```
design2 <- model.matrix(~gl(2, 10000))
design2 <- cbind(design2, BAD=runif(nrow(design2)))
colnames(design2)
```

```
## [1] "(Intercept)"   "gl(2, 10000)2" "BAD"
```

We can instruct `ResidualMatrix()` to retain the interesting structure (first two coefficients)
while regressing out the uninteresting covariate in the third coefficient:

```
# Making up another large-ish sparse matrix.
y0 <- rsparsematrix(nrow(design2), 30000, 0.01)

resid2 <- ResidualMatrix(y0, design2, keep=1:2)
resid2
```

```
## <20000 x 30000> ResidualMatrix object of type "double":
##                   [,1]          [,2]          [,3] ...      [,29999]
##     [1,]  0.0003610968 -0.0005362812 -0.0006870567   . -4.423137e-04
##     [2,]  0.0006099956 -0.0009059321 -0.0011606349   . -7.471941e-04
##     [3,]  0.0013597619 -0.0020194441 -0.0025872107   . -1.665596e-03
##     [4,]  0.0013671407 -0.0020304026 -0.0026012502   . -1.674634e-03
##     [5,]  0.0009095187 -0.0013507675 -0.0017305357   . -1.114085e-03
##      ...             .             .             .   .             .
## [19996,]  0.0009696272 -0.0014400373 -0.0018449037   . -0.0011877129
## [19997,]  0.0009091618 -0.0013502374 -0.0017298566   . -0.0011136479
## [19998,]  0.0009893631 -0.0014693480 -0.0018824551   . -0.0012118878
## [19999,]  0.0018900069 -0.0028069349 -0.0035961045   . -0.0023151018
## [20000,]  0.0014685486 -0.0021810081 -0.0027941984   . -0.0017988503
##               [,30000]
##     [1,]  6.401415e-05
##     [2,]  1.081382e-04
##     [3,]  2.410545e-04
##     [4,]  2.423626e-04
##     [5,]  1.612367e-04
##      ...             .
## [19996,]  0.0001718926
## [19997,]  0.0001611735
## [19998,]  0.0001753913
## [19999,]  0.0003350547
## [20000,]  0.0002603399
```

In this sense, the `ResidualMatrix` is effectively a delayed version of `removeBatchEffect()`,
the old workhorse function from *[limma](https://bioconductor.org/packages/3.22/limma)*.

# 4 Restricting observations

In some cases, we may only be confident in the correctness of `design` for a subset of our samples.
For example, we may have several batches of observations, each of which contains a subset of control observations.
All other observations in each batch have unknown structure but are affected by the same additive batch effect as the controls.
We would like to use the controls to remove the batch effect without making assumptions about the other observations.

To achieve this, we set the `restrict=` argument in the `ResidualMatrix` constructor.
This performs model fitting using only the specified (control) subset to estimate the batch effect.
It then uses those estimates to perform regression on all observations.
This option can also be combined with `keep` if the controls themselves have some structure that should be retained.

```
batches <- gl(3, 1000)
controls <- c(1:100, 1:100+1000, 1:100+2000)
y <- matrix(rnorm(30000), nrow=3000)

resid3 <- ResidualMatrix(y, design=model.matrix(~batches), restrict=controls)
resid3
```

```
## <3000 x 10> ResidualMatrix object of type "double":
##                [,1]        [,2]        [,3] ...        [,9]       [,10]
##    [1,]  0.19825824  0.17996457  1.13936050   .  0.33228412 -1.64454139
##    [2,] -0.28219580 -1.15656947  0.25430702   . -0.08018124  0.87146688
##    [3,] -2.21640973  0.26290101 -0.87678574   . -0.64221058 -0.09514042
##    [4,] -0.08887064  0.14095095  0.98438377   . -1.05511992  1.02235182
##    [5,] -0.99462216  0.63980424 -0.35985208   .  0.33789575 -0.68093555
##     ...           .           .           .   .           .           .
## [2996,]  -0.3511486  -2.2495602   0.3509155   .  0.59967323 -1.07031924
## [2997,]  -0.4235921   2.0300343   1.4830692   . -0.09382277 -3.42017897
## [2998,]   1.0993104   0.4044992  -2.6605940   .  1.14067257 -1.33360979
## [2999,]  -0.1802699  -1.7624554  -0.1289637   . -1.71318104 -1.96317436
## [3000,]  -0.3151365   0.1005264   0.3068870   .  1.49625115  0.39279434
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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ResidualMatrix_1.20.0 Matrix_1.7-4          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] jsonlite_2.0.0        compiler_4.5.1        BiocManager_1.30.26
##  [4] rsvd_1.0.5            Rcpp_1.1.0            tinytex_0.57
##  [7] magick_2.9.0          parallel_4.5.1        jquerylib_0.1.4
## [10] IRanges_2.44.0        BiocParallel_1.44.0   yaml_2.3.10
## [13] fastmap_1.2.0         lattice_0.22-7        R6_2.6.1
## [16] XVector_0.50.0        S4Arrays_1.10.0       generics_0.1.4
## [19] ScaledMatrix_1.18.0   knitr_1.50            BiocGenerics_0.56.0
## [22] DelayedArray_0.36.0   bookdown_0.45         MatrixGenerics_1.22.0
## [25] bslib_0.9.0           rlang_1.1.6           cachem_1.1.0
## [28] xfun_0.53             sass_0.4.10           SparseArray_1.10.0
## [31] cli_3.6.5             magrittr_2.0.4        BiocSingular_1.26.0
## [34] digest_0.6.37         grid_4.5.1            irlba_2.3.5.1
## [37] lifecycle_1.0.4       S4Vectors_0.48.0      evaluate_1.0.5
## [40] codetools_0.2-20      beachmat_2.26.0       abind_1.4-8
## [43] stats4_4.5.1          rmarkdown_2.30        matrixStats_1.5.0
## [46] tools_4.5.1           htmltools_0.5.8.1
```