MACPET

Ioannis Vardaxis ∗

∗

ioannis.vardaxis@ntnu.no

30 October 2018

Abstract

Package

This vignette gives an introduction to the MACPET package which can be used for the
analysis of paired-end DNA data like ChIA-PET. Throughout the vignette an introduction of
MACPET classes, methods and functions will be given.

MACPET 1.2.0 Rversion >=3.5.1

Contents

1

2

Introduction .

.

.

.

.

MACPET Classes .

PSelf Class .

PSFit Class .

PInter Class .

PIntra Class .

.

.

.

.

GenomeMap Class .

3

MACPET Methods .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

summary-method.

plot-method .

.

.

exportPeaks methods.

PeaksToGRanges methods .

TagsToGInteractions methods .

PeaksToNarrowPeak methods .

ConvertToPSelf methods .

.

.

GetSignInteractions methods .

GetShortestPath methods .

.

.

.

.

2.1

2.2

2.3

2.4

2.5

3.1

3.2

3.3

3.4

3.5

3.6

3.7

3.8

3.9

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

3

5

5

7

9

10

12

13

13

18

22

22

23

24

24

25

26

26

26

4

MACPET Supplementary functions .

4.1

AnalysisStatistics function .

.

.

.

.

MACPET

4.2

ConvertToPE_BAM function.

5

Peak Calling Workﬂow .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

27

29

2

MACPET

1

Introduction

The MACPET package can be used for general analysis of paired-end (PET) data like
ChIA-PET. MACPET currently implements the following ﬁve stages:

• Stage 0 (Linker ﬁltering):

Identiﬁes linkers A and B in the fastq ﬁles and classiﬁes
the reads as usable (A/A,B/B), chimeric (A/B,B/A) and ambiguous (non/A, non/B,
A/non, B/non).

• Stage 1 (Mapping to the reference genome): Maps the usable reads separately into the
reference genome using Rbowtie package, and keeps only uniquely mapped reads with
zero mismatch per read. It then maps the unmapped reads to the reference genome with
at most one mismatch and keeps the uniquely mapped reads. Uniquely mapped reads
with zero or one mismatch are then merged and paired, their duplicates are marked and
a paired-end bam ﬁle is created which is used in State 2.

• Stage 2 (PET classiﬁcation): Classiﬁes the PETs as self-ligated (short genomic distance,
same chromosome), intra-chromosomal (long genomic distance, same chromosome) by
ﬁnding the self-ligated cut-oﬀ using the elbow method, and inter-chromosomal (diﬀerent
chromosomes). Furthermore, it removes identically mapped PETs for reducing noise
created by ampliﬁcation procedures. Moreover, it can remove black-listed regions based
on the genome of the data. Note that loading the data into R might take a while
depending on the size of the data.

• Stage 3 (Peak-calling): Uses the self-ligated PETs found in Stage 2 and segments the
genome into non-overlapping regions. It then uses both reads of each PET and applies
2D mixture models for identifying two-dimensional clusters which represent candidate
binding sites using the skewed generalized students-t distributions (SGT). Finally, it
uses a local Poisson model for ﬁnding signiﬁcant binding sites.

• Stage 4 (Interaction-calling): This stage uses the intra- and inter-chromosomal PETs
found in State 2, as well as the signiﬁcant Peaks found in Stage 3 for calling for
signiﬁcant interactions. NOTE: currently inter-chromosomal PETs are not supported.

MACPET identiﬁes binding site locations more accurately than other algorithms which use
only one end (like MACS) (Vardaxis et al.). The output from Stage 3 in MACPET can be
used for interaction analysis using either MANGO or MICC, or the user can run State 4 in
MACPET for interaction analysis. Note that in the case of using the output from MACPET
in MANGO or MICC for interaction analysis, the user should use the self-ligated cut-oﬀ found
by MACPET , and not the one found in MANGO or MICC. Both of those algorithms allow the
user to specify the self-ligated cut-oﬀ. MACPET is mainly written in C++, and it supports
the BiocParallel package.

Before starting with examples of how to use MACPET , create a test folder to save all the
output ﬁles of the examples presented in this vignette:

#Create a temporary test folder, or anywhere you want:
SA_AnalysisDir=file.path(tempdir(),"MACPETtest")
dir.create(SA_AnalysisDir)#where you will save the results.

Load the package:

library(MACPET)

## Loading required package: InteractionSet

## Loading required package: GenomicRanges

## Loading required package: stats4

## Loading required package: BiocGenerics

3

MACPET

## Loading required package: parallel

##

## Attaching package: 'BiocGenerics'

## The following objects are masked from 'package:parallel':

##

##

##

##

clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,

clusterExport, clusterMap, parApply, parCapply, parLapply,

parLapplyLB, parRapply, parSapply, parSapplyLB

## The following objects are masked from 'package:stats':

##

##

IQR, mad, sd, var, xtabs

## The following objects are masked from 'package:base':

##

##

##

##

##

##

##

##

Filter, Find, Map, Position, Reduce, anyDuplicated, append,

as.data.frame, basename, cbind, colMeans, colSums, colnames,

dirname, do.call, duplicated, eval, evalq, get, grep, grepl,

intersect, is.unsorted, lapply, lengths, mapply, match, mget,

order, paste, pmax, pmax.int, pmin, pmin.int, rank, rbind,

rowMeans, rowSums, rownames, sapply, setdiff, sort, table,

tapply, union, unique, unsplit, which, which.max, which.min

## Loading required package: S4Vectors

##

## Attaching package: 'S4Vectors'

## The following object is masked from 'package:base':

##

##

expand.grid

## Loading required package: IRanges

## Loading required package: GenomeInfoDb

## Loading required package: SummarizedExperiment

## Loading required package: Biobase

## Welcome to Bioconductor

##

##

##

##

Vignettes contain introductory material; view with

'browseVignettes()'. To cite Bioconductor, see

'citation("Biobase")', and for packages 'citation("pkgname")'.

## Loading required package: DelayedArray

## Loading required package: matrixStats

##

## Attaching package: 'matrixStats'

## The following objects are masked from 'package:Biobase':

##

##

anyMissing, rowMedians

## Loading required package: BiocParallel

##

## Attaching package: 'DelayedArray'

## The following objects are masked from 'package:matrixStats':

##

##

colMaxs, colMins, colRanges, rowMaxs, rowMins, rowRanges

## The following objects are masked from 'package:base':

##

##

aperm, apply

4

MACPET

## Loading required package: bigmemory

## Loading required package: BH

## Loading required package: Rcpp

## Setting options('download.file.method.GEOquery'='auto')

## Setting options('GEOquery.inmemory.gpl'=FALSE)

2

MACPET Classes

MACPET provides ﬁve diﬀerent classes which all inherit from the GInteractions class in the
InteractionSet package. Therefore, every method associated with the GInteractions class is
also applicable to the MACPET classes. Every MACPET class contains information of the
PETs associated with the corresponding class, their start/end coordinates on the genome as
well as which chromosome they belong to. This section provides an overview of the MACPET
classes, while methods associated with each class are presented in latter sections. The classes
provided by MACPET are the following:

• PSelf class contains information about the self-ligated PETs in the data. This class is
created using either the MACPETUlt function at stage 2 or the ConvertToPSelf function.
• PSFit class is an update of the PSelf class, which contains information about which
binding site each PET belongs to, as well as signiﬁcant peaks found by the peak-calling
algorithm. This class is created using the MACPETUlt function at stage 3.

• PInter class contains information about Inter-chromosomal PETs in the data. This

class is created using the MACPETUlt function at stage 2.

• PIntra class contains information about Intra-chromosomal PETs in the data. This class

is created using the MACPETUlt function at stage 2.

• GenomeMap class contains information about the interactions in the genome. This
class is created using the MACPETUlt function at stage 4. Then the user can use the
GetSignInteractions function for subseting the signiﬁcant interactions from the object
and return a GInteractions class object.

2.1

PSelf Class

The PSelf class contains pair-end tag information of self-ligated PETs which is used for
binding site analysis.

load(system.file("extdata", "MACPET_pselfData.rda", package = "MACPET"))
class(MACPET_pselfData) #example name
## [1] "PSelf"
MACPET_pselfData #print method
## PSelf object with 4520 interactions and 0 metadata columns:

##

##

##

##

##

##

##

##

seqnames1

ranges1

seqnames2

ranges2

<Rle>

