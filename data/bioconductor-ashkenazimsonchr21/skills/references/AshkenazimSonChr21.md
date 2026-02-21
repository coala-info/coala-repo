AshkenazimSonChr21: Annotated variants on the
chromosome 21, human genome 19, Ashkenazim
Trio son sample

Tomasz Stokowy

October 30, 2025

Introduction

This vignette describes AshkenazimSonChr21 dataset, example input for RareVari-
antVis package. This dataset is CompleteGenomics whole genome sequencing
dataset, coming from Stanford Genome in a Bottle Consortium. This dataset
was made fully available for public, without restrictions. This particular data
refer to sample HG002- NA24385 - huAA53E0 (son). Original data can be found
at: https://sites.stanford.edu/abms/content/giab-reference-materials-and-data

Preprocessing

Original whole genome sequencing sample was (HG002-son) was too big for pur-
pose of R/Bioconductor test data, therefore only chromosome 21 variants were
slected. Complete Genomics output provides 3 types of variants: homozygous
reference, heterozygous and homozygous alternative. To minimize data size and
make it similar to Illumina X Ten output homozygous reference were excluded.
Finally, small indels were filtered out, since they introduced a lot of noise into
visualization. This noise was not observed in Illumina X Ten samples that we
analyzed in our laboratory.

Possible usage of data

Data aims to work well with RareVariantVis package, however it can be used also
in other packages that aim for whole genome sequencing data analysis. Dataset
includes two types of files: txt file with rare variants and vcf file obtained from
sequencing, very similar to one from Illumina X Ten output. Examples of data
usage and file structure are listed below.

## text file
library(AshkenazimSonChr21)
head(SonVariantsChr21)

##
## 1

Chromosome Start.position End.position Reference Variant Quality.by.Depth
313.61

9411318

9411318

chr21

C

T

1

G
T
T
C
T

C
C
G
T
G

9411327
9411410
9411500
9411602
9411609

9411327
720.44
9411410
1128.86
9411500
1241.14
9411602
615.72
603.02
9411609
SNP.id SNP.Frequency Gene.name Gene.component phyloP DP
-0.177 38
-0.307 37
0.717 49
0.717 62
0.624 57
-0.163 56

-1
-1
-1
-1
-1
-1

Variant.type

chr21
chr21
chr21
chr21
chr21

## 2
## 3
## 4
## 5
## 6
##
## 1 Substitution rs373567667
rs75025155
## 2 Substitution
rs78200054
## 3 Substitution
## 4 Substitution
rs71235073
## 5 Substitution rs368646645
## 6 Substitution
rs76676778
AD GT
##
## 1 25,13 0/1
## 2 13,24 0/1
## 3 15,34 0/1
## 4 24,38 0/1
## 5 35,22 0/1
## 6 35,21 0/1

## vcf file
library(VariantAnnotation)

’BiocGenerics’

IQR, mad, sd, var, xtabs

BiocGenerics
generics

as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
setequal, union

## Loading required package:
## Loading required package:
##
## Attaching package:
’generics’
## The following objects are masked from ’package:base’:
##
##
##
##
## Attaching package:
## The following objects are masked from ’package:stats’:
##
##
## The following objects are masked from ’package:base’:
##
##
##
##
##
##
##
## Loading required package:
## Loading required package:
##
## Attaching package:
’MatrixGenerics’
## The following objects are masked from ’package:matrixStats’:
##

Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
as.data.frame, basename, cbind, colnames, dirname, do.call,
duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
unsplit, which.max, which.min

MatrixGenerics
matrixStats

2

findMatches

’S4Vectors’

Seqinfo
GenomicRanges
stats4
S4Vectors

colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
colWeightedMeans, colWeightedMedians, colWeightedSds,
colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
rowWeightedSds, rowWeightedVars

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
## Loading required package:
## Loading required package:
## Loading required package:
## Loading required package:
##
## Attaching package:
## The following object is masked from ’package:utils’:
##
##
## The following objects are masked from ’package:base’:
##
##
## Loading required package:
## Loading required package:
## Loading required package:
## Welcome to Bioconductor
##
##
##
##
##
## Attaching package:
## The following object is masked from ’package:MatrixGenerics’:
##
##
## The following objects are masked from ’package:matrixStats’:
##
##
## Loading required package:
## Loading required package:
## Loading required package:
##
## Attaching package:

Vignettes contain introductory material; view with
’browseVignettes()’.
’citation("Biobase")’, and for packages ’citation("pkgname")’.

IRanges
SummarizedExperiment
Biobase

Rsamtools
Biostrings
XVector

To cite Bioconductor, see

I, expand.grid, unname

anyMissing, rowMedians

’Biostrings’

rowMedians

’Biobase’

3

strsplit

## The following object is masked from ’package:base’:
##
##
##
## Attaching package:
## The following object is masked from ’package:base’:
##
##

’VariantAnnotation’

tabulate

