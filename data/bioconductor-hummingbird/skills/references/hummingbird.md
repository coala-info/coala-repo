# The hummingbird

Eleni Adam, Tieming Ji, Desh Ranjan

#### 30 October 2025

#### Package

hummingbird 1.20.0

# Contents

* [0.1 Introduction](#introduction)
* [0.2 Functions](#functions)
* [0.3 Sample Dataset](#sample-dataset)
* [0.4 Example](#example)
* [0.5 Citation](#citation)
* [0.6 Reference](#reference)
* [0.7 Session Info](#session-info)

## 0.1 Introduction

*hummingbird* is a package for identifying differentially methylated regions
(DMRs) between case and control groups using whole genome bisulfite sequencing
(WGBS) or reduced representative bisulfite sequencing (RRBS) experiment data.

The *hummingbird* package uses a Bayesian hidden Markov model (HMM) for
detecting DMRs. It fits a Bayesian HMM for one chromosome at a time. The final
output of *hummingbird* are the detected DMRs with start and end positions in a
given chromosome, directions of the DMRs (hyper- or hypo-), and the numbers of
CpGs in these DMRs.

## 0.2 Functions

The *hummingbird* package contains the following three functions:

**1.** **hummingbirdEM**: This function reads input data, sets initial values,
executes the Expectation-Maximization (EM) algorithm for the Bayesian HMM and
infers the best sequence of methylation states.

It takes three parameters as input: the control group data, the case group
data and the bin size. A call to this function looks like: **hummingbirdEM**(
experimentInfoControl, experimentInfoCase, binSize = 40), where
experimentInfoControl and experimentInfoCase, respectively contain input data
for the control and case groups. This input data includes number of methylated
reads and number of unmethylated reads for each CpG position for an entire
chromosome. Their format needs to be that of a SummarizedExperiment object. In
section 3 (Sample Dataset), we provide detailed information on how to organize
data into a SummarizedExperiment object. The third parameter binSize is the
user desired bin size. Our default bin size is 40 base pairs. A smaller bin
size leads to more accurate DMR boundary prediction. A larger bin size leads to
faster computational time. The default bin size is chosen by balancing these
two factors. More detailed information on the statistical model and how to
choose a good bin size can be found in Ji (2019).

**2.** **hummingbirdPostAdjustment**: This function is usually executed after
executing **hummingbirdEM**. It allows the researchers to place three
additional requirements on DMRs: 1) the minimum length of a DMR, 2) the minimum
number of CpGs in a DMR, and 3) the maximum distance (in base pairs) between
any two adjacent CpGs in a DMR.

The **hummingbirdPostAdjustment** function has six parameters.
A call to this function looks like: **hummingbirdPostAdjustment**(
experimentInfoControl, experimentInfoCase, emInfo, minCpGs = 10, minLength =
500, maxGap = 300), where experimentInfoControl and experimentInfoCase take the
same input data as the function **hummingbirdEM**; emInfo are results from
running the function **hummingbirdEM**; minCpGs, minLength, maxGap are the
aforementioned three extra requirements. Their default values are 10, 500, and
300, respectively.

**3.** **hummingbirdGraph**: This function generates observation and prediction
graphs for a user specified region. It is usually called after executing
**hummingbirdEM** and **hummingbirdPostAdjustment** functions.

The function **hummingbirdGraph** needs five parameters. A call to this
function would appear as: **hummingbirdGraph**(experimentInfoControl,
experimentInfoCase, postAdjInfoDMRs, coord1, coord2), where
experimentInfoControl and experimentInfoCase are input data as in
**hummingbirdEM**. postAdjInfoDMRs are the reads in the detected DMRs from the
results of the function **hummingbirdPostAdjustment** and coord1 and coord2
are the start and end genomic positions for plotting.
The execution of this function produces two
figures, which we call the observation figure and the prediction figure. The
observation figure shows bin-wise average methylation rate for case and control
groups. The prediction figure shows bin-wise prediction, where “0” denotes
a predicted normal bin; “1” denotes a predicted hypermethylated bin;
and “-1” denotes a predicted hypomethylated bin.

## 0.3 Sample Dataset

A sample dataset, called “exampleHummingbird”, is provided with the package as
an example.

Specifically, it is partial data of chromosome 29 in the large offspring
syndrome (LOS) study described in Chen Z. et al (2017). The raw FASTQ files of
the WGBS experiment from this study are publicly available at Gene Expression
Omnibus (GEO) database with accession no. GSE93775.

In this section, we will use this example data to demonstrate how to organize
data in a correct format for our *hummingbird* package. Our package requires R
version 4.0 and Rcpp package.

```
library(GenomicRanges)
library(SummarizedExperiment)
library(hummingbird)
data(exampleHummingbird)
```

First, we use “abnormUM”, “abnormM”, “normM”, and “normUM”, respectively, to
denote four matrices that contain numbers of unmethylated reads for the
abnormal group, numbers of methylated reads for the abnormal group, numbers of
methylated reads for the normal group, and the numbers of unmethylated reads
for the normal group. For each of these four matrices, each row is a CpG
position, and each column is a biological replicate (for example, a patient, a
mouse, etc.). In the LOS study, the abnormal group has four cattle and the
normal group has four cattle also. Thus, these four matrices each contain four
columns. We require these four matrices to only contain commonly shared CpGs
at the same genomic positions. CpGs that are not shared by all biological
replicates are removed before analysis. The following shows the first 6 rows
from the normM matrix.

```
head(normM)
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    8    7   12   10
## [2,]    4    4    2    4
## [3,]    0    1    0    4
## [4,]    2    2    0    2
## [5,]    1    1    1    1
## [6,]    8    0    0    7
```

Our Bayesian HMM does not have a requirement of minimum number of biological
replicates in each treatment group. The case group (or abnormal group) and
control group (or normal group) can have either one or more replicates. The two
groups can have unequal number of replicates.

Second, we use vector pos to contain genomic positions of these CpGs in the
abovementioned four matrices – “abnormUM”, “abnormM”, “normM”, and “normUM”.

```
head(pos)
```

```
##      [,1]
## [1,]  271
## [2,]  331
## [3,]  363
## [4,]  386
## [5,]  418
## [6,]  464
```

To use the *hummingbird* package, we need to put the four matrices and vector
pos in two SummarizedExperiment objects, one for the case group and one for the
control group. This can be done as follows:

```
pos <- pos[,1]
assaysControl <- list(normM = normM, normUM = normUM)
assaysCase <- list(abnormM = abnormM, abnormUM = abnormUM)
exampleSEControl <- SummarizedExperiment(assaysControl,
                                        rowRanges = GPos("chr29", pos))
exampleSECase <- SummarizedExperiment(assaysCase,
                                    rowRanges = GPos("chr29", pos))
```

exampleSEControl and exampleSECase are ready for use by the *hummingbird*
package.

To display data in the SummarizedExperiment object, we can do the following.

The CpG positions are:

```
rowRanges(exampleSEControl)
```

```
## UnstitchedGPos object with 4746 positions and 0 metadata columns:
##          seqnames       pos strand
##             <Rle> <integer>  <Rle>
##      [1]    chr29       271      *
##      [2]    chr29       331      *
##      [3]    chr29       363      *
##      [4]    chr29       386      *
##      [5]    chr29       418      *
##      ...      ...       ...    ...
##   [4742]    chr29    399795      *
##   [4743]    chr29    399802      *
##   [4744]    chr29    399833      *
##   [4745]    chr29    399864      *
##   [4746]    chr29    399987      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
rowRanges(exampleSECase)
```

```
## UnstitchedGPos object with 4746 positions and 0 metadata columns:
##          seqnames       pos strand
##             <Rle> <integer>  <Rle>
##      [1]    chr29       271      *
##      [2]    chr29       331      *
##      [3]    chr29       363      *
##      [4]    chr29       386      *
##      [5]    chr29       418      *
##      ...      ...       ...    ...
##   [4742]    chr29    399795      *
##   [4743]    chr29    399802      *
##   [4744]    chr29    399833      *
##   [4745]    chr29    399864      *
##   [4746]    chr29    399987      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

The matrices containing the methylated and unmethylated read count data of the
normal group are as follows:

```
head(assays(exampleSEControl)[["normM"]])
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    8    7   12   10
## [2,]    4    4    2    4
## [3,]    0    1    0    4
## [4,]    2    2    0    2
## [5,]    1    1    1    1
## [6,]    8    0    0    7
```

```
head(assays(exampleSEControl)[["normUM"]])
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    4    7    2    4
## [2,]   12   11   11   10
## [3,]   10   10    8    7
## [4,]    8   11   10   13
## [5,]    7   11    6   17
## [6,]    8    9    7    8
```

The matrices containing the methylated and unmethylated read count data of the
abnormal group are as follows:

```
head(assays(exampleSECase)[["abnormM"]])
```

```
##      [,1] [,2] [,3] [,4]
## [1,]   10    7   10   13
## [2,]    6    2    6    8
## [3,]    3    0    3    0
## [4,]    0    1    1    0
## [5,]    1    1    2    2
## [6,]    6    4    8    7
```

```
head(assays(exampleSECase)[["abnormUM"]])
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    6    3    3    3
## [2,]    9    5    6   12
## [3,]   12   11    8   20
## [4,]    8   13   12   15
## [5,]   10   12   12   19
## [6,]    8    7    6   14
```

## 0.4 Example

This section uses the abovementioned example dataset to show how to use our
*hummingbird* package to infer methylation states. First, we need to load the
*hummingbird* package and the exampleHummingbird dataset. The
exampleHummingbird dataset contains the SummarizedExperiment objects,
exampleSEControl and exampleSECase, that are ready for use by the
*hummingbird* package.

```
library(hummingbird)
data(exampleHummingbird)
```

```
emInfo <- hummingbirdEM(experimentInfoControl = exampleSEControl,
                        experimentInfoCase = exampleSECase, binSize = 40)
```

```
## Reading input...
## Bin size: 40.
## Total lines: 4746, total replicates in normal group: 4 and in abnormal group: 4
## Processing input...
## Processing input completed...
## Calculation of the initial value...
## Initial Value calculated...
## EM begins...
## Iteration: 1
## Iteration: 2
## Iteration: 3
## Iteration: 4
## Iteration: 5
## Iteration: 6
## Iteration: 7
## Iteration: 8
## Iteration: 9
## Iteration: 10
## Iteration: 11
## Iteration: 12
## Iteration: 13
## Iteration: 14
## Iteration: 15
## Iteration: 16
## Iteration: 17
## Iteration: 18
## Iteration: 19
## Iteration: 20
## Iteration: 21
## Iteration: 22
## Calculation of states...
## EM converged after 22 iterations.
## Saving output...
## ****** Program ended. ******
```

```
emInfo
```

```
## GRanges object with 3296 ranges and 4 metadata columns:
##          seqnames        ranges strand |  distance      norm    abnorm
##             <Rle>     <IRanges>  <Rle> | <integer> <numeric> <numeric>
##      [1]    chr29       271-310      * |        40  0.672414  0.711864
##      [2]    chr29       311-350      * |        40  0.258065  0.413793
##      [3]    chr29       351-390      * |        40  0.156250  0.104348
##      [4]    chr29       391-430      * |        40  0.122449  0.126984
##      [5]    chr29       431-470      * |        40  0.333333  0.421875
##      ...      ...           ...    ... .       ...       ...       ...
##   [3292]    chr29 399671-399710      * |        40  0.250000  0.294118
##   [3293]    chr29 399751-399790      * |        80  0.617021  0.555556
##   [3294]    chr29 399791-399830      * |        40  0.700000  0.743902
##   [3295]    chr29 399831-399870      * |        40  0.448980  0.416667
##   [3296]    chr29 399951-399990      * |       120  0.108696  0.268293
##          direction
##          <integer>
##      [1]         1
##      [2]         1
##      [3]         0
##      [4]         0
##      [5]         0
##      ...       ...
##   [3292]         0
##   [3293]         0
##   [3294]         0
##   [3295]         0
##   [3296]         0
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

emInfo is a GenomicRanges object that contains the start and end positions of
each bin, the distance between the current bin the bin ahead of it, the average
methylation rate of normal and abnormal groups and the predicted direction of
methylation change (“0” means a predicted normal bin; “1” means a predicted
hypermethylated bin; “-1” means a predicted hypomethylated bin).

hummingbirdPostAdjustment adjusts emInfo such that each detected DMR has a
user-defined minimum length, minimum number of CpGs, and maximum gap between
adjacent CpGs in each DMR. If the user does not define, the default values are
minLength=500, minCpGs=10, and maxGap=300.

```
postAdjInfo <- hummingbirdPostAdjustment(
    experimentInfoControl = exampleSEControl,
    experimentInfoCase = exampleSECase,
    emInfo = emInfo, minCpGs = 10,
    minLength = 100, maxGap = 300)
```

```
## Reading input...
## Min CpGs: 10, Min Length: 100, Max gap: 300.
## Post Adjustment begins...
## Post Adjustment completed...
## Output DMRs...
## There are 3 DMRs in total. The first 3 are displayed.
## Region: Start, End, Length, Direction, CpGs
## 1: 98391, 98590, 200, -1, 10
## 2: 107991, 108350, 360, -1, 12
## 3: 110551, 110870, 320, -1, 10
## Saving output...
## ****** Program ended. ******
```

```
postAdjInfo$DMRs
```

```
## GRanges object with 3 ranges and 3 metadata columns:
##       seqnames        ranges strand |    length direction      CpGs
##          <Rle>     <IRanges>  <Rle> | <integer> <integer> <integer>
##   [1]    chr29   98391-98590      * |       200        -1        10
##   [2]    chr29 107991-108350      * |       360        -1        12
##   [3]    chr29 110551-110870      * |       320        -1        10
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

postAdjInfo is a list of two GenomicRanges objects, the DMRs and the
obsPostAdj.
Specifically, the DMRs contains the detected regions based on the user-defined
arguments (minLength, minCpGs, and maxGap). It contains the refined DMRs with
the start genomic position, the end genomic position, length of the region,
direction of predicted methylation change (“0” indicates no significant change,
“1” indicates predicted hyper-methylation, and “-1” indicates predicted
hypo-methylation), and the number of CpGs. The obsPostAdj object contains
methylation status of each CpG site.

At last, we use hummingbirdGraph to visualize observations and predictions for
a user-defined genomic region. In the observation plot, the horizontal axis
shows genomic positions; the vertical axis displays sample average methylation
rates for normal and abnormal groups, respectively, for each bin. The
prediction plot displays the sample average difference between the abnormal
group and the normal group for each bin. Numbers (“0”, “1”, “-1”) indicate the
predictions.

The next two figures (the former is an observation plot and the latter is a
prediction plot) visualize the second DMR in the above output.

```
hummingbirdGraph(experimentInfoControl = exampleSEControl,
                experimentInfoCase = exampleSECase,
                postAdjInfoDMRs = postAdjInfo$DMRs,
                coord1 = 107991, coord2 = 108350)
```

![](data:image/png;base64...)![](data:image/png;base64...)

## 0.5 Citation

If you use the *hummingbird* package, please cite the following paper that
includes the statistical model and fitting algorithm:

* Ji (2019) A Bayesian hidden Markov model for detecting differentially
  methylated regions. Biometrics 75(2):663‐673.

## 0.6 Reference

Real data from the LOS study are from the following paper:

* Chen et al. (2017) Global misregulation of genes largely uncoupled to DNA
  methylome epimutations characterizes a congenital overgrowth syndrome.
  Scientific Reports 7, 12667.

## 0.7 Session Info

The presented analysis was conducted on:

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
##  [1] hummingbird_1.20.0          SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [5] matrixStats_1.5.0           GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4        jsonlite_2.0.0      compiler_4.5.1
##  [4] BiocManager_1.30.26 tinytex_0.57        Rcpp_1.1.0
##  [7] magick_2.9.0        jquerylib_0.1.4     yaml_2.3.10
## [10] fastmap_1.2.0       lattice_0.22-7      R6_2.6.1
## [13] XVector_0.50.0      S4Arrays_1.10.0     knitr_1.50
## [16] DelayedArray_0.36.0 bookdown_0.45       bslib_0.9.0
## [19] rlang_1.1.6         cachem_1.1.0        xfun_0.53
## [22] sass_0.4.10         SparseArray_1.10.0  cli_3.6.5
## [25] magrittr_2.0.4      digest_0.6.37       grid_4.5.1
## [28] lifecycle_1.0.4     evaluate_1.0.5      abind_1.4-8
## [31] rmarkdown_2.30      tools_4.5.1         htmltools_0.5.8.1
```