<IRanges>

<Rle>

<IRanges>

[1]

[2]

[3]

[4]

[5]

...

chr1 128071-128090 ---

chr1 127738-127757

chr1 128071-128090 ---

chr1 127738-127757

chr1 128071-128090 ---

chr1 127738-127757

chr1 134267-134286 ---

chr1 134548-134567

chr1 134282-134301 ---

chr1 134461-134480

...

... ...

...

...

5

MACPET

##

##

##

##

##

##

##

##

[4516]

[4517]

[4518]

[4519]

[4520]

-------

chrX

chrX

chrX

chrX

chrX

16419-16438 ---

16422-16441 ---

16423-16442 ---

16478-16497 ---

16485-16504 ---

chrX

chrX

chrX

chrX

chrX

16099-16118

15920-15939

16067-16086

16112-16131

16126-16145

regions: 7548 ranges and 0 metadata columns

seqinfo: 18 sequences from hg19 genome

Extra information of this class is stored as list in the metadata entries with the following
elements:

• Self_info: a two-column data.frame with information about the chromosomes in the

data (chrom) and the total PET counts of each chromosome (PET.counts).

• SLmean: which is the mean size of the self-ligated PETs.
• MaxSize: The maximum self-ligated PET size in the data.
• MinSize: The minimum self-ligated PET size in the data.

metadata(MACPET_pselfData)
## $Self_info
##

Chrom PET.counts

469

235

247

451

130

215

133

41

174

268

169

267

258

189

528

100

203

443

## 1

## 2

## 3

## 4

## 5

## 6

chr1

chr2

chr3

chr7

chr8

chr9

## 7

chr10

## 8

chr11

## 9

chr12

## 10 chr15

## 11 chr16

## 12 chr17

## 13 chr18

## 14 chr19

## 15 chr20

## 16 chr21

## 17 chr22

## 18

chrX

##

## $SLmean

## [1] 294

##

## $MaxSize

## [1] 799

##

## $MinSize

## [1] 21

One can also access information about chromosome lengths etc.

6

MACPET

seqinfo(MACPET_pselfData)
## Seqinfo object with 18 sequences from hg19 genome:

##

##

##

##

##

##

##

##

##

##

##

##

seqnames seqlengths isCircular genome

chr1

chr2

chr3

chr7

chr8

...

chr19

chr20

chr21

chr22

chrX

249250621

243199373

198022430

159138663

146364022

...

59128983

63025520

48129895

51304566

155270560

<NA>

<NA>

<NA>

<NA>

<NA>

...

<NA>

<NA>

<NA>

<NA>

<NA>

hg19

hg19

hg19

hg19

hg19

...

hg19

hg19

hg19

hg19

hg19

2.2

PSFit Class

The PSFit class adds information to the PSelf class about the peak each PET belongs to,
as well as the total number of peaks in each chromosome in the data, p-values and FDR for
each peak.

load(system.file("extdata", "MACPET_psfitData.rda", package = "MACPET"))
class(MACPET_psfitData) #example name
## [1] "PSFit"
MACPET_psfitData #print method
## PSFit object with 4520 interactions and 0 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

seqnames1

ranges1

seqnames2

ranges2

<Rle>

<IRanges>

<Rle>

<IRanges>

chr1 128071-128090 ---

chr1 127738-127757

chr1 128071-128090 ---

chr1 127738-127757

chr1 128071-128090 ---

chr1 127738-127757

chr1 134267-134286 ---

chr1 134548-134567

chr1 134282-134301 ---

chr1 134461-134480

...

chrX

chrX

chrX

chrX

chrX

... ...

16419-16438 ---

16422-16441 ---

16423-16442 ---

16478-16497 ---

16485-16504 ---

...

chrX

chrX

chrX

chrX

chrX

...

16099-16118

15920-15939

16067-16086

16112-16131

16126-16145

[1]

[2]

[3]

[4]

[5]

...

[4516]

[4517]

[4518]

[4519]

[4520]

-------

regions: 7548 ranges and 0 metadata columns

seqinfo: 18 sequences from hg19 genome

This class updates the Self_info data frame of the PSelf class with two extra columns: the
total regions each chromosome is segmented into (Region.counts) and the total candidate
peaks of each chromosome (Peak.counts). Moreover, this class contains a metadata entry
which is a matrix containing region and peak IDs for each PET in the data (Classiﬁcation.Info).
Finally, it also contains a metadata entry with information about each peak found (Peaks.Info).
Peaks.Info is a data.frame with the following entries:

7

MACPET

• Chrom: The name of the chromosome
• Pets: Total PETs in the peak.
• Peak.Summit: Summit of the peak.
• Up.Summit: Summit of the left-stream PETs.
• Down.Summit: Summit of the right-stream PETs.
• CIQ.Up.start: Start of 95 Quantile conﬁdence interval for the left-stream PETs.
• CIQ.Up.end: End of 95 Quantile conﬁdence interval for the left-stream PETs.
• CIQ.Up.size: Size of 95 Quantile conﬁdence interval for the left-stream PETs.
• CIQ.Down.start: Start of 95 Quantile conﬁdence interval for the right-stream PETs.
• CIQ.Down.end: End of 95 Quantile conﬁdence interval for the right-stream PETs.
• CIQ.Down.size: Size of 95 Quantile conﬁdence interval for the right-stream PETs.
• CIQ.Peak.size: Size of the Peak based on the interval (CIQ.Up.start,CIQ.Down.end).
• sdx: The standard deviation of the upstream PETs.
• lambdax: The skewness of the upstream PETs.
• sdy: The standard deviation of the downstream PETs.
• lambday: The skewness of the downstream PETs.
• lambdaUp: The expected number of PETs in the left-stream Peak region by random

chance.

• FoldEnrichUp: Fold enrichment for the left-stream Peak region.
• p.valueUp: p-value for the left-stream Peak region.
• lambdaDown: The expected number of PETs in the right-stream Peak region by random

chance.

• FoldEnrichDown: Fold enrichment for the right-stream Peak region.
• p.valueDown: p-value for the right-stream Peak region.
• p.value: p-value for the Peak (p.valueUp*p.valueDown).
• FDRUp: FDR correction for the left-stream Peak region.
• FDRDown: FDR correction for the right-stream Peak region.
• FDR: FDR correction for the Peak.

head(metadata(MACPET_psfitData)$Peaks.Info)
##

Chrom Region Peak Pets Peak.Summit Up.Summit Down.Summit CIQ.Up.start

## 1

chr1

## 2

chr1

## 3

chr1

## 4

chr1

## 5

chr1

## 6

chr1

2

3

4

5

6

6

1

1

1

1

1

2

4

21

2

4

3

11

134529

134454.5

134602.5

136275

136223.5

136326.6

138672

138586.5

138757.5

153168

153048.5

153287.5

158256

158182.5

158330.5

158623

158533.5

158713.5

134258.6

135925.9

138468.7

152903.6

158172.4

158073.4

##

CIQ.Up.end CIQ.Up.size CIQ.Down.start CIQ.Down.end CIQ.Down.size

## 1

## 2

## 3

## 4

## 5

## 6

134452.0

136219.5

138585.0

153046.6

158182.4

158527.5

194

295

117

144

11

455

134604.6

136332.8

138761.0

153289.0

158330.5

158714.7

134763.6

136792.8

139036.0

153408.2

158332.3

158802.7

160

461

276

120

2

89

##

CIQ.Peak.size

sdx

lambdax

sdy

lambday lambdaUp

## 1

## 2

## 3

## 4

## 5

## 6

506 32.786997 -0.9761421 26.9709052 0.9760635 2.000000

868 49.667461 -0.9798426 77.8374868 0.9794046 3.398848

568 19.722558 -0.9755519 46.6467757 0.9755518 2.000000

505 24.248986 -0.9761427 20.2136087 0.9761358 2.000000

161 1.698188 -0.9757212

0.3076363 0.9757213 2.000000

731 76.906514 -0.9779880 14.9170727 0.9779329 2.199517

##

FoldEnrichUp

p.valueUp lambdaDown FoldEnrichDown

p.valueDown

8

MACPET

## 1

## 2

## 3

## 4

## 5

## 6

##

2.000000 5.265302e-02

2.000000

2.000000 5.265302e-02

6.178564 1.703525e-11

4.199089

5.001085 8.349971e-10

1.000000 3.233236e-01

2.000000

