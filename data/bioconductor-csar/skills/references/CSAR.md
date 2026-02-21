An Introduction to the CSAR Package

Jose M Muino∗

October 29, 2025

Applied Bioinformatics
Plant Research International, Wageningen UR
Wageningen, The Netherlands

1

Introduction

We present here a R package for the statistical detection of protein-bound ge-
nomic regions, where, considering the average DNA fragment size submitted
to sequencing, single-nucleotide enrichment values are obtained. After normal-
ization, sample and control are compared using a test based on the Poisson
distribution. Test statistic thresholds to control false discovery rate are ob-
tained through random permutation. The computational efficiency is achieved
implanting the most time-consuming functions in C++ language, and integrat-
ing them in the R package. Standard outputs of the package are tables of
genomic coordinates of significantly enriched region locations, level of enrich-
ment per nucleotide position and the distance of enriched regions to annotated
genomic features. The algorithm is described in detail in [1], [2], [3].

2 Methods

Due to PCR artifacts a high number of reads can represent the same sequence.
The elimination of these duplicated reads usually leads to a 15%-25% data re-
duction in a standard plant ChIP-seq experiment. This artifact is strand depen-
dent, therefore CSAR requests that the number of extended reads that overlap
a given nucleotide position should be supported by both strands independently.
This is achieved by virtually extending the mapped reads to a length of 300 bp
(the average DNA fragment length submitted to the sequence process) for each
strand independently, and after taken the minimum value for both strand at
each nucleotide position.

Before test enrichment between sample and control, the number of over-
lapped reads distribution of the sample is normalize to have the same mean and

∗jose.muino@wur.nl

1

variance that the control.. Subsequently, a score enrichment is calculated based
on the Poisson test or in the ratio.

Permutation is applied to calculate the FDR thresholds. The mapped reads
are randomly permutated between the control and sample group, and new scores
are calculated for this new permutated dataset. The procedure is repeated until
have a enough number of permutated scores. This scores are used to calculate
the FDR thresholds.

3 Example

We will use a dataset included in the CSAR package for this demonstration. The
data represent a small subset of a SEP3 ChIP-seq experiment in Arabidopsis
[1].

First, we load the CSAR package and the data CSAR-dataset. We use the
mappedReads2Nhits function to calculate the number of hits (number of ex-
tended reads that overlap a particular position) per nucleotide position for the
control and sample dataset. The results for each chromosome are saved in a file
with the name of the chromosome and the tag used in the parameter file See
function mappedReads2Nhits for more information about the parameter values.

R> library(CSAR)
R> data("CSAR-dataset");
R> head(sampleSEP3_test)

Nhits lengthRead strand

1
2
3
4
5
6

1
1
1
1
1
1

34
34
34
34
34
34

chr

pos
- CHR1v01212004 20729
- CHR1v01212004 62752
+ CHR1v01212004
8248
+ CHR1v01212004 48961
8248
+ CHR1v01212004
- CHR1v01212004 55621

R> head(controlSEP3_test)

Nhits lengthRead strand

1
2
3
4
5
6

1
1
1
1
1
1

35
35
35
35
35
35

pos
chr
- CHR1v01212004
5714
+ CHR1v01212004 39819
- CHR1v01212004 34149
+ CHR1v01212004 22988
- CHR1v01212004 83202
- CHR1v01212004 56583

R> nhitsS<-mappedReads2Nhits(sampleSEP3_test,file="sampleSEP3_test",chr=c("CHR1v01212004"),chrL=c(10000))
R> nhitsC<-mappedReads2Nhits(controlSEP3_test,file="controlSEP3_test",chr=c("CHR1v01212004"),chrL=c(10000))
R> nhitsC$filenames

[1] "CHR1v01212004_controlSEP3_test.CSARNhits"

2

R> nhitsS$filenames

[1] "CHR1v01212004_sampleSEP3_test.CSARNhits"

The variable nhitsC and nhitsS will have the needed information to use with
the function ChIPseqScore in order to calculate the read-enrichment score of
the sample compared to the control for each nucleotide position. The results
are saved in one file per each chromosome.
sigWin will generate candidate
read-enriched regions, and score2wig will generate a wig file that can be read
by standard genome browsers. distance2Genes function will report the relative
position of candidate read-enriched regions regarding the start and end posi-
tion of the annotated genes. genesWithPeaks function will report genes with a
candidate enriched region located near them.

R> test<-ChIPseqScore(control=nhitsC,sample=nhitsS,file="test",times=10000)
R> test$filenames

[1] "CHR1v01212004_test.CSARScore"

R> win<-sigWin(test)
R> head(win)

GRanges object with 6 ranges and 2 metadata columns:

posPeak

seqnames

ranges strand |

