# sparseMatrixStats

Constantin Ahlmann-Eltze

#### 2025-10-30

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
  + [2.1 Alternative Matrix Creation](#alternative-matrix-creation)
* [3 Benchmark](#benchmark)
* [4 Session Info](#session-info)

# 1 Installation

You can install the release version of *[sparseMatrixStats](https://bioconductor.org/packages/3.22/sparseMatrixStats)* from BioConductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("sparseMatrixStats")
```

# 2 Introduction

The sparseMatrixStats package implements a number of summary functions for sparse matrices from the *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* package.

Let us load the package and create a synthetic sparse matrix.

```
library(sparseMatrixStats)
#> Loading required package: MatrixGenerics
#> Loading required package: matrixStats
#>
#> Attaching package: 'MatrixGenerics'
#> The following objects are masked from 'package:matrixStats':
#>
#>     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
#>     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
#>     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
#>     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
#>     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
#>     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
#>     colWeightedMeans, colWeightedMedians, colWeightedSds,
#>     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
#>     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
#>     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
#>     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
#>     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
#>     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
#>     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
#>     rowWeightedSds, rowWeightedVars
# Matrix defines the sparse Matrix class
# dgCMatrix that we will use
library(Matrix)
# For reproducibility
set.seed(1)
```

Create a synthetic table with customers, items, and how often they bought that item.

```
customer_ids <- seq_len(100)
item_ids <-  seq_len(30)
n_transactions <- 1000
customer <- sample(customer_ids, size = n_transactions, replace = TRUE,
                    prob = runif(100))
item <- sample(item_ids, size = n_transactions, replace = TRUE,
               prob = runif(30))

tmp <- table(paste0(customer, "-", item))
tmp2 <- strsplit(names(tmp), "-")
purchase_table <- data.frame(
  customer = as.numeric(sapply(tmp2, function(x) x[1])),
  item = as.numeric(sapply(tmp2, function(x) x[2])),
  n = as.numeric(tmp)
)

head(purchase_table, n = 10)
#>    customer item n
#> 1         1   15 2
#> 2         1   20 1
#> 3         1   22 1
#> 4         1   23 1
#> 5         1   30 1
#> 6       100   11 1
#> 7       100   15 3
#> 8       100   17 1
#> 9       100   19 1
#> 10      100   20 2
```

Let us turn the table into a matrix to simplify the analysis:

```
purchase_matrix <- sparseMatrix(purchase_table$customer, purchase_table$item,
                x = purchase_table$n,
                dims = c(100, 30),
                dimnames = list(customer = paste0("Customer_", customer_ids),
                                item = paste0("Item_", item_ids)))
purchase_matrix[1:10, 1:15]
#> 10 x 15 sparse Matrix of class "dgCMatrix"
#>   [[ suppressing 15 column names 'Item_1', 'Item_2', 'Item_3' ... ]]
#>              item
#> customer
#>   Customer_1  . . . . . . . . . . . . . . 2
#>   Customer_2  . . 2 . . . . . . . . . . . 1
#>   Customer_3  . . 1 . . . . . 1 . . 1 . . 1
#>   Customer_4  . . . . . 1 . . 1 1 . 1 . 1 3
#>   Customer_5  . . . . . . . . . . . 1 . . .
#>   Customer_6  . . . 1 . 1 1 . . 1 1 . . . 1
#>   Customer_7  2 . 1 . . 1 . 1 1 . 1 2 . . 1
#>   Customer_8  . . . . . . . . 1 . . . . . .
#>   Customer_9  . . . . . 2 . . 1 . . . . 1 .
#>   Customer_10 . . . . . . . . . . . . . . .
```

We can see that some customers did not buy anything, where as
some bought a lot.

`sparseMatrixStats` can help us to identify interesting patterns in this data:

```
# How often was each item bough in total?
colSums2(purchase_matrix)
#>  Item_1  Item_2  Item_3  Item_4  Item_5  Item_6  Item_7  Item_8  Item_9 Item_10
#>      34      13      30      10      12      34      29      31      71      28
#> Item_11 Item_12 Item_13 Item_14 Item_15 Item_16 Item_17 Item_18 Item_19 Item_20
#>      20      40       0      48      52      27      30      55      14      46
#> Item_21 Item_22 Item_23 Item_24 Item_25 Item_26 Item_27 Item_28 Item_29 Item_30
#>       8      41      40      73      56      83      20      18      13      24

# What is the range of number of items each
# customer bought?
head(rowRanges(purchase_matrix))
#>            [,1] [,2]
#> Customer_1    0    2
#> Customer_2    0    2
#> Customer_3    0    3
#> Customer_4    0    3
#> Customer_5    0    1
#> Customer_6    0    4

# What is the variance in the number of items
# each customer bought?
head(rowVars(purchase_matrix))
#> Customer_1 Customer_2 Customer_3 Customer_4 Customer_5 Customer_6
#> 0.23448276 0.40919540 0.39195402 0.74022989 0.06436782 0.81034483

# How many items did a customer not buy at all, one time, 2 times,
# or exactly 4 times?
head(rowTabulates(purchase_matrix, values = c(0, 1, 2, 4)))
#>             0 1 2 4
#> Customer_1 25 4 1 0
#> Customer_2 25 2 3 0
#> Customer_3 25 4 0 0
#> Customer_4 19 8 1 0
#> Customer_5 28 2 0 0
#> Customer_6 20 7 2 1
```

## 2.1 Alternative Matrix Creation

In the previous section, I demonstrated how to create a sparse matrix from scratch using the `sparseMatrix()` function.
However, often you already have an existing matrix and want to convert it to a sparse representation.

```
mat <- matrix(0, nrow=10, ncol=6)
mat[sample(seq_len(60), 4)] <- 1:4
# Convert dense matrix to sparse matrix
sparse_mat <- as(mat, "dgCMatrix")
sparse_mat
#> 10 x 6 sparse Matrix of class "dgCMatrix"
#>
#>  [1,] . . . . . .
#>  [2,] . . . . 4 .
#>  [3,] . . . . . .
#>  [4,] . . . . . .
#>  [5,] . . . . . .
#>  [6,] 1 . . 2 . .
#>  [7,] . . 3 . . .
#>  [8,] . . . . . .
#>  [9,] . . . . . .
#> [10,] . . . . . .
```

The *sparseMatrixStats* package is a derivative of the *[matrixStats](https://CRAN.R-project.org/package%3DmatrixStats)* package and implements it’s API for
sparse matrices. For example, to calculate the variance for each column of `mat` you can do

```
apply(mat, 2, var)
#> [1] 0.1 0.0 0.9 0.4 1.6 0.0
```

However, this is quite inefficient and *matrixStats* provides the direct function

```
matrixStats::colVars(mat)
#> [1] 0.1 0.0 0.9 0.4 1.6 0.0
```

Now for sparse matrices, you can also just call

```
sparseMatrixStats::colVars(sparse_mat)
#> [1] 0.1 0.0 0.9 0.4 1.6 0.0
```

# 3 Benchmark

If you have a large matrix with many exact zeros, working on the sparse representation can considerably speed up the computations.

I generate a dataset with 10,000 rows and 50 columns that is 99% empty

```
big_mat <- matrix(0, nrow=1e4, ncol=50)
big_mat[sample(seq_len(1e4 * 50), 5000)] <- rnorm(5000)
# Convert dense matrix to sparse matrix
big_sparse_mat <- as(big_mat, "dgCMatrix")
```

I use the bench package to benchmark the performance difference:

```
bench::mark(
  sparseMatrixStats=sparseMatrixStats::colVars(big_sparse_mat),
  matrixStats=matrixStats::colVars(big_mat),
  apply=apply(big_mat, 2, var)
)
#> # A tibble: 3 × 6
#>   expression             min   median `itr/sec` mem_alloc `gc/sec`
#>   <bch:expr>        <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
#> 1 sparseMatrixStats  90.61µs  95.67µs    10350.        NA     6.20
#> 2 matrixStats         3.37ms    3.4ms      294.        NA     0
#> 3 apply               6.98ms   7.11ms      132.        NA   111.
```

As you can see `sparseMatrixStats` is ca. 50 times fast than `matrixStats`, which in turn is 7 times faster than the `apply()` version.

# 4 Session Info

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] Matrix_1.7-4             sparseMatrixStats_1.22.0 MatrixGenerics_1.22.0
#> [4] matrixStats_1.5.0        BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] vctrs_0.6.5         cli_3.6.5           knitr_1.50
#>  [4] rlang_1.1.6         xfun_0.53           bench_1.1.4
#>  [7] jsonlite_2.0.0      glue_1.8.0          htmltools_0.5.8.1
#> [10] sass_0.4.10         rmarkdown_2.30      grid_4.5.1
#> [13] tibble_3.3.0        evaluate_1.0.5      jquerylib_0.1.4
#> [16] fastmap_1.2.0       yaml_2.3.10         lifecycle_1.0.4
#> [19] bookdown_0.45       BiocManager_1.30.26 compiler_4.5.1
#> [22] pkgconfig_2.0.3     Rcpp_1.1.0          lattice_0.22-7
#> [25] digest_0.6.37       R6_2.6.1            utf8_1.2.6
#> [28] pillar_1.11.1       magrittr_2.0.4      bslib_0.9.0
#> [31] tools_4.5.1         cachem_1.1.0
```