1.000000 3.233236e-01

2.000000 5.265302e-02

2.000000

2.000000 5.265302e-02

1.500000 1.428765e-01

2.000000

1.500000 1.428765e-01

5.001099 3.561537e-06

2.097643

5.243981 2.211986e-06

p.value

FDRUp

FDRDown

FDR

## 1 2.772340e-03 1.001149e-01 1.001149e-01 5.271351e-03

## 2 1.422439e-20 1.210399e-10 5.636230e-09 9.601460e-20

## 3 1.045381e-01 3.357591e-01 3.419012e-01 1.102551e-01

## 4 2.772340e-03 1.001149e-01 1.001149e-01 5.271351e-03

## 5 2.041371e-02 2.269216e-01 2.296230e-01 3.242177e-02

## 6 7.878071e-12 1.602692e-05 1.066493e-05 3.667378e-11

One can also access information about chromosome lengths etc, using
seqinfo(MACPET_psfitData).

2.3

PInter Class

The PInter class contains pair-end tag information of Inter-chromosomal PETs:

load(system.file("extdata", "MACPET_pinterData.rda", package = "MACPET"))
class(MACPET_pinterData) #example name
## [1] "PInter"
MACPET_pinterData #print method
## PInter object with 94 interactions and 0 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

seqnames1

ranges1

seqnames2

<Rle>

<IRanges>

chr1 419128-419147 ---

<Rle>

chr15

ranges2

<IRanges>

89807-89826

chr1 450489-450508 ---

chr19 328877-328896

chr1 720534-720553 ---

chr15 554025-554044

chr1 778824-778843 ---

chr17 433884-433903

chr2 208915-208934 ---

chr8 142996-143015

...

chrX

chrX

chrX

chrX

chrX

... ...

...

...

5467-5486 ---

chr15

14508-14527

7866-7885 ---

chr18 174143-174162

8461-8480 ---

chr20 351317-351336

10072-10091 ---

chr19 302795-302814

16501-16520 ---

chr2 844134-844153

[1]

[2]

[3]

[4]

[5]

...

[90]

[91]

[92]

[93]

[94]

-------

regions: 172 ranges and 0 metadata columns

seqinfo: 18 sequences from hg19 genome

One can also access information about chromosome lengths etc, using
seqinfo(MACPET_pinterData).

It also contains a two-element metadata list with the following elements:

• InteractionCounts: a table with the total number of Inter-chromosomal PETs between
chromosomes. Where the rows represent the “from” anchor and the columns the “to”
anchor.

9

MACPET

metadata(MACPET_pinterData)
## $InteractionCounts

##

chr1 chr2 chr3 chr7 chr8 chr9 chr10 chr11 chr12 chr15 chr16 chr17

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

2

0

0

0

0

0

0

0

0

0

0

1

0

0

0

2

0

0

0

0

0

0

0

0

0

0

0

3

0

0

0

0

1

0

1

1

1

0

0

0

0

0

2

0

1

1

0

0

0

0

0

1

1

1

0

0

1

0

0

0

1

0

0

1

3

0

0

0

0

## chr1

## chr2

## chr3

## chr7

## chr8

## chr9

## chr10

## chr11

## chr12

## chr15

## chr16

## chr17

## chr18

## chr19

## chr20

## chr21

## chr22

## chrX

0

0

0

0

0

1

0

0

0

0

2

0

0

0

2

0

0

0

0

0

1

1

0

0

1

0

0

0

5

0

1

0

0

0

0

1

0

0

0

1

0

0

0

0

0

0

0

1

0

0

0

0

0

0

0

0

1

0

0

0

0

0

0

0

0

1

1

0

0

0

0

0

0

1

0

0

0

1

2

0

0

0

0

0

0

0

1

0

0

0

0

1

1

0

1

0

1

0

0

0

0

1

1

0

1

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

1

0

1

0

0

0

##

chr18 chr19 chr20 chr21 chr22 chrX

## chr1

## chr2

## chr3

## chr7

## chr8

## chr9

## chr10

## chr11

## chr12

## chr15

## chr16

## chr17

## chr18

## chr19

## chr20

## chr21

## chr22

## chrX

0

0

2

0

0

1

0

0

0

0

0

1

0

0

0

0

0

1

1

0

0

0

0

1

0

0

0

1

0

0

0

0

0

0

0

1

0

0

0

1

0

2

1

0

1

0

2

0

0

0

0

0

0

2

0

0

1

0

0

0

0

0

0

0

0

1

0

0

0

0

0

0

0

0

1

0

2

1

0

0

0

0

2

1

0

0

2

0

0

0

0

0

1

0

0

0

0

2

2

0

0

0

0

0

0

0

1

0

2.4

PIntra Class

The PIntra class contains pair-end tag information of Intra-chromosomal PETs.

load(system.file("extdata", "MACPET_pintraData.rda", package = "MACPET"))
class(MACPET_pintraData)#example name
## [1] "PIntra"
MACPET_pintraData#print method

10

MACPET

## PIntra object with 744 interactions and 0 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

seqnames1

ranges1

seqnames2

ranges2

<Rle>

<IRanges>

<Rle>

<IRanges>

[1]

[2]

[3]

[4]

[5]

...

[740]

[741]

[742]

[743]

[744]

-------

chr1 131180-131199 ---

chr1 152956-152975

chr1 134496-134515 ---

chr1 136252-136271

chr1 134612-134631 ---

chr1 158684-158703

chr1 134656-134675 ---

chr1 136152-136171

chr1 134712-134731 ---

chr1 136350-136369

...

chrX

chrX

chrX

chrX

chrX

... ...

16501-16520 ---

16501-16520 ---

16511-16530 ---

16512-16531 ---

16532-16551 ---

...

chrX

chrX

chrX

chrX

chrX

...

151-170

151-170

225-244

145-164

181-200

regions: 1245 ranges and 0 metadata columns

seqinfo: 18 sequences from hg19 genome

One can also access information about chromosome lengths etc, using
seqinfo(MACPET_pintraData).

It also contains a two-element metadata list with the following elements:

• InteractionCounts: a data.frame with the total number of Intra-chromosomal PETs for

each chromosome (Counts).

metadata(MACPET_pintraData)
## $InteractionCounts

##

Chrom Counts

## 1

## 2

## 3

## 4

## 5

## 6

chr1

chr2

chr3

chr7

chr8

chr9

## 7

chr10

## 8

chr11

## 9

chr12

## 10 chr15

## 11 chr16

## 12 chr17

## 13 chr18

## 14 chr19

78

37

48

107

13

21

14

10

31

56

25

43

37

26

## 15 chr20

102

## 16 chr21

## 17 chr22

## 18 chrX

16

30

50

11

MACPET

2.5

GenomeMap Class

The GenomeMap class contains all potential interactions between pairs of peaks, as well as
the peaks’ anchors.

load(system.file("extdata", "MACPET_GenomeMapData.rda", package = "MACPET"))
class(MACPET_GenomeMapData) #example name
## [1] "GenomeMap"
MACPET_GenomeMapData #print method
## GenomeMap object with 21 interactions and 2 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

seqnames1

ranges1

seqnames2

ranges2 | Anchor1Summit

<Rle>

<IRanges>

<Rle>

<IRanges> |

<numeric>

chr20 563447-565026 ---

chr20 905525-908110 |

chrX

-499-4606 ---

chrX

11382-17547 |

chr2 282319-283671 ---

chr2 355304-356676 |

chr3 632669-634651 ---

chr3 680567-682065 |

chr7 637535-638947 ---

chr7 690783-692499 |

...

... ...

...

... .

chr15 566320-568128 ---

chr15 578749-580144 |

chr17 985885-987476 ---

chr17 990745-992798 |

chr7 363524-368143 ---

chr7 373783-375135 |

chr7 363524-368143 ---

chr7 376355-378400 |

chr7 373783-375135 ---

chr7 376355-378400 |

564247

361

282890

633509

638268

...

567173

986528

366948

366948

374495

Anchor2Summit

<numeric>

907011

15855

355921

681202

691724

...

579414

991796

374495

377298

377298

[1]

[2]

[3]

[4]

[5]

...

[17]

[18]

[19]

[20]

[21]

[1]

[2]

[3]

[4]

[5]

...

[17]

[18]

[19]

[20]

[21]

-------

regions: 32 ranges and 0 metadata columns

seqinfo: 18 sequences from hg19 genome

