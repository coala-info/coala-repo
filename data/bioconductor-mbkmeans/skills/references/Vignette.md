# An introduction to mbkmeans

Yuwei Ni, Davide Risso, Stephanie Hicks, and Elizabeth Purdom

#### Last modified: November 7, 2020; Compiled: October 30, 2025

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
  + [2.1 Example dataset](#example-dataset)
* [3 `mbkmeans`](#mbkmeans)
  + [3.1 Choice of arguments](#choice-of-arguments)
    - [3.1.1 Batch size](#batch-size)
    - [3.1.2 Initialization](#initialization)
  + [3.2 Running `mbkmeans` with multiple values of \(k\)](#running-mbkmeans-with-multiple-values-of-k)
* [4 Comparison with *k*-means](#comparison-with-k-means)
* [5 Use with bluster](#use-with-bluster)
* [6 Working with on-disk data in Bioconductor](#working-with-on-disk-data-in-bioconductor)
* [References](#references)

# 1 Installation

To install the package, please use the following.

```
if (!requireNamespace("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("mbkmeans")
```

# 2 Introduction

This vignette provides an introductory example on how
to work with the `mbkmeans` package, which contains an
implementation of the mini-batch k-means algorithm
proposed in (Sculley [2010](#ref-sculley2010web)) for large single-cell
sequencing data. This algorithm runs the \_k\_means iterations on small, random subsamples of data (``mini batches’’) rather than the entire dataset. This both speeds up computation and reduces the amount of data that must be contained in memory.

The main function to be used by the users is `mbkmeans`.
This is implemented as an S4 generic and methods are
implemented for `matrix`, `Matrix`, `HDF5Matrix`,
`DelayedMatrix`, `SummarizedExperiment`, and
`SingleCellExperiment`.

Most of this work was inspired by the
`MiniBatchKmeans()` function implemented in the
`ClusterR` R package and we re-use many of the
C++ functions implemented there.

Our main contribution here is to provide an
interface to the `DelayedArray` and `HDF5Array`
packages so that `mbkmeans` algorithm only brings into memory at any time the “mini-batches” needed for the current iteration, and never requires loading the entire dataset into memory. This allows the user to run the mini-batch
*k*-means algorithm on very large datasets that do not fit
entirely in memory. `mbkmeans` also runs seamlessly on in-memory matrices provided by the user, and doing so significantly increases the speed of the algorithm compared to the standard *k*-means algorithm ((Hicks et al. [2020](#ref-Hicks2020))). A complete comparison of `mbkmeans` with other implementations can be found in (Hicks et al. [2020](#ref-Hicks2020)).

The motivation for this work is the clustering of
large single-cell RNA-sequencing (scRNA-seq) datasets,
and hence the main focus is on Bioconductor’s
`SingleCellExperiment`and `SummarizedExperiment`
data container. For this reason, `mbkmeans` assumes a
data representation typical of genomic data, in which
genes (variables) are in the rows and cells
(observations) are in the column. This is contrary to
most other statistical applications, and notably to
the `stats::kmeans()` and `ClusterR::MiniBatchKmeans()`
functions that assume observations in rows.

We provide a lower-level `mini_batch()` function that
expects observations in rows and is expected to be a direct
replacement of `ClusterR::MiniBatchKmeans()` for on-disk
data representations such as `HDF5` files. The rest of
this document shows the typical use case through the
`mbkmeans()` interface; users interested in the
`mini_batch()` function should refer to its manual page.

## 2.1 Example dataset

To illustrate a typical use case, we use the
`pbmc4k` dataset of the
[`TENxPBMCData` package](https://bioconductor.org/packages/release/data/experiment/html/TENxPBMCData.html).
This dataset contains a set of about 4,000 cells from
peripheral blood from a healthy donor and is expected
to contain many types or clusters of cell.

We would note that `mbkmeans` is designed for very large datasets, in particular for datasets large enough that either the full data matrix can’t be held in memory, or the computations necessary cannot be computed. This vignette works with a small dataset to allow the user to quickly follow along and understand the commands. (Hicks et al. [2020](#ref-Hicks2020)) shows the example of using `mbkmeans` with a dataset with 1.3 million cells, which is a more appropriate size for observing improved memory usage and improved speed.

First, we load the needed packages.

```
library(TENxPBMCData)
library(scater)
library(SingleCellExperiment)
library(mbkmeans)
library(DelayedMatrixStats)
```

Note that in this vignette, we do not aim at identifying
biologically meaningful clusters (that would
entail a more sophisticated normalization of data and
dimensionality reduction), but instead we only aim to show
how to run mini-batch *k*-means on a HDF5-backed
matrix.

We normalize the data simply by scaling for the total
number of counts using `scater` and select the 1,000
most variable genes and a random set of 100 cells to
speed-up computations.

```
tenx_pbmc4k <- TENxPBMCData(dataset = "pbmc4k")

set.seed(1034)
idx <- sample(seq_len(NCOL(tenx_pbmc4k)), 100)
sce <- tenx_pbmc4k[, idx]

#normalization
sce <- logNormCounts(sce)

vars <- rowVars(logcounts(sce))
names(vars) <- rownames(sce)
vars <- sort(vars, decreasing = TRUE)

sce1000 <- sce[names(vars)[1:1000],]

sce1000
```

```
## class: SingleCellExperiment
## dim: 1000 100
## metadata(0):
## assays(2): counts logcounts
## rownames(1000): ENSG00000090382 ENSG00000204287 ... ENSG00000117748
##   ENSG00000135968
## rowData names(3): ENSEMBL_ID Symbol_TENx Symbol
## colnames: NULL
## colData names(12): Sample Barcode ... Date_published sizeFactor
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

# 3 `mbkmeans`

The main function, `mbkmeans()`, returns a
list object including `centroids`,
`WCSS_per_cluster` (where WCSS stands for
within-cluster-sum-of-squares),
`best_initialization`, `iters_per_initiazation`
and `Clusters`.

It takes any matrix-like object as input, such
as `SummarizedExperiment`, `SingleCellExperiment`,
`matrix`, `DelayedMatrix` and `HDF5Matrix`.

In this example, the input is a `SingleCellExperiment`
object.

```
res <- mbkmeans(sce1000, clusters = 5,
                reduceMethod = NA,
                whichAssay = "logcounts")
```

The number of clusters (such as *k* in the
*k*-means algorithm) is set through the `clusters`
argument. In this case, we set `clusters = 5` for
no particular reason. For `SingleCellExperiment`
objects, the function provides the `reduceMethod`
and `whichAssay` arguments. The `reduceMethod` argument
should specify the dimensionality reduction slot
to use for the clustering, and the default is
“PCA”. Note that this *does not perform* PCA but
only looks at a slot called “PCA” already stored
in the object. Alternatively, one can specify
`whichAssay` as the assay to use as input to
mini-batch *k*-means. This is used only when
`reduceMethod` option is `NA`. See `?mbkmeans`
for more details.

## 3.1 Choice of arguments

There are additional arguements in `mbkmeans()`
that make the function more flexible
and suitable for more situations.

### 3.1.1 Batch size

The size of the mini batches is set through the
`batch_size` argument. This argument gives the size of the samples of data brought into memory at any one time, and thus constrains the memory usage of the alogrithm.

The `blocksize()` function can be used to set the batch size to the maximum allowed by the available memory.
It considers both the number of columns in the dataset
and the amount of RAM on the current matchine to
calculate as large of a batch size as reasonable for
the RAM available to the session. The calculation uses
`get_ram()` function in `benchmarkme` package. See
the `benchmarkme` vignette for more details.

```
batchsize <- blocksize(sce1000)
batchsize
```

```
## [1] 100
```

In this simple example, because the whole data fits in memory,
the default batch size would be a single
batch of size 100.

(Hicks et al. [2020](#ref-Hicks2020)) provides a comparison of the effect of batch size for large datasets (i.e. where the full data cannot be stored in memory). Their results show the algorithm to be robust to a large range of batch sizes (1,000-10,000 cells): accuracy of the results were equivalent if the batch size was above 500-1000 cells, with no noticable advantage in memory usage or speed as long as the batches were smaller than roughly 10,000 cells (corresponding to a subsample of the full data matrix whose memory foot print is not noticeable on most modern computers). For this reason, we would err on the larger range of batch size suggested in (Hicks et al. [2020](#ref-Hicks2020)) – 10,000 cells. Furthermore, since the initialization uses by default the same number of cells as batch size, this gives a robust sample for determining the initial start point.

We would note that it is better to make choices on batch size based on choosing the *absolute* number of cells in a batch rather than choosing batch size based on a percentage of the overall sample size. If batch size is chosen based on the percentage of cells, very large datasets will use very large batches of cells, negating the memory and speed gains. Moreover such large batches are not needed for good performance of the algorithm. The continual resampling of the batches works like stochastic gradient descent and allows for (local) minimization of the objective function (Sculley [2010](#ref-sculley2010web)) with relatively small batch sizes, as demonstrated on single-cell data in the work of (Hicks et al. [2020](#ref-Hicks2020)). If anything, the size of the batch should be governed more by the complexity of the problem (e.g. the number of underlying true clusters or subtypes), rather than the number of overall cells in the dataset.

### 3.1.2 Initialization

The performance of mini-batch *k*-means greatly
depends on the process of initialization. We
implemented two different initialization methods:

1. Random initialization, as in regular *k*-means;
2. `kmeans++`, as proposed in (Arthur and Vassilvitskii [2007](#ref-arthur2007k)). The default is “kmeans++”.

The percentage of data to use for the initialization
centroids is set through the `init_fraction` argument,
which should be larger than 0 and less than 1. The
default value is given so that the proportion matches the value of `batch_size`, converted to a proportion of the data.

```
res_random <- mbkmeans(sce1000, clusters = 5,
                reduceMethod = NA,
                whichAssay = "logcounts",
                initializer = "random")
table(res$Clusters, res_random$Clusters)
```

```
##
##      1  2  3  4  5
##   1  0  0  0  0  1
##   2  0  0  1  0  0
##   3  4  0 23  0  0
##   4  0  0  0  0  4
##   5  0  5  0 14 48
```

Note that large values of `init_fraction` will result in that proportion of the data being held in memory and used in the initialization of the `kmeans++` algorithm. Therefore, large values of `init_fraction` will require a great deal of memory – potentially more than that used by the actual clustering algorithm. Indeed keeping the fraction used constant for larger and larger datasets will result in commiserate numbers of cells being used in the initialization and increasing the memory usage (similar to the issues discussed above for batch size). Therefore, we recommend that users keep the default and make changes to the `batch_size` parameter as desired, ensuring consistent memory usage across both the initialization stage and the actual clustering stage of the algorithm. As mentioned in the discussion above on `batch_size`, for this reason we would recommend `batch_size` on the larger range suggested as reasonable in (Hicks et al. [2020](#ref-Hicks2020)) so as to improve the initialization.

## 3.2 Running `mbkmeans` with multiple values of \(k\)

The main parameter to set in \(k\)-means and its variants is the number of clusters \(k\). `mbkmeans` is quick enough to rerun the clustering algorithm with different number of clusters even in very large datasets.

Here, we apply `mbkmeans` with \(k\) from 5 to 15 and select the number of clusters using the elbow method (i.e., the value that corresponds to the point of inflection on the curve). We note that this is just a rule of thumb for selecting the number of clusters, and many different methods exist to decide the appropriate value of \(k\).

To speed up the computations, we will cluster on the top 20 PCs.

```
sce1000 <- runPCA(sce1000, ncomponents=20)

ks <- seq(5, 15)
res <- lapply(ks, function(k) {
    mbkmeans(sce1000, clusters = k,
             reduceMethod = "PCA",
             calc_wcss = TRUE, num_init=10)
})

wcss <- sapply(res, function(x) sum(x$WCSS_per_cluster))
plot(ks, wcss, type = "b")
```

![](data:image/png;base64...)

From the plot, it seems that `k = 12` could be a reasonable value.

# 4 Comparison with *k*-means

Note that if we set `init_fraction = 1`,
`initializer = "random"`, and `batch_size = ncol(x)`,
we recover the classic *k*-means algorithm.

```
res_full <- mbkmeans(sce1000, clusters = 5,
                     reduceMethod = NA,
                     whichAssay = "logcounts",
                     initializer = "random",
                     batch_size = ncol(sce1000))
res_classic <- kmeans(t(logcounts(sce1000)),
                      centers = 5)
table(res_full$Clusters, res_classic$cluster)
```

```
##
##      1  2  3  4  5
##   1  0  7  0  7  0
##   2  0  0 14 43  0
##   3  2  0  0  0  0
##   4 16  0  0  0 10
##   5  0  0  0  1  0
```

Note however, that since the two algorithms start from different random initializations, they will not always converge to the same solution. Furthremore, if the algorithm uses batches smaller than the full dataset (`batch_size<ncol(x)`), then `mbkmeans` will not converge to the same result as `kmeans` even with the same initialization. This is due to the fact that `kmeans` and `mbkmeans` have different search paths for an optimum and the problem is non-convex.

For a comparison of memory usage, speed, and accuracy of `mbkmeans` with `kmeans` for the non-trivial case where the algorithm uses batches, see (Hicks et al. [2020](#ref-Hicks2020)), where it is demonstrated that `mbkmeans` provides significant speed improvements and uses less memory than `kmeans`, without loss of accuracy.

# 5 Use with bluster

The *[bluster](https://bioconductor.org/packages/3.22/bluster)* package provides a flexible and extensible framework for clustering in Bioconductor packages/workflows.
The `clusterRows()` function controls dispatch to different clustering algorithms.
In this case, we will use the mini-batch *k*-means algorithm to cluster cells into cell populations based on their principal component analysis (PCA) coordinates.

```
mat <- reducedDim(sce1000, "PCA")
dim(mat)
```

```
## [1] 100  20
```

In the following three scenarios, we pass the number of cluster centers as a number using the `centers=5` argument.
In addition, we can also pass other `mbkmeans` arguments (e.g. `batch_size=10`).
In the first two cases, we only return the cluster labels.
However, in the third scenario, we ask for the full `mbkmeans` output.

```
library(bluster)
clusterRows(mat, MbkmeansParam(centers=5))
```

```
##   [1] 2 5 5 3 5 4 3 1 1 3 5 2 5 1 1 1 3 5 1 3 2 1 5 5 1 3 1 1 5 1 3 5 4 1 2 1 4
##  [38] 5 5 4 5 4 5 4 5 3 1 3 5 5 5 2 1 3 2 5 4 1 4 3 5 4 1 1 3 5 2 4 5 4 1 5 4 1
##  [75] 5 3 1 5 3 1 2 1 4 1 2 5 4 5 1 1 5 1 4 2 4 5 2 5 1 2
## Levels: 1 2 3 4 5
```

```
clusterRows(mat, MbkmeansParam(centers=5, batch_size=10))
```

```
##   [1] 3 3 3 3 3 3 3 5 5 3 3 1 3 5 5 5 3 3 5 3 4 5 3 3 5 3 5 5 3 5 3 3 4 5 1 5 4
##  [38] 3 3 3 3 3 3 3 3 3 5 3 3 3 3 1 5 3 1 3 3 5 4 3 3 4 5 5 3 3 3 3 3 3 2 3 3 5
##  [75] 3 3 5 3 3 5 4 5 3 5 1 3 4 3 5 5 3 5 3 3 3 3 3 3 5 4
## Levels: 1 2 3 4 5
```

```
clusterRows(mat, MbkmeansParam(centers=5, batch_size=10), full = TRUE)
```

```
## $clusters
##   [1] 5 5 5 5 5 5 5 1 1 5 5 2 5 1 1 1 5 5 3 5 5 1 5 5 1 5 1 1 5 1 5 5 5 1 2 1 5
##  [38] 5 5 5 5 5 5 5 5 5 1 5 5 5 5 2 1 5 2 5 5 1 5 5 5 5 1 1 5 5 5 5 5 5 1 5 5 1
##  [75] 5 5 1 5 5 1 5 1 5 1 2 5 5 5 1 1 5 1 5 5 5 5 4 5 1 5
## Levels: 1 2 3 4 5
##
## $objects
## $objects$mbkmeans
## $objects$mbkmeans$centroids
##            [,1]       [,2]      [,3]       [,4]      [,5]       [,6]       [,7]
## [1,] -15.010417 -0.7962079 -4.968180 -2.7679840 -0.605855 -0.2194566 -1.4958129
## [2,]   1.398788 15.2268393  4.914318 -8.7031508 -0.624902 -2.6562225 -0.8620272
## [3,] -17.543300 -0.3406707 -6.138011 -4.3145411  1.079512  0.6031462  3.6588221
## [4,]   3.505305  9.0542211  4.008002 -0.8464335 -1.494348 -5.7764435 -3.4572454
## [5,]   4.953126 -5.2662492  1.885661  0.1000841  1.303848 -0.6517419 -0.3327930
##            [,8]       [,9]      [,10]      [,11]     [,12]      [,13]
## [1,] -0.6686381  0.7806568 -1.1359341  1.1528491 -1.407013  1.5457278
## [2,] -3.2219319 -3.0456175 -0.2216553 -1.8928053  5.403923 -2.9907297
## [3,]  8.2619290 -4.0679099 -3.2909212  5.7171778  8.625866  4.8241775
## [4,] -3.3455593 -2.0061982 -1.3108509 -9.4799142  1.971986  9.3333830
## [5,] -0.4513868 -1.7769361 -1.2359026  0.4449523  0.151892 -0.9781383
##           [,14]      [,15]      [,16]       [,17]     [,18]     [,19]
## [1,]  1.6981873  3.2334236  0.7828917  0.11174810 0.7921813  2.095090
## [2,] -1.0326219 -0.3752647 -2.2624371  2.48013343 2.6617969 -2.687306
## [3,]  0.2712364 -1.0289170  5.9773702 -2.34843263 1.5557200 -3.698316
## [4,]  0.8668148  1.5455810  1.8839526 -4.15320464 2.9828210  2.413375
## [5,]  2.0870510 -1.4041611  0.3987755 -0.06157393 0.6216171 -0.435778
##            [,20]
## [1,] -0.12527754
## [2,] -2.21443762
## [3,]  2.67774700
## [4,]  0.06607878
## [5,] -0.77234827
##
## $objects$mbkmeans$WCSS_per_cluster
## numeric(0)
##
## $objects$mbkmeans$best_initialization
## [1] 1
##
## $objects$mbkmeans$iters_per_initialization
##      [,1]
## [1,]   17
##
## $objects$mbkmeans$Clusters
##   [1] 5 5 5 5 5 5 5 1 1 5 5 2 5 1 1 1 5 5 3 5 5 1 5 5 1 5 1 1 5 1 5 5 5 1 2 1 5
##  [38] 5 5 5 5 5 5 5 5 5 1 5 5 5 5 2 1 5 2 5 5 1 5 5 5 5 1 1 5 5 5 5 5 5 1 5 5 1
##  [75] 5 5 1 5 5 1 5 1 5 1 2 5 5 5 1 1 5 1 5 5 5 5 4 5 1 5
```

While many of the times clustering will be performed on in-memory data (for example after PCA), the `clusterRows` function also accepts any matrix-like object (in-memory or on-disk data representation) that `mbkmeans` accepts.

For example, we can cluster using `mbkmeans` on the `logcounts` assay in the `sce1000` object (similar to above), which is a `DelayedMatrix` object from the *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* package.

**Note**: We transpose the matrix as the `clusterRows` function expects observations along the rows and variables along the columns.

```
logcounts(sce1000)
```

```
## <1000 x 100> sparse DelayedMatrix object of type "double":
##                      [,1]      [,2]      [,3] ...     [,99]    [,100]
## ENSG00000090382  0.000000  1.482992  0.000000   . 5.4330604 0.0000000
## ENSG00000204287  2.198815  0.000000  0.000000   . 5.3387971 0.0000000
## ENSG00000163220  1.762993  1.482992  0.000000   . 2.1176311 2.0642508
## ENSG00000143546  0.000000  1.135438  1.113099   . 0.3825221 0.0000000
## ENSG00000019582  3.402730  1.762861  1.733874   . 6.2009459 2.0642508
##             ...         .         .         .   .         .         .
## ENSG00000145779 0.0000000 0.6766523 0.0000000   . 0.9342195 0.0000000
## ENSG00000106948 0.0000000 1.1354382 0.0000000   . 0.9342195 1.3735556
## ENSG00000155660 0.0000000 0.6766523 0.0000000   . 0.3825221 1.3735556
## ENSG00000117748 0.0000000 0.0000000 0.0000000   . 0.0000000 0.0000000
## ENSG00000135968 0.0000000 0.0000000 0.0000000   . 0.3825221 0.0000000
```

```
clusterRows(t(logcounts(sce1000)), MbkmeansParam(centers=4))
```

```
##   [1] 2 2 2 1 2 2 1 3 3 1 2 2 2 3 3 3 1 2 3 1 2 3 2 2 3 1 3 3 2 3 1 2 2 3 2 3 2
##  [38] 2 2 2 2 2 2 2 2 1 3 1 2 2 2 2 3 1 2 4 2 3 2 1 2 2 3 3 1 2 2 2 2 2 3 2 2 3
##  [75] 2 1 3 2 1 3 2 3 2 3 2 2 2 2 3 3 2 3 2 2 2 2 2 2 3 2
## Levels: 1 2 3 4
```

# 6 Working with on-disk data in Bioconductor

This vignette is focused on the use of the `mbkmeans` package.
For the users interested in learning more about working with `HDF5` files and on-disk data in Bioconductor, we recommend the excellent [DelayedArray workshop](https://petehaitch.github.io/BioC2020_DelayedArray_workshop/articles/Effectively_using_the_DelayedArray_framework_for_users.html), presented by Peter Hickey at [Bioc2020](https://bioc2020.bioconductor.org/).

# References

Arthur, David, and Sergei Vassilvitskii. 2007. “K-Means++: The Advantages of Careful Seeding.” In *Proceedings of the Eighteenth Annual Acm-Siam Symposium on Discrete Algorithms*, 1027–35. Society for Industrial; Applied Mathematics.

Hicks, Stephanie C., Ruoxi Liu, Yuwei Ni, Elizabeth Purdom, and Davide Risso. 2020. “Mbkmeans: Fast Clustering for Single Cell Data Using Mini-Batch K-Means.” *bioRxiv*. <https://doi.org/10.1101/2020.05.27.119438>.

Sculley, David. 2010. “Web-Scale K-Means Clustering.” In *Proceedings of the 19th International Conference on World Wide Web*, 1177–8. ACM.