Using PING with Paired-End sequencing data

Xuekui Zhang*, Sangsoon Woo(cid:132), Raphael Gottardo(cid:133)and Renan Sauteraud§

April 24, 2017

This vignette presents a workﬂow to use PING for analyzing paired-end

sequencing data.

Contents

1 Licensing and citing

2 Introduction

3 PING analysis steps

4 Data Input and Formatting

5 PING analysis

5.1 Genome segmentation . . . . . . . . . . . . . . . . . . . . . .
5.2 Parameter estimation . . . . . . . . . . . . . . . . . . . . . .

6 Post-processing PING results

7 Analyzing the prediction

2

2

2

2

3
3
3

4

4

*ubcxzhang@gmail.com
(cid:132)swoo@fhcrc.org
(cid:133)rgottard@fhcrc.org
§rsautera@fhcrc.org

1

1 Licensing and citing

Under the Artistic License 2.0, you are free to use and redistribute this
software.

If you use this package for a publication, we would ask you to cite the

following:

Xuekui Zhang, Gordon Robertson, Sangsoon Woo, Brad G. Hoﬀman,
and Raphael Gottardo. (2012). Probabilistic Inference for Nucleosome
Positioning with MNase-based or Sonicated Short-read Data. PLoS
ONE 7(2): e32095.

2

Introduction

For an introduction to the biological background and PING method, please
refer to the other vignette: ‘The PING user guide’. Because the structure of
paired-end sequencing data requires a slightly diﬀerent treatment , we are
separately presenting how to use PING for these data in this vignette.

3 PING analysis steps

A typical PING analysis consists of the following steps:

1. Extract reads and chromosomes from bam ﬁles into a GRanges object.

2. Segment the genome into candidate regions that have suﬃcient aligned

reads via ‘segmentPING’

3. Estimate nucleosome positions and other parameters with PING

4. Post-process PING predictions to correct certain predictions

As with any R package, you should ﬁrst load it with the following com-

mand:

> library(PING)

4 Data Input and Formatting

As with the Single-End PING, the input used for the segmentation step is a
GRanges object.

2

Because sequencing data often comes in the form of BAM ﬁles, in the
PICS package, we provide a function called bam2gr to convert these ﬁles
into GRanges objects with all the appropriate information. A small BAM
ﬁle including a region of yeast’s chromosome I is provided to be used as an
example in this vignette.

> yeastBam <- system.file("extdata/yeastChrI.bam", package = "PING")

> library(PICS)
> gr <- bam2gr(bamFile = yeastBam, PE = TRUE)

gr is a GRanges object containing all the reads from the .bam ﬁle.

Note that this function will also work for single-end sequencing data and
the argument PE should be set to TRUE when dealing with paired-end data.

5 PING analysis

5.1 Genome segmentation

PING is used the same way for paired-end and single-end sequencing data.
The function segmentPING will decide which segmentation method should be
used based on the arguments provided. When dealing with paired-end data,
four new arguments have to be passed to the function: islandDepth, min_-
cut and max_cut for candidate region selection. These arguments control
the size and required coverage for a region to be considered as a candidate.
In order to run segmentPING, we have to subset our GRanges object to

have a single chromosome

> grI <- gr[seqnames(gr) == "chrI"]
> seqlevels(grI) <- "chrI"

> segPE <- segmentPING(grI, PE = TRUE)

It returns a segReadsListPE object.

5.2 Parameter estimation

Parallelisation will also work with paired-end data.
In what follows, we
assume that parallel is installed on your machine. If it is not, the ﬁrst line
should be omitted and calculations will occur on a single CPU.

> library(parallel)

3

> ping <- PING(segPE, nCores = 2)

The returned object is a pingList, which will go through a post-processing
step using postPING function.

6 Post-processing PING results

> PS = postPING(ping, segPE)

[1] "No regions with pingerror"
[1] "No predictions with atypical delta"
[1] "No predictions with atypical sigma"

The 32 regions with following IDs are reprocessed for Boundary problems:

[1] 18 19 20 38 42 46

The result output of postPING is a dataframe that contains estimated pa-
rameters of each nucleosome.

7 Analyzing the prediction

PING comes with a set of tools to export or visualize the prediction. Here,
we only show how to export the results into bed format for further analysis
and how to make a quick plot to summarize the nucleosome prediction. For
more information on how to export the results or make more complex ﬁgures,
please refer to the section ‘Result output’ of PING vignette.

The function makeRangedDataOutput oﬀers a simple way to convert the
prediction results into a RangedData objec that can be exported into a ﬁle
using the rtracklayer package.

> rdBed <- makeRangedDataOutput(PS, type = "bed")
> library(rtracklayer)
> export(rdBed, "nucPrediction.bed")

The exported ﬁle includes all information about the predicted nucleosomes,
which are already automatically ranked by their score.

For paired-end sequencing data, the bult-in plotting function plotSum-
mary can be used to visualize the predicted nucleosome positions obtained
from postPING function.

4

> plotSummary(PS, ping, grI, chr = "chrI", from = 149000, to = 153000)

All the arguments for this function will work for Paired-end data as
well. Refer to PING vignette and the man page ?plotSummary for more
information.

5

chrI:149000−153000(4000bps)150 kb151 kb152 kb5'3'5'3'0100200300400500XSET01234scorePING