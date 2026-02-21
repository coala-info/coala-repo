# 3. Tensor decomposition by DelayedTensor

Koki Tsuyuzaki1 and Itoshi Nikaido1\*

1Laboratory for Bioinformatics Research, RIKEN Center for Biosystems Dynamics Research

\*k.t.the-answer@hotmail.co.jp

#### 29 October 2025

#### Package

DelayedTensor 1.16.0

**Authors**: Koki Tsuyuzaki [aut, cre]
**Last modified:** 2025-10-29 20:12:10.36772
**Compiled**: Wed Oct 29 23:33:13 2025

# 1 Setting

```
suppressPackageStartupMessages(library("DelayedTensor"))
suppressPackageStartupMessages(library("DelayedArray"))
suppressPackageStartupMessages(library("HDF5Array"))
suppressPackageStartupMessages(library("DelayedRandomArray"))

darr <- RandomUnifArray(c(3,4,5))

setVerbose(FALSE)
setSparse(FALSE)
setAutoBlockSize(1E+8)
```

```
## automatic block size set to 1e+08 bytes (was 1e+08)
```

```
tmpdir <- tempdir()
setHDF5DumpDir(tmpdir)
```

# 2 Tensor Decomposition

Tensor decomposition models decompose multiple factor matrices and core tensor.
Each factor matrix means the patterns of each mode
and is used for the visualization and the downstream analysis.
Core tensor means the intensity of the patterns
and is used to decide which patterns are informative.

