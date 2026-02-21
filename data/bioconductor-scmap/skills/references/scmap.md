# `scmap` package vignette

Vladimir Kiselev and Martin Hemberg

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 `SingleCellExperiment` class](#singlecellexperiment-class)
* [3 `scmap` input](#scmap-input)
* [4 Feature selection](#feature-selection)
* [5 scmap-cluster](#scmap-cluster)
  + [5.1 Index](#index)
  + [5.2 Projection](#projection)
  + [5.3 Results](#results)
  + [5.4 Visualisation](#visualisation)
* [6 scmap-cell](#scmap-cell)
  + [6.1 Stochasticity](#stochasticity)
  + [6.2 Index](#index-1)
    - [6.2.1 Sub-centroids](#sub-centroids)
    - [6.2.2 Sub-clusters](#sub-clusters)
  + [6.3 Projection](#projection-1)
  + [6.4 Results](#results-1)
  + [6.5 Cluster annotation](#cluster-annotation)
  + [6.6 Visualisation](#visualisation-1)
* [7 sessionInfo()](#sessioninfo)

# 1 Introduction

As more and more scRNA-seq datasets become available, carrying out comparisons between them is key. A central application is to compare datasets of similar biological origin collected by different labs to ensure that the annotation and the analysis is consistent. Moreover, as very large references, e.g. the Human Cell Atlas (HCA), become available, an important application will be to project cells from a new sample (e.g. from a disease tissue) onto the reference to characterize differences in composition, or to detect new cell-types.

`scmap` is a method for projecting cells from a scRNA-seq experiment on to the cell-types or cells identified in a different experiment. A copy of the `scmap` manuscript is available on [bioRxiv](http://doi.org/10.1101/150292).

# 2 `SingleCellExperiment` class

`scmap` is built on top of the Bioconductor’s [SingleCellExperiment](https://bioconductor.org/packages/SingleCellExperiment) class. Please read corresponding vignettes on how to create a `SingleCellExperiment` from your own data. Here we will show a small example on how to do that but note that it is not a comprehensive guide.

# 3 `scmap` input

If you already have a `SingleCellExperiment` object, then proceed to the next chapter.

If you have a matrix or a data frame containing expression data then you first need to create an `SingleCellExperiment` object containing your data. For illustrative purposes we will use an example expression matrix provided with `scmap`. The dataset (`yan`) represents **FPKM** gene expression of 90 cells derived from human embryo. The authors ([Yan et al.](http://dx.doi.org/10.1038/nsmb.2660)) have defined developmental stages of all cells in the original publication (`ann` data frame). We will use these stages in projection later.

```
library(SingleCellExperiment)
library(scmap)

head(ann)
```

```
##                 cell_type1
## Oocyte..1.RPKM.     zygote
## Oocyte..2.RPKM.     zygote
## Oocyte..3.RPKM.     zygote
## Zygote..1.RPKM.     zygote
## Zygote..2.RPKM.     zygote
## Zygote..3.RPKM.     zygote
```

```
yan[1:3, 1:3]
```

```
##          Oocyte..1.RPKM. Oocyte..2.RPKM. Oocyte..3.RPKM.
## C9orf152             0.0             0.0             0.0
## RPS11             1219.9          1021.1           931.6
## ELMO2                7.0            12.2             9.3
```

Note that the cell type information has to be stored in the `cell_type1` column of the `rowData` slot of the `SingleCellExperiment` object.

Now let’s create a `SingleCellExperiment` object of the `yan` dataset:

```
sce <- SingleCellExperiment(assays = list(normcounts = as.matrix(yan)), colData = ann)
logcounts(sce) <- log2(normcounts(sce) + 1)
# use gene names as feature symbols
rowData(sce)$feature_symbol <- rownames(sce)
# remove features with duplicated names
sce <- sce[!duplicated(rownames(sce)), ]
sce
```

```
## class: SingleCellExperiment
## dim: 20214 90
## metadata(0):
## assays(2): normcounts logcounts
## rownames(20214): C9orf152 RPS11 ... CTSC AQP7
## rowData names(1): feature_symbol
## colnames(90): Oocyte..1.RPKM. Oocyte..2.RPKM. ...
##   Late.blastocyst..3..Cell.7.RPKM. Late.blastocyst..3..Cell.8.RPKM.
## colData names(1): cell_type1
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

# 4 Feature selection

Once we have a `SingleCellExperiment` object we can run `scmap`. Firstly, we need to select the most informative features (genes) from our input dataset:

```
sce <- selectFeatures(sce, suppress_plot = FALSE)
```

```
## Warning in linearModel(object, n_features): Your object does not contain
## counts() slot. Dropouts were calculated using logcounts() slot...
```

![](data:image/png;base64...)

Features highlighted with the red colour will be used in the futher analysis (projection).

Features are stored in the `scmap_features` column of the `rowData` slot of the input object. By default `scmap` selects \(500\) features (it can also be controlled by setting n\_features parameter):

```
table(rowData(sce)$scmap_features)
```

```
##
## FALSE  TRUE
## 19714   500
```

# 5 scmap-cluster

## 5.1 Index

The `scmap-cluster` index of a reference dataset is created by finding the median gene expression for each cluster. By default `scmap` uses the `cell_type1` column of the `colData` slot in the reference to identify clusters. Other columns can be manually selected by adjusting `cluster_col` parameter:

```
sce <- indexCluster(sce)
```

The function `indexCluster` automatically writes the `scmap_cluster_index` item of the metadata slot of the reference dataset.

```
head(metadata(sce)$scmap_cluster_index)
```

```
##           zygote     2cell    4cell     8cell   16cell    blast
## ABCB4   5.788589 6.2258580 5.935134 0.6667119 0.000000 0.000000
## ABCC6P1 7.863625 7.7303559 8.322769 7.4303689 4.759867 0.000000
## ABT1    0.320773 0.1315172 0.000000 5.9787977 6.100671 4.627798
## ACCSL   7.922318 8.4274290 9.662611 4.5869260 1.768026 0.000000
## ACOT11  0.000000 0.0000000 0.000000 6.4677243 7.147798 4.057444
## ACOT9   4.877394 4.2196038 5.446969 4.0685468 3.827819 0.000000
```

One can also visualise the index:

```
heatmap(as.matrix(metadata(sce)$scmap_cluster_index))
```

![](data:image/png;base64...)

## 5.2 Projection

Once the `scmap-cluster` index has been generated we can use it to project our dataset to itself (just for illustrative purposes). This can be done with one index at a time, but `scmap` also allows for simultaneous projection to multiple indexes if they are provided as a list:

```
scmapCluster_results <- scmapCluster(
  projection = sce,
  index_list = list(
    yan = metadata(sce)$scmap_cluster_index
  )
)
```

## 5.3 Results

`scmap-cluster` projects the query dataset to all projections defined in the index\_list. The results of cell label assignements are merged into one matrix:

```
head(scmapCluster_results$scmap_cluster_labs)
```

```
##      yan
## [1,] "zygote"
## [2,] "zygote"
## [3,] "zygote"
## [4,] "2cell"
## [5,] "2cell"
## [6,] "2cell"
```

Corresponding similarities are stored in the scmap\_cluster\_siml item:

```
head(scmapCluster_results$scmap_cluster_siml)
```

```
##            yan
## [1,] 0.9947609
## [2,] 0.9951257
## [3,] 0.9955916
## [4,] 0.9934012
## [5,] 0.9953694
## [6,] 0.9871041
```

`scmap` also provides combined results of all reference dataset (choose labels corresponding to the largest similarity across reference datasets):

```
head(scmapCluster_results$combined_labs)
```

```
## [1] "zygote" "zygote" "zygote" "2cell"  "2cell"  "2cell"
```

## 5.4 Visualisation

The results of `scmap-cluster` can be visualized as a Sankey diagram to show how cell-clusters are matched (`getSankey()` function). Note that the Sankey diagram will only be informative if both the query and the reference datasets have been clustered, but it is not necessary to have meaningful labels assigned to the query (`cluster1`, `cluster2` etc. is sufficient):

```
plot(
  getSankey(
    colData(sce)$cell_type1,
    scmapCluster_results$scmap_cluster_labs[,'yan'],
    plot_height = 400
  )
)
```

# 6 scmap-cell

In contrast to `scmap-cluster`, `scmap-cell` projects cells of the input dataset to the individual cells of the reference and not to the cell clusters.

## 6.1 Stochasticity

`scmap-cell` contains k-means step which makes it stochastic, i.e. running it multiple times will provide slightly different results. Therefore, we will fix a random seed, so that a user will be able to exactly reproduce our results:

```
set.seed(1)
```

## 6.2 Index

In the `scmap-cell` index is created by a product quantiser algorithm in a way that every cell in the reference is identified with a set of sub-centroids found via k-means clustering based on a subset of the features.

```
sce <- indexCell(sce)
```

Unlike `scmap-cluster` index `scmap-cell` index contains information about each cell and therefore can not be easily visualised. `scmap-cell` index consists of two items:

```
names(metadata(sce)$scmap_cell_index)
```

```
## [1] "subcentroids" "subclusters"
```

### 6.2.1 Sub-centroids

`subcentroids` contains coordinates of subcentroids of low dimensional subspaces defined by selected features, `k` and `M` parameters of the product quantiser algorithm (see `?indexCell`).

```
length(metadata(sce)$scmap_cell_index$subcentroids)
```

```
## [1] 50
```

```
dim(metadata(sce)$scmap_cell_index$subcentroids[[1]])
```

```
## [1] 10  9
```

```
metadata(sce)$scmap_cell_index$subcentroids[[1]][,1:5]
```

```
##                    1         2          3          4         5
## ZAR1L    0.072987697 0.2848353 0.33713297 0.26694708 0.3051086
## SERPINF1 0.179135680 0.3784345 0.35886481 0.39453521 0.4326297
## GRB2     0.439712934 0.4246024 0.23308320 0.43238208 0.3247221
## GSTP1    0.801498298 0.1464230 0.14880665 0.19900079 0.0000000
## ABCC6P1  0.005544482 0.4358565 0.46276591 0.40280401 0.3989602
## ARGFX    0.341212258 0.4284664 0.07629512 0.47961460 0.1296112
## DCT      0.004323311 0.1943568 0.32117489 0.21259776 0.3836451
## C15orf60 0.006681366 0.1862540 0.28346531 0.01123282 0.1096438
## SVOPL    0.003004345 0.1548237 0.33551596 0.12691677 0.2525819
## NLRP9    0.101524942 0.3223963 0.40624639 0.30465156 0.4640308
```

In the case of our `yan` dataset:

* `yan` dataset contains \(N = 90\) cells
* We selected \(f = 500\) features (`scmap` default)
* `M` was calculated as \(f / 10 = 50\) (`scmap` default for \(f \le 1000\)). `M` is the number of low dimensional subspaces
* Number of features in any low dimensional subspace equals to \(f / M = 10\)
* `k` was calculated as \(k = \sqrt{N} \approx 9\) (`scmap` default).

### 6.2.2 Sub-clusters

`subclusters` contains for every low dimensial subspace indexies of `subcentroids` which a given cell belongs to:

```
dim(metadata(sce)$scmap_cell_index$subclusters)
```

```
## [1] 50 90
```

```
metadata(sce)$scmap_cell_index$subclusters[1:5,1:5]
```

```
##      Oocyte..1.RPKM. Oocyte..2.RPKM. Oocyte..3.RPKM. Zygote..1.RPKM.
## [1,]               6               6               6               6
## [2,]               5               5               5               5
## [3,]               5               5               5               5
## [4,]               3               3               3               3
## [5,]               6               6               6               6
##      Zygote..2.RPKM.
## [1,]               6
## [2,]               5
## [3,]               5
## [4,]               3
## [5,]               6
```

## 6.3 Projection

Once the `scmap-cell` indexes have been generated we can use them to project the `baron` dataset. This can be done with one index at a time, but `scmap` allows for simultaneous projection to multiple indexes if they are provided as a list:

```
scmapCell_results <- scmapCell(
  sce,
  list(
    yan = metadata(sce)$scmap_cell_index
  )
)
```

## 6.4 Results

`scmapCell_results` contains results of projection for each reference dataset in a list:

```
names(scmapCell_results)
```

```
## [1] "yan"
```

For each dataset there are two matricies. `cells` matrix contains the top 10 (`scmap` default) cell IDs of the cells of the reference dataset that a given cell of the projection dataset is closest to:

```
scmapCell_results$yan$cells[,1:3]
```

```
##       Oocyte..1.RPKM. Oocyte..2.RPKM. Oocyte..3.RPKM.
##  [1,]               1               1               1
##  [2,]               2               2               2
##  [3,]               3               3               3
##  [4,]              11              11              11
##  [5,]               5               5               5
##  [6,]               6               6               6
##  [7,]               7               7               7
##  [8,]              12               8              12
##  [9,]               9               9               9
## [10,]              10              10              10
```

`similarities` matrix contains corresponding cosine similarities:

```
scmapCell_results$yan$similarities[,1:3]
```

```
##       Oocyte..1.RPKM. Oocyte..2.RPKM. Oocyte..3.RPKM.
##  [1,]       0.9742737       0.9736593       0.9748542
##  [2,]       0.9742274       0.9737083       0.9748995
##  [3,]       0.9742274       0.9737083       0.9748995
##  [4,]       0.9693955       0.9684169       0.9697731
##  [5,]       0.9698173       0.9688538       0.9701976
##  [6,]       0.9695394       0.9685904       0.9699759
##  [7,]       0.9694336       0.9686058       0.9699198
##  [8,]       0.9694091       0.9684312       0.9697699
##  [9,]       0.9692544       0.9684312       0.9697358
## [10,]       0.9694336       0.9686058       0.9699198
```

## 6.5 Cluster annotation

If cell cluster annotation is available for the reference datasets, in addition to finding top 10 nearest neighbours `scmap-cell` also allows to annotate cells of the projection dataset using labels of the reference. It does so by looking at the top 3 nearest neighbours (`scmap` default) and if they all belong to the same cluster in the reference and their maximum similarity is higher than a threshold (\(0.5\) is the `scmap` default) a projection cell is assigned to a corresponding reference cluster:

```
scmapCell_clusters <- scmapCell2Cluster(
  scmapCell_results,
  list(
    as.character(colData(sce)$cell_type1)
  )
)
```

`scmap-cell` results are in the same format as the ones provided by `scmap-cluster` (see above):

```
head(scmapCell_clusters$scmap_cluster_labs)
```

```
##      yan
## [1,] "zygote"
## [2,] "zygote"
## [3,] "zygote"
## [4,] "unassigned"
## [5,] "unassigned"
## [6,] "unassigned"
```

Corresponding similarities are stored in the `scmap_cluster_siml` item:

```
head(scmapCell_clusters$scmap_cluster_siml)
```

```
##            yan
## [1,] 0.9742737
## [2,] 0.9737083
## [3,] 0.9748995
## [4,]        NA
## [5,]        NA
## [6,]        NA
```

```
head(scmapCell_clusters$combined_labs)
```

```
## [1] "zygote"     "zygote"     "zygote"     "unassigned" "unassigned"
## [6] "unassigned"
```

## 6.6 Visualisation

```
plot(
  getSankey(
    colData(sce)$cell_type1,
    scmapCell_clusters$scmap_cluster_labs[,"yan"],
    plot_height = 400
  )
)
```

# 7 sessionInfo()

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
##  [1] scmap_1.32.0                SingleCellExperiment_1.32.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] googleVis_0.7.3             BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6         xfun_0.53            bslib_0.9.0
##  [4] ggplot2_4.0.0        lattice_0.22-7       vctrs_0.6.5
##  [7] tools_4.5.1          tibble_3.3.0         proxy_0.4-27
## [10] pkgconfig_2.0.3      Matrix_1.7-4         RColorBrewer_1.1-3
## [13] S7_0.2.0             lifecycle_1.0.4      compiler_4.5.1
## [16] farver_2.1.2         stringr_1.5.2        tinytex_0.57
## [19] codetools_0.2-20     htmltools_0.5.8.1    class_7.3-23
## [22] sass_0.4.10          yaml_2.3.10          pillar_1.11.1
## [25] jquerylib_0.1.4      DelayedArray_0.36.0  cachem_1.1.0
## [28] magick_2.9.0         abind_1.4-8          tidyselect_1.2.1
## [31] digest_0.6.37        stringi_1.8.7        dplyr_1.1.4
## [34] reshape2_1.4.4       bookdown_0.45        labeling_0.4.3
## [37] fastmap_1.2.0        grid_4.5.1           cli_3.6.5
## [40] SparseArray_1.10.0   magrittr_2.0.4       S4Arrays_1.10.0
## [43] dichromat_2.0-0.1    randomForest_4.7-1.2 e1071_1.7-16
## [46] withr_3.0.2          scales_1.4.0         rmarkdown_2.30
## [49] XVector_0.50.0       evaluate_1.0.5       knitr_1.50
## [52] rlang_1.1.6          Rcpp_1.1.0           glue_1.8.0
## [55] BiocManager_1.30.26  jsonlite_2.0.0       R6_2.6.1
## [58] plyr_1.8.9
```