Extra information of this class is stored as list in the metadata entries with the following
elements:

• pvalue: The p-value of the interaction.
• FDR: The FDR of the interaction.
• Order: The order the interaction was entered into the model.
• TotalInterPETs: The total interaction PETs between every two interacting peaks.

Each row in the metadata entry corresponds to the same row in the main object.

metadata(MACPET_GenomeMapData)
## $InteractionInfo

## DataFrame with 21 rows and 4 columns

12

MACPET

##

##

## 1

## 2

## 3

## 4

## 5

## ...

## 17

## 18

## 19

## 20

## 21

pvalue

<numeric>

FDR

Order TotalInterPETs

<numeric> <numeric>

<numeric>

9.26058005318194e-09 6.01937703456826e-07

0.000127327838847454 0.00814898168623704

0.0319658097028795

0.671282003760469

0.0269894695978567

0.671282003760469

0.0154904671976064

0.671282003760469

1

2

3

3

3

...

...

...

0.758560331886533

0.450415834308879

0.992157972205279

0.104457939309804

0.891787260692922

1

1

1

1

1

5

5

5

5

5

9

32

3

4

4

...

3

5

4

15

7

3

MACPET Methods

This section describes methods associated with the classes in the MACPET package.

3.1

summary-method

All MACPET classes are associated with a summary method which sums up the information
stored in each class:

3.1.1 PSelf Class

summary for PSelf class prints information about the total number of self-ligated PETs for
each chromosome, as well as the total number of self-ligated PETs in the data, their min/max
length and genome information of the data:

class(MACPET_pselfData)
## [1] "PSelf"
summary(MACPET_pselfData)
## |-Self-ligatead PETs|

## |------Summary------|

##

## | Chrom | Self-lig. |

## |:-----:|:---------:|

## | chr1 |

## | chr2 |

## | chr3 |

## | chr7 |

## | chr8 |

## | chr9 |

## | chr10 |

## | chr11 |

## | chr12 |

## | chr15 |

469

235

247

451

130

215

133

41

174

268

|

|

|

|

|

|

|

|

|

|

13

MACPET

## | chr16 |

## | chr17 |

## | chr18 |

## | chr19 |

## | chr20 |

## | chr21 |

## | chr22 |

## | chrX |

##

##

169

267

258

189

528

100

203

443

|

|

|

|

|

|

|

|

## ============== ===================

======

## Tot. Self-lig. Self-lig. mean size

Genome

## ============== ===================

======

##

4520

294

hg19

## ============== ===================

======

##

##

## ================ ================

## Sortest Self-PET Longest Self-PET

## ================ ================

##

21 bp

799 bp

## ================ ================

3.1.2 PSFit Class

summary for PSFit class adds information to the summary of PSelf class. The new information
is the total regions found and analysed for each chromosome and the total number of candidate
binding sites found on each chromosome:

class(MACPET_psfitData)
## [1] "PSFit"
summary(MACPET_psfitData)
## |------Self-ligated PETs Summary------|

##

## | Chrom | Self-lig. | Regions | Peaks |

## |:-----:|:---------:|:-------:|:-----:|

## | chr1 |

## | chr2 |

## | chr3 |

## | chr7 |

## | chr8 |

## | chr9 |

## | chr10 |

## | chr11 |

## | chr12 |

## | chr15 |

## | chr16 |

## | chr17 |

## | chr18 |

## | chr19 |

469

235

247

451

130

215

133

41

174

268

169

267

258

189

|

|

|

|

|

|

|

|

|

|

|

|

|

|

49

32

27

50

15

21

20

7

23

23

11

29

38

26

|

|

|

|

|

|

|

|

|

|

|

|

|

|

23

10

8

16

4

3

5

1

8

6

1

6

9

6

|

|

|

|

|

|

|

|

|

|

|

|

|

|

14

MACPET

## | chr20 |

## | chr21 |

## | chr22 |

## | chrX |

528

100

203

443

|

|

|

|

37

12

24

7

|

|

|

|

13

2

4

10

|

|

|

|

##

##

## ============== ======= ===== ===================

## Tot. Self-lig. Regions Peaks Self-lig. mean size

## ============== ======= ===== ===================

##

4520

451

135

294

## ============== ======= ===== ===================

##

##

## ====== ================ ================

=====

## Genome Sortest Self-PET Longest Self-PET

class

## ====== ================ ================

=====

##

hg19

21 bp

799 bp

PSFit

## ====== ================ ================

=====

3.1.3 PIntra Class

summary for PIntra class prints information about the total number of intra-ligated PETs for
each chromosome, as well as information about the genome. The user can choose to plot a
heat-map for the total number of intra-ligated PETs on each chromosome:

class(MACPET_pintraData)
## [1] "PIntra"

requireNamespace("ggplot2")

## Loading required namespace: ggplot2

requireNamespace("reshape2")

## Loading required namespace: reshape2
summary(MACPET_pintraData,heatmap=TRUE)
## |--Intra-chrom. PETs--|

## |-------Summary-------|

##

## |Chrom | Intra-chrom. |

## |:-----|:------------:|

## |chr1 |

## |chr2 |

## |chr3 |

78

37

48

## |chr7 |

107

## |chr8 |

## |chr9 |

## |chr10 |

## |chr11 |

## |chr12 |

## |chr15 |

## |chr16 |

## |chr17 |

## |chr18 |

13

21

14

10

31

56

25

43

37

|

|

|

|

|

|

|

|

|

|

|

|

|

15

MACPET

## |chr19 |

## |chr20 |

## |chr21 |

## |chr22 |

## |chrX |

##

##

26

102

16

30

50

|

|

|

|

|

## ================= ====== ======

## Tot. Intra-chrom. Genome class

## ================= ====== ======

##

744

hg19

PIntra

## ================= ====== ======

3.1.4 PInter Class

summary for PInter class prints information about the total number of inter-ligated PETs for
each chromosome, as well as information about the genome. The user can choose to plot a
heat-map for the total number of inter-ligated PETs connecting the chromosomes:

class(MACPET_pinterData)
## [1] "PInter"

requireNamespace("ggplot2")

requireNamespace("reshape2")
summary(MACPET_pinterData,heatmap=TRUE)
## |--Inter-chrom. PETs--|

## |-------Summary-------|

##

## |Chrom | Inter-chrom. |

## |:-----|:------------:|

## |chr1 |

## |chr2 |

## |chr3 |

4

4

10

|

|

|

16

chr1chr2chr3chr7chr8chr9chr10chr11chr12chr15chr16chr17chr18chr19chr20chr21chr22chrXchr1chr2chr3chr7chr8chr9chr10chr11chr12chr15chr16chr17chr18chr19chr20chr21chr22chrXChromosomeChromosome0.000.250.500.751.00valueHeat−Map plot for Intra−chromosomal CountsMACPET

## |chr7 |

## |chr8 |

## |chr9 |

## |chr10 |

## |chr11 |

## |chr12 |

## |chr15 |

## |chr16 |

## |chr17 |

## |chr18 |

## |chr19 |

## |chr20 |

## |chr21 |

## |chr22 |

## |chrX |

##

##

6

3

8

5

2

3

4

11

7

9

3

8

0

1

6

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

## ====================== ====== ======

## Tot. Inter-chrom. PETs Genome class

## ====================== ====== ======

##

94

hg19

PInter

## ====================== ====== ======

3.1.5 GenomeMap Class

summary for GenomeMap class prints information about the total number of interactions in
the data. The user can provide a threshold for the FDR cut-oﬀ of the signiﬁcant interactions
to make the summary from. Alternatively if threshold=NULL all the interactions will be used
for the summary.

17

chr1chr2chr3chr7chr8chr9chr10chr11chr12chr15chr16chr17chr18chr19chr20chr21chr22chrXchr1chr2chr3chr7chr8chr9chr10chr11chr12chr15chr16chr17chr18chr19chr20chr21chr22chrXChromosomeChromosome0.000.250.500.751.00valueHeat−Map plot for Inter−chromosomal CountsMACPET

class(MACPET_GenomeMapData)
## [1] "GenomeMap"
summary(MACPET_GenomeMapData)
## No threshold given, all the interactions are returned.

## |------------------------------------------Interactions Summary------------------------------------------|

##

## | Tot. Peaks used | Tot. Intra-chrom. interactions | Tot. Inter-chrom. interactions | Genome |

Class

|

