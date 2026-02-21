# Singular value decomposition for Bioconductor packages

Aaron Lun1

1Cancer Research UK Cambridge Institute, Cambridge, United Kingdom

#### Revised: 9 February 2019

#### Package

BiocSingular 1.26.1

# 1 Overview

The singular value decomposition (SVD) is an important procedure in general data analysis, primarily due to its use in the principal components analysis (PCA).
The *[BiocSingular](https://bioconductor.org/packages/3.22/BiocSingular)* package provides methods to perform both exact and approximate SVD with a single wrapper function.
Our aim is to provide a standard framework for use in other Bioconductor packages, where users can easily switch between different SVD algorithms.
We also support parallelization throughout various parts of the SVD calculations via the *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)* framework.

# SVD algorithm choices

To perform any SVD, we call the `runSVD()` function.
The code below performs an exact SVD to obtain the first `k` singular vectors and values (in this case, 10):

```
dummy <- matrix(rnorm(10000), ncol=25)
e.out <- runSVD(dummy, k=10, BSPARAM=ExactParam())
str(e.out)
```

```
## List of 3
##  $ d: num [1:10] 24.4 23.9 23.1 22.9 22.5 ...
##  $ u: num [1:400, 1:10] -0.09372 -0.02707 0.00729 -0.00641 0.01066 ...
##  $ v: num [1:25, 1:10] 0.065061 0.465998 -0.338473 -0.029838 -0.000806 ...
```