score
<Rle> <IRanges> <Rle> | <numeric> <numeric>
180343
* |
536943
* |
180343
* |
180343
* |
1071844
* |
180343
* |

1-31
[1] CHR1v01212004
332-516
[2] CHR1v01212004
[3] CHR1v01212004 974-1259
[4] CHR1v01212004 1368-1453
[5] CHR1v01212004 1747-4525
[6] CHR1v01212004 4842-5004
-------
seqinfo: 1 sequence from an unspecified genome

1
332
974
1368
2831
4842

R> score2wig(test,file="test.wig",times=10000)
R> d<-distance2Genes(win=win,gff=TAIR8_genes_test)
R> d

p1

p2

gene

score

peakName

le
CHR1v01212004_974 -2657 -4925 180342.6 AT1G01010 2268
180342.6 AT1G01010 2268
-800 -3068 1071844.4 AT1G01010 2268
1211 -1057 180342.6 AT1G01010 2268
-791 180342.6 AT1G01010 2268
1477
180342.6 AT1G01010 2268
2777
180342.6 AT1G01020 1947
2329
358643.0 AT1G01010 2268
3207

CHR1v01212004_1368 -2263 -4531
CHR1v01212004_2831
CHR1v01212004_4842
CHR1v01212004_5108
CHR1v01212004_6408
CHR1v01212004_6408
CHR1v01212004_6838

509
382
939

1
2
3
4
5
6
7
8

3

CHR1v01212004_6838
9
10 CHR1v01212004_7422
11 CHR1v01212004_8547
12 CHR1v01212004_8972

1899
1315

-48 358643.0 AT1G01020 1947
-632 180342.6 AT1G01020 1947
190 -1757 4281250.8 AT1G01020 1947
180342.6 AT1G01020 1947

-235 -2182

R> genes<-genesWithPeaks(d)
R> head(genes)

name max3kb1kb

u3000 u2000

1071844 180342.6
0.0
4281251

1 AT1G01010
2 AT1G01020

d1000
1 358643.0
2 180342.6

u1000

d0
0 1071844.4 180342.6
0 180342.6 4281250.8

With each run of the function permutatedWinScores one set of permutated
scores is generated. Later, we can get the distribution of score values with the
function getPermutatedWinScores. From this distribution, several cut-off values
can be calculated to control the error of our test using functions implemented
in R. In this package, it is implemented a control of the error based on FDR
using the function getThreshold .

R> permutatedWinScores(nn=1,sample=sampleSEP3_test,control=controlSEP3_test,fileOutput="test",chr=c("CHR1v01212004"),chrL=c(100000))
R> permutatedWinScores(nn=2,sample=sampleSEP3_test,control=controlSEP3_test,fileOutput="test",chr=c("CHR1v01212004"),chrL=c(100000))
R> nulldist<-getPermutatedWinScores(file="test",nn=1:2)
R> getThreshold(winscores=values(win)$score,permutatedScores=nulldist,FDR=.05)

threshold Error_type_I

FDR
0.0418251 0.0418251

22

110538.1

This is a very simple function to obtain the threshold value of our test statistic
controlling FDR at a desired level. Basically, for each possible threshold value,
the proportion of error type I is calculated assuming that the permutated score
distribution is a optimal estimation of the score distribution under the null
hypothesis, and FDR is obtained as the ratio of the proportion of error type I
by the proportion of significant tests. Other functions implemented in R (eg:
multtest ) could be less conservative.

References

[1] Kerstin Kaufmann, Jose M Muino, Ruy Jauregui, Chiara A Airoldi, Cezary
Smaczniak, Pawel Krajewski, and Gerco C Angenent. Target genes of the
mads transcription factor sepallata3: Integration of developmental and hor-
monal pathways in the arabidopsis flower. PLoS Biol, 7(4):e1000090, 04
2009.

4

[2] Kerstin Kaufmann, Jose M Muino, Magne Osteras, Laurent Farinelli, Pawel
Krajewski, and Gerco C Angenent. Chromatin immunoprecipitation (chip)
of plant transcription factors followed by sequencing (chip-seq) or hybridiza-
tion to whole genome arrays (chip-chip). Nature Protocols, (2010).

[3] Jose M Muino, Kerstin Kaufmann, Roeland C van Ham, Gerco C Angenent,
and P Krajewski. Plant chip-seq analyzer: An r package for the statistical
detection of protein-bound genomic regions. (2011).

4 Details

This document was written using:

R> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4
[6] datasets methods

stats

graphics
base

grDevices utils

other attached packages:
[1] CSAR_1.62.0
[3] Seqinfo_1.0.0
[5] S4Vectors_0.48.0
[7] generics_0.1.4

GenomicRanges_1.62.0
IRanges_2.44.0
BiocGenerics_0.56.0

loaded via a namespace (and not attached):
[1] compiler_4.5.1 tools_4.5.1

5