## |:---------------:|:------------------------------:|:------------------------------:|:------:|:---------:|

## |

21

|

21

|

0

| hg19

| GenomeMap |

3.2

plot-method

All MACPET classes are associated with a plot method which can be used to visualize counts,
PETs in a region, as well as binding sites. Here we give some examples for the usage of the plot
methods, however more arguments can be provided to the plot methods, see MACPET::plot.

3.2.1 PSelf Class

plot for PSelf Class will create a bar-plot showing the total number of self-ligated PETs on
each chromosome. The x-axis are the chromosomes and the y-axis are the corresponding
frequencies.

requireNamespace("ggplot2")
class(MACPET_pselfData)
## [1] "PSelf"

# PET counts plot
plot(MACPET_pselfData)

18

0200400chr1chr10chr11chr12chr15chr16chr17chr18chr19chr2chr20chr21chr22chr3chr7chr8chr9chrXChromosomePET countsChromchr1chr10chr11chr12chr15chr16chr17chr18chr19chr2chr20chr21chr22chr3chr7chr8chr9chrXSelf−ligated PET counts by chromosomeMACPET

3.2.2 PSFit Class

plot for PSFit Class will create a bar-plot (if kind=“PeakCounts”) showing the total number
of candidate binding sites found on each chromosome. The x-axis are the chromosomes and
the y-axis are the corresponding frequencies.

class(MACPET_psfitData)
## [1] "PSFit"

#binding site couts:
plot(MACPET_psfitData,kind="PeakCounts")

Other kind of plots are also supported for this class. For example if kind=“PeakPETs”, then
a visual representation of a region will be plotted (RegIndex chooses which region to plot
with 1 meaning the one with the highest total of PETs in it). The x-axis are the genomic
coordinates of the region and the y-axis if the sizes of the PETs. Each segment represents a
PET from its start to its end coordinate. Diﬀerent colors of colors represent which binding
site each PET belongs to, with red (PeakID=0) representing the noise cluster. Vertical lines
represent the exact binding location of the binding site.

# region example with binding sites:
plot(MACPET_psfitData,kind="PeakPETs",RegIndex=1)

19

05101520chr1chr10chr11chr12chr15chr16chr17chr18chr19chr2chr20chr21chr22chr3chr7chr8chr9chrXChromosomePeak countsChromchr1chr10chr11chr12chr15chr16chr17chr18chr19chr2chr20chr21chr22chr3chr7chr8chr9chrXSelf−ligated peak counts by chromosomeMACPET

3.2.3 PIntra Class

plot for PIntra Class will create a bar-plot showing the total number of intra-ligated PETs
on each chromosome. The x-axis are the chromosomes and the y-axis are the corresponding
frequencies.

class(MACPET_pintraData)
## [1] "PIntra"

#plot counts:
plot(MACPET_pintraData)

20

200400600800110001300015000Midpoints of PETsPET sizesPeakID0123Visualization of PETs in region. Vertical lines correspond to peak−summits.0306090chr1chr10chr11chr12chr15chr16chr17chr18chr19chr2chr20chr21chr22chr3chr7chr8chr9chrXChromosomeIntra countChromchr1chr10chr11chr12chr15chr16chr17chr18chr19chr2chr20chr21chr22chr3chr7chr8chr9chrXIntra−chromosomal PET counts by chromosomeMACPET

3.2.4 PInter Class

plot for PInter Class. Each node represents a chromosome where the size of the node is
proportional to the total number of Inter-chromosomal PETs leaving from this chromosome.
Edges connect interacting chromosomes where the thickness of each edge is proportional to
the total number of Inter-chromosomal PETs connecting the two chromosomes.

class(MACPET_pinterData)
## [1] "PInter"

requireNamespace("igraph")

## Loading required namespace: igraph

#network plot:
plot(MACPET_pinterData)

## NULL

3.2.5 GenomeMap Class

plot for GenomeMap Class. Diﬀerent kind of plot can be created using the Type parameter.
The user can also specify a threshold for the signiﬁcant interactions to make the plots from.
In the following example, each node represents a chromosome and the edges show which
chromosomes have signiﬁcant interactions between them.

class(MACPET_GenomeMapData)
## [1] "GenomeMap"

requireNamespace("igraph")

#network plot:
plot(MACPET_GenomeMapData,Type='network-circle')
## No threshold given, all the interactions are returned.

21

Inter Interaction Network Plotchr1chr2chr3chr7chr8chr9chr10chr11chr12chr15chr16chr17chr18chr19chr20chr21chr22chrXMACPET

3.3

exportPeaks methods

PSFit class has a method which exports the binding site information stored in meta
data(object)[[’Peaks.Info’]] into csv ﬁles in a given directory if one wishes to have
the binding sites in an excel ﬁle. The user can also specify a threshold for the FDR. If no
threshold is speciﬁed all the binding sites found by the algorithm are exported.

class(MACPET_psfitData)#PSFit class
## [1] "PSFit"
exportPeaks(object=MACPET_psfitData,file.out="Peaks",threshold=1e-5,savedir=SA_AnalysisDir)
## [1] "The output is saved at savedir"

3.4

PeaksToGRanges methods

PSFit class has also a method which converts the binding sites found by the peak-calling
algorithm into a GRanges object with start and end coordinates the binding site’s conﬁdence
interval (CIQ.Up.start,CIQ.Down.end). It furthermore contains information about the total
number of PETs in the peak (TotPETs), the p-value of the peak (p.value) and its FDR (FDR).
The user can also specify an FDR threshold for returning signiﬁcant peaks. If threshold=NULL,
all the found peaks are returned.

class(MACPET_psfitData)#PSFit class
## [1] "PSFit"
object=PeaksToGRanges(object=MACPET_psfitData,threshold=1e-5)
object

## GRanges object with 39 ranges and 3 metadata columns:

##

##

##

##

seqnames

ranges strand |

TotPETs

<Rle>

<IRanges>

<Rle> | <numeric>

p.value

<numeric>

[1]

[2]

chr1 135926-136793

chr1 158073-158803

* |
* |

21 1.42243850010315e-20

11 7.87807089180069e-12

22

chr1chr2chr3chr7chr8chr9chr10chr11chr12chr15chr16chr17chr18chr19chr20chr21chr22chrXMACPET

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

[3]

[4]

[5]

...

[35]

[36]

[37]

[38]

[39]

chr1 172673-173381

chr1 384574-385448

chr1 406654-408186

...

...

chr9 499110-500298

chrX

chrX

chrX

chrX

1-676

2906-4106

14498-17047

16042-16702

FDR

<numeric>

* |
* |
* |
... .
* |
* |
* |
* |
* |

13 8.46824468042962e-15

23 3.50189198029452e-29

36 3.06170663244554e-41

...

...

32 6.19853263060922e-41

26 3.03823903879465e-25

30 6.03886673404633e-13

98 9.44033555038663e-46

28 1.78549928196275e-10

[1] 9.60145987569626e-20

[2] 3.6673778289417e-11

[3] 4.97049144286086e-14

[4] 3.15170278226507e-28

[5] 5.9047199340021e-40

...

...

[35] 1.04600238141531e-39

[36] 2.56351418898299e-24

[37] 3.01943336702316e-12

[38] 2.54889059860439e-44

[39] 7.53257509578036e-10

-------

seqinfo: 15 sequences from hg19 genome

3.5

TagsToGInteractions methods

PSFit class has also a method which returns only PETs belonging to peaks (removing noisy or
insigniﬁcant PETs) as a GInteractions object. This might be useful if one wishes to visualize
the tags belonging to PETs of binding sites on the genome-browser. The user can also specify
an FDR threshold for returning signiﬁcant peaks. If threshold=NULL, all the found peaks are
returned.

class(MACPET_psfitData)#PSFit class
## [1] "PSFit"
TagsToGInteractions(object=MACPET_psfitData,threshold=1e-5)
## GInteractions object with 1180 interactions and 0 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

[1]

[2]

[3]

[4]

[5]

...

[1176]

[1177]

[1178]

[1179]

seqnames1

ranges1

seqnames2

ranges2

<Rle>

<IRanges>

<Rle>

<IRanges>

chr1 135973-135992 ---

chr1 136594-136613

chr1 136081-136100 ---

chr1 136487-136506

chr1 136108-136127 ---

chr1 136317-136336

chr1 136121-136140 ---

chr1 136405-136424

