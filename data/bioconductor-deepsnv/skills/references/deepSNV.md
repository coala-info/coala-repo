Calling subclonal mutations with deepSNV

Moritz Gerstung and Niko Beerenwinkel

October 29, 2025

Contents

1 Introduction

2 Working example

3 Normalization

4 Overdispersion

5 sessionInfo()

1 Introduction

1

2

4

5

7

This package provides algorithms for calling single nucleotide variants in deep sequencing experiments
of polyclonal samples. The package uses a clonal control experiment for estimating the local error rate
and tests whether the observed nucleotide frequencies differ between test and control. The basic model
is a binomial model for the counts Xi,j and Yi,j of nucleotide j at position i, in the test and the control
experiment, respectively:

Xi,j ∼ Bin(ni, pi,j)
Yi,j ∼ Bin(mi, qi,j).

(1)

Here ni and mi denote the coverage in the two experiments, and pi,j and qi,j are learned from the
data. The presence of an SNV in the test experiment amounts to testing the hypothesis H1 : pi,j > qi,j
against the null-hypothesis H0 : pi,j = qi,j. The deepSNV algorithm uses likelihood ratio test with a
χ2

1-distribtution.

As an alternative to the binomial distribution, a beta-binomial model can be used that has a global

parameter of overdispersion:

Xi,j ∼ BB(ni, α, pi,j)
Yi,j ∼ BB(mi, α, qi,j).

(2)

The parameter α defines a parameter that quantifies the overdispersion of the model, shared across sites
and nucleotides. This parametrization is equivalent to setting βi,j = α(1 − pi,j)/pi,j. For small pi,j, one
obtains a variance of E[Xi,j] ≈ nipi,j + (nipi,j)2/α.

All parameters are determined by a maximum likelihood criterion, where for pi,j (and similarly for
qi,j) a methods-of-moments approximation is used, α/(α + ˆβi,j) = Xi,j/ni. The binomial model arises
from the beta-binomial model in the limit α → ∞.

To achieve a higher specifitiy the test is performed on both strands separately, and the resulting p-
values are combined into a single one using either the product, average, or maximum as a statistic and
their corresponding distributions under a uniform for computing a joint p-value. For more information
and for citing the deepSNV package please use:

• Gerstung M, Beisel C, Rechsteiner M, Wild P, Schraml P, Moch H, Beerenwinkel N (2012). “Reliable
detection of subclonal single-nucleotide variants in tumor cell populations.” Nat Commun, 3, 811.

1

2 Working example

In this example, we load some real world data. The data of length 1,512 nt were sequenced with a Roche
454 Junior sequencer at about 500x coverage. They consist of a mixture of two HIV clones at 10% and
90%(test) and a clonal control. The data were aligned to the HXB2 reference genome with novoalign,
and can be downloaded from the authors’ website, or attached . We first load the package and define the
genomic region of interest:

library(deepSNV)

regions <- data.frame(chr="B.FR.83.HXB2_LAI_IIIB_BRU_K034", start = 2074, stop=3585)

Now the data can be loaded from the remote .bam files with the deepSNV command (not run)

# HIVmix <- deepSNV(test = "http://www.bsse.ethz.ch/cbg/software/deepSNV/data/test.bam",
#
#

control = "http://www.bsse.ethz.ch/cbg/software/deepSNV/data/control.bam",
regions=regions, q=10)

The data.frame regions contains the genomic region to be parsed from the two files by the method
deepSNV. The additional parameter q=10 specifies that only nucleotides with PHRED higher than 10 are
counted. As this might fail in the absence of a running internet connection, we load the resulting object
that comes along with the deepSNV package:

data(HIVmix) # Attach the data instead, as it could fail in routine checks without internet connection.
show(HIVmix)

G

-
C
NA 0.5965736 0.5965736 0.5965736 0.5965736
NA 0.5965736
NA 0.5965736 0.5965736 0.5965736 0.5965736
NA 0.5965736 0.5965736
NA 0.5965736 0.5965736 0.5965736 0.5965736
NA 0.5965736

10 characters

A

T

fisher

## Data: 1512 positions x
## Model: bin
## Alternative: greater
## Combine Method:
## P-Values:
##
## [1,]
## [2,] 0.5965736 0.5965736 0.5965736
## [3,]
## [4,] 0.5965736 0.5965736
## [5,]
## [6,] 0.5965736 0.5965736 0.5965736
## ...
##
## [1507,]
## [1508,] 0.8465736 0.5965736 0.8465736
## [1509,] 0.5965736 0.5965736
## [1510,] 0.8465736 0.5965736
## [1511,]
## [1512,] 1.0000000

A

T

G

