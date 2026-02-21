# Introduction to the bamsignals package

Alessandro Mammana and Johannes Helmuth

#### 2025-10-29

# Contents

* [1 Introduction to the bamsignals package](#introduction-to-the-bamsignals-package)
  + [1.1 Loading toy data](#loading-toy-data)
  + [1.2 Counting reads in given ranges with `bamCount()`](#counting-reads-in-given-ranges-with-bamcount)
    - [1.2.1 Basic counting](#basic-counting)
    - [1.2.2 Accounting for fragment length](#accounting-for-fragment-length)
    - [1.2.3 Counting on each strand separately](#counting-on-each-strand-separately)
  + [1.3 Read profiles for each region with `bamProfile()`](#read-profiles-for-each-region-with-bamprofile)
    - [1.3.1 Counting on each strand separately](#counting-on-each-strand-separately-1)
    - [1.3.2 Regions of the same width](#regions-of-the-same-width)
    - [1.3.3 Binning counts](#binning-counts)
  + [1.4 Read coverage with `bamCoverage()`](#read-coverage-with-bamcoverage)
* [2 Advanced bamsignals filtering options](#advanced-bamsignals-filtering-options)
  + [2.1 Exclude ambiguous reads with the `mapq` argument](#exclude-ambiguous-reads-with-the-mapq-argument)
  + [2.2 Filter reads with the `filteredFlag` argument](#filter-reads-with-the-filteredflag-argument)
* [3 Paired End Data](#paired-end-data)
  + [3.1 Paired end data handling with the `paired.end` argument](#paired-end-data-handling-with-the-paired.end-argument)
  + [3.2 Filtering fragments with the `tlenFilter` argument](#filtering-fragments-with-the-tlenfilter-argument)

# 1 Introduction to the bamsignals package

The goal of the `bamsignals` package is to load count data from bam files as
easily and quickly as possible. A typical workflow without the `bamsignals`
package requires to firstly load all reads in R (*e.g.* using the `Rsamtools`
package), secondly process them and lastly convert them into counts. The
`bamsignals` package optimizes this workflow by merging these steps into one
using efficient C code, which makes the whole process easier and faster.
Additionally, `bamsignals` comes with native support for paired end data.

## 1.1 Loading toy data

We will use the following libraries (which are all required for installing
`bamsignals`).

```
library(GenomicRanges)
library(Rsamtools)
library(bamsignals)
```

In the following we will use a sorted and indexed bam file and a gene
annotation.

```
bampath <- system.file("extdata", "randomBam.bam", package="bamsignals")
genes <-
  get(load(system.file("extdata", "randomAnnot.Rdata", package="bamsignals")))
genes
```

```
## GRanges object with 20 ranges and 0 metadata columns:
##        seqnames    ranges strand
##           <Rle> <IRanges>  <Rle>
##    [1]     chr1  871-1475      +
##    [2]     chr3  534-1132      -
##    [3]     chr2  551-1153      +
##    [4]     chr2   341-917      +
##    [5]     chr3   308-900      +
##    ...      ...       ...    ...
##   [16]     chr3  778-1377      +
##   [17]     chr3   388-968      -
##   [18]     chr2  676-1295      +
##   [19]     chr3  511-1103      -
##   [20]     chr3   269-875      -
##   -------
##   seqinfo: 3 sequences from an unspecified genome; no seqlengths
```

The chromosome names in the bam file and those in the `GenomicRanges` object
need to match. Additionally, the bam file needs to be sorted and indexed. Note
that `bamsignals` requires the bam index to be named like bam file with “.bai”
suffix.

```
#sequence names of the GenomicRanges object
seqinfo(genes)
```

```
## Seqinfo object with 3 sequences from an unspecified genome; no seqlengths:
##   seqnames seqlengths isCircular genome
##   chr1             NA         NA   <NA>
##   chr3             NA         NA   <NA>
##   chr2             NA         NA   <NA>
```

```
#sequence names in the bam file
bf <- Rsamtools::BamFile(bampath)
seqinfo(bf)
```

```
## Seqinfo object with 3 sequences from an unspecified genome:
##   seqnames seqlengths isCircular genome
##   chr1          10237         NA   <NA>
##   chr2          10279         NA   <NA>
##   chr3          10238         NA   <NA>
```

```
#checking if there is an index
file.exists(gsub(".bam$", ".bam.bai", bampath))
```

```
## [1] TRUE
```

## 1.2 Counting reads in given ranges with `bamCount()`

### 1.2.1 Basic counting

Let’s count how many reads map to the promoter regions of our genes. Using the
`bamCount()` function, this is straightforward.

```
proms <- GenomicRanges::promoters(genes, upstream=100, downstream=100)
counts <- bamCount(bampath, proms, verbose=FALSE)
str(counts)
```

```
##  int [1:20] 806 883 727 766 667 576 587 793 710 758 ...
```

The object `counts` is a vector of the same length as the number of ranges that
we are analyzing, the `i`-th count corresponds to the `i`-th range.

### 1.2.2 Accounting for fragment length

With the `bamCount()` function a read is counted in a range if the 5’ end of the
read falls in that range. This might be appropriate when analyzing DNase I
hypersensitivity tags, however for ChIP-seq data the immunoprecipitated protein
is normally located downstream with respect to the 5’ end of the sequenced
reads. To correct for that, it is possible to count reads with a strand-specific
shift, *i.e.* reads will be counted in a range if the shifted 5’ end falls in
that range. Note that this shift will move reads mapped to the positive strand
to the right and reads mapped to the negative strand to the left with respect to
the reference orientation. The shift should correspond approximately to half of
the average length of the fragments in the sequencing experiment.

```
counts <- bamCount(bampath, proms, verbose=FALSE, shift=75)
str(counts)
```

```
##  int [1:20] 703 826 697 759 645 478 471 877 560 713 ...
```

### 1.2.3 Counting on each strand separately

Sometimes it is necessary to consider the two genomic strands separately. This
is achieved with the `ss` option (separate strands, or strand-specific), and
depends also on the strand of the `GenomicRanges` object.

```
strand(proms)
```

```
## factor-Rle of length 20 with 12 runs
##   Lengths: 1 1 3 1 2 2 2 3 1 1 1 2
##   Values : + - + - + - + - + - + -
## Levels(3): + - *
```

```
counts <- bamCount(bampath, proms, verbose=FALSE, ss=TRUE)
str(counts)
```

```
##  int [1:2, 1:20] 556 250 535 348 336 391 444 322 393 274 ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : chr [1:2] "sense" "antisense"
##   ..$ : NULL
```

Now `counts` is a matrix with two rows, one for the sense strand, the other for
the antisense strand. Note that the sense of a read is decided also by the
region it falls into, so if both the region and the read are on the same strand
the read is counted as a sense read, otherwise as an antisense read.

## 1.3 Read profiles for each region with `bamProfile()`

If you are interested in counting how many reads map to each base pair of your
genes, the `bamProfile()` function might save you a day.

```
sigs <- bamProfile(bampath, genes, verbose=FALSE)
sigs
```

```
## CountSignals object with 20 signals
## [1] signal of width 605
## 8 4 3 6 2 2 3 3 4 3 ...
## [2] signal of width 599
## 4 4 7 8 6 6 3 7 2 3 ...
## [3] signal of width 603
## 5 4 4 5 6 2 6 8 2 1 ...
## [4] signal of width 577
## 1 4 3 2 4 1 2 2 4 1 ...
## [5] signal of width 593
## 6 3 3 2 4 1 6 1 3 1 ...
## ....
```

The `CountSignals` class is a read-only container for count vectors.
Conceptually it is like a `list` of vectors, and in fact it can be immediately
converted to that format.

```
#CountSignals is conceptually like a list
lsigs <- as.list(sigs)
stopifnot(length(lsigs[[1]])==length(sigs[1]))
#sapply and lapply can be used as if we were using a list
stopifnot(all(sapply(sigs, sum) == sapply(lsigs, sum)))
```

Similarly as for the `bamCount` function, the `CountSignals` object has as many
elements (called `signals`) as there are ranges, and the `i`-th signal
corresponds to the `i`-th range.

```
stopifnot(all(width(sigs)==width(genes)))
```

### 1.3.1 Counting on each strand separately

As for the `bamCount()` function, also with `bamProfile()` the reads can be
counted for each strand separately

```
sssigs <- bamProfile(bampath, genes, verbose=FALSE, ss=TRUE)
sssigs
```

```
## CountSignals object with 20 strand-specific signals
## [1] signal of width 605
## sense      7 3 2 6 1 2 2 2 4 3 ...
## antisense  1 1 1 0 1 0 1 1 0 0 ...
## [2] signal of width 599
## sense      3 2 6 7 6 5 3 6 1 0 ...
## antisense  1 2 1 1 0 1 0 1 1 3 ...
## [3] signal of width 603
## sense      1 2 2 2 2 1 3 5 1 0 ...
## antisense  4 2 2 3 4 1 3 3 1 1 ...
## [4] signal of width 577
## sense      1 2 1 1 2 1 1 1 3 1 ...
## antisense  0 2 2 1 2 0 1 1 1 0 ...
## [5] signal of width 593
## sense      4 1 1 0 3 1 3 1 2 1 ...
## antisense  2 2 2 2 1 0 3 0 1 0 ...
## ....
```

Now each signal is a matrix with two rows.

```
str(sssigs[1])
```

```
##  int [1:2, 1:605] 7 1 3 1 2 1 6 0 1 1 ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : chr [1:2] "sense" "antisense"
##   ..$ : NULL
```

```
#summing up the counts from the two strands is the same as using ss=FALSE
stopifnot(colSums(sssigs[1])==sigs[1])
#the width function takes into account that now the signals are strand-specific
stopifnot(width(sssigs)==width(sigs))
#the length function does not, a strand-specific signal is twice as long
stopifnot(length(sssigs[1])==2*length(sigs[1]))
```

Let’s summarize this with a plot

```
xlab <- "offset from start of the region"
ylab <- "counts per base pair (negative means antisense)"
main <- paste0("read profile of the region ",
  seqnames(genes)[1], ":", start(genes)[1], "-", end(genes)[1])
plot(sigs[1], ylim=c(-max(sigs[1]), max(sigs[1])), ylab=ylab, xlab=xlab,
  main=main, type="l")
lines(sssigs[1]["sense",], col="blue")
lines(-sssigs[1]["antisense",], col="red")
legend("bottom", c("sense", "antisense", "both"),
  col=c("blue", "red", "black"), lty=1)
```

![](data:image/png;base64...)

### 1.3.2 Regions of the same width

In case our ranges have all the same width, a `CountSignals` object can be
immediately converted into a matrix, or an array, with the `alignSignals`
function

```
#The promoter regions have all the same width
sigs <- bamProfile(bampath, proms, ss=FALSE, verbose=FALSE)
sssigs <- bamProfile(bampath, proms, ss=TRUE, verbose=FALSE)

sigsMat <- alignSignals(sigs)
sigsArr <- alignSignals(sssigs)
```

The last dimension of the resulting array (or matrix) represents the different
ranges, the second-last one represents the base pairs in each region, and in the
strand-specific case, the first-one represents the strand of the signal. This
can be changed by using the `t()` function (for matrices) or `aperm()` (for
arrays).

```
#the dimensions are [base pair, region]
str(sigsMat)
```

```
##  int [1:200, 1:20] 2 2 3 6 2 2 1 2 4 2 ...
```

```
#the dimensions are [strand, base pair, region]
str(sigsArr)
```

```
##  int [1:2, 1:200, 1:20] 1 1 0 2 2 1 3 3 0 2 ...
##  - attr(*, "dimnames")=List of 3
##   ..$ : chr [1:2] "sense" "antisense"
##   ..$ : NULL
##   ..$ : NULL
```

```
stopifnot(all(sigsMat == sigsArr["sense",,] + sigsArr["antisense",,]))
```

Computing the average read profile at promoters in `proms` is now
straightforward

```
avgSig <- rowMeans(sigsMat)
avgSenseSig <- rowMeans(sigsArr["sense",,])
avgAntisenseSig <- rowMeans(sigsArr["antisense",,])
ylab <- "average counts per base pair"
xlab <- "distance from TSS"
main <- paste0("average profile of ", length(proms), " promoters")
xs <- -99:100
plot(xs, avgSig, ylim=c(0, max(avgSig)), xlab=xlab, ylab=ylab, main=main,
  type="l")
lines(xs, avgSenseSig, col="blue")
lines(xs, avgAntisenseSig, col="red")
legend("bottom", c("sense", "antisense", "both"),
  col=c("blue", "red", "black"), lty=1)
```

![](data:image/png;base64...)

### 1.3.3 Binning counts

Very often it is better to count reads mapping to small regions instead of
single base pairs. Bins are small non-overlapping regions of fixed size tiling a
larger region. Instead of splitting your regions of interest into bins, it is
easier and much more efficient to provide the `binsize` option to
`bamProfile()`.

```
binsize <- 20
binnedSigs <- bamProfile(bampath, proms, binsize=binsize, verbose=FALSE)
stopifnot(all(width(binnedSigs)==ceiling(width(sigs)/binsize)))
binnedSigs
```

```
## CountSignals object with 20 signals
## [1] signal of width 10
## 42 49 68 71 93 79 100 90 115 99
## [2] signal of width 10
## 85 73 79 75 93 96 75 75 110 122
## [3] signal of width 10
## 79 71 70 59 71 89 81 77 70 60
## [4] signal of width 10
## 64 72 84 72 61 64 86 87 92 84
## [5] signal of width 10
## 45 55 52 63 63 61 75 75 82 96
## ....
```

In case the ranges’ widths are not multiples of the bin size, a warning will be
issued and the last bin in those ranges will be smaller than the others (where
“last” depends on the orientation of the region).

Binning means considering a `signal` at a lower resolution.

```
avgBinnedSig <- rowMeans(alignSignals(binnedSigs))
#the counts in the bin are the sum of the counts in each base pair
stopifnot(all.equal(colSums(matrix(avgSig, nrow=binsize)),avgBinnedSig))
#let's plot it
ylab <- "average counts per base pair"
plot(xs, avgSig, xlab=xlab, ylab=ylab, main=main, type="l")
lines(xs, rep(avgBinnedSig, each=binsize)/binsize, lty=2)
legend("topright", c("base pair count", "bin count"), lty=c(1, 2))
```

![](data:image/png;base64...)

## 1.4 Read coverage with `bamCoverage()`

Instead of counting the 5’ end of each read, you may want to count how many
reads overlap each base pair, you should check out the `bamCoverage()` function
which gives you a smooth read coverage profile by considering the whole read
length and not just the 5’ end:

```
covSigs <- bamCoverage(bampath, genes, verbose=FALSE)
puSigs <- bamProfile(bampath, genes, verbose=FALSE)
xlab <- "offset from start of the region"
ylab <- "reads per base pair"
main <- paste0("read coverage and profile of the region ", seqnames(genes)[1],
  ":", start(genes)[1], "-", end(genes)[1])
plot(covSigs[1], ylim=c(0, max(covSigs[1])), ylab=ylab, xlab=xlab, main=main,
  type="l")
lines(puSigs[1], lty=2)
legend("topright", c("covering the base pair", "5' end maps to the base pair"),
  lty=c(1,2))
```

![](data:image/png;base64...)

# 2 Advanced bamsignals filtering options

## 2.1 Exclude ambiguous reads with the `mapq` argument

Most mapping software (*e.g.* bwa, bowtie2) stores information about mapping
confidence in the **MAPQ** field of a bam file. In general, it is recommended to
exclude reads with bad mapping quality because their mapping location is
ambiguous. In bowtie2, a mapping quality of 20 or less indicates that there is
at least a 1 in 20 chance that the read truly originated elsewhere. In that
case, the `mapq` argument is a lower bound on **MAPQ**:

```
counts.all <- bamCount(bampath, proms, verbose=FALSE)
summary(counts.all)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   576.0   669.2   769.0   775.3   836.5  1073.0
```

```
counts.mapq <- bamCount(bampath, proms, mapq=20, verbose=FALSE)
summary(counts.mapq)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   281.0   344.8   379.0   388.2   429.0   558.0
```

## 2.2 Filter reads with the `filteredFlag` argument

Analogously to the **MAPQ** field, every bam contains a **SAMFLAG** field where
the mapping software or the post-processing software (*e.g.* picard)
stores information on the read. See [Decoding SAM
flags](https://broadinstitute.github.io/picard/explain-flags.html) for
explanation. For instance, a **SAMFLAG** of 1024 indicates a optical
duplicate. We would like to *filter out* optical duplicate reads with
`filteredFlag=1024` from the read counts with **MAPQ** >= 19 to get a higher
confidence on the results:

```
counts.mapq.noDups <- bamCount(bampath, proms, mapq=20, filteredFlag=1024, verbose=FALSE)
summary(counts.mapq.noDups)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   271.0   328.0   350.5   366.4   402.0   521.0
```

# 3 Paired End Data

## 3.1 Paired end data handling with the `paired.end` argument

All `bamsignals` methods (`bamCount()`, `bamProfile()` and `bamCoverage()`)
discussed above support dealing with paired end sequencing data. Considering
only one read avoids counting both reads in read pair which may bias downstream
analysis. The argument `paired.end` can be set to `ignore` (treat like single
end), `filter` (consider 5’-end of first read in a properly aligned pair, *i.e.*
**SAMFLAG**=66) or `midpoint` (consider the midpoint of an aligned fragment).
Please note, that the strand of the first read in a pair defines the strand of
fragment.

```
#5' end falls into regions defined in `proms`
counts.pe.filter <- bamCount(bampath, proms, paired.end="filter", verbose=FALSE)
summary(counts.pe.filter)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   280.0   333.8   388.5   385.8   415.2   521.0
```

```
#fragment midpoint falls into regions defined in `proms`
counts.pe.midpoint <- bamCount(bampath, proms, paired.end="midpoint", verbose=FALSE)
summary(counts.pe.midpoint)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   231.0   331.5   360.0   376.4   412.2   608.0
```

```
#counts are similar but not identical
cor(counts.pe.filter, counts.pe.midpoint)
```

```
## [1] 0.9336458
```

For `bamCoverage()`, `paired.end=="midpoint"` is not defined. However,
`paired.end=="extend"` computes “how many fragments cover each base pair” (as
opposed to “how many reads cover each base pair” in the single end case). This
is done by utilizing the actual length of a fragment is stored in the **TLEN**
field of the paired end bam file. The result is a very smooth coverage plot:

```
covSigs <- bamCoverage(bampath, genes, paired.end="extend", verbose=FALSE)
puSigs <- bamProfile(bampath, genes, paired.end="midpoint", verbose=FALSE)
xlab <- "offset from start of the region"
ylab <- "reads per base pair"
main <- paste0("Paired end whole fragment coverage and fragment midpoint profile\n",
  "of the region ", seqnames(genes)[1], ":", start(genes)[1], "-",
  end(genes)[1])
plot(covSigs[1], ylim=c(0, max(covSigs[1])), ylab=ylab, xlab=xlab, main=main,
  type="l")
lines(puSigs[1], lty=2)
legend("topright", c("covering the base pair", "fragment midpoint maps to the base pair"),
  lty=c(1,2))
```

![](data:image/png;base64...)

## 3.2 Filtering fragments with the `tlenFilter` argument

In paired end data, the actual fragment length can be inferred from the distance
between two read mates. This information is then stored in the **TLEN** field of
a bam file. One might need to filter for fragments within a certain “allowed”
size, *e.g.* mono-nucleosomal fragments in ChIP-seq.

```
counts.monoNucl <- bamCount(bampath, genes, paired.end="midpoint", tlenFilter=c(120,170), verbose=FALSE)
summary(counts.monoNucl)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   402.0   416.0   469.5   463.8   513.5   535.0
```

```
#Coverage of mononucleosomal fragments
covSigs.monoNucl <- bamCoverage(bampath, genes, paired.end="extend", tlenFilter=c(120,170), verbose=FALSE)
xlab <- "offset from start of the region"
ylab <- "reads per base pair"
main <- paste0("Paired end whole fragment coverage for\n",
  "of the region ", seqnames(genes)[1], ":", start(genes)[1], "-",
  end(genes)[1])
plot(covSigs[1], ylim=c(0, max(covSigs[1])), ylab=ylab, xlab=xlab, main=main,
  type="l")
lines(covSigs.monoNucl[1], lty=3)
legend("topright", c("all fragment sizes", "mononucleosomal fragments only"),
  lty=c(1,3))
```

![](data:image/png;base64...)

There are many more use cases for `tlenFilter`, *e.g.* count only long range
reads in ChIA-PET or HiC data or profile only very small fragments in
ChIP-exo/nexus data.