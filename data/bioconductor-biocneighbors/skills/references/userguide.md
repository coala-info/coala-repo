# Finding neighbors in high-dimensional space

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: July 28, 2024

#### Package

BiocNeighbors 2.4.0

# 1 Overview

The *[BiocNeighbors](https://bioconductor.org/packages/3.22/BiocNeighbors)* package implements a variety of nearest-neighbor (NN) search algorithms with a consistent interface.
This includes exact search methods like
[vantage point trees](https://dl.acm.org/doi/10.5555/313559.313789),
[k-means k-nearest neighbors](https://doi.org/10.1109/IJCNN.2011.6033373),
and an exhaustive brute-force search,
as well as approximate methods like
[Approximate Nearest Neighbors Oh Yeah (Annoy)](https://github.com/spotify/annoy)
and [hierarchical navigable small worlds (HNSW)](https://github.com/nmslib/hnswlib).
We provides methods to search nearest neighbors within a dataset, query across datasets,
and (for some algorithms) find all neighbors within a certain distance.

# 2 Finding nearest neighbors

The `findKNN()` function will find the `k`-nearest neighbors within a dataset,
returning one matrix of neighbor identities and another matrix of (sorted) distances to each neighbor.

```
# Mocking up a matrix with 'nobs' points in the rows
# and 'ndim' dimensions in the columns.
nobs <- 1000
ndim <- 20
data <- matrix(runif(nobs*ndim), ncol=ndim)

library(BiocNeighbors)
fout <- findKNN(data, k=10)
str(fout)
```

```
## List of 2
##  $ index   : int [1:1000, 1:10] 10 501 106 881 721 486 775 62 461 1 ...
##  $ distance: num [1:1000, 1:10] 1.06 1.199 0.992 1.155 1.028 ...
```

Each row of the `index` matrix corresponds to a row in `data` and contains the row indices in `data` that are its nearest neighbors.
For example, the 3rd point in `data` has the following nearest neighbors with their (sorted) distances:

```
fout$index[3,]
```

```
##  [1] 106 116 791 493  68 840 939 736 388 400
```

```
fout$distance[3,]
```

```
##  [1] 0.9923836 1.0118565 1.0627019 1.0715067 1.0875516 1.1378636 1.1385719
##  [8] 1.1421896 1.1537396 1.1638757
```

Users can easily change the algorithm by setting the `BNPARAM=` argument.
For example, the code below switches to the Annoy algorithm for a faster, less accurate search.

```
aout <- findKNN(data, k=10, BNPARAM=AnnoyParam())
str(aout)
```

```
## List of 2
##  $ index   : int [1:1000, 1:10] 10 501 106 881 721 486 775 62 461 1 ...
##  $ distance: num [1:1000, 1:10] 1.06 1.199 0.992 1.155 1.028 ...
```

The same mechanism can be used to change the distance metric from the Euclidean default.

```
vout <- findKNN(data, k=10, BNPARAM=VptreeParam(distance="Manhattan"))
str(vout)
```

```
## List of 2
##  $ index   : int [1:1000, 1:10] 10 797 106 881 721 486 400 114 461 246 ...
##  $ distance: num [1:1000, 1:10] 4.02 3.9 3.62 3.63 3.71 ...
```

If the number of neighbors differs for each point, we can supply an integer vector to `k=` instead.
This yields a list of vectors containing the neighbors and their distances to each point.

```
var.k <- sample(10, nrow(data), replace=TRUE)

# use I() to distinguish between scalar and length-1 vectors.
var.out <- findKNN(data, k=I(var.k))

head(var.out$index)
```

```
## [[1]]
##  [1]  10 743 121 322 608 246  25 923  96 538
##
## [[2]]
## [1] 501  83
##
## [[3]]
## [1] 106 116 791
##
## [[4]]
## [1] 881 558 267 120 400 335 833
##
## [[5]]
## [1] 721
##
## [[6]]
## [1] 486 785 269  48 140
```

```
head(var.out$distance)
```

```
## [[1]]
##  [1] 1.059995 1.195867 1.207465 1.208032 1.246542 1.246966 1.275415 1.285533
##  [9] 1.287975 1.288305
##
## [[2]]
## [1] 1.198662 1.208656
##
## [[3]]
## [1] 0.9923836 1.0118565 1.0627019
##
## [[4]]
## [1] 1.155241 1.170470 1.184136 1.197051 1.197828 1.215869 1.221885
##
## [[5]]
## [1] 1.02773
##
## [[6]]
## [1] 1.030991 1.063953 1.082797 1.102278 1.103196
```

`queryKNN()` is a related function that will find the `k`-nearest neighbors in one dataset based on query points in another dataset.
Here, the rows of the output matrices correspond to rows of our `query` matrix.

```
nquery <- 100
ndim <- 20
query <- matrix(runif(nquery*ndim), ncol=ndim)

qout <- queryKNN(data, query, k=5)
str(qout)
```

```
## List of 2
##  $ index   : int [1:100, 1:5] 349 540 520 686 443 783 493 440 94 71 ...
##  $ distance: num [1:100, 1:5] 1.11 1.33 1.14 1.14 1.02 ...
```

When performing multiple calls to `findKNN()` or `queryKNN()` on the same data,
advanced users may prefer to build the index first with `buildIndex()`.
This can be efficiently reused without repeating the index construction in each call.

```
prebuilt <- buildIndex(data)
out1 <- findKNN(prebuilt, k=5)
out2 <- queryKNN(prebuilt, query, k=5)
```

# 3 Finding all neighbors within range

In some applications, we need to find all neighboring points within a certain distance threshold.
This is achieved using the `findNeighbors()` function:

```
nobs <- 8000
ndim <- 20
data <- matrix(runif(nobs*ndim), ncol=ndim)

fout <- findNeighbors(data, threshold=1)
head(fout$index)
```

```
## [[1]]
## [1] 5845 5382
##
## [[2]]
## [1] 1461 1647
##
## [[3]]
## [1] 410
##
## [[4]]
## [1] 6666 3205  156 4552
##
## [[5]]
## [1] 2886 2443 3980 7484 3585 3148 5932
##
## [[6]]
## integer(0)
```

```
head(fout$distance)
```

```
## [[1]]
## [1] 0.9209169 0.9849596
##
## [[2]]
## [1] 0.9741905 0.9803832
##
## [[3]]
## [1] 0.8953597
##
## [[4]]
## [1] 0.9568178 0.9717669 0.9795090 0.9995167
##
## [[5]]
## [1] 0.8810099 0.8948550 0.9425610 0.9534772 0.9583569 0.9727592 0.9996600
##
## [[6]]
## numeric(0)
```

Each entry of the `index` list corresponds to a point in `data` and contains the row indices in `data` that are within `threshold`.
For example, the 3rd point in `data` has the following neighbors with the associated distances:

```
fout$index[[3]]
```

```
## [1] 410
```

```
fout$distance[[3]]
```

```
## [1] 0.8953597
```

Again, we can switch algorithms by specifying `BNPARAM=`.
However, keep in mind that not all algorithms (particularly the approximate methods) support this range-based search.

```
vparam <- VptreeParam(distance="Manhattan")
vout <- findNeighbors(data, threshold=1, BNPARAM=vparam)
```

`queryNeighbors()` is a related function that will identify all points within a certain distance of a query point.
Each entry of the returned `index` and `distance` corresponds to a row of `query` and describes its neighbors in `data`.

```
nquery <- 100
ndim <- 20
query <- matrix(runif(nquery*ndim), ncol=ndim)
qout <- queryNeighbors(data, query, threshold=1)
head(qout$index)
```

```
## [[1]]
## [1] 2308 6812 1354 6347 3242 7625
##
## [[2]]
## [1] 6994  216 1693 5627
##
## [[3]]
## integer(0)
##
## [[4]]
## integer(0)
##
## [[5]]
## [1] 7
##
## [[6]]
##  [1] 1784 3951 1147 2695 7216 4161  832  724 4625 6374 2597  265
```

As described above, advanced users can built the index first before repeated calls to `findNeighbors()` and `queryNeighbors()`.

```
prebuilt <- buildIndex(data)
out1 <- findNeighbors(prebuilt, threshold=1)
out2 <- queryNeighbors(prebuilt, query,threshold=1)
```

If only the number of neighbors is of interest, we can set `get.index=FALSE` and `get.distance=FALSE` in the `findNeighbors()`/`queryNeighbors()` call.
This will count the number of neighbors without storing their identities/distances for greater memory efficiency.

```
num <- findNeighbors(data, threshold=1, get.index=FALSE, get.distance=FALSE)
head(num)
```

```
## [1] 2 2 1 4 7 0
```

# 4 Usage in downstream C++ libraries

R/Bioconductor package developers can use *[BiocNeighbors](https://bioconductor.org/packages/3.22/BiocNeighbors)* to perform nearest-neighbor searches in their own C++ code.
This uses the interfaces in the [**knncolle**](https://github.com/knncolle/knncolle) library to abstract away the underlying search methods.
First, we add some linking instructions in the `DESCRIPTION` to make the header files available:

```
LinkingTo: Rcpp, assorthead, BiocNeighbors
```

This includes the `BiocNeighbors.h` file that implements the `BiocNeigbors::Prebuilt` class:

```
system.file("include", "BiocNeighbors.h", package="BiocNeighbors")
```

When a `buildIndex()` method returns an external pointer, that pointer is expected to refer to an instance of a `BiocNeighbors::Prebuilt`.
Thus, downstream code just needs to accept a pointer and cast it to a `BiocNeighbors::Prebuilt` for use in nearest-neighbor searches.
(The same approach can be applied to obtain a `BiocNeighbors::Builder` for construction of new indices.)

```
SEXP do_something(SEXP raw_ptr, int k) {
    BiocNeighbors::PrebuiltPointer ptr(raw_ptr);
    const auto& prebuilt = ptr->index;
    auto searcher = prebuilt->initialize();

    std::vector<int> indices;
    std::vector<double> distances;
    searcher->search(0, k, &indices, &distances);

    return Rcpp::List::create(
        Rcpp::IntegerVector(indices.begin(), indices.end()),
        Rcpp::IntegerVector(distances.begin(), distances.end())
    );
}
```

Some extra work is required for cosine-normalized indices, which is indicated by `ptr->cosine == true`.
Any query data should also be L2-normalized before use in `Searcher::search()` or `Searcher::search_all()`.
(This is not required for overloads that accept an index for searching *within* a dataset, only for queries between datasets.)

# 5 Extending to new methods

## 5.1 Introduction

Developers can extend the *[BiocNeighbors](https://bioconductor.org/packages/3.22/BiocNeighbors)* framework to more algorithms through the creation of new `BiocNeighborParam` classes.
Users can then switch between algorithms by simply changing the `BNPARAM=` argument in their calls to `findKNN()`, etc.
In general, we recommend putting these extensions in a new R/Bioconductor package that adds more methods to the *[BiocNeighbors](https://bioconductor.org/packages/3.22/BiocNeighbors)* generics.
Developers can choose to write pure R extensions or they can write them partially in C++.

## 5.2 In R

Each extension package should:

* Implement a `SomeNewParam` S4 class that inherits from `BiocNeighborParam`.
* Implement a `SomeNewIndex` S4 class that inherits from `BiocNeighborIndex` and contains an arbitrary index structure.
* Implement a `buildIndex()` S4 method, dispatching on a `matrix` type for `X=` and a `SomeNewParam` type for `BNPARAM=`.
  This should return an instance of `SomeNewIndex`.
* Implement two methods for each of `findKNN()` and `queryKNN()` (and optionally `findNeighbors()` `queryNeighbors()`).
  One method should dispatch on a `matrix` type for `X=` and a `SomeNewParam` type for `BNPARAM=`.
  The other method should dispatch on a prebuilt `SomeNewIndex` type for `X=` and an `ANY` type for `BNPARAM=` (as the `BNPARAM=` is ignored for prebuilt indices).

## 5.3 In C++

Alternatively, each extension package should:

* Implement C++ classes that inherit from the `Builder`, `Prebuilt` and `Searcher` interfaces in the [**knncolle**](https://github.com/knncolle/knncolle) library.
  This requires `LinkingTo: assorthead, BiocNeighbors` in the `DESCRIPTION`.
* Implement a `SomeNewParam` S4 class that inherits from `BiocNeighborParam`.
* Implement a `SomeNewIndex` S4 class that inherits from `BiocNeighborGenericIndex`.
  This should contain a `ptr` slot for an external pointer and a `names` slot for the observation names.
* Implement a `defineBuilder()` method, dispatching on a `matrix` type for `X=` and a `SomeNewParam` type for `BNPARAM=`.
  This should call into C++ and return a list containing `builder`,
  an external pointer to an instance of a `BiocNeighbors::Builder` (see definition in `BiocNeighbors.h`);
  and `class`, the constructor for the new `SomeNewIndex` class.

No new methods are required for `findKNN()`, `queryNeighbors()`, etc. as a `BiocNeighborGeneric` method is already available for each generic.
This approach also allows the new method to be used in C++ code of downstream packages that accept a `BiocNeighbors::Prebuilt` instance.

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
## [1] BiocNeighbors_2.4.0 knitr_1.50          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] htmltools_0.5.8.1   rmarkdown_2.30      lifecycle_1.0.4
## [10] cli_3.6.5           sass_0.4.10         jquerylib_0.1.4
## [13] compiler_4.5.1      tools_4.5.1         evaluate_1.0.5
## [16] bslib_0.9.0         Rcpp_1.1.0          yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```