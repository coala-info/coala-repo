# SparseArray objects

Hervé Pagès1

1Fred Hutch Cancer Center, Seattle, WA

#### Compiled 18 December 2025; Modified 14 January 2025

#### Package

SparseArray 1.10.8

# Contents

* [1 Introduction](#introduction)
* [2 Install and load the package](#install-and-load-the-package)
* [3 The SparseArray virtual class and its two concrete subclasses](#the-sparsearray-virtual-class-and-its-two-concrete-subclasses)
* [4 SVT\_SparseArray objects](#svt_sparsearray-objects)
  + [4.1 Construction](#construction)
  + [4.2 SVT\_SparseArray vs COO\_SparseArray](#svt_sparsearray-vs-coo_sparsearray)
* [5 The SparseArray API](#the-sparsearray-api)
  + [5.1 The core array API](#the-core-array-api)
  + [5.2 type() and is\_sparse()](#type-and-is_sparse)
  + [5.3 is\_nonzero() and the nz\*() functions](#is_nonzero-and-the-nz-functions)
  + [5.4 Subsetting and subassignment](#subsetting-and-subassignment)
  + [5.5 Summarization methods (whole array)](#summarization-methods-whole-array)
  + [5.6 Operations from the Arith, Compare, Logic, Math, Math2, and Complex groups](#operations-from-the-arith-compare-logic-math-math2-and-complex-groups)
* [6 The 2D API](#the-2d-api)
  + [6.1 SVT\_SparseMatrix objects](#svt_sparsematrix-objects)
  + [6.2 Transposition](#transposition)
  + [6.3 Combine multidimensional objects along a given dimension](#combine-multidimensional-objects-along-a-given-dimension)
  + [6.4 matrixStats methods](#matrixstats-methods)
  + [6.5 `rowsum()` and `colsum()`](#rowsum-and-colsum)
  + [6.6 Matrix multiplication and cross-product](#matrix-multiplication-and-cross-product)
* [7 Other operations](#other-operations)
  + [7.1 Generate a random SVT\_SparseArray object](#generate-a-random-svt_sparsearray-object)
  + [7.2 Read/write a sparse matrix from/to a CSV file](#readwrite-a-sparse-matrix-fromto-a-csv-file)
* [8 Comparison with dgCMatrix objects](#comparison-with-dgcmatrix-objects)
  + [8.1 “SVT layout” vs “CSC layout”](#svt-layout-vs-csc-layout)
  + [8.2 Working with a big sparse dataset](#working-with-a-big-sparse-dataset)
* [9 Learn more](#learn-more)
* [10 Session information](#session-information)

# 1 Introduction

*[SparseArray](https://bioconductor.org/packages/3.22/SparseArray)* is an infrastructure package that enables
high-performance sparse data representation and manipulation in R.
The workhorse of the package is an array-like container that allows
efficient in-memory representation of multidimensional sparse data in R.

# 2 Install and load the package

Like any other Bioconductor package, *[SparseArray](https://bioconductor.org/packages/3.22/SparseArray)* should always
be installed with `BiocManager::install()`:

```
if (!require("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("SparseArray")
```

Load the package:

```
library(SparseArray)
```

# 3 The SparseArray virtual class and its two concrete subclasses

The package defines the SparseArray virtual class and two concrete
subclasses: COO\_SparseArray and SVT\_SparseArray.

Each subclass uses its own internal representation of the nonzero
multidimensional data: the “COO layout” and the “SVT layout”, respectively.

Note that the SparseArray virtual class makes no assumption about the
internal representation of the nonzero data, so it could easily be
extended by other S4 classes that use a different layout for the
nonzero data.

This vignette focuses on the SVT\_SparseArray container, which is
the most memory-efficient and feature-complete of the two SparseArray
subclasses. The COO\_SparseArray class is only provided to support
some rare use-cases. In other words, using SVT\_SparseArray objects
is almost always preferred over using COO\_SparseArray objects.

# 4 SVT\_SparseArray objects

The SVT\_SparseArray container provides an efficient representation of the
nonzero multidimensional data via a novel layout called the “SVT layout”.

Note that SVT\_SparseArray objects mimic as much as possible the behavior of
ordinary matrix or array objects in base R. In particular, they suppport
most of the “standard matrix and array API” defined in base R and in the
*[matrixStats](https://bioconductor.org/packages/3.22/matrixStats)* package from CRAN.

## 4.1 Construction

SVT\_SparseArray objects can be constructed in many ways. A common way
is to start with an empty object and to subassign nonzero values to it:

```
svt1 <- SVT_SparseArray(dim=c(6, 4))
svt1[c(1:2, 8, 10, 15:17, 24)] <- (1:8)*10L
svt1
```

```
## <6 x 4 SparseMatrix> of type "integer" [nzcount=8 (33%)]:
##      [,1] [,2] [,3] [,4]
## [1,]   10    0    0    0
## [2,]   20   30    0    0
## [3,]    0    0   50    0
## [4,]    0   40   60    0
## [5,]    0    0   70    0
## [6,]    0    0    0   80
```

```
svt2 <- SVT_SparseArray(dim=5:3)
svt2[c(1:2, 8, 10, 15:17, 20, 24, 40, 56:60)] <- (1:15)*10L
svt2
```

```
## <5 x 4 x 3 SparseArray> of type "integer" [nzcount=15 (25%)]:
## ,,1
##      [,1] [,2] [,3] [,4]
## [1,]   10    0    0   60
## [2,]   20    0    0   70
## [3,]    0   30    0    0
## [4,]    0    0    0    0
## [5,]    0   40   50   80
##
## ,,2
##      [,1] [,2] [,3] [,4]
## [1,]    0    0    0    0
## [2,]    0    0    0    0
## [3,]    0    0    0    0
## [4,]   90    0    0    0
## [5,]    0    0    0  100
##
## ,,3
##      [,1] [,2] [,3] [,4]
## [1,]    0    0    0  110
## [2,]    0    0    0  120
## [3,]    0    0    0  130
## [4,]    0    0    0  140
## [5,]    0    0    0  150
```

Another way is to coerce a matrix- or array-like object to
SVT\_SparseArray:

```
# Coerce a dgCMatrix object to SVT_SparseArray:
dgcm <- Matrix::rsparsematrix(12, 5, density=0.15)
svt3 <- as(dgcm, "SVT_SparseArray")

# Coerce a TENxMatrix object to SVT_SparseArray:
suppressMessages(library(HDF5Array))
M <- writeTENxMatrix(svt3)
svt3b <- as(M, "SVT_SparseArray")

# Sanity check:
stopifnot(identical(svt3, svt3b))
```

Alternatively, these coercions can be done by simply passing the object
to coerce to the `SVT_SparseArray()` constructor function:

```
svt3  <- SVT_SparseArray(dgcm)  # same as as(dgcm, "SVT_SparseArray")
svt3b <- SVT_SparseArray(M)     # same as as(M, "SVT_SparseArray")
```

See `?SVT_SparseArray` for more information about the `SVT_SparseArray()`
constructor function and additional examples.

## 4.2 SVT\_SparseArray vs COO\_SparseArray

As mentioned earlier, SVT\_SparseArray objects are almost always preferred
over using COO\_SparseArray objects. Coercing to SparseArray or using
the `SparseArray()` constructor function reflects this preference i.e.
in both cases the actual class of the returned SparseArray derivative
will almost always be SVT\_SparseArray (or SVT\_SparseMatrix). Except
in the rare situation where returning a COO\_SparseArray object is a more
natural fit for the input object.

For example coercing the following objects to SparseArray will *always*
produce an SVT\_SparseArray object:

```
# Coerce an ordinary matrix to SparseArray:
a <- array(rpois(80, lambda=0.35), dim=c(5, 8, 2))
class(as(a, "SparseArray"))  # SVT_SparseArray
```

```
## [1] "SVT_SparseArray"
## attr(,"package")
## [1] "SparseArray"
```

```
# Coerce a dgCMatrix object to SparseArray:
svt3  <- as(dgcm, "SparseArray")
class(svt3)  # SVT_SparseArray
```

```
## [1] "SVT_SparseMatrix"
## attr(,"package")
## [1] "SparseArray"
```

```
# Coerce a TENxMatrix object to SparseArray:
svt3b <- as(M, "SparseArray")
class(svt3)  # SVT_SparseArray
```

```
## [1] "SVT_SparseMatrix"
## attr(,"package")
## [1] "SparseArray"
```

Also using the `SparseArray()` constructor function on these objects will
*always* produce an SVT\_SparseArray object:

```
SparseArray(a)              # same as as(a, "SparseArray")
```

```
## <5 x 8 x 2 SparseArray> of type "integer" [nzcount=21 (26%)]:
## ,,1
##      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8]
## [1,]    0    0    0    1    0    0    0    0
## [2,]    0    0    0    0    1    2    0    0
## [3,]    1    1    0    0    0    0    1    0
## [4,]    1    0    0    0    0    1    0    1
## [5,]    0    1    0    0    0    2    1    1
##
## ,,2
##      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8]
## [1,]    0    0    0    0    0    0    0    0
## [2,]    0    1    1    0    0    1    0    0
## [3,]    0    0    0    0    0    1    0    0
## [4,]    0    1    0    1    0    1    0    0
## [5,]    0    0    0    0    0    1    0    0
```

```
svt3  <- SparseArray(dgcm)  # same as as(dgcm, "SparseArray")
svt3b <- SparseArray(M)     # same as as(M, "SparseArray")
```

This is actually the most convenient way to turn an ordinary matrix or
array, or a dgCMatrix object, or a TENxMatrix object, into an SVT\_SparseArray
object.

One situation where `as(x, "SparseArray")` or `SparseArray(x)` will return
a COO\_SparseArray object is when the input object `x` is a sparseMatrix
derivative that uses a compressed *row-oriented* representation (`"R"`
representation) instead of the more widely used compressed *column-oriented*
representation (`"C"` representation):

```
ngrm <- sparseMatrix(i=c(1, 5, 5, 6), j=c(4, 2, 3, 2), repr="R")
class(ngrm)  # ngRMatrix
```

```
## [1] "ngRMatrix"
## attr(,"package")
## [1] "Matrix"
```

```
class(SparseArray(ngrm))  # COO_SparseMatrix
```

```
## [1] "COO_SparseMatrix"
## attr(,"package")
## [1] "SparseArray"
```

One way to enforce the SVT\_SparseArray representation is to coerce the
result to SVT\_SparseArray:

```
svt <- as(SparseArray(ngrm), "SVT_SparseArray")
class(svt)  # SVT_SparseMatrix
```

```
## [1] "SVT_SparseMatrix"
## attr(,"package")
## [1] "SparseArray"
```

Finally, note that coercing back to ordinary matrix or array (dense
representation) is supported, although obviously not a good idea if
the SparseArray object is big:

```
as.array(svt1)  # same as as.matrix(svt1)
```

```
##      [,1] [,2] [,3] [,4]
## [1,]   10    0    0    0
## [2,]   20   30    0    0
## [3,]    0    0   50    0
## [4,]    0   40   60    0
## [5,]    0    0   70    0
## [6,]    0    0    0   80
```

```
as.array(svt2)
```

```
## , , 1
##
##      [,1] [,2] [,3] [,4]
## [1,]   10    0    0   60
## [2,]   20    0    0   70
## [3,]    0   30    0    0
## [4,]    0    0    0    0
## [5,]    0   40   50   80
##
## , , 2
##
##      [,1] [,2] [,3] [,4]
## [1,]    0    0    0    0
## [2,]    0    0    0    0
## [3,]    0    0    0    0
## [4,]   90    0    0    0
## [5,]    0    0    0  100
##
## , , 3
##
##      [,1] [,2] [,3] [,4]
## [1,]    0    0    0  110
## [2,]    0    0    0  120
## [3,]    0    0    0  130
## [4,]    0    0    0  140
## [5,]    0    0    0  150
```

# 5 The SparseArray API

## 5.1 The core array API

SVT\_SparseArray objects support the “core array API” defined in base R:

```
dim(svt2)
```

```
## [1] 5 4 3
```

```
length(svt2)
```

```
## [1] 60
```

```
dimnames(svt2) <- list(NULL, letters[1:4], LETTERS[1:3])
svt2
```

```
## <5 x 4 x 3 SparseArray> of type "integer" [nzcount=15 (25%)]:
## ,,A
##       a  b  c  d
## [1,] 10  0  0 60
## [2,] 20  0  0 70
## [3,]  0 30  0  0
## [4,]  0  0  0  0
## [5,]  0 40 50 80
##
## ,,B
##        a   b   c   d
## [1,]   0   0   0   0
## [2,]   0   0   0   0
## [3,]   0   0   0   0
## [4,]  90   0   0   0
## [5,]   0   0   0 100
##
## ,,C
##        a   b   c   d
## [1,]   0   0   0 110
## [2,]   0   0   0 120
## [3,]   0   0   0 130
## [4,]   0   0   0 140
## [5,]   0   0   0 150
```

## 5.2 type() and is\_sparse()

`type()` and `is_sparse()` are generic functions defined in
*[BiocGenerics](https://bioconductor.org/packages/3.22/BiocGenerics)* and *[S4Arrays](https://bioconductor.org/packages/3.22/S4Arrays)*, respectively.
They extend the “core array API” defined in base R:

```
type(svt1)
```

```
## [1] "integer"
```

```
type(svt1) <- "double"
svt1
```

```
## <6 x 4 SparseMatrix> of type "double" [nzcount=8 (33%)]:
##      [,1] [,2] [,3] [,4]
## [1,]   10    0    0    0
## [2,]   20   30    0    0
## [3,]    0    0   50    0
## [4,]    0   40   60    0
## [5,]    0    0   70    0
## [6,]    0    0    0   80
```

```
is_sparse(svt1)
```

```
## [1] TRUE
```

See `?SparseArray` for more information and additional examples.

## 5.3 is\_nonzero() and the nz\*() functions

A set of functions is provided for direct manipulation of the nonzero
array elements:

```
is_nonzero(svt1)
```

```
## <6 x 4 SparseMatrix> of type "logical" [nzcount=8 (33%)]:
##       [,1]  [,2]  [,3]  [,4]
## [1,]  TRUE FALSE FALSE FALSE
## [2,]  TRUE  TRUE FALSE FALSE
## [3,] FALSE FALSE  TRUE FALSE
## [4,] FALSE  TRUE  TRUE FALSE
## [5,] FALSE FALSE  TRUE FALSE
## [6,] FALSE FALSE FALSE  TRUE
```

```
## Get the number of nonzero array elements in 'svt1':
nzcount(svt1)
```

```
## [1] 8
```

```
## Extract the "linear indices" of the nonzero array elements in 'svt1':
nzwhich(svt1)
```

```
## [1]  1  2  8 10 15 16 17 24
```

```
## Extract the "array indices" (a.k.a. "array coordinates") of the
## nonzero array elements in 'svt1':
nzwhich(svt1, arr.ind=TRUE)
```

```
##      [,1] [,2]
## [1,]    1    1
## [2,]    2    1
## [3,]    2    2
## [4,]    4    2
## [5,]    3    3
## [6,]    4    3
## [7,]    5    3
## [8,]    6    4
```

```
## Extract the values of the nonzero array elements in 'svt1':
nzvals(svt1)
```

```
## [1] 10 20 30 40 50 60 70 80
```

Note that the vectors produced by `nzwhich()` and `nzvals()` are *parallel*,
that is, they have the same length and the i-th element in one vector
corresponds to the i-th element in the other vector.

See `?is_nonzero` for more information and additional examples.

## 5.4 Subsetting and subassignment

```
svt2[5:3, , "C"]
```

```
## <3 x 4 SparseMatrix> of type "integer" [nzcount=3 (25%)]:
##        a   b   c   d
## [1,]   0   0   0 150
## [2,]   0   0   0 140
## [3,]   0   0   0 130
```

Like with ordinary arrays in base R, assigning values of type `"double"` to
an SVT\_SparseArray object of type `"integer"` will automatically change the
type of the object to `"double"`:

```
type(svt2)
```

```
## [1] "integer"
```

```
svt2[5, 1, 3] <- NaN
type(svt2)
```

```
## [1] "double"
```

See `?SparseArray_subsetting` for more information and additional examples.

## 5.5 Summarization methods (whole array)

The following summarization methods are provided at the moment: `anyNA()`,
`any`, `all`, `min`, `max`, `range`, `sum`, `prod`, `mean`, `var`, `sd`.

```
anyNA(svt2)
```

```
## [1] TRUE
```

```
range(svt2, na.rm=TRUE)
```

```
## [1]   0 150
```

```
mean(svt2, na.rm=TRUE)
```

```
## [1] 20.33898
```

```
var(svt2, na.rm=TRUE)
```

```
## [1] 1717.124
```

See `?SparseArray_summarization` for more information and additional examples.

## 5.6 Operations from the Arith, Compare, Logic, Math, Math2, and Complex groups

SVT\_SparseArray objects support operations from the `Arith`, `Compare`,
`Logic`, `Math`, `Math2`, and `Complex` groups, with some restrictions.
See `?S4groupGeneric` in the *[methods](https://bioconductor.org/packages/3.22/methods)* package for more
information about these group generics.

```
signif((svt1^1.5 + svt1) %% 100 - 0.6 * svt1, digits=2)
```

```
## <6 x 4 SparseMatrix> of type "double" [nzcount=8 (33%)]:
##       [,1]  [,2]  [,3]  [,4]
## [1,]  36.0   0.0   0.0   0.0
## [2,]  -2.6  76.0   0.0   0.0
## [3,]   0.0   0.0 -26.0   0.0
## [4,]   0.0  69.0 -11.0   0.0
## [5,]   0.0   0.0  14.0   0.0
## [6,]   0.0   0.0   0.0  48.0
```

See `?SparseArray_Arith`, `?SparseArray_Compare`, `?SparseArray_Logic`,
`?SparseArray_Math`, and `?SparseArray_Complex` for more information
and additional examples.

# 6 The 2D API

## 6.1 SVT\_SparseMatrix objects

SVT\_SparseMatrix objects are just two-dimensional SVT\_SparseArray objects.
See `?SparseArray` for a diagram of the SparseArray class hierarchy.

## 6.2 Transposition

```
t(svt1)
```

```
## <4 x 6 SparseMatrix> of type "double" [nzcount=8 (33%)]:
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]   10   20    0    0    0    0
## [2,]    0   30    0   40    0    0
## [3,]    0    0   50   60   70    0
## [4,]    0    0    0    0    0   80
```

Note that multidimensional transposition is supported via `aperm()`:

```
aperm(svt2)
```

```
## <3 x 4 x 5 SparseArray> of type "double" [nzcount=16 (27%)]:
## ,,1
##     a   b   c   d
## A  10   0   0  60
## B   0   0   0   0
## C   0   0   0 110
##
## ,,2
##     a   b   c   d
## A  20   0   0  70
## B   0   0   0   0
## C   0   0   0 120
##
## ,,3
##     a   b   c   d
## A   0  30   0   0
## B   0   0   0   0
## C   0   0   0 130
##
## ,,4
##     a   b   c   d
## A   0   0   0   0
## B  90   0   0   0
## C   0   0   0 140
##
## ,,5
##     a   b   c   d
## A   0  40  50  80
## B   0   0   0 100
## C NaN   0   0 150
```

See `?SparseArray_aperm` for more information and additional examples.

## 6.3 Combine multidimensional objects along a given dimension

Like ordinary matrices in base R, SVT\_SparseMatrix objects can be
combined by rows or columns, with `rbind()` or `cbind()`:

```
svt4 <- poissonSparseMatrix(6, 2, density=0.5)

cbind(svt1, svt4)
```

```
## <6 x 6 SparseMatrix> of type "double" [nzcount=15 (42%)]:
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]   10    0    0    0    0    0
## [2,]   20   30    0    0    1    3
## [3,]    0    0   50    0    2    1
## [4,]    0   40   60    0    1    2
## [5,]    0    0   70    0    1    0
## [6,]    0    0    0   80    0    0
```

Note that multidimensional objects can be combined along any dimension
with `abind()`:

```
svt5a <- poissonSparseArray(c(5, 6, 2), density=0.4)
svt5b <- poissonSparseArray(c(5, 6, 5), density=0.2)
svt5c <- poissonSparseArray(c(5, 6, 4), density=0.2)
abind(svt5a, svt5b, svt5c)
```

```
## <5 x 6 x 11 SparseArray> of type "integer" [nzcount=74 (22%)]:
## ,,1
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    0    0    1    0    0    0
## [2,]    1    1    0    1    0    0
## [3,]    0    0    1    0    0    1
## [4,]    1    0    0    0    0    0
## [5,]    3    0    0    0    1    1
##
## ...
##
## ,,11
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    0    0    0    0    1    0
## [2,]    0    1    0    0    0    0
## [3,]    1    0    1    0    0    0
## [4,]    0    0    0    1    0    0
## [5,]    0    0    1    0    0    0
```

```
svt6a <- aperm(svt5a, c(1, 3:2))
svt6b <- aperm(svt5b, c(1, 3:2))
svt6c <- aperm(svt5c, c(1, 3:2))
abind(svt6a, svt6b, svt6c, along=2)
```

```
## <5 x 11 x 6 SparseArray> of type "integer" [nzcount=74 (22%)]:
## ,,1
##       [,1]  [,2]  [,3]  [,4] ...  [,8]  [,9] [,10] [,11]
## [1,]     0     0     0     0   .     0     1     1     0
## [2,]     1     1     0     0   .     0     0     0     0
## [3,]     0     0     0     0   .     0     0     0     1
## [4,]     1     0     0     0   .     0     1     0     0
## [5,]     3     1     0     0   .     0     0     0     0
##
## ...
##
## ,,6
##       [,1]  [,2]  [,3]  [,4] ...  [,8]  [,9] [,10] [,11]
## [1,]     0     2     2     0   .     0     0     0     0
## [2,]     0     2     1     0   .     1     1     0     0
## [3,]     1     0     1     0   .     0     1     0     0
## [4,]     0     0     0     0   .     0     0     0     0
## [5,]     1     0     1     0   .     0     0     0     0
```

See `?SparseArray_abind` for more information and additional examples.

## 6.4 matrixStats methods

The *[SparseArray](https://bioconductor.org/packages/3.22/SparseArray)* package provides memory-efficient col/row
summarization methods for SVT\_SparseMatrix objects:

```
svt7 <- SVT_SparseArray(dim=5:6, dimnames=list(letters[1:5], LETTERS[1:6]))
svt7[c(2, 6, 12:17, 22:30)] <- 101:117

colVars(svt7)
```

```
##      A      B      C      D      E      F
## 2040.2 2080.8 2185.3 3467.0 2443.3    2.5
```

Note that multidimensional objects are supported:

```
colVars(svt2)
```

```
##      A    B   C
## a   80 1620 NaN
## b  380    0   0
## c  500    0   0
## d 1520 2000 250
```

```
colVars(svt2, dims=2)
```

```
##        A        B        C
## 732.6316 857.6316      NaN
```

```
colAnyNAs(svt2)
```

```
##       A     B     C
## a FALSE FALSE  TRUE
## b FALSE FALSE FALSE
## c FALSE FALSE FALSE
## d FALSE FALSE FALSE
```

```
colAnyNAs(svt2, dims=2)
```

```
##     A     B     C
## FALSE FALSE  TRUE
```

See `?SparseArray_matrixStats` for more information and additional examples.

## 6.5 `rowsum()` and `colsum()`

`rowsum()` and `colsum()` are supported:

```
rowsum(svt7, group=c(1:3, 2:1))
```

```
##     A   B   C   D   E   F
## 1   0 102 106 107 112 230
## 2 101   0 208 108 220 230
## 3   0   0 104   0 110 115
```

```
colsum(svt7, group=c("A", "B", "A", "B", "B", "A"))
```

```
##     A   B
## a 113 209
## b 318 217
## c 219 110
## d 221 111
## e 223 112
```

See `?rowsum_methods` for more information and additional examples.

## 6.6 Matrix multiplication and cross-product

SVT\_SparseMatrix objects support matrix multiplication:

```
svt7 %*% svt4
```

```
##   [,1] [,2]
## a  209  520
## b  423  319
## c  318  104
## d  321  105
## e  324  106
```

as well as `crossprod()` and `tcrossprod()`:

```
crossprod(svt4)
```

```
##      [,1] [,2]
## [1,]    7    7
## [2,]    7   14
```

See `?SparseMatrix_mult` for more information and additional examples.

# 7 Other operations

## 7.1 Generate a random SVT\_SparseArray object

Two convenience functions are provided for this:

```
randomSparseArray(c(5, 6, 2), density=0.5)
```

```
## <5 x 6 x 2 SparseArray> of type "double" [nzcount=30 (50%)]:
## ,,1
##        [,1]   [,2]   [,3]   [,4]   [,5]   [,6]
## [1,]  0.000 -1.000  0.000  0.280  0.000 -0.400
## [2,]  0.071  0.000 -0.620  0.000  0.610  0.000
## [3,]  0.560  0.000  0.000  0.000  0.000 -1.100
## [4,]  0.000  1.000  0.000  0.000 -2.300 -1.600
## [5,] -0.380 -0.400  0.000  0.000  0.000  0.310
##
## ,,2
##        [,1]   [,2]   [,3]   [,4]   [,5]   [,6]
## [1,]  0.000  0.000 -0.760 -1.800 -2.100 -1.700
## [2,] -0.053  0.000  0.000  0.000  2.300  1.600
## [3,] -0.450  0.140  0.000  0.000  0.380  0.160
## [4,]  0.590  0.300  0.000  0.000 -1.000  0.000
## [5,] -0.990  0.000  0.000  0.510  0.000  0.000
```

```
poissonSparseArray(c(5, 6, 2), density=0.5)
```

```
## <5 x 6 x 2 SparseArray> of type "integer" [nzcount=26 (43%)]:
## ,,1
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    1    0    0    0    0    2
## [2,]    0    0    1    0    0    2
## [3,]    2    0    0    1    1    0
## [4,]    0    1    0    0    1    0
## [5,]    0    0    0    0    1    1
##
## ,,2
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    0    0    4    2    0    1
## [2,]    1    0    0    0    1    1
## [3,]    1    0    1    0    0    1
## [4,]    1    0    0    0    1    0
## [5,]    1    0    1    1    0    1
```

See `?randomSparseArray` for more information and additional examples.

## 7.2 Read/write a sparse matrix from/to a CSV file

Use `writeSparseCSV()` to write a sparse matrix to a CSV file:

```
csv_file <- tempfile()
writeSparseCSV(svt7, csv_file)
```

Use `readSparseCSV()` to read the file. This will import the data as
an SVT\_SparseMatrix object:

```
readSparseCSV(csv_file)
```

```
## <5 x 6 SparseMatrix> of type "integer" [nzcount=17 (57%)]:
##     A   B   C   D   E   F
## a   0 102   0 107   0 113
## b 101   0 103 108 109 114
## c   0   0 104   0 110 115
## d   0   0 105   0 111 116
## e   0   0 106   0 112 117
```

See `?readSparseCSV` for more information and additional examples.

# 8 Comparison with dgCMatrix objects

## 8.1 “SVT layout” vs “CSC layout”

The nonzero data of a SVT\_SparseArray object is stored in a *Sparse
Vector Tree*. This internal data representation is referred to as
the “SVT layout”. It is similar to the “CSC layout” (compressed, sparse,
column-oriented format) used by CsparseMatrix derivatives from
the *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* package, like dgCMatrix or lgCMatrix objects,
but with the following improvements:

* The “SVT layout” supports sparse arrays of arbitrary dimensions.
* With the “SVT layout”, the sparse data can be of any type.
  Whereas CsparseMatrix derivatives only support sparse data of
  type `"double"` or `"logical"`.
* The “SVT layout” imposes no limit on the number of nonzero array
  elements that can be stored. With dgCMatrix/lgCMatrix objects, this
  number must be < 2^31.
* Overall, the “SVT layout” allows more efficient operations on
  SVT\_SparseArray objects.

See `?SVT_SparseArray` for more information about the “SVT layout”.

## 8.2 Working with a big sparse dataset

The “1.3 Million Brain Cell Dataset” from 10x Genomics is a sparse 2D
dataset with more than 2^31 nonzero values. The dataset is stored in an
HDF5 file that is available via ExperimentHub (resource id `EH1039`):

```
suppressMessages(library(HDF5Array))
suppressMessages(library(ExperimentHub))
hub <- ExperimentHub()
oneM <- TENxMatrix(hub[["EH1039"]], group="mm10")
```

```
## see ?TENxBrainData and browseVignettes('TENxBrainData') for documentation
```

```
## loading from cache
```

```
oneM
```

```
## <27998 x 1306127> sparse TENxMatrix object of type "integer":
##                      AAACCTGAGATAGGAG-1 ... TTTGTCATCTGAAAGA-133
## ENSMUSG00000051951                    0   .                    0
## ENSMUSG00000089699                    0   .                    0
## ENSMUSG00000102343                    0   .                    0
## ENSMUSG00000025900                    0   .                    0
## ENSMUSG00000109048                    0   .                    0
##                ...                    .   .                    .
## ENSMUSG00000079808                    0   .                    0
## ENSMUSG00000095041                    1   .                    0
## ENSMUSG00000063897                    0   .                    0
## ENSMUSG00000096730                    0   .                    0
## ENSMUSG00000095742                    0   .                    0
```

`oneM` is a TENxMatrix object. This is a particular kind of sparse
DelayedArray object where the data is on disk in an HDF5 file.
See `?TENxMatrix` in the *[HDF5Array](https://CRAN.R-project.org/package%3DHDF5Array)* package for more
information about TENxMatrix objects.

Note that the object has more than 2^31 nonzero values:

```
nzcount(oneM)
```

```
## [1] 2624828308
```

The standard way to load the data of a TENxMatrix object (or any
DelayedArray derivative) from disk to memory is to simply coerce the
object to the desired in-memory representation.

For example, to load the data in an SVT\_SparseArray object:

```
# WARNING: This takes a couple of minutes on a modern laptop, and will
# consume about 25Gb of RAM!
svt <- as(oneM, "SVT_SparseArray")
```

To load the data in a dgCMatrix object:

```
# This will fail because 'oneM' has more than 2^31 nonzero values!
as(oneM, "dgCMatrix")
```

# 9 Learn more

Please consult the individual man pages in the *[SparseArray](https://bioconductor.org/packages/3.22/SparseArray)*
package to learn more about SVT\_SparseArray objects and about the
package. A good starting point is the man page for SparseArray
objects: `?SparseArray`

# 10 Session information

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] TENxBrainData_1.30.0        SingleCellExperiment_1.32.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.1        Seqinfo_1.0.0
##  [7] ExperimentHub_3.0.0         AnnotationHub_4.0.0
##  [9] BiocFileCache_3.0.0         dbplyr_2.5.1
## [11] HDF5Array_1.38.0            h5mread_1.2.1
## [13] rhdf5_2.54.1                DelayedArray_0.36.0
## [15] SparseArray_1.10.8          S4Arrays_1.10.1
## [17] IRanges_2.44.0              abind_1.4-8
## [19] S4Vectors_0.48.0            MatrixGenerics_1.22.0
## [21] matrixStats_1.5.0           BiocGenerics_0.56.0
## [23] generics_0.1.4              Matrix_1.7-4
## [25] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      xfun_0.55            bslib_0.9.0
##  [4] httr2_1.2.2          lattice_0.22-7       rhdf5filters_1.22.0
##  [7] vctrs_0.6.5          tools_4.5.2          curl_7.0.0
## [10] tibble_3.3.0         AnnotationDbi_1.72.0 RSQLite_2.4.5
## [13] blob_1.2.4           pkgconfig_2.0.3      lifecycle_1.0.4
## [16] compiler_4.5.2       Biostrings_2.78.0    htmltools_0.5.9
## [19] sass_0.4.10          yaml_2.3.12          pillar_1.11.1
## [22] crayon_1.5.3         jquerylib_0.1.4      cachem_1.1.0
## [25] tidyselect_1.2.1     digest_0.6.39        purrr_1.2.0
## [28] dplyr_1.1.4          bookdown_0.46        BiocVersion_3.22.0
## [31] fastmap_1.2.0        grid_4.5.2           cli_3.6.5
## [34] magrittr_2.0.4       withr_3.0.2          filelock_1.0.3
## [37] rappdirs_0.3.3       bit64_4.6.0-1        rmarkdown_2.30
## [40] XVector_0.50.0       httr_1.4.7           bit_4.6.0
## [43] otel_0.2.0           png_0.1-8            memoise_2.0.1
## [46] evaluate_1.0.5       knitr_1.50           rlang_1.1.6
## [49] glue_1.8.0           DBI_1.2.3            BiocManager_1.30.27
## [52] jsonlite_2.0.0       R6_2.6.1             Rhdf5lib_1.32.0
```