-
C
NA 0.5965736 0.5965736 0.5965736 0.5965736
NA 0.5965736
NA 0.5965736 0.5965736
NA 0.5965736 0.5965736
NA 0.5965736 0.5965736 0.4737885 0.5965736
NA 0.8465736 0.8465736 0.8465736

The counts are stored in the slots test and control:

control(HIVmix)[100:110,]

##
##
##
##
##
##
##
##

T
A
0
[1,] 1170
0
[2,]
0
0 1170
[3,]
0 1170
[4,]
0 1170
[5,]
0
[6,]
0
[7,]

C
0
0 1170 0
0 0
0
0 0
0
0 0
0
0 1170
0 0
0 1168 0
0

t
a
G -
0
0 0 163
1
0
0 118
0 125
1
1
0

g _
c
0
1 0
0 147 0
3 6
0
0 0
0
0 0
99 10
0 91
5 0
1 85 0
0

2

[8,]
##
##
[9,]
## [10,]
## [11,]

0
0
0
0
0 1170
0 1173

0 1169 0
0 1170 0
1 0
0
0 0
0

1
0
0
3
0 109
0 115

0 94 0
0 99 0
0 0
0
0 0
0

test(HIVmix)[100:110,]

G -
a
0 0 70

A
T
##
[1,] 442
0
##
0
0
[2,]
##
13
0 427
[3,]
##
0
0 440
[4,]
##
0
[5,]
0 440
##
1 437
1
[6,]
##
0
[7,] 10
##
0
0
[8,]
##
0
##
0
[9,]
0 425
## [10,]
0 425
## [11,]

C
0
0 441 0
0 0
0 0
0 0
0 0
2 424 0
0 429 0
0 425 0
0 0
0
0 0
0

t
0 0

c g _
0 0
0 0
0 66 0
0 50 6
0 3
0 56 0
0 0
0 42 7
0 0
4 0
1 38
0
0 1 33 0
3
0 36 0
0 0
0 38 0
0 0
0 0
0 42 0
0 0
0 47 0

Uppercase nucleotides are from the reference strand, lowercase nucleotides from the reverse. Also

note the strand bias.

A visual representation of the data can be obtained with the plot method:

plot(HIVmix)

One realizes that there are many variants nicely separated by the test at the topleft corner, althought
the noise level also extends along the diagonal to similar frequencies. Grey dots have a P -values smaller
than 0.05.

Significant SNVs are tabularized with the summary command:

SNVs <- summary(HIVmix, sig.level=0.05, adjust.method="BH")
head(SNVs)

chr

pos ref var

##
B.FR.83.HXB2_LAI_IIIB_BRU_K034 2127
## 1
## 53 B.FR.83.HXB2_LAI_IIIB_BRU_K034 2130
## 73 B.FR.83.HXB2_LAI_IIIB_BRU_K034 2139
## 74 B.FR.83.HXB2_LAI_IIIB_BRU_K034 2141
## 54 B.FR.83.HXB2_LAI_IIIB_BRU_K034 2150
B.FR.83.HXB2_LAI_IIIB_BRU_K034 2151
## 2
sigma2.freq.var n.tst.fw cov.tst.fw n.tst.bw cov.tst.bw n.ctrl.fw
##
2
## 1

freq.var
A 4.191236e-07 0.02903526
C 1.802070e-09 0.03076923
G 7.753362e-11 0.03362573
G 5.771900e-11 0.03333333
C 9.639517e-06 0.01763908
A 5.804568e-10 0.02815013

4.892000e-05

G
T
A
A
A
G

p.val

581

17

47

2

3

1e−041e−031e−021e−011e+001e−041e−031e−021e−011e+00Relative Frequency in ControlRelative Frequency in TestntATCG−−log10 P01020304050## 53
## 73
## 74
## 54
## 2
##
## 1
## 53
## 73
## 74
## 54
## 2

4.733728e-05
4.916043e-05
4.830918e-05
2.393362e-05
3.773476e-05

16
16
16
10
16

597
599
599
609
614

4
7
7
3
5

53
85
91
128
132

0
0
0
0
0

cov.ctrl.fw n.ctrl.bw cov.ctrl.bw

1537
1534
1535
1535
1538
1539

0
0
0
0
0
0

raw.p.val
103 6.306257e-09
104 2.353895e-11
158 9.614784e-13
181 7.062179e-13
283 1.577897e-07
287 7.486050e-12

nrow(SNVs)

## [1] 107

min(SNVs$freq.var)

## [1] 0.004378763

We chose a significance level of sig.level=0.05 and Benjamini-Hochberg correction for multiple

testing (adjust.method="BH"). The test selected 107 variants. This compares to