chr1 136121-136140 ---

chr1 136405-136424

...

chrX

chrX

chrX

chrX

... ...

16419-16438 ---

16422-16441 ---

16423-16442 ---

16478-16497 ---

...

chrX

chrX

chrX

chrX

...

16099-16118

15920-15939

16067-16086

16112-16131

23

MACPET

##

##

##

##

[1180]

-------

chrX

16485-16504 ---

chrX

16126-16145

regions: 7548 ranges and 0 metadata columns

seqinfo: 18 sequences from hg19 genome

3.6

PeaksToNarrowPeak methods

PSFit class has a method which converts peaks of an object of PSFit class to narrowPeak
object. The object is saved in a user speciﬁed directory and can be used in the MANGO or
MICC algorithms for interaction analysis. Alternatively, the user can use stage 4 in MACPETUlt
for running the interaction analysis stage.

class(MACPET_psfitData)#PSFit class
## [1] "PSFit"
PeaksToNarrowPeak(object=MACPET_psfitData,threshold=1e-5,

## [1] "Done! Check savedir!"

file.out="MACPET_peaks.narrowPeak",savedir=SA_AnalysisDir)

3.7

ConvertToPSelf methods

This method if for the GInteractions class. It converts a GInteractions object to PSelf object.
This method could be used in case the user already has the self-ligated PETs separated from
the rest of the data and wishes to run a binding site analysis on those only using stage 3 in
MACPETUlt. The output object will be saved in the user-speciﬁed directory.

#--remove information and convert to GInteractions:
object=MACPET_pselfData
#--remove information and convert to GInteractions:

S4Vectors::metadata(object)=list(NULL)

class(object)='GInteractions'

#----input parameters
S2_BlackList=TRUE
SA_prefix="MACPET"
S2_AnalysisDir=SA_AnalysisDir

ConvertToPSelf(object=object,

S2_BlackList=S2_BlackList,
SA_prefix=SA_prefix,
S2_AnalysisDir=S2_AnalysisDir)

## Separating Self-ligated data...Done

## INFO [2018-10-30 22:18:32] Self-ligated mean length:

294

## The PSelf object is saved in:

##

/tmp/RtmpNmRKS8/MACPETtest

#load object:
rm(MACPET_pselfData)#old object
load(file.path(S2_AnalysisDir,"MACPET_pselfData"))
class(MACPET_pselfData)
## [1] "PSelf"

24

MACPET

3.8

GetSignInteractions methods

GenomeMap class has a method which subsets the signiﬁcant interactions given a user-
speciﬁed FDR threshold and returns either a GInteractions class object for the interactions
(each row corresponds to one interaction), or it saves the signiﬁcant interactions into an excel
ﬁle in a user speciﬁed directory. Metadata columns are also provided which given further
information about each interaction.

class(MACPET_GenomeMapData)#GenomeMap class
## [1] "GenomeMap"
GetSignInteractions(object=MACPET_GenomeMapData,

threshold = NULL,

ReturnedAs='GInteractions')

## No threshold given, all the interactions are returned.

## GInteractions object with 21 interactions and 6 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

[1]

[2]

[3]

[4]

[5]

...

[17]

[18]

[19]

[20]

[21]

[1]

[2]

[3]

[4]

[5]

...

[17]

[18]

[19]

[20]

[21]

[1]

[2]

[3]

[4]

[5]

...

[17]

[18]

seqnames1

ranges1

seqnames2

ranges2 | Anchor1Summit

<Rle>

<IRanges>

<Rle>

<IRanges> |

<numeric>

chr20 563447-565026 ---

chr20 905525-908110 |

chrX

-499-4606 ---

chrX

11382-17547 |

chr2 282319-283671 ---

chr2 355304-356676 |

chr3 632669-634651 ---

chr3 680567-682065 |

chr7 637535-638947 ---

chr7 690783-692499 |

...

... ...

...

... .

chr15 566320-568128 ---

chr15 578749-580144 |

chr17 985885-987476 ---

chr17 990745-992798 |

chr7 363524-368143 ---

chr7 373783-375135 |

chr7 363524-368143 ---

chr7 376355-378400 |

chr7 373783-375135 ---

chr7 376355-378400 |

564247

361

282890

633509

638268

...

567173

986528

366948

366948

374495

Anchor2Summit

<numeric>

pvalue

<numeric>

FDR

Order

<numeric> <numeric>

907011 9.26058005318194e-09 6.01937703456826e-07

15855 0.000127327838847454

0.00814898168623704

355921

0.0319658097028795

0.671282003760469

681202

0.0269894695978567

0.671282003760469

691724

0.0154904671976064

0.671282003760469

1

2

3

3

3

...

...

...

0.758560331886533

0.450415834308879

0.992157972205279

0.104457939309804

0.891787260692922

1

1

1

1

1

5

5

5

5

5

...

579414

991796

374495

377298

377298

TotalInterPETs

<numeric>

9

32

3

4

4

...

3

5

25

MACPET

##

##

##

##

##

##

[19]

[20]

[21]

-------

4

15

7

regions: 32 ranges and 0 metadata columns

seqinfo: 18 sequences from hg19 genome

3.9

GetShortestPath methods

GenomeMap class has a method which ﬁnds the length of the shortest path between two
user-speciﬁed peaks. Currently it only ﬁnds the shortest paths between intra-chromosomal
peaks. Therefore, the peaks have to be on the same chromosome. The resulting value is a
two-element list with the ﬁrst element named LinearPathLength for the linear length of the
path between summits of the two peaks, and the second element named ThreeDPathLength
for the 3D length of the shortest path between summits of the two peaks.

class(MACPET_GenomeMapData)#GenomeMap class
## [1] "GenomeMap"
GetShortestPath(object=MACPET_GenomeMapData,

threshold = NULL,

ChrFrom="chr1",

ChrTo="chr1",

SummitFrom=10000,

SummitTo=1000000)

## No threshold given, all the interactions are returned.

## $LinearPathLength

## [1] 990000

##

## $ThreeDPathLength

## [1] 511410

4

MACPET Supplementary functions

4.1

AnalysisStatistics function

AnalysisStatistics function can be used for all the classes of the MACPET package for
printing and/or saving statistics of the classes in csv ﬁle in a given working directory. Input
for Self-ligated PETs of one of the classes (PSelf , PSFit) is mandatory, while input for the
Intra- and Inter-chromosomal PETs is not.

If the input for the Self-ligated PETs is of PSFit class, a threshold can be given for the FDR
cut-oﬀ.

Here is an example:

AnalysisStatistics(x.self=MACPET_psfitData,

x.intra=MACPET_pintraData,
x.inter=MACPET_pinterData,

26

MACPET

file.out='AnalysisStats',
savedir=SA_AnalysisDir,
threshold=1e-5)

## -------------------------

##

PETs Counts Summary

## -------------------------

##

## | Chrom | Self | Regions | Peaks | Sign. Peaks | Intra | Inter |

## |:-----:|:----:|:-------:|:-----:|:-----------:|:-----:|:-----:|

## | chr1 | 469 |

## | chr2 | 235 |

## | chr3 | 247 |

## | chr7 | 451 |

## | chr8 | 130 |

## | chr9 | 215 |

## | chr10 | 133 |

## | chr11 | 41 |

## | chr12 | 174 |

## | chr15 | 268 |

## | chr16 | 169 |

## | chr17 | 267 |

## | chr18 | 258 |

## | chr19 | 189 |

## | chr20 | 528 |

## | chr21 | 100 |

## | chr22 | 203 |

## | chrX | 443 |

##

##

49

32

27

50

15

21

20

7

23

23

11

29

38

26

37

12

24

7

| 23

| 10

|

8

| 16

|

|

|

|

|

|

|

|

|

|

4

3

5

1

8

6

1

6

9

6

| 13

|

|

2

4

| 10

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

9

3

2

7

1

1

1

0

1

2

0

2

2

1

2

1

0

4

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

78

37

48

107

13

21

14

10

31

56

25

43

37

26

102

16

30

50

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

5

10

2

3

5

7

2

0

3

6

7

9

5

4

9

2

9

6

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

|

## =================== ====== ============

=========

## Self-lig. mean size Genome Self Borders

Tot. Self

## =================== ====== ============

=========

##

294

hg19

21/799 bp

4520

## =================== ====== ============

=========

##

##

## ======= ===== =========== ==========

==========

