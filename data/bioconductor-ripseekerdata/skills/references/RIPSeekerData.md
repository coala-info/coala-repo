RIP-seq datasets for testing RIPSeeker package

Yue Li
yueli@cs.toronto.edu

November 1, 2018

1 PRC2 Datasets

The RIP-seq data from Zhao et al. [2010] for Ezh2 (a PRC2 unique subunit) in mouse
embryonic stem cell (mESC) were downloaded from Gene Expression Omnibus (GEO)
(GSE17064). Brieﬂy, there are in total ﬁve datasets. Two datasets correspond to the
non-speciﬁc and speciﬁc negative controls using the antibody IgG and mutant mESC
depleted of Ezh2 (Ezh2 -/-) (MT), respectively. Only the speciﬁc negative control is
used in our test. The two and one remaining datasets correspond to the libraries con-
structed from two biological replicates of the wild type mESC. Notably, the library con-
struction and strand-speciﬁc sequencing generated sequences from the opposite strand
of the PRC2-bound RNA Zhao et al. [2010], consequently, each read was treated as if
it were reverse complemented. After the quality control (QC) and alignments (?? and
?? in Supplementary Data), the technical replicates were merged, resulting in three test
ﬁles - RIP-biorep1, RIP-biorep2, and CTL with 1,022,474, 442,030, and 208,445 reads
mapped to unique loci of the mouse reference genome (mm9 build) (Table ??).

recursive=TRUE, full.names=TRUE)

