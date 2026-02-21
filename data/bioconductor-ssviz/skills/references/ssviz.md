ssviz: A small RNA-seq visualizer and analysis toolkit

Diana HP Low

Institute of Molecular and Cell Biology
Agency for Science, Technology and Research (A*STAR), Singapore
dlow@imcb.a-star.edu.sg

October 30, 2025

Contents

1 Introduction

1.1 A typical small RNA sequencing analysis

. . . . . . . . . . . . . . . . . . . . . . . . . .

2 Installing and loading the ssviz package

3 Using ssviz

3.1 Loading the ssviz package . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Reading bam files . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3 Read counts in small RNA sequencing . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4 Plotting bam properties . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.5 Plotting region density . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.6 piRNA ping-pong analysis . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . .
3.7 Computing nucleotide frequency (composition)

4 Further work

References

1

Introduction

1
1

2

3
3
3
4
4
6
6
7

7

8

Small RNA sequencing enables the discovery and profiling of microRNAs, piRNAs and other non-
coding RNA for any organism, even without prior genome annotation. The ssviz package is intended
firstly as a visual aid, and secondly to provide more specialized analysis catering for either miRNA or
piRNA analysis.

1.1 A typical small RNA sequencing analysis

To understand the workings and conventions of this package, Figure 1 outlines a typical workflow for
a small RNA sequencing run. Here it is assumed that the data is produced on the Illumina platform,
either GAIIx or HiSeq 2000.

First, pre-processing on the raw reads is done with tools like fastx-toolkit. Small RNA reads are
typically shorter than the high-throughput sequencing length, so there is a need for adapter trimming
and removal of adapter contaminants. Also, as reads are often repeated, it is thus favourable to
collapse identical sequences into a single read (but keeping note of the total number of reads). Based

1

on fastx-toolkit, collapsed read names are in the form of readname-readcount. This point is crucial
as ssviz will take into account this naming convention in plots and computations.

After pre-processing, reads are then mapped to list of contaminants (snoRNA, snRNA, tRNA, etc)
and then either to the genome and small RNA databases (eg. miRBank, RepBase, piRNABank) or
both. Once mapped, tools like ssviz can be used to analyze the resulting data.

Figure 1: A typical small RNA sequencing workflow

2

Installing and loading the ssviz package

We recommend that users install the package via Bioconductor, since this will automatically de-
tect and install all required dependencies. The Bioconductor installation procedure is described at
http://www.bioconductor.org/docs/install/. To install ssviz, launch a new R session, and in a com-
mand terminal either type or copy/paste:

if (!requireNamespace("BiocManager", quietly=TRUE))

install.packages("BiocManager")

BiocManager::install("ssviz")

2

3 Using ssviz

3.1 Loading the ssviz package

To load the ssviz package in the R environment, simply type:-

library(ssviz)

The ssviz package also includes all the data generated in this vignette for easy reference. Data can

be loaded by typing:

data(ssviz)

3.2 Reading bam files

ssviz analyzes bam files that have been mapped either to a genome or to small RNA seq annotations.
Bam files can be loaded into the workspace using readBam. The package comes with two example
datasets (control and treatment). readBam is a wrapper for the scanBam function and writes the
bam file contents into a convenient data frame. For more information, please refer to the Rsamtools
package.

bam.files <- dir(system.file("extdata", package = "ssviz"), full = TRUE, patt = "bam$")
ctrlbam <- readBam(bam.files[1])
treatbam <- readBam(bam.files[2])

Firstly, we can view the contents of the bam file, by simply typing the name of the object, for

example ctrlbam.

ctrlbam

pos

flag

qname

rname

qwidth

strand

16
16
0
16
16
...
16
0
16
0
16

74300-21
95290-16
114695-13
97521-15
100554-15
...
111742-13
24886-63
102926-15
122260-12
108613-14
cigar

mapq
<character> <integer> <factor> <factor> <integer> <integer> <integer>
255
255
255
255
255
...
255
255
255
255
255

## DataFrame with 9976 rows and 13 columns
##
##
## 1
## 2
## 3
## 4
## 5
## ...
## 9972
## 9973
## 9974
## 9975
## 9976
##
##
## 1
## 2
## 3
## 4
## 5
## ...

seq
<DNAStringSet>
0 CATATTGTGC...TCCTTTGTGA
0 GGTTCTTTCCAGCTTCTGGCTAT
0 AATTTTCTGA...CCGCCAGACT
0 TTCCAGTTTT...GCCTTTTGTA
0 GTTTCACTGT...TAGTTTCTGT
...

