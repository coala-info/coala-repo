Working with Illumina 450k Methylation Arrays

Tim Triche, Jr. & Sean Davis

October 30, 2025

Contents

1 Creating a MethyLumiSet object from IDATs

2 Negative and normalization controls

3 Preprocessing the raw data

4 Coercions to other data structures

5 sessionInfo

2

3

5

7

11

1

1 Creating a MethyLumiSet object from IDATs

This also happens to be the first step in the TCGA processing pipeline. The complete
pipeline is available on GitHub as the EGC.tools project. Ten samples from the TCGA
breast cancer (BRCA) project are included in the TCGAMethylation450k package, which
should be installed for this step.

suppressPackageStartupMessages(require('methylumi'))
suppressPackageStartupMessages(require('TCGAMethylation450k'))
suppressPackageStartupMessages(require('FDb.InfiniumMethylation.hg19'))

## read in 10 BRCA IDATs
idatPath <- system.file('extdata/idat',package='TCGAMethylation450k')
mset450k <- methylumIDAT(getBarcodes(path=idatPath), idatPath=idatPath)

## 0 HumanMethylation27 samples found
## 10 HumanMethylation450 samples found
## Attempting to extract protocolData() from list...
## Determining chip type from IDAT protocolData...

sampleNames(mset450k) <- paste0('TCGA', seq_along(sampleNames(mset450k)))
show(mset450k)

element names: betas, methylated, methylated.OOB, pvals, unmethylated, unmethylated.OOB

total)

featureNames: cg00000029 cg00000108 ...

sampleNames: TCGA1 TCGA2 ... TCGA10 (10

varLabels: barcode
varMetadata: labelDescription

##
## Object Information:
## MethyLumiSet (storageMode: lockedEnvironment)
## assayData: 485577 features, 10 samples
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
##
##
## experimentData: use 'experimentData(object)'
## Annotation: IlluminaHumanMethylation450k
## Major Operation History:
##
submitted
## 1 2025-10-30 01:03:09.519421
## 2 2025-10-30 01:03:33.993608
##
finished
## 1 2025-10-30 01:03:32.915704
## 2 2025-10-30 01:03:35.351797
##
command
## 1 methylumIDAT(barcodes = getBarcodes(path = idatPath), idatPath = idatPath)
Subset of 485577 features.
## 2

fvarLabels: Probe_ID DESIGN COLOR_CHANNEL
fvarMetadata: labelDescription

rs9839873 (485577 total)

Note that the default is to collect opposite-channel fluorescence from Type I methy-
lation probes (which are paired and designed to fluoresce in one channel) in the matrices
’methylated.OOB’ and ’unmethylated.OOB’ (OOB, as in out-of-band) for use in background
correction and perhaps additional steps. This also allows a user to coerce the resulting object
into minfi’s RGChannelSet if desired since all of the signal information in the IDATs is thus
retained.

2

2 Negative and normalization controls

Plot the negative and normalization controls:

3

library(ggplot2)
## for larger datasets, the by.type argument be set to FALSE
## positional effects will manifest as a wave-like pattern
p <- qc.probe.plot(mset450k, by.type=TRUE)

## Warning: ‘qplot()‘ was deprecated in ggplot2 3.4.0.
## i The deprecated feature was likely used in the

##

print(p)

##

methylumi package.
Please report the issue at
<https://github.com/seandavi/methylumi/issues/new>.

##

## This warning is displayed once every 8 hours.
## Call ‘lifecycle::last lifecycle warnings()‘ to
## see where this warning was generated.

4

Figure 1: Some of the controls on the 450k chip

Cy3 (Green)Cy5 (Red)NEGATIVENORM_ANORM_TNORM_CNORM_G6451240963276864512409632768TCGA10TCGA9TCGA8TCGA7TCGA6TCGA5TCGA4TCGA3TCGA2TCGA1TCGA10TCGA9TCGA8TCGA7TCGA6TCGA5TCGA4TCGA3TCGA2TCGA1TCGA10TCGA9TCGA8TCGA7TCGA6TCGA5TCGA4TCGA3TCGA2TCGA1TCGA10TCGA9TCGA8TCGA7TCGA6TCGA5TCGA4TCGA3TCGA2TCGA1TCGA10TCGA9TCGA8TCGA7TCGA6TCGA5TCGA4TCGA3TCGA2TCGA1IntensitiesSampletypeNEGATIVENORM_ANORM_TNORM_CNORM_GNegative & normalization control probes3 Preprocessing the raw data

After importing the data from IDATs, the next step is to background correct and dye bias
equalize the data. The default for background correction is a normal- exponential model
which uses the out-of-band intensities as control probes. Dye bias correction is performed
by picking the least-biased sample, and using it as a reference for red:green intensity ratio
adjustments based on the normalization controls. Other approaches to preprocessing (as im-
plemented in minfi and lumi) include various flavors of quantile normalization and smoothing
spline fits.

After preprocessing, we can reduce the size of the resulting MethyLumiSet substantially
by dropping the out-of-band intensities with stripOOB(). This frees up some memory, but
precludes later coercion to an RGChannelSet.

mset450k.proc <- stripOOB(normalizeMethyLumiSet(methylumi.bgcorr(mset450k)))

## Background mean & SD estimated from 178406 probes

MASS

## Loading required package:
##
## Attaching package:
## The following object is masked from ’package:AnnotationDbi’:
##
##

select

’MASS’

## Background mean & SD estimated from 92596 probes

## Normalizing via Illumina controls...
## Using sample number 5 as reference level...

Now we compare the post-processing controls with those from figure 1.

5

library(ggplot2)
p2 <- qc.probe.plot(mset450k.proc, by.type=TRUE)
print(p2)

Figure 2: Controls after preprocessing

6

Cy3 (Green)Cy5 (Red)NEGATIVENORM_ANORM_TNORM_CNORM_G6451240963276864512409632768TCGA10TCGA9TCGA8TCGA7TCGA6TCGA5TCGA4TCGA3TCGA2TCGA1TCGA10TCGA9TCGA8TCGA7TCGA6TCGA5TCGA4TCGA3TCGA2TCGA1TCGA10TCGA9TCGA8TCGA7TCGA6TCGA5TCGA4TCGA3TCGA2TCGA1TCGA10TCGA9TCGA8TCGA7TCGA6TCGA5TCGA4TCGA3TCGA2TCGA1TCGA10TCGA9TCGA8TCGA7TCGA6TCGA5TCGA4TCGA3TCGA2TCGA1IntensitiesSampletypeNEGATIVENORM_ANORM_TNORM_CNORM_GNegative & normalization control probes4 Coercions to other data structures

Coercions are provided to and from various data structures in the lumi and minfi packages.
Each provides various functionality and exhibits different design decisions. One may be more
appropriate than the other for some needs. Preprocessing in methylumi retains SNP probes,
which can identify label swaps, but is less efficient than preprocessing in minfi, and cannot
use shinyMethyl.

Coercing to lumi (e.g. for lumiMethyN or similar):

suppressPackageStartupMessages(require(lumi))

## No methods found in package ’RSQLite’ for request: ’dbListFields’ when loading ’lumi’

mset450k.lumi <- as(mset450k.proc, 'MethyLumiM')
show(mset450k.lumi)

element names: detection, exprs, methylated, unmethylated

total)

