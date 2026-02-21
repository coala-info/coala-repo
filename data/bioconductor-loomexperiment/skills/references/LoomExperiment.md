# The LoomExperiment Classes

Daniel Van Twisk

#### 30 October 2025

#### Package

LoomExperiment 1.28.0

# Contents

* [1 The `LoomExperiment` class](#the-loomexperiment-class)
  + [1.1 Definition](#definition)
  + [1.2 Create instances of LoomExperiment](#create-instances-of-loomexperiment)
  + [1.3 Setting up a simple example](#setting-up-a-simple-example)
* [2 The `LoomGraph` class](#the-loomgraph-class)
* [3 The `LoomGraphs` class](#the-loomgraphs-class)
* [4 Available methods for the `LoomExperiment`](#available-methods-for-the-loomexperiment)
* [5 Session Info](#session-info)

# 1 The `LoomExperiment` class

## 1.1 Definition

The `LoomExperiment` family of classes inherits from the main class
`LoomExperiment` as well as the Experiment class that they are named
after. For example, the `SingleCellLoomExperiment` class inherits from
both `LoomExperiment` and `SingleCellExperiment`.

The purpose of the `LoomExperiment` class is to act as an intermediary
between Bioconductor’s Experiment classes and the Linnarson Lab’s Loom
File Format (<http://linnarssonlab.org/loompy/index.html>). The Loom
File Format uses HDF5 to store Experiment data.

The `LoomExperiment` family of classes contain the following slots.

* `colGraphs`
* `rowGraphs`

Both of these slots are `LoomGraphs` objects that describe the
`col_graph` and `row_graph` attributes as specified by the Loom File
Format.

## 1.2 Create instances of LoomExperiment

There are several ways to create instances of a `LoomExperiment` class
of object. One can plug an existing SummarizedExperiment type class
into the appropriate constructor:

```
library(LoomExperiment)
counts <- matrix(rpois(100, lambda = 10), ncol=10, nrow=10)
sce <- SingleCellExperiment(assays = list(counts = counts))
scle <- SingleCellLoomExperiment(sce)
## OR
scle <- LoomExperiment(sce)
```

One can also simply plug the arguments into the appropriate
constructor, since all `LoomExperiment` constructors call the
applicable class’s constructor

```
scle <- SingleCellLoomExperiment(assays = list(counts = counts))
```

Also, it is also possible to create a `LoomExperiment` extending class
via coercion:

```
scle <- as(sce, "SingleCellLoomExperiment")
scle
```

```
## class: SingleCellLoomExperiment
## dim: 10 10
## metadata(0):
## assays(1): counts
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowGraphs(0): NULL
## colGraphs(0): NULL
```

Finally, one can create a `LoomExperiment` object from importing a
Loom File.

## 1.3 Setting up a simple example

We will use the following `SingleCellLoomExperiment` for the remainder
of the vignette.

```
l1_file <-
    system.file("extdata", "L1_DRG_20_example.loom", package = "LoomExperiment")
scle <- import(l1_file, type="SingleCellLoomExperiment")
scle
```

```
## class: SingleCellLoomExperiment
## dim: 20 20
## metadata(4): CreatedWith LOOM_SPEC_VERSION LoomExperiment-class
##   MatrixName
## assays(1): matrix
## rownames: NULL
## rowData names(7): Accession Gene ... X_Total X_Valid
## colnames: NULL
## colData names(103): Age AnalysisPool ... cDNA_Lib_Ok ngperul_cDNA
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowGraphs(0): NULL
## colGraphs(2): KNN MKNN
```

All the following methods apply to all `LoomExperiment` classes.

# 2 The `LoomGraph` class

The `colGraphs` and `rowGraphs` slots of LoomExperiments correspond to
the `col_graphs` and `row_graphs` fields in the Loom File format.
Both of these slots require `LoomGraphs` objects.

A `LoomGraph` class extends the `SelfHits` class from the `S4Vectors`
package with the requirements that a `LoomGraph` object must:

* Contents must all be of class `integer` and non-negative
* Have col/row numbers corresponding to entries in the
  `LoomExperiment` object (if attached to a `LoomExperiment` object)
* May have on metadata column named ‘w’ that contains numeric elements

The columns `to` and `from` correspond to either `row` or `col`
indices in the `LoomExperiment` object while `w` is an optional column
that specifies the weight.

A LoomGraph can be constructed in two ways:

```
a <- c(1, 2, 3)
b <- c(3, 2, 1)
w <- c(100, 10, 1)
df <- DataFrame(a, b, w)
lg <- as(df, "LoomGraph")

## OR

lg <- LoomGraph(a, b, weight = w)
lg
```

```
## LoomGraph object with 3 hits and 1 metadata column:
##            from        to |         w
##       <integer> <integer> | <numeric>
##   [1]         1         3 |       100
##   [2]         2         2 |        10
##   [3]         3         1 |         1
##   -------
##   nnode: 3
```

`LoomGraph` objects can be subset by the ‘row’/‘col’ indices.

```
lg[c(1, 2)]
```

```
## LoomGraph object with 2 hits and 1 metadata column:
##            from        to |         w
##       <integer> <integer> | <numeric>
##   [1]         1         3 |       100
##   [2]         2         2 |        10
##   -------
##   nnode: 3
```

```
lg[-c(2)]
```

```
## LoomGraph object with 2 hits and 1 metadata column:
##            from        to |         w
##       <integer> <integer> | <numeric>
##   [1]         1         3 |       100
##   [2]         3         1 |         1
##   -------
##   nnode: 3
```

# 3 The `LoomGraphs` class

A `LoomGraphs` object extends the `S4Vectors:SimpleList` object. It
contains multiple `LoomGraph` objects with its only requirement being
that it must contain `LoomGraph` objects.

It can be created simply by using `LoomGraph` objects in the
`LoomGraphs` constructor

```
lgs <- LoomGraphs(lg, lg)
names(lgs) <- c('lg1', 'lg2')
lgs
```

```
## LoomGraphs of length 2
## names(2): lg1 lg2
```

# 4 Available methods for the `LoomExperiment`

The `LoomGraphs` assigned to these `colGraphs` and `rowGraphs` slots
can be obtained by their eponymous methods:

```
colGraphs(scle)
```

```
## LoomGraphs of length 2
## names(2): KNN MKNN
```

```
rowGraphs(scle)
```

```
## LoomGraphs of length 0
```

The same symbols can also be used to replace the respective `LoomGraphs`

```
colGraphs(scle) <- lgs
rowGraphs(scle) <- lgs

colGraphs(scle)
```

```
## LoomGraphs of length 2
## names(2): lg1 lg2
```

```
rowGraphs(scle)
```

```
## LoomGraphs of length 2
## names(2): lg1 lg2
```

```
colGraphs(scle)[[1]]
```

```
## LoomGraph object with 3 hits and 1 metadata column:
##            from        to |         w
##       <integer> <integer> | <numeric>
##   [1]         1         3 |       100
##   [2]         2         2 |        10
##   [3]         3         1 |         1
##   -------
##   nnode: 20
```

```
rowGraphs(scle)[[1]]
```

```
## LoomGraph object with 3 hits and 1 metadata column:
##            from        to |         w
##       <integer> <integer> | <numeric>
##   [1]         1         3 |       100
##   [2]         2         2 |        10
##   [3]         3         1 |         1
##   -------
##   nnode: 20
```

`LoomExperiment` objects can be subsetting in such a way that the
`assays`, `colGraphs`, and `rowGraphs` will all be subsetted.
`assays` will will be subsetted as any `matrix` would. The `i`
element in the subsetting operation will subset the `rowGraphs` slot
and the `j` element in the subsetting operation will subset the
`colGraphs` slot, as we’ve seen from the subsetting method from
`LoomGraphs`.

```
scle2 <- scle[c(1, 3), 1:2]
colGraphs(scle2)[[1]]
```

```
## LoomGraph object with 1 hit and 1 metadata column:
##            from        to |         w
##       <integer> <integer> | <numeric>
##   [1]         2         2 |        10
##   -------
##   nnode: 2
```

```
rowGraphs(scle2)[[1]]
```

```
## LoomGraph object with 2 hits and 1 metadata column:
##            from        to |         w
##       <integer> <integer> | <numeric>
##   [1]         1         2 |       100
##   [2]         2         1 |         1
##   -------
##   nnode: 2
```

```
scle3 <- rbind(scle, scle)
scle3
```

```
## class: SingleCellLoomExperiment
## dim: 40 20
## metadata(8): CreatedWith LOOM_SPEC_VERSION ... LoomExperiment-class
##   MatrixName
## assays(1): matrix
## rownames: NULL
## rowData names(7): Accession Gene ... X_Total X_Valid
## colnames: NULL
## colData names(103): Age AnalysisPool ... cDNA_Lib_Ok ngperul_cDNA
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowGraphs(2): lg1 lg2
## colGraphs(4): lg1 lg2 lg1 lg2
```

```
colGraphs(scle3)
```

```
## LoomGraphs of length 4
## names(4): lg1 lg2 lg1 lg2
```

```
rowGraphs(scle3)
```

```
## LoomGraphs of length 2
## names(2): lg1 lg2
```

```
colGraphs(scle3)[[1]]
```

```
## LoomGraph object with 3 hits and 1 metadata column:
##            from        to |         w
##       <integer> <integer> | <numeric>
##   [1]         1         3 |       100
##   [2]         2         2 |        10
##   [3]         3         1 |         1
##   -------
##   nnode: 20
```

```
rowGraphs(scle3)[[1]]
```

```
## LoomGraph object with 6 hits and 1 metadata column:
##            from        to |         w
##       <integer> <integer> | <numeric>
##   [1]         1         3 |       100
##   [2]         2         2 |        10
##   [3]         3         1 |         1
##   [4]        21        23 |       100
##   [5]        22        22 |        10
##   [6]        23        21 |         1
##   -------
##   nnode: 40
```

Finally, the `LoomExperiment` object can be exported.

```
temp <- tempfile(fileext='.loom')
export(scle2, temp)
```

# 5 Session Info

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
##  [1] LoomExperiment_1.28.0       BiocIO_1.20.0
##  [3] rhdf5_2.54.0                SingleCellExperiment_1.32.0
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0         generics_0.1.4
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4        jsonlite_2.0.0      compiler_4.5.1
##  [4] BiocManager_1.30.26 stringr_1.5.2       rhdf5filters_1.22.0
##  [7] jquerylib_0.1.4     yaml_2.3.10         fastmap_1.2.0
## [10] lattice_0.22-7      R6_2.6.1            XVector_0.50.0
## [13] S4Arrays_1.10.0     knitr_1.50          DelayedArray_0.36.0
## [16] bookdown_0.45       h5mread_1.2.0       bslib_0.9.0
## [19] rlang_1.1.6         stringi_1.8.7       HDF5Array_1.38.0
## [22] cachem_1.1.0        xfun_0.53           sass_0.4.10
## [25] SparseArray_1.10.0  cli_3.6.5           magrittr_2.0.4
## [28] Rhdf5lib_1.32.0     digest_0.6.37       grid_4.5.1
## [31] lifecycle_1.0.4     glue_1.8.0          evaluate_1.0.5
## [34] abind_1.4-8         rmarkdown_2.30      tools_4.5.1
## [37] htmltools_0.5.8.1
```