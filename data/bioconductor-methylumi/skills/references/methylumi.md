An Introduction to the methylumi package

Sean Davis and Sven Bilke

October 30, 2025

1

Introduction

Gene expression patterns are very important in understanding any biologic system. The
regulation of gene expression is a complex, poorly understood process. However, DNA
methylation is one biological process that is known to be important in gene regulation. In
short, DNA methylation is a chemical modification of DNA CpG sites in which a methyl
In humans, the DNA
group is added number 5 carbon of the cytosine pyrimidine ring.
methyltransferases (DNMT1, DNMT3a, and DNMT3b) are the enzymes responsible for
carrying out the methylation.

The Illumina GoldenGate methylation profiling technology specifically targets more than
1500 CpG sites throughout the genome, specifically targeting approximately 700 “cancer
genes”. Samples are run in 96-well format, making the technology very high-throughput.
After a two-color hybridization, a laser captures the intensities associated with the methy-
lated state and the accompanying unmethylated state. The Illumina BeadStudio software is
then used for quality control and basic visualization tasks. A newer platform, the Illumina
Infinium Methylation platform provides a more “whole-genome” view of DNA methylation.
Utilizing the Infinium profiling technology on bisulfite-treated DNA, the methylation sta-
tus of more than 25,000 individual CpG sites is assayed simultaneously. This package can
handle both types of data. Note that normalization functions here are really specific to the
GoldenGate platform and are probably not optimal for Infinium data.

The methylumi package provides convenient mechanisms for loading the results of the Il-
lumina methylation platform into R/Bioconductor. Classes based on common Bioconductor
classes for encapsulating the data and facilitate data manipulation are at the core of the
package, with methods for quality control, normalization (for GoldenGate, in particular),
and plotting.

2 Loading Data

After exporting the data from BeadStudio, methylumi can read them in with a single com-
mand. To include rich sample annotation, it is possible to supply a data.frame including
that sample annotation. This can be read from disk or constructed on-the-fly for flexibility.

1

If used, a SampleID column must be present and match the sample IDs used in the Bead-
Studio export file. Also, if a column called SampleLabel is present in the data frame and it
includes unique names, the values from that column will be used for the sampleNames of
the resulting MethyLumiSet.

Two different formats can be read by methylumi. The “Final Report” format includes
all the data in a single file. The package will look “[Header]” in the file to determine when
that file format is to be used. The data block “[Sample Methylation Profile]” needs to be
present in the “Final Report” format. If the data block “[Control Probe Profile]” is present,
these data will be included in the QCdata of the resulting MethyLumiSet object. The second
format can be a simple tab-delimited text file with headers from BeadStudio. If this format
is used, the sample data and the QC data can be in separate files. The QC data need not be
present for either format, but it can be helpful for quality control of data. For the examples
in this vignette, a small sample set run on the Illumina GoldenGate platform will be used
and the file format is the tab-delimited format.

suppressPackageStartupMessages(library(methylumi,quietly=TRUE))
samps <- read.table(system.file("extdata/samples.txt",

mldat <- methylumiR(system.file('extdata/exampledata.samples.txt',package='methylumi'),

package = "methylumi"),sep="\t",header=TRUE)

qcfile=system.file('extdata/exampledata.controls.txt',package="methylumi"),
sampleDescriptions=samps)

Only a subset of an entire plate is included here for illustration purposes. The mldat ob-
ject now contains the data (in an eSet-like object) and quality control information (available
as QCdata(mldat), also an eSet-like object) from a set of experiments. The details of what
was loaded can be viewed:

mldat

element names: Avg_NBEADS, BEAD_STDERR, betas, methylated, pvals, unmethylated

##
## Object Information:
## MethyLumiSet (storageMode: lockedEnvironment)
## assayData: 1536 features, 10 samples
##
## protocolData: none
## phenoData
##
##
##
##
## featureData
##
##

sampleNames: M_1 M_2 ... F_10 (10 total)
varLabels: sampleID SampleLabel Sample

