# Overview of DelayedMatrixStats

Peter Hickey

#### Modified: 06 Feb 2021 Compiled: 29 Oct 2025

# Contents

* [1 Overview](#overview)
* [2 How can DelayedMatrixStats help me?](#how-can-delayedmatrixstats-help-me)
* [3 Supported methods](#supported-methods)
* [4 ‘Seed-aware’ methods](#seed_aware_methods)
* [5 Delayed operations](#delayed-operations)
* [6 Roadmap](#roadmap)
* [7 Session info](#session-info)

# 1 Overview

*[DelayedMatrixStats](https://bioconductor.org/packages/3.22/DelayedMatrixStats)* ports the *[matrixStats](https://CRAN.R-project.org/package%3DmatrixStats)* API
to work with *DelayedMatrix* objects from the *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*
package. It provides high-performing functions operating on rows and columns of
*DelayedMatrix* objects, including all subclasses such as *RleArray* (from the
*[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* package) and *HDF5Array* (from the
*[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)*) as well as supporting all types of *seeds*, such as
*matrix* (from the *base* package) and *Matrix* (from the *[Matrix](https://CRAN.R-project.org/package%3DMatrix)*
package).

# 2 How can DelayedMatrixStats help me?

The *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* package allows developers to store array-like
data using in-memory or on-disk representations (e.g., in HDF5 files) and
provides a common and familiar array-like interface for interacting with these
data.

The *[DelayedMatrixStats](https://bioconductor.org/packages/3.22/DelayedMatrixStats)* package is designed to make life easier
for Bioconductor developers wanting to use *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* by
providing a rich set of column-wise and row-wise summary functions.

We briefly demonstrate and explain these two features using a simple example.
We’ll simulate some (unrealistic) RNA-seq read counts data from 10,000 genes
and 20 samples and store it on disk as a *HDF5Array*:

```
library(DelayedArray)

x <- do.call(cbind, lapply(1:20, function(j) {
  rpois(n = 10000, lambda = sample(20:40, 10000, replace = TRUE))
}))
colnames(x) <- paste0("S", 1:20)
x <- realize(x, "HDF5Array")
x
#> <10000 x 20> HDF5Matrix object of type "integer":
#>           S1  S2  S3  S4 ... S17 S18 S19 S20
#>     [1,]  18  20  20  15   .  38  29  33  41
#>     [2,]  30  39  34  36   .  39  29  33  29
#>     [3,]  19  25  21  27   .  39  43  37  33
#>     [4,]  24  28  23  32   .  24  13  27  23
#>     [5,]  23  26  40  32   .  51  22  32  35
#>      ...   .   .   .   .   .   .   .   .   .
#>  [9996,]  12  40  21  23   .  29  15  21  39
#>  [9997,]  45  22  45  28   .  28  27  22  32
#>  [9998,]  27  32  28  28   .  31  42  42  34
#>  [9999,]  35  18  18  19   .  35  40  26  43
#> [10000,]  24  23  40  37   .  37  29  35  23
```

Suppose you wish to compute the standard deviation of the read counts for each
gene.

You might think to use `apply()` like in the following:

```
system.time(row_sds <- apply(x, 1, sd))
#>    user  system elapsed
#> 196.642   5.332 201.977
head(row_sds)
#> [1] 7.576105 5.766509 7.064366 7.494559 8.312799 9.509552
```

This works, but takes quite a while.

Or perhaps you already know that the *[matrixStats](https://CRAN.R-project.org/package%3DmatrixStats)* package
provides a `rowSds()` function:

```
matrixStats::rowSds(x)
#> Error in rowVars(x, rows = rows, cols = cols, na.rm = na.rm, refine = refine, : Argument 'x' must be a matrix or a vector
```

Unfortunately (and perhaps unsurprisingly) this doesn’t work.
*[matrixStats](https://CRAN.R-project.org/package%3DmatrixStats)* is designed for use on in-memory *matrix* objects.
Well, why don’t we just first realize our data in-memory and then use
*[matrixStats](https://CRAN.R-project.org/package%3DmatrixStats)*

```
system.time(row_sds <- matrixStats::rowSds(as.matrix(x)))
#>    user  system elapsed
#>   0.012   0.000   0.012
head(row_sds)
#> [1] 7.576105 5.766509 7.064366 7.494559 8.312799 9.509552
```

This works and is many times faster than the `apply()`-based approach! However,
it rather defeats the purpose of using a *HDF5Array* for storing the
data since we have to bring all the data into memory at once to compute the
result.

Instead, we can use `DelayedMatrixStats::rowSds()`, which has the speed
benefits of `matrixStats::rowSds()`111 In fact, it currently uses `matrixStats::rowSds()` under the hood. but without having to load the
entire data into memory at once222 In this case, it loads blocks of data row-by-row. The amount of
data loaded into memory at any one time is controlled by the
*default block size* global setting; see `?DelayedArray::getAutoBlockSize`
for details. Notably, if the data are small enough (and the default block size
is large enough) then all the data is loaded as a single block, but this
approach generalizes and still works when the data are too large to be
loaded into memory in one block.:

```
library(DelayedMatrixStats)

system.time(row_sds <- rowSds(x))
#>    user  system elapsed
#>   0.024   0.002   0.025
head(row_sds)
#> [1] 7.576105 5.766509 7.064366 7.494559 8.312799 9.509552
```

Finally, by using *[DelayedMatrixStats](https://bioconductor.org/packages/3.22/DelayedMatrixStats)* we can use the same code,
(`colMedians(x)`) regardless of whether the input is an ordinary *matrix* or a
*DelayedMatrix*. This is useful for packages wishing to support both types of
objects, e.g., packages wanting to retain backward compatibility or during a
transition period from *matrix*-based to *DelayeMatrix*-based objects.

# 3 Supported methods

The initial release of *[DelayedMatrixStats](https://bioconductor.org/packages/3.22/DelayedMatrixStats)* supports the complete
column-wise and row-wise API *[matrixStats](https://CRAN.R-project.org/package%3DmatrixStats)* API333 Some of the API is covered via inheritance to functionality in *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*. Please
see the *[matrixStats](https://CRAN.R-project.org/package%3DmatrixStats)* vignette
([available online](https://cran.r-project.org/package%3DmatrixStats/vignettes/matrixStats-methods.html))
for a summary these methods. The following table documents the API coverage and
availability of [‘seed-aware’ methods](#seed_aware_methods) in the current
version of *[DelayedMatrixStats](https://bioconductor.org/packages/3.22/DelayedMatrixStats)*, where:

* ✔ = Implemented in *[DelayedMatrixStats](https://bioconductor.org/packages/3.22/DelayedMatrixStats)*
* ☑️ = Implemented in [**DelayedArray**](http://bioconductor.org/packages/DelayedArray/) or [**sparseMatrixStats**](http://bioconductor.org/packages/sparseMatrixStats/)
* ❌ = Not yet implemented

| Method | Block processing | *base::matrix* optimized | *Matrix::dgCMatrix* optimized | *Matrix::lgCMatrix* optimized | *DelayedArray::RleArray* (*SolidRleArraySeed*) optimized | *DelayedArray::RleArray* (*ChunkedRleArraySeed*) optimized | *HDF5Array::HDF5Matrix* optimized | *base::data.frame* optimized | *S4Vectors::DataFrame* optimized |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `colAlls()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colAnyMissings()` | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colAnyNAs()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colAnys()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colAvgsPerRowSet()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colCollapse()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colCounts()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colCummaxs()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colCummins()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colCumprods()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colCumsums()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colDiffs()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colIQRDiffs()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colIQRs()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colLogSumExps()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colMadDiffs()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colMads()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colMaxs()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colMeans2()` | ✔ | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ |
| `colMedians()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colMins()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colOrderStats()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colProds()` | ✔ | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ |
| `colQuantiles()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colRanges()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colRanks()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colSdDiffs()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colSds()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colSums2()` | ✔ | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ |
| `colTabulates()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colVarDiffs()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colVars()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colWeightedMads()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colWeightedMeans()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colWeightedMedians()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colWeightedSds()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colWeightedVars()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `colsum()` | ☑️ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowAlls()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowAnyMissings()` | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowAnyNAs()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowAnys()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowAvgsPerColSet()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowCollapse()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowCounts()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowCummaxs()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowCummins()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowCumprods()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowCumsums()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowDiffs()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowIQRDiffs()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowIQRs()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowLogSumExps()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowMadDiffs()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowMads()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowMaxs()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowMeans2()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowMedians()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowMins()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowOrderStats()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowProds()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowQuantiles()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowRanges()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowRanks()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowSdDiffs()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowSds()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowSums2()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowTabulates()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowVarDiffs()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowVars()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowWeightedMads()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowWeightedMeans()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowWeightedMedians()` | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowWeightedSds()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowWeightedVars()` | ✔ | ✔ | ✔ | ✔ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `rowsum()` | ☑️ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |

# 4 ‘Seed-aware’ methods

As well as offering a familiar API, *[DelayedMatrixStats](https://bioconductor.org/packages/3.22/DelayedMatrixStats)* provides
‘seed-aware’ methods that are optimized for specific types of *DelayedMatrix*
objects.

To illustrate this idea, we will compare two ways of computing the column sums
of a *DelayedMatrix* object:

1. The ‘block-processing’ strategy. This was developed in the *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* package and is available for all methods in the *[DelayedMatrixStats](https://bioconductor.org/packages/3.22/DelayedMatrixStats)* through the `force_block_processing` argument
2. The ‘seed-aware’ strategy. This is implemented in the *[DelayedMatrixStats](https://bioconductor.org/packages/3.22/DelayedMatrixStats)* and is optimized for both speed and memory but only for *DelayedMatrix* objects with certain types of *seed*.

We will demonstrate this by computing the column sums matrices with 20,000 rows
and 600 columns where the data have different structure and are stored in
*DelayedMatrix* objects with different types of seed:

* Dense data with values in \((0, 1)\) using an ordinary *matrix* as the seed
* Sparse data with values in \([0, 1)\), where \(60\%\) are zeros, using a *dgCMatrix*, a sparse matrix representation from the *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* package, as the seed
* Dense data in \({0, 1, \ldots, 100}\), where there are multiple runs of identical values, using a *RleArraySeed* from the *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* package as the seed

We use the *[microbenchmark](https://CRAN.R-project.org/package%3Dmicrobenchmark)* package to measure running time and
the *[profmem](https://CRAN.R-project.org/package%3Dprofmem)* package to measure the total memory allocations of
each method.

In each case, the ‘seed-aware’ method is many times faster and allocates
substantially lower total memory.

```
library(DelayedMatrixStats)
library(sparseMatrixStats)
library(microbenchmark)
library(profmem)

set.seed(666)

# -----------------------------------------------------------------------------
# Dense with values in (0, 1)
# Fast, memory-efficient column sums of DelayedMatrix with ordinary matrix seed
#

# Generate some data
dense_matrix <- matrix(runif(20000 * 600),
                       nrow = 20000,
                       ncol = 600)

# Benchmark
dm_matrix <- DelayedArray(dense_matrix)
class(seed(dm_matrix))
#> [1] "matrix" "array"
dm_matrix
#> <20000 x 600> DelayedMatrix object of type "double":
#>                [,1]       [,2]       [,3] ...     [,599]     [,600]
#>     [1,]  0.7743685  0.6601787  0.4098798   . 0.89118118 0.05776471
#>     [2,]  0.1972242  0.8436035  0.9198450   . 0.31799523 0.63099417
#>     [3,]  0.9780138  0.2017589  0.4696158   . 0.31783791 0.02830454
#>     [4,]  0.2013274  0.8797239  0.6474768   . 0.55217184 0.09678816
#>     [5,]  0.3612444  0.8158778  0.5928599   . 0.08530977 0.39224147
#>      ...          .          .          .   .          .          .
#> [19996,] 0.19490291 0.07763570 0.56391725   . 0.09703424 0.62659353
#> [19997,] 0.61182993 0.01910121 0.04046034   . 0.59708388 0.88389731
#> [19998,] 0.12932744 0.21155070 0.19344085   . 0.51682032 0.13378223
#> [19999,] 0.18985573 0.41716539 0.35110782   . 0.62939661 0.94601427
#> [20000,] 0.87889047 0.25308041 0.54666920   . 0.81630322 0.73272217
microbenchmark(
  block_processing = colSums2(dm_matrix, force_block_processing = TRUE),
  seed_aware = colSums2(dm_matrix),
  times = 10)
#> Unit: milliseconds
#>              expr       min        lq      mean    median       uq       max
#>  block_processing 107.62798 109.75721 202.55382 116.11957 118.8314 559.57931
#>        seed_aware  20.84551  20.88884  21.38632  20.98801  21.4253  23.76621
#>  neval cld
#>     10  a
#>     10   b
total(profmem(colSums2(dm_matrix, force_block_processing = TRUE)))
#> Error in profmem_begin(threshold = threshold): Profiling of memory allocations is not supported on this R system (capabilities('profmem') reports FALSE). See help('tracemem'). To enable memory profiling for R on Linux, R needs to be configured and built using './configure --enable-memory-profiling'.
total(profmem(colSums2(dm_matrix)))
#> Error in profmem_begin(threshold = threshold): Profiling of memory allocations is not supported on this R system (capabilities('profmem') reports FALSE). See help('tracemem'). To enable memory profiling for R on Linux, R needs to be configured and built using './configure --enable-memory-profiling'.

# -----------------------------------------------------------------------------
# Sparse (60% zero) with values in (0, 1)
# Fast, memory-efficient column sums of DelayedMatrix with ordinary matrix seed
#

# Generate some data
sparse_matrix <- dense_matrix
zero_idx <- sample(length(sparse_matrix), 0.6 * length(sparse_matrix))
sparse_matrix[zero_idx] <- 0

# Benchmark
dm_dgCMatrix <- DelayedArray(Matrix(sparse_matrix, sparse = TRUE))
class(seed(dm_dgCMatrix))
#> [1] "dgCMatrix"
#> attr(,"package")
#> [1] "Matrix"
dm_dgCMatrix
#> <20000 x 600> sparse DelayedMatrix object of type "double":
#>               [,1]      [,2]      [,3] ...     [,599]     [,600]
#>     [1,] 0.7743685 0.0000000 0.0000000   . 0.89118118 0.00000000
#>     [2,] 0.1972242 0.0000000 0.9198450   . 0.00000000 0.00000000
#>     [3,] 0.9780138 0.0000000 0.4696158   . 0.31783791 0.00000000
#>     [4,] 0.0000000 0.8797239 0.6474768   . 0.55217184 0.00000000
#>     [5,] 0.3612444 0.0000000 0.0000000   . 0.08530977 0.39224147
#>      ...         .         .         .   .          .          .
#> [19996,] 0.1949029 0.0776357 0.0000000   . 0.09703424 0.00000000
#> [19997,] 0.0000000 0.0000000 0.0000000   . 0.00000000 0.88389731
#> [19998,] 0.0000000 0.2115507 0.1934408   . 0.00000000 0.00000000
#> [19999,] 0.1898557 0.0000000 0.3511078   . 0.62939661 0.94601427
#> [20000,] 0.8788905 0.2530804 0.0000000   . 0.00000000 0.73272217
microbenchmark(
  block_processing = colSums2(dm_dgCMatrix, force_block_processing = TRUE),
  seed_aware = colSums2(dm_dgCMatrix),
  times = 10)
#> Unit: milliseconds
#>              expr       min        lq     mean    median        uq       max
#>  block_processing 135.20733 153.09849 278.9605 161.01429 552.98275 582.11659
#>        seed_aware  18.22172  18.22648  18.2747  18.24303  18.28872  18.46655
#>  neval cld
#>     10  a
#>     10   b
total(profmem(colSums2(dm_dgCMatrix, force_block_processing = TRUE)))
#> Error in profmem_begin(threshold = threshold): Profiling of memory allocations is not supported on this R system (capabilities('profmem') reports FALSE). See help('tracemem'). To enable memory profiling for R on Linux, R needs to be configured and built using './configure --enable-memory-profiling'.
total(profmem(colSums2(dm_dgCMatrix)))
#> Error in profmem_begin(threshold = threshold): Profiling of memory allocations is not supported on this R system (capabilities('profmem') reports FALSE). See help('tracemem'). To enable memory profiling for R on Linux, R needs to be configured and built using './configure --enable-memory-profiling'.

# -----------------------------------------------------------------------------
# Dense with values in {0, 100} featuring runs of identical values
# Fast, memory-efficient column sums of DelayedMatrix with Rle-based seed
#

# Generate some data
runs <- rep(sample(100, 500000, replace = TRUE), rpois(500000, 100))
runs <- runs[seq_len(20000 * 600)]
runs_matrix <- matrix(runs,
                      nrow = 20000,
                      ncol = 600)

# Benchmark
dm_rle <- RleArray(Rle(runs),
                   dim = c(20000, 600))
class(seed(dm_rle))
#> [1] "SolidRleArraySeed"
#> attr(,"package")
#> [1] "DelayedArray"
dm_rle
#> <20000 x 600> RleMatrix object of type "integer":
#>            [,1]   [,2]   [,3]   [,4] ... [,597] [,598] [,599] [,600]
#>     [1,]     20     65      9     50   .     43     74     85     14
#>     [2,]     20     65      9     50   .     43     74     85     14
#>     [3,]     20     65      9     50   .     43     74     85     14
#>     [4,]     20     65      9     50   .     43     74     85     14
#>     [5,]     20     65      9     50   .     43     74     85     14
#>      ...      .      .      .      .   .      .      .      .      .
#> [19996,]     65      9     50     16   .     74     85     14     55
#> [19997,]     65      9     50     16   .     74     85     14     55
#> [19998,]     65      9     50     16   .     74     85     14     55
#> [19999,]     65      9     50     16   .     74     85     14     55
#> [20000,]     65      9     50     16   .     74     85     14     55
microbenchmark(
  block_processing = colSums2(dm_rle, force_block_processing = TRUE),
  seed_aware = colSums2(dm_rle),
  times = 10)
#> Unit: milliseconds
#>              expr       min         lq       mean     median         uq
#>  block_processing 768.12365 769.063248 776.966603 774.967175 783.780680
#>        seed_aware   4.39434   4.557577   6.191187   4.789479   5.279195
#>        max neval cld
#>  790.51011    10  a
#>   18.58635    10   b
total(profmem(colSums2(dm_rle, force_block_processing = TRUE)))
#> Error in profmem_begin(threshold = threshold): Profiling of memory allocations is not supported on this R system (capabilities('profmem') reports FALSE). See help('tracemem'). To enable memory profiling for R on Linux, R needs to be configured and built using './configure --enable-memory-profiling'.
total(profmem(colSums2(dm_rle)))
#> Error in profmem_begin(threshold = threshold): Profiling of memory allocations is not supported on this R system (capabilities('profmem') reports FALSE). See help('tracemem'). To enable memory profiling for R on Linux, R needs to be configured and built using './configure --enable-memory-profiling'.
```

The development of ‘seed-aware’ methods is ongoing work (see the [Roadmap](#roadmap)), and for now only a few methods and seed-types have a
‘seed-aware’ method.

An extensive set of benchmarks is under development at <http://peterhickey.org/BenchmarkingDelayedMatrixStats/>.

# 5 Delayed operations

A key feature of a *DelayedArray* is the ability to register ‘delayed
operations’. For example, let’s compute `sin(dm_matrix)`:

```
system.time(sin_dm_matrix <- sin(dm_matrix))
#>    user  system elapsed
#>   0.005   0.000   0.005
```

This instantaneous because the operation is not actually performed, rather
it is registered and only performed when the object is *realized*. All methods
in *[DelayedMatrixStats](https://bioconductor.org/packages/3.22/DelayedMatrixStats)* will correctly realise these delayed
operations before computing the final result. For example, let’s compute
`colSums2(sin_dm_matrix)` and compare check we get the correct answer:

```
all.equal(colSums2(sin_dm_matrix), colSums(sin(as.matrix(dm_matrix))))
#> [1] TRUE
```

# 6 Roadmap

The initial version of *[DelayedMatrixStats](https://bioconductor.org/packages/3.22/DelayedMatrixStats)* provides complete
coverage of the *[matrixStats](https://CRAN.R-project.org/package%3DmatrixStats)* column-wise and row-wise API444 Some of the API is covered via inheritance to functionality in *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*,
allowing package developers to use these functions with *DelayedMatrix* objects
as well as with ordinary *matrix* objects. This should simplify package
development and assist authors to support to their software for large datasets
stored in disk-backed data structures such as *HDF5Array*. Such large datasets
are increasingly common with the rise of single-cell genomics.

Future releases of *[DelayedMatrixStats](https://bioconductor.org/packages/3.22/DelayedMatrixStats)* will improve the
performance of these methods, specifically by developing additional ‘seed-aware’
methods. The plan is to prioritise commonly used methods (e.g.,
`colMeans2()`/`rowMeans2()`, `colSums2()`/`rowSums2()`, etc.) and the
development of ‘seed-aware’ methods for the *HDF5Matrix* class. To do so, we
will leverage the *[beachmat](https://bioconductor.org/packages/3.22/beachmat)* package. Proof-of-concept code
has shown that this can greatly increase the performance when analysing such
disk-backed data.

Importantly, all package developers using methods from
*[DelayedMatrixStats](https://bioconductor.org/packages/3.22/DelayedMatrixStats)* will immediately gain from performance
improvements to these low-level routines. By using
*[DelayedMatrixStats](https://bioconductor.org/packages/3.22/DelayedMatrixStats)*, package developers will be able to focus on
higher level programming tasks and address important scientific questions and
technological challenges in high-throughput biology.

# 7 Session info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] profmem_0.7.0             microbenchmark_1.5.0
#>  [3] sparseMatrixStats_1.22.0  DelayedMatrixStats_1.32.0
#>  [5] DelayedArray_0.36.0       SparseArray_1.10.0
#>  [7] S4Arrays_1.10.0           abind_1.4-8
#>  [9] IRanges_2.44.0            S4Vectors_0.48.0
#> [11] MatrixGenerics_1.22.0     matrixStats_1.5.0
#> [13] BiocGenerics_0.56.0       generics_0.1.4
#> [15] Matrix_1.7-4              BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] jsonlite_2.0.0      compiler_4.5.1      BiocManager_1.30.26
#>  [4] Rcpp_1.1.0          rhdf5filters_1.22.0 jquerylib_0.1.4
#>  [7] splines_4.5.1       yaml_2.3.10         fastmap_1.2.0
#> [10] TH.data_1.1-4       lattice_0.22-7      R6_2.6.1
#> [13] XVector_0.50.0      knitr_1.50          MASS_7.3-65
#> [16] bookdown_0.45       h5mread_1.2.0       bslib_0.9.0
#> [19] rlang_1.1.6         multcomp_1.4-29     cachem_1.1.0
#> [22] HDF5Array_1.38.0    xfun_0.53           sass_0.4.10
#> [25] cli_3.6.5           Rhdf5lib_1.32.0     digest_0.6.37
#> [28] grid_4.5.1          mvtnorm_1.3-3       sandwich_3.1-1
#> [31] rhdf5_2.54.0        lifecycle_1.0.4     evaluate_1.0.5
#> [34] codetools_0.2-20    zoo_1.8-14          survival_3.8-3
#> [37] rmarkdown_2.30      tools_4.5.1         htmltools_0.5.8.1
```