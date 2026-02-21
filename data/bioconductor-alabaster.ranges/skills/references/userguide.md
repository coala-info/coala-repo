# Saving genomic ranges to artifacts and back again

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: November 20, 2023

#### Package

alabaster.ranges 1.10.0

# Contents

* [1 Overview](#overview)
* [2 Quick start](#quick-start)
  + [2.1 Further comments](#further-comments)
* [Session information](#session-information)

# 1 Overview

The *[alabaster.ranges](https://bioconductor.org/packages/3.22/alabaster.ranges)* package implements methods to save genomic ranges (i.e., `GRanges` and `GRangesList` objects) to file artifacts and load them back into R.
It also supports various `CompressedList` subclasses, including the somewhat useful `CompressedSplitDataFrameList`.
Check out *[alabaster.base](https://bioconductor.org/packages/3.22/alabaster.base)* for more details on the motivation and concepts of the **alabaster** framework.

# 2 Quick start

Given some genomic ranges, we can use `saveObject()` to save it inside a staging directory:

```
library(GenomicRanges)
gr <- GRanges("chrA", IRanges(sample(100), width=sample(100)))
mcols(gr)$score <- runif(length(gr))
metadata(gr)$genome <- "Aaron"
seqlengths(gr) <- c(chrA=1000)

library(alabaster.ranges)
tmp <- tempfile()
saveObject(gr, tmp)

list.files(tmp, recursive=TRUE)
```

```
## [1] "OBJECT"
## [2] "_environment.json"
## [3] "other_annotations/OBJECT"
## [4] "other_annotations/list_contents.json.gz"
## [5] "range_annotations/OBJECT"
## [6] "range_annotations/basic_columns.h5"
## [7] "ranges.h5"
## [8] "sequence_information/OBJECT"
## [9] "sequence_information/info.h5"
```

We can then easily load it back in with `readObject()`.

```
roundtrip <- readObject(tmp)
roundtrip
```

```
## GRanges object with 100 ranges and 1 metadata column:
##         seqnames    ranges strand |     score
##            <Rle> <IRanges>  <Rle> | <numeric>
##     [1]     chrA     24-82      * |  0.240620
##     [2]     chrA    60-142      * |  0.850103
##     [3]     chrA     46-56      * |  0.331704
##     [4]     chrA     17-49      * |  0.421060
##     [5]     chrA    71-147      * |  0.781474
##     ...      ...       ...    ... .       ...
##    [96]     chrA    39-100      * |  0.119858
##    [97]     chrA     81-87      * |  0.375890
##    [98]     chrA    63-113      * |  0.628474
##    [99]     chrA    74-127      * |  0.127701
##   [100]     chrA    45-107      * |  0.843813
##   -------
##   seqinfo: 1 sequence from an unspecified genome
```

The same can be done for `GRangesList` and `CompressedList` subclasses.

## 2.1 Further comments

Metadata is preserved during this round-trip:

```
metadata(roundtrip)
```

```
## $genome
## [1] "Aaron"
```

```
mcols(roundtrip)
```

```
## DataFrame with 100 rows and 1 column
##         score
##     <numeric>
## 1    0.240620
## 2    0.850103
## 3    0.331704
## 4    0.421060
## 5    0.781474
## ...       ...
## 96   0.119858
## 97   0.375890
## 98   0.628474
## 99   0.127701
## 100  0.843813
```

```
seqinfo(roundtrip)
```

```
## Seqinfo object with 1 sequence from an unspecified genome:
##   seqnames seqlengths isCircular genome
##   chrA           1000         NA   <NA>
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
## [1] alabaster.ranges_1.10.0 alabaster.base_1.10.0   GenomicRanges_1.62.0
## [4] Seqinfo_1.0.0           IRanges_2.44.0          S4Vectors_0.48.0
## [7] BiocGenerics_0.56.0     generics_0.1.4          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5                knitr_1.50               rlang_1.1.6
##  [4] xfun_0.53                jsonlite_2.0.0           htmltools_0.5.8.1
##  [7] sass_0.4.10              rmarkdown_2.30           evaluate_1.0.5
## [10] jquerylib_0.1.4          fastmap_1.2.0            Rhdf5lib_1.32.0
## [13] alabaster.schemas_1.10.0 yaml_2.3.10              lifecycle_1.0.4
## [16] bookdown_0.45            BiocManager_1.30.26      compiler_4.5.1
## [19] Rcpp_1.1.0               rhdf5filters_1.22.0      rhdf5_2.54.0
## [22] digest_0.6.37            R6_2.6.1                 bslib_0.9.0
## [25] tools_4.5.1              cachem_1.1.0
```