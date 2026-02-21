# 2. Tensor arithmetic by DelayedTensor

Koki Tsuyuzaki1 and Itoshi Nikaido1\*

1Laboratory for Bioinformatics Research, RIKEN Center for Biosystems Dynamics Research

\*k.t.the-answer@hotmail.co.jp

#### 29 October 2025

#### Package

DelayedTensor 1.16.0

**Authors**: Koki Tsuyuzaki [aut, cre]
**Last modified:** 2025-10-29 20:12:10.36772
**Compiled**: Wed Oct 29 23:32:59 2025

# 1 Setting

```
suppressPackageStartupMessages(library("DelayedTensor"))
```

```
## Warning: multiple methods tables found for 'kronecker'
```

```
suppressPackageStartupMessages(library("DelayedArray"))
suppressPackageStartupMessages(library("HDF5Array"))
suppressPackageStartupMessages(library("DelayedRandomArray"))

darr1 <- RandomUnifArray(c(2,3,4))
darr2 <- RandomUnifArray(c(2,3,4))
```

There are several settings in *[DelayedTensor](https://bioconductor.org/packages/3.22/DelayedTensor)*.

First, the sparsity of the intermediate *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* objects
calculated inside *[DelayedTensor](https://bioconductor.org/packages/3.22/DelayedTensor)* is set by `setSparse`.

Note that the sparse mode is experimental.

Whether it contributes to higher speed and lower memory is quite dependent
on the sparsity of the *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*,
and the current implementation does not recognize the block size,
which may cause out-of-memory errors, when the data is extremely huge.

Here, we specify `as.sparse` as `FALSE`
(this is also the default value for now).

```
DelayedTensor::setSparse(as.sparse=FALSE)
```

Next, the verbose message is suppressed by `setVerbose`.
This is useful when we want to monitor the calculation process.

Here we specify `as.verbose` as `FALSE`
(this is also the default value for now).

```
DelayedTensor::setVerbose(as.verbose=FALSE)
```

The block size of block processing is specified by `setAutoBlockSize`.
When the sparse mode is off, all the functions of *[DelayedTensor](https://bioconductor.org/packages/3.22/DelayedTensor)*
are performed as block processing,
in which each block vector/matrix/tensor is expanded to memory space
from on-disk file incrementally so as not to exceed the specified size.

Here, we specify the block size as `1E+8`.

```
setAutoBlockSize(size=1E+8)
```

```
## automatic block size set to 1e+08 bytes (was 1e+08)
```

Finally, the temporal directory to store the intermediate HDF5 files during running *[DelayedTensor](https://bioconductor.org/packages/3.22/DelayedTensor)* is specified by `setHDF5DumpDir`.

Note that in many systems the `/var` directory has the storage limitation, so if there is no enough space, user should specify the other directory.

```
# tmpdir <- paste(sample(c(letters,1:9), 10), collapse="")
# dir.create(tmpdir, recursive=TRUE))
tmpdir <- tempdir()
setHDF5DumpDir(tmpdir)
```

These specified values are also extracted by each getter function.

```
DelayedTensor::getSparse()
```

```
## $delayedtensor.sparse
## [1] FALSE
```

```
DelayedTensor::getVerbose()
```

```
## $delayedtensor.verbose
## [1] FALSE
```

```
getAutoBlockSize()
```

```
## [1] 1e+08
```

```
getHDF5DumpDir()
```

```
## [1] "/tmp/RtmpmpQjeh"
```

# 2 Tensor Arithmetic Operations

## 2.1 Unfold/Fold Operations

Unfold (a.k.a. matricizing) operations are used to reshape a tensor into a
matrix.

![](data:image/png;base64...)

Figure 1: Unfold/Fold Operasions

In `unfold`, `row_idx` and `col_idx` are specified to set which modes are used
as the row/column.

```
dmat1 <- DelayedTensor::unfold(darr1, row_idx=c(1,2), col_idx=3)
dmat1
```

```
## <6 x 4> HDF5Matrix object of type "double":
##            [,1]       [,2]       [,3]       [,4]
## [1,] 0.42526327 0.56100747 0.78420617 0.49306966
## [2,] 0.86999338 0.03341074 0.45874524 0.16851049
## [3,] 0.67177302 0.92674488 0.70477727 0.35671789
## [4,] 0.81785597 0.91977070 0.36163217 0.04202805
## [5,] 0.18932836 0.82915287 0.55235526 0.63072154
## [6,] 0.87395351 0.64431156 0.47885931 0.58421390
```

`fold` is the inverse operation of `unfold`, which is used to reshape
a matrix into a tensor.

In `fold`, `row_idx`/`col_idx` are specified to set which modes correspond
the row/column of the output tensor and `modes`
is specified to set the mode of the output tensor.

```
dmat1_to_darr1 <- DelayedTensor::fold(dmat1,
    row_idx=c(1,2), col_idx=3, modes=dim(darr1))
dmat1_to_darr1
```

```
## <2 x 3 x 4> DelayedArray object of type "double":
## ,,1
##           [,1]      [,2]      [,3]
## [1,] 0.4252633 0.6717730 0.1893284
## [2,] 0.8699934 0.8178560 0.8739535
##
## ,,2
##            [,1]       [,2]       [,3]
## [1,] 0.56100747 0.92674488 0.82915287
## [2,] 0.03341074 0.91977070 0.64431156
##
## ,,3
##           [,1]      [,2]      [,3]
## [1,] 0.7842062 0.7047773 0.5523553
## [2,] 0.4587452 0.3616322 0.4788593
##
## ,,4
##            [,1]       [,2]       [,3]
## [1,] 0.49306966 0.35671789 0.63072154
## [2,] 0.16851049 0.04202805 0.58421390
```

```
identical(as.array(darr1), as.array(dmat1_to_darr1))
```

```
## [1] TRUE
```

There are some wrapper functions of `unfold` and `fold`.

For example, in `k_unfold`, mode `m` is used as the row, and the other modes
are is used as the column.

`k_fold` is the inverse operation of `k_unfold`.

```
dmat2 <- DelayedTensor::k_unfold(darr1, m=1)
dmat2_to_darr1 <- k_fold(dmat2, m=1, modes=dim(darr1))
identical(as.array(darr1), as.array(dmat2_to_darr1))
```

```
## [1] TRUE
```

```
dmat3 <- DelayedTensor::k_unfold(darr1, m=2)
dmat3_to_darr1 <- k_fold(dmat3, m=2, modes=dim(darr1))
identical(as.array(darr1), as.array(dmat3_to_darr1))
```

```
## [1] TRUE
```

```
dmat4 <- DelayedTensor::k_unfold(darr1, m=3)
dmat4_to_darr1 <- k_fold(dmat4, m=3, modes=dim(darr1))
identical(as.array(darr1), as.array(dmat4_to_darr1))
```

```
## [1] TRUE
```

In `rs_unfold`, mode `m` is used as the row, and the other modes
are is used as the column.

`rs_fold` and `rs_unfold` also perform the same operations.

On the other hand, `cs_unfold` specifies the mode `m` as the column
and the other modes are specified as the column.

`cs_fold` is the inverse operation of `cs_unfold`.

```
dmat8 <- DelayedTensor::cs_unfold(darr1, m=1)
dmat8_to_darr1 <- DelayedTensor::cs_fold(dmat8, m=1, modes=dim(darr1))
identical(as.array(darr1), as.array(dmat8_to_darr1))
```

```
## [1] TRUE
```

```
dmat9 <- DelayedTensor::cs_unfold(darr1, m=2)
dmat9_to_darr1 <- DelayedTensor::cs_fold(dmat9, m=2, modes=dim(darr1))
identical(as.array(darr1), as.array(dmat9_to_darr1))
```

```
## [1] TRUE
```

```
dmat10 <- DelayedTensor::cs_unfold(darr1, m=3)
dmat10_to_darr1 <- DelayedTensor::cs_fold(dmat10, m=3, modes=dim(darr1))
identical(as.array(darr1), as.array(dmat10_to_darr1))
```

```
## [1] TRUE
```

In `matvec`, m=2 is specified as unfold.

`unmatvec` is the inverse operation of `matvec`.

```
dmat11 <- DelayedTensor::matvec(darr1)
dmat11_darr1 <- DelayedTensor::unmatvec(dmat11, modes=dim(darr1))
identical(as.array(darr1), as.array(dmat11_darr1))
```

```
## [1] TRUE
```

`ttm` multiplies a tensor by a matrix.

`m` specifies in which mode the matrix will be multiplied.

```
dmatZ <- RandomUnifArray(c(10,4))
DelayedTensor::ttm(darr1, dmatZ, m=3)
```

```
## <2 x 3 x 10> DelayedArray object of type "double":
## ,,1
##           [,1]      [,2]      [,3]
## [1,] 0.3859626 0.4679909 0.4059114
## [2,] 0.1683906 0.3719447 0.3709833
##
## ,,2
##           [,1]      [,2]      [,3]
## [1,] 1.0967203 1.3378975 0.9984248
## [2,] 0.9930121 1.1717445 1.4620342
##
## ,,3
##           [,1]      [,2]      [,3]
## [1,] 0.6461533 0.7205489 0.8759221
## [2,] 0.1512322 0.4802925 0.7575005
##
## ...
##
## ,,8
##           [,1]      [,2]      [,3]
## [1,] 1.3734314 1.7090541 1.5172979
## [2,] 0.7100748 1.4163502 1.5716076
##
## ,,9
##          [,1]     [,2]     [,3]
## [1,] 1.687844 1.960986 1.509176
## [2,] 1.344569 1.600702 1.976275
##
## ,,10
##           [,1]      [,2]      [,3]
## [1,] 0.5766316 0.6837172 0.7066236
## [2,] 0.1761979 0.5104015 0.6131587
```

`ttl` multiplies a tensor by multiple matrices.

`ms` specifies in which mode these matrices will be multiplied.

```
dmatX <- RandomUnifArray(c(10,2))
dmatY <- RandomUnifArray(c(10,3))
dlizt <- list(dmatX = dmatX, dmatY = dmatY)
DelayedTensor::ttl(darr1, dlizt, ms=c(1,2))
```

```
## <10 x 10 x 4> DelayedArray object of type "double":
## ,,1
##           [,1]     [,2]     [,3] ...     [,9]    [,10]
##  [1,] 1.340630 1.307763 1.429696   . 1.660431 1.423926
##  [2,] 1.134427 1.084994 1.163050   . 1.460910 1.260467
##   ...        .        .        .   .        .        .
##  [9,] 1.580887 1.569108 1.744242   . 1.888285 1.609789
## [10,] 1.568157 1.570000 1.759442   . 1.838123 1.562067
##
## ...
##
## ,,4
##            [,1]      [,2]      [,3] ...      [,9]     [,10]
##  [1,] 0.6356897 0.4496612 0.4300028   . 0.9748678 0.8859191
##  [2,] 0.3909002 0.2315521 0.2079994   . 0.6301177 0.5834495
##   ...         .         .         .   .         .         .
##  [9,] 0.9330559 0.7161005 0.7015514   .  1.392653  1.252077
## [10,] 1.0175238 0.8035248 0.7934212   .  1.503321  1.345984
```

## 2.2 Vectorization

`vec` collapses a *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* into
a 1D *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* (vector).

![](data:image/png;base64...)

Figure 2: Vectorization

```
DelayedTensor::vec(darr1)
```

```
## <24> HDF5Array object of type "double":
##       [1]       [2]       [3]         .      [23]      [24]
## 0.4252633 0.8699934 0.6717730         . 0.6307215 0.5842139
```

## 2.3 Norm Operations

`fnorm` calculates the Frobenius norm of a *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*.

![](data:image/png;base64...)

Figure 3: Norm Operations

```
DelayedTensor::fnorm(darr1)
```

```
## [1] 3.017916
```

`innerProd` calculates the inner product value of two
*[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*.

```
DelayedTensor::innerProd(darr1, darr2)
```

```
## [1] 7.060017
```

## 2.4 Outer Product

Inner product multiplies two tensors and collapses to 0D tensor (norm).
On the other hand, the outer product is an operation that leaves all subscripts intact.

![](data:image/png;base64...)

Figure 4: Outer Product

```
DelayedTensor::outerProd(darr1[,,1], darr2[,,1])
```

```
## <2 x 3 x 2 x 3> HDF5Array object of type "double":
## ,,1,1
##           [,1]      [,2]      [,3]
## [1,] 0.3872260 0.6116869 0.1723941
## [2,] 0.7921777 0.7447036 0.7957836
##
## ,,2,1
##           [,1]      [,2]      [,3]
## [1,] 0.2517496 0.3976797 0.1120796
## [2,] 0.5150232 0.4841587 0.5173676
##
## ,,1,2
##            [,1]       [,2]       [,3]
## [1,] 0.08888629 0.14041046 0.03957242
## [2,] 0.18184144 0.17094395 0.18266916
##
## ,,2,2
##            [,1]       [,2]       [,3]
## [1,] 0.21413967 0.33826869 0.09533556
## [2,] 0.43808178 0.41182819 0.44007589
##
## ,,1,3
##           [,1]      [,2]      [,3]
## [1,] 0.2947899 0.4656689 0.1312413
## [2,] 0.6030741 0.5669328 0.6058192
##
## ,,2,3
##           [,1]      [,2]      [,3]
## [1,] 0.2632850 0.4159018 0.1172152
## [2,] 0.5386222 0.5063434 0.5410740
```

## 2.5 Diagonal Operations

Using `DelayedDiagonalArray`, we can originally create a diagonal
*[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* by specifying the dimensions (modes) and the values.

![](data:image/png;base64...)

Figure 5: Diagonal Operations

```
dgdarr <- DelayedTensor::DelayedDiagonalArray(c(5,6,7), 1:5)
dgdarr
```

```
## <5 x 6 x 7> sparse DelayedArray object of type "integer":
## ,,1
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    1    0    0    0    0    0
## [2,]    0    0    0    0    0    0
## [3,]    0    0    0    0    0    0
## [4,]    0    0    0    0    0    0
## [5,]    0    0    0    0    0    0
##
## ...
##
## ,,7
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    0    0    0    0    0    0
## [2,]    0    0    0    0    0    0
## [3,]    0    0    0    0    0    0
## [4,]    0    0    0    0    0    0
## [5,]    0    0    0    0    0    0
```

Similar to the `diag` of the *[base](https://CRAN.R-project.org/package%3Dbase)* package,
the `diag` of *[DelayedTensor](https://bioconductor.org/packages/3.22/DelayedTensor)* is used to extract
and assign values to *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*.

```
DelayedTensor::diag(dgdarr)
```

```
## <5> DelayedArray object of type "integer":
## [1] [2] [3] [4] [5]
##   1   2   3   4   5
```

```
DelayedTensor::diag(dgdarr) <- c(1111, 2222, 3333, 4444, 5555)
DelayedTensor::diag(dgdarr)
```

```
## <5> DelayedArray object of type "double":
##  [1]  [2]  [3]  [4]  [5]
## 1111 2222 3333 4444 5555
```

## 2.6 Mode-wise Operations

`modeSum` calculates the summation for a given mode `m` of
a *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*.
The mode specified as `m` is collapsed into 1D as follows.

![](data:image/png;base64...)

Figure 6: Mode-wise Operations

```
DelayedTensor::modeSum(darr1, m=1)
```

```
## <1 x 3 x 4> DelayedArray object of type "double":
## ,,1
##          [,1]     [,2]     [,3]
## [1,] 1.295257 1.489629 1.063282
##
## ,,2
##           [,1]      [,2]      [,3]
## [1,] 0.5944182 1.8465156 1.4734644
##
## ,,3
##          [,1]     [,2]     [,3]
## [1,] 1.242951 1.066409 1.031215
##
## ,,4
##           [,1]      [,2]      [,3]
## [1,] 0.6615801 0.3987459 1.2149354
```

```
DelayedTensor::modeSum(darr1, m=2)
```

```
## <2 x 1 x 4> DelayedArray object of type "double":
## ,,1
##          [,1]
## [1,] 1.286365
## [2,] 2.561803
##
## ,,2
##          [,1]
## [1,] 2.316905
## [2,] 1.597493
##
## ,,3
##          [,1]
## [1,] 2.041339
## [2,] 1.299237
##
## ,,4
##           [,1]
## [1,] 1.4805091
## [2,] 0.7947524
```

```
DelayedTensor::modeSum(darr1, m=3)
```

```
## <2 x 3 x 1> DelayedArray object of type "double":
## ,,1
##          [,1]     [,2]     [,3]
## [1,] 2.263547 2.660013 2.201558
## [2,] 1.530660 2.141287 2.581338
```

Similar to `modeSum`, `modeMean` calculates the average value
for a given mode `m` of a *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*.

```
DelayedTensor::modeMean(darr1, m=1)
```

```
## <1 x 3 x 4> DelayedArray object of type "double":
## ,,1
##           [,1]      [,2]      [,3]
## [1,] 0.6476283 0.7448145 0.5316409
##
## ,,2
##           [,1]      [,2]      [,3]
## [1,] 0.2972091 0.9232578 0.7367322
##
## ,,3
##           [,1]      [,2]      [,3]
## [1,] 0.6214757 0.5332047 0.5156073
##
## ,,4
##           [,1]      [,2]      [,3]
## [1,] 0.3307901 0.1993730 0.6074677
```

```
DelayedTensor::modeMean(darr1, m=2)
```

```
## <2 x 1 x 4> DelayedArray object of type "double":
## ,,1
##           [,1]
## [1,] 0.4287882
## [2,] 0.8539343
##
## ,,2
##           [,1]
## [1,] 0.7723017
## [2,] 0.5324977
##
## ,,3
##           [,1]
## [1,] 0.6804462
## [2,] 0.4330789
##
## ,,4
##           [,1]
## [1,] 0.4935030
## [2,] 0.2649175
```

```
DelayedTensor::modeMean(darr1, m=3)
```

```
## <2 x 3 x 1> DelayedArray object of type "double":
## ,,1
##           [,1]      [,2]      [,3]
## [1,] 0.5658866 0.6650033 0.5503895
## [2,] 0.3826650 0.5353217 0.6453346
```

## 2.7 Tensor Product Operations

There are some tensor specific product such as Hadamard product,
Kronecker product, and Khatri-Rao product.

### 2.7.1 Hadamard Product

Suppose a tensor \(A \in \Re ^{I \times J}\) and
a tensor \(B \in \Re ^{I \times J}\).

Hadamard product is defined as the element-wise product of \(A\) and \(B\).

![](data:image/png;base64...)

Figure 7: Hadamard Product

Hadamard product can be extended to higher-order tensors.

\[
A \circ B = \begin{bmatrix}
a\_{11}b\_{11} & a\_{12}b\_{12} & \cdots & a\_{1J}b\_{1J} \\
a\_{21}b\_{21} & a\_{22}b\_{22} & \cdots & a\_{2J}b\_{2J} \\
\vdots & \vdots & \ddots & \vdots \\
a\_{I1}b\_{I1} & a\_{I2}b\_{I2} & \cdots & a\_{IJ}b\_{IJ} \\
\end{bmatrix}
\]

`hadamard` calculates Hadamard product of two *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*
objects.

```
prod_h <- DelayedTensor::hadamard(darr1, darr2)
dim(prod_h)
```

```
## [1] 2 3 4
```

`hadamard_list` calculates Hadamard product of multiple
*[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* objects.

```
prod_hl <- DelayedTensor::hadamard_list(list(darr1, darr2))
dim(prod_hl)
```

```
## [1] 2 3 4
```

### 2.7.2 Kronecker Product

Suppose a tensor \(A \in \Re ^{I \times J}\) and
a tensor \(B \in \Re ^{K \times L}\).

Kronecker product is defined as all the possible combination of element-wise
product and the dimensions of output tensor are \({IK \times JL}\).

![](data:image/png;base64...)

Figure 8: Kronecker Product

Kronecker product can be extended to higher-order tensors.

\[
A \otimes B = \begin{bmatrix}
a\_{11}B & a\_{12}B & \cdots & a\_{1J}B \\
a\_{21}B & a\_{22}B & \cdots & a\_{2J}B \\
\vdots & \vdots & \ddots & \vdots \\
a\_{I1}B & a\_{I2}B & \cdots & a\_{IJ}B \\
\end{bmatrix}
\]

`kronecker` calculates Kronecker product of two *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*
objects.

```
prod_kron <- DelayedTensor::kronecker(darr1, darr2)
dim(prod_kron)
```

```
## [1]  4  9 16
```

`kronecker_list` calculates Kronecker product of multiple
*[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* objects.

```
prod_kronl <- DelayedTensor::kronecker_list(list(darr1, darr2))
dim(prod_kronl)
```

```
## [1]  4  9 16
```

### 2.7.3 Khatri-Rao Product

Suppose a tensor \(A \in \Re ^{I \times J}\) and
a tensor \(B \in \Re ^{K \times J}\).

Khatri-Rao product is defined as the column-wise Kronecker product
and the dimensions of output tensor is \({IK \times J}\).

\[
A \odot B = \begin{bmatrix}
a\_{1} \otimes a\_{1} & a\_{2} \otimes a\_{2} & \cdots & a\_{J} \otimes a\_{J} \\
\end{bmatrix}
\]

![](data:image/png;base64...)

Figure 9: Khatri-Rao Product

Khatri-Rao product can only be used for 2D tensors (matrices).

`khatri_rao` calculates Khatri-Rao product of two *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*
objects.

```
prod_kr <- DelayedTensor::khatri_rao(darr1[,,1], darr2[,,1])
dim(prod_kr)
```

```
## [1] 4 3
```

`khatri_rao_list` calculates Khatri-Rao product of multiple
*[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* objects.

```
prod_krl <- DelayedTensor::khatri_rao_list(list(darr1[,,1], darr2[,,1]))
dim(prod_krl)
```

```
## [1] 4 3
```

## 2.8 Utilities Functions

`list_rep` replicates an arbitrary number of any R object.

```
str(DelayedTensor::list_rep(darr1, 3))
```

```
## List of 3
##  $ :Formal class 'RandomUnifArray' [package "DelayedRandomArray"] with 1 slot
##   .. ..@ seed:Formal class 'RandomUnifArraySeed' [package "DelayedRandomArray"] with 6 slots
##   .. .. .. ..@ min     : num 0
##   .. .. .. ..@ max     : num 1
##   .. .. .. ..@ dim     : int [1:3] 2 3 4
##   .. .. .. ..@ chunkdim: int [1:3] 2 3 4
##   .. .. .. ..@ seeds   :List of 1
##   .. .. .. .. ..$ : int [1:2] -372031969 607955137
##   .. .. .. ..@ sparse  : logi FALSE
##  $ :Formal class 'RandomUnifArray' [package "DelayedRandomArray"] with 1 slot
##   .. ..@ seed:Formal class 'RandomUnifArraySeed' [package "DelayedRandomArray"] with 6 slots
##   .. .. .. ..@ min     : num 0
##   .. .. .. ..@ max     : num 1
##   .. .. .. ..@ dim     : int [1:3] 2 3 4
##   .. .. .. ..@ chunkdim: int [1:3] 2 3 4
##   .. .. .. ..@ seeds   :List of 1
##   .. .. .. .. ..$ : int [1:2] -372031969 607955137
##   .. .. .. ..@ sparse  : logi FALSE
##  $ :Formal class 'RandomUnifArray' [package "DelayedRandomArray"] with 1 slot
##   .. ..@ seed:Formal class 'RandomUnifArraySeed' [package "DelayedRandomArray"] with 6 slots
##   .. .. .. ..@ min     : num 0
##   .. .. .. ..@ max     : num 1
##   .. .. .. ..@ dim     : int [1:3] 2 3 4
##   .. .. .. ..@ chunkdim: int [1:3] 2 3 4
##   .. .. .. ..@ seeds   :List of 1
##   .. .. .. .. ..$ : int [1:2] -372031969 607955137
##   .. .. .. ..@ sparse  : logi FALSE
```

### 2.8.1 Bind Operations

`modebind_list` collapses multiple *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* objects
into single *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* object.

`m` specifies the collapsed dimension.

![](data:image/png;base64...)

Figure 10: Bind Operations

```
dim(DelayedTensor::modebind_list(list(darr1, darr2), m=1))
```

```
## [1] 4 3 4
```

```
dim(DelayedTensor::modebind_list(list(darr1, darr2), m=2))
```

```
## [1] 2 6 4
```

```
dim(DelayedTensor::modebind_list(list(darr1, darr2), m=3))
```

```
## [1] 2 3 8
```

`rbind_list` is the row-wise `modebind_list` and
collapses multiple 2D *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* objects
into single *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* object.

```
dim(DelayedTensor::rbind_list(list(darr1[,,1], darr2[,,1])))
```

```
## [1] 4 3
```

`cbind_list` is the column-wise `modebind_list` and
collapses multiple 2D *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* objects
into single *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* object.

```
dim(DelayedTensor::cbind_list(list(darr1[,,1], darr2[,,1])))
```

```
## [1] 2 6
```

# Session information

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
##  [1] DelayedRandomArray_1.18.0 HDF5Array_1.38.0
##  [3] h5mread_1.2.0             rhdf5_2.54.0
##  [5] DelayedArray_0.36.0       SparseArray_1.10.0
##  [7] S4Arrays_1.10.0           abind_1.4-8
##  [9] IRanges_2.44.0            S4Vectors_0.48.0
## [11] MatrixGenerics_1.22.0     matrixStats_1.5.0
## [13] BiocGenerics_0.56.0       generics_0.1.4
## [15] Matrix_1.7-4              DelayedTensor_1.16.0
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] jsonlite_2.0.0      compiler_4.5.1      BiocManager_1.30.26
##  [4] rsvd_1.0.5          Rcpp_1.1.0          rhdf5filters_1.22.0
##  [7] parallel_4.5.1      jquerylib_0.1.4     BiocParallel_1.44.0
## [10] yaml_2.3.10         fastmap_1.2.0       lattice_0.22-7
## [13] R6_2.6.1            XVector_0.50.0      ScaledMatrix_1.18.0
## [16] knitr_1.50          einsum_0.1.2        bookdown_0.45
## [19] bslib_0.9.0         rlang_1.1.6         cachem_1.1.0
## [22] xfun_0.53           sass_0.4.10         cli_3.6.5
## [25] Rhdf5lib_1.32.0     BiocSingular_1.26.0 digest_0.6.37
## [28] grid_4.5.1          irlba_2.3.5.1       rTensor_1.4.9
## [31] dqrng_0.4.1         lifecycle_1.0.4     evaluate_1.0.5
## [34] codetools_0.2-20    beachmat_2.26.0     rmarkdown_2.30
## [37] tools_4.5.1         htmltools_0.5.8.1
```