# *Matter 2*: User guide for flexible out-of-memory data structures

Kylie Ariel Bemis

#### Revised: July 17, 2024

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Out-of-memory data structures](#out-of-memory-data-structures)
  + [3.1 Atomic data units](#atomic-data-units)
  + [3.2 Arrays and matrices](#arrays-and-matrices)
    - [3.2.1 N-dimensional arrays](#n-dimensional-arrays)
    - [3.2.2 Column-major and row-major matrices](#column-major-and-row-major-matrices)
  + [3.3 Deferred arithmetic](#deferred-arithmetic)
  + [3.4 Lists](#lists)
* [4 Sparse data structures](#sparse-data-structures)
  + [4.1 Sparse matrices](#sparse-matrices)
  + [4.2 Nonuniform signals](#nonuniform-signals)
  + [4.3 Deferred arithmetic](#deferred-arithmetic-1)
* [5 Future work](#future-work)
* [6 Session information](#session-information)

# 1 Introduction

The *Matter* package provides flexible data structures for out-of-memory computing on dense and sparse arrays, with several features designed specifically for computing on nonuniform signals such as mass spectra and other spectral data.

*Matter 2* has been updated to provide a more robust C++ backend to out-of-memory `matter` objects, along with a completely new implementation of sparse arrays and new signal processing functions for nonuniform sparse signal data.

Originally designed as a backend for the *Cardinal* package, The first version of *Matter* was constantly evolving to handle the ever-increasing demands of larger-than-memory mass spectrometry (MS) imaging experiments. While it was designed to be flexible from a user’s point-of-view to handle a wide array for file structures beyond the niche of MS imaging, its codebase was becoming increasingly difficult to maintain and update.

*Matter 2* was re-written from the ground up to simplify some features that were rarely needed in practice and to provide a more robust and future-proof codebase for further improvement.

Specific improvements include:

* New sparse matrix backend re-implemented completely in C++ for greater efficiency and for planned public API and future ALTREP support
* Rewritten sparse matrix frontend re-implemented with more options for resampling and interpolation (see section on sparse matrices for details)
* Rewritten out-of-memory backend with improved and simplified C++ code designed with greater modularity for new features and planned public API
* Deferred `colsweep()` and `rowsweep()` operations to supplement new `colscale()` and `rowscale()` functions for centering/scaling with a grouping variable

# 2 Installation

*Matter* can be installed via the *BiocManager* package.

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("matter")
```

The same function can be used to update *Matter* and other Bioconductor packages.

Once installed, *Matter* can be loaded with `library()`:

```
library(matter)
```

# 3 Out-of-memory data structures

*Matter* provides a number of data structures for out-of-memory computing. These are designed to flexibly support a variety of binary file structures, which can be computed on similarly to native R data structures.

## 3.1 Atomic data units

The basis of out-of-memory data structures in *Matter* is a single contiguous chunk of data called an “atom”. The basic idea is: an “atom” is a unit of data that can be pulled into memory in a single atomic read operation.

An “atom” of data typically lives in a local file. It is defined by (1) its source (e.g., a file path), (2) its data type, (3) its offset within the source (in bytes), and (4) its extent (i.e., the number of elements).

A `matter` object is composed of any number of atoms, from any number of files, that together make up the elements of the data structure.

```
x <- matter_vec(1:10)
y <- matter_vec(11:20)
z <- cbind(x, y)
atomdata(z)
```

```
## <2 length> atoms :: units of data
##                   source  type offset extent group
## 1 file16499954a03e10.bin int32      0     10     0
## 2 file1649996c440f5a.bin int32      0     10     1
## (20 elements | 10 per group x 2 groups)
```

Above, the two columns of the matrix `z` are composed of two different “atoms” from two different files.

In this way, a `matter` object may be composed of data from any number of files, from any locations (i.e., byte offsets) within those files. This data can then be represented to the user as an array, matrix, vector, or list.

## 3.2 Arrays and matrices

### 3.2.1 N-dimensional arrays

File-based arrays can be constructed using `matter_arr()`.

If a native R array is provided, then its data will be written to the file specified by `path`. A temporary file will be created if none is specified.

```
set.seed(1)
a1 <- array(sort(runif(24)), dim=c(4,3,2))

a2 <- matter_arr(a1)
a2
```

```
## <4 x 3 x 2 dim> matter_arr :: out-of-core double array
## , , 1
##            [,1]       [,2]       [,3]
## [1,] 0.06178627 0.20597457 0.38003518
## [2,] 0.12555510 0.21214252 0.38410372
## [3,] 0.17655675 0.26550866 0.49769924
## [4,] 0.20168193 0.37212390 0.57285336
## , , ...
## (6.45 KB real | 0 bytes shared | 192 bytes virtual)
```

```
path(a2)
```

```
## [1] "/tmp/Rtmpx480ts/file1649994abcf4d4.bin"
```

A `matter` array can be constructed from data in an existing file(s) by specifying the following:

* `type` : the data type (see `?"matter-types"`)
* `path` : the file path(s)
* `offset` : the byte offset(s) within the file(s)
* `extent` : the number of data elements at each file/offset

For example, we can specify a new vector (i.e., a 1-D array) that points to the same temporary data file that was created above, but only the first 10 data elements.

```
a3 <- matter_arr(type="double", path=path(a2), offset=0, extent=10)
a3
```

```
## <10 length> matter_vec :: out-of-core double vector
##         [1]        [2]        [3]        [4]        [5]        [6] ...
##  0.06178627 0.12555510 0.17655675 0.20168193 0.20597457 0.21214252 ...
## (5.82 KB real | 0 bytes shared | 80 bytes virtual)
```

```
a1[1:10]
```

```
##  [1] 0.06178627 0.12555510 0.17655675 0.20168193 0.20597457 0.21214252
##  [7] 0.26550866 0.37212390 0.38003518 0.38410372
```

### 3.2.2 Column-major and row-major matrices

File-based matrices in *Matter* are a special case of 2-D arrays. By default, `matter` arrays and matrices follow standard R conventions by being stored in column-major order.

```
set.seed(1)
m1 <- matrix(sort(runif(35)), nrow=5, ncol=7)

m2 <- matter_mat(m1)
m2
```

```
## <5 row x 7 col> matter_mat :: out-of-core double matrix
##            [,1]       [,2]       [,3]       [,4]       [,5]       [,6] ...
## [1,] 0.01339033 0.20168193 0.34034900 0.38611409 0.59956583 0.71761851 ...
## [2,] 0.06178627 0.20597457 0.37212390 0.48208012 0.62911404 0.76984142 ...
## [3,] 0.12555510 0.21214252 0.38003518 0.49354131 0.65167377 0.77744522 ...
## [4,] 0.17655675 0.26550866 0.38238796 0.49769924 0.66079779 0.82737332 ...
## [5,] 0.18621760 0.26722067 0.38410372 0.57285336 0.68702285 0.86969085 ...
## (6.82 KB real | 0 bytes shared | 280 bytes virtual)
```

However, row-major storage is also supported.

```
m3 <- matter_mat(type="double", path=path(m2), nrow=7, ncol=5, rowMaj=TRUE)
m3
```

```
## <7 row x 5 col> matter_mat :: out-of-core double matrix
##            [,1]       [,2]       [,3]       [,4]       [,5]
## [1,] 0.01339033 0.06178627 0.12555510 0.17655675 0.18621760
## [2,] 0.20168193 0.20597457 0.21214252 0.26550866 0.26722067
## [3,] 0.34034900 0.37212390 0.38003518 0.38238796 0.38410372
## [4,] 0.38611409 0.48208012 0.49354131 0.49769924 0.57285336
## [5,] 0.59956583 0.62911404 0.65167377 0.66079779 0.68702285
## [6,] 0.71761851 0.76984142 0.77744522 0.82737332 0.86969085
## ...         ...        ...        ...        ...        ...
## (6.2 KB real | 0 bytes shared | 280 bytes virtual)
```

Transposing a `matter` matrix simply switches whether it is treated as column-major or row-major, without changing any data.

```
t(m2)
```

```
## <7 row x 5 col> matter_mat :: out-of-core double matrix
##            [,1]       [,2]       [,3]       [,4]       [,5]
## [1,] 0.01339033 0.06178627 0.12555510 0.17655675 0.18621760
## [2,] 0.20168193 0.20597457 0.21214252 0.26550866 0.26722067
## [3,] 0.34034900 0.37212390 0.38003518 0.38238796 0.38410372
## [4,] 0.38611409 0.48208012 0.49354131 0.49769924 0.57285336
## [5,] 0.59956583 0.62911404 0.65167377 0.66079779 0.68702285
## [6,] 0.71761851 0.76984142 0.77744522 0.82737332 0.86969085
## ...         ...        ...        ...        ...        ...
## (6.82 KB real | 0 bytes shared | 280 bytes virtual)
```

Use `rowMaj()` to check whether the data is stored in column-major or row-major order. It is much faster to iterate over a matrix in the same direction as its data orientation.

```
rowMaj(t(m2))
```

```
## [1] TRUE
```

```
rowMaj(m2)
```

```
## [1] FALSE
```

## 3.3 Deferred arithmetic

*Matter* supports deferred arithmetic for arrays and matrices.

```
m2 + 100
```

```
## <5 row x 7 col> matter_mat :: out-of-core double matrix
##          [,1]     [,2]     [,3]     [,4]     [,5]     [,6] ...
## [1,] 100.0134 100.2017 100.3403 100.3861 100.5996 100.7176 ...
## [2,] 100.0618 100.2060 100.3721 100.4821 100.6291 100.7698 ...
## [3,] 100.1256 100.2121 100.3800 100.4935 100.6517 100.7774 ...
## [4,] 100.1766 100.2655 100.3824 100.4977 100.6608 100.8274 ...
## [5,] 100.1862 100.2672 100.3841 100.5729 100.6870 100.8697 ...
## (10.07 KB real | 0 bytes shared | 280 bytes virtual)
```

Deferred arithmetic is not applied to the data in storage. Instead, it is applied on-the-fly to data elements that are read into memory (only when the are accessed).

```
as.matrix(1:5) + m2
```

```
## <5 row x 7 col> matter_mat :: out-of-core double matrix
##          [,1]     [,2]     [,3]     [,4]     [,5]     [,6] ...
## [1,] 1.013390 1.201682 1.340349 1.386114 1.599566 1.717619 ...
## [2,] 2.061786 2.205975 2.372124 2.482080 2.629114 2.769841 ...
## [3,] 3.125555 3.212143 3.380035 3.493541 3.651674 3.777445 ...
## [4,] 4.176557 4.265509 4.382388 4.497699 4.660798 4.827373 ...
## [5,] 5.186218 5.267221 5.384104 5.572853 5.687023 5.869691 ...
## (10.09 KB real | 0 bytes shared | 280 bytes virtual)
```

If the argument is not a scalar, then it must be an array with dimensions that are compatible for *Matter*’s deferred arithmetic.

Dimensions are compatible for deferred arithment when:

* A single dimension is equal for both arrays
* All other dimensions are 1

The dimensions that are 1 are then recycled to match the dimensions of the `matter` array.

```
t(1:7) + m2
```

```
## <5 row x 7 col> matter_mat :: out-of-core double matrix
##          [,1]     [,2]     [,3]     [,4]     [,5]     [,6] ...
## [1,] 1.013390 2.201682 3.340349 4.386114 5.599566 6.717619 ...
## [2,] 1.061786 2.205975 3.372124 4.482080 5.629114 6.769841 ...
## [3,] 1.125555 2.212143 3.380035 4.493541 5.651674 6.777445 ...
## [4,] 1.176557 2.265509 3.382388 4.497699 5.660798 6.827373 ...
## [5,] 1.186218 2.267221 3.384104 4.572853 5.687023 6.869691 ...
## (10.09 KB real | 0 bytes shared | 280 bytes virtual)
```

## 3.4 Lists

File-based lists can be construced using `matter_list()`.

Because they are not truly recursive like native R lists, `matter` lists are really more like jagged arrays.

```
set.seed(1)
l1 <- list(A=runif(10), B=rnorm(15), C=rlnorm(5), D="This is a string!")

l2 <- matter_list(l1)
l2
```

```
## <4 length> matter_list :: out-of-core list
##          [1]       [2]       [3]       [4]       [5]       [6] ...
## $A 0.2655087 0.3721239 0.5728534 0.9082078 0.2016819 0.8983897 ...
##           [1]        [2]        [3]        [4]        [5]        [6] ...
## $B -0.8204684  0.4874291  0.7383247  0.5757814 -0.3053884  1.5117812 ...
##          [1]       [2]       [3]       [4]       [5]
## $C 2.5067256 2.1861375 1.0774154 0.1367841 1.8586041
##                  [1]
## $D This is a string!
## (6.48 KB real | 0 bytes shared | 257 bytes virtual)
```

Due to the complexities of out-of-memory character vectors, character vector elements are limited to scalar strings.

# 4 Sparse data structures

*Matter* provides sparse arrays that are compatible with out-of-memory storage. These sparse arrays are unique in allowing for on-the-fly reindexing of rows and columns. This is especially useful for storing nonuniform signals such as high-resolution mass spectra.

## 4.1 Sparse matrices

*Matter* supports several variants of both compressed sparse column (CSC) and compressed sparse row (CSR) formats. The variants include the traditional array-based CSC/CSR representations (with a pointer array) and a list-based representation (without a pointer array, for easier modification).

Sparse matrices can be constructed using `sparse_mat()`.

If a native R matrix is provided, then the corresponding sparse matrix will be constructed.

```
set.seed(1)
s1 <- matrix(rbinom(35, 10, 0.05), nrow=5, ncol=7)

s2 <- sparse_mat(s1)
s2
```

```
## <5 row x 7 col> sparse_mat :: sparse integer matrix
##      [,1] [,2] [,3] [,4] [,5] [,6] ...
## [1,]    .    1    .    .    2    . ...
## [2,]    .    2    .    1    .    . ...
## [3,]    .    1    1    3    1    . ...
## [4,]    1    1    .    .    .    1 ...
## [5,]    .    .    1    1    .    . ...
## (15/35 non-zero elements: 42.86% density)
```

The default format uses a CSC-like list representation for the nonzero entries.

```
atomdata(s2)
```

```
## [[1]]
## [1] 1
##
## [[2]]
## [1] 1 2 1 1
##
## [[3]]
## [1] 1 1
##
## [[4]]
## [1] 1 3 1
##
## [[5]]
## [1] 2 1
##
## [[6]]
## [1] 1
##
## [[7]]
## [1] 1 1
```

```
atomindex(s2)
```

```
## [[1]]
## [1] 3
##
## [[2]]
## [1] 0 1 2 3
##
## [[3]]
## [1] 2 4
##
## [[4]]
## [1] 1 2 4
##
## [[5]]
## [1] 0 2
##
## [[6]]
## [1] 3
##
## [[7]]
## [1] 1 4
```

Sparse matrices can be constructed from the nonzero entries and the row/column indices.

```
s3 <- sparse_mat(atomdata(s2), index=atomindex(s2), nrow=5, ncol=7)
s3
```

```
## <5 row x 7 col> sparse_mat :: sparse double matrix
##      [,1] [,2] [,3] [,4] [,5] [,6] ...
## [1,]    .    1    .    .    2    . ...
## [2,]    .    2    .    1    .    . ...
## [3,]    .    1    1    3    1    . ...
## [4,]    1    1    .    .    .    1 ...
## [5,]    .    .    1    1    .    . ...
## (15/35 non-zero elements: 42.86% density)
```

Alternatively, a `pointers` array can be requested to construct the more traditional array-based CSC/CSR format with a “pointers” array to the start of the rows/columns.

```
s4 <- sparse_mat(s1, pointers=TRUE)
atomdata(s4)
```

```
##  [1] 1 1 2 1 1 1 1 1 3 1 2 1 1 1 1
```

```
atomindex(s4)
```

```
##  [1] 3 0 1 2 3 2 4 1 2 4 0 2 3 1 4
```

```
pointers(s4)
```

```
## [1]  0  1  5  7 10 12 13 15
```

Sparse matrices can be constructed using the array-based representation with a “pointers” array to the start of the rows/columns as well.

```
s5 <- sparse_mat(atomdata(s2), index=atomindex(s2), pointers=pointers(s2), nrow=5, ncol=7)
s5
```

```
## <5 row x 7 col> sparse_mat :: sparse double matrix
##      [,1] [,2] [,3] [,4] [,5] [,6] ...
## [1,]    .    1    .    .    2    . ...
## [2,]    .    2    .    1    .    . ...
## [3,]    .    1    1    3    1    . ...
## [4,]    1    1    .    .    .    1 ...
## [5,]    .    .    1    1    .    . ...
## (15/35 non-zero elements: 42.86% density)
```

Both the nonzero data entries and the row/column indices can be out-of-memory `matter` lists or arrays.

## 4.2 Nonuniform signals

Besides being able to handle out-of-memory data, sparse matrices in *Matter* are unique in supporting on-the-fly reindexing of their sparse dimension.

This is especially useful for representing nonuniform signals such as high-dimensional spectral data.

Consider mass spectra with intensity peaks collected at various (nonuniform) *m/z* values.

```
set.seed(1)
s <- replicate(4, simspec(1), simplify=FALSE)

# spectra with different m/z-values
head(domain(s[[1]]))
```

```
## [1] 507.8720 508.0159 508.1598 508.3037 508.4476 508.5915
```

```
head(domain(s[[2]]))
```

```
## [1] 562.5085 562.6585 562.8085 562.9585 563.1085 563.2585
```

```
head(domain(s[[3]]))
```

```
## [1] 607.2084 607.4040 607.5996 607.7951 607.9907 608.1863
```

```
head(domain(s[[4]]))
```

```
## [1] 313.2757 313.4277 313.5797 313.7317 313.8837 314.0357
```

```
# plot each spectrum
p1 <- plot_signal(domain(s[[1]]), s[[1]])
p2 <- plot_signal(domain(s[[2]]), s[[2]])
p3 <- plot_signal(domain(s[[3]]), s[[3]])
p4 <- plot_signal(domain(s[[4]]), s[[4]])

# combine the plots
plt <- as_facets(list(
    "Spectrum 1"=p1,
    "Spectrum 2"=p2,
    "Spectrum 3"=p3,
    "Spectrum 4"=p4), free="x")
plt <- set_channel(plt, "x", label="m/z")
plt <- set_channel(plt, "y", label="Intensity")

plot(plt)
```

![](data:image/png;base64...)

Representing these spectra as columns of a matrix with a common *m/z* axis would typically require binning or resampling. But this would sacrifice the sparsity of the data.

In *Matter*, we can accomplish this by using a sparse matrix that performs on-the-fly resampling.

```
mzr <- range(
    domain(s[[1]]),
    domain(s[[2]]),
    domain(s[[3]]),
    domain(s[[4]]))
mz <- seq(from=round(mzr[1]), to=round(mzr[2]), by=0.2)

index <- list(
    domain(s[[1]]),
    domain(s[[2]]),
    domain(s[[3]]),
    domain(s[[4]]))

spectra <- sparse_mat(s, index=index, domain=mz,
    sampler="max", tolerance=0.5)

spectra
```

```
## <11251 row x 4 col> sparse_mat :: sparse double matrix
##                [,1]       [,2]       [,3]       [,4]
## (313,)   .          .          .          0.08564349
## (313.2,) .          .          .          0.08564349
## (313.4,) .          .          .          0.08564349
## (313.6,) .          .          .          0.10222002
## (313.8,) .          .          .          0.10222002
## (314,)   .          .          .          0.10222002
## ...             ...        ...        ...        ...
## (40000/45004 non-zero elements: 88.88% density)
```

```
plot_signal(mz, as.matrix(spectra), byrow=FALSE)
```

![](data:image/png;base64...)

## 4.3 Deferred arithmetic

Like out-of-memory arrays and matrices, sparse matrices in *Matter* also support deferred arithmetic.

```
spectra / t(colMeans(spectra))
```

```
## <11251 row x 4 col> sparse_mat :: sparse double matrix
##               [,1]      [,2]      [,3]      [,4]
## (313,)   .         .         .         0.2666138
## (313.2,) .         .         .         0.2666138
## (313.4,) .         .         .         0.2666138
## (313.6,) .         .         .         0.3182176
## (313.8,) .         .         .         0.3182176
## (314,)   .         .         .         0.3182176
## ...            ...       ...       ...       ...
## (40000/45004 non-zero elements: 88.88% density)
```

# 5 Future work

*Matter 2* will continue to be developed to provide more flexible solutions to out-of-memory data in R, and to meet the needs of high-resolution mass spectrometry and other spectral data.

For some domain-specific applications of *Matter*, see the Bioconductor package *Cardinal* for statistical analysis of mass spectrometry imaging experiments.

# 6 Session information

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
## [1] matter_2.12.0       Matrix_1.7-4        BiocParallel_1.44.0
## [4] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          magick_2.9.0
##  [4] rlang_1.1.6         xfun_0.53           ProtGenerics_1.42.0
##  [7] generics_0.1.4      jsonlite_2.0.0      htmltools_0.5.8.1
## [10] tinytex_0.57        sass_0.4.10         stats4_4.5.1
## [13] rmarkdown_2.30      grid_4.5.1          evaluate_1.0.5
## [16] jquerylib_0.1.4     fastmap_1.2.0       yaml_2.3.10
## [19] lifecycle_1.0.4     bookdown_0.45       BiocManager_1.30.26
## [22] compiler_4.5.1      codetools_0.2-20    irlba_2.3.5.1
## [25] Rcpp_1.1.0          lattice_0.22-7      digest_0.6.37
## [28] R6_2.6.1            parallel_4.5.1      magrittr_2.0.4
## [31] bslib_0.9.0         tools_4.5.1         BiocGenerics_0.56.0
## [34] cachem_1.1.0
```