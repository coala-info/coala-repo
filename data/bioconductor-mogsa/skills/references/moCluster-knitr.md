moCluster: Integrative clustering using mul-
tiple omics data

Chen Meng

Modified: June 03, 2015. Compiled: October 30, 2025.

Contents

1

2

3

moCluster overview .

Run moCluster .

2.1

Quick start .

Session info .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

1

1

1

6

1

2

2.1

moCluster overview

Introduction to moCluter algorithm.

Run moCluster

Quick start
In this vignette, we will define subtypes the NCI-60 cell lines using four transcriptomic data
from different microarray platforms. First we load the package and data

# loading package and gene expression data

library(mogsa)
data(NCI60_4arrays)

NCI60_4arrays is a list of data.frame. The list consists of microarray data for NCI-60 cell
In each of the data.frame, columns are the 60 cell lines and
lines from different platforms.
rows are genes. The data was downloaded from [1], but only a small subset of genes were
selected. Therefore, the result in this vignette is not intended for biological interpretation.
Check the dimension of each matrix:

sapply(NCI60_4arrays, dim) # check dimensions of expression data

##

agilent hgu133 hgu133p2 hgu95

## [1,]

## [2,]

300

60

298

60

268

60

288

60

moCluster: Integrative clustering using multiple omics data

Before performing the moCluster analysis, we define some auxiliary variable to indicate the
tissue of origin of cell lines and the color for each:

tumorType <- sapply(strsplit(colnames(NCI60_4arrays$agilent), split="\\."), "[", 1)
colcode <- as.factor(tumorType)

levels(colcode) <- c("red", "green", "blue", "cyan", "orange",

"gray25", "brown", "gray75", "pink")

colcode <- as.character(colcode)

Then we can apply the moCluster algorithm to clustering the 60 cell lines. The moCluster
employs consensus PCA (CPCA) approach to integrate multiple omics data. CPCA approach
is particularly suitable for the integrative clustering algorithm. The First, we call mbpca to
perform the consensus PCA:

moa <- mbpca(NCI60_4arrays, ncomp = 10, k = "all", method = "globalScore", option = "lambda1",

center=TRUE, scale=FALSE, moa = TRUE, svd.solver = "fast", maxiter = 1000)

## calculating component 1 ...

## calculating component 2 ...

## calculating component 3 ...

## calculating component 4 ...

## calculating component 5 ...

## calculating component 6 ...

## calculating component 7 ...

## calculating component 8 ...

## calculating component 9 ...

## calculating component 10 ...

plot(moa, value="eig", type=2)

Figure 1: The variance associated with each latent variable. Colors distinguishes the contributions from
different data sets.

In the above commands, the argument ncomp = 10 specifies that 10 latent variables should
be calculated. The argument k = "all" suggest that no sparsity should be introduced to the
loading factor. Sparsity in loading factor is a preferred property in multiple omics data analysis
since only a subset of the variables would associated with the latent variables. Therefore,
the interpret ability is increased. However, we do not introduce the sparsity for two reasons.
First, we want to evaluate the relative contribution of variance as show in the figure. Second,

2

hgu95hgu133p2hgu133agilent0.00.51.01.52.02.53.03.5moCluster: Integrative clustering using multiple omics data

we will use the permutation test to evaluate the latent variables that are representing the
concordant structures in different data sets. This can be done with a permutation test, that
is, permute the samples in each of the data and do the multi-block PCA:

r <- bootMbpca(moa, mc.cores = 1, B=20, replace = FALSE, resample = "sample")

## method is set to 'globalScore'.

Figure 2: permutation test

The result suggested that the top 3 latent variables account for concordance structures across
data data. The elbow test also shows that the top 3 variables are significant. Therefore,
we will use 3 latent variable in the subsequent analysis. Next, we are ready to calculate the
latent variables with the parse loadings:

moas <- mbpca(NCI60_4arrays, ncomp = 3, k = 0.1, method = "globalScore", option = "lambda1",

center=TRUE, scale=FALSE, moa = TRUE, svd.solver = "fast", maxiter = 1000)

## calculating component 1 ...

## calculating component 2 ...

## calculating component 3 ...

k = 0.1 indicates we only keep 10% variables with non-zero coefficients in the result. The
cluster will be perform using the latent variable, which could be extract by moaScore. We
first extract the latent variables for both the sparse and non-sparse loading results. Then
compare their correlation.

scr <- moaScore(moa)

scrs <- moaScore(moas)

diag(cor(scr[, 1:3], scrs))

##

PC1

PC2

PC3

## 0.9741884 0.9889647 0.9546203

They have a very high correlation so we assume the should account for the same variance or
biological effects. Visualize the plot in the first three dimensions.

layout(matrix(1:2, 1, 2))

plot(scrs[, 1:2], col=colcode, pch=20)

legend("topright", legend = unique(tumorType), col=unique(colcode), pch=20)

3

123456789100.51.02.0____________________moCluster: Integrative clustering using multiple omics data

plot(scrs[, 2:3], col=colcode, pch=20)