## Regions Peaks Sign. Peaks Tot. Intra

Tot. Inter

## ======= ===== =========== ==========

==========

##

451

135

39

744

94

## ======= ===== =========== ==========

==========

## [1] "The output has been saved at the savedir"

4.2

ConvertToPE_BAM function

ConvertToPE_BAM in case the user has two separate BAM ﬁles from read 1 and 2 of the paired
data, and needs to pair them in one paired-end BAM ﬁle for further analysis in stage 2-3 on
the MACPETUlt function. The output paired-end BAM ﬁle will be saved in the user-speciﬁed
directory.

27

MACPET

Here is an example:

requireNamespace('ggplot2')

#Create a temporary forder, or anywhere you want:
S1_AnalysisDir=SA_AnalysisDir

#directories of the BAM files:
BAM_file_1=system.file('extdata', 'SampleChIAPETDataRead_1.bam', package = 'MACPET')
BAM_file_2=system.file('extdata', 'SampleChIAPETDataRead_2.bam', package = 'MACPET')
SA_prefix="MACPET"

#convert to paired-end BAM:
ConvertToPE_BAM(S1_AnalysisDir=S1_AnalysisDir,
SA_prefix=SA_prefix,
S1_BAMStream=2000000,S1_image=TRUE,
S1_genome="hg19",BAM_file_1=BAM_file_1,
BAM_file_2=BAM_file_2)

for index creation...Done

## Checking inputs...OK
## Sorting SampleChIAPETDataRead_1.bam
## Creating BAM index...Done
## Sorting SampleChIAPETDataRead_2.bam
## Creating BAM index...Done
## Filtering MACPET_BAM_1_sorted.bam ...Done
## Filtering MACPET_BAM_2_sorted.bam ...Done
## Merging MACPET_usable_1_filt.bam, MACPET_usable_2_filt.bam files...Done
## Sorting MACPET_usable_merged.bam file by Qname...Done
## Pairing reads in MACPET_usable_merged.bam file...
## ||Total lines scanned: 10754(100%)|| ||Total Pairs registered: 5377(100% of the scanned lines)||

for index creation...Done

=========>Pairing statistics<========

## Total reads processed: 10754 ( 100 %)

## Total pairs registered: 5377 ( 100 % of the scanned lines)

## Saving 16 x 10 in image
## Merging bam files in MACPET_Paired_end.bam ...Done
## Deleting unnecessary files.The paired-end BAM is in:
/tmp/RtmpNmRKS8/MACPETtest/MACPET_Paired_end.bam

##

#test if the resulted BAM is paired-end:
PairedBAM=file.path(S1_AnalysisDir,paste(SA_prefix,"_Paired_end.bam",sep=""))
Rsamtools::testPairedEndBam(file = PairedBAM, index = PairedBAM)

## [1] TRUE

bamfile = Rsamtools::BamFile(file = PairedBAM,asMates = TRUE)

GenomicAlignments::readGAlignmentPairs(file = bamfile,use.names = FALSE,

with.which_label = FALSE,
strandMode = 1)

## GAlignmentPairs object with 4920 pairs, strandMode=1, and 0 metadata columns:

##

##

##

##

##

seqnames strand

<Rle> <Rle>

:

:

ranges

<IRanges>

--

--

ranges

<IRanges>

[1]

[2]

[3]

chr1

chr1

chr1

*

*

*

: 128071-128090

-- 127738-127757

: 128071-128090

-- 127738-127757

: 128071-128090

-- 127738-127757

28

MACPET

##

##

##

##

##

##

##

##

##

##

[4]

[5]

...

[4916]

[4917]

[4918]

[4919]

[4920]

-------

chr1

chr1

...

chrX

<NA>

chrX

chrX

chrX

*

*

: 134267-134286

-- 134548-134567

: 134282-134301

-- 134461-134480

... ...

... ...

...

*

*

*

*

*

:

:

:

:

:

16501-16520

--

151-170

16501-16520

-- 844134-844153

16511-16530

16512-16531

16532-16551

--

--

--

225-244

145-164

181-200

seqinfo: 25 sequences from an unspecified genome

5

Peak Calling Workﬂow

The main function which the user can use for running a paired-end data analysis is called
MACPETUlt. It consists of the ﬁve stages described in the introduction section. The user may
run the whole pipeline/analysis at once using Stages=c(0:4) or step by step using a single
stage at a time. The function supports the BiocParallel package.

For the following example we run stages 2 and 4 of the MACPETUlt only. The reason is that
for running state 1, the bowtie index is needed which is too big for downloading it here.

#give directory of the BAM file:
S2_PairedEndBAMpath=system.file('extdata', 'SampleChIAPETData.bam', package = 'MACPET')

#give prefix name:
SA_prefix="MACPET"

#parallel backhead can be created using the BiocParallel package

#parallel backhead can be created using the BiocParallel package

#requireNamespace('BiocParallel')

#snow <- BiocParallel::SnowParam(workers = 4, type = 'SOCK', progressbar=FALSE)

#BiocParallel::register(snow, default=TRUE)

# packages for plotting:

requireNamespace('ggplot2')

#-run for the whole binding site analysis:
MACPETUlt(SA_AnalysisDir=SA_AnalysisDir,

SA_stages=c(2:4),
SA_prefix=SA_prefix,
S2_PairedEndBAMpath=S2_PairedEndBAMpath,
S2_image=TRUE,
S2_BlackList=TRUE,
S3_image=TRUE,
S4_image=TRUE,
S4_FDR_peak=1)# the data is small so use all the peaks found.

## |%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|

## |-------------MACPET analysis input checking------------|

## |%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|

29

MACPET

## Common stage inputs...OK

## Stages to run: 2-3-4

## |---- Checking Stage 2 inputs ----|

## Creating BAM index...
## S2_PairedEndBAMpath bam file is paired-end file.
## Checking the bam file header for the genome....OK

## Loading PET data...

## ===========>PET statistics<==========

## Total PETs in data: 5377 ( 100 %)

## Total PCR replicates: 0 ( 0 %)

## Total Black-listed PETs: 19 ( 0.353356890459364 %)

## Total valid PETs left: 5358 ( 99.6466431095406 %)

## Saving 16 x 10 in image

## Correct Stage 2 inputs given.

## |---- Checking Stage 3 inputs ----|

## Correct Stage 3 inputs given.

## |---- Checking Stage 4 inputs ----|

## Correct Stage 4 inputs given.

## All inputs correct! Starting MACPET analysis...

## |%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|

## |--------------PET Classification Analysis--------------|

## |-----------------------Stage 2-------------------------|

## |%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|

## =====================================

## Separating Inter-chromosomal data...Done

## Finding Self-Intra cut-off...Done

## Self-ligated cut-off at: 799 bp

## Saving 16 x 10 in image

## Separating Intra-chromosomal data...Done

## Separating Self-ligated data...Done

## Self-ligated mean length: 294

## ===========>PET statistics<==========

## Total Self-ligated PETs: 4520

## Total Intra-chromosomal PETs: 744

## Total Inter-chromosomal PETs: 94

## Saving 16 x 10 in image

## =====================================

## Stage 2 is done!

## Analysis results for stage 2 are in:

##

/tmp/RtmpNmRKS8/MACPETtest/S2_results

## Total stage 2 time: 1.43521523475647

secs

## |%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|

## |----------------Binding Site Analysis------------------|

## |-----------------------Stage 3-------------------------|

## |%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|

## Converting data for analysis...Done

## Segmenting into regions...Done

## Total Regions found: 451

## Running peak calling process...Done

## Total 135 candidate peaks found in data

## Splitting data by chromosome for inference...

30

MACPET

## Computing p-values...

## FDR adjusting p-values...

## Saving 16 x 10 in image

## Saving 16 x 10 in image

## Saving 16 x 10 in image

## Saving 16 x 10 in image

## =====================================

## Stage 3 is done!

## Analysis results for stage 3 are in:

##

/tmp/RtmpNmRKS8/MACPETtest/S3_results

## Total stage 3 time: 2.68322038650513

secs

## |%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|

## |----------------Interactions Analysis------------------|

## |-----------------------Stage 4-------------------------|

## |%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|

## Minimum number of allowed interaction PETs is set to: 2

## FDR cut-off of peaks to be used in the analysis:

1

## Preparing interactions data...

## Total peaks passing the FDR cut-off: 135 ( 100 % of the total peaks )

