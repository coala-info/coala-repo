# GDSArray: Representing GDS files as array-like objects

Qian Liu1, Hervé Pagès2 and Martin Morgan1

1Roswell Park Comprehensive Cancer Center, Buffalo, NY
2Fred Hutchinson Cancer Research Center, Seattle, WA

#### last edit: 3/26/2024

#### Package

GDSArray 1.30.0

# 1 Introduction

[GDSArray](https://bioconductor.org/packages/GDSArray) is a *Bioconductor* package that represents GDS files as
objects derived from the [DelayedArray](https://bioconductor.org/packages/DelayedArray) package and `DelayedArray`
class. It converts a GDS node in the file to a `DelayedArray`-derived
data structure. The rich common methods and data operations defined on
`GDSArray` makes it more *R*-user-friendly than working with the GDS
file directly.

# 2 Package installation

1. Download the package from Bioconductor.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("GDSArray")
```

2. Load the package into R session.

```
library(GDSArray)
```

# 3 GDS format introduction

## 3.1 Genomic Data Structure (GDS)

The *Bioconductor* package [gdsfmt](https://bioconductor.org/packages/gdsfmt) has provided a high-level R
interface to CoreArray Genomic Data Structure (GDS) data files, which
is designed for large-scale datasets, especially for data which are
much larger than the available random-access memory.

More details about GDS format can be found in the vignettes of the
[gdsfmt](https://bioconductor.org/packages/gdsfmt), [SNPRelate](https://bioconductor.org/packages/SNPRelate), and [SeqArray](https://bioconductor.org/packages/SeqArray) packages.

# 4 `GDSArray`, `GDSMatrix`, and `GDSFile`

`GDSArray` represents GDS files as `DelayedArray` instances. It has
methods like `dim`, `dimnames` defined, and it inherits array-like
operations and methods from `DelayedArray`, e.g., the subsetting
method of `[`.

## 4.1 GDSArray, GDSMatrix, and DelayedArray

The `GDSArray()` constructor takes as arguments the file path and the
GDS node inside the GDS file. The `GDSArray()` constructor always
returns the object with rows being features (genes / variants / snps)
and the columns being “samples”. This is consistent with the assay
data inside `SummarizedExperiment`. **FIXME: should GDSArray() return that dim?**

```
file <- gdsExampleFileName("seqgds")
```

```
## This is a SeqArray GDS file
```

```
GDSArray(file, "genotype/data")
```

```
## <2 x 90 x 1348> GDSArray object of type "integer":
## ,,1
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     3     3     0     3   .     0     0     0     0
## [2,]     3     3     0     3   .     0     0     0     0
##
## ,,2
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     3     3     0     3   .     0     0     0     0
## [2,]     3     3     0     3   .     0     0     0     0
##
## ...
##
## ,,1347
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     0     0     0     0   .     0     0     0     0
## [2,]     0     0     0     0   .     0     0     0     0
##
## ,,1348
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     3     3     0     3   .     3     3     3     3
## [2,]     3     3     1     3   .     3     3     3     3
```

A `GDSMatrix` is a 2-dimensional `GDSArray`, and will be returned from
the `GDSArray()` constructor automatically if the input GDS node is
2-dimensional.

```
GDSArray(file, "annotation/format/DP/data")
```

```
## <90 x 1348> GDSMatrix object of type "integer":
##          [,1]    [,2]    [,3]    [,4] ... [,1345] [,1346] [,1347] [,1348]
##  [1,]       0       0      12      15   .       6       5       4       0
##  [2,]       0       0      17       4   .      10       8       7       0
##  [3,]     107      92     247     177   .      28      15      26       3
##   ...       .       .       .       .   .       .       .       .       .
## [88,]      81      84     217     110   .      36      61      92       0
## [89,]      67      47     134     111   .      46      57      71       2
## [90,]     156     150     417     195   .      78     101     144       2
```

## 4.2 `GDSFile`

The `GDSFile` is a light-weight class to represent GDS files. It has
the `$` completion method to complete any possible gds nodes. It could
be used as a convenient `GDSArray` constructor if the slot of
`current_path` in `GDSFile` object represents a valid gds node.
Otherwise, it will return the `GDSFile` object with an updated
`current_path`.

```
gf <- GDSFile(file)
gf$annotation$info
```

```
## class: GDSFile
## file: /home/biocbuild/bbs-3.22-bioc/R/site-library/SeqArray/extdata/CEU_Exon.gds
## current node: annotation/info
## subnodes:
##   annotation/info/AA
##   annotation/info/AC
##   annotation/info/AN
##   annotation/info/DP
##   annotation/info/HM2
##   annotation/info/HM3
##   annotation/info/OR
##   annotation/info/GP
##   annotation/info/BN
```

```
gf$annotation$info$AC
```

```
## <1348> GDSArray object of type "integer":
##    [1]    [2]    [3]    [4]      . [1345] [1346] [1347] [1348]
##      4      1      6    128      .      2     11      1      1
```

Try typing in `gf$ann` and pressing `tab` key for the completion.

## 4.3 `GDSArray` methods

### 4.3.1 slot accessors.

* `seed` returns the `GDSArraySeed` of the `GDSArray` object.

```
gt <- GDSArray(file, "genotype/data")
seed(gt)
```

```
## GDSArraySeed
## GDS File path: /home/biocbuild/bbs-3.22-bioc/R/site-library/SeqArray/extdata/CEU_Exon.gds
## Array node: genotype/data
## Dim: 2 x 90 x 1348
```

* `gdsfile` returns the file path of the corresponding GDS file.

```
gdsfile(gt)
```

```
## [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SeqArray/extdata/CEU_Exon.gds"
```

### 4.3.2 Available GDS nodes

`gdsnodes()` takes the GDS file path or `GDSFile` object as input, and
returns all nodes that can be converted to `GDSArray` instances. The
returned GDS node names can be used as input for the `GDSArray(name=)`
constructor.

```
gdsnodes(file)
```

```
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
```

```
identical(gdsnodes(file), gdsnodes(gf))
```

```
## [1] TRUE
```

```
varname <- gdsnodes(file)[2]
GDSArray(file, varname)
```

```
## <1348> GDSArray object of type "integer":
##    [1]    [2]    [3]    [4]      . [1345] [1346] [1347] [1348]
##      1      2      3      4      .   1345   1346   1347   1348
```

### 4.3.3 `dim()`, `dimnames()`

The `dimnames(GDSArray)` returns an unnamed list, with the value of
NULL or dimension names with length being the same as return from
`dim(GDSArray)`.

```
dp <- GDSArray(file, "annotation/format/DP/data")
dim(dp)
```

```
## [1]   90 1348
```

```
class(dimnames(dp))
```

```
## [1] "list"
```

```
lengths(dimnames(dp))
```

```
## [1] 0 0
```

### 4.3.4 `[` subsetting

`GDSArray` instances can be subset, following the usual *R*
conventions, with numeric or logical vectors; logical vectors are
recycled to the appropriate length.

```
dp[1:3, 10:15]
```

```
## <3 x 6> DelayedMatrix object of type "integer":
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]   59   49   88   55   46   47
## [2,]   33   22   16    9    7    7
## [3,]  276  271  145   89   70  151
```

```
dp[c(TRUE, FALSE), ]
```

```
## <45 x 1348> DelayedMatrix object of type "integer":
##          [,1]    [,2]    [,3]    [,4] ... [,1345] [,1346] [,1347] [,1348]
##  [1,]       0       0      12      15   .       6       5       4       0
##  [2,]     107      92     247     177   .      28      15      26       3
##  [3,]       0       0      17       0   .       4       4       4       0
##   ...       .       .       .       .   .       .       .       .       .
## [43,]       0       0      11       5   .       3       3       1       0
## [44,]       3       4       9       2   .       4       3       4       0
## [45,]      67      47     134     111   .      46      57      71       2
```

### 4.3.5 some numeric calculation

```
log(dp)
```

```
## <90 x 1348> DelayedMatrix object of type "double":
##           [,1]     [,2]     [,3] ...   [,1347]   [,1348]
##  [1,]     -Inf     -Inf 2.484907   .  1.386294      -Inf
##  [2,]     -Inf     -Inf 2.833213   .  1.945910      -Inf
##  [3,] 4.672829 4.521789 5.509388   .  3.258097  1.098612
##   ...        .        .        .   .         .         .
## [88,] 4.394449 4.430817 5.379897   . 4.5217886      -Inf
## [89,] 4.204693 3.850148 4.897840   . 4.2626799 0.6931472
## [90,] 5.049856 5.010635 6.033086   . 4.9698133 0.6931472
```

```
dp[rowMeans(dp) < 60, ]
```

```
## <52 x 1348> DelayedMatrix object of type "integer":
##          [,1]    [,2]    [,3]    [,4] ... [,1345] [,1346] [,1347] [,1348]
##  [1,]       0       0      12      15   .       6       5       4       0
##  [2,]       0       0      17       4   .      10       8       7       0
##  [3,]       0       0      11       1   .       3       1       1       0
##   ...       .       .       .       .   .       .       .       .       .
## [50,]       0       0       6       0   .       2       0       0       0
## [51,]       0       0      11       5   .       3       3       1       0
## [52,]       3       4       9       2   .       4       3       4       0
```

## 4.4 Internals: `GDSArraySeed`

The `GDSArraySeed` class represents the ‘seed’ for the `GDSArray`
object. It is not exported from the [GDSArray](https://bioconductor.org/packages/GDSArray) package. Seed objects
should contain the GDS file path, node name, and are expected to
satisfy the [seed
contract](https://bioconductor.org/packages/release/bioc/vignettes/DelayedArray/inst/doc/02-Implementing_a_backend.html#the-seed-contract)
for implementing a `DelayedArray` backend, i.e. to support dim() and
dimnames().

```
seed <- GDSArray:::GDSArraySeed(file, "genotype/data")
seed
```

```
## GDSArraySeed
## GDS File path: /home/biocbuild/bbs-3.22-bioc/R/site-library/SeqArray/extdata/CEU_Exon.gds
## Array node: genotype/data
## Dim: 2 x 90 x 1348
```

The seed can be used to construct a `GDSArray` instance.

```
GDSArray(seed)
```

```
## <2 x 90 x 1348> GDSArray object of type "integer":
## ,,1
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     3     3     0     3   .     0     0     0     0
## [2,]     3     3     0     3   .     0     0     0     0
##
## ,,2
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     3     3     0     3   .     0     0     0     0
## [2,]     3     3     0     3   .     0     0     0     0
##
## ...
##
## ,,1347
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     0     0     0     0   .     0     0     0     0
## [2,]     0     0     0     0   .     0     0     0     0
##
## ,,1348
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     3     3     0     3   .     3     3     3     3
## [2,]     3     3     1     3   .     3     3     3     3
```

The `DelayedArray()` constructor with `GDSArraySeed` object as
argument will return the same content as the `GDSArray()` constructor
over the same `GDSArraySeed`.

```
class(DelayedArray(seed))
```

```
## [1] "GDSArray"
## attr(,"package")
## [1] "GDSArray"
```

# 5 sessionInfo

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
##  [1] GDSArray_1.30.0       DelayedArray_0.36.0   SparseArray_1.10.0
##  [4] S4Arrays_1.10.0       abind_1.4-8           IRanges_2.44.0
##  [7] S4Vectors_0.48.0      MatrixGenerics_1.22.0 matrixStats_1.5.0
## [10] Matrix_1.7-4          BiocGenerics_0.56.0   generics_0.1.4
## [13] gdsfmt_1.46.0         BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] jsonlite_2.0.0       compiler_4.5.1       BiocManager_1.30.26
##  [4] crayon_1.5.3         GenomicRanges_1.62.0 Biostrings_2.78.0
##  [7] parallel_4.5.1       jquerylib_0.1.4      Seqinfo_1.0.0
## [10] yaml_2.3.10          fastmap_1.2.0        lattice_0.22-7
## [13] R6_2.6.1             XVector_0.50.0       knitr_1.50
## [16] bookdown_0.45        bslib_0.9.0          rlang_1.1.6
## [19] cachem_1.1.0         xfun_0.53            sass_0.4.10
## [22] cli_3.6.5            digest_0.6.37        grid_4.5.1
## [25] SeqArray_1.50.0      lifecycle_1.0.4      evaluate_1.0.5
## [28] rmarkdown_2.30       tools_4.5.1          htmltools_0.5.8.1
```