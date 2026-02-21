How to use the DEGseq Package

Likun Wang1,2, Xiaowo Wang1 and Xuegong Zhang1.

October 29, 2025

1MOE Key Laboratory of Bioinformatics and Bioinformatics Division, TNLIST /Depart-
ment of Automation, Tsinghua University.
2Department of Biomedical Informatics, School of Basic Medical Sciences, Peking University
Health Science Center.

wanglk@pku.edu.cn; xwwang@tsinghua.edu.cn; zhangxg@tsinghua.edu.cn

Contents

1 Introduction

2 Getting started

3 Methods

3.1 MA-plot-based method with random sampling model . . . . . . . . . . . . . .
3.2 MA-plot-based method with technical replicates . . . . . . . . . . . . . . . . .

4 Data

1

2

2
2
4

4

5 Examples

5
5
5.1 Example for DEGexp . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7
5.2 Example for DEGseq . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.3 Example for samWrapper
5.4 Example for getGeneExp . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
5.5 Example for readGeneExp . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10

1

Introduction

This document provides a discussion of the functions in the package DEGseq. DEGseq is a
free R package for identifying differentially expressed genes from RNA-seq data. The input
of DEGseq is uniquely mapped reads from RNA-seq data with a gene annotation of the
corresponding genome, or gene (or transcript isoform) expression values provided by other
programs. The output of DEGseq includes a text file and an XHTML summary page. The
text file contains the gene expression values for the samples, a P-value and two kinds of
Q-values which are calculated by the methods described in Benjamini and Hochberg (1995)

1

and Storey and Tibshirani (2003) for each gene to denote its expression difference between
libraries.

We also provided a function samWrapper using the method as described in SAM (Tusher
and et al., 2001) which can be applied to compare two sets of samples with multiple replicates
or two groups of samples from different individuals (e.g. disease samples, case vs. control).
The DEGseq package employs library qvalue and samr , which must be installed in ad-

vance.

2 Getting started

To load the DEGseq package, type library(DEGseq). Total six methods are presented in
this package. They are DEGexp, DEGseq, samWrapper, getGeneExp and readGeneExp.

3 Methods

3.1 MA-plot-based method with random sampling model

Current observations suggest that typically RNA-seq experiments have low background noise
and the Poisson model fits data well. In such cases, users could directly pool the technical
replicates for each sample together to get higher sequencing depth and detect subtle gene
expression changes.

Jiang and et al. (2009) modeled RNA sequencing as a random sampling process, in which
each read is sampled independently and uniformly from every possible nucleotides in the
sample. Based on this model, the number of reads coming from a gene (or transcript isoform)
follows a binomial distribution (and could be approximated by a Poisson distribution).
Using the statistical model, we proposed a novel method based on the MA-plot, which is a
statistical analysis tool having been widely used to detect and visualize intensity-dependent
ratio of microarray data (Yang and et al., 2002).

Let C1 and C2 denote the counts of reads mapped to a specific gene obtained from
two samples with Ci ∼ binomial(ni, pi), i = 1, 2, where ni denotes the total number of
mapped reads and pi denotes the probability of a read coming from that gene. We define
M = logC1
2 )/2. We assume that C1 and C2 are independent.
Let X = logC1
2 , hence M = X − Y and A = (X + Y )/2. We can prove that
X and Y follow normal distributions approximately (when ni is large enough), denote

2 , and A = (logC1

2 and Y = logC2

2 + logC2

2 − logC2

X → N (log2(n1p1), (

Y → N (log2(n2p2), (

1 − p1
n1p1
1 − p2
n2p2

)(loge

2)2) = N (µX , σ2

X )

)(loge

2)2) = N (µY , σ2
Y )

(1)

(2)

Based on the assumption that C1 and C2 are independent (so X and Y are independent),

the distributions of M and A can be obtained:

M ∼ N (µX − µY , σ2

Y ) = N (µM , σ2

M )

A ∼ N (

1
2

(µX + µY ),

X + σ2

Y )) = N (µA, σ2
A)

X + σ2
1
4

