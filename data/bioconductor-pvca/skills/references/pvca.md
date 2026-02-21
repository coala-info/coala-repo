Estimating batch effect in Microarray data with
Principal Variance Component Analysis(PVCA)
method

Pierre R. Bushel, Jianying Li

October 30, 2025

Contents

1 Introduction

2 Installation

3 An example run on published Golub data

4 Session

1

Introduction

1

2

2

3

Often times "batch effects" are present in microarray data due to any number of factors,
including e.g. a poor experimental design or when the gene expression data is combined
from different studies with limited standardization. To estimate the variability of ex-
perimental effects including batch, a novel hybrid approach known as principal variance
component analysis (PVCA) has been developed. The approach leverages the strengths
of two very popular data analysis methods: first, principal component analysis (PCA) is
used to efficiently reduce data dimension with maintaining the majority of the variability
in the data, and variance components analysis (VCA) fits a mixed linear model using
factors of interest as random effects to estimate and partition the total variability. The
PVCA approach can be used as a screening tool to determine which sources of variability

1

(biological, technical or other) are most prominent in a given microarray data set. Using
the eigenvalues associated with their corresponding eigenvectors as weights, associated
variations of all factors are standardized and the magnitude of each source of variability
(including each batch effect) is presented as a proportion of total variance. Although
PVCA is a generic approach for quantifying the corresponding proportion of variation
of each effect, it can be a handy assessment for estimating batch effect before and after
batch normalization.

The pvca package implements the method described in the book Batch Effects and
Noise in Microarray Experiment, chapter 12 "Principal Variance Components Analysis:
Estimating Batch Effects in Microarray Gene Expression Data": Jianying Li, Pierre R
Bushel, Tzu-Ming Chu, and Russell D Wolfinger 2010

The pvca method was applied in the paper: Michael J Boedigheimer, Russell D
Wolfinger, Michael B Bass, Pierre R Bushel, Jeff W Chou, Matthew Cooper, J Christo-
pher Corton, Jennifer Fostel, Susan Hester, Janice S Lee, Fenglong Liu, Jie Liu, Hui-
Rong Qian, John Quackenbush, Syril Pettit and Karol L Thompson11 2008 “Sources of
variation in baseline gene expression levels from toxicogenomics study control animals
across multiple laboratories” BMC Genomics 2008, June 12, 9:285

2

Installation

Simply skip this section if one has been familiar with the usual Bioconductor installation
process. Assume that a recent version of R has been correctly installed.

Install the packages from the Bioconductor repository, using the biocLite utility.

Within R console, type

>
+
>

if (!requireNamespace("BiocManager", quietly=TRUE))

install.packages("BiocManager")

BiocManager::install("pvca")

Installation using the biocLite utility automatically handles the package dependen-
cies. The pvca package depends on the packages like lme4 etc., which can be installed
when pvca package is stalled.

3 An example run on published Golub data

We use Golub dataset in the package golubEsets as an example to illustrate the PVCA
batch effect estimation procedure. This dataset contains 7129 genes from Microarray

2

data on 72 samples from a leukemia study. It is a merged dataset and we are testing
variability from each factor and their two-ways interactions. The pacakge performs
PVCA on this merged data and produces an estimation of the proportion (as possible
batch effect) each factor and interaction contribute. The figure shows the proportion in
a bar chart. .

> library(golubEsets)
> library(pvca)
> data(Golub_Merge)
> pct_threshold <- 0.6
> batch.factors <- c("ALL.AML", "BM.PB", "Source")
> pvcaObj <- pvcaBatchAssess (Golub_Merge, batch.factors, pct_threshold)
>

We can plot the source of potential batch effect in proporting as shown in Figure 1.

xlab = "Effects",

ylab = "Weighted average proportion variance",
ylim= c(0,1.1),col = c("blue"), las=2,
main="PVCA estimation bar chart")

> bp <- barplot(pvcaObj$dat,
+
+
+
> axis(1, at = bp, labels = pvcaObj$label, xlab = "Effects", cex.axis = 0.5, las=2)
> values = pvcaObj$dat
> new_values = round(values , 3)
> text(bp,pvcaObj$dat,labels = new_values, pos=3, cex = 0.8)
>

4 Session

>

print(sessionInfo())

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:

3

Figure 1: The bar chart shows the proportion of batch effect from possible source.

4

PVCA estimation bar chartEffectsWeighted average proportion variance0.00.20.40.60.81.0BM.PB:SourceALL.AML:SourceALL.AML:BM.PBSourceBM.PBALL.AMLResidual0.0310.0090.0440.0570.0440.1430.673[1] LC_CTYPE=en_US.UTF-8
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
[1] stats

graphics

grDevices utils

datasets

methods

base

other attached packages:
[1] pvca_1.50.0
[4] BiocGenerics_0.56.0 generics_0.1.4

golubEsets_1.51.0

Biobase_2.70.0

loaded via a namespace (and not attached):

[1] Matrix_1.7-4
[4] preprocessCore_1.72.0 dplyr_1.1.4
[7] BiocManager_1.30.26

gtable_0.3.6

[10] dichromat_2.0-0.1
[13] boot_1.3-32
[16] ggplot2_4.0.0
[19] MASS_7.3-65
[22] vsn_3.78.0
[25] pillar_1.11.1
[28] rlang_1.1.6
[31] magrittr_2.0.4
[34] lme4_1.1-37
[37] reformulas_0.4.2
[40] farver_2.1.2

Rcpp_1.1.0
splines_4.5.1
statmod_1.5.1
R6_2.6.1
tibble_3.3.0
minqa_1.2.8
RColorBrewer_1.1-3
S7_0.2.0
Rdpack_2.6.4
nlme_3.1-168
vctrs_0.6.5
tools_4.5.1

limma_3.66.0
compiler_4.5.1
tidyselect_1.2.1
scales_1.4.0
lattice_0.22-7
rbibutils_2.3
nloptr_2.2.1
affy_1.88.0
affyio_1.80.0
cli_3.6.5
grid_4.5.1
lifecycle_1.0.4
glue_1.8.0
pkgconfig_2.0.3

5