sum(RF(test(HIVmix), total=T) > 0.01 & RF(test(HIVmix), total=T) < 0.95)

## [1] 417

candidate variants with frequencies above 0.01! In this experiment we also know the truth from direct

Sanger sequencing of the clones before pooling. Load the data and study the confusion matrix with:

data(trueSNVs, package="deepSNV")
table(p.adjust(p.val(HIVmix), method="BH") < 0.05, trueSNVs)

##
##
##
##

trueSNVs

FALSE TRUE
8
93

5933
14

FALSE
TRUE

So 93 of 101 SNVs could be recovered by the experiments.

3 Normalization

We want to further assess the null model with experimental data from two homogeneous replicates. In
particular we want to analyze whether the empirical distribution of the p-values is uniform. The data we
study comes from two phiX sequences sequenced on separate runs on a GAIIx.

## Load data (unnormalized)
data(phiX, package="deepSNV")
plot(phiX, cex.min=.5)
## Normalize data
phiN <- normalize(phiX, round=TRUE)
plot(phiN, cex.min=.5)

4

From the left plot it appears that there is a systematic bias between the two experiments, likely
because they were sequenced in different runs. The normalized data is shown in the second plot. Now
the points now symmetrically scatter around the diagonal and all p-values are within the expected range:

p.norm <- p.val(phiN)

n <- sum(!is.na(p.norm))
qqplot(p.norm, seq(1/n,1, length.out=n), log="xy", type="S", xlab="P-value", ylab="CDF")

p.val <- p.val(phiX)

points(sort(p.val[!is.na(p.val)]), seq(1/n,1, length.out=n), pch=16, col="grey", type="S", lty=2)
legend("topleft", c("raw data", "normalized data"), pch=16, col=c("grey", "black"), bty="n", lty=3)
abline(0,1)

After normalization the cumulative distribution of the p-values is close to the diagonal, even for the

smallest values. Hence the p-values accurately measure the probability of type-1 errors.

4 Overdispersion

In some situations, the variance of the binomial model is too small, for example for templates with
long repeats or heavy PCR amplification for target selection. An alternative model is the beta-binomial
distribution that allows for a larger variance.

We load a data-set from two deep sequencing experiments of four genes extracted from a metastatic

renal cell carcinoma with sequenced on separate lanes of a GAIIx:

data("RCC", package="deepSNV")
show(RCC)

## Data: 14813 positions x

10 characters

5

1e−041e−031e−021e−011e+001e−041e−031e−021e−011e+00P−valueCDFraw datanormalized dataC

A

T

average

G -
NA 1.0000000 1.0000000 1.0000000 1
NA 1.0000000 0.8395837 1.0000000 1
NA 0.8901412 1.0000000 0.9144178 1
NA 0.5717729 1
NA 0.9977519 0.5858255 0.6729237 1
NA 1

## Model: bin
## Alternative: two.sided
## Combine Method:
## P-Values:
##
## [1,]
## [2,]
## [3,]
## [4,] 0.5000127 0.5969902
## [5,]
## [6,] 1.0000000 0.9810956 0.7530014
## ...
##
G -
## [14808,] 0.9733845 1.0000000 0.8896366 NA 1
1 1
## [14809,] 1.0000000 1.0000000
## [14810,]
1 1
## [14811,] 0.9414135 1.0000000 0.9944664 NA 1
1 1
## [14812,]
1 1
## [14813,]

NA
NA 0.9201851 0.5000416

NA 1.0000000 0.8270151
NA 1.0000000 1.0000000

T

A

C

plot(RCC, cex.min=.5)
RCC.bb = estimateDispersion(RCC, alternative="two.sided")

## Note: The initial object used a binomial model. Will be changed to beta-binomial.
## Estimated dispersion factor 136.926849574802

plot(RCC.bb, cex.min=.5)

We see that a binomial model was used to generate the data. An inspection of the first plot shows
a long noise tail where apparently the dispersion is underestimated causing some false positives. In the
second plot we used a beta-binomial model instead and conservatively estimate the dispersion factor on
both sides with the argument alternative="two.sided".

The log-likelihood of the two models are:

RCC.bb@log.lik

## [1] -270110.7

RCC@log.lik

## [1] -283851.7

RCC.bb@log.lik - RCC@log.lik

## [1] 13740.93

6

log(4*nrow(test(RCC)))

## [1] 10.98955

Note that the difference is larger than log(n), the difference in BIC of the two models.
If we compare the number of called SNVs, we find

summary(RCC, adjust.method="bonferroni")[,1:6]

chr

p.val