3005526
3005696
3005832
3008048
3008818
...
16828975
16833561
16834169
16838393
16838446

isize
<character> <factor> <integer> <integer>

chr1
chr1
chr1
chr1
chr1
...
chr1
chr1
chr1
chr1
chr1
mpos

24
23
24
30
29
...
27
27
25
29
26

-
-
+
-
-
...
-
+
-
+
-

NA
NA
NA
NA
NA
...

NA
NA
NA
NA
NA
...

24M
23M
24M
30M
29M
...

mrnm

...

3

NA
NA
NA
NA
NA

0 AAACAACACC...ATAGTCACAA
0 TTTGTCTCTG...TTCCATGGGT
0 GACTGATTTC...TGGTTGTACA
0 TAGGACGTGT...ATTGGCTGCA
0 GAGGAAGGCA...ATGGAGTGAA

NA
NA
NA
NA
NA

27M
27M
25M
29M
26M

## 9972
## 9973
## 9974
## 9975
## 9976
##
qual
##
<PhredQuality>
## 1
IIIIIIIIII...IIIIIIIIII
## 2
IIIIIIIIIIIIIIIIIIIIIII
## 3
IIIIIIIIII...IIIIIIIIII
## 4
IIIIIIIIII...IIIIIIIIII
## 5
IIIIIIIIII...IIIIIIIIII
...
## ...
## 9972 IIIIIIIIII...IIIIIIIIII
## 9973 IIIIIIIIII...IIIIIIIIII
## 9974 IIIIIIIIII...IIIIIIIIII
## 9975 IIIIIIIIII...IIIIIIIIII
## 9976 IIIIIIIIII...IIIIIIIIII

3.3 Read counts in small RNA sequencing

As mentioned above, raw reads files are usually collapsed before mapping, but the counts are retriev-
able. If you have used fastx-toolkit:

ctrl.count<-getCountMatrix(ctrlbam)
treat.count<-getCountMatrix(treatbam)

a counts column will now be appended to the DataFrame.

ctrl.count[1,]

mapq
<character> <integer> <factor> <factor> <integer> <integer> <integer>
255

3005526

strand

qwidth

rname

pos

24

-

flag

qname

74300-21
cigar

## DataFrame with 1 row and 14 columns
##
##
## 1
##
##
## 1
##
##
## 1 IIIIIIIIII...IIIIIIIIII

counts
qual
<PhredQuality> <numeric>
21

chr1
mpos

isize
<character> <factor> <integer> <integer>

mrnm

24M

16

NA

NA

seq
<DNAStringSet>
0 CATATTGTGC...TCCTTTGTGA

3.4 Plotting bam properties

ssviz has a few plot functions - the most basic is to plot the general distribution in the bam file based
on their properties. For small RNA sequencing in particular, it is important to know the lengths of the
reads (representing the lengths of the small RNA), direction (strand in sequencing) and perhaps region
(eg. chromosome or RNA element). For example, microRNAs are typically 18-24nt in length, whereas
piRNAs are longer, around 24-32 nt in length (Ruvkun 2001, Brennecke 2007, Thomson 2009).

When comparing two or more datasets, it is crucial that the datasets are normalized properly, and
this includes having information on (i) total number of counts for the same reads, and (ii) the overall

4

number of reads that was mapped, to make sure than the comparisons are on the same scale. Part
(i) can be obtained directly from the loaded bam DataFrame (if fastx-toolkit was used). Part (ii)
can be obtained as an output of the mapper, eg. bowtie. Typically this number would represent total
number of reads sequenced, or mappable to the broadest encompassing index (the genome).

In the bam file, read length is represented by qwidth, direction by strand and region by rname

and pos. For example, to plot the read length distribution (Figure 2):

plotDistro(list(ctrl.count), type = "qwidth", samplenames = c("Control"), ncounts = counts[1])

Figure 2: plotDistro with a single dataset

To compare two or more datasets, simply include them in the list (Figure 3).

plotDistro(list(ctrl.count, treat.count), type = "qwidth", samplenames = c("Control",

"Treatment"), ncounts = counts)

Figure 3: plotDistro with two datasets

5

3.5 Plotting region density

region<-'chr1:3015526-3080526'
plotRegion(list(ctrl.count), region=region)

Figure 4: plotRegion

3.6 piRNA ping-pong analysis

