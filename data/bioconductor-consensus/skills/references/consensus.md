Fitting and visualising row-linear models with
consensus

Tim Peters

October 29, 2025

Summary

This short vignette will demonstrate how to fit a set of row-linear mod-
els in the form of an interlaboratory testing procedure (ASTM Standard
E691) in a genomic context. This allows us to make comparisons of sensi-
tivity and precision for each platform/condition the samples are measured
under. We can then make broader inferences about the suitability of a
given technology.

In an ideal world we would like a set of “gold standards” to validate a new
technology or laboratory protocol when quantifying various genomic character-
istics. The problem with this is that all genomic measurements are estimates,
even those that are seen as more reliable, such as qPCR. Stochastic sampling of
individual molecules (and their subsequent amplification) is an inescapable part
of most modern laboratory protocols, which means that, inevitably, there will
always be error present in the measurement. Rather than ignore this error and
defining a “gold standard” (thus biasing all subsequent measurements towards
that standard), the aim of this package is to encourage an empirical approach
to characterising the advantages and disadvantages of a suite of candidate tech-
nological platforms, laboratory protocols or other various conditions that may
influence the measurement. With this in mind, we start with some normalised
gene expression data sourced from The Cancer Genome Atlas (TCGA) glioblas-
toma multiforme (GBM) project[1].

Firstly, make sure the package is installed:

if (!require("BiocManager"))

install.packages("BiocManager")

BiocManager::install("consensus")

Then load package and data:

library(consensus)
data("TCGA")

1

We have 27 matched samples assayed across four different gene expres-
sion measurement platforms: Affymetrix-HT-HG-U133A GeneChip, Affymetrix
HuEx GeneChip, Custom Agilent 244,000 feature Gene Expression Microarray
and a polyA selection RNA-Seq protocol. We have selected 1000 genes at ran-
dom for this test dataset.

sapply(mget(c("U133A", "Huex", "Agilent", "RNASeq")), dim)

##
## [1,] 1000 1000
27
## [2,]

U133A Huex Agilent RNASeq
1000
27

1000
27

27

rnames <- sapply(mget(c("U133A", "Huex", "Agilent", "RNASeq")), rownames)
head(rnames)

Huex
"A2M"

Agilent RNASeq
"A2M"

##
U133A
## [1,] "A2M"
## [2,] "ABCA3" "ABCA3" "ABCA3" "ABCA3"
## [3,] "ABCA4" "ABCA4" "ABCA4" "ABCA4"
## [4,] "ABCB9" "ABCB9" "ABCB9" "ABCB9"
## [5,] "ABCC3" "ABCC3" "ABCC3" "ABCC3"
## [6,] "ABCF3" "ABCF3" "ABCF3" "ABCF3"

"A2M"

apply(rnames[,2:ncol(rnames)], 2, function (x) all(x==rnames[,1]))

##
##

Huex Agilent
TRUE
TRUE

RNASeq
TRUE

cnames <- sapply(mget(c("U133A", "Huex", "Agilent", "RNASeq")), colnames)
head(cnames)

Huex

U133A

Agilent

##
## [1,] "TCGA.06.0211.01B.01" "TCGA.06.0211.01B.01" "TCGA.06.0211.01B.01"
## [2,] "TCGA.06.0190.01A.01" "TCGA.06.0190.01A.01" "TCGA.06.0190.01A.01"
## [3,] "TCGA.06.0238.01A.02" "TCGA.06.0238.01A.02" "TCGA.06.0238.01A.02"
## [4,] "TCGA.06.0645.01A.01" "TCGA.06.0645.01A.01" "TCGA.06.0645.01A.01"
## [5,] "TCGA.06.0132.01A.02" "TCGA.06.0132.01A.02" "TCGA.06.0132.01A.02"
## [6,] "TCGA.12.0618.01A.01" "TCGA.12.0618.01A.01" "TCGA.12.0618.01A.01"
##
## [1,] "TCGA.06.0211.01B.01"
## [2,] "TCGA.06.0190.01A.01"
## [3,] "TCGA.06.0238.01A.02"
## [4,] "TCGA.06.0645.01A.01"
## [5,] "TCGA.06.0132.01A.02"
## [6,] "TCGA.12.0618.01A.01"

RNASeq

apply(rnames[,2:ncol(rnames)], 2, function (x) all(x==rnames[,1]))

2

##
##

Huex Agilent
TRUE
TRUE

RNASeq
TRUE

rm(rnames, cnames)

Notice that the dimensions, row names and column names are identical
across all measurement matrices. This is required for when we construct a
MultiMeasure object from this data. If this requirement is not met, an error
message will tell you which matrix attributes don’t match.

Now we construct the MultiMeasure:

tcga_mm <- MultiMeasure(names=c("U133A", "Huex", "Agilent", "RNA-Seq"),

data=list(U133A, Huex, Agilent, RNASeq))

tcga_mm

## MultiMeasure object with 4 platforms/conditions, 27 samples and 1000 measured loci.

We can fit the data using the row-linear method from the ASTM standard[2].
One fit is performed for each gene represented by the matrix. The row-linear
fit can be expressed in the form:

Zij = ai + bi(xj − ¯x) + dij

(1)

