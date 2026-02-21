# rmspc User Guide

Vahid Jalili, Marzia Angela Cremona, Fernando Palluzzi, Meriem Bahda

#### October 30, 2025

# Contents

* [1 MSPC](#mspc)
* [2 Run MSPC from Command Line or as an R Package](#run-mspc-from-command-line-or-as-an-r-package)
* [3 Prerequisites](#prerequisites)
* [4 Using the rmspc package](#using-the-rmspc-package)
  + [4.1 Installing and loading the package](#installing-and-loading-the-package)
  + [4.2 Required arguments of the mspc function](#required-arguments-of-the-mspc-function)
  + [4.3 Scenario 1: Input as path file to BED files](#scenario-1-input-as-path-file-to-bed-files)
  + [4.4 Scenario 2: Input as Granges objects](#scenario-2-input-as-granges-objects)
* [5 Session Information](#session-information)
* [6 Bibliographic references](#bibliographic-references)

# 1 MSPC

The analysis of ChIP-seq samples outputs a number of enriched regions
(commonly known as “peaks”), each indicating a protein-DNA interaction
or a specific chromatin modification. When replicate samples
are analyzed, overlapping peaks are expected. This repeated evidence
can therefore be used to locally lower the minimum significance
required to accept a peak. [MSPC](https://genometric.github.io/MSPC/)
is a method for joint analysis of weak peaks. Given a set of peaks from
(biological or technical) replicates, MSPC combines the p-values of
overlapping enriched regions, and allows the “rescue” of weak peaks
occurring in more than one replicate. In other words, MSPC comparatively
evaluates ChIP-seq peaks and combines the statistical significance of
repeated evidences, with the aim of lowering the minimum significance
required to “rescue” weak peaks; hence reducing false-negatives.

# 2 Run MSPC from Command Line or as an R Package

The MSPC method is implemented as a
[C# .NET library](https://www.nuget.org/packages/Genometric.MSPC.Core)
with two interfaces: A cross-platform command line interface,
and an R package. Both interfaces are built on the same library,
hence they provide the same functionality and produce the same output.

The documentation for running the package from a terminal on Linux,
macOS, and Windows is available at
[this page](https://genometric.github.io/MSPC/docs/quick_start).
The present package, `rmspc`, is developed to run MSPC from R.
The package facilitates usage and integration of MSPC with
pipelines/scripts written in R. This document explores how
to use MSPC program from Rstudio, using the `rmspc` package.

# 3 Prerequisites

A prerequisite for the rmspc package is .NET 9.0 (since it is developed
on program implemented in C# .NET). You can check if .NET is installed
using the command `dotnet --info` run in a terminal.
If .NET is installed, the output of the command shows the version
of the installed framework (should be 9.0). If not installed,
you may install following
[these instructions](https://dotnet.microsoft.com/en-us/download/dotnet/9.0).

# 4 Using the rmspc package

## 4.1 Installing and loading the package

The installation of the package goes as follows :

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("rmspc")
```

If the package BiocManager is not installed in the user’s computer,
it will be installed as well.

A package only needs to be installed once. We load the `rmspc` package
into an R session :

```
library(rmspc)
```

The package has one external function: `mspc`. This is the main function
of the package that we use to run the MSPC program in R.

## 4.2 Required arguments of the mspc function

There are 4 required arguments that the user needs to specify to run the
`mspc` function.

These arguments are:

* `input`: Character vector (file path of BED files) or a GRanges list.
* `replicateType`: Character string. This argument defines the replicate
  type. Possible values : ‘Bio’, ‘Biological’, ‘Tec’, ‘Technical’.
* `stringencyThreshold`: A real number of type `Double`. A threshold
  on p-values, where peaks with p-value lower than this threshold are
  considered stringent peaks.
* `weakThreshold`: A real number of type `Double`. A threshold on
  p-values, such that peaks with p-value between this and the stringency
  threshold are considered weak peaks.

More information about the arguments of the `mspc` function can be
found in the package documentation.

It is important to note that the `input` argument can be given in
two possible formats.

## 4.3 Scenario 1: Input as path file to BED files

In this first scenario, we suppose the samples we want to use as
input data for the `mspc` function are in a BED file format. We
will use for this example the external data available in the package.

```
path <- system.file("extdata", package = "rmspc")
```

We have two sample files available in the directory inst/extdata of
the package :

```
list.files(path)
```

```
## [1] "rep1.bed" "rep2.bed"
```

More information about these sample files is available in the data
documentation file.

We specify the input argument. In this first scenario, the input
argument is a character vector. Each element of the vector is a file
path of a BED file.

```
input1 <- paste0(path, "/rep1.bed")
input2 <- paste0(path, "/rep2.bed")
input <- c(input1, input2)
input
```

```
## [1] "/tmp/RtmpDvJ2iP/Rinst2b7912374a4aa0/rmspc/extdata/rep1.bed"
## [2] "/tmp/RtmpDvJ2iP/Rinst2b7912374a4aa0/rmspc/extdata/rep2.bed"
```

When the `mspc` function is called, it creates a number of files in
the user’s computer. If the user wishes to keep all the files
generated in their computer, they can set the argument `keep` to `TRUE`.

More information regarding this argument is available in the
documentation.

We run the `mspc` function as follows :

```
results <- mspc(
    input = input, replicateType = "Technical",
    stringencyThreshold = 1e-8,
    weakThreshold = 1e-4, gamma = 1e-8,
    keep = FALSE,GRanges = TRUE,
    multipleIntersections = "Lowest",
    c = 2,alpha = 0.05)
```

```
## Export Directory: /tmp/Rtmp0OaHqN_0
##
## .::...Parsing Samples....::.
##    #             Filename    Read peaks# Min p-value Mean p-value    Max p-value
## ---- --------------------    ----------- ----------- ------------    -----------
##  1/2                 rep1          5,458  5.012E-071   1.215E-003     1.000E-002
##  2/2                 rep2          4,119  6.607E-239   1.778E-004     9.550E-003
##
## .::..Analyzing Samples...::.
## [1/4] Initializing
## [2/4] Processing samples
##
  └── 0/6,045   (0.000%) peaks
  └── 2,657/6,045   (43.954%) peaks processed
  └── 6,045/6,045   (100.000%) peaks processed
## [3/4] Performing Multiple testing correction
## [4/4] Creating consensus peaks set
##
## .::....Saving Results....::.
##
## .::..Summary Statistics..::.
##    #             Filename    Read peaks# Background      Weak    Stringent   Confirmed   Discarded   TruePositive    FalsePositive
## ---- --------------------    ----------- ----------  --------    ---------   ---------   ---------   ------------    -------------
##  1/2                 rep1          5,458    51.319%   39.080%       9.601%     27.318%     21.363%        27.318%           0.000%
##  2/2                 rep2          4,119    17.747%   48.216%      34.037%     30.104%     52.149%        30.104%           0.000%
##
## .::.Consensus Peaks Count.::.
## 1,239
##
##
## Elapsed time: 00:00:19.0875544
## All processes successfully finished.
```

The `mspc` function prints the results of the MSPC program.
The first line of the output printed gives the exported directory,
which is the directory where the files generated by the
`mspc` function are created.

The function returns the following:

1. `status`: Integer. The exit status of running the `mspc` function.
   A `0` exit status means the function ran successfully.
2. `filesCreated`: List of character vectors. It lists the names of
   the files generated while running the `mspc` function.
3. `GrangesObjects`: GRanges list. All the files generated while
   running the `mspc` function are imported as GRanges objects,
   and are combined into a GRanges list.

It is important to note that the `mspc` function does not
always return these three elements. The output of the function
depends on the arguments `keep` and `GRanges` given to
the `mspc` function.

In this example, we chose to set the argument `keep` to `FALSE`,
and `GRanges` to `TRUE`.

By doing so, we chose to ask the function to return all the
files generated as GRanges objects, but to not keep them in
the computer.
The objects returned by the `mspc` function in this example
are therefore :

```
results$status
```

```
## [1] 0
```

```
head(results$GRangesObjects,3)
```

```
## $ConsensusPeaks
## GRanges object with 1239 ranges and 2 metadata columns:
##          seqnames              ranges strand |           name     score
##             <Rle>           <IRanges>  <Rle> |    <character> <numeric>
##      [1]     chr1         32565-33040      * | MSPC_Peak_1239    61.843
##      [2]     chr1         34688-34887      * | MSPC_Peak_1238    14.490
##      [3]     chr1         34973-35206      * | MSPC_Peak_1237    10.042
##      [4]     chr1         38569-38849      * | MSPC_Peak_1236    24.609
##      [5]     chr1       437581-437800      * | MSPC_Peak_1235    11.529
##      ...      ...                 ...    ... .            ...       ...
##   [1235]     chr1 248100316-248100550      * |    MSPC_Peak_5     8.706
##   [1236]     chr1 249152183-249153033      * |    MSPC_Peak_4    44.835
##   [1237]     chr1 249153179-249153549      * |    MSPC_Peak_3    10.678
##   [1238]     chr1 249168024-249168194      * |    MSPC_Peak_2    11.693
##   [1239]     chr1 249232854-249233102      * |    MSPC_Peak_1    23.832
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $`rep1/Background`
## GRanges object with 2801 ranges and 2 metadata columns:
##          seqnames              ranges strand |           name     score
##             <Rle>           <IRanges>  <Rle> |    <character> <numeric>
##      [1]     chr1         10000-10039      * |    MACS_peak_1      2.42
##      [2]     chr1         10102-10190      * |    MACS_peak_2      3.23
##      [3]     chr1         29304-29382      * |    MACS_peak_3      2.44
##      [4]     chr1       132296-132335      * |    MACS_peak_9      3.58
##      [5]     chr1       227521-227560      * |   MACS_peak_11      2.70
##      ...      ...                 ...    ... .            ...       ...
##   [2797]     chr1 248610772-248610811      * | MACS_peak_5442      2.52
##   [2798]     chr1 249104439-249104478      * | MACS_peak_5446      2.02
##   [2799]     chr1 249162600-249162639      * | MACS_peak_5452      3.67
##   [2800]     chr1 249219095-249219134      * | MACS_peak_5455      3.58
##   [2801]     chr1 249230903-249230943      * | MACS_peak_5456      3.50
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $`rep1/Confirmed`
## GRanges object with 1491 ranges and 2 metadata columns:
##          seqnames              ranges strand |           name     score
##             <Rle>           <IRanges>  <Rle> |    <character> <numeric>
##      [1]     chr1         32601-32680      * |    MACS_peak_4      4.08
##      [2]     chr1         32727-32936      * |    MACS_peak_5     17.50
##      [3]     chr1         34690-34797      * |    MACS_peak_6      5.82
##      [4]     chr1         35084-35124      * |    MACS_peak_7      4.59
##      [5]     chr1         38594-38836      * |    MACS_peak_8     10.70
##      ...      ...                 ...    ... .            ...       ...
##   [1487]     chr1 249152329-249152446      * | MACS_peak_5449     10.70
##   [1488]     chr1 249152889-249152949      * | MACS_peak_5450      5.65
##   [1489]     chr1 249153389-249153472      * | MACS_peak_5451      6.28
##   [1490]     chr1 249168083-249168158      * | MACS_peak_5453      4.75
##   [1491]     chr1 249232876-249233088      * | MACS_peak_5458      7.13
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Each element of the `GRangesObjects` of the output can be
accessed as such:

```
results$GRangesObjects$ConsensusPeaks
```

```
## GRanges object with 1239 ranges and 2 metadata columns:
##          seqnames              ranges strand |           name     score
##             <Rle>           <IRanges>  <Rle> |    <character> <numeric>
##      [1]     chr1         32565-33040      * | MSPC_Peak_1239    61.843
##      [2]     chr1         34688-34887      * | MSPC_Peak_1238    14.490
##      [3]     chr1         34973-35206      * | MSPC_Peak_1237    10.042
##      [4]     chr1         38569-38849      * | MSPC_Peak_1236    24.609
##      [5]     chr1       437581-437800      * | MSPC_Peak_1235    11.529
##      ...      ...                 ...    ... .            ...       ...
##   [1235]     chr1 248100316-248100550      * |    MSPC_Peak_5     8.706
##   [1236]     chr1 249152183-249153033      * |    MSPC_Peak_4    44.835
##   [1237]     chr1 249153179-249153549      * |    MSPC_Peak_3    10.678
##   [1238]     chr1 249168024-249168194      * |    MSPC_Peak_2    11.693
##   [1239]     chr1 249232854-249233102      * |    MSPC_Peak_1    23.832
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
results$GRangesObjects$`rep1/Background`
```

```
## GRanges object with 2801 ranges and 2 metadata columns:
##          seqnames              ranges strand |           name     score
##             <Rle>           <IRanges>  <Rle> |    <character> <numeric>
##      [1]     chr1         10000-10039      * |    MACS_peak_1      2.42
##      [2]     chr1         10102-10190      * |    MACS_peak_2      3.23
##      [3]     chr1         29304-29382      * |    MACS_peak_3      2.44
##      [4]     chr1       132296-132335      * |    MACS_peak_9      3.58
##      [5]     chr1       227521-227560      * |   MACS_peak_11      2.70
##      ...      ...                 ...    ... .            ...       ...
##   [2797]     chr1 248610772-248610811      * | MACS_peak_5442      2.52
##   [2798]     chr1 249104439-249104478      * | MACS_peak_5446      2.02
##   [2799]     chr1 249162600-249162639      * | MACS_peak_5452      3.67
##   [2800]     chr1 249219095-249219134      * | MACS_peak_5455      3.58
##   [2801]     chr1 249230903-249230943      * | MACS_peak_5456      3.50
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

In order to understand better the output of the `mspc`
function, let’s go over the files generated while
running the `mspc` function.
These files are listed by the `filesCreated` object,
returned by the `mspc` function :

* A log file that contains the execution log : this
  file contains the information, debugging messages,
  and exceptions that occurred during the execution.
* Consensus peaks in standard BED and MSPC format.
* One folder per each replicates that contains BED files,
  containing stringent, weak, background, confirmed, discarded,
  true-positive, and false-positive peaks.

Each category of peaks is defined as such :

* **Background** :

Peaks with p-value >= `weakThreshold`.

* **Weak** :

Peaks with `stringencyThreshold` <= p-value < `weakThreshold`.

* **Stringent** :

Peaks with p-value < `stringencyThreshold`.

* **Confirmed** :

Peaks that:

1. are supported by at least `c` peaks from replicates, and
2. their combined stringency (xSquared) satisfies the given
   threshold: xSquared >= the inverse of the right-tailed probability
   of `gamma` and
3. if technical replicate, passed all the tests, and if biological
   replicate, passed at least one test.

* **Discarded** :

Peaks that:

1. does not have minimum required (i.e., `c`) supporting evidence, or
2. their combined stringency (xSquared) does not satisfy the given
   threshold, or
3. if technical replicate, failed a test.

* **TruePositive** :

The confirmed peaks that pass the Benjamini-Hochberg multiple testing
correction at level `alpha`.

* **FalsePositive** :

The confirmed peaks that fail Benjamini-Hochberg multiple testing
correction at level `alpha`.

More information about the files generated by the mspc function
can be found
[here](https://genometric.github.io/MSPC/docs/cli/output).

## 4.4 Scenario 2: Input as Granges objects

In this second scenario, we suppose the samples we want to use
as input data for the `mspc` function are GRanges objects,
loaded in the R environment the user is working on.

To exemplify this scenario, we will import the BED files, included
in the package, as GRanges objects into our R environment.

In order to do so, we need to install and load the two following
Bioconductor packages: `GenomicRanges` and `rtracklayer`.

```
BiocManager::install("GenomicRanges",dependencies = TRUE)
BiocManager::install("rtracklayer",dependencies = TRUE)
```

We load these packages to our R session as follows:

```
library(GenomicRanges)
library(rtracklayer)
```

We now import the two BED files, that are available in the
folder inst/extdata of the package, as GRanges objects.

```
path <- system.file("extdata", package = "rmspc")
input1 <- paste0(path, "/rep1.bed")
input2 <- paste0(path, "/rep2.bed")

GR1 <- rtracklayer::import(con = input1, format = "bed")
GR2 <- rtracklayer::import(con = input2, format = "bed")
```

We have now created 2 GRanges objects : **GR1** and **GR2**.
Here’s what the GR1 object is like:

```
GR1
```

```
## UCSC track 'R Track'
## UCSCData object with 5458 ranges and 2 metadata columns:
##          seqnames              ranges strand |           name     score
##             <Rle>           <IRanges>  <Rle> |    <character> <numeric>
##      [1]     chr1         10000-10039      * |    MACS_peak_1      2.42
##      [2]     chr1         10102-10190      * |    MACS_peak_2      3.23
##      [3]     chr1         29304-29382      * |    MACS_peak_3      2.44
##      [4]     chr1         32601-32680      * |    MACS_peak_4      4.08
##      [5]     chr1         32727-32936      * |    MACS_peak_5     17.50
##      ...      ...                 ...    ... .            ...       ...
##   [5454]     chr1 249185288-249185343      * | MACS_peak_5454      5.05
##   [5455]     chr1 249219095-249219134      * | MACS_peak_5455      3.58
##   [5456]     chr1 249230903-249230943      * | MACS_peak_5456      3.50
##   [5457]     chr1 249231135-249231205      * | MACS_peak_5457      5.00
##   [5458]     chr1 249232876-249233088      * | MACS_peak_5458      7.13
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

We can now combine the GRanges objects, **GR1** and **GR2**,
into a GRanges list.
A Granges list is a list of several GRanges objects. It is
defined as such:

```
GR <- GenomicRanges::GRangesList("GR1" = GR1, "GR2" = GR2)
GR
```

```
## GRangesList object of length 2:
## $GR1
## UCSC track 'R Track'
## UCSCData object with 5458 ranges and 2 metadata columns:
##          seqnames              ranges strand |           name     score
##             <Rle>           <IRanges>  <Rle> |    <character> <numeric>
##      [1]     chr1         10000-10039      * |    MACS_peak_1      2.42
##      [2]     chr1         10102-10190      * |    MACS_peak_2      3.23
##      [3]     chr1         29304-29382      * |    MACS_peak_3      2.44
##      [4]     chr1         32601-32680      * |    MACS_peak_4      4.08
##      [5]     chr1         32727-32936      * |    MACS_peak_5     17.50
##      ...      ...                 ...    ... .            ...       ...
##   [5454]     chr1 249185288-249185343      * | MACS_peak_5454      5.05
##   [5455]     chr1 249219095-249219134      * | MACS_peak_5455      3.58
##   [5456]     chr1 249230903-249230943      * | MACS_peak_5456      3.50
##   [5457]     chr1 249231135-249231205      * | MACS_peak_5457      5.00
##   [5458]     chr1 249232876-249233088      * | MACS_peak_5458      7.13
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $GR2
## UCSC track 'R Track'
## UCSCData object with 4119 ranges and 2 metadata columns:
##          seqnames              ranges strand |           name     score
##             <Rle>           <IRanges>  <Rle> |    <character> <numeric>
##      [1]     chr1          9933-10069      * |    MACS_peak_1      7.99
##      [2]     chr1         11143-11340      * |    MACS_peak_2      5.37
##      [3]     chr1         29363-29488      * |    MACS_peak_3      4.42
##      [4]     chr1         32565-33040      * |    MACS_peak_4     44.33
##      [5]     chr1         34688-34887      * |    MACS_peak_5     10.25
##      ...      ...                 ...    ... .            ...       ...
##   [4115]     chr1 249168024-249168194      * | MACS_peak_4115      8.44
##   [4116]     chr1 249200277-249200407      * | MACS_peak_4116      3.62
##   [4117]     chr1 249208247-249208409      * | MACS_peak_4117      9.33
##   [4118]     chr1 249221136-249221304      * | MACS_peak_4118     11.34
##   [4119]     chr1 249232854-249233102      * | MACS_peak_4119     18.48
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

The GRanges list **GR** created is the input we will give
to the `mspc` function.

When we give a Granges list to the `mspc` function as input,
each GRanges object of the GRanges list is exported as a BED
file into the folder specified by the argument `directoryGRangesInput`.

More information about the `directoryGRangesInput` argument in
the documentation.

We now will call the `mspc` function, as follows:

```
results <- mspc(
    input = GR, replicateType = "Biological",
    stringencyThreshold = 1e-8, weakThreshold = 1e-4,
    gamma =  1e-8, GRanges = TRUE, keep = FALSE,
    multipleIntersections = "Highest",
    c = 2,alpha = 0.05)
```

```
## Export Directory: /tmp/Rtmp0OaHqN_1
##
## .::...Parsing Samples....::.
##    #             Filename    Read peaks# Min p-value Mean p-value    Max p-value
## ---- --------------------    ----------- ----------- ------------    -----------
##  1/2                  gr1          5,458  5.012E-071   1.215E-003     1.000E-002
##  2/2                  gr2          4,119  6.607E-239   1.778E-004     9.550E-003
##
## .::..Analyzing Samples...::.
## [1/4] Initializing
## [2/4] Processing samples
##
  └── 0/6,045   (0.000%) peaks
  └── 2,657/6,045   (43.954%) peaks processed
  └── 6,045/6,045   (100.000%) peaks processed
## [3/4] Performing Multiple testing correction
## [4/4] Creating consensus peaks set
##
## .::....Saving Results....::.
##
## .::..Summary Statistics..::.
##    #             Filename    Read peaks# Background      Weak    Stringent   Confirmed   Discarded   TruePositive    FalsePositive
## ---- --------------------    ----------- ----------  --------    ---------   ---------   ---------   ------------    -------------
##  1/2                  gr1          5,458    51.319%   39.080%       9.601%     27.318%     21.363%        27.318%           0.000%
##  2/2                  gr2          4,119    17.747%   48.216%      34.037%     30.129%     52.124%        30.129%           0.000%
##
## .::.Consensus Peaks Count.::.
## 1,239
##
##
## Elapsed time: 00:00:18.7129643
## All processes successfully finished.
```

The objects returned by the `mspc` function in this example are:

```
results$status
```

```
## [1] 0
```

```
tail(results$GRangesObjects)
```

```
## $`gr2/Confirmed`
## GRanges object with 1241 ranges and 2 metadata columns:
##          seqnames              ranges strand |           name     score
##             <Rle>           <IRanges>  <Rle> |    <character> <numeric>
##      [1]     chr1         32565-33040      * |    MACS_peak_4     44.33
##      [2]     chr1         34688-34887      * |    MACS_peak_5     10.25
##      [3]     chr1         34973-35206      * |    MACS_peak_6      6.89
##      [4]     chr1         38569-38849      * |    MACS_peak_7     15.70
##      [5]     chr1       437581-437800      * |   MACS_peak_19      6.95
##      ...      ...                 ...    ... .            ...       ...
##   [1237]     chr1 248100316-248100550      * | MACS_peak_4103      4.83
##   [1238]     chr1 249152183-249153033      * | MACS_peak_4110     32.29
##   [1239]     chr1 249153179-249153549      * | MACS_peak_4111      5.86
##   [1240]     chr1 249168024-249168194      * | MACS_peak_4115      8.44
##   [1241]     chr1 249232854-249233102      * | MACS_peak_4119     18.48
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $`gr2/Discarded`
## GRanges object with 2147 ranges and 2 metadata columns:
##          seqnames              ranges strand |           name     score
##             <Rle>           <IRanges>  <Rle> |    <character> <numeric>
##      [1]     chr1          9933-10069      * |    MACS_peak_1      7.99
##      [2]     chr1         11143-11340      * |    MACS_peak_2      5.37
##      [3]     chr1         29363-29488      * |    MACS_peak_3      4.42
##      [4]     chr1       132229-132405      * |    MACS_peak_8      7.45
##      [5]     chr1       136294-136419      * |    MACS_peak_9      4.29
##      ...      ...                 ...    ... .            ...       ...
##   [2143]     chr1 249132100-249132234      * | MACS_peak_4108      4.99
##   [2144]     chr1 249132816-249133041      * | MACS_peak_4109      5.08
##   [2145]     chr1 249167198-249167371      * | MACS_peak_4113      9.63
##   [2146]     chr1 249208247-249208409      * | MACS_peak_4117      9.33
##   [2147]     chr1 249221136-249221304      * | MACS_peak_4118     11.34
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $`gr2/FalsePositive`
## GRanges object with 0 ranges and 0 metadata columns:
##    seqnames    ranges strand
##       <Rle> <IRanges>  <Rle>
##   -------
##   seqinfo: no sequences
##
## $`gr2/Stringent`
## GRanges object with 1402 ranges and 2 metadata columns:
##          seqnames              ranges strand |           name     score
##             <Rle>           <IRanges>  <Rle> |    <character> <numeric>
##      [1]     chr1         32565-33040      * |    MACS_peak_4     44.33
##      [2]     chr1         34688-34887      * |    MACS_peak_5     10.25
##      [3]     chr1         38569-38849      * |    MACS_peak_7     15.70
##      [4]     chr1       432555-433057      * |   MACS_peak_18     14.06
##      [5]     chr1       544675-545070      * |   MACS_peak_25     10.93
##      ...      ...                 ...    ... .            ...       ...
##   [1398]     chr1 249167198-249167371      * | MACS_peak_4113      9.63
##   [1399]     chr1 249168024-249168194      * | MACS_peak_4115      8.44
##   [1400]     chr1 249208247-249208409      * | MACS_peak_4117      9.33
##   [1401]     chr1 249221136-249221304      * | MACS_peak_4118     11.34
##   [1402]     chr1 249232854-249233102      * | MACS_peak_4119     18.48
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $`gr2/TruePositive`
## GRanges object with 1241 ranges and 2 metadata columns:
##          seqnames              ranges strand |           name     score
##             <Rle>           <IRanges>  <Rle> |    <character> <numeric>
##      [1]     chr1         32565-33040      * |    MACS_peak_4     44.33
##      [2]     chr1         34688-34887      * |    MACS_peak_5     10.25
##      [3]     chr1         34973-35206      * |    MACS_peak_6      6.89
##      [4]     chr1         38569-38849      * |    MACS_peak_7     15.70
##      [5]     chr1       437581-437800      * |   MACS_peak_19      6.95
##      ...      ...                 ...    ... .            ...       ...
##   [1237]     chr1 248100316-248100550      * | MACS_peak_4103      4.83
##   [1238]     chr1 249152183-249153033      * | MACS_peak_4110     32.29
##   [1239]     chr1 249153179-249153549      * | MACS_peak_4111      5.86
##   [1240]     chr1 249168024-249168194      * | MACS_peak_4115      8.44
##   [1241]     chr1 249232854-249233102      * | MACS_peak_4119     18.48
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $`gr2/Weak`
## GRanges object with 1986 ranges and 2 metadata columns:
##          seqnames              ranges strand |           name     score
##             <Rle>           <IRanges>  <Rle> |    <character> <numeric>
##      [1]     chr1          9933-10069      * |    MACS_peak_1      7.99
##      [2]     chr1         11143-11340      * |    MACS_peak_2      5.37
##      [3]     chr1         29363-29488      * |    MACS_peak_3      4.42
##      [4]     chr1         34973-35206      * |    MACS_peak_6      6.89
##      [5]     chr1       132229-132405      * |    MACS_peak_8      7.45
##      ...      ...                 ...    ... .            ...       ...
##   [1982]     chr1 248100316-248100550      * | MACS_peak_4103      4.83
##   [1983]     chr1 249120099-249120329      * | MACS_peak_4105      4.08
##   [1984]     chr1 249132100-249132234      * | MACS_peak_4108      4.99
##   [1985]     chr1 249132816-249133041      * | MACS_peak_4109      5.08
##   [1986]     chr1 249153179-249153549      * | MACS_peak_4111      5.86
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

# 5 Session Information

The output in this vignette was produced under the following
conditions:

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
## [1] rtracklayer_1.70.0   GenomicRanges_1.62.0 Seqinfo_1.0.0
## [4] IRanges_2.44.0       S4Vectors_0.48.0     BiocGenerics_0.56.0
## [7] generics_0.1.4       rmspc_1.16.0         BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10                 SparseArray_1.10.0
##  [3] bitops_1.0-9                stringi_1.8.7
##  [5] lattice_0.22-7              magrittr_2.0.4
##  [7] digest_0.6.37               grid_4.5.1
##  [9] evaluate_1.0.5              bookdown_0.45
## [11] fastmap_1.2.0               jsonlite_2.0.0
## [13] Matrix_1.7-4                processx_3.8.6
## [15] cigarillo_1.0.0             restfulr_0.0.16
## [17] ps_1.9.1                    BiocManager_1.30.26
## [19] httr_1.4.7                  XML_3.99-0.19
## [21] Biostrings_2.78.0           codetools_0.2-20
## [23] jquerylib_0.1.4             abind_1.4-8
## [25] cli_3.6.5                   rlang_1.1.6
## [27] crayon_1.5.3                XVector_0.50.0
## [29] Biobase_2.70.0              DelayedArray_0.36.0
## [31] cachem_1.1.0                yaml_2.3.10
## [33] S4Arrays_1.10.0             tools_4.5.1
## [35] parallel_4.5.1              BiocParallel_1.44.0
## [37] Rsamtools_2.26.0            SummarizedExperiment_1.40.0
## [39] curl_7.0.0                  vctrs_0.6.5
## [41] R6_2.6.1                    BiocIO_1.20.0
## [43] matrixStats_1.5.0           lifecycle_1.0.4
## [45] stringr_1.5.2               bslib_0.9.0
## [47] glue_1.8.0                  xfun_0.53
## [49] GenomicAlignments_1.46.0    MatrixGenerics_1.22.0
## [51] knitr_1.50                  rjson_0.2.23
## [53] htmltools_0.5.8.1           rmarkdown_2.30
## [55] compiler_4.5.1              RCurl_1.98-1.17
```

# 6 Bibliographic references

Jalili, V., Matteucci, M., Masseroli, M., & Morelli, M. J. (2015).
Using combined evidence from replicates to evaluate ChIP-seq peaks.
Bioinformatics, 31(17), 2761-2769.
[Link to the article](https://doi.org/10.1093/bioinformatics/btv293)