featureNames: AATK_E63_R AATK_P519_R ...

varMetadata: labelDescription

ZP3_P220_F (1536 total)

Gender

2

(17 total)

fvarMetadata: labelDescription

fvarLabels: TargetID ProbeID ... PRODUCT

##
##
##
## experimentData: use 'experimentData(object)'
## Annotation:
## Major Operation History:
submitted
##
## 1 2025-10-30 01:02:59.341754
##
finished
## 1 2025-10-30 01:02:59.603652
##
## 1 methylumiR(filename = system.file("extdata/exampledata.samples.txt",

package = "methylumi"), qcfile = system.file("extdata/exampledata.controls.txt",

package = "methylumi"), sampleDescriptions = samps)

command

Accessors for various slots of the resulting object are outlined in the online help. It is
worth noting, though, that the QCdata will return another eSet-like object of class Methy-
LumiQC ; the data contained here can be useful if an array has failed.

Note that the assayData names have been changed from the original column identifiers in

the data file from Illumina. The mappings are available via the function getAssayDataNameSubstitutions.

getAssayDataNameSubstitutions()

regex
##
## 1
AVG_Beta
## 2 Detection Pval
## 3
## 4
## 5
## 6
## 7
## 8

result
betas
pvals
Signal CY3 unmethylated
Signal CY5
methylated
Signal_Red unmethylated
methylated
Signal_Grn
Signal_A unmethylated
methylated
Signal_B

3 Quality Control

The data that are included with the methylumi package are all normal samples from the
same tissue. The samples are labeled with the presumed gender. The data are meant to
be illustrative of some typical quality-control and sample-labeling problems. In order to get
a quick overview of the samples, it is useful to look at an MDS plot of the samples, using
only probes on the X chromosome. Since females undergo X-inactivation, they should show
something approximating hemi-methylation on that chromosome while males should show
very little methylation on the X chromosome.

3

md <- cmdscale(dist(t(exprs(mldat)[fData(mldat)$CHROMOSOME=='X',])),2)

plot(md,pch=c('F','M')[pData(mldat)$Gender],col=c('red','blue')[pData(mldat)$Gender])

The MDS plot shows that the males and females are quite distinct except for a single
male that groups with the females. Upon consultation with the laboratory investigator, the
sample was found to be mislabeled. Also, it is worth noting that the males do not cluster
nearly as tightly as the females. A quick evaluation of the p-values for detection for the
samples will show what the problem is:

4

−20−10010−15−10−50510md[,1]md[,2]avgPval <- colMeans(pvals(mldat))
par(las=2)
barplot(avgPval,ylab="Average P-Value")

So, it is quite obvious that there are two arrays that fail QC with a large percentage of

the reporters showing lack of measurement.

It is also possible to use the qcplot method in combination with controlTypes to examine

the QC data in more detail. The control types for the GoldenGate platform are:

5

M_1M_2M_3M_4F_5F_6F_7F_8M_9F_10Average P−Value0.000.050.100.15controlTypes(mldat)

## [1] "ALLELE SPECIFIC EXTENSION"
## [2] "EXTENSION GAP"
## [3] "FIRST HYBRIDIZATION"
## [4] "GENDER"
## [5] "NEGATIVE"
## [6] "PCR CONTAMINATION"
## [7] "SECOND HYBRIDIZATION"

Looking more closely at the hybridization controls (“FIRST HYBRIDIZATION”) is

telling here:

qcplot(mldat,"FIRST HYBRIDIZATION")

6

So, it appears that the hybridization controls (at least) failed for samples “M 1” and

“M 4”, which might help explain why the samples failed.

4 Normalization

The Illumina platform shows a significant dye bias in the two channels which will lead to
bias in the estimates of Beta on the GoldenGate platform. Therefore, some normalization
is required. The function, normalizeMethyLumiSet does this normalization. Basically, it

7