where Zij is 4x27 matrix of measurements from sample j on platform i. ai is
row mean of the ith platform, xj the column mean of the jth sample and ¯x the
grand mean of Zij. bi is the slope of the regression of the sample measurements
from platform i on xj − ¯x, and dij the residual scatter about this line.

Firstly, let’s visualise one of these fits, from a well-known gene, TP53:

plotOneFit(tcga_mm, "TP53", brewer.pal(n = 4, name = "Dark2"))

3

This gene is generally concordant across platforms, since the regression lines

are fairly parallel and the residuals don’t fall too far away.

Now to perform the fitting. This will create a S4 class object of type Con-

sensusFit.

fit <- fitConsensus(tcga_mm)
fit

## ConsensusFit object with 4 platforms/conditions and 1000 measured loci.

Once this is done, we might be interested in seeing what the distributions of
some parameters from Equation (1) look like over all 1000 genes. First, let’s see
what the distribution of the averages (ais) are, which serve as dynamic ranges
of each platform:

4

4.24.44.64.85.05.25.45.6−202468TP53Sample meansSample measurementsU133AHuexAgilentRNA−SeqplotMarginals(fit, "average", brewer.pal(n = 4, name = "Dark2"))

Then we can see which platforms have the greatest sensitivity (bi) to changes

in gene expression:

plotMarginals(fit, "sensitivity", brewer.pal(n = 4, name = "Dark2"))

5

05100.00.10.20.30.40.5Marginals: averagea_iDensityU133AHuexAgilentRNA−SeqClearly, RNA-Seq is the most sensitive, followed by the Agilent array, then
Huex and finally U133A. Interestingly, U133A has a second mode at 0, which
is indicative of a subset of genes that do not show any response to expression
change on this platform. The marginals of the averages for this platform show
a right skew, which contributes to this phenomenon.

Let’s plot the precision (di) marginals, remembering that higher values mean

lower precision:

plotMarginals(fit, "precision", brewer.pal(n = 4, name = "Dark2"))

6

012340.00.51.01.5Marginals: sensitivityb_iDensityU133AHuexAgilentRNA−SeqAll platforms except U133A are generally similar in their precision, suggest-
ing that, from a platform design perspective, there may have been a trade-off
between risk and reward in detecting changes in gene expression on U133A that
has now been surmounted by more recent technologies.

Finally, we are interested in the gene loci whose measurements are the most
discordant across platforms. These are most easily visualised on a heatmap.
Like with plotMarginals, we can choose to plot discordance in terms of average,
sensitivity or precision.

plotMostDiscordant(fit, "sensitivity", 15)

7

−6−5−4−3−2−100.00.20.40.6Marginals: precisionLog (d_i)DensityU133AHuexAgilentRNA−SeqClearly, the governing feature of the most sensitivity-discordant genes is that
RNA-Seq explains the vast majority of change in gene expression. To see what
a row-linear fit looks like for one of these genes, we again use plotOneFit.

plotOneFit(tcga_mm, "MYO7B", brewer.pal(n = 4, name = "Dark2"))

8

U133AAgilentHuexRNA−SeqMAP3K9FRMPD1HBE1SPTBADAMTS7MASP2OPRD1CNGB1F2RL3KCNG2PLA2G2DPOU3F3MYOGSLC6A20MYO7B−202sensitivityColor KeyWe have seen that the row-linear model is able to provide us with a method
of assessing the measurement quality of various transcriptomic platforms, that
acts as an alternative to a “gold standard”. The model need not be restricted to
gene expression either - platforms assessing other measurements such as DNA
methylation are just as applicable. The method can also be used to assess
competing laboratory protocols, given a suite of matched aliquots of material
are provided across three or more variations on such processes.

sessionInfo()

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

9

2.02.53.03.5−20246MYO7BSample meansSample measurementsU133AHuexAgilentRNA−SeqLC_NUMERIC=C
LC_MONETARY=en_US.UTF-8
LC_NAME=C
LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_TIME=en_GB
LC_MESSAGES=en_US.UTF-8
LC_ADDRESS=C

##
## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [4] LC_COLLATE=C
## [7] LC_PAPER=en_US.UTF-8
## [10] LC_TELEPHONE=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats
##
## other attached packages:
## [1] consensus_1.28.0
##
## loaded via a namespace (and not attached):
## [1] compiler_4.5.1
## [5] highr_0.11
## [9] bitops_1.0-9

gplots_3.2.0
caTools_1.18.3
gtools_3.9.5

grDevices utils

graphics

datasets

methods

base

RColorBrewer_1.1-3 knitr_1.50

tools_4.5.1
xfun_0.53
evaluate_1.0.5

KernSmooth_2.23-26
matrixStats_1.5.0

References

[1] Verhaak, R. G. W., Hoadley, K. A., Purdom, E., Wang, V., Qi, Y., Wilker-
son, M. D., ..., Cancer Genome Atlas Research Network. Integrated genomic
analysis identifies clinically relevant subtypes of glioblastoma characterized
by abnormalities in PDGFRA, IDH1, EGFR, and NF1. Cancer Cell, 2010,
17(1), 98-110.

[2] Mandel, J. Analyzing Interlaboratory Data According to ASTM Standard
E691. In Quality and Statistics: Total Quality Management (pp. 59-59-12),
1994. 100 Barr Harbor Drive, PO Box C700, West Conshohocken, PA 19428-
2959: ASTM International.

10