> library(RIPSeeker)
> extdata.dir <- system.file("extdata", package="RIPSeekerData")
> bamFiles <- list.files(extdata.dir, "\\.bam$",
+
> bamFiles.PRC2 <- grep("PRC2/", bamFiles, value=TRUE)
> # import, process, and convert BAM data to GappedAlignments object
> # using function combineAlignGals
>
> # PRC2
> PRC2.rip <- grep(pattern="SRR039214", bamFiles.PRC2, value=TRUE, invert=TRUE)
> PRC2.rip.biorep1 <- PRC2.rip[grep(pattern="SRR039213", PRC2.rip, invert=TRUE)]
> PRC2.rip.biorep2 <- PRC2.rip[grep(pattern="SRR039213", PRC2.rip, invert=FALSE)]
> PRC2.ctl <- grep(pattern="SRR039214", bamFiles, value=TRUE, invert=FALSE)
> ripGal.PRC2.rip.biorep1 <- combineAlignGals(PRC2.rip.biorep1,
+
> ripGal.PRC2.rip.biorep2 <- combineAlignGals(PRC2.rip.biorep2,
+
> ripGal.PRC2.ctl <- combineAlignGals(PRC2.ctl,
+
> ripGal.PRC2.rip.biorep1

reverseComplement=TRUE, genomeBuild="mm9")

reverseComplement=TRUE, genomeBuild="mm9")

reverseComplement=TRUE, genomeBuild="mm9")

GAlignments object with 1022474 alignments and 1 metadata column:

seqnames strand

cigar

qwidth

start

end

1

<Rle> <character> <integer> <integer> <integer>
3038931
3043102
3043102
3044677
3044693
...
2851707
2854129
2865354
2870128
2888313

3038896
3043067
3043067
3044642
3044658
...
2851672
2854110
2865319
2870093
2888278

36M
36M
36M
36M
36M
...
36M
20M
36M
36M
36M

36
36
36
36
36
...
36
20
36
36
36

SRR039210.2697764
SRR039210.4759331
SRR039210.5363123
SRR039210.4785683
SRR039210.5440116
...
SRR039212.2286434
SRR039212.5775845
SRR039212.2698603
SRR039212.1732007
SRR039212.6081906

<Rle>
chr1
chr1
chr1
chr1
chr1
...
chrY
chrY
chrY
chrY
chrY
width

+
-
+
+
+
...
+
+
+
+
+
njunc | uniqueHit
<integer> <integer> | <logical>
TRUE
TRUE
FALSE
TRUE
TRUE
...
TRUE
TRUE
FALSE
FALSE
TRUE

0 |
0 |
0 |
0 |
0 |
... .
0 |
0 |
0 |
0 |
0 |

SRR039210.2697764
SRR039210.4759331
SRR039210.5363123
SRR039210.4785683
SRR039210.5440116
...
SRR039212.2286434
SRR039212.5775845
SRR039212.2698603
SRR039212.1732007
SRR039212.6081906
-------
seqinfo: 22 sequences from mm9 genome

36
36
36
36
36
...
36
20
36
36
36

> ripGal.PRC2.rip.biorep2

GAlignments object with 442030 alignments and 1 metadata column:

SRR039213.2654515
SRR039213.1340316
SRR039213.5984066
SRR039213.1775423
SRR039213.1617846
...
SRR039213.4441161
SRR039213.4469893
SRR039213.1027267
SRR039213.5937961
SRR039213.5666673

SRR039213.2654515
SRR039213.1340316
SRR039213.5984066
SRR039213.1775423

start

cigar

seqnames strand

<Rle>
chr1
chr1
chr1
chr1
chr1
...
chrY
chrY
chrY
chrY
chrY
width

end
qwidth
<Rle> <character> <integer> <integer> <integer>
3044625
3101921
3165220
3204841
3226872
...
2623715
2681900
2787451
2854129
2860495

3044590
3101886
3165185
3204806
3226837
...
2623680
2681865
2787416
2854110
2860460

-
+
+
+
+
...
+
+
-
+
+
njunc | uniqueHit
<integer> <integer> | <logical>
FALSE
FALSE
TRUE
TRUE

36M
36M
36M
36M
36M
...
36M
36M
36M
20M
36M

36
36
36
36
36
...
36
36
36
20
36

0 |
0 |
0 |
0 |

36
36
36
36

2

SRR039213.1617846
...
SRR039213.4441161
SRR039213.4469893
SRR039213.1027267
SRR039213.5937961
SRR039213.5666673
-------
seqinfo: 22 sequences from mm9 genome

36
...
36
36
36
20
36

0 |
... .
0 |
0 |
0 |
0 |
0 |

TRUE
...
FALSE
FALSE
FALSE
TRUE
FALSE

> ripGal.PRC2.ctl

GAlignments object with 208445 alignments and 1 metadata column:

SRR039214.3256146
SRR039214.4450026
SRR039214.4200528
SRR039214.4467447
SRR039214.3463161
...
SRR039214.5888680
SRR039214.2883579
SRR039214.2387301
SRR039214.435163
SRR039214.2969488

start

cigar

end
qwidth
<Rle> <character> <integer> <integer> <integer>
3062113
3095104
3095105
3161687
3180346
...
2606375
2611753
2648281
2779447
2854129

3062094
3095085
3095086
3161652
3180311
...
2606354
2611734
2648262
2779415
2854110

20M
20M
20M
36M
36M
...
22M
20M
20M
33M
20M

20
20
20
36
36
...
22
20
20
33
20

seqnames strand

<Rle>
chr1
chr1
chr1
chr1
chr1
...
chrY
chrY
chrY
chrY
chrY
width

+
-
-
-
-
...
-
+
-
+
+
njunc | uniqueHit
<integer> <integer> | <logical>
FALSE
FALSE
FALSE
TRUE
FALSE
...
FALSE
FALSE
FALSE
FALSE
FALSE

0 |
0 |
0 |
0 |
0 |
... .
0 |
0 |
0 |
0 |
0 |

SRR039214.3256146
SRR039214.4450026
SRR039214.4200528
SRR039214.4467447
SRR039214.3463161
...
SRR039214.5888680
SRR039214.2883579
SRR039214.2387301
SRR039214.435163
SRR039214.2969488
-------
seqinfo: 22 sequences from mm9 genome

20
20
20
36
36
...
22
20
20
33
20

2 CCNT1 Datasets

The data for CCNT1 were generated from two RIP-seq experiments. The pilot exper-
iment generated 775,582 and 773,785 strand-speciﬁc raw reads, and 5,853 and 4,556
uniquely mapped read remain after the stringent QC for the CCNT1 and GFP con-
trol RIP RNA libraries, respectively. Same as in the PRC2 data, the reads came from
the second strand of the cDNA synthesis opposite to the original RNA strand. The
non-strand-speciﬁc library from the second screen has deeper coverage with 1,647,641

3

and 2,369,271 raw reads, and 26,859 and 45,024 uniquely aligned reads under QC for
CCNT1 and GFP, respectively (Table ??). Since the two experiments were performed
with slightly different protocols, we treated them as two separate biological replicates
for the following analyses.

recursive=TRUE, full.names=TRUE)