(σ2

2

(3)

(4)

Based on formulas (3) and (4), the conditional distribution of M given that A = a can

be obtained:

M |(A = a) ∼ N (µM + ρ

σM
σA

(a − µA), σ2

M (1 − ρ2)),

ρ =

Cov(M, A)
σM σA

=

σ2
X − σ2
Y
σ2
X + σ2
Y

.

E(M |A = a) = µM + ρ

σM
σA

(a − µA)

= µX − µY + 2

σ2
X − σ2
Y
X + σ2
σ2
Y

(a −

1
2

(µX + µY )).

Thus,

and

V ar(M |A = a) = σ2

M (1 − ρ2)
X σ2
σ2
Y
X + σ2
σ2
Y

.

= 4

For gene g with (A = a, M = m) on the MA-plot of two samples, we do the hypothesis

test H0 : p1 = p2 = p versus H1 : p1 ̸= p2. Based on above deduction,

µA =

1
2

(µX + µY ) =

1
2

log2(n1n2p2).

Thus,

Use a as an estimate of µA then

p =

(cid:112)

22µA/(n1n2).

ˆp =

(cid:112)

22a/(n1n2).

So the estimates of E(M |A = a) and V ar(M |A = a) are

and

(cid:98)E(M |A = a) = log2(n1) − log2(n2),

(cid:100)V ar(M |A = a) =

4(1 − (cid:112)22a/(n1n2))(loge
(n1 + n2)(cid:112)22a/(n1n2)

2)2

.

Then use the two estimates to calculate a Z-score for the gene g with (A = a, M = m), and
convert it to a two-sided P-value which is used to indicate whether gene g is differentially
expressed or not.

Z − score =

|m − (cid:98)E(M |A = a)|
(cid:113)

(cid:100)V ar(M |A = a)

.

3

Given a Z-score threshold, take four as an example, the two lines with the following
equations are used to indicate the four-fold local standard deviation of M according to the
random sampling model:

m1 = (cid:98)E(M |A = a) + 4 ·

(cid:113)

(cid:100)V ar(M |A = a)

= log2(n1) − log2(n2) + 4 ·

(cid:115)

4(1 − (cid:112)22a/(n1n2))(loge
(n1 + n2)(cid:112)22a/(n1n2)

2)2

m2 = (cid:98)E(M |A = a) − 4 ·

(cid:113)

(cid:100)V ar(M |A = a)

= log2(n1) − log2(n2) − 4 ·

(cid:115)

4(1 − (cid:112)22a/(n1n2))(loge
(n1 + n2)(cid:112)22a/(n1n2)

2)2

We call the lines obtained by above equations theoretical four-fold local standard devia-

tions lines.

3.2 MA-plot-based method with technical replicates

To estimate the noise level of genes with different intensity, and identify gene expression
difference in different sequencing libraries, we proposed another method which is also based
on the MA-plot. Here M is the Y -axis and represents the intensity ratio, and A is the
X-axis and represents the average intensity for each transcript. To estimate the random
variation, we first draw a MA-plot using two technical replicates (e.g. two sequencing lanes)
from the same library. A sliding window (each window includes 1% points of the MA-plot)
is applied to scan the MA-plot along the A-axis (average intensity). For the window which is
centered at A = a, the local variation of M conditioned on A = a is estimated by all the M
values of the transcripts in the window. And a smoothed estimate of the intensity-dependent
noise level (local variation of M ) is estimated by lowess regression among the windows, and
converted to the standard deviation, under the assumption of normal distribution. The local
standard deviations σa of M conditioned on A = a were then used to compare the observed
difference between two different libraries. Next, we draw a second MA-plot for the data
from two different libraries. For each transcript g with (A = ag, M = mg) on the MA-plot,
a Z-score = |mg − µg|/σg is calculated to evaluate whether this transcript is differentially
expressed, where µg is the local mean of M and σg is the local standard deviation of M
conditioned on A = ag estimated by technical replicates. Finally, a P-value is assigned to
this gene according to the Z-score under the assumption of normal distribution.

4 Data

The test RNA-seq data are from Marioni and et al. (2008).
In their research, the RNA
samples from human liver and kidney were analyzed using the Illumina Genome Analyzer
sequencing platform. Each sample was sequenced in seven lanes, split across two runs of the
machine. The raw data are available in the NCBI short read archive with accession number
SRA000299. Please see Marioni and et al. (2008) for more details.

4

5 Examples

5.1 Example for DEGexp

If users already have the gene expression values (or the number of reads mapped to each
gene), this method can be used to identify differentially expressed genes between two sam-
ples with or without multiple technical replicates directly. In the package, there are test
data for this method. The file GeneExpExample5000.txt includes the first 5000 lines in
SupplementaryTable2.txt which is a supplementary file for Marioni and et al. (2008). In
this file, each line includes the count of reads mapped to a gene for 14 lanes respectively
(7 lanes for kidney and 7 lanes for liver). In the following examples, we only use the data
sequenced at a concentration of 3 pM (five lanes for each sample).

>
>
>
>
>

library(DEGseq)
geneExpFile <- system.file("extdata", "GeneExpExample5000.txt", package="DEGseq")
geneExpMatrix1 <- readGeneExp(file=geneExpFile, geneCol=1, valCol=c(7,9,12,15,18))
geneExpMatrix2 <- readGeneExp(file=geneExpFile, geneCol=1, valCol=c(8,10,11,13,16))
write.table(geneExpMatrix1[30:31,],row.names=FALSE)

"EnsemblGeneID" "R1L1Kidney" "R1L3Kidney" "R1L7Kidney" "R2L2Kidney" "R2L6Kidney"
"ENSG00000188976" "73" "77" "68" "70" "82"
"ENSG00000187961" "15" "15" "13" "12" "15"

>

write.table(geneExpMatrix2[30:31,],row.names=FALSE)

"EnsemblGeneID" "R1L2Liver" "R1L4Liver" "R1L6Liver" "R1L8Liver" "R2L3Liver"
"ENSG00000188976" "34" "56" "45" "55" "42"
"ENSG00000187961" "8" "13" "11" "12" "20"

To identify differentially expressed genes between the two samples (kidney and liver), we
first used the method MARS: MA-plot-based method with Random Sampling model. Five
report graphs for the two samples will be shown following the example commands.

> layout(matrix(c(1,2,3,4,5,6), 3, 2, byrow=TRUE))
> par(mar=c(2, 2, 2, 2))
> DEGexp(geneExpMatrix1=geneExpMatrix1, geneCol1=1, expCol1=c(2,3,4,5,6), groupLabel1="kidney",
+
+

geneExpMatrix2=geneExpMatrix2, geneCol2=1, expCol2=c(2,3,4,5,6), groupLabel2="liver",
method="MARS")

Please wait...
gene id column in geneExpMatrix1 for sample1:
expression value column(s) in geneExpMatrix1: 2 3 4 5 6
total number of reads uniquely mapped to genome obtained from sample1: 345504 354981 334557 366041 372895
gene id column in geneExpMatrix2 for sample2:
expression value column(s) in geneExpMatrix2: 2 3 4 5 6
total number of reads uniquely mapped to genome obtained from sample2: 274430 274486 264999 255041 284205

1

1

5

method to identify differentially expressed genes: MARS
pValue threshold: 0.001
output directory: none

The outputDir is not specified!
Please wait ...
Identifying differentially expressed genes ...
Please wait patiently ...
output ...
The results can be observed in directory:

none

The red points in the last graph (MA-plot) are the genes identified as differentially expressed.
If the outputDir is specified, a text file and an XHTML summary page will be generated.
These files can be found in the output directory.

Next, we performed the function DEGexp with the method MATR: MA-plot-based method

with technical replicates.

> layout(matrix(c(1,2,3,4,5,6), 3, 2, byrow=TRUE))
> par(mar=c(2, 2, 2, 2))

6

kidneylog2(Number of reads mapped to a gene)Density0510150.00.10.20.30.40.5liverlog2(Number of reads mapped to a gene)Density0510150.00.10.20.30.40.5kidneyliver051015log2(Number of reads mapped to a gene)051015051015kidney VS liverlog2(read counts for each gene) in liverlog2(read counts for each gene) in kidney051015−50510kidney VS liverAM> DEGexp(geneExpMatrix1=geneExpMatrix1, expCol1=2, groupLabel1="kidneyR1L1",
+
+
+
+

geneExpMatrix2=geneExpMatrix2, expCol2=2, groupLabel2="liverR1L2",
replicateExpMatrix1=geneExpMatrix1, expColR1=3, replicateLabel1="kidneyR1L3",
replicateExpMatrix2=geneExpMatrix1, expColR2=4, replicateLabel2="kidneyR1L7",
method="MATR")

The red points in the last graph (MA-plot) are the genes identified as differentially expressed.
The blue points are from the replicates (kidneyR1L3 and kidneyR1L7), and the blue lines
show the four-fold local standard deviation of M estimated by the two technical replicates.

5.2 Example for DEGseq

The method DEGseq takes uniquely mapped reads from RNA-seq data with a gene anno-
tation as input. This function first counts the number of reads mapped to each gene for
samples with or without multiple technical replicates. And then it invokes DEGexp to identify
significant genes.

>
>

kidneyR1L1 <- system.file("extdata", "kidneyChr21.bed.txt", package="DEGseq")
liverR1L2 <- system.file("extdata", "liverChr21.bed.txt", package="DEGseq")

7

kidneyR1L1log2(Number of reads mapped to a gene)Density0510150.00.10.20.30.40.5liverR1L2log2(Number of reads mapped to a gene)Density0510150.00.10.20.30.40.5kidneyR1L1liverR1L2051015log2(Number of reads mapped to a gene)051015051015kidneyR1L1 VS liverR1L2log2(read counts for each gene) in liverR1L2log2(read counts for each gene) in kidneyR1L1051015051015kidneyR1L3 VS kidneyR1L7log2(read counts for each gene) in kidneyR1L7log2(read counts for each gene) in kidneyR1L3051015−505kidneyR1L1 VS liverR1L2AM>
>
>
>
>
+

<- system.file("extdata", "refFlatChr21.txt", package="DEGseq")

refFlat
mapResultBatch1 <- c(kidneyR1L1)
mapResultBatch2 <- c(liverR1L2)
outputDir <- file.path(tempdir(), "DEGseqExample")
DEGseq(mapResultBatch1, mapResultBatch2, fileFormat="bed", refFlat=refFlat,

## only use the data from kidneyR1L1 and liverR1L2

outputDir=outputDir, method="LRT")

Please wait...

mapResultBatch1:

/tmp/RtmpdBWUy3/Rinst3ff2bd417262d0/DEGseq/extdata/kidneyChr21.bed.txt

mapResultBatch2:

/tmp/RtmpdBWUy3/Rinst3ff2bd417262d0/DEGseq/extdata/liverChr21.bed.txt

/tmp/RtmpdBWUy3/Rinst3ff2bd417262d0/DEGseq/extdata/refFlatChr21.txt

file format: bed
refFlat:
Ignore the strand information when count the reads mapped to genes!
Count the number of reads mapped to each gene ...
This will take several minutes, please wait patiently!
Please wait...

SampleFiles:

/tmp/RtmpdBWUy3/Rinst3ff2bd417262d0/DEGseq/extdata/kidneyChr21.bed.txt

Count the number of reads mapped to each gene.
This will take several minutes.
Please wait ...
total 259 unique genes

processed 0 reads (kidneyChr21.bed.txt)
processed 10000 reads (kidneyChr21.bed.txt)
processed 20000 reads (kidneyChr21.bed.txt)
processed 30000 reads (kidneyChr21.bed.txt)
processed 34304 reads (kidneyChr21.bed.txt)
total used 0.045286 seconds!
Please wait...

SampleFiles:

/tmp/RtmpdBWUy3/Rinst3ff2bd417262d0/DEGseq/extdata/liverChr21.bed.txt

Count the number of reads mapped to each gene.
This will take several minutes.
Please wait ...
total 259 unique genes

processed 0 reads (liverChr21.bed.txt)
processed 10000 reads (liverChr21.bed.txt)
processed 20000 reads (liverChr21.bed.txt)

8

processed 30000 reads (liverChr21.bed.txt)
processed 30729 reads (liverChr21.bed.txt)
total used 0.038054 seconds!
Please wait...
gene id column in geneExpMatrix1 for sample1:
expression value column(s) in geneExpMatrix1: 2
total number of reads uniquely mapped to genome obtained from sample1: 34304
gene id column in geneExpMatrix2 for sample2:
expression value column(s) in geneExpMatrix2: 2
total number of reads uniquely mapped to genome obtained from sample2: 30729

1

1

method to identify differentially expressed genes: LRT
pValue threshold: 0.001
output directory: /tmp/RtmpiJrewg/DEGseqExample

Please wait ...
Identifying differentially expressed genes ...
Please wait patiently ...
output ...

Done ...
The results can be observed in directory:

/tmp/RtmpiJrewg/DEGseqExample

5.3 Example for samWrapper

To compare two sets of samples with multiple replicates or two groups of samples from
different individuals (e.g. disease samples vs. control samples), we provided a method
which employs the methods in package samr . The strategy used in samr was first described
in Tusher and et al. (2001), and is used for significance analysis of microarrays. Note: This
function was removed from version 1.34.1.

5.4 Example for getGeneExp

This method is used to count the number of reads mapped to each gene for one sample.
The sample can have multiple technical replicates. The input of this method is the uniquely
mapped reads with a gene annotation. And the output is a text file containing gene expres-
sion values for the sample. For example,

>
>
>
>
>

<- system.file("extdata", "refFlatChr21.txt", package="DEGseq")

kidneyR1L1 <- system.file("extdata", "kidneyChr21.bed.txt", package="DEGseq")
refFlat
mapResultBatch <- c(kidneyR1L1)
output <- file.path(tempdir(), "kidneyChr21.bed.exp")
exp <- getGeneExp(mapResultBatch, refFlat=refFlat, output=output)

Please wait...

9

SampleFiles:

/tmp/RtmpdBWUy3/Rinst3ff2bd417262d0/DEGseq/extdata/kidneyChr21.bed.txt

Count the number of reads mapped to each gene.
This will take several minutes.
Please wait ...
total 259 unique genes

processed 0 reads (kidneyChr21.bed.txt)
processed 10000 reads (kidneyChr21.bed.txt)
processed 20000 reads (kidneyChr21.bed.txt)
processed 30000 reads (kidneyChr21.bed.txt)
processed 34304 reads (kidneyChr21.bed.txt)
total used 0.043011 seconds!

>

write.table(exp[30:32,], row.names=FALSE)

"geneName" "kidneyChr21.bed.txt.raw.counts." "kidneyChr21.bed.txt.RPKM." "kidneyChr21.bed.txt.all.reads."
"C21orf131" "0" "0" "34304"
"C21orf15" "0" "0" "34304"
"C21orf2" "51" "665.789" "34304"

The gene annotation file must follow the UCSC refFlat format. See http://genome.ucsc.
edu/goldenPath/gbdDescriptionsOld.html#RefFlat.

5.5 Example for readGeneExp

This function is used to read gene expression values from a file to a matrix in R workspace.
For example,

>
>
>

geneExpFile <- system.file("extdata", "GeneExpExample1000.txt", package="DEGseq")
exp <- readGeneExp(file=geneExpFile, geneCol=1, valCol=c(7,9,12,15,18,8,10,11,13,16))
write.table(exp[30:32,], row.names=FALSE)

"EnsemblGeneID" "R1L1Kidney" "R1L3Kidney" "R1L7Kidney" "R2L2Kidney" "R2L6Kidney" "R1L2Liver" "R1L4Liver" "R1L6Liver" "R1L8Liver" "R2L3Liver"
"ENSG00000188976" "73" "77" "68" "70" "82" "34" "56" "45" "55" "42"
"ENSG00000187961" "15" "15" "13" "12" "15" "8" "13" "11" "12" "20"
"ENSG00000187583" "1" "1" "3" "0" "3" "0" "1" "0" "0" "2"

References

Benjamini, Y. and Hochberg, Y. (1995). Controlling the false discovery rate: a practical

and powerful approach to multiple testing. J. R. Stat. Soc. Ser. B, 57:289–300.

Jiang, H. and et al. (2009). Statistical inferences for isoform expression in RNA-Seq. Bioin-

formatics, 25:1026–1032.

Marioni, J. C. and et al. (2008). RNA-seq: an assessment of technical reproducibility and

comparison with gene expression arrays. Genome Res., 18:1509–1517.

10

Storey, J. D. and Tibshirani, R. (2003). Statistical significance for genomewide studies.

Proc. Natl. Acad. Sci., 100:9440–9445.

Tusher, V. G. and et al. (2001). Significance analysis of microarrays applied to the ionizing

radiation response. PNAS, 98:5116–5121.

Yang, Y. H. and et al. (2002). Normalization for cDNA microarray data: a robust composite
method addressing single and multiple slide systematic variation. Nucleic Acids Research,
30:e15.

11