… but we can change the algorithm by specifying a different `BiocSingularParam` class to the `BSPARAM=` argument.
For example, we could use an approximate approach with *[irlba](https://CRAN.R-project.org/package%3Dirlba)* instead:

```
set.seed(1000)
i.out <- runSVD(dummy, k=10, BSPARAM=IrlbaParam())
```

… or we could use a randomized SVD via *[rsvd](https://CRAN.R-project.org/package%3Drsvd)*:

```
set.seed(1000)
r.out <- runSVD(dummy, k=10, BSPARAM=RandomParam())
```

By default, the exact algorithm is used when `BSPARAM=NULL`.
The other algorithms are approximate but are much faster than the exact SVD for low `k`.
They also involve randomization, so note the use of a random seed.

# 2 Taking the cross-product

For tall or fat matrices, it may be faster to perform the SVD on the cross-product rather than on the matrix itself.
The cross-product is usually much smaller than the original matrix and can be decomposed rapidly, with time savings offsettting the cost of the cross-product in the first place.
The results of the cross-product decomposition is used to obtain the decomposition results for the original matrix.

The definition of “tall” or “fat” is based on the fold difference in dimensions.
All `BiocSingularParam` objects have a `fold` slot that specifies the minimum fold difference between dimensions for a cross-product to be computed.
This provides an automated mechanism for deciding whether or not a cross-product should be used.

```
epam <- ExactParam(fold=10)
epam
```

```
## class: ExactParam
## cross-product fold-threshold: 10.00
## deferred centering/scaling: off
```

```
cr.out <- runSVD(dummy, k=10, BSPARAM=epam)
```

Setting `fold=1` will compute the cross-product for all matrices, even for square matrices where the gains are negligible.
Setting `fold=Inf` will never compute the cross-product for any matrix.
The default is to use `fold=5`.

# 3 Centering and/or scaling

Centering and scaling of the input matrix can be performed with the `center=` and `scale=` arguments, respectively.
These should be numeric vectors of length equal to the number of rows of the input matrix.
The SVD will then be effectively performed on `t(t(dummy)-center)/scale)`.

```
cs.out <- runSVD(dummy, k=10, scale=runif(ncol(dummy)),
    center=rnorm(ncol(dummy)))
```

Many of the approximate algorithms (and computation of the cross-product) involve matrix multiplications.
By default, any centering and scaling is applied before any multiplication.
However, it is possible to “defer” the centering and scaling such that the multiplication can make use of features of the underlying matrix representation (e.g., sparsity).
This enables faster calculations at the expense of numerical stability.

```
set.seed(2000)
def.out <- runSVD(dummy, k=10, scale=runif(ncol(dummy)),
    center=rnorm(ncol(dummy)), BSPARAM=IrlbaParam(deferred=TRUE))
```

# 4 Other SVD-related options

Each individual algorithm has its own parameters that may need tuning.
These can be set in the constructors for the relevant `BiocSingularParam` objects:

```
ipam <- IrlbaParam(tol=1e-8, extra.work=10)
ipam
```

```
## class: IrlbaParam
## cross-product fold-threshold: Inf
## deferred centering/scaling: off
## extra workspace: 10
## additional arguments(1): tol
```

… which will be used in the `irlba()` function when `runSVD()` is called:

```
set.seed(3000)
i.out <- runSVD(dummy, k=10, BSPARAM=ipam)
```

Internal matrix multiplications can be parallelized by setting the `BPPARAM=` argument.
This can speed up calculations when dealing with very large input matrices, e.g., from the *[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)* package.

```
set.seed(4000)
library(BiocParallel)
i.out <- runSVD(dummy, k=10, BSPARAM=ipam, BPPARAM=bpparam())
```

The number of left or right singular vectors to return can be directly controlled with the `nv=` and `nu=` arguments.
This can avoid wasting time in computing these vectors when they are not required.

# 5 Running the PCA

The main practical purpose of the SVD is to perform PCAs.
This is achieved with the `runPCA()` wrapper function, which also accepts a `BSPARAM=` argument specifying the type of algorithm to use:

```
pcs.out <- runPCA(dummy, rank=10, BSPARAM=ExactParam())
str(pcs.out)
```

```
## List of 3
##  $ sdev    : num [1:10] 1.22 1.2 1.15 1.15 1.12 ...
##  $ rotation: num [1:25, 1:10] 0.065141 0.465864 -0.33853 -0.029862 -0.000804 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:10] "PC1" "PC2" "PC3" "PC4" ...
##  $ x       : num [1:400, 1:10] -2.288 -0.662 0.176 -0.157 0.26 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:10] "PC1" "PC2" "PC3" "PC4" ...
```

The output is equivalent to that of `prcomp()` - a matrix of principal component scores, the rotation vectors, and the standard deviation explained by each component.

```
head(pcs.out$x)
```

```
##              PC1          PC2        PC3         PC4        PC5        PC6
## [1,] -2.28836543 -0.005088504 -0.1215437 -1.14325491  2.4615798  0.3795913
## [2,] -0.66231190 -0.593552869  0.8889813  0.08355081 -1.6417589 -0.5222694
## [3,]  0.17610681 -0.581214302 -1.3314832  0.40977421 -1.4605159  0.4954922
## [4,] -0.15681334 -0.783137887  0.6542274 -0.11570220  0.8610293  0.3942107
## [5,]  0.25961665  0.174974164  1.2359999  0.74731536 -0.5603019 -0.9505845
## [6,]  0.05301977  0.539412924  0.4282860  0.79711774 -1.3153335  0.1527365
##             PC7        PC8         PC9        PC10
## [1,] -1.3398241  1.2252040 -0.43533736 -1.08645020
## [2,] -0.2877867 -0.3340612  0.09030705  0.26171719
## [3,] -1.4815112 -0.1693165  3.53207643 -0.52140348
## [4,]  1.3050660  0.2166619 -0.20253499 -0.70411648
## [5,]  0.4708046  0.1893536 -1.42183396 -0.00935545
## [6,] -2.6508875 -0.9834861  0.04690857 -0.29286364
```

Column centering is performed by default with `center=TRUE`.
Standardization of each column can be enabled with `scale=TRUE`.
Alternatively, numeric vectors can be passed to either argument for subtraction from and scaling of each column.

# 6 Session information

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
## [1] BiocParallel_1.44.0 BiocSingular_1.26.1 knitr_1.50
## [4] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4          jsonlite_2.0.0        compiler_4.5.2
##  [4] BiocManager_1.30.27   rsvd_1.0.5            Rcpp_1.1.0
##  [7] parallel_4.5.2        jquerylib_0.1.4       IRanges_2.44.0
## [10] yaml_2.3.10           fastmap_1.2.0         lattice_0.22-7
## [13] R6_2.6.1              XVector_0.50.0        S4Arrays_1.10.0
## [16] generics_0.1.4        ScaledMatrix_1.18.0   BiocGenerics_0.56.0
## [19] DelayedArray_0.36.0   bookdown_0.45         MatrixGenerics_1.22.0
## [22] bslib_0.9.0           rlang_1.1.6           cachem_1.1.0
## [25] xfun_0.54             sass_0.4.10           SparseArray_1.10.2
## [28] cli_3.6.5             digest_0.6.38         grid_4.5.2
## [31] irlba_2.3.5.1         lifecycle_1.0.4       S4Vectors_0.48.0
## [34] evaluate_1.0.5        codetools_0.2-20      beachmat_2.26.0
## [37] abind_1.4-8           stats4_4.5.2          rmarkdown_2.30
## [40] matrixStats_1.5.0     tools_4.5.2           htmltools_0.5.8.1
```