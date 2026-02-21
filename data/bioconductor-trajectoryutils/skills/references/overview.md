# Trajectory utilities for package developers

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: 8 November 2020

#### Package

TrajectoryUtils 1.18.0

# 1 Overview

The *[TrajectoryUtils](https://bioconductor.org/packages/3.22/TrajectoryUtils)* package contains low-level utilities to support trajectory inference packages.
*Support* is the key word here: this package does not perform any inference itself, deferring that to higher-level packages like *[TSCAN](https://bioconductor.org/packages/3.22/TSCAN)* and *[slingshot](https://bioconductor.org/packages/3.22/slingshot)*.
In fact, most of the code in this package was factored out of those two packages after we realized their commonalities.
By rolling this out into a separate package, we can cut down on redundancy, facilitate better propagation of features and simplify maintenance.
If you’re a developer and you have a general utility for trajectory inference, contributions are welcome.

# 2 MST construction

The construction of a cluster-based minium spanning tree is the primary motivator for this package,
as it was implemented separately in *[TSCAN](https://bioconductor.org/packages/3.22/TSCAN)* and *[slingshot](https://bioconductor.org/packages/3.22/slingshot)*.
The idea is simple - cluster cells and create a minimum spanning tree from the cluster centroids to serve as the backbone for the trajectory reconstruction.

```
# Mocking up a Y-shaped trajectory.
centers <- rbind(c(0,0), c(0, -1), c(1, 1), c(-1, 1))
rownames(centers) <- seq_len(nrow(centers))
clusters <- sample(nrow(centers), 1000, replace=TRUE)
cells <- centers[clusters,]
cells <- cells + rnorm(length(cells), sd=0.5)

# Creating the MST:
library(TrajectoryUtils)
mst <- createClusterMST(cells, clusters)
plot(mst)
```

![](data:image/png;base64...)

The implementation in `createClusterMST()` combines several useful ideas from the two aforementioned packages:

* With `outgroup=TRUE`, users can add an outgroup to break apart distant clusters.
  This ensures that the MST does not form spurious links between unrelated parts of the dataset.
* With `dist.method="mnn"`, users can create the MST based on the distances between mutually nearest neighbors.
  This avoids penalizing the formation of edges between adjacent heterogeneous clusters.
* With `dist.method="slingshot"`, the Mahalanobis distance is computed from the covariance matrix for cells in each cluster.
  This accounts for the shape and spread of clusters when constructing the MST.
* With `use.median=TRUE`, the centroids are computed by taking the median instead of the mean.
  This protects against clusters with many outliers.

# 3 Operations on the MST

Once the MST is constructed, we can use the `guessMSTRoots()` function to guess the possible roots.
One root is guessed for each component of the MST, though the choice of root depends on the `method` in use.
For example, we can choose a root node that maximizes the steps/distance to all terminal (degree-1) nodes;
this results in fewer branch events when defining paths through the MST.

```
guessMSTRoots(mst, method="maxstep")
```

```
## [1] "2"
```

```
guessMSTRoots(mst, method="minstep")
```

```
## [1] "1"
```

Once a root is guessed, we can define paths from the root to all terminal nodes using the `defineMSTPaths()` function.
The interpretation of each path depends on the appropriateness of the chosen root;
for example, in developmental contexts, each path can be treated as a lineage if the root corresponds to some undifferentiated state.

```
defineMSTPaths(mst, roots=c("1"))
```

```
## [[1]]
## [1] "1" "2"
##
## [[2]]
## [1] "1" "3"
##
## [[3]]
## [1] "1" "4"
```

```
defineMSTPaths(mst, roots=c("2"))
```

```
## [[1]]
## [1] "2" "1" "3"
##
## [[2]]
## [1] "2" "1" "4"
```

Alternatively, if timing information is available (e.g., from an experimental time-course, or from computational methods like RNA velocity),
we can use that to define paths through the MST based on the assumed movement of cells from local minima to the nearest local maxima in time.
In the mock example below, the branch point at cluster 1 has the highest time so all paths converge from the terminal nodes to cluster 1.

```
defineMSTPaths(mst, times=c(`1`=4, `2`=0, `3`=1, `4`=0))
```

```
## [[1]]
## [1] "2" "1"
##
## [[2]]
## [1] "3" "1"
##
## [[3]]
## [1] "4" "1"
```

We can also use a root-free method of defining paths through the MST, by simply defining all unbranched segments as separate paths.
This decomposes the MST into simpler structures for, e.g., detection of marker genes, without explicitly defining a root or requiring external information.
In fact, one might prefer this approach as it allows us to interpret each section of the MST in a more modular manner,
without duplication of effort caused by the sharing of nodes across different paths from a common root.

```
splitByBranches(mst)
```

```
## [[1]]
## [1] "2" "1"
##
## [[2]]
## [1] "3" "1"
##
## [[3]]
## [1] "4" "1"
```

# 4 The `PseudotimeOrdering` class

We can create a compact representation of pseudotime orderings in the form of a matrix where rows are cells and columns are paths through the trajectory.
Each cell receives a pseudotime value along a path - or `NA`, if the cell does not lie on that path.
On occasion, we may wish to annotate this with metadata on the cells or on the paths.
This is supported by the `PseudotimeOrdering` class:

```
# Make up a matrix of pseudotime orderings.
ncells <- 200
npaths <- 5
orderings <- matrix(rnorm(1000), ncells, npaths)

# Default constructor:
(pto <- PseudotimeOrdering(orderings))
```

```
## class: PseudotimeOrdering
## dim: 200 5
## metadata(0):
## pathStats(1): ''
## cellnames: NULL
## cellData names(0):
## pathnames: NULL
## pathData names(0):
```

It is then straightforward to add metadata on the cells:

```
pto$cluster <- sample(LETTERS[1:5], ncells, replace=TRUE)
cellData(pto)
```

```
## DataFrame with 200 rows and 1 column
##         cluster
##     <character>
## 1             C
## 2             D
## 3             B
## 4             A
## 5             C
## ...         ...
## 196           E
## 197           C
## 198           C
## 199           A
## 200           A
```

Or on the paths:

```
pathData(pto)$description <- sprintf("PATH-%i", seq_len(npaths))
pathData(pto)
```

```
## DataFrame with 5 rows and 1 column
##   description
##   <character>
## 1      PATH-1
## 2      PATH-2
## 3      PATH-3
## 4      PATH-4
## 5      PATH-5
```

Additional matrices can also be added if multiple statistics are available for each cell/path combination.
For example, one might imagine assigning the confidence to which each cell is assigned to each path.

```
pathStat(pto, "confidence") <- matrix(runif(1000), ncells, npaths)
pathStatNames(pto)
```

```
## [1] ""           "confidence"
```

For convenience, we also provide the `averagePseudotime()` function to compute the average pseudotime for each cell.
This is sometimes necessary in applications that only expect a single set of pseudotime values, e.g., for visualization.

```
summary(averagePseudotime(pto))
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
## -1.37023 -0.23386  0.04180  0.02261  0.29957  1.69376
```

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
##  [1] TrajectoryUtils_1.18.0      SingleCellExperiment_1.32.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] knitr_1.50                  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4        jsonlite_2.0.0      compiler_4.5.1
##  [4] BiocManager_1.30.26 Rcpp_1.1.0          tinytex_0.57
##  [7] magick_2.9.0        jquerylib_0.1.4     yaml_2.3.10
## [10] fastmap_1.2.0       lattice_0.22-7      R6_2.6.1
## [13] XVector_0.50.0      S4Arrays_1.10.0     igraph_2.2.1
## [16] DelayedArray_0.36.0 bookdown_0.45       bslib_0.9.0
## [19] rlang_1.1.6         cachem_1.1.0        xfun_0.53
## [22] sass_0.4.10         SparseArray_1.10.0  cli_3.6.5
## [25] magrittr_2.0.4      digest_0.6.37       grid_4.5.1
## [28] lifecycle_1.0.4     glue_1.8.0          evaluate_1.0.5
## [31] abind_1.4-8         rmarkdown_2.30      pkgconfig_2.0.3
## [34] tools_4.5.1         htmltools_0.5.8.1
```