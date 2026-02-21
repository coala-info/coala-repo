# Developing around the SingleCellExperiment class

Davide Risso and Aaron Lun

#### 30 October 2025

#### Package

SingleCellExperiment 1.32.0

# 1 Introduction

By design, the scope of this package is limited to defining the `SingleCellExperiment` class and some minimal getter and setter methods.
For this reason, we leave it to developers of specialized packages to provide more advanced methods for the `SingleCellExperiment` class.
If packages define their own data structure, it is their responsibility to provide coercion methods to/from their classes to `SingleCellExperiment`.

For developers, the use of `SingleCellExperiment` objects within package functions is mostly the same as the use of instances of the base `SummarizedExperiment` class.
The only exceptions involve direct access to the internal fields of the `SingleCellExperiment` definition.
Manipulation of these internal fields in other packages is possible but requires some caution, as we shall discuss below.

# 2 Using the internal fields

## 2.1 Rationale

We use an internal storage mechanism to protect certain fields from direct manipulation by the user.
This ensures that only a call to the provided setter methods can change the size factors.
The same effect could be achieved by reserving a subset of columns (or column names) as “private” in `colData()` and `rowData()`, though this is not easily implemented.

The internal storage avoids situations where users or functions can silently overwrite these important metadata fields during manipulations of `rowData` or `colData`.
This can result in bugs that are difficult to track down, particularly in long workflows involving many functions.
It also allows us to add new methods and metadata types to `SingleCellExperiment` without worrying about overwriting user-supplied metadata in existing objects.

Methods to get or set the internal fields are exported for use by developers of packages that depend on *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)*.
This allows dependent packages to store their own custom fields that are not meant to be directly accessible by the user.
However, this requires some care to avoid conflicts between packages.

## 2.2 Conflicts between packages

The concern is that package **A** and **B** both define methods that get/set an internal field `X` in a `SingleCellExperiment` instance.
Consider the following example object:

```
library(SingleCellExperiment)
counts <- matrix(rpois(100, lambda = 10), ncol=10, nrow=10)
sce <- SingleCellExperiment(assays = list(counts = counts))
sce
```

```
## class: SingleCellExperiment
## dim: 10 10
## metadata(0):
## assays(1): counts
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

Assume that we have functions that set an internal field `X` in packages **A** and **B**.

```
# Function in package A:
AsetX <- function(sce) {
    int_colData(sce)$X <- runif(ncol(sce))
    sce
}

# Function in package B:
BsetX <- function(sce) {
    int_colData(sce)$X <- sample(LETTERS, ncol(sce), replace=TRUE)
    sce
}
```

If both of these functions are called, one will clobber the output of the other.
This may lead to nonsensical results in downstream procedures.

```
sce2 <- AsetX(sce)
int_colData(sce2)$X
```

```
##  [1] 0.1087477 0.9774320 0.2109910 0.2873821 0.6232665 0.9438237 0.0346593
##  [8] 0.3574876 0.6085779 0.1905249
```

```
sce2 <- BsetX(sce2)
int_colData(sce2)$X
```

```
##  [1] "M" "O" "X" "S" "Q" "B" "K" "X" "P" "H"
```

## 2.3 Using “Inception-style” nesting

We recommend using nested `DataFrame`s to store internal fields in the column-level metadata.
The name of the nested element should be set to the package name, thus avoiding clashes between fields with the same name from different packages.

```
AsetX_better <- function(sce) {
    int_colData(sce)$A <- DataFrame(X=runif(ncol(sce)))
    sce
}

BsetX_better <- function(sce) {
    choice <- sample(LETTERS, ncol(sce), replace=TRUE)
    int_colData(sce)$B <- DataFrame(X=choice)
    sce
}

sce2 <- AsetX_better(sce)
sce2 <- BsetX_better(sce2)
int_colData(sce2)$A$X
```

```
##  [1] 0.8607912 0.8897867 0.5920328 0.4990860 0.2632683 0.9164873 0.2222134
##  [8] 0.2151641 0.5759307 0.5678103
```

```
int_colData(sce2)$B$X
```

```
##  [1] "L" "T" "M" "Y" "P" "H" "F" "S" "O" "P"
```

The same approach can be applied to the row-level metadata, e.g., for some per-row field `Y`.

```
AsetY_better <- function(sce) {
    int_elementMetadata(sce)$A <- DataFrame(Y=runif(nrow(sce)))
    sce
}

