# DelayedDataFrame: an on-disk represention of DataFrame

Qian Liu1, Hervé Pagès2 and Martin Morgan1

1Roswell Park Comprehensive Cancer Center, Buffalo, NY
2Fred Hutchinson Cancer Research Center, Seattle, WA

#### last edit: 10/15/2021

#### Package

DelayedDataFrame 1.26.0

# 1 Introduction

As the genetic/genomic data are having increasingly larger profile,
the annotation file are also getting much bigger than expected. the
memory space in *R* has been an obstable for fast and efficient data
processing, because most available *R* or *Bioconductor* packages are
developed based on in-memory data manipulation. With some newly
developed data structure as [HDF5](https://www.hdfgroup.org/solutions/hdf5/) or [GDS](http://corearray.sourceforge.net/), and the *R* interface
of [DelayedArray](https://bioconductor.org/packages/DelayedArray) to represent on-disk data structures with
different back-end in *R*-user-friendly array data structure (e.g.,
[HDF5Array](https://bioconductor.org/packages/HDF5Array),[GDSArray](https://bioconductor.org/packages/GDSArray)), the high-throughput genetic/genomic data
are now being able to easily loaded and manipulated within
*R*. However, the annotation files for the samples and features inside
the high-through data are also getting unexpectedly larger than
before. With an ordinary `data.frame` or `DataFrame`, it is still
getting more and more challenging for any analysis to be done within
*R*. So here we have developed the `DelayedDataFrame`, which has the
very similar characteristics as `data.frame` and `DataFrame`. But at
the same time, all column data could be optionally saved on-disk
(e.g., in [DelayedArray](https://bioconductor.org/packages/DelayedArray) structure with any back-end). Common
operations like constructing, subsetting, splitting, combining could
be done in the same way as `DataFrame`. This feature of
`DelayedDataFrame` could enable efficient on-disk reading and
processing of the large-scale annotation files, and at the same,
signicantly saves memory space with common `DataFrame` metaphor in *R*
and *Bioconductor*.

# 2 Installation

Download the package from *Bioconductor*:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DelayedDataFrame")
```

The development version is also available to download through github:

```
BiocManager::install("Bioconductor/DelayedDataFrame")
```

Load the package into *R* session before using:

```
library(DelayedDataFrame)
```

# 3 DelayedDataFrame class

## 3.1 class extension

`DelayedDataFrame` extends the `DataFrame` data structure, with an
additional slot called `lazyIndex`, which saves all the mapping
indexes for each column of the data inside `DelayedDataFrame`. It is
similar to `data.frame` in terms of construction, subsetting,
splitting, combining… The `rownames` are having same feature as
`DataFrame`. It will not be given automatically, but only by
explicitly specify in the constructor function `DelayedDataFrame(, row.names=...)` or using the slot setter function `rownames()<-`.

Here we use the [GDSArray](https://bioconductor.org/packages/GDSArray) data as example to show the
`DelayedDataFrame` characteristics. [GDSArray](https://bioconductor.org/packages/GDSArray) is a *Bioconductor*
package that represents GDS files as objects derived from the
[DelayedArray](https://bioconductor.org/packages/DelayedArray) package and `DelayedArray` class. It carries the
on-disk data path and represent the GDS nodes in a
`DelayedArray`-derived data structure.

The `GDSArray()` constructor takes 2 arguments: the file path and the
GDS node name inside the GDS file.

```
library(GDSArray)
## Loading required package: gdsfmt
file <- SeqArray::seqExampleFileName("gds")
gdsnodes(file)
##  [1] "sample.id"                  "variant.id"
##  [3] "position"                   "chromosome"
##  [5] "allele"                     "genotype/data"
##  [7] "genotype/~data"             "genotype/extra.index"
##  [9] "genotype/extra"             "phase/data"
## [11] "phase/~data"                "phase/extra.index"
## [13] "phase/extra"                "annotation/id"
## [15] "annotation/qual"            "annotation/filter"
## [17] "annotation/info/AA"         "annotation/info/AC"
## [19] "annotation/info/AN"         "annotation/info/DP"
## [21] "annotation/info/HM2"        "annotation/info/HM3"
## [23] "annotation/info/OR"         "annotation/info/GP"
## [25] "annotation/info/BN"         "annotation/format/DP/data"
## [27] "annotation/format/DP/~data" "sample.annotation/family"
varid <- GDSArray(file, "annotation/id")
DP <- GDSArray(file, "annotation/info/DP")
```

We use an ordinary character vector and the `GDSArray` objects to
construct a `DelayedDataFrame` object.

```
ddf <- DelayedDataFrame(varid, DP)  ## only accommodate 1D GDSArrays with same length
```

## 3.2 slot accessors

The slots of `DelayedDataFrame` could be accessed by `lazyIndex()`,
`nrow()`, `rownames()` (if not NULL) functions. With a newly
constructed `DelayedDataFrame` object, the initial value of
`lazyIndex` slot will be NULL for all columns.

```
lazyIndex(ddf)
## LazyIndex of length 1
## [[1]]
## NULL
##
## index of each column:
## [1] 1 1
nrow(ddf)
## [1] 1348
rownames(ddf)
## NULL
```

## 3.3 `lazyIndex` slot

The `lazyIndex` slot is in `LazyIndex` class, which is defined in the
`DelayedDataFrame` package and extends the `SimpleList` class. The
`listData` slot saves unique indexes for all the columns, and the
`index` slots saves the position of index in `listData` slot for each
column in `DelayedDataFrame` object. In the above example, with an
initial construction of `DelayedDataFrame` object, the index for each
column will all be NULL, and all 3 columns points the NULL values
which sits in the first position in `listData` slot of `lazyIndex`.

```
lazyIndex(ddf)@listData
## [[1]]
## NULL
lazyIndex(ddf)@index
## [1] 1 1
```

Whenever an operation is done (e.g., subsetting), the `listData` slot
inside the `DelayedDataFrame` stays the same, but the `lazyIndex` slot
will be updated, so that the show method, further statistical
calculation will be applied to the subsetting data set. For example,
here we subset the `DelayedDataFrame` object `ddf` to keep only the
first 5 rows, and see how the `lazyIndex` works. As shown in below,
after subsetting, the `listData` slot in `ddf1` stays the same as
`ddf`. But the subsetting operation was recorded in the `lazyIndex`
slot, and the slots of `lazyIndex`, `nrows` and `rownames` (if not
NULL) are all updated. So the subsetting operation is kind of
`delayed`.

```
ddf1 <- ddf[1:20,]
identical(ddf@listData, ddf1@listData)
## [1] TRUE
lazyIndex(ddf1)
## LazyIndex of length 1
## [[1]]
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
##
## index of each column:
## [1] 1 1
nrow(ddf1)
## [1] 20
```

Only when functions like `DataFrame()`, or `as.list()`, the
`lazyIndex` will be realized and `DelayedDataFrame` returned.
We will show the realization in the following coercion method section.

# 4 DelayedDataFrame methods

The common methods on `data.frame` or `DataFrame` are also defined on
`DelayedDataFrame` class, so that they behave similarily on
`DelayedDataFrame` objects.

## 4.1 Coercion methods

Coercion methods between `DelayedDataFrame` and other data structures
are defined. When coercing from `ANY` to `DelayedDataFrame`, the
`lazyIndex` slot will be added automatically, with the initial NULL
value of indexes for each column.

* From vector

```
as(letters, "DelayedDataFrame")
## DelayedDataFrame with 26 rows and 1 column
##               X
##     <character>
## 1             a
## 2             b
## 3             c
## ...         ...
## 24            x
## 25            y
## 26            z
```

* From DataFrame

```
as(DataFrame(letters), "DelayedDataFrame")
## DelayedDataFrame with 26 rows and 1 column
##         letters
##     <character>
## 1             a
## 2             b
## 3             c
## ...         ...
## 24            x
## 25            y
## 26            z
```

* From list

```
(a <- as(list(a=1:5, b=6:10), "DelayedDataFrame"))
## DelayedDataFrame with 5 rows and 2 columns
##           a         b
##   <integer> <integer>
## 1         1         6
## 2         2         7
## 3         3         8
## 4         4         9
## 5         5        10
lazyIndex(a)
## LazyIndex of length 1
## [[1]]
## NULL
##
## index of each column:
## [1] 1 1
```

When coerce `DelayedDataFrame` into other data structure, the
`lazyIndex` slot will be realized and the new data structure
returned. For example, when `DelayedDataFrame` is coerced into a
`DataFrame` object, the `listData` slot will be updated according to
the `lazyIndex` slot.

```
df1 <- as(ddf1, "DataFrame")
df1@listData
## $varid
## <20> DelayedArray object of type "character":
##          [1]           [2]           [3]           .             [19]
## "rs111751804" "rs114390380" "rs1320571"               .  "rs61751002"
##          [20]
##  "rs6691840"
##
## $DP
## <20> DelayedArray object of type "integer":
##  [1]  [2]  [3]  [4]    . [17] [18] [19] [20]
## 3251 2676 7610 3383    . 6040 6589 5089 6871
dim(df1)
## [1] 20  2
```

## 4.2 Subsetting methods

### 4.2.1 subsetting by `[`

two-dimensional `[` subsetting on `DelayedDataFrame` objects by
integer, character, logical values all work.

* integer subscripts.

```
ddf[, 1, drop=FALSE]
## DelayedDataFrame with 1348 rows and 1 column
##            varid
##       <GDSArray>
## 1    rs111751804
## 2    rs114390380
## 3      rs1320571
## ...          ...
## 1346   rs8135982
## 1347 rs116581756
## 1348   rs5771206
```

* character subscripts (column names).

```
ddf[, "DP", drop=FALSE]
## DelayedDataFrame with 1348 rows and 1 column
##              DP
##      <GDSArray>
## 1          3251
## 2          2676
## 3          7610
## ...         ...
## 1346        823
## 1347       1257
## 1348         48
```

* logical subscripts.

```
ddf[, c(TRUE,FALSE), drop=FALSE]
## DelayedDataFrame with 1348 rows and 1 column
##            varid
##       <GDSArray>
## 1    rs111751804
## 2    rs114390380
## 3      rs1320571
## ...          ...
## 1346   rs8135982
## 1347 rs116581756
## 1348   rs5771206
```

When subsetting using `[` on an already subsetted `DelayedDataFrame`
object, the `lazyIndex`, `nrows` and `rownames`(if not NULL) slot will
be updated.

```
(a <- ddf1[1:10, 2, drop=FALSE])
## DelayedDataFrame with 10 rows and 1 column
##             DP
##     <GDSArray>
## 1         3251
## 2         2676
## 3         7610
## ...        ...
## 8         9076
## 9         9605
## 10        9707
lazyIndex(a)
## LazyIndex of length 1
## [[1]]
##  [1]  1  2  3  4  5  6  7  8  9 10
##
## index of each column:
## [1] 1
nrow(a)
## [1] 10
```

### 4.2.2 subsetting by `[[`

The `[[` subsetting will take column subscripts for integer or
character values, and return corresponding columns in it’s original
data format.

```
ddf[[1]]
## <1348> GDSArray object of type "character":
##        [1]           [2]           [3]           .             [1347]
## "rs111751804" "rs114390380" "rs1320571"               . "rs116581756"
##        [1348]
## "rs5771206"
ddf[["varid"]]
## <1348> GDSArray object of type "character":
##        [1]           [2]           [3]           .             [1347]
## "rs111751804" "rs114390380" "rs1320571"               . "rs116581756"
##        [1348]
## "rs5771206"
identical(ddf[[1]], ddf[["varid"]])
## [1] TRUE
```

## 4.3 `rbind/cbind`

When doing `rbind`, the `lazyIndex` of input arguments will be
realized and a new `DelayedDataFrame` with NULL lazyIndex will be
returned.

```
ddf2 <- ddf[21:40, ]
(ddfrb <- rbind(ddf1, ddf2))
## DelayedDataFrame with 40 rows and 2 columns
##              varid             DP
##     <DelayedArray> <DelayedArray>
## 1      rs111751804           3251
## 2      rs114390380           2676
## 3        rs1320571           7610
## ...            ...            ...
## 38       rs1886116           3641
## 39     rs115917561           3089
## 40      rs61751016           4109
lazyIndex(ddfrb)
## LazyIndex of length 1
## [[1]]
## NULL
##
## index of each column:
## [1] 1 1
```

`cbind` of `DelayedDataFrame` objects will keep all existing
`lazyIndex` of input arguments and carry into the new
`DelayedDataFrame` object.

```
(ddfcb <- cbind(varid = ddf1[,1, drop=FALSE], DP=ddf1[, 2, drop=FALSE]))
## DelayedDataFrame with 20 rows and 2 columns
##           varid      DP.DP
##      <GDSArray> <GDSArray>
## 1   rs111751804       3251
## 2   rs114390380       2676
## 3     rs1320571       7610
## ...         ...        ...
## 18  rs115614983       6589
## 19   rs61751002       5089
## 20    rs6691840       6871
lazyIndex(ddfcb)
## LazyIndex of length 1
## [[1]]
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
##
## index of each column:
## [1] 1 1
```

# 5 sessionInfo

```
sessionInfo()
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
##  [1] GDSArray_1.30.0         gdsfmt_1.46.0           DelayedDataFrame_1.26.0
##  [4] DelayedArray_0.36.0     SparseArray_1.10.0      S4Arrays_1.10.0
##  [7] abind_1.4-8             IRanges_2.44.0          MatrixGenerics_1.22.0
## [10] matrixStats_1.5.0       Matrix_1.7-4            S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0     generics_0.1.4          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] jsonlite_2.0.0       crayon_1.5.3         compiler_4.5.1
##  [4] BiocManager_1.30.26  Biostrings_2.78.0    GenomicRanges_1.62.0
##  [7] parallel_4.5.1       jquerylib_0.1.4      Seqinfo_1.0.0
## [10] yaml_2.3.10          fastmap_1.2.0        lattice_0.22-7
## [13] R6_2.6.1             XVector_0.50.0       knitr_1.50
## [16] bookdown_0.45        bslib_0.9.0          rlang_1.1.6
## [19] cachem_1.1.0         xfun_0.53            sass_0.4.10
## [22] cli_3.6.5            digest_0.6.37        grid_4.5.1
## [25] SeqArray_1.50.0      lifecycle_1.0.4      evaluate_1.0.5
## [28] rmarkdown_2.30       tools_4.5.1          htmltools_0.5.8.1
```