## Extending peak intervals by 500 bp on either side.

## Merging overlapping peaks...Done

## Total peaks after merging: 121

## Including only Intra-ligated PETs in the analysis (Inter-ligated are empty)...Done

## Intersecting the PETs with the peaks...Done

## Counting PETs in the peaks...Done

## Total 21 candidate interactions will be processed

## Total 32 peaks are involved in potential interactions ( 26.4462809917355 % of the total FDR peaks )

## Total 133 PETs are involved in potential interactions ( 17.8763440860215 % of the total interaction PETs )

## Summarizing interaction information...Done

## Saving 16 x 10 in image

## |================ Network Initialization is finished =================|

## |=================== Running interactions analysis ===================|

## |---- Total interactions processed:

1

( 4.761905 %) ----|

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

|---- Total interactions processed:

2

3

4

5

6

7

8

9

10

11

12

13

14

15

16

17

18

19

( 9.52381 %) ----|

( 14.28571 %) ----|

( 19.04762 %) ----|

( 23.80952 %) ----|

( 28.57143 %) ----|

( 33.33333 %) ----|

( 38.09524 %) ----|

( 42.85714 %) ----|

( 47.61905 %) ----|

( 52.38095 %) ----|

( 57.14286 %) ----|

( 61.90476 %) ----|

( 66.66667 %) ----|

( 71.42857 %) ----|

( 76.19048 %) ----|

( 80.95238 %) ----|

( 85.71429 %) ----|

( 90.47619 %) ----|

31

MACPET

|---- Total interactions processed:

|---- Total interactions processed:

20

21

( 95.2381 %) ----|

( 100 %) ----|

## Interaction analysis completed!

## =====================================

## Total interactions processed: 21

## Total bi-products removed: 0

## Creating the GenomeMap Object...Done

## The Genome map is successfully built!

## =====================================

## Stage 4 is done!

## Analysis results for stage 4 are in:

##

/tmp/RtmpNmRKS8/MACPETtest/S4_results

## Total stage 4 time: 7.81659245491028

secs

## |%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|

## Global analysis is done!

## Global analysis time: 12.8786308765411

secs

#load results:
SelfObject=paste(SA_prefix,"_pselfData",sep="")
load(file.path(SA_AnalysisDir,"S2_results",SelfObject))
SelfObject=get(SelfObject)

class(SelfObject) # see methods for this class

## [1] "PSelf"

IntraObject=paste(SA_prefix,"_pintraData",sep="")
load(file.path(SA_AnalysisDir,"S2_results",IntraObject))
IntraObject=get(IntraObject)

class(IntraObject) # see methods for this class

## [1] "PIntra"

InterObject=paste(SA_prefix,"_pinterData",sep="")
load(file.path(SA_AnalysisDir,"S2_results",InterObject))
InterObject=get(InterObject)

class(InterObject) # see methods for this class

## [1] "PInter"

SelfFitObject=paste(SA_prefix,"_psfitData",sep="")
load(file.path(SA_AnalysisDir,"S3_results",SelfFitObject))
SelfFitObject=get(SelfFitObject)

class(SelfFitObject) # see methods for this class

## [1] "PSFit"

GenomeMapObject=paste(SA_prefix,"_GenomeMapData",sep="")
load(file.path(SA_AnalysisDir,"S4_results",GenomeMapObject))
GenomeMapObject=get(GenomeMapObject)

class(GenomeMapObject) # see methods for this class

## [1] "GenomeMap"

#-----delete test directory:
unlink(SA_AnalysisDir,recursive=TRUE)

32

MACPET

MACPETUlt saves its outputs in SA_AnalysisDir in the folders S0_results, S1_results,
S2_results, S3_results and S4_results based on the stages run. The output of MACPETUlt in
those folders is the following:

Stage 0: (output saved in a folder named S0_results in SA_AnalysisDir)

• SA_preﬁx_usable_1.fastq.gz: fastq.gz ﬁles with the usable 5-end tags. To be used in

Stage 1.

• SA_preﬁx_usable_2.fastq.gz: fastq.gz ﬁles with the usable 3-end tags. To be used in

Stage 1.

• SA_preﬁx_chimeric_1.fastq.gz: fastq.gz ﬁles with the chimeric 5-end tags.
• SA_preﬁx_chimeric_2.fastq.gz: fastq.gz ﬁles with the chimeric 3-end tags.
• SA_preﬁx_ambiguous_1.fastq.gz: fastq.gz ﬁles with the ambiguous 5-end tags.
• SA_preﬁx_ambiguous_2.fastq.gz: fastq.gz ﬁles with the ambiguous 3-end tags.
• SA_preﬁx_stage_0_image.jpg: Pie chart image with the split of two fastq ﬁles used as

input (if S0_image==TRUE)

Stage 1: (output saved in a folder named S1_results in SA_AnalysisDir)

• SA_preﬁx_usable_1.sam: sam ﬁle with the mapped 5-end reads (if S1_rmSam==FALSE).
• SA_preﬁx_usable_2.sam: sam ﬁle with the mapped 3-end reads (if S1_rmSam==FALSE).
• SA_preﬁx_Paired_end.bam: paired-end bam ﬁle with the mapped PETs. To be used

in Stage 2

• SA_preﬁx_Paired_end.bam.bai: .bai paired-end bam ﬁle with the mapped PETs. To

be used in Stage 2

• SA_preﬁx_stage_1_p1_image.jpg: Pie-chart for the mapped/unmapped reads from
SA_preﬁx_usable_1.sam and SA_preﬁx_usable_2.sam (if S1_image==TRUE).
• SA_preﬁx_stage_1_p2_image.jpg: Pie-chart for the paired/unpaired reads of

SA_preﬁx_Paired_end.bam (if S1_image==TRUE).

Stage 2: (output saved in a folder named S2_results in SA_AnalysisDir)

• SA_preﬁx_pselfData: An object of PSelf class, containing the self-ligated PETs. To

be used in Stage 3.

• SA_preﬁx_pintraData: An object of PIntra class, containing the intra-chromosomal

PETs.

• SA_preﬁx_pinterData: An object of PInter class, containing the inter-chromosomal

PETs.

• SA_preﬁx_stage_2_p1_image.jpg: Pie-chart reliable/duplicated/black-listed PETs of

SA_preﬁx_Paired_end.bam (if S2_image==TRUE).

• SA_preﬁx_stage_2_p2_image.jpg: Histogram with the self-ligated/intra-chromosomal

cut-oﬀ of SA_preﬁx_Paired_end.bam (if S2_image==TRUE).

• SA_preﬁx_stage_2_p3_image.jpg: Pie-chart for the self-ligated/intra-chromosomal/inter-

chromosomal PETs of SA_preﬁx_Paired_end.bam (if S2_image==TRUE).

Stage 3: (output saved in a folder named S3_results in SA_AnalysisDir)

• SA_preﬁx_psﬁtData: An object of PSFit class. This object contains peaks found by

the peak-calling algorithm along with their p-values and FDR.

• SA_preﬁx_stage_3_p1_image.jpg: Sizes of the upstream vs downstream peaks of each

binding site given the binding site’s FDR (if S3_image==TRUE).

• SA_preﬁx_stage_3_p2_image.jpg: FDR of the binding sites. The horizontal red line is

at FDR=0.05 (if S3_image==TRUE).

• SA_preﬁx_stage_3_p3_image.jpg: Comparison of binding site sizes given their FDR

(if S3_image==TRUE).

33

MACPET

• SA_preﬁx_stage_3_p4_image.jpg: FDR for the upstream/donwstream peaks of the

binding sites given the binding sites FDR (if S3_image==TRUE).

Stage 4: (output saved in a folder named S4_results in SA_AnalysisDir)

• SA_preﬁx_GenomeMapData: An object of GenomeMap class. This object contains all

the interactions found in the data.

• SA_preﬁx_stage_4_p1_image.jpg: Pie charts for the total number of peaks used
in the interaction analysis as well as the total number of interaction PETs used (if
S4_image==TRUE).

Stages 0:4:

• All the above outputs in separate folders.

Furthermore a log-ﬁle named SA_preﬁx_analysis.log with the progress of the analysis is also
saved in the SA_AnalysisDir.

Vardaxis, Ioannis, Finn Drabløs, Morten Rye, and Bo Henry Lindqvist. “MACPET Model-Based
Analysis for ChIA-PET.” To Be Published.

34