PIWI-interacting RNAs (piRNAs) are 23-30-nucleotide-long small RNAs that act as sequence-specific
silencers of transposable elements in animal gonads (Kawaoka 2011). The ping-pong mechanism is
a proposed method for the amplification of primary Piwi-associated RNAs (piRNAs), which leads to
the production of new primary piRNAs from their precursor transcripts, which eventually amplifies
the pool of both primary and secondary piRNAs (Brennecke 2007). This positive feedback loop is
a secondary biogenesis mechanism that requires complementary transcripts to a pre-existing pool of
piRNAs.

Piwi proteins retain the endoribonuclease or Slicer activity that allows them to cleave targets
between position 10 and position 11 of their bound piRNA. This cleavage defines the 5’ end of a
secondary piRNA that is generated from the transposon transcript. Because a very high proportion
of piRNAs have a uridine (U) at the first position and because the complementarity between piRNAs
and targets is expected to be nearly perfect, secondary piRNAs typically have adenosines at position
10, which base-pairs with the U at the first position of the piRNA. This is reflected as a sharp peak at
10nts when frequency is plotted against overlap length, and also can be seen in the nucleotide frequency
plot in the next section.

To compute the overlaps between the sense and anti-sense (amplified) piRNAs, we leverage on the
positional information contained in the bam file of "+" strand reads and "-" strand reads, calculates
and plots the frequency of overlap (up to the length of the read).

pp.ctrl<-pingpong(pctrlbam.count)
plotPP(list(pp.ctrl), samplenames=c("Control"))

6

Figure 5: plotPP

3.7 Computing nucleotide frequency (composition)

A known property of primary piRNA is a marked 5-prime uridine bias (Brennecke 2007). The ntfreq
function allows the user to compute the frequency of nucleotides over a chosen length.

pctrlbam.count<-getCountMatrix(pctrlbam)
freq.ctrl<-ntfreq(pctrlbam.count, ntlength=10)
plotFreq(freq.ctrl)

Figure 6: plotFreq

4 Further work

It is the hope that with feedback from the community, ssviz would further develop to support and
improve the multi-faceted analysis in small RNA sequencing including miRNA target identification
and novel RNA discovery. As such, output and working data formats have been kept to the convention
most widely utilized for sequencing analysis in R to ensure and enhance cross-compatibility and usage.

7

References

[1] FASTX-Toolkit: FASTQ/A short-reads pre-processing tools

[2] Ruvkun, G. Molecular Biology: Glimpses of a Tiny RNA World. Science 2001, 294, 797-799.

[3] Brennecke J, Aravin AA, Stark A, Dus M, Kellis M, Sachidanandam R, Hannon GJ. Discrete small
RNA-generating loci as master regulators of transposon activity in Drosophila. Cell. 2007;128:1089-
1103.

[4] Thomson T, Lin H. The biogenesis and function of PIWI proteins and piRNAs: progress and

prospect. Annu. Rev. Cell. Dev. Biol. 2009;25:355-376.

[5] Shinpei Kawaoka, Yuji Arai, Koji Kadota, et al. Zygotic amplification of secondary piRNAs during

silkworm embryogenesis RNA (2011), 17:00-00

sessionInfo()

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##
## locale:
##
##
##
##
##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4
## [8] base
##
## other attached packages:
##
##
##
## [10] S4Vectors_0.48.0
## [13] generics_0.1.4
##
## loaded via a namespace (and not attached):
##
##
##
## [10] dichromat_2.0-0.1

RColorBrewer_1.1-3
Rsamtools_2.26.0
GenomicRanges_1.62.0 IRanges_2.44.0
Seqinfo_1.0.0

[1] ssviz_1.44.0
[4] reshape_0.8.10
[7] XVector_0.50.0

dplyr_1.1.4
crayon_1.5.3
bitops_1.0-9
scales_1.4.0

[1] gtable_0.3.6
[4] highr_0.11
[7] Rcpp_1.1.0

grDevices utils

graphics

stats

datasets

compiler_4.5.1
tidyselect_1.2.1
parallel_4.5.1
BiocParallel_1.44.0

ggplot2_4.0.0
Biostrings_2.78.0

BiocGenerics_0.56.0

LAPACK version 3.12.0

methods

8

## [13] R6_2.6.1
## [16] tibble_3.3.0
## [19] xfun_0.53
## [22] formatR_1.14
## [25] grid_4.5.1
## [28] evaluate_1.0.5
## [31] codetools_0.2-20

plyr_1.8.9
pillar_1.11.1
S7_0.2.0
withr_3.0.2
lifecycle_1.0.4
glue_1.8.0
pkgconfig_2.0.3

knitr_1.50
rlang_1.1.6
cli_3.6.5
magrittr_2.0.4
vctrs_0.6.5
farver_2.1.2
tools_4.5.1

9