FIRST HYBRIDIZATIONunmethylatedM_1M_2M_3M_4F_5F_6F_7F_8M_9F_100FIRST HYBRIDIZATIONFIRST HYBRIDIZATION.1FIRST HYBRIDIZATIONmethylatedM_1M_2M_3M_4F_5F_6F_7F_8M_9F_100FIRST HYBRIDIZATIONFIRST HYBRIDIZATION.1looks at the median intensities in the methylated and unmethylated channels (each measured
in one color on the GoldenGate platform) at very low and very high beta values and sets
these medians equal. Using the transformed unmethylated and methylated values, new beta
values are calculated using one of two “map” functions. The ratio function is the default
and is the same as used by Illumina in the BeadStudio software, but values using the atan
selection should be similar.

First, a bit of cleanup is needed. The two samples with significantly poorer quality are

removed. The gender of the mis-labeled sample is also corrected.

toKeep <- (avgPval<0.05)
pData(mldat)$Gender[9] <- "F"
mldat.norm <- normalizeMethyLumiSet(mldat[,toKeep])

5 Example Analysis

As a simple example of an analysis, we can look for the differences between males and females.
We already know there is a strong difference based on simple unsupervized methods (the MDS
plot). However, methylation is particularly informative for sex differences because females
undergo X-inactivation and are, therefore, expected to have one copy of the X chromosome
largely methylated. Note that, while limma is used here to illustrate a point,
an appropriate statistical framework for finding differential methylation targets
based on the Illumina methylation platforms with data that is not normally
distributed under the null is a current research topic for a number of groups.

library(limma)

##
## Attaching package:
## The following object is masked from ’package:BiocGenerics’:
##
##

’limma’

plotMA

dm <- model.matrix(~1+Gender,data=pData(mldat.norm))
colnames(dm)

## [1] "(Intercept)" "GenderM"

fit1 <- lmFit(exprs(mldat.norm),dm)
fit2 <- eBayes(fit1)
tt <- topTable(fit2,coef=2,genelist=fData(mldat.norm)[,c('SYMBOL','CHROMOSOME')],number=1536)
x <- aggregate(tt$adj.P.Val,by=list(tt$CHROMOSOME),median)
colnames(x) <- c('Chromosome','Median adjusted P-value')

8

library(xtable)
xt <- xtable(x,label="tab:chromosomepvals",caption="The median adjusted p-value for each chromosome showing that the X-chromosome is highly significantly different between males and females")
digits(xt) <- 6
print(xt,include.rownames=FALSE,align="cr")

Chromosome Median adjusted P-value
0.998947
1
0.998947
10
0.998947
11
0.998947
12
0.998947
13
0.998947
14
0.998947
15
0.998947
16
0.998947
17
0.998947
18
0.998947
19
0.998947
2
0.998947
20
0.998947
21
0.998947
22
0.998947
3
0.998947
4
0.998947
5
0.998947
6
0.998947
7
0.998947
8
0.998947
9
0.000114
X

Table 1: The median adjusted p-value for each chromosome showing that the X-chromosome
is highly significantly different between males and females

Looking at the median adjusted p-values for the resulting differences (calculated using
limma), one can quickly see that the X chromosome is, indeed, quite significantly different,
on the whole, between males and females. The actual p-values are plotted to show the
distribution.

6

sessionInfo

9

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

• Base packages: base, datasets, grDevices, graphics, methods, parallel, stats, stats4,

utils

• Other packages: AnnotationDbi 1.72.0, Biobase 2.70.0, BiocGenerics 0.56.0,

Biostrings 2.78.0, FDb.InfiniumMethylation.hg19 2.2.0, GenomicFeatures 1.62.0,
GenomicRanges 1.62.0, IRanges 2.44.0, MatrixGenerics 1.22.0, S4Vectors 0.48.0,
Seqinfo 1.0.0, SummarizedExperiment 1.40.0,
TxDb.Hsapiens.UCSC.hg19.knownGene 3.22.1, XVector 0.50.0, bumphunter 1.52.0,
foreach 1.5.2, generics 0.1.4, ggplot2 4.0.0, iterators 1.0.14, knitr 1.50, lattice 0.22-7,
limma 3.66.0, locfit 1.5-9.12, matrixStats 1.5.0, methylumi 2.56.0, minfi 1.56.0,
org.Hs.eg.db 3.22.0, reshape2 1.4.4, scales 1.4.0, xtable 1.8-4