##
chr10 89710231
## 6
## 1
7512879
chr17
## 10 chr17 7513782
chr3 10158255
## 15
chr3 10158274
## 4
chr3 10158337
## 2
chr3 10163012
## 7
chr3 10163206
## 16
chr3 10163208
## 17
chr3 10163428
## 11
chr3 10166219
## 8
chr3 10166943
## 3
chr3 10167220
## 12
chr3 10167672
## 13
chr3 10167709
## 5
chr3 10167762
## 9
chr3 10168683
## 14

pos ref var
freq.var
T
1.812318e-06 -0.0522069105
A
4.923709e-03 0.0095680379
G
6.137099e-57 0.0523098637
7.414419e-27 0.0374605077
-
T 6.596999e-152 -0.1420210172
A
8.455105e-09 -0.1458150689
C 2.512916e-211 0.1242571351
0.000000e+00 0.2440387988
-
1.908223e-02 0.0007724394
-
1.026389e-79 -0.1111055718
G
C
6.538408e-74 0.1591560973
A 1.406981e-158 -0.1326056510
2.960126e-36 0.0046531880
G
G
0.000000e+00 0.1399833662
T 6.203881e-304 -0.1440968910
0.000000e+00 -0.1323353964
C
G 2.134656e-304 -0.1324914089

C
G
A
A
C
G
-
T
G
T
G
G
C
A
C
T
T

compared to

tab <- summary(RCC.bb, adjust.method="bonferroni")[,1:6]
tab

chr

p.val

##
## 2 chr3 10158274
## 7 chr3 10163206
## 8 chr3 10163208
## 1 chr3 10166943
## 5 chr3 10167220
## 3 chr3 10167709
## 4 chr3 10167762
## 6 chr3 10168683

freq.var
pos ref var
4.185487e-03 -0.1420210172
T
0.2440387988
- 6.777322e-304
2.693887e-02
-
0.0007724394
9.500067e-03 -0.1326056510
A
0.0046531880
5.461071e-30
G
3.466478e-02 -0.1440968910
T
8.715720e-03 -0.1323353964
C
4.237396e-02 -0.1324914089
G

C
T
G
G
C
C
T
T

A closer inspection will show that the variants with a negative change in frequency are all known SNPs
on chromosome 3, which drop in frequency due to loss of heterozygousity in the tumor. The remaining
variants have positive frequencies. The first is a deletion of chr3:10158274C on -14.2% of the alleles
that truncates the VHL protein. The second is a C>G conversion in the 5′-UTR of the VHL gene at
chr3:10163206T in 24.4% of the alleles. The third variant is likely to be an alignment artifact resulting
from imperfect alignments of the deletion of chr3:10158274C.

5 sessionInfo()

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C,
LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

• Time zone: America/New_York

7

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, parallel, splines, stats, stats4, utils

• Other packages: Biobase 2.70.0, BiocGenerics 0.56.0, Biostrings 2.78.0, GenomicRanges 1.62.0,

IRanges 2.44.0, MatrixGenerics 1.22.0, Rsamtools 2.26.0, S4Vectors 0.48.0, Seqinfo 1.0.0,
SummarizedExperiment 1.40.0, VGAM 1.1-13, VariantAnnotation 1.56.0, XVector 0.50.0,
deepSNV 1.56.0, generics 0.1.4, knitr 1.50, matrixStats 1.5.0

• Loaded via a namespace (and not attached): AnnotationDbi 1.72.0, BSgenome 1.78.0,

BiocIO 1.20.0, BiocParallel 1.44.0, DBI 1.2.3, DelayedArray 0.36.0, GenomicAlignments 1.46.0,
GenomicFeatures 1.62.0, KEGGREST 1.50.0, Matrix 1.7-4, R6 2.6.1, RCurl 1.98-1.17,
RSQLite 2.4.3, Rhtslib 3.6.0, S4Arrays 1.10.0, SparseArray 1.10.0, XML 3.99-0.19, abind 1.4-8,
bit 4.6.0, bit64 4.6.0-1, bitops 1.0-9, blob 1.2.4, bslib 0.9.0, cachem 1.1.0, cigarillo 1.0.0, cli 3.6.5,
codetools 0.2-20, compiler 4.5.1, crayon 1.5.3, curl 7.0.0, digest 0.6.37, evaluate 1.0.5,
fastmap 1.2.0, grid 4.5.1, highr 0.11, htmltools 0.5.8.1, httr 1.4.7, jquerylib 0.1.4, jsonlite 2.0.0,
lattice 0.22-7, lifecycle 1.0.4, memoise 2.0.1, png 0.1-8, restfulr 0.0.16, rjson 0.2.23, rlang 1.1.6,
rmarkdown 2.30, rtracklayer 1.70.0, sass 0.4.10, tools 4.5.1, vctrs 0.6.5, xfun 0.53, yaml 2.3.10

8