fl <- system.file("extdata", "SonVariantsChr21.vcf.gz",

package="AshkenazimSonChr21")

vcf <- readVcf(fl, genome="hg19")
geno(vcf)

## List of length 8
## names(8): GT GQX AD DP GQ MQ PL VF

info(vcf)

QD BLOCKAVG_min30p3a
<logical>
FALSE
FALSE
FALSE
FALSE
FALSE
...
FALSE
FALSE
FALSE
FALSE
FALSE

DP

AF

AN

BaseQRankSum

1
1
1
1
1
...
1
1
1
1
1

38
37
49
62
57
...
101
113
115
155
169

2
2
2
2
2
...
2
2
2
2
2

0.50
0.50
0.50
0.50
0.50
...
0.50
0.50
0.50
0.50
0.50

<IntegerList> <character> <integer> <integer> <numeric>
8.25
19.47
23.04
20.02
10.80
...
2.04
2.12
2.01
0.14
0.02

## DataFrame with 94527 rows and 35 columns
##
AC
##
## 1
## 2
## 3
## 4
## 5
## ...
## 94523
## 94524
## 94525
## 94526
## 94527
##
##
## 1
## 2
## 3
## 4
## 5
## ...
## 94523
## 94524
## 94525
## 94526
## 94527
##
##
## 1
## 2

HRun
<numeric> <logical> <numeric> <integer> <numeric> <integer>
0
1
1
0
0
...
1
1
1
0
3

0.000
1.443
11.788
1.005
0.000
...
0.000
0.000
0.000
6.160
2.884
MQ0 MQRankSum
<numeric> <numeric> <integer> <numeric>
-0.031
0.016

-0.923
-0.334
-0.683
1.395
-1.436
...
1.834
2.439
1.499
1.670
1.448

FALSE
FALSE
FALSE
FALSE
FALSE
...
FALSE
FALSE
FALSE
FALSE
FALSE

0
0
0
0
0
...
0.01
0.06
0.01
0.00
0.01

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

<numeric>
1.9783
0.9995

HaplotypeScore InbreedingCoeff

51
52

NA
NA

Dels

END

0
0

DS

FS

MQ

4

## 3
## 4
## 5
## ...
## 94523
## 94524
## 94525
## 94526
## 94527
##
##
## 1
## 2
## 3
## 4
## 5
## ...
## 94523
## 94524
## 94525
## 94526
## 94527
##
##
## 1
## 2
## 3
## 4
## 5
## ...
## 94523
## 94524
## 94525
## 94526
## 94527
##
##
## 1
## 2
## 3
## 4
## 5
## ...
## 94523
## 94524
## 94525
## 94526
## 94527
##

0.8667
0.0000
0.0000
...
128.037
205.879
250.594
184.049
195.051
ReadPosRankSum

NA
NA
NA
...
NA
NA
NA
NA
NA
VQSLOD
<numeric> <numeric> <numeric>
2.0206
4.3216
2.9995
2.1560
2.1432
...

SB

-0.154
0.970
-0.011
-1.192
0.276
...
-0.805
-1.330
-0.590
3.132
2.138

-55.94
-261.36
-414.78
-535.11
-178.59
...
-88.65
-89.77
-110.60
-0.01
-0.01

50
52
53
...
25
24
22
19
18

0
0
6
...
3
4
5
37
56

-0.597
1.322
0.086
...
-3.844
-1.997
-3.745
-1.952
-1.775

culprit
<character>

set
<character>
QD FilteredInAll
variant
MQ
MQ FilteredInAll
MQ FilteredInAll
QD FilteredInAll
...
-27.4198 HaplotypeScore FilteredInAll
-60.7511 HaplotypeScore FilteredInAll
-89.2046 HaplotypeScore FilteredInAll
DP FilteredInAll
-63.3093
DP FilteredInAll
-70.4434

...

CSQT
<CharacterList>

GMAF
<CharacterList> <character> <CharacterList>

CSQR

AA

...

...
ENSR00000684572|regu..
ENSR00000684572|regu..
ENSR00000684572|regu..
ENSR00000684572|regu..
ENSR00000684572|regu..

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
clinvar phastCons

...

EVS

cosmic

Variant.type
<CharacterList> <CharacterList> <CharacterList> <logical> <CharacterList>
Substitution
Substitution
Substitution
Substitution
Substitution
...
Substitution
Substitution
Substitution
Substitution
Substitution

FALSE
FALSE
FALSE
FALSE
FALSE
...
FALSE
FALSE
FALSE
FALSE
FALSE

...

...

...

Gene.name

Gene.component

phyloP SNP.Frequency

5

##
## 1
## 2
## 3
## 4
## 5
## ...
## 94523
## 94524
## 94525
## 94526
## 94527

<CharacterList> <CharacterList> <numeric>
-0.177
-0.307
0.717
0.717
0.624
...
-100
-100
-100
-100
-100

...

...

<numeric>
-1
-1
-1
-1
-1
...
-1
-1
-1
-1
-1

6

