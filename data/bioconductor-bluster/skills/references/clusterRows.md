# Flexible clustering for Bioconductor

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### 29 October 2025

#### Package

bluster 1.20.0

# Contents

* [1 Introduction](#introduction)
* [2 Based on distance matrices](#based-on-distance-matrices)
  + [2.1 Hierarchical clustering](#hierarchical-clustering)
  + [2.2 Affinity propagation](#affinity-propagation)
* [3 With a fixed number of clusters](#with-a-fixed-number-of-clusters)
  + [3.1 \(k\)-means clustering](#k-means-clustering)
  + [3.2 Self-organizing maps](#self-organizing-maps)
* [4 Graph-based clustering](#graph-based-clustering)
* [5 Density-based clustering](#density-based-clustering)
* [6 Two-phase clustering](#two-phase-clustering)
* [7 Obtaining full clustering statistics](#obtaining-full-clustering-statistics)
* [8 Further comments](#further-comments)
* [Session information](#session-information)

# 1 Introduction

The *[bluster](https://bioconductor.org/packages/3.22/bluster)* package provides a flexible and extensible framework for clustering in Bioconductor packages/workflows.
At its core is the `clusterRows()` generic that controls dispatch to different clustering algorithms.
We will demonstrate on some single-cell RNA sequencing data from the *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* package;
our aim is to cluster cells into cell populations based on their PC coordinates.

```
library(scRNAseq)
sce <- ZeiselBrainData()

# Trusting the authors' quality control, and going straight to normalization.
library(scuttle)
sce <- logNormCounts(sce)

# Feature selection based on highly variable genes.
library(scran)
dec <- modelGeneVar(sce)
hvgs <- getTopHVGs(dec, n=1000)

# Dimensionality reduction for work (PCA) and pleasure (t-SNE).
set.seed(1000)
library(scater)
sce <- runPCA(sce, ncomponents=20, subset_row=hvgs)
sce <- runUMAP(sce, dimred="PCA")

mat <- reducedDim(sce, "PCA")
dim(mat)
```

```
## [1] 3005   20
```

# 2 Based on distance matrices

## 2.1 Hierarchical clustering

Our first algorithm is good old hierarchical clustering, as implemented using `hclust()` from the *stats* package.
This automatically sets the cut height to half the dendrogram height.

```
library(bluster)
hclust.out <- clusterRows(mat, HclustParam())
plotUMAP(sce, colour_by=I(hclust.out))
```

![](data:image/png;base64...)

Advanced users can achieve greater control of the procedure by passing more parameters to the `HclustParam()` constructor.
Here, we use Ward’s criterion for the agglomeration with a dynamic tree cut from the *[dynamicTreeCut](https://CRAN.R-project.org/package%3DdynamicTreeCut)* package.

```
hp2 <- HclustParam(method="ward.D2", cut.dynamic=TRUE)
hp2
```

```
## class: HclustParam
## metric: [default]
## method: ward.D2
## cut.fun: cutreeDynamic
## cut.params(0):
## dist.fun: stats::dist
## clust.fun: stats::hclust
```

```
hclust.out <- clusterRows(mat, hp2)
plotUMAP(sce, colour_by=I(hclust.out))
```

![](data:image/png;base64...)

## 2.2 Affinity propagation

Another option is to use affinity propagation, as implemented using the *[apcluster](https://CRAN.R-project.org/package%3Dapcluster)* package.
Here, messages are passed between observations to decide on a set of exemplars, each of which form the center of a cluster.

This is not particularly fast as it involves the calculation of a square similarity matrix between all pairs of observations.
So, we’ll speed it up by taking analyzing a subset of the data:

```
set.seed(1000)
sub <- sce[,sample(ncol(sce), 200)]
ap.out <- clusterRows(reducedDim(sub), AffinityParam())
plotUMAP(sub, colour_by=I(ap.out))
```

![](data:image/png;base64...)

The `q` parameter is probably the most important and determines the resolution of the clustering.
This can be set to any value below 1, with smaller (possibly negative) values corresponding to coarser clusters.

```
set.seed(1000)
ap.out <- clusterRows(reducedDim(sub), AffinityParam(q=-2))
plotUMAP(sub, colour_by=I(ap.out))
```

![](data:image/png;base64...)

# 3 With a fixed number of clusters

## 3.1 \(k\)-means clustering

A classic algorithm is \(k\)-means clustering, as implemented using the `kmeans()` function.
This requires us to pass in the number of clusters, either as a number:

```
set.seed(100)
kmeans.out <- clusterRows(mat, KmeansParam(10))
plotUMAP(sce, colour_by=I(kmeans.out))
```

![](data:image/png;base64...)

Or as a function of the number of observations, which is useful for vector quantization purposes:

```
kp <- KmeansParam(sqrt)
kp
```

```
## class: KmeansParam
## centers: variable
## iter.max: 10
## nstart: 1
## algorithm: Hartigan-Wong
```

```
set.seed(100)
kmeans.out <- clusterRows(mat, kp)
plotUMAP(sce, colour_by=I(kmeans.out))
```

![](data:image/png;base64...)

A variant of this approach is mini-batch \(k\)-means, as implemented in the *[mbkmeans](https://bioconductor.org/packages/3.22/mbkmeans)* package.
This uses mini-batching to approximate the full \(k\)-means algorithm for greater speed.

```
set.seed(100)
mbkmeans.out <- clusterRows(mat, MbkmeansParam(20))
plotUMAP(sce, colour_by=I(mbkmeans.out))
```

![](data:image/png;base64...)

## 3.2 Self-organizing maps

We can also use self-organizing maps (SOMs) from the *[kohonen](https://CRAN.R-project.org/package%3Dkohonen)* package.
This allocates observations to nodes of a simple neural network; each node is then treated as a cluster.

```
set.seed(1000)
som.out <- clusterRows(mat, SomParam(20))
plotUMAP(sce, colour_by=I(som.out))
```

![](data:image/png;base64...)

The key feature of SOMs is that they apply additional topological constraints on the relative positions of the nodes.
This allows us to naturally determine the relationships between clusters based on the proximity of the nodes.

```
set.seed(1000)
som.out <- clusterRows(mat, SomParam(100), full=TRUE)

par(mfrow=c(1,2))
plot(som.out$objects$som, "counts")
grid <- som.out$objects$som$grid$pts
text(grid[,1], grid[,2], seq_len(nrow(grid)))
```

![](data:image/png;base64...)

# 4 Graph-based clustering

We can build shared or direct nearest neighbor graphs and perform community detection with *[igraph](https://CRAN.R-project.org/package%3Digraph)*.
Here, the number of neighbors `k` controls the resolution of the clusters.

```
set.seed(101) # just in case there are ties.
graph.out <- clusterRows(mat, NNGraphParam(k=10))
plotUMAP(sce, colour_by=I(graph.out))
```

![](data:image/png;base64...)

It is again straightforward to tune the procedure by passing more arguments such as the community detection algorithm to use.

```
set.seed(101) # just in case there are ties.
np <- NNGraphParam(k=20, cluster.fun="louvain")
np
```

```
## class: SNNGraphParam
## k: 20
## type: rank
## BNPARAM: KmknnParam
## num.threads: 1
## cluster.fun: louvain
## cluster.args(0):
```

```
graph.out <- clusterRows(mat, np)
plotUMAP(sce, colour_by=I(graph.out))
```

![](data:image/png;base64...)

# 5 Density-based clustering

We also implement a version of the DBSCAN algorithm for density-based clustering.
This focuses on identifying masses of continuous density.

```
dbscan.out <- clusterRows(mat, DbscanParam())
plotUMAP(sce, colour_by=I(dbscan.out))
```

![](data:image/png;base64...)

Unlike the other methods, it will consider certain points to be noise and discard them from the output.

```
summary(is.na(dbscan.out))
```

```
##    Mode   FALSE    TRUE
## logical    1789    1216
```

The resolution of the clustering can be modified by tinkering with the `core.prop`.
Smaller values will generally result in smaller clusters as well as more noise points.

```
dbscan.out <- clusterRows(mat, DbscanParam(core.prop=0.1))
summary(is.na(dbscan.out))
```

```
##    Mode   FALSE    TRUE
## logical     565    2440
```

# 6 Two-phase clustering

We also provide a wrapper for a hybrid “two-step” approach for handling larger datasets.
Here, a fast agglomeration is performed with \(k\)-means to compact the data,
followed by a slower graph-based clustering step to obtain interpretable meta-clusters.
(This dataset is not, by and large, big enough for this approach to work particularly well.)

```
set.seed(100) # for the k-means
two.out <- clusterRows(mat, TwoStepParam())
plotUMAP(sce, colour_by=I(two.out))
```

![](data:image/png;base64...)

Each step is itself parametrized by `BlusterParam` objects, so it is possible to tune them individually:

```
twop <- TwoStepParam(second=NNGraphParam(k=5))
twop
```

```
## class: TwoStepParam
## first:
##   class: KmeansParam
##   centers: variable
##   iter.max: 10
##   nstart: 1
##   algorithm: Hartigan-Wong
## second:
##   class: SNNGraphParam
##   k: 5
##   type: rank
##   BNPARAM: KmknnParam
##   num.threads: 1
##   cluster.fun: walktrap
##   cluster.args(0):
```

```
set.seed(100) # for the k-means
two.out <- clusterRows(mat, TwoStepParam())
plotUMAP(sce, colour_by=I(two.out))
```

![](data:image/png;base64...)

# 7 Obtaining full clustering statistics

Sometimes the vector of cluster assignments is not enough.
We can obtain more information about the clustering procedure by setting `full=TRUE` in `clusterRows()`.
For example, we could obtain the actual graph generated by `NNGraphParam()`:

```
nn.out <- clusterRows(mat, NNGraphParam(), full=TRUE)
nn.out$objects$graph
```

```
## IGRAPH f76614b U-W- 3005 87028 --
## + attr: weight (e/n)
## + edges from f76614b:
##  [1]  1-- 2  1-- 3  2-- 3  1-- 4  2-- 4  3-- 4  4-- 5  1-- 5  2-- 5  3-- 5
## [11]  1-- 6  2-- 6  3-- 6  4-- 6  5-- 6  1-- 7  5-- 7  6-- 7  2-- 7  4-- 7
## [21]  3-- 7  3-- 8  1-- 8  2-- 8  4-- 8  6-- 8  7-- 8  5-- 8  1-- 9  2-- 9
## [31]  4-- 9  5-- 9  7-- 9  3-- 9  6-- 9  8-- 9  1--10  5--10  9--10  3--10
## [41]  4--10  3--11  9--11 10--11  1--11  5--11  2--13  5--13  6--13  7--13
## [51] 12--13  8--13 12--14 13--14 12--15 13--15 14--15  2--15  5--15  6--15
## [61]  7--15 12--16 13--16 14--16 15--16 14--17 12--17 15--17 16--17 13--17
## [71] 12--18 14--18 15--18 16--18 13--18 17--18 19--20 12--20 14--20 15--20
## + ... omitted several edges
```

The assignment vector is still reported in the `clusters` entry:

```
table(nn.out$clusters)
```

```
##
##   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19
## 166 216 256 543 218  89 583  92 123 186  91  42  94  64  58  58  60  35  31
```

# 8 Further comments

`clusterRows()` enables users or developers to easily switch between clustering algorithms by changing a single argument.
Indeed, by passing the `BlusterParam` object across functions, we can ensure that the same algorithm is used through a workflow.
It is also helpful for package functions as it provides diverse functionality without compromising a clean function signature.
However, the true power of this framework lies in its extensibility.
Anyone can write a `clusterRows()` method for a new clustering algorithm with an associated `BlusterParam` subclass,
and that procedure is immediately compatible with any workflow or function that was already using `clusterRows()`.

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
##  [1] bluster_1.20.0              scater_1.38.0
##  [3] ggplot2_4.0.0               scran_1.38.0
##  [5] scuttle_1.20.0              scRNAseq_2.23.1
##  [7] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0               IRanges_2.44.0
## [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [15] generics_0.1.4              MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       jsonlite_2.0.0           magrittr_2.0.4
##   [4] magick_2.9.0             ggbeeswarm_0.7.2         GenomicFeatures_1.62.0
##   [7] gypsum_1.6.0             farver_2.1.2             rmarkdown_2.30
##  [10] BiocIO_1.20.0            vctrs_0.6.5              memoise_2.0.1
##  [13] Rsamtools_2.26.0         RCurl_1.98-1.17          benchmarkme_1.0.8
##  [16] tinytex_0.57             htmltools_0.5.8.1        S4Arrays_1.10.0
##  [19] dynamicTreeCut_1.63-1    AnnotationHub_4.0.0      curl_7.0.0
##  [22] BiocNeighbors_2.4.0      Rhdf5lib_1.32.0          SparseArray_1.10.0
##  [25] rhdf5_2.54.0             sass_0.4.10              alabaster.base_1.10.0
##  [28] bslib_0.9.0              alabaster.sce_1.10.0     httr2_1.2.1
##  [31] cachem_1.1.0             GenomicAlignments_1.46.0 igraph_2.2.1
##  [34] iterators_1.0.14         lifecycle_1.0.4          pkgconfig_2.0.3
##  [37] rsvd_1.0.5               Matrix_1.7-4             R6_2.6.1
##  [40] fastmap_1.2.0            digest_0.6.37            AnnotationDbi_1.72.0
##  [43] dqrng_0.4.1              irlba_2.3.5.1            ExperimentHub_3.0.0
##  [46] RSQLite_2.4.3            beachmat_2.26.0          labeling_0.4.3
##  [49] filelock_1.0.3           httr_1.4.7               abind_1.4-8
##  [52] compiler_4.5.1           doParallel_1.0.17        bit64_4.6.0-1
##  [55] withr_3.0.2              S7_0.2.0                 BiocParallel_1.44.0
##  [58] viridis_0.6.5            DBI_1.2.3                apcluster_1.4.14
##  [61] HDF5Array_1.38.0         alabaster.ranges_1.10.0  alabaster.schemas_1.10.0
##  [64] rappdirs_0.3.3           DelayedArray_0.36.0      rjson_0.2.23
##  [67] tools_4.5.1              vipor_0.4.7              mbkmeans_1.26.0
##  [70] beeswarm_0.4.0           glue_1.8.0               h5mread_1.2.0
##  [73] restfulr_0.0.16          rhdf5filters_1.22.0      grid_4.5.1
##  [76] cluster_2.1.8.1          gtable_0.3.6             ensembldb_2.34.0
##  [79] BiocSingular_1.26.0      ScaledMatrix_1.18.0      metapod_1.18.0
##  [82] XVector_0.50.0           foreach_1.5.2            ggrepel_0.9.6
##  [85] BiocVersion_3.22.0       pillar_1.11.1            limma_3.66.0
##  [88] benchmarkmeData_1.0.4    dplyr_1.1.4              BiocFileCache_3.0.0
##  [91] lattice_0.22-7           gmp_0.7-5                FNN_1.1.4.1
##  [94] rtracklayer_1.70.0       bit_4.6.0                tidyselect_1.2.1
##  [97] locfit_1.5-9.12          Biostrings_2.78.0        knitr_1.50
## [100] gridExtra_2.3            bookdown_0.45            ProtGenerics_1.42.0
## [103] edgeR_4.8.0              xfun_0.53                statmod_1.5.1
## [106] UCSC.utils_1.6.0         lazyeval_0.2.2           yaml_2.3.10
## [109] evaluate_1.0.5           codetools_0.2-20         cigarillo_1.0.0
## [112] tibble_3.3.0             alabaster.matrix_1.10.0  BiocManager_1.30.26
## [115] cli_3.6.5                uwot_0.2.3               jquerylib_0.1.4
## [118] dichromat_2.0-0.1        Rcpp_1.1.0               GenomeInfoDb_1.46.0
## [121] dbplyr_2.5.1             png_0.1-8                kohonen_3.0.12
## [124] XML_3.99-0.19            parallel_4.5.1           blob_1.2.4
## [127] ClusterR_1.3.5           AnnotationFilter_1.34.0  bitops_1.0-9
## [130] viridisLite_0.4.2        alabaster.se_1.10.0      scales_1.4.0
## [133] crayon_1.5.3             rlang_1.1.6              cowplot_1.2.0
## [136] KEGGREST_1.50.0
```