We reimplemented some of the tensor decomposition functions of
*[rTensor](https://CRAN.R-project.org/package%3DrTensor)* using block processing of
*[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*.

Only tensor decomposition algorithms and utility functions that require
Fast Fourier Transform (e.g., `t_mult`, `t_svd`, and `t_svd_reconstruct`)
are exceptions and have not yet been implemented in *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*
because we are still investigating how to calculate them with
out-of-core manner.

## 2.1 Tucker Decomposition

Suppose a tensor \(\mathcal{X} \in \Re^{I \times J \times K}\).
Tucker decomposition models decomposes a tensor \(\mathcal{X}\) into a core tensor
\(\mathcal{G} \in \Re^{p \times q \times r}\),
and multiple factor matrices \(A \in \Re^{I \times p}\),
\(B \in \Re^{J \times q}\), and \(C \in \Re^{K \times r}\)
(\(p \leq I, q \leq J, \textrm{and}\ r \leq K\)).

\[
\mathcal{X} = \mathcal{G} \times\_{1} A \times\_{2} B \times\_{3} C
\]

For simplicity, here we will use a third-order tensor
but the Tucker decomposition can be applied to tensors of larger orders.

There are well-known two algorithms;
Higher-Order Singular Value Decomposition (HOSVD) and
Higher-order Orthogonal Iteration (HOOI).

`hosvd` performs the HOSVD Tucker decomposition
and `tucker` performs HOOI Tucker decomposition.

For the details, check the `hosvd` and `tucker` functions of
*[rTensor](https://CRAN.R-project.org/package%3DrTensor)*.

```
out_hosvd <- hosvd(darr, ranks=c(2,1,3))
```

```
##
  |
  |                                                                      |   0%
  |
  |=======================                                               |  33%
  |
  |===============================================                       |  67%
  |
  |======================================================================| 100%
```

```
str(out_hosvd)
```

```
## List of 4
##  $ Z          :Formal class 'DelayedArray' [package "DelayedArray"] with 1 slot
##   .. ..@ seed:Formal class 'HDF5ArraySeed' [package "HDF5Array"] with 7 slots
##   .. .. .. ..@ filepath : chr "/tmp/RtmpmpQjeh/autofa574ea77523.h5"
##   .. .. .. ..@ name     : chr "/HDF5ArrayAUTO00125"
##   .. .. .. ..@ as_sparse: logi FALSE
##   .. .. .. ..@ type     : chr NA
##   .. .. .. ..@ dim      : int [1:3] 2 1 3
##   .. .. .. ..@ chunkdim : int [1:3] 2 1 3
##   .. .. .. ..@ first_val: num -3.86
##  $ U          :List of 3
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed: num [1:3, 1:2] -0.584 -0.597 -0.55 0.575 -0.782 ...
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed: num [1:4, 1] -0.57 -0.47 -0.447 -0.504
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed: num [1:5, 1:3] -0.471 -0.374 -0.535 -0.36 -0.472 ...
##  $ est        :Formal class 'DelayedArray' [package "DelayedArray"] with 1 slot
##   .. ..@ seed:Formal class 'HDF5ArraySeed' [package "HDF5Array"] with 7 slots
##   .. .. .. ..@ filepath : chr "/tmp/RtmpmpQjeh/autofa57b33003.h5"
##   .. .. .. ..@ name     : chr "/HDF5ArrayAUTO00142"
##   .. .. .. ..@ as_sparse: logi FALSE
##   .. .. .. ..@ type     : chr NA
##   .. .. .. ..@ dim      : int [1:3] 3 4 5
##   .. .. .. ..@ chunkdim : int [1:3] 3 4 5
##   .. .. .. ..@ first_val: num 0.605
##  $ fnorm_resid: num 1.99
```

```
out_tucker <- tucker(darr, ranks=c(2,3,2))
```

```
##
  |
  |                                                                      |   0%
  |
  |===                                                                   |   4%
  |
  |======                                                                |   8%
  |
  |========                                                              |  12%
  |
  |===========                                                           |  16%
  |
  |==============                                                        |  20%
  |
  |=================                                                     |  24%
  |
  |======================================================================| 100%
```

```
str(out_tucker)
```

```
## List of 7
##  $ Z           :Formal class 'DelayedArray' [package "DelayedArray"] with 1 slot
##   .. ..@ seed:Formal class 'HDF5ArraySeed' [package "HDF5Array"] with 7 slots
##   .. .. .. ..@ filepath : chr "/tmp/RtmpmpQjeh/autofa5750f8ebd7.h5"
##   .. .. .. ..@ name     : chr "/HDF5ArrayAUTO00509"
##   .. .. .. ..@ as_sparse: logi FALSE
##   .. .. .. ..@ type     : chr NA
##   .. .. .. ..@ dim      : int [1:3] 2 3 2
##   .. .. .. ..@ chunkdim : int [1:3] 2 3 2
##   .. .. .. ..@ first_val: num 3.86
##  $ U           :List of 3
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed: num [1:3, 1:2] -0.575 -0.609 -0.547 0.342 -0.786 ...
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed: num [1:4, 1:3] -0.574 -0.472 -0.45 -0.495 -0.267 ...
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed: num [1:5, 1:2] 0.486 0.375 0.53 0.359 0.461 ...
##  $ conv        : logi TRUE
##  $ est         :Formal class 'DelayedArray' [package "DelayedArray"] with 1 slot
##   .. ..@ seed:Formal class 'HDF5ArraySeed' [package "HDF5Array"] with 7 slots
##   .. .. .. ..@ filepath : chr "/tmp/RtmpmpQjeh/autofa57141f2044.h5"
##   .. .. .. ..@ name     : chr "/HDF5ArrayAUTO00543"
##   .. .. .. ..@ as_sparse: logi FALSE
##   .. .. .. ..@ type     : chr NA
##   .. .. .. ..@ dim      : int [1:3] 3 4 5
##   .. .. .. ..@ chunkdim : int [1:3] 3 4 5
##   .. .. .. ..@ first_val: num 0.534
##  $ norm_percent: num 64.3
##  $ fnorm_resid : num 1.56
##  $ all_resids  : num [1:6] 1.57 1.57 1.56 1.56 1.56 ...
```

## 2.2 CANDECOMP/PARAFAC (CP) Decomposition

Suppose a tensor \(\mathcal{X} \in \Re^{I \times J \times K}\).
CP decomposition models decomposes a tensor \(X\) into a core diagonal tensor
\(\mathcal{G} \in \Re^{r \times r \times r}\),
and multiple factor matrices \(A \in \Re^{I \times r}\),
\(B \in \Re^{J \times r}\), and \(C \in \Re^{K \times r}\)
(\(r \leq \min{\left(I,J,K\right)}\)).

\[
\mathcal{X} = \mathcal{G} \times\_{1} A \times\_{2} B \times\_{3} C
\]

For simplicity, here we will use a third-order tensor
but the CP decomposition can be applied to tensors of larger orders.

Alternating least squares (ALS) is a well-known algorithm for CP decomposition
and `cp` performs the ALS CP decomposition.

For the details, check the `cp` function of *[rTensor](https://CRAN.R-project.org/package%3DrTensor)*.

```
out_cp <- cp(darr, num_components=2)
```

```
##
  |
  |                                                                      |   0%
  |
  |===                                                                   |   4%
  |
  |======                                                                |   8%
  |
  |========                                                              |  12%
  |
  |===========                                                           |  16%
  |
  |==============                                                        |  20%
  |
  |=================                                                     |  24%
  |
  |====================                                                  |  28%
  |
  |======================                                                |  32%
  |
  |=========================                                             |  36%
  |
  |============================                                          |  40%
  |
  |===============================                                       |  44%
  |
  |==================================                                    |  48%
  |
  |====================================                                  |  52%
  |
  |=======================================                               |  56%
  |
  |==========================================                            |  60%
  |
  |=============================================                         |  64%
  |
  |================================================                      |  68%
  |
  |==================================================                    |  72%
  |
  |=====================================================                 |  76%
  |
  |========================================================              |  80%
  |
  |===========================================================           |  84%
  |
  |==============================================================        |  88%
  |
  |================================================================      |  92%
  |
  |===================================================================   |  96%
  |
  |======================================================================| 100%
```

```
str(out_cp)
```

```
## List of 7
##  $ lambdas     : num [1:2] 29.22 6.25
##  $ U           :List of 3
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed:Formal class 'DelayedAperm' [package "DelayedArray"] with 2 slots
##   .. .. .. .. ..@ perm: int [1:2] 2 1
##   .. .. .. .. ..@ seed:Formal class 'DelayedUnaryIsoOpWithArgs' [package "DelayedArray"] with 6 slots
##   .. .. .. .. .. .. ..@ OP    :function (e1, e2)
##   .. .. .. .. .. .. ..@ Largs : list()
##   .. .. .. .. .. .. ..@ Rargs :List of 1
##   .. .. .. .. .. .. .. ..$ : num [1:2] 29.29 6.04
##   .. .. .. .. .. .. ..@ Lalong: int(0)
##   .. .. .. .. .. .. ..@ Ralong: int 1
##   .. .. .. .. .. .. ..@ seed  :Formal class 'DelayedAperm' [package "DelayedArray"] with 2 slots
##   .. .. .. .. .. .. .. .. ..@ perm: int [1:2] 2 1
##   .. .. .. .. .. .. .. .. ..@ seed:Formal class 'HDF5ArraySeed' [package "HDF5Array"] with 7 slots
##   .. .. .. .. .. .. .. .. .. .. ..@ filepath : chr "/tmp/RtmpmpQjeh/autofa574ed44c0b.h5"
##   .. .. .. .. .. .. .. .. .. .. ..@ name     : chr "/HDF5ArrayAUTO02142"
##   .. .. .. .. .. .. .. .. .. .. ..@ as_sparse: logi FALSE
##   .. .. .. .. .. .. .. .. .. .. ..@ type     : chr NA
##   .. .. .. .. .. .. .. .. .. .. ..@ dim      : int [1:2] 3 2
##   .. .. .. .. .. .. .. .. .. .. ..@ chunkdim : int [1:2] 3 2
##   .. .. .. .. .. .. .. .. .. .. ..@ first_val: num 9.72
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed:Formal class 'DelayedAperm' [package "DelayedArray"] with 2 slots
##   .. .. .. .. ..@ perm: int [1:2] 2 1
##   .. .. .. .. ..@ seed:Formal class 'DelayedUnaryIsoOpWithArgs' [package "DelayedArray"] with 6 slots
##   .. .. .. .. .. .. ..@ OP    :function (e1, e2)
##   .. .. .. .. .. .. ..@ Largs : list()
##   .. .. .. .. .. .. ..@ Rargs :List of 1
##   .. .. .. .. .. .. .. ..$ : num [1:2] 29.28 5.88
##   .. .. .. .. .. .. ..@ Lalong: int(0)
##   .. .. .. .. .. .. ..@ Ralong: int 1
##   .. .. .. .. .. .. ..@ seed  :Formal class 'DelayedAperm' [package "DelayedArray"] with 2 slots
##   .. .. .. .. .. .. .. .. ..@ perm: int [1:2] 2 1
##   .. .. .. .. .. .. .. .. ..@ seed:Formal class 'HDF5ArraySeed' [package "HDF5Array"] with 7 slots
##   .. .. .. .. .. .. .. .. .. .. ..@ filepath : chr "/tmp/RtmpmpQjeh/autofa572054d662.h5"
##   .. .. .. .. .. .. .. .. .. .. ..@ name     : chr "/HDF5ArrayAUTO02165"
##   .. .. .. .. .. .. .. .. .. .. ..@ as_sparse: logi FALSE
##   .. .. .. .. .. .. .. .. .. .. ..@ type     : chr NA
##   .. .. .. .. .. .. .. .. .. .. ..@ dim      : int [1:2] 4 2
##   .. .. .. .. .. .. .. .. .. .. ..@ chunkdim : int [1:2] 4 2
##   .. .. .. .. .. .. .. .. .. .. ..@ first_val: num -8.44
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed:Formal class 'DelayedAperm' [package "DelayedArray"] with 2 slots
##   .. .. .. .. ..@ perm: int [1:2] 2 1
##   .. .. .. .. ..@ seed:Formal class 'DelayedUnaryIsoOpWithArgs' [package "DelayedArray"] with 6 slots
##   .. .. .. .. .. .. ..@ OP    :function (e1, e2)
##   .. .. .. .. .. .. ..@ Largs : list()
##   .. .. .. .. .. .. ..@ Rargs :List of 1
##   .. .. .. .. .. .. .. ..$ : num [1:2] 29.22 6.25
##   .. .. .. .. .. .. ..@ Lalong: int(0)
##   .. .. .. .. .. .. ..@ Ralong: int 1
##   .. .. .. .. .. .. ..@ seed  :Formal class 'DelayedAperm' [package "DelayedArray"] with 2 slots
##   .. .. .. .. .. .. .. .. ..@ perm: int [1:2] 2 1
##   .. .. .. .. .. .. .. .. ..@ seed:Formal class 'HDF5ArraySeed' [package "HDF5Array"] with 7 slots
##   .. .. .. .. .. .. .. .. .. .. ..@ filepath : chr "/tmp/RtmpmpQjeh/autofa5719d2343.h5"
##   .. .. .. .. .. .. .. .. .. .. ..@ name     : chr "/HDF5ArrayAUTO02188"
##   .. .. .. .. .. .. .. .. .. .. ..@ as_sparse: logi FALSE
##   .. .. .. .. .. .. .. .. .. .. ..@ type     : chr NA
##   .. .. .. .. .. .. .. .. .. .. ..@ dim      : int [1:2] 5 2
##   .. .. .. .. .. .. .. .. .. .. ..@ chunkdim : int [1:2] 5 2
##   .. .. .. .. .. .. .. .. .. .. ..@ first_val: num -6.01
##  $ conv        : logi FALSE
##  $ est         :Formal class 'DelayedArray' [package "DelayedArray"] with 1 slot
##   .. ..@ seed:Formal class 'HDF5ArraySeed' [package "HDF5Array"] with 7 slots
##   .. .. .. ..@ filepath : chr "/tmp/RtmpmpQjeh/autofa574648b237.h5"
##   .. .. .. ..@ name     : chr "/HDF5ArrayAUTO02205"
##   .. .. .. ..@ as_sparse: logi FALSE
##   .. .. .. ..@ type     : chr NA
##   .. .. .. ..@ dim      : int [1:3] 3 4 5
##   .. .. .. ..@ chunkdim : int [1:3] 3 4 5
##   .. .. .. ..@ first_val: num 0.432
##  $ norm_percent: num 62
##  $ fnorm_resid : num 1.66
##  $ all_resids  : num [1:24] 2.17 1.95 1.93 1.92 1.89 ...
```

## 2.3 Multilinear Principal Component Analysis (MPCA)

MPCA is a kind of Tucker decomposition and when the order of tensor is 3,
this is also known as the
Generalized Low-Rank Approximation of Matrices (GLRAM).
For the details, check the `mpca` function of *[rTensor](https://CRAN.R-project.org/package%3DrTensor)*.

```
out_mpca <- mpca(darr, ranks=c(2,2))
```

```
##
  |
  |                                                                      |   0%
  |
  |===                                                                   |   4%
  |
  |======                                                                |   8%
  |
  |======================================================================| 100%
```

```
str(out_mpca)
```

```
## List of 7
##  $ Z_ext       :Formal class 'DelayedArray' [package "DelayedArray"] with 1 slot
##   .. ..@ seed:Formal class 'HDF5ArraySeed' [package "HDF5Array"] with 7 slots
##   .. .. .. ..@ filepath : chr "/tmp/RtmpmpQjeh/autofa571ff5479a.h5"
##   .. .. .. ..@ name     : chr "/HDF5ArrayAUTO02275"
##   .. .. .. ..@ as_sparse: logi FALSE
##   .. .. .. ..@ type     : chr NA
##   .. .. .. ..@ dim      : int [1:3] 2 2 5
##   .. .. .. ..@ chunkdim : int [1:3] 2 2 5
##   .. .. .. ..@ first_val: num 1.81
##  $ U           :List of 3
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed: num [1:3, 1:2] -0.574 -0.607 -0.549 0.455 -0.795 ...
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed: num [1:4, 1:2] -0.57 -0.477 -0.449 -0.496 0.342 ...
##   ..$ : NULL
##  $ conv        : logi TRUE
##  $ est         :Formal class 'DelayedArray' [package "DelayedArray"] with 1 slot
##   .. ..@ seed:Formal class 'HDF5ArraySeed' [package "HDF5Array"] with 7 slots
##   .. .. .. ..@ filepath : chr "/tmp/RtmpmpQjeh/autofa5712d12094.h5"
##   .. .. .. ..@ name     : chr "/HDF5ArrayAUTO02297"
##   .. .. .. ..@ as_sparse: logi FALSE
##   .. .. .. ..@ type     : chr NA
##   .. .. .. ..@ dim      : int [1:3] 3 4 5
##   .. .. .. ..@ chunkdim : int [1:3] 3 4 5
##   .. .. .. ..@ first_val: num 0.517
##  $ norm_percent: num 65.2
##  $ fnorm_resid : num 1.52
##  $ all_resids  : num [1:2] 1.52 1.52
```

## 2.4 Population Value Decomposition (PVD)

Suppose a series of 2D data X\_{j}, where \(X\_{j} \in \Re^{n\_{1} \times n\_{2}}\),
and \(j = 1, \ldots , n\_{3}\).
PVD models decomposes a tensor \(X\_{j}\)
into two common factor matrices across all \(X\_{j}\),
\(P \in \Re^{n\_{1} \times r\_{1}}\) and \(D \in \Re^{n\_{2} \times r\_{2}}\),
and a \(X\_{j}\) specific factor matrix \(V\_{j} \in \Re^{r\_{1} \times r\_{2}}\)
(\(r\_{1} \leq n\_{1}, \textrm{and}\ r\_{2} \leq n\_{2}\)).

\[
X\_{j} = P \times V\_{j} \times D
\]

For the details, check the `pvd` function of *[rTensor](https://CRAN.R-project.org/package%3DrTensor)*.

```
out_pvd <- pvd(darr,
  uranks=rep(2,dim(darr)[3]), wranks=rep(3,dim(darr)[3]), a=2, b=3)
```

```
##
  |
  |                                                                      |   0%
  |
  |=========                                                             |  12%
  |
  |==================                                                    |  25%
  |
  |==========================                                            |  38%
  |
  |===================================                                   |  50%
  |
  |============================================                          |  62%
  |
  |====================================================                  |  75%
  |
  |=============================================================         |  88%
  |
  |======================================================================| 100%
```

```
str(out_pvd)
```

```
## List of 6
##  $ P           :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. ..@ seed: num [1:3, 1:2] -0.516 -0.638 -0.572 0.599 -0.746 ...
##  $ D           :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. ..@ seed:Formal class 'DelayedAperm' [package "DelayedArray"] with 2 slots
##   .. .. .. ..@ perm: int [1:2] 2 1
##   .. .. .. ..@ seed: num [1:4, 1:3] 0.104 0.547 0.72 0.415 0.917 ...
##  $ V           :List of 5
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed:Formal class 'HDF5ArraySeed' [package "HDF5Array"] with 7 slots
##   .. .. .. .. ..@ filepath : chr "/tmp/RtmpmpQjeh/autofa57106cf20b.h5"
##   .. .. .. .. ..@ name     : chr "/HDF5ArrayAUTO02331"
##   .. .. .. .. ..@ as_sparse: logi FALSE
##   .. .. .. .. ..@ type     : chr NA
##   .. .. .. .. ..@ dim      : int [1:2] 2 3
##   .. .. .. .. ..@ chunkdim : int [1:2] 2 3
##   .. .. .. .. ..@ first_val: num -1.59
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed:Formal class 'HDF5ArraySeed' [package "HDF5Array"] with 7 slots
##   .. .. .. .. ..@ filepath : chr "/tmp/RtmpmpQjeh/autofa571af2e71b.h5"
##   .. .. .. .. ..@ name     : chr "/HDF5ArrayAUTO02337"
##   .. .. .. .. ..@ as_sparse: logi FALSE
##   .. .. .. .. ..@ type     : chr NA
##   .. .. .. .. ..@ dim      : int [1:2] 2 3
##   .. .. .. .. ..@ chunkdim : int [1:2] 2 3
##   .. .. .. .. ..@ first_val: num -1.05
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed:Formal class 'HDF5ArraySeed' [package "HDF5Array"] with 7 slots
##   .. .. .. .. ..@ filepath : chr "/tmp/RtmpmpQjeh/autofa5774cc9797.h5"
##   .. .. .. .. ..@ name     : chr "/HDF5ArrayAUTO02343"
##   .. .. .. .. ..@ as_sparse: logi FALSE
##   .. .. .. .. ..@ type     : chr NA
##   .. .. .. .. ..@ dim      : int [1:2] 2 3
##   .. .. .. .. ..@ chunkdim : int [1:2] 2 3
##   .. .. .. .. ..@ first_val: num -1.68
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed:Formal class 'HDF5ArraySeed' [package "HDF5Array"] with 7 slots
##   .. .. .. .. ..@ filepath : chr "/tmp/RtmpmpQjeh/autofa5720e6010f.h5"
##   .. .. .. .. ..@ name     : chr "/HDF5ArrayAUTO02349"
##   .. .. .. .. ..@ as_sparse: logi FALSE
##   .. .. .. .. ..@ type     : chr NA
##   .. .. .. .. ..@ dim      : int [1:2] 2 3
##   .. .. .. .. ..@ chunkdim : int [1:2] 2 3
##   .. .. .. .. ..@ first_val: num -1.32
##   ..$ :Formal class 'DelayedMatrix' [package "DelayedArray"] with 1 slot
##   .. .. ..@ seed:Formal class 'HDF5ArraySeed' [package "HDF5Array"] with 7 slots
##   .. .. .. .. ..@ filepath : chr "/tmp/RtmpmpQjeh/autofa576a7eaf09.h5"
##   .. .. .. .. ..@ name     : chr "/HDF5ArrayAUTO02355"
##   .. .. .. .. ..@ as_sparse: logi FALSE
##   .. .. .. .. ..@ type     : chr NA
##   .. .. .. .. ..@ dim      : int [1:2] 2 3
##   .. .. .. .. ..@ chunkdim : int [1:2] 2 3
##   .. .. .. .. ..@ first_val: num -1.66
##  $ est         :Formal class 'DelayedArray' [package "DelayedArray"] with 1 slot
##   .. ..@ seed: num [1:3, 1:4, 1:5] 0.413 0.646 0.492 0.432 1.037 ...
##  $ norm_percent: num 67.5
##  $ fnorm_resid : num 1.42
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