> library(RIPSeeker)
> extdata.dir <- system.file("extdata", package="RIPSeekerData")
> bamFiles <- list.files(extdata.dir, "\\.bam$",
+
> bamFiles.CCNT1 <- grep("CCNT1/", bamFiles, value=TRUE)
> # import, process, and convert BAM data to GappedAlignments object
> # using function combineAlignGals
>
> CCNT1.rip <- grep(pattern="humanCCNT1", bamFiles.CCNT1, value=TRUE, invert=TRUE)
> CCNT1.ctl <- grep(pattern="humanGFP", bamFiles.CCNT1, value=TRUE, invert=TRUE)
> ripGal.CCNT1.rip <- combineAlignGals(CCNT1.rip,
+
> ripGal.CCNT1.ctl <- combineAlignGals(CCNT1.ctl,
+
> ripGal.CCNT1.rip

reverseComplement=TRUE, genomeBuild="hg19")

reverseComplement=TRUE, genomeBuild="hg19")

GAlignments object with 10409 alignments and 1 metadata column:
seqnames strand

5:2106:4142:3430:Y
5:2108:3248:41912:Y
5:1103:12850:21621:Y
5:1203:17240:152389:Y
5:2202:17340:164011:Y
...
5:2204:14312:62539:Y
5:2103:1434:12137:Y
5:2105:15255:188637:Y
5:2205:10179:8240:Y
5:2203:8878:67831:Y

5:2106:4142:3430:Y
5:2108:3248:41912:Y
5:1103:12850:21621:Y
5:1203:17240:152389:Y
5:2202:17340:164011:Y
...
5:2204:14312:62539:Y
5:2103:1434:12137:Y
5:2105:15255:188637:Y
5:2205:10179:8240:Y
5:2203:8878:67831:Y

cigar

qwidth

21
22
20
21
21
...
20
22
20
21
20

<Rle>
chr1
chr1
chr1
chr1
chr1
...
chrY
chrY
chrY
chrY
chrY

+
-
+
+
+
...
+
+
+
+
-
width

start
<Rle> <character> <integer> <integer>
918006
1101224
1186368
1186368
1201404
...
58994694
58995993
58995993
58995993
59128396

21M
22M
20M
21M
21M
...
20M
22M
20M
21M
20M
njunc | uniqueHit
<integer> <integer> <integer> | <logical>
FALSE
FALSE
FALSE
FALSE
FALSE
...
FALSE
TRUE
FALSE
FALSE
FALSE

918026
1101245
1186387
1186388
1201424
...
58994713
58996014
58996012
58996013
59128415

0 |
0 |
0 |
0 |
0 |
... .
0 |
0 |
0 |
0 |
0 |

21
22
20
21
21
...
20
22
20
21
20

end

-------
seqinfo: 25 sequences from hg19 genome

4

> ripGal.CCNT1.ctl

GAlignments object with 5853 alignments and 1 metadata column:
seqnames strand

5:2106:4142:3430:Y
5:2108:3248:41912:Y
5:1103:12850:21621:Y
5:1203:17240:152389:Y
5:2202:17340:164011:Y
...
5:1105:18196:33270:Y
5:2108:3344:10035:Y
5:1103:9654:115236:Y
5:1105:17962:142486:Y
5:2208:14704:146696:Y

cigar

qwidth

21
22
20
21
21
...
20
20
22
21
20

<Rle>
chr1
chr1
chr1
chr1
chr1
...
chrY
chrY
chrY
chrY
chrY

+
-
+
+
+
...
-
-
-
-
-
width

start
<Rle> <character> <integer> <integer>
918006
1101224
1186368
1186368
1201404
...
59128396
59128397
59342111
59342112
59342113

21M
22M
20M
21M
21M
...
20M
20M
22M
21M
20M
njunc | uniqueHit
<integer> <integer> <integer> | <logical>
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

0 |
0 |
0 |
0 |
0 |
... .
0 |
0 |
0 |
0 |
0 |

21
22
20
21
21
...
20
20
22
21
20

end

5:2106:4142:3430:Y
5:2108:3248:41912:Y
5:1103:12850:21621:Y
5:1203:17240:152389:Y
5:2202:17340:164011:Y
...
5:1105:18196:33270:Y
5:2108:3344:10035:Y
5:1103:9654:115236:Y
5:1105:17962:142486:Y
5:2208:14704:146696:Y
-------
seqinfo: 25 sequences from hg19 genome

918026
1101245
1186387
1186388
1201424
...
59128415
59128416
59342132
59342132
59342132

3 Session Info

> sessionInfo()

R version 3.5.1 Patched (2018-07-12 r74967)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

5

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] parallel stats4
[8] methods

base

other attached packages:

stats

graphics

grDevices utils

datasets

[1] RIPSeeker_1.22.0
[3] GenomicAlignments_1.18.0
[5] Biostrings_2.50.0
[7] SummarizedExperiment_1.12.0 DelayedArray_0.8.0
matrixStats_0.54.0
[9] BiocParallel_1.16.0
GenomicRanges_1.34.0
IRanges_2.16.0
BiocGenerics_0.28.0

[11] Biobase_2.42.0
[13] GenomeInfoDb_1.18.0
[15] S4Vectors_0.20.0

rtracklayer_1.42.0
Rsamtools_1.34.0
XVector_0.22.0

loaded via a namespace (and not attached):

[1] zlibbioc_1.28.0
[4] grid_3.5.1
[7] bitops_1.0-6
[10] XML_3.98-1.16

References

lattice_0.20-35
Matrix_1.2-14
RCurl_1.95-4.11

tools_3.5.1
GenomeInfoDbData_1.2.0
compiler_3.5.1

Jing Zhao, Toshiro K Ohsumi, Johnny T Kung, Yuya Ogawa, Daniel J Grau, Kavitha
Sarma, Ji Joon Song, Robert E Kingston, Mark Borowsky, and Jeannie T Lee.
Genome-wide Identiﬁcation of Polycomb-Associated RNAs by RIP-seq. Molecu-
lar Cell, 40(6):939–953, December 2010.

6

