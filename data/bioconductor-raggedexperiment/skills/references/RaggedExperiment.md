# RaggedExperiment

Martin Morgan1 and Marcel Ramos1

1Roswell Park Comprehensive Cancer Center, Buffalo, NY

#### 30 October 2025

#### Package

RaggedExperiment 1.34.0

# 1 Introduction

The *[RaggedExperiment](https://bioconductor.org/packages/3.22/RaggedExperiment)* package provides a flexible data
representation for copy number, mutation and other ragged array schema for
genomic location data. It aims to provide a framework for a set of samples
that have differing numbers of genomic ranges.

The `RaggedExperiment` class derives from a `GRangesList` representation and
provides a semblance of a rectangular dataset. The row and column dimensions of
the `RaggedExperiment` correspond to the number of ranges in the entire dataset
and the number of samples represented in the data, respectively.

# 2 Installation

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("RaggedExperiment")
```

Loading the package:

```
library(RaggedExperiment)
library(GenomicRanges)
```

# 3 Citing RaggedExperiment

Your citations are crucial in keeping our software free and open source. To
cite our package see the citation (Ramos et al. ([2023](#ref-Ramos2023-og))) in the Reference section.
You may also browse to the publication at the link [here](https://doi.org/10.1093/bioinformatics/btad330).

# 4 `RaggedExperiment` class overview

A schematic showing the class geometry and supported transformations of the
`RaggedExperiment` class is show below. There are three main operations for
transforming the `RaggedExperiment` representation:

1. `sparseAssay`
2. `compactAssay`
3. `qreduceAssay`

![RaggedExperiment object schematic. Rows and columns represent   genomic ranges and samples, respectively. Assay operations can be   performed with (from left to right) compactAssay, qreduceAssay, and   sparseAssay.](data:image/svg+xml;base64...)

Figure 1: RaggedExperiment object schematic
Rows and columns represent
genomic ranges and samples, respectively. Assay operations can be
performed with (from left to right) compactAssay, qreduceAssay, and
sparseAssay.

# 5 Constructing a `RaggedExperiment` object

We start with a couple of `GRanges` objects, each representing an individual
sample:

```
sample1 <- GRanges(
    c(A = "chr1:1-10:-", B = "chr1:8-14:+", C = "chr2:15-18:+"),
    score = 3:5)
sample2 <- GRanges(
    c(D = "chr1:1-10:-", E = "chr2:11-18:+"),
    score = 1:2)
```

Include column data `colData` to describe the samples:

```
colDat <- DataFrame(id = 1:2)
```

## 5.1 Using `GRanges` objects

```
ragexp <- RaggedExperiment(
    sample1 = sample1,
    sample2 = sample2,
    colData = colDat
)
ragexp
```

```
## class: RaggedExperiment
## dim: 5 2
## assays(1): score
## rownames(5): A B C D E
## colnames(2): sample1 sample2
## colData names(1): id
```

## 5.2 Using a `GRangesList` instance

```
grl <- GRangesList(sample1 = sample1, sample2 = sample2)
RaggedExperiment(grl, colData = colDat)
```

```
## class: RaggedExperiment
## dim: 5 2
## assays(1): score
## rownames(5): A B C D E
## colnames(2): sample1 sample2
## colData names(1): id
```

## 5.3 Using a `list` of `GRanges`

```
rangeList <- list(sample1 = sample1, sample2 = sample2)
RaggedExperiment(rangeList, colData = colDat)
```

```
## class: RaggedExperiment
## dim: 5 2
## assays(1): score
## rownames(5): A B C D E
## colnames(2): sample1 sample2
## colData names(1): id
```

## 5.4 Using a `List` of `GRanges` with metadata

**Note**: In cases where a `SimpleGenomicRangesList` is provided along with
accompanying metadata (accessed by `mcols`), the metadata is used as the
`colData` for the `RaggedExperiment`.

```
grList <- List(sample1 = sample1, sample2 = sample2)
mcols(grList) <- colDat
RaggedExperiment(grList)
```

```
## class: RaggedExperiment
## dim: 5 2
## assays(1): score
## rownames(5): A B C D E
## colnames(2): sample1 sample2
## colData names(1): id
```

# 6 Accessors

## 6.1 Range data

```
rowRanges(ragexp)
```

```
## GRanges object with 5 ranges and 0 metadata columns:
##     seqnames    ranges strand
##        <Rle> <IRanges>  <Rle>
##   A     chr1      1-10      -
##   B     chr1      8-14      +
##   C     chr2     15-18      +
##   D     chr1      1-10      -
##   E     chr2     11-18      +
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

## 6.2 Dimension names

```
dimnames(ragexp)
```

```
## [[1]]
## [1] "A" "B" "C" "D" "E"
##
## [[2]]
## [1] "sample1" "sample2"
```

## 6.3 `colData`

```
colData(ragexp)
```

```
## DataFrame with 2 rows and 1 column
##                id
##         <integer>
## sample1         1
## sample2         2
```

# 7 Subsetting

## 7.1 by dimension

Subsetting a `RaggedExperiment` is akin to subsetting a `matrix` object. Rows
correspond to genomic ranges and columns to samples or specimen. It is possible
to subset using `integer`, `character`, and `logical` indices.

## 7.2 by genomic ranges

The `overlapsAny` and `subsetByOverlaps` functionalities are available for use
for `RaggedExperiment`. Please see the corresponding documentation in
`RaggedExperiment` and `GenomicRanges`.

# 8 \*Assay functions

`RaggedExperiment` package provides several different functions for representing
ranged data in a rectangular matrix via the `*Assay` methods.

## 8.1 sparseAssay

The most straightforward matrix representation of a `RaggedExperiment` will
return a matrix of dimensions equal to the product of the number of ranges and
samples.

```
dim(ragexp)
```

```
## [1] 5 2
```

```
Reduce(`*`, dim(ragexp))
```

```
## [1] 10
```

```
sparseAssay(ragexp)
```

```
##   sample1 sample2
## A       3      NA
## B       4      NA
## C       5      NA
## D      NA       1
## E      NA       2
```

```
length(sparseAssay(ragexp))
```

```
## [1] 10
```

### 8.1.1 Support for sparse matrix output

We provide sparse matrix representations with the help of the `Matrix` package.
To obtain a sparse representation, the user can use the `sparse = TRUE`
argument.

```
sparseAssay(ragexp, sparse = TRUE)
```

```
## 5 x 2 sparse Matrix of class "dgCMatrix"
##   sample1 sample2
## A       3       .
## B       4       .
## C       5       .
## D       .       1
## E       .       2
```

This representation is of class `dgCMatrix` see the `Matrix` documentation for
more details.

## 8.2 compactAssay

Samples with identical ranges are placed in the same row. Non-disjoint ranges
are **not** collapsed.

```
compactAssay(ragexp)
```

```
##              sample1 sample2
## chr1:8-14:+        4      NA
## chr1:1-10:-        3       1
## chr2:11-18:+      NA       2
## chr2:15-18:+       5      NA
```

Similarly, to `sparseAssay` the `compactAssay` function provides the option to
obtain a sparse matrix representation with the `sparse = TRUE` argument. This
will return a `dgCMatrix` class from the `Matrix` package.

```
compactAssay(ragexp, sparse = TRUE)
```

```
## 4 x 2 sparse Matrix of class "dgCMatrix"
##              sample1 sample2
## chr1:8-14:+        4       .
## chr1:1-10:-        3       1
## chr2:11-18:+       .       2
## chr2:15-18:+       5       .
```

## 8.3 disjoinAssay

This function returns a matrix of disjoint ranges across all samples. Elements
of the matrix are summarized by applying the `simplifyDisjoin` functional
argument to assay values of overlapping ranges.

```
disjoinAssay(ragexp, simplifyDisjoin = mean)
```

```
##              sample1 sample2
## chr1:8-14:+        4      NA
## chr1:1-10:-        3       1
## chr2:11-14:+      NA       2
## chr2:15-18:+       5       2
```

## 8.4 qreduceAssay

The `qreduceAssay` function works with a `query` parameter that highlights
a window of ranges for the resulting matrix. The returned matrix will have
dimensions `length(query)` by `ncol(x)`. Elements contain assay values for the
*i* th query range and the *j* th sample, summarized according to the
`simplifyReduce` functional argument.

For demonstration purposes, we can have a look at the original `GRangesList`
and the associated scores from which the current `ragexp` object is derived:

```
unlist(grl, use.names = FALSE)
```

```
## GRanges object with 5 ranges and 1 metadata column:
##     seqnames    ranges strand |     score
##        <Rle> <IRanges>  <Rle> | <integer>
##   A     chr1      1-10      - |         3
##   B     chr1      8-14      + |         4
##   C     chr2     15-18      + |         5
##   D     chr1      1-10      - |         1
##   E     chr2     11-18      + |         2
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

This data is represented as `rowRanges` and `assays` in `RaggedExperiment`:

```
rowRanges(ragexp)
```

```
## GRanges object with 5 ranges and 0 metadata columns:
##     seqnames    ranges strand
##        <Rle> <IRanges>  <Rle>
##   A     chr1      1-10      -
##   B     chr1      8-14      +
##   C     chr2     15-18      +
##   D     chr1      1-10      -
##   E     chr2     11-18      +
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

```
assay(ragexp, "score")
```

```
##   sample1 sample2
## A       3      NA
## B       4      NA
## C       5      NA
## D      NA       1
## E      NA       2
```

Here we provide the “query” region of interest:

```
(query <- GRanges(c("chr1:1-14:-", "chr2:11-18:+")))
```

```
## GRanges object with 2 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]     chr1      1-14      -
##   [2]     chr2     11-18      +
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

The `simplifyReduce` argument in `qreduceAssay` allows the user to summarize
overlapping regions with a custom method for the given “query” region of
interest. We provide one for calculating a weighted average score per
query range, where the weight is proportional to the overlap widths between
overlapping ranges and a query range.

*Note* that there are three arguments to this function. See the documentation
for additional details.

```
weightedmean <- function(scores, ranges, qranges)
{
    isects <- pintersect(ranges, qranges)
    sum(scores * width(isects)) / sum(width(isects))
}
```

A call to `qreduceAssay` involves the `RaggedExperiment`, the `GRanges` query
and the `simplifyReduce` functional argument.

```
qreduceAssay(ragexp, query, simplifyReduce = weightedmean)
```

```
##              sample1 sample2
## chr1:1-14:-        3       1
## chr2:11-18:+       5       2
```

See the schematic for a visual representation.

[back to top](#header)

# 9 Coercion

The `RaggedExperiment` provides a family of parallel functions for coercing to
the `SummarizedExperiment` class. By selecting a particular assay index (`i`),
a parallel assay coercion method can be achieved.

Here is the list of function names:

* `sparseSummarizedExperiment`
* `compactSummarizedExperiment`
* `disjoinSummarizedExperiment`
* `qreduceSummarizedExperiment`

See the documentation for details.

## 9.1 from dgCMatrix to RaggedExperiment

In the special case where the rownames of a `sparseMatrix` are coercible to
`GRanges`, `RaggedExperiment` provides the facility to convert sparse matrices
into `RaggedExperiment`. This can be done using the `as` coercion method. The
example below first creates an example sparse `dgCMatrix` class and then shows
the `as` method usage to this end.

```
library(Matrix)
```

```
##
## Attaching package: 'Matrix'
```

```
## The following object is masked from 'package:S4Vectors':
##
##     expand
```

```
sm <- Matrix::sparseMatrix(
    i = c(2, 3, 4, 3, 4, 3, 4),
    j = c(1, 1, 1, 3, 3, 4, 4),
    x = c(2L, 4L, 2L, 2L, 2L, 4L, 2L),
    dims = c(4, 4),
    dimnames = list(
        c("chr2:1-10", "chr2:2-10", "chr2:3-10", "chr2:4-10"),
        LETTERS[1:4]
    )
)

as(sm, "RaggedExperiment")
```

```
## class: RaggedExperiment
## dim: 7 3
## assays(1): counts
## rownames: NULL
## colnames(3): A C D
## colData names(0):
```

# 10 Session Information

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
## [1] Matrix_1.7-4            RaggedExperiment_1.34.0 GenomicRanges_1.62.0
## [4] Seqinfo_1.0.0           IRanges_2.44.0          S4Vectors_0.48.0
## [7] BiocGenerics_0.56.0     generics_0.1.4          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5                   knitr_1.50
##  [3] rlang_1.1.6                 xfun_0.53
##  [5] DelayedArray_0.36.0         jsonlite_2.0.0
##  [7] SummarizedExperiment_1.40.0 htmltools_0.5.8.1
##  [9] BiocBaseUtils_1.12.0        MatrixGenerics_1.22.0
## [11] sass_0.4.10                 Biobase_2.70.0
## [13] rmarkdown_2.30              grid_4.5.1
## [15] abind_1.4-8                 evaluate_1.0.5
## [17] jquerylib_0.1.4             fastmap_1.2.0
## [19] yaml_2.3.10                 lifecycle_1.0.4
## [21] bookdown_0.45               BiocManager_1.30.26
## [23] compiler_4.5.1              XVector_0.50.0
## [25] lattice_0.22-7              digest_0.6.37
## [27] R6_2.6.1                    SparseArray_1.10.0
## [29] bslib_0.9.0                 tools_4.5.1
## [31] matrixStats_1.5.0           S4Arrays_1.10.0
## [33] cachem_1.1.0
```

# References

Ramos, Marcel, Martin Morgan, Ludwig Geistlinger, Vincent J Carey, and Levi Waldron. 2023. “RaggedExperiment: the missing link between genomic ranges and matrices in Bioconductor.” *Bioinformatics* 39 (6): btad330. <https://doi.org/10.1093/bioinformatics/btad330>.