Using gap statistic to evaluate the optimal number of clusters

gap <- moGap(moas, K.max = 12, cluster = "hcl")

Figure 3: gap statistic plot

layout(matrix(1, 1, 1))

gap$nClust

##

##

firstSEmax Tibs2001SEmax

globalSEmax

firstmax

globalmax

4

4

7

4

12

Using hierarchical cluster and plot

hcl <- hclust(dist(scrs))

cls <- cutree(hcl, k=4)

clsColor <- as.factor(cls)

levels(clsColor) <- c("red", "blue", "orange", "pink")

clsColor <- as.character((clsColor))

heatmap(t(scrs[hcl$order, ]), ColSideColors = colcode[hcl$order], Rowv = NA, Colv=NA)

4

−0.10−0.050.000.050.10−0.050.000.050.100.15PC1PC2BRCNSCOLEMELCOVPRRE−0.050.000.050.100.15−0.050.000.050.10PC2PC3246810120.10.20.30.40.50.60.70.8clusGap(x = sr, FUNcluster = fhclust, K.max = K.max, B = B,       dist.method = dist.method, dist.diag = dist.diag,       dist.upper = dist.upper, dist.p = dist.p, hcl.method       = hcl.method, hcl.members = hcl.members)kGapkmoCluster: Integrative clustering using multiple omics data

heatmap(t(scrs[hcl$order, ]), ColSideColors = clsColor[hcl$order], Rowv = NA, Colv=NA)

In order to interpret the result, extract the variable with non-zero coefficients

genes <- moaCoef(moas)

genes$nonZeroCoef$agilent.V1.neg

coef
##
FGD3_agilent -0.105242702
## FGD3_agilent
TMC6_agilent -0.045236957
## TMC6_agilent
## GMFG_agilent
GMFG_agilent -0.042502839
## IQGAP2_agilent IQGAP2_agilent -0.001185483

id

5

BR.T47DCO.SW_620CO.HCT_15LC.NCI_H322MLC.EKVXOV.OVCAR_3LC.NCI_H23LE.CCRF_CEMLC.NCI_H522LE.RPMI_8226ME.UACC_62ME.MALME_3MME.MDA_NCNS.SNB_19BR.HS578TME.LOXIMVIRE.ACHNRE.UO_31LC.HOP_92RE.TK_10PC1PC2PC3BR.T47DCO.SW_620CO.HCT_15LC.NCI_H322MLC.EKVXOV.OVCAR_3LC.NCI_H23LE.CCRF_CEMLC.NCI_H522LE.RPMI_8226ME.UACC_62ME.MALME_3MME.MDA_NCNS.SNB_19BR.HS578TME.LOXIMVIRE.ACHNRE.UO_31LC.HOP_92RE.TK_10PC1PC2PC3moCluster: Integrative clustering using multiple omics data

3

Session info

toLatex(sessionInfo())

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,
LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: knitr 1.50, mogsa 1.44.0

• Loaded via a namespace (and not attached): AnnotationDbi 1.72.0, Biobase 2.70.0,
BiocGenerics 0.56.0, BiocManager 1.30.26, BiocStyle 2.38.0, Biostrings 2.78.0,
DBI 1.2.3, GSEABase 1.72.0, IRanges 2.44.0, KEGGREST 1.50.0,
KernSmooth 2.23-26, Matrix 1.7-4, MatrixGenerics 1.22.0, R6 2.6.1, RSQLite 2.4.3,
S4Vectors 0.48.0, Seqinfo 1.0.0, XML 3.99-0.19, XVector 0.50.0, annotate 1.88.0,
bit 4.6.0, bit64 4.6.0-1, bitops 1.0-9, blob 1.2.4, caTools 1.18.3, cachem 1.1.0,
cli 3.6.5, cluster 2.1.8.1, codetools 0.2-20, compiler 4.5.1, corpcor 1.6.10,
crayon 1.5.3, digest 0.6.37, evaluate 1.0.5, fastmap 1.2.0, genefilter 1.92.0,
generics 0.1.4, gplots 3.2.0, graph 1.88.0, graphite 1.56.0, grid 4.5.1, gtools 3.9.5,
highr 0.11, htmltools 0.5.8.1, httr 1.4.7, lattice 0.22-7, matrixStats 1.5.0,
memoise 2.0.1, parallel 4.5.1, png 0.1-8, rappdirs 0.3.3, rlang 1.1.6, rmarkdown 2.30,
splines 4.5.1, stats4 4.5.1, survival 3.8-3, svd 0.5.8, tinytex 0.57, tools 4.5.1,
vctrs 0.6.5, xfun 0.53, xtable 1.8-4, yaml 2.3.10

References

[1] Reinhold WC, Sunshine M, Liu H, Varma S, Kohn KW, Morris J, Doroshow J, and
Pommier Y. Cellminer: A web-based suite of genomic and pharmacologic tools to
explore transcript and drug patterns in the nci-60 cell line set. Cancer Research,
72(14):3499–511, 2012.

6

