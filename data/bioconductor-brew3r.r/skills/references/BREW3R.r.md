# BREW3R.r

Lucille Lopez-Delisle

#### 2024-02-21

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Example](#example)
  + [3.1 Load dependencies](#load-dependencies)
  + [3.2 Get gtfs](#get-gtfs)
  + [3.3 Convert gtf files to GRanges](#convert-gtf-files-to-granges)
  + [3.4 Save annotations](#save-annotations)
  + [3.5 Extend the GRanges](#extend-the-granges)
  + [3.6 Explore your data](#explore-your-data)
  + [3.7 Recompose the GRanges](#recompose-the-granges)
  + [3.8 Write new GRanges to gtf](#write-new-granges-to-gtf)
* [4 Session Info](#session-info)

# 1 Introduction

The **BREW3R.r** package has been written to be part of the BREW3R workflow.
Today, the package contains a single function which enable to extend three prime
of gene annotations using another gene annotation as template.
This is very helpful when you are using a technique that only sequence
three-prime end of genes like 10X scRNA-seq or BRB-seq.

# 2 Installation

To install from Bioconductor use:

```
if (!require("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("BREW3R.r")
```

To install from github use:

```
if (!require("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("lldelisle/BREW3R.r")
```

# 3 Example

## 3.1 Load dependencies

```
library(rtracklayer)
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: stats4
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
library(GenomicRanges)
```

## 3.2 Get gtfs

In this example, I will extend the transcripts from gencode using
RefSeq on mm10. In order to decrease the size of the input files, the input
files of this vignette have been subsetted to the chromosome 19.
Original gtf for gencode is available
[here](https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M25/gencode.vM25.annotation.gtf.gz)
and gtf for RefSeq is available
[here](https://hgdownload.soe.ucsc.edu/goldenPath/mm10/bigZips/genes/mm10.ncbiRefSeq.gtf.gz).

```
input_gtf_file_to_extend <-
    system.file(
        "extdata/chr19.gencode.vM25.annotation.gtf.gz",
        package = "BREW3R.r",
        mustWork = TRUE
    )
input_gtf_file_template <-
    system.file(
        "extdata/chr19.mm10.ncbiRefSeq.gtf.gz",
        package = "BREW3R.r",
        mustWork = TRUE
    )
```

## 3.3 Convert gtf files to GRanges

We will use the rtracklayer package to import gtf:

```
input_gr_to_extend <- rtracklayer::import(input_gtf_file_to_extend)
input_gr_template <- rtracklayer::import(input_gtf_file_template)
```

## 3.4 Save annotations

The package only use exon information.
It may be interesting to save the other annotations like ‘CDS’,
‘start\_codon’, ‘end\_codon’.

You should not save the ‘gene’ and ‘transcript’ annotations as they will be out
of date. Same for three prime UTR.

```
input_gr_CDS <- subset(input_gr_to_extend, type == "CDS")
```

## 3.5 Extend the GRanges

Now we can run the main function of the package:

```
library(BREW3R.r)
new_gr_exons <- extend_granges(
    input_gr_to_extend = input_gr_to_extend,
    input_gr_to_overlap = input_gr_template
)
```

```
## Found 4343 last exons to potentially extend.
```

```
## Compute overlap between 4343 exons and 38576 exons.
```

```
## 2331  exons may be extended.
```

```
## 2263 exons have been extended while preventing collision with other genes.
```

```
## Found 32563  exons that may be included into 723 transcripts.
```

```
## Stay 68 candidate exons that may be included into 26 transcripts.
```

```
## Finally 29 combined exons will be included into 26 transcripts.
```

By default, you get few statistics. You can change the verbosity with
`options(rlib_message_verbosity = "quiet")` to mute it or on the contrary
you can set `options(BREW3R.r.verbose = "progression")` to get messages with
all steps.
Among them, you can read that you extended about half of last exons,
then you could add 29 exons to 26 transcripts.

## 3.6 Explore your data

Here is an example for the Btrc gene that have been extended:

![](data:image/png;base64...)

Here is an example for the Mrpl21 gene that have a new exon
on the 3’ end of one of its transcript:

![](data:image/png;base64...)

## 3.7 Recompose the GRanges

We can put back annotations that have been stored:

```
new_gr <- c(new_gr_exons, input_gr_CDS)
```

## 3.8 Write new GRanges to gtf

```
rtracklayer::export.gff(sort(new_gr), "my_new.gtf")
```

# 4 Session Info

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
## [1] BREW3R.r_1.6.0       rtracklayer_1.70.0   GenomicRanges_1.62.0
## [4] Seqinfo_1.0.0        IRanges_2.44.0       S4Vectors_0.48.0
## [7] BiocGenerics_0.56.0  generics_0.1.4       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10                 SparseArray_1.10.0
##  [3] bitops_1.0-9                lattice_0.22-7
##  [5] magrittr_2.0.4              digest_0.6.37
##  [7] evaluate_1.0.5              grid_4.5.1
##  [9] bookdown_0.45               fastmap_1.2.0
## [11] jsonlite_2.0.0              Matrix_1.7-4
## [13] cigarillo_1.0.0             restfulr_0.0.16
## [15] tinytex_0.57                BiocManager_1.30.26
## [17] httr_1.4.7                  XML_3.99-0.19
## [19] Biostrings_2.78.0           codetools_0.2-20
## [21] jquerylib_0.1.4             abind_1.4-8
## [23] cli_3.6.5                   rlang_1.1.6
## [25] crayon_1.5.3                XVector_0.50.0
## [27] Biobase_2.70.0              cachem_1.1.0
## [29] DelayedArray_0.36.0         yaml_2.3.10
## [31] S4Arrays_1.10.0             tools_4.5.1
## [33] parallel_4.5.1              BiocParallel_1.44.0
## [35] Rsamtools_2.26.0            SummarizedExperiment_1.40.0
## [37] curl_7.0.0                  R6_2.6.1
## [39] magick_2.9.0                BiocIO_1.20.0
## [41] matrixStats_1.5.0           lifecycle_1.0.4
## [43] bslib_0.9.0                 Rcpp_1.1.0
## [45] xfun_0.53                   GenomicAlignments_1.46.0
## [47] MatrixGenerics_1.22.0       knitr_1.50
## [49] rjson_0.2.23                htmltools_0.5.8.1
## [51] rmarkdown_2.30              compiler_4.5.1
## [53] RCurl_1.98-1.17
```