BsetY_better <- function(sce) {
    choice <- sample(LETTERS, nrow(sce), replace=TRUE)
    int_elementMetadata(sce)$B <- DataFrame(Y=choice)
    sce
}

sce2 <- AsetY_better(sce)
sce2 <- BsetY_better(sce2)
int_elementMetadata(sce2)$A$Y
```

```
##  [1] 0.50999574 0.91348814 0.60463701 0.48934603 0.32781652 0.81592374
##  [7] 0.44574032 0.86539058 0.86852001 0.05038553
```

```
int_elementMetadata(sce2)$B$Y
```

```
##  [1] "A" "E" "W" "G" "J" "S" "H" "A" "L" "R"
```

For the object-wide metadata, a nested list is usually sufficient.

```
AsetZ_better <- function(sce) {
    int_metadata(sce)$A <- list(Z = "Aaron")
    sce
}

BsetZ_better <- function(sce) {
    int_metadata(sce)$B <- list(Z = "Davide")
    sce
}

sce2 <- AsetZ_better(sce)
sce2 <- BsetZ_better(sce2)
int_metadata(sce2)$A$Z
```

```
## [1] "Aaron"
```

```
int_metadata(sce2)$B$Z
```

```
## [1] "Davide"
```

In this manner, both **A** and **B** can set their internal `X`, `Y` and `Z` without interfering with each other.
Of course, this strategy assumes that packages do not have the same names as some of the in-built internal fields (which would be very unfortunate).

# 3 Contacting us

If your package accesses the internal fields of the `SingleCellExperiment` class, we suggest you get into contact with us on [GitHub](https://github.com/drisso/SingleCellExperiment).
This will help us in planning changes to the internal organization of the class.
It will also allow us to contact you with respect to changes or to get feedback.

We are particularly interested in scenarios where multiple packages are defining internal fields with the same scientific meaning.
In such cases, it may be valuable to provide getters and setters for this field in *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* directly.
This reduces redundancy in the definitions across packages and promotes interoperability.
For example, methods from one package can set the field, which can then be used by methods of another package.

# 4 Other design decisions

## 4.1 What’s up with `reducedDims`?

We use a `SimpleList` as the `reducedDims` slot to allow for multiple dimensionality reduction results.
One can imagine that different dimensionality reduction techniques will be useful for different aspects of the analysis, e.g., t-SNE for visualization, PCA for pseudo-time inference.
We see `reducedDims` as a similar slot to `assays()` in that multiple matrices can be stored, though the dimensionality reduction results need not have the same number of dimensions.

## 4.2 Why derive from a `RangedSummarizedExperiment`?

We decided to extend `RangedSummarizedExperiment` rather than `SummarizedExperiment` because for certain assays it will be essential to have `rowRanges()`.
Even for RNA-seq, it is sometimes useful to have `rowRanges()` and other classes to define the genomic coordinates, e.g., `DESeqDataSet` in the *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* package.
An alternative would have been to have two classes, `SingleCellExperiment` and `RangedSingleCellExperiment`.
However, this seems like an unnecessary duplication as having a class with default empty `rowRanges` seems good enough when one does not need `rowRanges`.

## 4.3 Why not use a `MultiAssayExperiment`?

Another approach to storing alternative Experiments would be to use a `MultiAssayExperiment`.
We do not do so as the vast majority of scRNA-seq data analyses operate on the endogenous genes.
Switching to a `MultiAssayExperiment` introduces an additional layer of indirection with no benefit in most cases.
Indeed, the methods of this class are largely unnecessary when the alternative Experiments contain data for the same samples.
By storing nested Experiments, we maintain the familiar `SummarizedExperiment` interface for better compatibility and ease of use.

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
##  [1] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] xfun_0.53           DelayedArray_0.36.0 jsonlite_2.0.0
##  [7] htmltools_0.5.8.1   sass_0.4.10         rmarkdown_2.30
## [10] grid_4.5.1          abind_1.4-8         evaluate_1.0.5
## [13] jquerylib_0.1.4     fastmap_1.2.0       yaml_2.3.10
## [16] lifecycle_1.0.4     bookdown_0.45       BiocManager_1.30.26
## [19] compiler_4.5.1      XVector_0.50.0      lattice_0.22-7
## [22] digest_0.6.37       R6_2.6.1            SparseArray_1.10.0
## [25] Matrix_1.7-4        bslib_0.9.0         tools_4.5.1
## [28] S4Arrays_1.10.0     cachem_1.1.0
```