# The bsseq User’s Guide

Kasper Daniel Hansen

#### 29 October 2025

#### Abstract

A comprehensive guide to using the bsseq package for analyzing whole-genome bisulfite sequencing (WGBS) datta.

#### Package

bsseq 1.46.0

# 1 Introduction

This R package is the reference implementation of the BSmooth algorithm for analyzing whole-genome bisulfite sequencing (WGBS) data. This package does **not** contain alignment software, which is available from . This package is not intended for analysis of single-loci bisulfite sequencing (typically Sanger bisulfite sequencing or pyro bisulfite sequencing).

The package has been used to analyze capture bisulfite sequencing data. For this type of data, the most useful parts of the package is its data-handling functions. The BSmooth algorithm itself may not be useful for a standard capture bisulfite sequencing experiment, since it relies heavily on smoothing, which again requires that we have measured methylation in bigger regions of the genome.

The BSmooth algorithm is described in detail in (Hansen, Langmead, and Irizarry [2012](#ref-Hansen:2012)). It was applied to human cancer data in (Hansen, Timp, et al. [2011](#ref-Hansen:2011)) and we have also used it to analyze data from Rhesus Macaque (Tung et al. [2012](#ref-Tung:2012)). Specifically, the algorithm uses smoothing to get reliable semi-local methylation estimates from low-coverage bisulfite sequencing. After smoothing it uses biological replicates to estimate biological variation and identify differentially methylated regions (DMRs). The smoothing portion could be used even on a single sample, but we believe that variation between individuals is an important aspect of DNA methylation and needs to be accounted for, see also (Hansen, Wu, et al. [2011](#ref-Hansen:2011rna)) for a relevant discussion.

The main focus for our development has been the analysis of CpG methylation in humans, and we have successfully used it in other primates (Tung et al. [2012](#ref-Tung:2012)). It is highly likely that the approach will work in non-human organisms, but care must be taken: the smoothing parameters (which we have selected based on human data) should be evaluated carefully. Furthermore, it may not be suitable at all for organisms with vastly different (from humans) methylation structures.

Later, we have used the approach to analyze a large WGBS dataset in human brain (Rizzardi et al. [2021](#ref-gtexWGBS)). The data consisted of more than 300 samples and our analysis included non-CpG methylation. To do so, we extended the package to support HDF5 backed data and we imnplemented a more flexible F-statistics. Doing so, we were able to not only analyse CpG methylation in this large sample size, but also non-CpG methylation which is far larger. However, especially the non-CpG methylation analysis was still difficult to accomplish due to computational due to computational requirements.

## 1.1 System Requirements

The package requires that all the data is loaded into system memory. By ``data’’ we do not mean the individual reads (which is big for a whole-genome experiment). Instead, what we need are summarized data given us the number of reads supporting methylation as well as the total number of reads at
each loci. Focusing on human data, we need to work with objects with a maximum of 28.2 million entries, per sample (since there are roughly 28.2 millions CpGs in the human genome). This provides us with an upper limit on the data object.

Based on this, the 8 samples from (Hansen, Timp, et al. [2011](#ref-Hansen:2011)) including the smoothed values, take up roughly 1.2GB of RAM, meaning an analysis can easily be done with 8GB of RAM. In order to improve speed, the package allows for easy parallel processing of samples/chromosomes. This will require multiple copies of the data object for each core used, increasing the memory usage substantially to perhaps even 32GB. This can be avoided by processing the samples sequentially at the cost of speed.

On a 64GB node, the 8 samples from (Hansen, Timp, et al. [2011](#ref-Hansen:2011)) takes roughly one hour to process in parallel using 8 cores (using much less than 64GB of RAM in total). This does not including parsing the data from the alignment output files.

## 1.2 Some terminology

Because not all methylation happens at CpG sites, we have tried to use the term ``methylation loci’’ instead of CpG. We use this term to refer to a single-base methylation site.

Some standard terms from the DNA methylation field: differentially methylated region (DMR), hyper methylation (methylation that is higher in one condition/sample than in another), hypo methylation (methylation that is lower in one condition/sample than in another), and finally differentially methylated position (DMP) referring to a single loci.

## 1.3 Citation

If you use this package, please cite our BSmooth paper (Hansen, Langmead, and Irizarry [2012](#ref-Hansen:2012)).

## 1.4 Dependencies

```
library(bsseq)
```

# 2 Overview

The package assumes that the following data has been extracted from alignments:

* genomic positions, including chromosome and location, for methylation loci.
* a (matrix) of M (Methylation) values, describing the number of read supporting methylation covering a single loci. Each row in this matrix is a methylation loci and each column is a sample.
* a (matrix) of Cov (Coverage) values, describing the total number of reads covering a single loci. Each row in this matrix is a methylation loci and each column is a sample.

We can have a look at some data from (Lister et al. [2009](#ref-Lister:2009)), specifically chromosome 22 from the IMR90 cell line.

```
data(BS.chr22)
BS.chr22
```

```
## An object of type 'BSseq' with
##   494728 methylation loci
##   2 samples
## has not been smoothed
## All assays are in-memory
```

The genomic positions are stored as a `GRanges` object `GRanges` are general genomic regions; we represent a single base methylation loci as an interval of width 1 (which may seem a bit strange, but there are good reasons for this). For example, the first 4 loci in the Lister data are

```
head(granges(BS.chr22), n = 4)
```

```
## GRanges object with 4 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]    chr22  14430632      *
##   [2]    chr22  14430677      *
##   [3]    chr22  14430687      *
##   [4]    chr22  14430702      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

We also have the M and Cov matrices

```
head(getCoverage(BS.chr22, type = "M"), n = 4)
```

```
##      r1 r2
## [1,] 17 20
## [2,]  4 20
## [3,]  6 19
## [4,]  2  4
```

```
head(getCoverage(BS.chr22), n = 4)
```

```
##      r1 r2
## [1,] 18 23
## [2,] 11 28
## [3,] 10 25
## [4,]  8 21
```

Since CpG methylation is symmetric on the two strands of a chromosome, we aggregated reads on the forward and reverse strand to form a single value, and we assume the genomic position points to the C of the CpG. It is not crucial in any way to do this, one may easily analyze each strand separately, but CpG methylation is symmetric and this halves the number of loci.

How to input your methylation data into this data structure (called a `BSseq` object) is described in a section below. We also have a section on how to operate on these types of objects.

An analysis typically consists of the following steps.

1. Smoothing, using the function `BSmooth()`.
2. Compute t-statistics, using the function `BSmooth.tstat()`. This converts the `BSseq` object into a `BSseqTstat` object.
3. Threshold these t-statistics to identify DMRs, using the function `dmrFinder()`, returning a simple `data.frame`.

It is usually a good idea to look at the smoothed data either before or after identifying DMRs. This can be done using the functions `plotRegion()` and `plotManyRegions()`.

We also have functions for assessing goodness of fit for binomial and poison models; this is like to be of marginal interest to most users. See the man page for `binomialGoodnessOfFit()`.

We also allow for easy computation of Fisher’s exact test for each loci, using the function `fisherTests()`.

# 3 Using objects of class BSseq

## 3.1 Basic operations

Objects of class `BSseq` contains a `GRanges` object with the genomic locations. This `GRanges` object can be obtained by `granges()`. A number of standard `GRanges` methods works directly on the `BSseq` object, such as `start()`, `end()`, `seqnames()` (chromosome names) etc.

These objects also contains a `phenoData` object for sample pheno data. Useful methods are `sampleNames()`, `pData()`.

Finally, we have methods such as `dim()`, `ncol()` (number of columns; number of samples), `nrow()` (number of rows; number of methylation loci).

Objects can be subsetted using two indicies `BSseq[i,j]` with the first index being methylation loci and the second index being samples. Another very useful way of subsetting the object is by using the method `subsetByOverlaps()`. This selects all methylation loci inside a set of genomic intervals (there is a difference between first and second argument and either can be
`BSseq` or `GRanges`).

Examples:

```
head(start(BS.chr22), n = 4)
```

```
## [1] 14430632 14430677 14430687 14430702
```

```
head(seqnames(BS.chr22), n = 4)
```

```
## factor-Rle of length 4 with 1 run
##   Lengths:     4
##   Values : chr22
## Levels(1): chr22
```

```
sampleNames(BS.chr22)
```

```
## [1] "r1" "r2"
```

```
pData(BS.chr22)
```

```
## DataFrame with 2 rows and 1 column
##            Rep
##    <character>
## r1  replicate1
## r2  replicate2
```

```
dim(BS.chr22)
```

```
## [1] 494728      2
```

```
BS.chr22[1:6,1]
```

```
## An object of type 'BSseq' with
##   6 methylation loci
##   1 samples
## has not been smoothed
## All assays are in-memory
```

```
subsetByOverlaps(BS.chr22,
                 GRanges(seqnames = "chr22",
                         ranges = IRanges(start = 1, end = 2*10^7)))
```

```
## An object of type 'BSseq' with
##   67082 methylation loci
##   2 samples
## has not been smoothed
## All assays are in-memory
```

## 3.2 Data handling

We have a number of functions for manipulating one or more `BSseq` objects.

`BSseq()` instantiates an object of class `BSseq`. Genomic locations are passed in, either as a `GRanges` object (argument `gr`) or as chromosome and location vectors (arguments `chr` and `pos`). The arguments `M` and `Cov` accepts matrices, and it is possible to directly give it a `phenoData` object.

```
M <- matrix(0:8, 3, 3)
Cov <- matrix(1:9, 3, 3)
BStmp <- BSseq(chr = c("chr1", "chrX", "chr1"), pos = 1:3,
               M = M, Cov = Cov, sampleNames = c("A1","A2", "B"))
```

A `BSseq` object may be ordered by `orderBSseq()`. This ensures that data from a single chromosome appears in an ordered, contiguous block. There is also the possibility for specifying the chromosome order (this is less important). The smoothing functions assumes that the underlying `BSseq` has been ordered.

```
granges(BStmp)
```

```
## GRanges object with 3 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]     chr1         1      *
##   [2]     chrX         2      *
##   [3]     chr1         3      *
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

```
BStmp <- orderBSseq(BStmp, seqOrder = c("chr1", "chrX"))
granges(BStmp)
```

```
## GRanges object with 3 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]     chr1         1      *
##   [2]     chr1         3      *
##   [3]     chrX         2      *
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

`chrSelectBSseq()` performs the often useful task of selecting one or more chromosomes and can also order the output. In case `order = TRUE`, the output is ordered according to the order of the `seqnames` argument.

```
chrSelectBSseq(BStmp, seqnames = "chr1", order = TRUE)
```

```
## An object of type 'BSseq' with
##   2 methylation loci
##   3 samples
## has not been smoothed
## All assays are in-memory
```

Of course, in this case the function does little, since `BS.chr22` already only contains data
from chromosome 22.

`combine()` combines two `BSseq` objects in the following way: the samples for the return objects is the union of the samples from the two objects, and the methylation loci are the union of the two methylation loci. The two objects do not need to have measured the same loci (in the example below, `BStmp` has data on chromosome 1 and X).

```
BStmp2 <- combine(BStmp, BS.chr22[1:3,])
```

```
## Warning in .merge_two_Seqinfo_objects(x, y): The 2 combined objects have no sequence levels in common. (Use
##   suppressWarnings() to suppress this warning.)
## Warning in .merge_two_Seqinfo_objects(x, y): The 2 combined objects have no sequence levels in common. (Use
##   suppressWarnings() to suppress this warning.)
```

```
granges(BStmp2)
```

```
## GRanges object with 6 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]     chr1         1      *
##   [2]     chr1         3      *
##   [3]     chrX         2      *
##   [4]    chr22  14430632      *
##   [5]    chr22  14430677      *
##   [6]    chr22  14430687      *
##   -------
##   seqinfo: 3 sequences from an unspecified genome; no seqlengths
```

```
getCoverage(BStmp2)
```

```
##      A1 A2 B r1 r2
## [1,]  1  4 7  0  0
## [2,]  3  6 9  0  0
## [3,]  2  5 8  0  0
## [4,]  0  0 0 18 23
## [5,]  0  0 0 11 28
## [6,]  0  0 0 10 25
```

`collapseBSseq` performs the often useful task of adding several columns of a `BSseq` object. This is often used in the beginning of an analysis where each column may correspond to a lane and several such columns represents the data for a single biological sample.

```
collapseBSseq(BStmp, group = c("A", "A", "B"))
```

```
## An object of type 'BSseq' with
##   3 methylation loci
##   2 samples
## has not been smoothed
## All assays are in-memory
```

## 3.3 Obtaining coverage (methylation)

Coverage, either Cov or M values, are obtained by `getCoverage()`, using the `type` argument:

```
head(getCoverage(BS.chr22, type = "Cov"), n = 4)
```

```
##      r1 r2
## [1,] 18 23
## [2,] 11 28
## [3,] 10 25
## [4,]  8 21
```

```
head(getCoverage(BS.chr22, type = "M"), n = 4)
```

```
##      r1 r2
## [1,] 17 20
## [2,]  4 20
## [3,]  6 19
## [4,]  2  4
```

This will return a – possibly very large – matrix. It is also possible to get region based coverage by using the `regions` argument to the function. This argument is either a `data.frame` (with columns `chr`, `start` and `end`) or a `GRanges` object. Let us do an example

```
regions <- GRanges(seqnames = c("chr22", "chr22"),
                   ranges = IRanges(start = 1.5 * 10^7 + c(0,200000),
                                    width = 1000))
getCoverage(BS.chr22, regions = regions, what = "perRegionTotal")
```

```
##      r1 r2
## [1,] 30 38
## [2,] NA NA
```

When `what` is `perRegionTotal` the return value is the total coverage of each region (and note that regions without coverage return `NA`). Similarly, `perRegionAverage` yields the average coverage in the region. However, it is often useful to get the actual values, like

```
getCoverage(BS.chr22, regions = regions, what = "perBase")
```

```
## [[1]]
##      [,1] [,2]
## [1,]   21   30
## [2,]    2    8
## [3,]    7    0
##
## [[2]]
## NULL
```

This is the default behaviour, and it returns a list where each element corresponds to a region. Note that regions with no coverage gets a `NULL`.

Methylation estimates can be obtained in the same way, using the function `getMeth()`. If `type` is set to `raw` the function returns simple single-loci methylation estimates (which are M/Cov). To get smoothed estimates, the `BSseq` object needs to have been smoothed using Bsmooth, and `type` set to `smooth` (default). The `getCoverage(0`, `getMeth()` has a `regions` and a `what` argument. For `getMeth()` the `what` argument can be `perBase` or `perRegion` (the later is really the per-region average methylation). Additionally, confidence intervals can be computed using a method taking possibly low coverage loci into account as well as loci where the methylation percentage might be close to 0 or 1 (Agresti and Coull [1998](#ref-Agresti:1998)). Currently, confidence intervals cannot be computed for region-level summary estimates. Examples

```
getMeth(BS.chr22, regions, type = "raw")
```

```
## [[1]]
##           [,1]      [,2]
## [1,] 0.1904762 0.1666667
## [2,] 1.0000000 0.7500000
## [3,] 0.1428571       NaN
##
## [[2]]
## NULL
```

```
getMeth(BS.chr22, regions[2], type = "raw", what = "perBase")
```

```
## [[1]]
## NULL
```

# 4 Reading data

## 4.1 Alignment output from the BSmooth alignment suite

It is straightforward to read output files (summarized evidence) from the BSmooth alignment suite, using `read.bsmooth()`. This function takes as argument a number of directories, usually corresponding to samples, with the alignment output. Sometimes, one might want to read only certain chromosomes, which can be accomplished by the `seqnames` argument. Also, the default values of `qualityCutoff = 20` ensures that we do not use methylation evidence with a base quality strictly lower than 20 (since we may not be confident whether the read really supports methylation or not). The function `read.bsmooth()` allows for both gzipped and non-gzipped input files. It is faster to read gzipped files, so we recommend gzipping post-alignment.

During the development of BSmooth we experimented with a number of different output formats. These legacy formats can be read with `read.umtab()` and `read.umtab2()`.

## 4.2 Alignment output from other aligners

We are interested in adding additional parsers to the package; if your favorite alignment software is not supported, feel free to get in touch.

In general, we need summarized methylation evidence. In short, for each methylation loci, we need to know how many reads cover the loci and how many of those reads support methylation.

As an example, consider the Lister data. The files posted online looks like

```
> head mc_imr90_r1_22
assembly        position        strand  class   mc      h
22      14430632        +       CG      9       10
22      14430633        -       CG      8       8
22      14430677        +       CG      1       1
22      14430678        -       CG      3       10
22      14430688        -       CG      6       10
22      14430703        -       CG      2       8
22      14431244        +       CG      5       10
22      14431245        -       CG      5       11
```

For these files, the evidence is split by strand. It is often easiest to read in one sample at a time, instantiate a `BSseq` object and then use `combine()` and `collapseBSseq()` to combine the samples, since these functions deal objects that have different sets of CpGs. In the Lister data, note that the position is the position of the “C”, so basically, if you want to combine the evidence from both strands, CpGs on the “-” strand needs to have 1 subtracted from their position. A full script showing how these files are used to create `BS.chr22` can be found in `inst/scripts/get\_BS.chr22.R` in the *[bsseq](https://bioconductor.org/packages/3.22/bsseq)* package. The path of this file may be found by

```
system.file("scripts", "get_BS.chr22.R", package = "bsseq")
```

# 5 Analysis

Computing smoothed methylation levels is simple. We subset ``BS.chr22` so we only smooth 1 sample, for run-time purpose

```
BS.chr22.1 <- BSmooth(BS.chr22[,"r1"], verbose = TRUE)
BS.chr22.1
```

```
## An object of type 'BSseq' with
##   494728 methylation loci
##   1 samples
## has been smoothed with
##   BSmooth (ns = 70, h = 1000, maxGap = 100000000)
## All assays are in-memory
```

A number of arguments pertains to using multiple cores. This is useful if you have multiple samples or chromosomes. `mc.cores` tells `BSmooth()` how many cores to use and `parallelBy` describes whether the parallelization is over samples or chromosomes. If the parallelization is over samples, each core will compute the smoothing of the entire genome. And if it is over samples, each cores will smooth all samples for one or more chromosomes. The appropriate choice depends on the number of samples and cpu cores available. If you have the exact same number of samples as cores, the fastest is `parallelBy = "sample"`. If you have less samples than cores, the fastest is `parallelBy = "chromosome"`. The argument `mc.preshedule` should not need to be changed (unless perhaps if a small value of `maxGap` is uses); see the man page for `parallel::mclapply`. Note that setting `mc.cores` to a value greater than 1 is not support on MS Windows due to a limitation of the operating system.

For a more detailed discussion of the analysis tools, read the companion vignette ``Analyzing WGBS with the bsseq package’’, which also finding DMRs and plotting them.

Fisher’s exact tests may be efficiently computed using the function `fisherTests`()`.

Binomial and poisson goodness of fit tests statistics may be computed using `binomialGoodnessOfFit()` and `poissonGoodnessOfFit()`.

# 6 HDF5 support

`bsseq` supports HDF5-backed objects. This allows computations to happen in bounded memory, facilitating analysis of large datasets. We use the `HDF5Array` package together with `SummarizedExperiment`.

An HDF5-backed `BSseq` object has a small memory footprint: the data contained in the `assay` slot (particular the `M` and `Cov` matrices as well as the smoothed methylation values) are all stored on disk. The only thing in memory is the (relatively small) data in `colData` as well as some minimal overhead such as a pointer to the files on disk. Together with the `BiocParallel` package this allows large computations to happen where only parts of the data (such as the data on a single chromosome for a signle sample) is read into memory.

The easiest way to convert an existing in-memory `BSseq` object to an HDF5-backed object is to save it

```
library(HDF5Array)
saveHDF5SummarizedExperiment(BSseq, dir = "./BSseqName.h5")
```

The second argument of this is a directory (not a file). I often append `.h5` to the name, but that is not necessary. After saving, the contents of the directory will be

```
assays.h5  se.rds
```

The `se.rds` refers to a `SummarizedExperiment`. To move this object around, you need to transfer the entire directory. But otherwise, this is like a normal R object file which is platform independent.

Loading of the object uses the RDS syntax where a return object is explicitely named, such as

```
BSseq <- loadHDF5SummarizedExperiment(dir = "./BSseqName.h5")
```

Loading is instantenous because most of the data is not being read.

## 6.1 Parallizing using HDF5

It is easy to parallize over multiple cores on the same node using `BiocParallel`, by specifying the `BPPARAM` argument, like

```
BSseq <- BSmooth(BSseq, BPPARAM = MulticoreParam(workers = 10)
```

would use 10 workers. In our experience, the bottle neck is almost always memory consumption. You would need to have enough memory to have the 10 workers operate simultanously. For `BSmooth()` the max memory consumption per worker will be what is needed to have 1 chromosome for 1 sample in memory. In fact, what is needed, is only `M` and `Cov` for that sample. But the details of memory consumption is function specific.

## 6.2 Constructing a new object using HDF5

Currently, we support constructing a new object from Bismark input files using HDF5. Again, this implies that the memory consumption will be bounded by the number of workers times the max consumption of a single worker. For reading files, this typically ends up being the memory needed to read the relevant columns from a single file, for the entire genome. An example invocation is

```
BSseq <- read.bismark(bismarkfiles, BACKEND = "HDF5Array", BPPARAM = MulticoreParam(workers = 10))
```

There is no benefits to using more workers than you have files.

# 7 sessionInfo()

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] bsseq_1.46.0                SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [5] matrixStats_1.5.0           GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rjson_0.2.23              xfun_0.53
##  [3] bslib_0.9.0               rhdf5_2.54.0
##  [5] lattice_0.22-7            bitops_1.0-9
##  [7] rhdf5filters_1.22.0       tools_4.5.1
##  [9] curl_7.0.0                parallel_4.5.1
## [11] R.oo_1.27.1               Matrix_1.7-4
## [13] data.table_1.17.8         BSgenome_1.78.0
## [15] RColorBrewer_1.1-3        cigarillo_1.0.0
## [17] sparseMatrixStats_1.22.0  lifecycle_1.0.4
## [19] compiler_4.5.1            farver_2.1.2
## [21] Rsamtools_2.26.0          Biostrings_2.78.0
## [23] statmod_1.5.1             codetools_0.2-20
## [25] permute_0.9-8             htmltools_0.5.8.1
## [27] sass_0.4.10               RCurl_1.98-1.17
## [29] yaml_2.3.10               crayon_1.5.3
## [31] jquerylib_0.1.4           R.utils_2.13.0
## [33] BiocParallel_1.44.0       DelayedArray_0.36.0
## [35] cachem_1.1.0              limma_3.66.0
## [37] abind_1.4-8               gtools_3.9.5
## [39] locfit_1.5-9.12           digest_0.6.37
## [41] restfulr_0.0.16           bookdown_0.45
## [43] fastmap_1.2.0             grid_4.5.1
## [45] cli_3.6.5                 SparseArray_1.10.0
## [47] S4Arrays_1.10.0           XML_3.99-0.19
## [49] dichromat_2.0-0.1         h5mread_1.2.0
## [51] DelayedMatrixStats_1.32.0 scales_1.4.0
## [53] httr_1.4.7                rmarkdown_2.30
## [55] XVector_0.50.0            R.methodsS3_1.8.2
## [57] beachmat_2.26.0           HDF5Array_1.38.0
## [59] evaluate_1.0.5            knitr_1.50
## [61] BiocIO_1.20.0             rtracklayer_1.70.0
## [63] rlang_1.1.6               Rcpp_1.1.0
## [65] glue_1.8.0                BiocManager_1.30.26
## [67] jsonlite_2.0.0            R6_2.6.1
## [69] Rhdf5lib_1.32.0           GenomicAlignments_1.46.0
```

# 8 References

Agresti, Alan, and Brent Coull. 1998. “Approximate Is Better than "Exact" for Interval Estimation of Binomial Proportions.” *The American Statistician* 52 (2): 119–26. <http://www.jstor.org/stable/2685469>.

Hansen, Kasper D, Benjamin Langmead, and Rafael A Irizarry. 2012. “BSmooth: from whole genome bisulfite sequencing reads to differentially methylated regions.” *Genome Biology* 13 (10): R83. <https://doi.org/10.1186/gb-2012-13-10-r83>.

Hansen, Kasper D, Winston Timp, Hector Corrada Bravo, Sarven Sabunciyan, Benjamin Langmead, Oliver G. McDonald, Bo Wen, et al. 2011. “Generalized Loss of Stability of Epigenetic Domains Across Cancer Types.” *Nature Genetics* 43 (8): 768–75. <https://doi.org/10.1038/ng.865>.

Hansen, Kasper D, Zhijin Wu, Rafael A Irizarry, and Jeffrey T Leek. 2011. “Sequencing technology does not eliminate biological variability.” *Nature Biotechnology* 29 (7): 572–73. <https://doi.org/10.1038/nbt.1910>.

Lister, Ryan, Mattia Pelizzola, Robert H Dowen, R David Hawkins, Gary C Hon, Julian Tonti-Filippini, Joseph R Nery, et al. 2009. “Human DNA methylomes at base resolution show widespread epigenomic differences.” *Nature* 462 (7271): 315–22. <https://doi.org/10.1038/nature08514>.

Rizzardi, Lindsay F, Peter F Hickey, Adrian Idrizi, Rakel Tryggvadottir, Colin M Callahan, Kimberly E Stephens, Sean D Taverna, et al. 2021. “Human Brain Region-Specific Variably Methylated Regions Are Enriched for Heritability of Distinct Neuropsychiatric Traits.” *Genome Biology* 22: 116. <https://doi.org/10.1186/s13059-021-02335-w>.

Tung, Jenny, Luis B Barreiro, Zachary P Johnson, Kasper D Hansen, Vasiliki Michopoulos, Donna Toufexis, Katelyn Michelini, Mark E Wilson, and Yoav Gilad. 2012. “Social environment is associated with gene regulatory variation in the rhesus macaque immune system.” *PNAS* 109 (17): 6490–5. <https://doi.org/10.1073/pnas.1202734109>.

# Appendix