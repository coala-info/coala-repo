# Working with transcripts

Haakon Tjeldnes & Kornel Labun

#### 22 December 2025

#### Package

ORFik 1.30.2

# Contents

* [1 Introduction](#introduction)
  + [1.1 Motivation](#motivation)
* [2 Getting data](#getting-data)
* [3 Loading Transcript region (single point locations)](#loading-transcript-region-single-point-locations)
* [4 Loading Transcript region (window locations)](#loading-transcript-region-window-locations)
* [5 Extending transcript into genomic flanks](#extending-transcript-into-genomic-flanks)
* [6 Coverage over transcript regions](#coverage-over-transcript-regions)
  + [6.1 Loading NGS data](#loading-ngs-data)
  + [6.2 Total counts per region/window](#total-counts-per-regionwindow)
  + [6.3 Per nucleotide in region/window](#per-nucleotide-in-regionwindow)
  + [6.4 Per nucleotide in region/window (split by read length)](#per-nucleotide-in-regionwindow-split-by-read-length)
  + [6.5 Advanced details](#advanced-details)

# 1 Introduction

Welcome to the introduction to working with transcripts in ORFik. This vignette will walk you through how
to find and manipulate the sections of transcript you want. And how to calculate coverage over these regions.
`ORFik` is an R package containing various functions for analysis of RiboSeq, RNASeq, RCP-seq, TCP-seq, Chip-seq and Cage data, we advice you to read Importing data vignette, before starting this one.

## 1.1 Motivation

Working with all the specific regions of transcripts can be hard. The standard Bioconductor
packages GenomicRanges and GenomicFeatures does not solve most of these problems, so
ORFik extends this ecosystem with what we call TranscriptRanges and TranscriptFeatures.
We will here learn how to use ORFik
effectively getting the transcript regions we want and compute coverage over those regions etc.

# 2 Getting data

Let us use the same data we used in the importing data vignette.

```
library(ORFik)
organism <- "Saccharomyces cerevisiae" # Baker's yeast
output_dir <- tempdir(TRUE) # Let's just store it to temp
# If you already downloaded, it will not redownload, but reuse those files.
annotation <- getGenomeAndAnnotation(
                    organism = organism,
                    output.dir = output_dir,
                    assembly_type = "toplevel"
                    )
genome <- annotation["genome"]
gtf <- annotation["gtf"]
txdb_path <- paste0(gtf, ".db")
txdb <- loadTxdb(txdb_path)
```

# 3 Loading Transcript region (single point locations)

Let us get these regions:

* Transcription start sites (TSS, start of leaders)
* Translation start sites (TIS, start of CDSs)
* Translation termination sites (TTS, end of CDSs)
* Transcription end sites (TES, end of mRNA)

```
## TSS
startSites(loadRegion(txdb, "leaders"), asGR = TRUE, is.sorted = TRUE)
```

```
## GRanges object with 6600 ranges and 0 metadata columns:
##          seqnames    ranges strand
##             <Rle> <IRanges>  <Rle>
##      [1]        I       234      +
##      [2]        I       437      +
##      [3]        I      2379      +
##      [4]        I      9990      +
##      [5]        I     11945      +
##      ...      ...       ...    ...
##   [6596]     Mito     65669      +
##   [6597]     Mito     73657      +
##   [6598]     Mito     74394      +
##   [6599]     Mito     79112      +
##   [6600]     Mito     85453      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
```

```
# Equal to:
startSites(loadRegion(txdb, "mrna"), asGR = TRUE, is.sorted = TRUE)
```

```
## GRanges object with 6600 ranges and 0 metadata columns:
##          seqnames    ranges strand
##             <Rle> <IRanges>  <Rle>
##      [1]        I       234      +
##      [2]        I       437      +
##      [3]        I      2379      +
##      [4]        I      9990      +
##      [5]        I     11945      +
##      ...      ...       ...    ...
##   [6596]     Mito     65669      +
##   [6597]     Mito     73657      +
##   [6598]     Mito     74394      +
##   [6599]     Mito     79112      +
##   [6600]     Mito     85453      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
```

```
## TIS
startSites(loadRegion(txdb, "cds"), asGR = TRUE, is.sorted = TRUE)
```

```
## GRanges object with 6600 ranges and 0 metadata columns:
##          seqnames    ranges strand
##             <Rle> <IRanges>  <Rle>
##      [1]        I       335      +
##      [2]        I       538      +
##      [3]        I      2480      +
##      [4]        I     10091      +
##      [5]        I     12046      +
##      ...      ...       ...    ...
##   [6596]     Mito     65770      +
##   [6597]     Mito     73758      +
##   [6598]     Mito     74495      +
##   [6599]     Mito     79213      +
##   [6600]     Mito     85554      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
```

```
## TTS
stopSites(loadRegion(txdb, "cds"), asGR = TRUE, is.sorted = TRUE)
```

```
## GRanges object with 6600 ranges and 0 metadata columns:
##          seqnames    ranges strand
##             <Rle> <IRanges>  <Rle>
##      [1]        I       649      +
##      [2]        I       792      +
##      [3]        I      2707      +
##      [4]        I     10399      +
##      [5]        I     12426      +
##      ...      ...       ...    ...
##   [6596]     Mito     66174      +
##   [6597]     Mito     74513      +
##   [6598]     Mito     75984      +
##   [6599]     Mito     80022      +
##   [6600]     Mito     85709      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
```

```
## TES
stopSites(loadRegion(txdb, "mrna"), asGR = TRUE, is.sorted = TRUE)
```

```
## GRanges object with 6600 ranges and 0 metadata columns:
##          seqnames    ranges strand
##             <Rle> <IRanges>  <Rle>
##      [1]        I       649      +
##      [2]        I       792      +
##      [3]        I      2707      +
##      [4]        I     10399      +
##      [5]        I     12426      +
##      ...      ...       ...    ...
##   [6596]     Mito     66174      +
##   [6597]     Mito     74513      +
##   [6598]     Mito     75984      +
##   [6599]     Mito     80022      +
##   [6600]     Mito     85709      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
```

# 4 Loading Transcript region (window locations)

What if we want a window around that region point?
Then we also need might the mrna region information,
to map to transcript coordinates and get area around that point

```
mrna <- loadRegion(txdb, "mrna")
## TSS
startRegion(loadRegion(txdb, "mrna"), upstream = 30, downstream = 30, is.sorted = TRUE)
```

```
## GRangesList object of length 6600:
## $YAL069W_mRNA
## GRanges object with 1 range and 0 metadata columns:
##                seqnames    ranges strand
##                   <Rle> <IRanges>  <Rle>
##   YAL069W_mRNA        I   234-264      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## $`YAL068W-A_mRNA`
## GRanges object with 1 range and 0 metadata columns:
##                  seqnames    ranges strand
##                     <Rle> <IRanges>  <Rle>
##   YAL068W-A_mRNA        I   437-467      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## $`YAL067W-A_mRNA`
## GRanges object with 1 range and 0 metadata columns:
##                  seqnames    ranges strand
##                     <Rle> <IRanges>  <Rle>
##   YAL067W-A_mRNA        I 2379-2409      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## ...
## <6597 more elements>
```

```
## TIS
startRegion(loadRegion(txdb, "cds"), mrna, upstream = 30, downstream = 30, is.sorted = TRUE)
```

```
## GRangesList object of length 6600:
## $YAL069W_mRNA
## GRanges object with 1 range and 0 metadata columns:
##                seqnames    ranges strand
##                   <Rle> <IRanges>  <Rle>
##   YAL069W_mRNA        I   305-365      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## $`YAL068W-A_mRNA`
## GRanges object with 1 range and 0 metadata columns:
##                  seqnames    ranges strand
##                     <Rle> <IRanges>  <Rle>
##   YAL068W-A_mRNA        I   508-568      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## $`YAL067W-A_mRNA`
## GRanges object with 1 range and 0 metadata columns:
##                  seqnames    ranges strand
##                     <Rle> <IRanges>  <Rle>
##   YAL067W-A_mRNA        I 2450-2510      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## ...
## <6597 more elements>
```

```
## TTS
stopRegion(loadRegion(txdb, "cds"), mrna, upstream = 30, downstream = 30, is.sorted = TRUE)
```

```
## GRangesList object of length 6600:
## $YAL069W_mRNA
## GRanges object with 1 range and 0 metadata columns:
##                seqnames    ranges strand
##                   <Rle> <IRanges>  <Rle>
##   YAL069W_mRNA        I   619-649      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## $`YAL068W-A_mRNA`
## GRanges object with 1 range and 0 metadata columns:
##                  seqnames    ranges strand
##                     <Rle> <IRanges>  <Rle>
##   YAL068W-A_mRNA        I   762-792      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## $`YAL067W-A_mRNA`
## GRanges object with 1 range and 0 metadata columns:
##                  seqnames    ranges strand
##                     <Rle> <IRanges>  <Rle>
##   YAL067W-A_mRNA        I 2677-2707      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## ...
## <6597 more elements>
```

```
## TES
stopRegion(loadRegion(txdb, "mrna"), upstream = 30, downstream = 30, is.sorted = TRUE)
```

```
## GRangesList object of length 6600:
## $YAL069W_mRNA
## GRanges object with 1 range and 0 metadata columns:
##                seqnames    ranges strand
##                   <Rle> <IRanges>  <Rle>
##   YAL069W_mRNA        I   619-649      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## $`YAL068W-A_mRNA`
## GRanges object with 1 range and 0 metadata columns:
##                  seqnames    ranges strand
##                     <Rle> <IRanges>  <Rle>
##   YAL068W-A_mRNA        I   762-792      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## $`YAL067W-A_mRNA`
## GRanges object with 1 range and 0 metadata columns:
##                  seqnames    ranges strand
##                     <Rle> <IRanges>  <Rle>
##   YAL067W-A_mRNA        I 2677-2707      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## ...
## <6597 more elements>
```

# 5 Extending transcript into genomic flanks

You might notice that since we are doing transcript coordinates, it will not actually extend 30 upstream
from TSS, because there is no transcript there.

To extend into the genomic region do:

```
# TSS genomic extension
extendLeaders(startRegion(mrna[1], upstream = -1, downstream = 30, is.sorted = TRUE), 30)
```

```
## GRangesList object of length 1:
## $YAL069W_mRNA
## GRanges object with 1 range and 0 metadata columns:
##                seqnames    ranges strand
##                   <Rle> <IRanges>  <Rle>
##   YAL069W_mRNA        I   205-264      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
```

```
# TES genomic extension
extendTrailers(stopRegion(mrna[1], upstream = 30, downstream = 0, is.sorted = TRUE), 30)
```

```
## GRangesList object of length 1:
## $YAL069W_mRNA
## GRanges object with 1 range and 0 metadata columns:
##                seqnames    ranges strand
##                   <Rle> <IRanges>  <Rle>
##   YAL069W_mRNA        I   619-679      +
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
```

# 6 Coverage over transcript regions

So how could we now get the coverage per nt in the TIS region of a cds?

## 6.1 Loading NGS data

We first need some NGS data with matching annotation, so let us now use the ORFik experiment included in the package:

```
df <- ORFik.template.experiment()
df
```

```
## ORFik experiment: ORFik (Tjeldnes et al.)
## Libraries:  4 library types and 16 runs
## Organism: Homo sapiens
##     libtype rep condition
##  1:    CAGE   1    Mutant
##  2:    CAGE   2    Mutant
##  3:    CAGE   1        WT
##  4:    CAGE   2        WT
##  5:     PAS   1    Mutant
##  6:     PAS   2    Mutant
##  7:     PAS   1        WT
##  8:     PAS   2        WT
##  9:     RFP   1    Mutant
## 10:     RFP   2    Mutant
## 11:     RFP   1        WT
## 12:     RFP   2        WT
## 13:     RNA   1    Mutant
## 14:     RNA   2    Mutant
## 15:     RNA   1        WT
## 16:     RNA   2        WT
```

There are 4 CAGE libraries, 4 PAS (Poly-A seq) libraries, 4 Ribo-seq libraries and
4 RNA-seq libraries.
Let’s load the first Ribo-seq library in this artificial study

```
df <- df[9,]
df
```

```
## ORFik experiment: ORFik (Tjeldnes et al.)
## Libraries:  1 library type and 1 runs
## Organism: Homo sapiens
##    libtype
## 1:     RFP
```

Load the Ribo-seq

```
ribo <- fimport(filepath(df, "default"))
```

Some NGS statistics, first Read length distribution

```
table(readWidths(ribo))
```

```
##
##   27   28   29
## 1001  961  984
```

Then RFP peak count distribution

```
summary(score(ribo))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##    1.00    4.00   15.00   49.68   57.75  775.00
```

Total number of unique (collapsed) and original (non collapsed reads):

```
paste("Number of collapsed:", length(ribo),
      "Number of non-collapsed:", sum(score(ribo)))
```

```
## [1] "Number of collapsed: 2946 Number of non-collapsed: 146368"
```

```
paste("duplication rate:", round(1 - length(ribo)/sum(score(ribo)), 2) * 100, "%")
```

```
## [1] "duplication rate: 98 %"
```

## 6.2 Total counts per region/window

```
TIS_window <- startRegion(loadRegion(df, "cds"), loadRegion(df, "mrna"),
                is.sorted = TRUE, upstream = 20, downstream = 20)
```

Now let’s get the total counts per window, we will do it in two identical ways.
The second version uses the automatic 5’ end anchoring to create an identical output.

```
countOverlapsW(TIS_window, ribo, weight = "score") # score is the number of pshifted RFP peaks at respective position
```

```
## ENSTTEST10001 ENSTTEST10002 ENSTTEST10003 ENSTTEST10004 ENSTTEST10005
##          1416          1818          1571          1662          1300
## ENSTTEST10006
##          1537
```

```
# This is shorter version (You do not need TIS_window defined first) ->
startRegionCoverage(loadRegion(df, "cds"), ribo, loadRegion(df, "mrna"),
                    is.sorted = TRUE, upstream = 20, downstream = 20)
```

```
## ENSTTEST10001 ENSTTEST10002 ENSTTEST10003 ENSTTEST10004 ENSTTEST10005
##            33            36            37            39            36
## ENSTTEST10006
##            38
```

You see the first gene had 33 reads in the 20-20 window around TIS

## 6.3 Per nucleotide in region/window

A per nucleotide coverage is in Bioconductor called a ‘tiling’,
if you want the coverage per nucleotide in that predefined window?

```
# TIS region coverage
coveragePerTiling(TIS_window, ribo)[1:3]
```

```
## RleList of length 3
## $ENSTTEST10001
## numeric-Rle of length 41 with 39 runs
##   Lengths:   1   1   1   1   3   1   1   1 ...   1   1   1   1   1   1   1   1
##   Values :   0  15   3   7   0   9   2   7 ...  68   7 120  20   0 155  86   9
##
## $ENSTTEST10002
## numeric-Rle of length 41 with 38 runs
##   Lengths:   1   1   1   1   1   1   1   1 ...   1   1   1   1   1   1   1   1
##   Values :   0  24   3   1  15   8   1   8 ... 190 255  31  64  10  11  46 285
##
## $ENSTTEST10003
## numeric-Rle of length 41 with 40 runs
##   Lengths:   1   1   1   1   1   1   1   1 ...   1   1   1   1   1   1   1   1
##   Values :   2   9   4   5   1   0   1  21 ...   0  80 130  14  11 185 194  17
```

For plotting it is best to use the data.table return:

```
# TIS region coverage
dt <- coveragePerTiling(TIS_window, ribo, as.data.table = TRUE)
head(dt)
```

```
##    count genes position
##    <num> <int>    <int>
## 1:     0     1        1
## 2:    15     1        2
## 3:     3     1        3
## 4:     7     1        4
## 5:     0     1        5
## 6:     0     1        6
```

Let’s plot the coverage for fun, now we want frame information too:

```
# TIS region coverage
dt <- coveragePerTiling(TIS_window, ribo, as.data.table = TRUE, withFrames = TRUE)
# Rescale 0 to position 21
dt[, position := position - 21]
pSitePlot(dt)
```

![](data:image/png;base64...)

## 6.4 Per nucleotide in region/window (split by read length)

To get coverage of a window per read length, we can anchor on a specific location,
namely the 5’ end of CDSs (i.e. TISs) in this case.

```
# Define transcript with valid UTRs and lengths
txNames <- filterTranscripts(df, 25, 25,0, longestPerGene = TRUE)
# TIS region coverage
dt <- windowPerReadLength(loadRegion(df, "cds", txNames), loadRegion(df, "mrna", txNames), ribo)
# Remember to set scoring to scoring used above for dt
coverageHeatMap(dt, scoring = "transcriptNormalized")
```

![](data:image/png;base64...)

To get coverage of a full region per read length
(coverage of full transcript per read length), we do:

```
dt <- regionPerReadLength(loadRegion(df, "cds", txNames)[1], ribo,
                          exclude.zero.cov.grl = FALSE, drop.zero.dt = FALSE)
# Remember to set scoring to scoring used above for dt
coverageHeatMap(dt, scoring = NULL)
```

![](data:image/png;base64...)
You see the arguments exclude.zero.cov.grl and drop.zero.dt are set to false,
default is true, which leads to considerable speed ups for large datasets, by reducing number
of 0 positions that are kept in the final object.

## 6.5 Advanced details

Most coverage calculations in ORFik in some way relies on the GenomicRanges::coverage
function, to understand how it all works and how to speed it up, look up the two functions:

* ORFik:::coverageByTranscriptW (Must convert to coverage)
* ORFik:::coverageByTranscriptC (Uses precomputed RLE coverage tracks, much faster)

The remaining logic is usually pure R loops, as very little computation is done in R code anyway.
The output relies on data.table package for efficient computation on results and easy plotting.