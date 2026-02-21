# CopyNumberPlots: create copy-number specific plots using karyoploteR

Bernat Gel (bgel@igtp.cat); Miriam Magallon (mmagallon@igtp.cat)

#### 29 October 2025

#### Package

CopyNumberPlots 1.26.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Quick Start](#quick-start)
* [4 Loading Copy-Number Data](#loading-copy-number-data)
  + [4.1 Load Raw Data](#load-raw-data)
  + [4.2 Load Copy-Number Calls](#load-copy-number-calls)
* [5 Plotting Copy-Number Data](#plotting-copy-number-data)
  + [5.1 Plotting Raw Data](#plotting-raw-data)
  + [5.2 plotBAF](#plotbaf)
  + [5.3 Plot LRR](#plot-lrr)
  + [5.4 Plot Copy-Number Calls](#plot-copy-number-calls)
    - [5.4.1 plotCopyNumberCalls](#plotcopynumbercalls)
    - [5.4.2 plotCopyNumberCallsAsLines](#plotcopynumbercallsaslines)
    - [5.4.3 plotCopyNumberSummary](#plotcopynumbersummary)
* [6 Session Info](#session-info)

# 1 Introduction

Data visualisation is a powerful tool used for data analysis and exploration in
many fields. Genomics data analysis is one of these fields where good
visualisation tools can be of great help.
The aim of *[CopyNumberPlots](https://bioconductor.org/packages/3.22/CopyNumberPlots)* is to offer the user an
easy way to create copy-number related plots using the infrastructure provided
by the R package *[karyoploteR](https://bioconductor.org/packages/3.22/karyoploteR)*.

In addition to a set of specialized plotting functions for copy-number analysis
data and results (`plotBAF`, `plotCopyNumberCalls`, …),
*[CopyNumberPlots](https://bioconductor.org/packages/3.22/CopyNumberPlots)* contains a number of data loading
functions to help parsing and loading the results of widely used
copy-number calling software such as *[DNAcopy](https://bioconductor.org/packages/3.22/DNAcopy)*,
[DECoN](https://wellcomeopenresearch.org/articles/1-20/v1) or
[CNVkit](https://cnvkit.readthedocs.io/en/stable/).

Finally, since *[CopyNumberPlots](https://bioconductor.org/packages/3.22/CopyNumberPlots)* extends the
functionality of *[karyoploteR](https://bioconductor.org/packages/3.22/karyoploteR)*, it is possible
to combine the plotting functions of both packages to get the perfect
figure for your data.

# 2 Installation

*[CopyNumberPlots](https://bioconductor.org/packages/3.22/CopyNumberPlots)* is a
[Bioconductor](http://bioconductor.org) package and to install it we have
to use *[BiocManager](https://bioconductor.org/packages/3.22/BiocManager)*.

```
  if (!requireNamespace("BiocManager", quietly = TRUE))
      install.packages("BiocManager")
  BiocManager::install("CopyNumberPlots")
```

We can also install the package from github to get the latest devel version,
but beware that it might be incompatible with the release version of
Bioconductor!

```
  BiocManager::install("bernatgel/CopyNumberPlots")
```

# 3 Quick Start

To start working with *[CopyNumberPlots](https://bioconductor.org/packages/3.22/CopyNumberPlots)* we will need
to use the `plotKaryoptype` function from *[karyoploteR](https://bioconductor.org/packages/3.22/karyoploteR)*.
If you want more information on how to customize it, use for other organisms
or genome version, etc… you can take a look at the
[karyoploteR tutorial](https://bernatgel.github.io/karyoploter_tutorial/) and
specifically at the section on
[how to plot ideograms](https://bernatgel.github.io/karyoploter_tutorial//Tutorial/CreateIdeogram/CreateIdeogram.html).

For this quick start example we’ll plot SNP-array data simulating a cancer
genome. The data is in a file included with the package. You can use almost
any table-like file format, including the Final Report file you would get from
Illumina’s Genome Studio. In this case, to keep the example small, we have
data only for chomosome 1.

To load the data we’ll use `loadSNPData` which will detect the right columns,
read the data and build a GRanges object for us.

If data uses Ensembl-style chromosome names (1,2,3,…,X,Y) instead of
default karyoploteR UCSC chromosome names (chr1,chr2,chr3,…,chrX,chrY)
we could change the chromosome style to UCSC with the function `UCSCStyle`.

```
  library(CopyNumberPlots)
```

```
## Loading required package: karyoploteR
```

```
## Loading required package: regioneR
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
  s1.file <- system.file("extdata", "S1.rawdata.txt", package = "CopyNumberPlots", mustWork = TRUE)
  s1 <- loadSNPData(s1.file)
```

```
## Reading data from /tmp/Rtmp3Hzmm3/Rinst3d50dd7fa8a804/CopyNumberPlots/extdata/S1.rawdata.txt
```

```
## The column identified as Chromosome is: chr
```

```
## The column identified as Start is: start
```

```
## The column identified as End is: end
```

```
## The column identified as B-Allele Frequency is: baf
```

```
## The column identified as Log Ratio is: lrr
```

```
  s1
```

```
## GRanges object with 965 ranges and 2 metadata columns:
##       seqnames    ranges strand |       lrr       baf
##          <Rle> <IRanges>  <Rle> | <numeric> <numeric>
##   253     chr1    480818      * | -0.949246         1
##   678     chr1    595283      * | -0.882367         0
##   643     chr1    632319      * | -0.769292         1
##    41     chr1   1036550      * | -1.128100         1
##    88     chr1   1115414      * | -0.842099         0
##   ...      ...       ...    ... .       ...       ...
##   575     chr1 248120086      * |  0.714653  0.751899
##   510     chr1 248245181      * |  0.446138  0.312570
##   654     chr1 248488745      * |  0.794984  0.000000
##   171     chr1 248630472      * |  0.758302  1.000000
##   938     chr1 248704671      * |  0.994605  0.227549
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Once we have our data loaded we can start plotting. We’ll start by creating
a karyoplot using `plotKaryotype`. If we were plotting more than one
chromosome, we could use `plot.type=4` to get all chromosomes in a single line
one next to the other. You can get more information on the available plot types
at
[the karyoploteR tutorial](https://bernatgel.github.io/karyoploter_tutorial//Tutorial/PlotTypes/PlotTypes.html).

```
  kp <- plotKaryotype(chromosomes="chr1")
```

![](data:image/png;base64...)

And once we have a karyoplot we can start adding out data. We can plot the
B-allele frequency using `plotBAF`

```
  kp <- plotKaryotype(chromosomes="chr1")
  plotBAF(kp, s1)
```

![](data:image/png;base64...)

We can plot LRR using `plotLRR`

```
  kp <- plotKaryotype(chromosomes="chr1")
  plotLRR(kp, s1)
```

![](data:image/png;base64...)

And we can see in this plot that points with a LRR below -4 (and above 2) are
plotted in red at -4 (and at 2) so we don’t lose them.

We can also use the
[data positioning](https://bernatgel.github.io/karyoploter_tutorial//Tutorial/DataPositioning/DataPositioning.html) parameters `r0` and `r1` to add more than one data type
on the same plot.

```
  kp <- plotKaryotype(chromosomes="chr1")
  plotBAF(kp, s1, r0=0.55, r1=1)
  plotLRR(kp, s1, r0=0, r1=0.45)
```

![](data:image/png;base64...)

Finally, we can load a copy number calling made on this data and plot it.
To load the copy number calls in this file we can use the function
`loadCopyNumberCalls` that will read the data, identify the correct columns and
create a GRanges object for us.

```
  s1.calls.file <- system.file("extdata", "S1.segments.txt", package = "CopyNumberPlots", mustWork = TRUE)
  s1.calls <- loadCopyNumberCalls(s1.calls.file)
```

```
## Reading data from /tmp/Rtmp3Hzmm3/Rinst3d50dd7fa8a804/CopyNumberPlots/extdata/S1.segments.txt
```

```
## The column identified as Copy Number is: cn
```

```
## The column identified as LOH is: loh
```

```
  s1.calls
```

```
## GRanges object with 13 ranges and 2 metadata columns:
##      seqnames              ranges strand |        cn       loh
##         <Rle>           <IRanges>  <Rle> | <integer> <integer>
##    1     chr1          1-60000000      * |         1         1
##    2     chr1   60000001-60000999      * |         2         0
##    3     chr1   60001000-62990000      * |         0         1
##    4     chr1   62990001-62999999      * |         2         0
##    5     chr1  63000000-121500000      * |         1         1
##   ..      ...                 ...    ... .       ...       ...
##    9     chr1 189600352-220352872      * |         3         0
##   10     chr1 220352873-220352971      * |         2         0
##   11     chr1 220352972-234920000      * |         5         0
##   12     chr1 234920001-234999999      * |         2         0
##   13     chr1 235000000-249250621      * |         3         0
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

And then use `plotCopyNumberCalls` to add them to the previous plot.

```
  kp <- plotKaryotype(chromosomes="chr1")
  plotBAF(kp, s1, r0=0.6, r1=1)
  plotLRR(kp, s1, r0=0.15, r1=0.55)
```

![](data:image/png;base64...)

```
  #plotCopyNumberCalls(kp, s1.calls, r0=0, r1=0.10)
```

With that the main functionality of *[CopyNumberPlots](https://bioconductor.org/packages/3.22/CopyNumberPlots)*
is covered. It is important to take into account that since we are extending
the functionality of *[karyoploteR](https://bioconductor.org/packages/3.22/karyoploteR)*, we can use all
karyoploteR functions to add more data and other data types into these plots.

In the following pages you will find more information on how to load
data to use with *[CopyNumberPlots](https://bioconductor.org/packages/3.22/CopyNumberPlots)*, how to create other
plot types and how to customize them.

# 4 Loading Copy-Number Data

The plotting functions in *[CopyNumberPlots](https://bioconductor.org/packages/3.22/CopyNumberPlots)* expect
data to be in a `GRanges` with a few columns with specific names:

* **baf** for B-allele frequency data (or similar) (real value between 0 and 1)
* **lrr** for log-ratio intensity data (or similar) (real value)
* **cn** for integer copy-number data (integer value)
* **loh** for loss of heterozygosity (logical value)
* **segment.value** for values representing the copy-number called segment but
  not necessarily the integer copy-number calls (real value)

You can create these structures yourself, but
*[CopyNumberPlots](https://bioconductor.org/packages/3.22/CopyNumberPlots)* has functions to help in loading
both raw data (mainly SNP-array and aCGH data) and copy-number calls.

## 4.1 Load Raw Data

The main function to load raw data is `loadSNPData`. It will take either
a file or an R object (`data.frame` or similar) and will load it, detect
the columns with the needed information (chromosome, position, log-ratio,
B-allele frequency) based on the column names and build a `GRanges` object
ready to use by the plotting functions.

```
  raw.data.file <- system.file("extdata", "snp.data_test.csv", package = "CopyNumberPlots", mustWork=TRUE)
  snps <- loadSNPData(raw.data.file)
```

```
## Reading data from /tmp/Rtmp3Hzmm3/Rinst3d50dd7fa8a804/CopyNumberPlots/extdata/snp.data_test.csv
```

```
## The column identified as Chromosome is: Chr
```

```
## The column identified as Position is: Position
```

```
## The column identified as B-Allele Frequency is: B.Allele.Freq
```

```
## The column identified as Log Ratio is: Log.R.Ratio
```

```
## The column identified as Identifier is: SNP.Name
```

```
  snps
```

```
## GRanges object with 6 ranges and 11 metadata columns:
##     seqnames    ranges strand |   Sample.ID          id SNP.Index         SNP
##        <Rle> <IRanges>  <Rle> | <character> <character> <integer> <character>
##   1        X  68757767      * |        S001   rs7060463         1       [A/G]
##   2        9  86682315      * |        S001   rs1898321         2       [T/C]
##   3       11  92711948      * |        S001 kgp12808645         3       [A/G]
##   4       12  55233823      * |        S001   rs7299872         4       [A/G]
##   5        2 147722211      * |        S001   rs2176056         5       [A/G]
##   6       19  32605173      * |        S001  rs17597441         6       [T/C]
##     Plus.Minus.Strand Allele1...Plus Allele2...Plus  GC.Score  GT.Score
##           <character>    <character>    <character> <numeric> <numeric>
##   1                 -              C              C    0.9244    0.8872
##   2                 +              T              C    0.9643    0.9367
##   3                 -              T              T    0.8770    0.8885
##   4                 +              A              G    0.8852    0.8508
##   5                 +              G              G    0.9499    0.9167
##   6                 -              G              G    0.8025    0.8332
##           baf       lrr
##     <numeric> <numeric>
##   1    1.0000   -0.3530
##   2    0.5004    0.0740
##   3    0.0054   -0.0537
##   4    0.5088   -0.2337
##   5    1.0000    0.0886
##   6    0.9986    0.0779
##   -------
##   seqinfo: 6 sequences from an unspecified genome; no seqlengths
```

When run, the function will tell us the columns it identified and will proceed
load the data. To identify the columns it will internally use a set of
regular expressions that work in most cases including on the ‘Final Report’
files created by Illumina’s Genome Studio. If for any reason the automatic
identification of the columns failed, it is possible to specify the exact column
names using the appropiate parameters (`chr.col`, `start.col`, `end.col`…).

## 4.2 Load Copy-Number Calls

Another set of functions included in the package are functions to load
the results of copy-number calling algorithms, the copy number calls per se.
In this case we also have a generic function, `loadCopyNumberCalls`, and a
few functions specialized in specific copy-number calling packages.

Again, the generic function can work with a file or an R object with a
table-like structure and will try to discover the right columns itself. It will
return a GRanges with the copy-number called segments and the optional columns
`cn` for integer copy-number values, `loh` for loss-of-heterozigosity regions and
`segment.value` for values computed for the segments (for example, mean value
of the probes in the segment).

As an example we will generate a “random” calling

```
  cn.data <- toGRanges(c("chr14:66459785-86459774", "chr17:68663111-88866308",
                         "chr10:43426998-83426994", "chr3:88892741-120892733",
                         "chr2:12464318-52464316", "chrX:7665575-27665562"))

  cn.data$CopyNumberInteger <- sample(c(0,1,3,4), size = 6, replace = TRUE)
  cn.data$LossHetero <- cn.data$CopyNumberInteger<2

  cn.data
```

```
## GRanges object with 6 ranges and 2 metadata columns:
##     seqnames             ranges strand | CopyNumberInteger LossHetero
##        <Rle>          <IRanges>  <Rle> |         <numeric>  <logical>
##   1    chr14  66459785-86459774      * |                 3      FALSE
##   2    chr17  68663111-88866308      * |                 1       TRUE
##   3    chr10  43426998-83426994      * |                 4      FALSE
##   4     chr3 88892741-120892733      * |                 1       TRUE
##   5     chr2  12464318-52464316      * |                 1       TRUE
##   6     chrX   7665575-27665562      * |                 4      FALSE
##   -------
##   seqinfo: 6 sequences from an unspecified genome; no seqlengths
```

and load it

```
  cn.calls <- loadCopyNumberCalls(cn.data)
```

```
## The column identified as Copy Number is: CopyNumberInteger
```

```
## The column identified as LOH is: LossHetero
```

```
  cn.calls
```

```
## GRanges object with 6 ranges and 2 metadata columns:
##     seqnames             ranges strand |        cn       loh
##        <Rle>          <IRanges>  <Rle> | <numeric> <logical>
##   1    chr14  66459785-86459774      * |         3     FALSE
##   2    chr17  68663111-88866308      * |         1      TRUE
##   3    chr10  43426998-83426994      * |         4     FALSE
##   4     chr3 88892741-120892733      * |         1      TRUE
##   5     chr2  12464318-52464316      * |         1      TRUE
##   6     chrX   7665575-27665562      * |         4     FALSE
##   -------
##   seqinfo: 6 sequences from an unspecified genome; no seqlengths
```

we can see how the columns for cn and loh were correctly identified.

To plot this objet we can call, for example `plotCopyNumberCalls`.

```
  kp <- plotKaryotype(plot.type = 1)
```

![](data:image/png;base64...)

```
  #plotCopyNumberCalls(kp, cn.calls = cn.calls)
```

There are other specialized functions that will load either the R object
produced by copy-number calling R packages or the files produced by
either R or external copy-number calling software.

Currently there are specilized functions to load the data produced by:

* ASCAT
* DECoN
* DNAcopy
* pennCNV
* cnmops
* panel.cnmops
* CNVkit

# 5 Plotting Copy-Number Data

Once we have data loaded (or directly created by us) we can plot it.

There are two functions to plot raw data (`plotBAF` and `plotLRR`) and three
functions to plot the copy-number calls (`plotCopyNumberCalls`,
`plotCopyNumberCallsAsLines` and `plotCopyNumberSummary`).

## 5.1 Plotting Raw Data

To demonstrate the raw-data plotting functions we’ll use two example
files included with the package

```
  s1.file <- system.file("extdata", "S1.rawdata.txt", package = "CopyNumberPlots", mustWork = TRUE)
  s1 <- loadSNPData(s1.file)
```

```
## Reading data from /tmp/Rtmp3Hzmm3/Rinst3d50dd7fa8a804/CopyNumberPlots/extdata/S1.rawdata.txt
```

```
## The column identified as Chromosome is: chr
```

```
## The column identified as Start is: start
```

```
## The column identified as End is: end
```

```
## The column identified as B-Allele Frequency is: baf
```

```
## The column identified as Log Ratio is: lrr
```

```
  head(s1)
```

```
## GRanges object with 6 ranges and 2 metadata columns:
##       seqnames    ranges strand |       lrr       baf
##          <Rle> <IRanges>  <Rle> | <numeric> <numeric>
##   253     chr1    480818      * | -0.949246 1.0000000
##   678     chr1    595283      * | -0.882367 0.0000000
##   643     chr1    632319      * | -0.769292 1.0000000
##    41     chr1   1036550      * | -1.128100 1.0000000
##    88     chr1   1115414      * | -0.842099 0.0000000
##   116     chr1   1559575      * | -1.346852 0.0141703
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
  s2.file <- system.file("extdata", "S2.rawdata.txt", package = "CopyNumberPlots", mustWork = TRUE)
  s2 <- loadSNPData(s2.file)
```

```
## Reading data from /tmp/Rtmp3Hzmm3/Rinst3d50dd7fa8a804/CopyNumberPlots/extdata/S2.rawdata.txt
```

```
## The column identified as Chromosome is: chr
```

```
## The column identified as Start is: start
```

```
## The column identified as End is: end
```

```
## The column identified as B-Allele Frequency is: baf
```

```
## The column identified as Log Ratio is: lrr
```

```
  head(s2)
```

```
## GRanges object with 6 ranges and 2 metadata columns:
##       seqnames    ranges strand |        lrr       baf
##          <Rle> <IRanges>  <Rle> |  <numeric> <numeric>
##   458     chr1    326751      * |  0.1076864 0.0000000
##   382     chr1    466084      * |  0.0898970 0.0562677
##   177     chr1    523654      * | -0.1805354 0.4927062
##   282     chr1    785305      * |  0.0373102 0.4035268
##   799     chr1    787101      * |  0.1487428 1.0000000
##   315     chr1    899495      * | -0.1578661 1.0000000
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## 5.2 plotBAF

To plot the B-Allele frequency (BAF) we’ll use `plotBAF`. We’ll start creating
a karyoplot using
[karyoploteR’s plotKaryotype](https://bernatgel.github.io/karyoploter_tutorial//Tutorial/CreateIdeogram/CreateIdeogram.html) and then add the BAF values into it.

```
  kp <- plotKaryotype(chromosomes="chr1")
  plotBAF(kp, snps=s1)
```

![](data:image/png;base64...)

We can change a number of parameters to alter the appearance of the plot.
We can activate and deactivate the axis and label, we can change the color, size
and glyph (shape) of the points, we can [use r0 and r1 alter the vertical
position of the data](https://bernatgel.github.io/karyoploter_tutorial//Tutorial/DataPositioning/DataPositioning.html) and in general we can use any of the standard base R
plotting parameters.

```
  kp <- plotKaryotype(chromosomes="chr1")
  plotBAF(kp, snps=s1, r0=0, r1=0.2, labels = "BAF1", points.col = "orange",
          points.cex = 2, points.pch = 4, axis.cex = 0.3)
  plotBAF(kp, snps=s1, r0=0.3, r1=0.5, labels = "BAF2", points.col = "red",
          points.cex = 0.5, points.pch = 8, axis.cex = 0.7)
  plotBAF(kp, snps=s1, r0=0.6, r1=1, labels = "BAF3",
          points.col = "#FF552222", points.cex = 1.8, points.pch = 16,
          axis.cex = 0.7)
```

![](data:image/png;base64...)

If we want to plot more than one sample, if we have the data in a list of
GRanges or in a GRanges list, `plotBAF` will take care of it and plot the
different samples one below the other. It will also use the names of the list
as labels to identify the different samples.

```
  samples <- list("Sample1"=s1, "Sample2"=s2)
  kp <- plotKaryotype(chromosomes="chr1")
  plotBAF(kp, snps=samples)
```

![](data:image/png;base64...)

## 5.3 Plot LRR

The function `plotLRR` is equivalent to the `plotBAF` function but will plot the
data in the “lrr” column.

```
  kp <- plotKaryotype(chromosomes="chr1")
  kpAddBaseNumbers(kp)
  plotLRR(kp, snps=s1)
```

![](data:image/png;base64...)

`plotLRR` has a few specific parameters. Since the range of the data points
is not limited to [0,1] as in BAF, you can define the `ymin` and `ymax` values
and any point falling out of the [ymin, ymax] range will be plotted in red
within this range.

This can help us identify out-of-range data, such as the
deletion arround 50Mb in the plot above or the gained region at ~220Mb.

Changing the values of `ymin` and `ymax` we can see a bit different picture

```
  kp <- plotKaryotype(chromosomes="chr1")
  kpAddBaseNumbers(kp)
  plotLRR(kp, snps=s1,  ymin=-1.5, ymax=1.5)
```

![](data:image/png;base64...)

In this case we see many more points out-of-range. We can change the appearance
of this points, changing their color, for example, of we can change how they are
represented, using a density plot instead of raw points.

```
  kp <- plotKaryotype(chromosomes="chr1")
  kpAddBaseNumbers(kp)
  plotLRR(kp, snps=s1,  ymin=-1.5, ymax=1.5, out.of.range = "density")
```

![](data:image/png;base64...)

In this case, due to the very few points in the example, the default parameters
for the density plot are not optimal. We can increase the window size to compute
the density using larger windows. For example, we can set the window to 1
megabase.

```
  kp <- plotKaryotype(chromosomes="chr1")
  plotLRR(kp, snps=s1,  ymin=-1.5, ymax=1.5, out.of.range = "density", density.window = 1e6)
```

![](data:image/png;base64...)

And we can see the peaks corresponding to the accumulation of out-of-range
points.

Finally, we can control the presence and color of the horizontal line marking
the 0 with the "line.at.0.\*" parameters.

We can also use the standard customization options with `plotLRR`.

```
  kp <- plotKaryotype(chromosomes="chr1")
  plotLRR(kp, snps=s1, r0=0, r1=0.2, labels = "LRR1", points.col = "orange",
          points.cex = 2, points.pch = 4, axis.cex = 0.3)
  plotLRR(kp, snps=s1, r0=0.3, r1=0.5, labels = "LRR2", points.col = "red",
          points.cex = 0.5, points.pch = 8, axis.cex = 0.7, ymin=-1.5, ymax=1.5,
          out.of.range.col = "gold", out.of.range = "density",
          density.window = 10e6, density.height = 0.3)
  plotLRR(kp, snps=s1, r0=0.6, r1=1, labels = "LRR3",
          points.col = "#FF552222", points.cex = 1.8, points.pch = 16,
          axis.cex = 0.7)
```

![](data:image/png;base64...)

## 5.4 Plot Copy-Number Calls

The final data type we can plot with *[CopyNumberPlots](https://bioconductor.org/packages/3.22/CopyNumberPlots)*
are copy number calls, that is, the results from copy-number calling algorithms.
To plot that we need a GRanges object with a at least one column of:
\* “cn” for integer copy number calls
\* “segment.value” for non-integer segment regional values
\* “loh” a logical for loss-of-heterozygosity

As an example we’ll use the data generated by ASCAT in a cancer cell line.

```
  s1.calls.file <- system.file("extdata", "S1.segments.txt", package = "CopyNumberPlots", mustWork = TRUE)
  s1.calls <- loadCopyNumberCalls(s1.calls.file)
```

```
## Reading data from /tmp/Rtmp3Hzmm3/Rinst3d50dd7fa8a804/CopyNumberPlots/extdata/S1.segments.txt
```

```
## The column identified as Copy Number is: cn
```

```
## The column identified as LOH is: loh
```

```
  s2.calls <- loadCopyNumberCalls(system.file("extdata", "S2.segments.txt", package = "CopyNumberPlots", mustWork = TRUE))
```

```
## Reading data from /tmp/Rtmp3Hzmm3/Rinst3d50dd7fa8a804/CopyNumberPlots/extdata/S2.segments.txt
```

```
## The column identified as Copy Number is: cn
```

```
## The column identified as LOH is: loh
```

```
  s3.calls <- loadCopyNumberCalls(system.file("extdata", "S3.segments.txt", package = "CopyNumberPlots", mustWork = TRUE))
```

```
## Reading data from /tmp/Rtmp3Hzmm3/Rinst3d50dd7fa8a804/CopyNumberPlots/extdata/S3.segments.txt
```

```
## The column identified as Copy Number is: cn
```

```
## The column identified as LOH is: loh
```

```
  s1.calls
```

```
## GRanges object with 13 ranges and 2 metadata columns:
##      seqnames              ranges strand |        cn       loh
##         <Rle>           <IRanges>  <Rle> | <integer> <integer>
##    1     chr1          1-60000000      * |         1         1
##    2     chr1   60000001-60000999      * |         2         0
##    3     chr1   60001000-62990000      * |         0         1
##    4     chr1   62990001-62999999      * |         2         0
##    5     chr1  63000000-121500000      * |         1         1
##   ..      ...                 ...    ... .       ...       ...
##    9     chr1 189600352-220352872      * |         3         0
##   10     chr1 220352873-220352971      * |         2         0
##   11     chr1 220352972-234920000      * |         5         0
##   12     chr1 234920001-234999999      * |         2         0
##   13     chr1 235000000-249250621      * |         3         0
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

### 5.4.1 plotCopyNumberCalls

The first function to plot the copy-number calls is `plotCopyNumberCalls`,
which will plot them as colored rectangles over the genome. It will create
2 lines of rectangles: the top one with copy-number values and the bottom one
with loss-of-heterozygosity in blue.

```
  kp <- plotKaryotype(chromosomes = "chr1")
```

![](data:image/png;base64...)

```
  #plotCopyNumberCalls(kp, s1.calls)
```

By default we’ll see losses in green, 2n regions in gray and gains in
yellow-orange-red. And the LOH regions as a blue line below the CN data.
We can change the colors used with `cn.colors`. This parameter will take
any value accepted by `getCopyNumberColors`, including the predefined
palletes. You can find them all in the documentation of `getCopyNumberColors`.
This fuction can also help us creating a legend.

```
  kp <- plotKaryotype(chromosomes="chr1")
  #plotCopyNumberCalls(kp, s1.calls, cn.colors = "red_blue", loh.color = "orange", r1=0.8)
  cn.cols <- getCopyNumberColors(colors = "red_blue")
  legend("top", legend=names(cn.cols), fill = cn.cols, ncol=length(cn.cols))
```

![](data:image/png;base64...)

As with the other plotting functions, giving it a list of GRanges will plot
them all.

```
  cn.calls <- list("Sample1"=s1.calls, "Sample2"=s2.calls, "Sample3"=s3.calls)
  kp <- plotKaryotype(chromosomes="chr1")
```

![](data:image/png;base64...)

```
  #plotCopyNumberCalls(kp, cn.calls, r1=0.3)
```

### 5.4.2 plotCopyNumberCallsAsLines

Another option is to plot the copy-number calls as lines using the function
`plotCopyNumberCallsAsLines`. We’ll show a single chromosome in this case.

```
  kp <- plotKaryotype(chr="chr1")
```

![](data:image/png;base64...)

```
  #plotCopyNumberCallsAsLines(kp, s1.calls)
```

In this case we can change the standard customization options and make it use
segments instead of lines using the additional parameter `style`.

```
  kp <- plotKaryotype(chr="chr1")
```

![](data:image/png;base64...)

```
  #plotCopyNumberCallsAsLines(kp, s1.calls, style = "segments")
```

### 5.4.3 plotCopyNumberSummary

Finally, to plot a view of the accumulation of copy number alterations we can
use `plotCopyNumberSummary`. It will create a coverage plot of gains and losses
over all samples in our dataset.

```
  cn.cols <- getCopyNumberColors(colors = "green_orange_red")
  kp <- plotKaryotype(chromosomes="chr1")
  kpDataBackground(kp, color = cn.cols["2"], r0=0.3)
```

![](data:image/png;base64...)

```
  #plotCopyNumberCalls(kp, cn.calls, loh.height = 0, r0=0.3)
  #plotCopyNumberSummary(kp, cn.calls, r1=0.25)
```

And we can change the appearance of the summary using the `direction` parameter.

```
  cn.cols <- getCopyNumberColors(colors = "green_orange_red")
  kp <- plotKaryotype(chromosomes="chr1")
  kpDataBackground(kp, color = cn.cols["2"], r0=0.3)
```

![](data:image/png;base64...)

```
  #plotCopyNumberCalls(kp, cn.calls, loh.height = 0, r0=0.3)
  #plotCopyNumberSummary(kp, cn.calls, r1=0.25, direction = "out")
```

# 6 Session Info

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
##  [1] CopyNumberPlots_1.26.0 karyoploteR_1.36.0     regioneR_1.42.0
##  [4] GenomicRanges_1.62.0   Seqinfo_1.0.0          IRanges_2.44.0
##  [7] S4Vectors_0.48.0       BiocGenerics_0.56.0    generics_0.1.4
## [10] knitr_1.50             BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   bitops_1.0-9
##   [3] gridExtra_2.3               rlang_1.1.6
##   [5] magrittr_2.0.4              biovizBase_1.58.0
##   [7] matrixStats_1.5.0           compiler_4.5.1
##   [9] RSQLite_2.4.3               GenomicFeatures_1.62.0
##  [11] png_0.1-8                   vctrs_0.6.5
##  [13] ProtGenerics_1.42.0         stringr_1.5.2
##  [15] pkgconfig_2.0.3             crayon_1.5.3
##  [17] fastmap_1.2.0               magick_2.9.0
##  [19] backports_1.5.0             XVector_0.50.0
##  [21] Rsamtools_2.26.0            rmarkdown_2.30
##  [23] UCSC.utils_1.6.0            tinytex_0.57
##  [25] bit_4.6.0                   xfun_0.53
##  [27] cn.mops_1.56.0              cachem_1.1.0
##  [29] cigarillo_1.0.0             GenomeInfoDb_1.46.0
##  [31] jsonlite_2.0.0              blob_1.2.4
##  [33] rhdf5filters_1.22.0         DelayedArray_0.36.0
##  [35] Rhdf5lib_1.32.0             BiocParallel_1.44.0
##  [37] parallel_4.5.1              cluster_2.1.8.1
##  [39] R6_2.6.1                    VariantAnnotation_1.56.0
##  [41] bslib_0.9.0                 stringi_1.8.7
##  [43] RColorBrewer_1.1-3          bezier_1.1.2
##  [45] rtracklayer_1.70.0          rpart_4.1.24
##  [47] jquerylib_0.1.4             Rcpp_1.1.0
##  [49] bookdown_0.45               SummarizedExperiment_1.40.0
##  [51] base64enc_0.1-3             Matrix_1.7-4
##  [53] nnet_7.3-20                 tidyselect_1.2.1
##  [55] rstudioapi_0.17.1           dichromat_2.0-0.1
##  [57] abind_1.4-8                 yaml_2.3.10
##  [59] codetools_0.2-20            curl_7.0.0
##  [61] lattice_0.22-7              tibble_3.3.0
##  [63] Biobase_2.70.0              KEGGREST_1.50.0
##  [65] S7_0.2.0                    evaluate_1.0.5
##  [67] foreign_0.8-90              Biostrings_2.78.0
##  [69] pillar_1.11.1               BiocManager_1.30.26
##  [71] MatrixGenerics_1.22.0       checkmate_2.3.3
##  [73] RCurl_1.98-1.17             ensembldb_2.34.0
##  [75] ggplot2_4.0.0               scales_1.4.0
##  [77] glue_1.8.0                  lazyeval_0.2.2
##  [79] Hmisc_5.2-4                 tools_4.5.1
##  [81] BiocIO_1.20.0               data.table_1.17.8
##  [83] BSgenome_1.78.0             GenomicAlignments_1.46.0
##  [85] XML_3.99-0.19               rhdf5_2.54.0
##  [87] grid_4.5.1                  AnnotationDbi_1.72.0
##  [89] colorspace_2.1-2            htmlTable_2.4.3
##  [91] restfulr_0.0.16             Formula_1.2-5
##  [93] cli_3.6.5                   S4Arrays_1.10.0
##  [95] dplyr_1.1.4                 AnnotationFilter_1.34.0
##  [97] gtable_0.3.6                sass_0.4.10
##  [99] digest_0.6.37               SparseArray_1.10.0
## [101] rjson_0.2.23                htmlwidgets_1.6.4
## [103] farver_2.1.2                memoise_2.0.1
## [105] htmltools_0.5.8.1           lifecycle_1.0.4
## [107] httr_1.4.7                  bit64_4.6.0-1
## [109] bamsignals_1.42.0
```