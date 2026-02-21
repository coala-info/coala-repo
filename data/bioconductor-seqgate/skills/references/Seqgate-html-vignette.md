# SeqGate: Filter lowly expressed features

Christelle Reynès1\* and Stéphanie Rialle2\*\*

1IGF, CNRS, INSERM, Univ Montpellier, Montpellier France
2BioCampus Montpellier, CNRS, INSERM, Univ Montpellier, Montpellier France

\*christelle.reynes@igf.cnrs.fr
\*\*stephanie.rialle@mgx.cnrs.fr

#### 30 October 2025

#### Abstract

Differential expression studies are very common experiments in RNA-Seq. They imply the application of statistical tests to a very high number of genes (or transcripts). Some lowly expressed genes are not likely to be significant, thus it is a good practice to filter them in order to increase the differential genes detection sensitivity. The application of a filtering method for these lowly expressed genes is very common but generally an arbitrary threshold is chosen. Here we propose a novel filtering method, SeqGate, based on the replicates of the experiment that allows to rationalize the determination of the threshold by taking advandage of the data themselves.

#### Package

SeqGate 1.20.0

# Contents

* [1 Introduction: SeqGate method description](#introduction-seqgate-method-description)
* [2 Installation](#installation)
* [3 Filtering with SeqGate](#filtering-with-seqgate)
  + [3.1 Input data](#input-data)
    - [3.1.1 Toy dataset](#toy-dataset)
    - [3.1.2 Getting the SummarizedExperiment input](#getting-the-summarizedexperiment-input)
  + [3.2 Filtering with default options](#filtering-with-default-options)
  + [3.3 Setting custom filtering parameters](#setting-custom-filtering-parameters)
    - [3.3.1 Parameters detailed explanation](#parameters-detailed-explanation)
    - [3.3.2 Custom filtering parameters example](#custom-filtering-parameters-example)
* [4 SessionInfo](#sessioninfo)

# 1 Introduction: SeqGate method description

In order to find a threshold value to filter lowly expressed features, SeqGate
analyzes the distribution of counts found in replicates along with zero counts.
More specifically, features with a customizable minimal proportion of zeros in
one condition are selected. The distribution of counts found in replicates of
that same condition along with those zeros is computed. The chosen threshold is
the count value corresponding to the customizable percentile of this
distribution. Finally, features having a customizable proportion (90% by
default) of replicates with counts below that value in all conditions are
filtered. Default value for all customizable parameters have been set through
extensive simulation batch testing and can be considered as adequate in most
situations.

# 2 Installation

To install SeqGate, start R and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("SeqGate")
```

```
## Bioconductor version 3.22 (BiocManager 1.30.26), R 4.5.1 Patched (2025-08-23
##   r88802)
```

```
## Warning: package(s) not installed when version(s) same as or greater than current; use
##   `force = TRUE` to re-install: 'SeqGate'
```

# 3 Filtering with SeqGate

First load SeqGate:

```
library(SeqGate)
```

```
## Loading required package: S4Vectors
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
## Loading required package: SummarizedExperiment
```

```
## Loading required package: MatrixGenerics
```

```
## Loading required package: matrixStats
```

```
##
## Attaching package: 'MatrixGenerics'
```

```
## The following objects are masked from 'package:matrixStats':
##
##     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
##     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
##     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
##     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
##     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
##     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
##     colWeightedMeans, colWeightedMedians, colWeightedSds,
##     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
##     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
##     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
##     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
##     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
##     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
##     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
##     rowWeightedSds, rowWeightedVars
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
##
## Attaching package: 'Biobase'
```

```
## The following object is masked from 'package:MatrixGenerics':
##
##     rowMedians
```

```
## The following objects are masked from 'package:matrixStats':
##
##     anyMissing, rowMedians
```

## 3.1 Input data

The main input data is a
[SummarizedExperiment] (<https://bioconductor.org/packages/release/bioc/html/>
SummarizedExperiment.html)
object which contains an assay with count data. Briefly, a SummarizedExperiment
container contains one or more assays, each represented by a matrix-like object
of numeric or other mode. The rows typically represent genomic ranges of
interest and the columns represent samples. For SeqGate, the
SummarizedExperiment object must contain at least one assay of numeric counts,
and a DataFrame describing the columns, in particular a column telling the
biological condition the sample belongs to.
To apply SeqGate, the SummarizedExperiment object, the assay name and the column
describing the condition of each sample in the colData dataframe, must be given.

### 3.1.1 Toy dataset

Let’s load some toy data set. This data set is an extract from a human
transcriptome dataset produced by Strub *et al.* (2011), in which human cells
expressing the Microphtalmia Transcription Factor (MiTF) are compared to cells
in which the MiTF is repressed. The extract counts 1,000 genes with expression
measured in 3 samples for each biological condition (the full table of read
counts is available in the Supplementary materials of Dillies, M.A. *et al.*
(2012)).

```
data(data_MiTF_1000genes)
head(data_MiTF_1000genes)
```

```
##           A1   A2   B1   B2   A3   B3
## G000001  576 1048  993  756  825 1266
## G000002    0    0    0    0    0    0
## G000003 2590 3401 2674 2078 2879 3221
## G000004  109   35  255  169  111  184
## G000005  293  375 1289  719  415 1139
## G000006    0    0    8    0    0    4
```

And now we define a vector indicating the biological condition corresponding to
each column of data\_MiTF\_1000. Here the two biological conditions are ‘A’ and
‘B’.

```
cond<-c("A","A","B","B","A","B")
```

### 3.1.2 Getting the SummarizedExperiment input

The toy dataset that we have just loaded is not yet a SummarizedExperiment
object, such as required in Seqgate input. We thus need to create it,
from the count matrix and the biological condition annotation.

```
rowData <- DataFrame(row.names=rownames(data_MiTF_1000genes))
colData <- DataFrame(Conditions=cond)
counts_strub <- SummarizedExperiment(
                  assays=list(counts=data_MiTF_1000genes),
                  rowData=rowData,
                  colData=colData)
```

## 3.2 Filtering with default options

By default, SeqGate only needs the SummarizedExperiment object along with the
name of the assay we want to work with, and the name of the column which
contains the biological conditions annotation. Thus, we can apply the SeqGate
method filtering, by calling the following code:

```
counts_strub <- applySeqGate(counts_strub,"counts","Conditions")
```

```
## assay(countsSE,counts) dataframe has
## been converted to a matrix.
```

```
## The SeqGate filter parameters applied are:
## prop0=0.666666666666667
## percentile=0.9
## propUpThresh=0.9
## The applied threshold is 13.
```

As a result, the input SummarizedExperiment object now includes a new column in
the rowData DataFrame, named onFilter. This column is a logical vector that
indicates if the gene should be kept after filtering (TRUE) or not (FALSE). The
metadata of the object also include a new element, named “threshold”, which
gives the value of the applied threshold.

Thus, to get the matrix of features intended to be kept for the downstream
analysis:

```
keptGenes <- assay(counts_strub[rowData(counts_strub)$onFilter == TRUE,])
head(keptGenes)
```

```
##           A1   A2   B1   B2   A3   B3
## G000001  576 1048  993  756  825 1266
## G000003 2590 3401 2674 2078 2879 3221
## G000004  109   35  255  169  111  184
## G000005  293  375 1289  719  415 1139
## G000008 1098 1281 1409 1284 1015 1640
## G000009  993  953 1488 1065 1293 1599
```

```
dim(keptGenes)
```

```
## [1] 748   6
```

To get the applied threshold:

```
metadata(counts_strub)$threshold
```

```
## 90%
##  13
```

We can also get the matrix of filtered genes:

```
filteredOut <- assay(counts_strub[rowData(counts_strub)$onFilter == FALSE,])
head(filteredOut)
```

```
##         A1 A2 B1 B2 A3 B3
## G000002  0  0  0  0  0  0
## G000006  0  0  8  0  0  4
## G000007 51 10 56  0 38 46
## G000014  0 35 48  0 55  9
## G000016 13  0  0  0  0  0
## G000021  0  0  0  0  0 10
```

To conclude, we can see that, from the initial set of 1,000 genes,
748 have been kept, after the application of a threshold of
13: all genes having less than
90%
replicates with less than 13 reads are
discarded.

## 3.3 Setting custom filtering parameters

### 3.3.1 Parameters detailed explanation

Besides the three mandatory parameters described above, the applySeqGate
function also have three other parameters, that can be set to refine the
filtering:

* prop0: this is minimal proportion of zeros among a condition to consider that
  the feature is not or lowly expressed.
* percentile: percentile used on the ‘max’ distribution to determine the
  filtering threshold value.
* propUpThresh: proportion of counts to be above the threshold in at least one
  condition to keep the feature.

By default, ‘prop0’ is set to the maximum number of replicates minus one,
divided by the maximum number of replicates. In the example above, as we have 3
replicates in both conditions, the maximum number of replicates is 3. Thus, the
parameter ‘prop0’ is set to 2/3. This means that we consider that the gene is
lowly expressed if it has 2 zeros among its 3 replicates.

The distribution of maximum counts from all the lowly expressed genes (selected
according to ‘prop0’) is then computed. The idea is to see how high a count can
be in a replicate alongside a zero in another replicate. In order to introduce
flexibility, we do not simply take the maximum count of the distribution but a
‘percentile’ of this distribution. By default, when the number of replicates in
at least one condition is below 5, ‘percentile’ is set to 0.9. In the above
example, the 90th percentile of the distribution of maximum counts seen
alongside a zero is 13, and this is the
threshold that we will apply in order to actually filter the lowly expressed
genes.

Finally, the filter is applied according to a last parameter: propUpThresh.
SeqGate does keep those genes whose counts are above the computed threshold in
at least ‘propUpThresh’ replicates, in at least one condition. Still in the
example used precedently, this means that all genes whose counts are above
13 in 3 x 0.9 = 2.7 replicates, are kept.
As it is not possible to consider 2.7 replicates, the value is rounded to the
next integer, that is 3 in this case. Finally in this example, a gene is kept if
all its 3 replicates have a count above 13,
in at least one condition.

### 3.3.2 Custom filtering parameters example

Default value for all customizable parameters have been set through extensive
simulation batch testing and can be considered as adequate in most situations.
However, one may consider that the default parameters are not suited to its
experiment.
In that case, custom values can be given:

```
counts_strub <- applySeqGate(counts_strub,"counts","Conditions",
             prop0=1/3,
             percentile=0.8,
             propUpThresh=0.5)
```

```
## The SeqGate filter parameters applied are:
## prop0=0.333333333333333
## percentile=0.8
## propUpThresh=0.5
## The applied threshold is 18.
```

This time, from the initial set of 1,000 genes,
765 have been kept,
after the application of a threshold of 18.

# 4 SessionInfo

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
##  [1] SeqGate_1.20.0              SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] MatrixGenerics_1.22.0       matrixStats_1.5.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              knitr_1.50
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           rlang_1.1.6         xfun_0.53
##  [4] DelayedArray_0.36.0 jsonlite_2.0.0      htmltools_0.5.8.1
##  [7] sass_0.4.10         rmarkdown_2.30      grid_4.5.1
## [10] abind_1.4-8         evaluate_1.0.5      jquerylib_0.1.4
## [13] fastmap_1.2.0       yaml_2.3.10         lifecycle_1.0.4
## [16] bookdown_0.45       BiocManager_1.30.26 compiler_4.5.1
## [19] XVector_0.50.0      lattice_0.22-7      digest_0.6.37
## [22] R6_2.6.1            SparseArray_1.10.0  Matrix_1.7-4
## [25] bslib_0.9.0         tools_4.5.1         S4Arrays_1.10.0
## [28] cachem_1.1.0
```