sampleNames: TCGA1 TCGA2 ... TCGA10 (10

varLabels: barcode mu.Cy3 ... offset.Cy5

## MethyLumiM (storageMode: lockedEnvironment)
## assayData: 485577 features, 10 samples
##
## protocolData: none
## phenoData
##
##
##
##
##
## featureData
##
##
##
##
## experimentData: use 'experimentData(object)'
## Annotation: IlluminaHumanMethylation450k

fvarLabels: Probe_ID DESIGN COLOR_CHANNEL
fvarMetadata: labelDescription

featureNames: cg00000029 cg00000108 ...

varMetadata: labelDescription

rs9839873 (485577 total)

(9 total)

7

Coercing back to a MethyLumiSet:

mset450k.andBack <- as(mset450k.lumi, 'MethyLumiSet')
show(mset450k.andBack)

total)

(9 total)

rs9839873 (485577 total)

varMetadata: labelDescription

featureNames: cg00000029 cg00000108 ...

sampleNames: TCGA1 TCGA2 ... TCGA10 (10

varLabels: barcode mu.Cy3 ... offset.Cy5

element names: betas, methylated, pvals, unmethylated

fvarLabels: Probe_ID DESIGN COLOR_CHANNEL
fvarMetadata: labelDescription

##
## Object Information:
## MethyLumiSet (storageMode: lockedEnvironment)
## assayData: 485577 features, 10 samples
##
## protocolData: none
## phenoData
##
##
##
##
##
## featureData
##
##
##
##
## experimentData: use 'experimentData(object)'
## Annotation: IlluminaHumanMethylation450k
## Major Operation History:
##
submitted
## 1 2025-10-30 01:03:09.519421
## 2 2025-10-30 01:03:33.993608
## 3 2025-10-30 01:03:45.084585
## 4 2025-10-30 01:03:54.762187
## 5 2025-10-30 01:03:57.661205
## 6 2025-10-30 01:04:05.345322
##
finished
## 1 2025-10-30 01:03:32.915704
## 2 2025-10-30 01:03:35.351797
01:03:54
## 3
01:03:57
## 4
## 5 2025-10-30 01:03:57.661609
## 6
2025-10-30 01:04:06.0381
##
command
## 1 methylumIDAT(barcodes = getBarcodes(path = idatPath), idatPath = idatPath)
Subset of 485577 features.
## 2
methylumi.bgcorr(x = mset450k)
## 3
## 4
normalizeViaControls(x = x)
stripOOB(object = normalizeMethyLumiSet(methylumi.bgcorr(mset450k)))
## 5
## 6
asMethod(from = object)
##
## 1
## 2
## 3
## 4
## 5
## 6

lumiVersion
<NA>
<NA>
<NA>
<NA>
<NA>
2.56.0

8

MethyLumiSet objects with OOB matrices can be coerced to RGChannelSet objects for

further processing using functions found in the minfi or ChAMP packages.

suppressPackageStartupMessages(require(FDb.InfiniumMethylation.hg19))
rgSet450k <- as(mset450k, 'RGChannelSet')

## Loading required package:
## Fetching coordinates for hg19...

rtracklayer

show(rgSet450k)

## class: RGChannelSet
## dim: 621928 10
## metadata(0):
## assays(2): Green Red
## rownames(621928): 14782418 12709357 ...
##
## rowData names(0):
## colnames(10): TCGA1 TCGA2 ... TCGA9 TCGA10
## colData names(1): barcode
## Annotation
##

array: IlluminaHumanMethylation450k

28673402 13742412

The above will not work for the processed data, but only because we called stripOOB()
on the resulting object to reduce its size. If you plan on using a preprocessed MethyLumiSet
in minfi for further processing, don’t strip it.

The GenomicMethylSet and GenomicRatioSet classes in minfi inherit from the Ranged-

SummarizedExperiment class, which has some particularly useful features:

suppressPackageStartupMessages(require(minfi))
suppressPackageStartupMessages(require(IlluminaHumanMethylation450kanno.ilmn12.hg19))
grSet450k <- mapToGenome(mset450k.andBack)

sexChroms <- GRanges( seqnames=c('chrX','chrY'),

IRanges(start=c(1, 1),

end=c(155270560, 59373566)),

strand=c('*','*') )

summary(subsetByOverlaps(grSet450k, sexChroms))

## [1] "GenomicMethylSet object of length 11648 with 0 metadata columns"

dim(subsetByOverlaps(grSet450k, sexChroms))

## [1] 11648

10

9

These SummarizedExperiment-derived objects can be subsetted by nearly anything that
has an interval-based representation. Here we extract some promoters, but one could just as
easily use AnnotationHub resources to find CTCF peaks or, say, H3K4me1 peaks in ChIP-
seq data (often associated with transcriptional enhancers; the presence or absence of DNA
methylation may help determine their activity).

## perhaps more topical:
suppressPackageStartupMessages(require(TxDb.Hsapiens.UCSC.hg19.knownGene))
suppressPackageStartupMessages(require(Homo.sapiens))
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

KDM6AEntrezID=org.Hs.egSYMBOL2EG[['KDM6A']]
txs.KDM6A <- transcriptsBy(txdb, 'gene')[[KDM6AEntrezID]]
tss.KDM6A <- unique(resize(txs.KDM6A, 1, fix='start')) ## two start sites
promoters.KDM6A <- flank(tss.KDM6A, 100) ## an arbitrary distance upstream
show( subsetByOverlaps(grSet450k, promoters.KDM6A) ) ## probes in this window

cg17824914 cg06877198

## class: GenomicMethylSet
## dim: 6 10
## metadata(0):
## assays(2): Meth Unmeth
## rownames(6): cg14384228 cg07167981 ...
##
## rowData names(0):
## colnames(10): TCGA1 TCGA2 ... TCGA9 TCGA10
## colData names(9): barcode mu.Cy3 ...
##
## Annotation
##
##
## Preprocessing
##
##
##

array: IlluminaHumanMethylation450k
annotation: ilmn12.hg19

alpha.Cy5 offset.Cy5

Method: methylumi, background corrected, dye bias equalized
minfi version: 1.56.0
Manifest version: 0.4

Consult the AnnotationHub package vignette for some other possibilities.

If you are
unfamiliar with the powerful GenomicRanges and GenomicFeatures packages, you may want
to familiarize yourself with them as well.

10

5

sessionInfo

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

Biostrings 2.78.0, FDb.InfiniumMethylation.hg19 2.2.0, GO.db 3.22.0,
GenomicFeatures 1.62.0, GenomicRanges 1.62.0, Homo.sapiens 1.3.1, IRanges 2.44.0,
IlluminaHumanMethylation450kanno.ilmn12.hg19 0.6.1, MASS 7.3-65,
MatrixGenerics 1.22.0, OrganismDbi 1.52.0, S4Vectors 0.48.0, Seqinfo 1.0.0,
SummarizedExperiment 1.40.0, TCGAMethylation450k 1.45.0,
TxDb.Hsapiens.UCSC.hg19.knownGene 3.22.1, XVector 0.50.0, bumphunter 1.52.0,
foreach 1.5.2, generics 0.1.4, ggplot2 4.0.0, iterators 1.0.14, knitr 1.50, lattice 0.22-7,
limma 3.66.0, locfit 1.5-9.12, lumi 2.62.0, matrixStats 1.5.0, methylumi 2.56.0,
minfi 1.56.0, org.Hs.eg.db 3.22.0, reshape2 1.4.4, rtracklayer 1.70.0, scales 1.4.0,
xtable 1.8-4

• Loaded via a namespace (and not attached): BiocIO 1.20.0, BiocManager 1.30.26,
BiocParallel 1.44.0, DBI 1.2.3, DelayedArray 0.36.0, DelayedMatrixStats 1.32.0,
GEOquery 2.78.0, GenomeInfoDb 1.46.0, GenomicAlignments 1.46.0,
HDF5Array 1.38.0, KEGGREST 1.50.0, KernSmooth 2.23-26, Matrix 1.7-4, R6 2.6.1,
RBGL 1.86.0, RColorBrewer 1.1-3, RCurl 1.98-1.17, RSQLite 2.4.3, Rcpp 1.1.0,
Rhdf5lib 1.32.0, Rsamtools 2.26.0, S4Arrays 1.10.0, S7 0.2.0, SparseArray 1.10.0,
UCSC.utils 1.6.0, XML 3.99-0.19, abind 1.4-8, affy 1.88.0, affyio 1.80.0,
annotate 1.88.0, askpass 1.2.1, base64 2.0.2, beanplot 1.3.1, bit 4.6.0, bit64 4.6.0-1,

11

bitops 1.0-9, blob 1.2.4, cachem 1.1.0, cigarillo 1.0.0, cli 3.6.5, codetools 0.2-20,
compiler 4.5.1, crayon 1.5.3, curl 7.0.0, data.table 1.17.8, dichromat 2.0-0.1,
digest 0.6.37, doRNG 1.8.6.2, dplyr 1.1.4, evaluate 1.0.5, farver 2.1.2, fastmap 1.2.0,
genefilter 1.92.0, glue 1.8.0, graph 1.88.0, grid 4.5.1, gtable 0.3.6, h5mread 1.2.0,
highr 0.11, hms 1.1.4, httr 1.4.7, illuminaio 0.52.0, jsonlite 2.0.0, lifecycle 1.0.4,
magrittr 2.0.4, mclust 6.1.1, memoise 2.0.1, mgcv 1.9-3, multtest 2.66.0, nleqslv 3.3.5,
nlme 3.1-168, nor1mix 1.3-3, openssl 2.3.4, pillar 1.11.1, pkgconfig 2.0.3, plyr 1.8.9,
png 0.1-8, preprocessCore 1.72.0, purrr 1.1.0, quadprog 1.5-8, readr 2.1.5,
rentrez 1.2.4, reshape 0.8.10, restfulr 0.0.16, rhdf5 2.54.0, rhdf5filters 1.22.0,
rjson 0.2.23, rlang 1.1.6, rngtools 1.5.2, scrime 1.3.5, siggenes 1.84.0,
sparseMatrixStats 1.22.0, splines 4.5.1, statmod 1.5.1, stringi 1.8.7, stringr 1.5.2,
survival 3.8-3, tibble 3.3.0, tidyr 1.3.1, tidyselect 1.2.1, tools 4.5.1, tzdb 0.5.0,
vctrs 0.6.5, withr 3.0.2, xfun 0.53, xml2 1.4.1, yaml 2.3.10

12

