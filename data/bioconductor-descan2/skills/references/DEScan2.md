# DEScan2

Dario Righelli - John Koberstein - Bruce Gomes

#### 2025-10-29

# Contents

* [1 Overview](#overview)
* [2 A typical differential enrichment analysis workflow](#a-typical-differential-enrichment-analysis-workflow)
* [3 A note on performance and serial computing](#a-note-on-performance-and-serial-computing)

# 1 Overview

This document describes how to use DEScan2 to detect regions of differential
enrichment in epigenomic sequencing data. DEScan2 is an R/Bioconductor based
tool, developed for Bioconductor v3.6 and R v3.4.3.

# 2 A typical differential enrichment analysis workflow

First, let’s load the packages and set serial computations.

```
library("DEScan2")
library("RUVSeq")
library("edgeR")
BiocParallel::register(BiocParallel::SerialParam())
```

##Example data

This analysis will make use of mouse Sono-seq data from mouse chromosome 19.
This data is a small portion of data obtained from hippocampus of mice following
learning through contextual fear conditioning. The experiment has 4 fear
conditioned (FC) and 4 homecage control (HC) replicates. The data was aligned to
the mouse genome (mm9) using bowtie2, allowing for multi-mapping reads.
Duplicates were removed if present in isolation from duplicated reads relative
to genomic location. Aligned data in this example is provided as bed files, but
DEScan accepts bam format alignments.

```
bam.files <- list.files(system.file(file.path("extdata","bam"),
                        package="DEScan2"),
                        pattern="bam$", full.names=TRUE)
```

##Calling peaks for each sample
First, peak calling for the samples will be done using the *findPeaks* function.
Bam files are used as input in this case, but bed files work as well (in any
case we reccomend to specify a genome code as reference for the data).
We will perform this step on a single sample in the interest of time; however,
note that a vector of file names can be supplied.
If the **save** flag is set to TRUE the function will produce a sorted bed file
for each input file in the folder **outputFolder** (“peaks” directory is the
default). *findPeaks* implements an adaptive window size scan to find peaks, and
requires 2 parameters to define the size of the overlapping windows to be tested
for enrichment. Enrichment for each window is calculated relative to
**minCompWinWidth** 5kb, **maxCompWinWidth** 10kb (local) or the whole
chromosome, and the maximum among the three is reported.

Parameter description:

**files**
:   Character vector containing paths of files to be analyzed.

**filetype**
:   Character, either “bam” or “bed” indicating format of input file.

**binSize**
:   Integer size in base pairs of the minimum window for scanning, 50 is the
    default.

**minWin**
:   Integer indicating the minimum window size in base pairs, 50 is the default.
    (A multiple of binSize)

**maxWin**
:   Integer indicating the maximum allowed window size in units of 50 bp, 1000 is
    the default. (A multiple of binSize)

**minCompWinWidth**
:   minimum bases width of a comparing background window for Z-score (default is
    5000).

**maxCompWinWidth**
:   maximum bases width of a comparing background window for Z-score (default is
    10000).

**zthresh**
:   Cuttoff value for z-scores, default is 10. Only windows with greater z-scores
    will be kept.

**minCount**
:   A small constant (usually no larger than one) to be added to the counts prior
    to the log transformation to avoid problems with log(0).

**sigwin**
:   an integer value used to compute the length of the signal of a peak (default
    value is 10).

**save**
:   Flag indicating if tha output has to be saved

**outputFolder**
:   A string, Name of the folder to save the Peaks (optional), if the directory
    doesn’t exist, it will be created. default is “Peaks”.

**force**
:   A boolean flag indicating if to force output overwriting.

**genomeName**
:   The code of the genome to use as reference for the input files.
    We strongly recommend (particularly with bed files) to specify a genome code,
    but, if there is no internet connection or problems contacting the server, this
    argument can be not used.

**onlyStdChrs**
:   a flag to work only with standard chromosomes (cfr. constructBedRanges
    function parameters)

**chr** if not NULL, a character like “chr#” indicating the chromosomes to use

```
peaksGRL <- DEScan2::findPeaks(files=bam.files[1], filetype="bam", genomeName="mm9",
    binSize=50, minWin=50, maxWin=1000, zthresh=10, minCount=0.1, sigwin=10,
    minCompWinWidth=5000, maxCompWinWidth=10000, save=FALSE,
    outputFolder="peaks", force=TRUE, onlyStdChrs=TRUE, chr=NULL, verbose=FALSE)
```

##Aligning peaks across replicates to produce regions
After *findPeaks* has been run on each sample, the *finalRegions* function can
be used to align overlapping peaks found in multiple samples. Peak files for all
the alignment files can be found in the “extdata/peaks” folder.
*finalRegions* will produce a GRanges object containing the locations of the
aligned peaks.
If the **saveFlag** is set to TRUE, the function will produce a tab separated
value file in the **outputFolder**.

Parameter description:

**peakSamplesGRangesList**
:   named GRangesList where each element is a sample of called peaks. A z-score
    mcols values is needed for each GRanges. (tipically returned by findPeaks
    function).

**zThreshold**
:   Z-score for considering a peak for alignment, it needs to be equal or higher
    to the ztresh used in findPeaks, default 20.

**minCarriers**
:   Minimum number of biological replicates required to overlap after aligning
    peaks for reporting.

**saveFlag**
:   A boolean indicating if to save the results in a tab delimited file

**outputFolder**
:   the directory name to store the output file.

```
peaks.file <- system.file(
                file.path("extdata","peaks","RData","peaksGRL_all_files.rds"),
                package="DEScan2")

peaksGRL <- readRDS(peaks.file)
regionsGR <- DEScan2::finalRegions(peakSamplesGRangesList=peaksGRL, zThreshold=10,
                minCarriers=3, saveFlag=FALSE, outputFolder=NULL, verbose=FALSE)

head(regionsGR)
```

```
## GRanges object with 6 ranges and 3 metadata columns:
##                      seqnames            ranges strand |   z-score   n-peaks
##                         <Rle>         <IRanges>  <Rle> | <numeric> <numeric>
##   chr19.p020_np03_k3    chr19 57220100-57220599      * |   16.3522         3
##   chr19.p021_np06_k6    chr19 57224200-57224799      * |   19.7854         6
##   chr19.p023_np06_k3    chr19 57226800-57228199      * |   18.3281         6
##   chr19.p024_np06_k6    chr19 57230800-57231349      * |   25.2732         6
##   chr19.p028_np04_k4    chr19 57235750-57236399      * |   13.3579         4
##   chr19.p032_np04_k3    chr19 57243400-57244499      * |   14.5674         4
##                      k-carriers
##                       <numeric>
##   chr19.p020_np03_k3          3
##   chr19.p021_np06_k6          6
##   chr19.p023_np06_k3          3
##   chr19.p024_np06_k6          6
##   chr19.p028_np04_k4          4
##   chr19.p032_np04_k3          3
##   -------
##   seqinfo: 1 sequence from mm9 genome
```

The output of this function is a bed-like file with columns indicating genomic
coordinates as well as additional columns: AvgZ, average z-score of the peaks
combined to form a common region, and NumCarriers, the number of samples a
region was present in.

##Counting reads in the final regions
The resulting regions can then be used to generate a count matrix using the
*countFinalRegions* function. This function takes the regions to count across
(can be any bed like data structure), and the path to files which contain the
reads to be counted. Bam files for all the alignment files can be found in the
“extdata/bam/” folder. The minimum number of carriers can also be specified in
order to speed up the process. In this case we will not specify a minimum number
of carriers and will filter after counting. This function is a wrapper for
*summarizeOverlaps*.

```
bam.path <- system.file(file.path("extdata","bam"), package="DEScan2")
finalRegions <- DEScan2::countFinalRegions(regionsGRanges=regionsGR,
                    readsFilePath=bam.path, fileType="bam", minCarriers=1,
                    genomeName="mm9", onlyStdChrs=TRUE, saveFlag=FALSE,
                    verbose=FALSE)

counts <- SummarizedExperiment::assay(finalRegions)
regions <- SummarizedExperiment::rowRanges(finalRegions)
```

It returns a *SummarizedExperiment* object. To obtain the matrix of counts it is
necessary to use the *assay* function.
The resulting count matrix contains a row for each region and a column for each
sample. This structure is analogous to common RNA-seq data and can be normalized
and analyzed with similar tools.
Using the function *rowRanges* the GRanges of the regions will be returned.
Using the rownames of the count matrix over the names of the regions, the
coordinates of the peaks can be accessed.
Moreover, the regions GRanges object can be used to filter out rows of the
matrix of counts. Indeed, we will rename and reorder the columns for readability
and filter for a minimum of 4 carriers in order to only test relevant regions.

```
counts <- counts[regions$`k-carriers` >= 4, ]
counts <- counts[rowSums(counts) > 0,]
colnames(counts) <- c("FC1", "FC4", "HC1", "HC4", "FC6", "FC9", "HC6", "HC9")
counts <- counts[,order(colnames(counts))]
head(counts)
```

```
##                    FC1 FC4 FC6 FC9 HC1 HC4 HC6 HC9
## chr19.p021_np06_k6 129   9  50  26  51  46  27  20
## chr19.p024_np06_k6  15   4  21 341  53  56  11   6
## chr19.p028_np04_k4  28   2  33  11  16  25  27  12
## chr19.p036_np04_k4  25   5  18   9   5  43  10   2
## chr19.p043_np04_k4  36  20  42  18  28  48   9  12
## chr19.p048_np04_k4  21   2   4   3  54  36  28   1
```

##Normalization using RUV

In order to control for “unwanted variation”, e.g., batch, library preparation,
and other nuisance effects, the between-sample normalization method RUVs from
the RUVSeq package can be utilized. Any normalization method based on total
library counts is not appropriate for epigenetic sequencing experiments, as
differences in total counts in the count matrix can be due to the treatment of
interest.

```
library("RColorBrewer")
colors <- brewer.pal(3, "Set2")
set <- EDASeq::betweenLaneNormalization(counts, which = "upper")
groups <- matrix(c(1:8), nrow=2, byrow=TRUE)
trt <- factor(c(rep("FC", 4), rep("HC", 4)))
```

The boxplots of relative log expression (RLE = log-ratio of read count to median
read count across sample) and plots of principal components (PC) reveal a clear
need for between-sample normalization.

```
EDASeq::plotRLE(set, outline=FALSE, ylim=c(-4, 4),
        col=colors[trt], main="No Normalization RLE")
EDASeq::plotPCA(set, col=colors[trt], main="No Normalization PCA",
                labels=FALSE, pch=19)
```

![](data:image/png;base64...)![](data:image/png;base64...)

The parameter **k** dictates the number of factors of unwanted to variation to
remove, in this case we use 4, but this is up for the user to determine. We can
see in the PCA plot that after RUVs normalization the first 2 principal
components seperate the two groups indicating that the treatment is the major
source of variation.

```
k <- 4
s <- RUVSeq::RUVs(set, cIdx=rownames(set), scIdx=groups, k=k)

EDASeq::plotRLE(s$normalizedCounts, outline=FALSE, ylim=c(-4, 4),
        col=colors[trt], main="Normalized RLE")
EDASeq::plotPCA(s$normalizedCounts, col=colors[trt], main="Normalized PCA",
        labels=FALSE, pch=19)
```

![](data:image/png;base64...)![](data:image/png;base64...)

##Testing for differential enrichment of regions

Now, we are ready to look for differentially enriched regions, using the
negative binomial quasi-likelihood GLM approach implemented in edgeR (see the
edgeR package vignette for details). This is done by considering a design matrix
that includes both the covariates of interest (here, the treatment status) and
the factors of unwanted variation.
In the end we get the coordinates of differentially enriched regions by
subsetting the regions computed previously.

```
design <- model.matrix(~0 + trt + s$W)
colnames(design) <- c(levels(trt), paste0("W", 1:k))

y <- edgeR::DGEList(counts=counts, group=trt)
y <- edgeR::estimateDisp(y, design)

fit <- edgeR::glmQLFit(y, design, robust=TRUE)

con <- limma::makeContrasts(FC - HC, levels=design)

qlf <- edgeR::glmQLFTest(fit, contrast=con)
res <- edgeR::topTags(qlf, n=Inf, p.value=0.05)
head(res$table)
```

```
##                    logFC logCPM     F    PValue     FDR
## chr19.p362_np04_k4 2.602  11.83 14.09 0.0002149 0.02470
## chr19.p254_np07_k5 2.067  13.05 12.99 0.0003743 0.02470
## chr19.p506_np07_k7 2.004  12.59 11.45 0.0008253 0.03632
```

```
dim(res$table)
```

```
## [1] 3 5
```

```
regions[rownames(res$table)]
```

```
## GRanges object with 3 ranges and 3 metadata columns:
##                      seqnames            ranges strand |   z-score   n-peaks
##                         <Rle>         <IRanges>  <Rle> | <numeric> <numeric>
##   chr19.p362_np04_k4    chr19 57993950-57994699      * |   18.6357         4
##   chr19.p254_np07_k5    chr19 57733200-57734949      * |   19.2381         7
##   chr19.p506_np07_k7    chr19 57619900-57620599      * |   19.7085         7
##                      k-carriers
##                       <numeric>
##   chr19.p362_np04_k4          4
##   chr19.p254_np07_k5          5
##   chr19.p506_np07_k7          7
##   -------
##   seqinfo: 1 sequence from mm9 genome
```

# 3 A note on performance and serial computing

The DEScan2 package uses the BiocParallel package to allow for parallel computing.
Here, we used the register command to ensure that the vignette runs with serial computations.

However, in real datasets, parallel computations can speed up the computations dramatically, in the presence of many genes and/or many cells.

There are two ways of allowing parallel computations in DEScan2 The first is to register() a parallel back-end (see ?BiocParallel::register for details).
Alternatively, one can pass a BPPARAM object to findPeaks and finalRegions functions, e.g.

```
library("BiocParallel")

peaksGRL <- DEScan2::findPeaks(files=bam.files[1], filetype="bam", genomeName="mm9",
    binSize=50, minWin=50, maxWin=1000, zthresh=10, minCount=0.1, sigwin=10,
    minCompWinWidth=5000, maxCompWinWidth=10000, save=FALSE,
    outputFolder="peaks", force=TRUE, onlyStdChrs=TRUE, chr=NULL, verbose=FALSE,
    BPPARAM=BiocParallel::MulticoreParam(2))
```

We found that MulticoreParam() may have some performance issues on Mac; hence, we recommend DoparParam() when working on Mac.