• Loaded via a namespace (and not attached): BiocIO 1.20.0, BiocParallel 1.44.0,
DBI 1.2.3, DelayedArray 0.36.0, DelayedMatrixStats 1.32.0, GEOquery 2.78.0,
GenomeInfoDb 1.46.0, GenomicAlignments 1.46.0, HDF5Array 1.38.0,
KEGGREST 1.50.0, MASS 7.3-65, Matrix 1.7-4, R6 2.6.1, RColorBrewer 1.1-3,
RCurl 1.98-1.17, RSQLite 2.4.3, Rcpp 1.1.0, Rhdf5lib 1.32.0, Rsamtools 2.26.0,
S4Arrays 1.10.0, S7 0.2.0, SparseArray 1.10.0, UCSC.utils 1.6.0, XML 3.99-0.19,
abind 1.4-8, annotate 1.88.0, askpass 1.2.1, base64 2.0.2, beanplot 1.3.1, bit 4.6.0,
bit64 4.6.0-1, bitops 1.0-9, blob 1.2.4, cachem 1.1.0, cigarillo 1.0.0, cli 3.6.5,
codetools 0.2-20, compiler 4.5.1, crayon 1.5.3, curl 7.0.0, data.table 1.17.8,
dichromat 2.0-0.1, digest 0.6.37, doRNG 1.8.6.2, dplyr 1.1.4, evaluate 1.0.5,
farver 2.1.2, fastmap 1.2.0, genefilter 1.92.0, glue 1.8.0, grid 4.5.1, gtable 0.3.6,
h5mread 1.2.0, highr 0.11, hms 1.1.4, httr 1.4.7, illuminaio 0.52.0, jsonlite 2.0.0,

10

lifecycle 1.0.4, magrittr 2.0.4, mclust 6.1.1, memoise 2.0.1, multtest 2.66.0,
nlme 3.1-168, nor1mix 1.3-3, openssl 2.3.4, pillar 1.11.1, pkgconfig 2.0.3, plyr 1.8.9,
png 0.1-8, preprocessCore 1.72.0, purrr 1.1.0, quadprog 1.5-8, readr 2.1.5,
rentrez 1.2.4, reshape 0.8.10, restfulr 0.0.16, rhdf5 2.54.0, rhdf5filters 1.22.0,
rjson 0.2.23, rlang 1.1.6, rngtools 1.5.2, rtracklayer 1.70.0, scrime 1.3.5,
siggenes 1.84.0, sparseMatrixStats 1.22.0, splines 4.5.1, statmod 1.5.1, stringi 1.8.7,
stringr 1.5.2, survival 3.8-3, tibble 3.3.0, tidyr 1.3.1, tidyselect 1.2.1, tools 4.5.1,
tzdb 0.5.0, vctrs 0.6.5, withr 3.0.2, xfun 0.53, xml2 1.4.1, yaml 2.3.10

11

print(xyplot(-log10(adj.P.Val)~CHROMOSOME,
tt,ylab="-log10(Adjusted P-value)",
main="P-values for probes\ndistinguising males from females"))
## Warning in order(as.numeric(x)): NAs introduced by coercion
## Warning in diff(as.numeric(x[ord])): NAs introduced by coercion
## Warning in (function (x, y, type = "p", groups = NULL, pch = if
(is.null(groups)) plot.symbol$pch else superpose.symbol$pch, : NAs
introduced by coercion

12
Figure 1: Probes differentially methylated plotted by chromosome. Note that the p-values
plotted here are based on a linear model. Since the underlying data are not normally
distributed, the p-values representing the outcomes of the linear models are not exact.

P−values for probesdistinguising males from femalesCHROMOSOME−log10(Adjusted P−value)02461X