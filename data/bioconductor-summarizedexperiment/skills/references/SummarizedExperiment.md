# *SummarizedExperiment* for Coordinating Experimental Assays, Samples, and Regions of Interest

Martin Morgan, Valerie Obenchain, Jim Hester, Hervé Pagès

#### Revised: 5 Jan, 2023

# Contents

* [1 Introduction](#introduction)
* [2 Anatomy of a `SummarizedExperiment`](#anatomy-of-a-summarizedexperiment)
  + [2.1 Assays](#assays)
  + [2.2 ‘Row’ (regions-of-interest) data](#row-regions-of-interest-data)
  + [2.3 ‘Column’ (sample) data](#column-sample-data)
  + [2.4 Experiment-wide metadata](#experiment-wide-metadata)
* [3 Constructing a `SummarizedExperiment`](#constructing-a-summarizedexperiment)
* [4 Top-level dimnames vs assay-level dimnames](#top-level-dimnames-vs-assay-level-dimnames)
* [5 Common operations on `SummarizedExperiment`](#common-operations-on-summarizedexperiment)
  + [5.1 Subsetting](#subsetting)
  + [5.2 Getters and setters](#getters-and-setters)
  + [5.3 Range-based operations](#range-based-operations)
* [6 Interactive visualization](#interactive-visualization)
* [7 Session information](#session-information)

# 1 Introduction

The `SummarizedExperiment` class is used to store rectangular matrices of
experimental results, which are commonly produced by sequencing and microarray
experiments. Note that `SummarizedExperiment` can simultaneously manage several
experimental results or `assays` as long as they be of the same dimensions.

Each object stores observations of one or more samples, along
with additional meta-data describing both the observations (features) and
samples (phenotypes).

A key aspect of the `SummarizedExperiment` class is the coordination of the
meta-data and assays when subsetting. For example, if you want to exclude a
given sample you can do for both the meta-data and assay in one operation,
which ensures the meta-data and observed data will remain in sync. Improperly
accounting for meta and observational data has resulted in a number of
incorrect results and retractions so this is a very desirable
property.

`SummarizedExperiment` is in many ways similar to the historical
`ExpressionSet`, the main distinction being that `SummarizedExperiment` is more
flexible in it’s row information, allowing both `GRanges` based as well as those
described by arbitrary `DataFrame`s. This makes it ideally suited to a variety
of experiments, particularly sequencing based experiments such as RNA-Seq and
ChIp-Seq.

# 2 Anatomy of a `SummarizedExperiment`

The *SummarizedExperiment* package contains two classes:
`SummarizedExperiment` and `RangedSummarizedExperiment`.

`SummarizedExperiment` is a matrix-like container where rows represent features
of interest (e.g. genes, transcripts, exons, etc.) and columns represent
samples. The objects contain one or more assays, each represented by a
matrix-like object of numeric or other mode. The rows of a
`SummarizedExperiment` object represent features of interest. Information
about these features is stored in a `DataFrame` object, accessible using the
function `rowData()`. Each row of the `DataFrame` provides information on the
feature in the corresponding row of the `SummarizedExperiment` object. Columns
of the DataFrame represent different attributes of the features of interest,
e.g., gene or transcript IDs, etc.

`RangedSummarizedExperiment` is the child of the `SummarizedExperiment` class
which means that all the methods on `SummarizedExperiment` also work on a
`RangedSummarizedExperiment`.

The fundamental difference between the two classes is that the rows of a
`RangedSummarizedExperiment` object represent genomic ranges of interest
instead of a `DataFrame` of features. The `RangedSummarizedExperiment` ranges
are described by a `GRanges` or a `GRangesList` object, accessible using the
`rowRanges()` function.

The following graphic displays the class geometry and highlights the
vertical (column) and horizontal (row) relationships.

![](data:image/svg+xml;base64...)

Summarized Experiment

## 2.1 Assays

The `airway` package contains an example dataset from an RNA-Seq experiment of
read counts per gene for airway smooth muscles. These data are stored
in a `RangedSummarizedExperiment` object which contains 8 different
experimental and assays 64,102 gene transcripts.

```
library(SummarizedExperiment)
data(airway, package="airway")
se <- airway
se
```

```
## class: RangedSummarizedExperiment
## dim: 63677 8
## metadata(1): ''
## assays(1): counts
## rownames(63677): ENSG00000000003 ENSG00000000005 ... ENSG00000273492
##   ENSG00000273493
## rowData names(10): gene_id gene_name ... seq_coord_system symbol
## colnames(8): SRR1039508 SRR1039509 ... SRR1039520 SRR1039521
## colData names(9): SampleName cell ... Sample BioSample
```

To retrieve the experiment data from a `SummarizedExperiment` object one can
use the `assays()` accessor. An object can have multiple assay datasets
each of which can be accessed using the `$` operator.
The `airway` dataset contains only one assay (`counts`). Here each row
represents a gene transcript and each column one of the samples.

```
assays(se)$counts
```

|  | SRR1039508 | SRR1039509 | SRR1039512 | SRR1039513 | SRR1039516 | SRR1039517 | SRR1039520 | SRR1039521 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ENSG00000000003 | 679 | 448 | 873 | 408 | 1138 | 1047 | 770 | 572 |
| ENSG00000000005 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| ENSG00000000419 | 467 | 515 | 621 | 365 | 587 | 799 | 417 | 508 |
| ENSG00000000457 | 260 | 211 | 263 | 164 | 245 | 331 | 233 | 229 |
| ENSG00000000460 | 60 | 55 | 40 | 35 | 78 | 63 | 76 | 60 |
| ENSG00000000938 | 0 | 0 | 2 | 0 | 1 | 0 | 0 | 0 |
| ENSG00000000971 | 3251 | 3679 | 6177 | 4252 | 6721 | 11027 | 5176 | 7995 |
| ENSG00000001036 | 1433 | 1062 | 1733 | 881 | 1424 | 1439 | 1359 | 1109 |
| ENSG00000001084 | 519 | 380 | 595 | 493 | 820 | 714 | 696 | 704 |
| ENSG00000001167 | 394 | 236 | 464 | 175 | 658 | 584 | 360 | 269 |

## 2.2 ‘Row’ (regions-of-interest) data

The `rowRanges()` accessor is used to view the range information for a
`RangedSummarizedExperiment`. (Note if this were the parent
`SummarizedExperiment` class we’d use `rowData()`). The data are stored in a
`GRangesList` object, where each list element corresponds to one gene
transcript and the ranges in each `GRanges` correspond to the exons in the
transcript.

```
rowRanges(se)
```

```
## GRangesList object of length 63677:
## $ENSG00000000003
## GRanges object with 17 ranges and 2 metadata columns:
##        seqnames            ranges strand |   exon_id       exon_name
##           <Rle>         <IRanges>  <Rle> | <integer>     <character>
##    [1]        X 99883667-99884983      - |    667145 ENSE00001459322
##    [2]        X 99885756-99885863      - |    667146 ENSE00000868868
##    [3]        X 99887482-99887565      - |    667147 ENSE00000401072
##    [4]        X 99887538-99887565      - |    667148 ENSE00001849132
##    [5]        X 99888402-99888536      - |    667149 ENSE00003554016
##    ...      ...               ...    ... .       ...             ...
##   [13]        X 99890555-99890743      - |    667156 ENSE00003512331
##   [14]        X 99891188-99891686      - |    667158 ENSE00001886883
##   [15]        X 99891605-99891803      - |    667159 ENSE00001855382
##   [16]        X 99891790-99892101      - |    667160 ENSE00001863395
##   [17]        X 99894942-99894988      - |    667161 ENSE00001828996
##   -------
##   seqinfo: 722 sequences (1 circular) from an unspecified genome
##
## ...
## <63676 more elements>
```

## 2.3 ‘Column’ (sample) data

Sample meta-data describing the samples can be accessed using `colData()`, and
is a `DataFrame` that can store any number of descriptive columns for each
sample row.

```
colData(se)
```

```
## DataFrame with 8 rows and 9 columns
##            SampleName     cell      dex    albut        Run avgLength
##              <factor> <factor> <factor> <factor>   <factor> <integer>
## SRR1039508 GSM1275862  N61311     untrt    untrt SRR1039508       126
## SRR1039509 GSM1275863  N61311     trt      untrt SRR1039509       126
## SRR1039512 GSM1275866  N052611    untrt    untrt SRR1039512       126
## SRR1039513 GSM1275867  N052611    trt      untrt SRR1039513        87
## SRR1039516 GSM1275870  N080611    untrt    untrt SRR1039516       120
## SRR1039517 GSM1275871  N080611    trt      untrt SRR1039517       126
## SRR1039520 GSM1275874  N061011    untrt    untrt SRR1039520       101
## SRR1039521 GSM1275875  N061011    trt      untrt SRR1039521        98
##            Experiment    Sample    BioSample
##              <factor>  <factor>     <factor>
## SRR1039508  SRX384345 SRS508568 SAMN02422669
## SRR1039509  SRX384346 SRS508567 SAMN02422675
## SRR1039512  SRX384349 SRS508571 SAMN02422678
## SRR1039513  SRX384350 SRS508572 SAMN02422670
## SRR1039516  SRX384353 SRS508575 SAMN02422682
## SRR1039517  SRX384354 SRS508576 SAMN02422673
## SRR1039520  SRX384357 SRS508579 SAMN02422683
## SRR1039521  SRX384358 SRS508580 SAMN02422677
```

This sample metadata can be accessed using the `$` accessor which makes it
easy to subset the entire object by a given phenotype.

```
# subset for only those samples treated with dexamethasone
se[, se$dex == "trt"]
```

```
## class: RangedSummarizedExperiment
## dim: 63677 4
## metadata(1): ''
## assays(1): counts
## rownames(63677): ENSG00000000003 ENSG00000000005 ... ENSG00000273492
##   ENSG00000273493
## rowData names(10): gene_id gene_name ... seq_coord_system symbol
## colnames(4): SRR1039509 SRR1039513 SRR1039517 SRR1039521
## colData names(9): SampleName cell ... Sample BioSample
```

## 2.4 Experiment-wide metadata

Meta-data describing the experimental methods and publication references can be
accessed using `metadata()`.

```
metadata(se)
```

```
## [[1]]
## Experiment data
##   Experimenter name: Himes BE
##   Laboratory: NA
##   Contact information:
##   Title: RNA-Seq transcriptome profiling identifies CRISPLD2 as a glucocorticoid responsive gene that modulates cytokine function in airway smooth muscle cells.
##   URL: http://www.ncbi.nlm.nih.gov/pubmed/24926665
##   PMIDs: 24926665
##
##   Abstract: A 226 word abstract is available. Use 'abstract' method.
```

Note that `metadata()` is just a simple list, so it is appropriate for *any*
experiment wide metadata the user wishes to save, such as storing model
formulas.

```
metadata(se)$formula <- counts ~ dex + albut

metadata(se)
```

```
## [[1]]
## Experiment data
##   Experimenter name: Himes BE
##   Laboratory: NA
##   Contact information:
##   Title: RNA-Seq transcriptome profiling identifies CRISPLD2 as a glucocorticoid responsive gene that modulates cytokine function in airway smooth muscle cells.
##   URL: http://www.ncbi.nlm.nih.gov/pubmed/24926665
##   PMIDs: 24926665
##
##   Abstract: A 226 word abstract is available. Use 'abstract' method.
##
## $formula
## counts ~ dex + albut
```

# 3 Constructing a `SummarizedExperiment`

Often, `SummarizedExperiment` or `RangedSummarizedExperiment` objects are
returned by functions written by other packages. However it is possible to
create them by hand with a call to the `SummarizedExperiment()` constructor.

Constructing a `RangedSummarizedExperiment` with a `GRanges` as the
*rowRanges* argument:

```
nrows <- 200
ncols <- 6
counts <- matrix(runif(nrows * ncols, 1, 1e4), nrows)
rowRanges <- GRanges(rep(c("chr1", "chr2"), c(50, 150)),
                     IRanges(floor(runif(200, 1e5, 1e6)), width=100),
                     strand=sample(c("+", "-"), 200, TRUE),
                     feature_id=sprintf("ID%03d", 1:200))
colData <- DataFrame(Treatment=rep(c("ChIP", "Input"), 3),
                     row.names=LETTERS[1:6])

SummarizedExperiment(assays=list(counts=counts),
                     rowRanges=rowRanges, colData=colData)
```

```
## class: RangedSummarizedExperiment
## dim: 200 6
## metadata(0):
## assays(1): counts
## rownames: NULL
## rowData names(1): feature_id
## colnames(6): A B ... E F
## colData names(1): Treatment
```

A `SummarizedExperiment` can be constructed with or without supplying
a `DataFrame` for the *rowData* argument:

```
SummarizedExperiment(assays=list(counts=counts), colData=colData)
```

```
## class: SummarizedExperiment
## dim: 200 6
## metadata(0):
## assays(1): counts
## rownames: NULL
## rowData names(0):
## colnames(6): A B ... E F
## colData names(1): Treatment
```

# 4 Top-level dimnames vs assay-level dimnames

In addition to the dimnames that are set on a `SummarizedExperiment` object
itself, the individual assays that are stored in the object can have their
own dimnames or not:

```
a1 <- matrix(runif(24), ncol=6, dimnames=list(letters[1:4], LETTERS[1:6]))
a2 <- matrix(rpois(24, 0.8), ncol=6)
a3 <- matrix(101:124, ncol=6, dimnames=list(NULL, LETTERS[1:6]))
se3 <- SummarizedExperiment(SimpleList(a1, a2, a3))
```

The dimnames of the `SummarizedExperiment` object (top-level dimnames):

```
dimnames(se3)
```

```
## [[1]]
## [1] "a" "b" "c" "d"
##
## [[2]]
## [1] "A" "B" "C" "D" "E" "F"
```

When extracting assays from the object, the top-level dimnames are put on
them by default:

```
assay(se3, 2)  # this is 'a2', but with the top-level dimnames on it
```

```
##   A B C D E F
## a 1 0 0 0 0 0
## b 0 1 2 0 2 1
## c 0 0 2 0 2 0
## d 0 1 0 0 1 2
```

```
assay(se3, 3)  # this is 'a3', but with the top-level dimnames on it
```

```
##     A   B   C   D   E   F
## a 101 105 109 113 117 121
## b 102 106 110 114 118 122
## c 103 107 111 115 119 123
## d 104 108 112 116 120 124
```

However if using `withDimnames=FALSE` then the assays are returned
*as-is*, i.e. with their original dimnames (this is how they are stored
in the `SummarizedExperiment` object):

```
assay(se3, 2, withDimnames=FALSE)  # identical to 'a2'
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    1    0    0    0    0    0
## [2,]    0    1    2    0    2    1
## [3,]    0    0    2    0    2    0
## [4,]    0    1    0    0    1    2
```

```
assay(se3, 3, withDimnames=FALSE)  # identical to 'a3'
```

```
##        A   B   C   D   E   F
## [1,] 101 105 109 113 117 121
## [2,] 102 106 110 114 118 122
## [3,] 103 107 111 115 119 123
## [4,] 104 108 112 116 120 124
```

```
rownames(se3) <- strrep(letters[1:4], 3)

dimnames(se3)
```

```
## [[1]]
## [1] "aaa" "bbb" "ccc" "ddd"
##
## [[2]]
## [1] "A" "B" "C" "D" "E" "F"
```

```
assay(se3, 1)  # this is 'a1', but with the top-level dimnames on it
```

```
##             A         B          C         D          E         F
## aaa 0.2954624 0.9722446 0.53774289 0.3973584 0.65643152 0.1666617
## bbb 0.4716552 0.6736350 0.03274751 0.7137514 0.98809375 0.3294234
## ccc 0.3769514 0.4330806 0.05707316 0.7285320 0.04456762 0.6346887
## ddd 0.5291343 0.5676206 0.05260963 0.9471412 0.09622942 0.2723609
```

```
assay(se3, 1, withDimnames=FALSE)  # identical to 'a1'
```

```
##           A         B          C         D          E         F
## a 0.2954624 0.9722446 0.53774289 0.3973584 0.65643152 0.1666617
## b 0.4716552 0.6736350 0.03274751 0.7137514 0.98809375 0.3294234
## c 0.3769514 0.4330806 0.05707316 0.7285320 0.04456762 0.6346887
## d 0.5291343 0.5676206 0.05260963 0.9471412 0.09622942 0.2723609
```

# 5 Common operations on `SummarizedExperiment`

## 5.1 Subsetting

* `[` Performs two dimensional subsetting, just like subsetting a matrix
  or data frame.

```
# subset the first five transcripts and first three samples
se[1:5, 1:3]
```

```
## class: RangedSummarizedExperiment
## dim: 5 3
## metadata(2): '' formula
## assays(1): counts
## rownames(5): ENSG00000000003 ENSG00000000005 ENSG00000000419
##   ENSG00000000457 ENSG00000000460
## rowData names(10): gene_id gene_name ... seq_coord_system symbol
## colnames(3): SRR1039508 SRR1039509 SRR1039512
## colData names(9): SampleName cell ... Sample BioSample
```

* `$` operates on `colData()` columns, for easy sample extraction.

```
se[, se$cell == "N61311"]
```

```
## class: RangedSummarizedExperiment
## dim: 63677 2
## metadata(2): '' formula
## assays(1): counts
## rownames(63677): ENSG00000000003 ENSG00000000005 ... ENSG00000273492
##   ENSG00000273493
## rowData names(10): gene_id gene_name ... seq_coord_system symbol
## colnames(2): SRR1039508 SRR1039509
## colData names(9): SampleName cell ... Sample BioSample
```

## 5.2 Getters and setters

* `rowRanges()` / (`rowData()`), `colData()`, `metadata()`

```
counts <- matrix(1:15, 5, 3, dimnames=list(LETTERS[1:5], LETTERS[1:3]))

dates <- SummarizedExperiment(assays=list(counts=counts),
                              rowData=DataFrame(month=month.name[1:5], day=1:5))

# Subset all January assays
dates[rowData(dates)$month == "January", ]
```

```
## class: SummarizedExperiment
## dim: 1 3
## metadata(0):
## assays(1): counts
## rownames(1): A
## rowData names(2): month day
## colnames(3): A B C
## colData names(0):
```

* `assay()` versus `assays()`
  There are two accessor functions for extracting the assay data from a
  `SummarizedExperiment` object. `assays()` operates on the entire list of assay
  data as a whole, while `assay()` operates on only one assay at a time.
  `assay(x, i)` is simply a convenience function which is equivalent to
  `assays(x)[[i]]`.

```
assays(se)
```

```
## List of length 1
## names(1): counts
```

```
assays(se)[[1]][1:5, 1:5]
```

```
##                 SRR1039508 SRR1039509 SRR1039512 SRR1039513 SRR1039516
## ENSG00000000003        679        448        873        408       1138
## ENSG00000000005          0          0          0          0          0
## ENSG00000000419        467        515        621        365        587
## ENSG00000000457        260        211        263        164        245
## ENSG00000000460         60         55         40         35         78
```

```
# assay defaults to the first assay if no i is given
assay(se)[1:5, 1:5]
```

```
##                 SRR1039508 SRR1039509 SRR1039512 SRR1039513 SRR1039516
## ENSG00000000003        679        448        873        408       1138
## ENSG00000000005          0          0          0          0          0
## ENSG00000000419        467        515        621        365        587
## ENSG00000000457        260        211        263        164        245
## ENSG00000000460         60         55         40         35         78
```

```
assay(se, 1)[1:5, 1:5]
```

```
##                 SRR1039508 SRR1039509 SRR1039512 SRR1039513 SRR1039516
## ENSG00000000003        679        448        873        408       1138
## ENSG00000000005          0          0          0          0          0
## ENSG00000000419        467        515        621        365        587
## ENSG00000000457        260        211        263        164        245
## ENSG00000000460         60         55         40         35         78
```

## 5.3 Range-based operations

* `subsetByOverlaps()`
  `SummarizedExperiment` objects support all of the `findOverlaps()` methods and
  associated functions. This includes `subsetByOverlaps()`, which makes it easy
  to subset a `SummarizedExperiment` object by an interval.

```
# Subset for only rows which are in the interval 100,000 to 110,000 of
# chromosome 1
roi <- GRanges(seqnames="1", ranges=100000:1100000)
subsetByOverlaps(se, roi)
```

```
## class: RangedSummarizedExperiment
## dim: 74 8
## metadata(2): '' formula
## assays(1): counts
## rownames(74): ENSG00000131591 ENSG00000177757 ... ENSG00000272512
##   ENSG00000273443
## rowData names(10): gene_id gene_name ... seq_coord_system symbol
## colnames(8): SRR1039508 SRR1039509 ... SRR1039520 SRR1039521
## colData names(9): SampleName cell ... Sample BioSample
```

# 6 Interactive visualization

The *[iSEE](https://bioconductor.org/packages/3.22/iSEE)* package provides functions for creating an interactive user interface based on the *[shiny](https://CRAN.R-project.org/package%3Dshiny)* package for exploring data stored in `SummarizedExperiment` objects.
Information stored in standard components of `SummarizedExperiment` objects – including assay data, and row and column metadata – are automatically detected and used to populate the interactive multi-panel user interface.
Particular attention is given to the *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* extension of the `SummarizedExperiment` class, with visualization of dimensionality reduction results.

Extensions to the *[iSEE](https://bioconductor.org/packages/3.22/iSEE)* package provide support for more context-dependent functionality:

* *[iSEEde](https://bioconductor.org/packages/3.22/iSEEde)* provides additional panels that facilitate the interactive visualization of differential expression results, including the `DESeqDataSet` extension of `SummarizedExperiment` implemented in *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*.
* *[iSEEpathways](https://bioconductor.org/packages/3.22/iSEEpathways)* provides additional panels for the interactive visualization of pathway analysis results.
* *[iSEEhub](https://bioconductor.org/packages/3.22/iSEEhub)* provides functionality to import data sets stored in the Bioconductor *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)*.
* *[iSEEhub](https://bioconductor.org/packages/3.22/iSEEhub)* provides functionality to import data sets from custom sources (local and remote).

# 7 Session information

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
##  [1] testthat_3.2.3              SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4        jsonlite_2.0.0      compiler_4.5.1
##  [4] BiocManager_1.30.26 brio_1.1.5          jquerylib_0.1.4
##  [7] yaml_2.3.10         fastmap_1.2.0       lattice_0.22-7
## [10] R6_2.6.1            XVector_0.50.0      S4Arrays_1.10.0
## [13] knitr_1.50          DelayedArray_0.36.0 bookdown_0.45
## [16] desc_1.4.3          rprojroot_2.1.1     pillar_1.11.1
## [19] bslib_0.9.0         rlang_1.1.6         cachem_1.1.0
## [22] xfun_0.53           sass_0.4.10         pkgload_1.4.1
## [25] SparseArray_1.10.0  cli_3.6.5           withr_3.0.2
## [28] magrittr_2.0.4      digest_0.6.37       grid_4.5.1
## [31] lifecycle_1.0.4     vctrs_0.6.5         waldo_0.6.2
## [34] glue_1.8.0          evaluate_1.0.5      abind_1.4-8
## [37] rmarkdown_2.30      tools_4.5.1         htmltools_0.5.8.1
```