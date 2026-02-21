# segmentSeq: methods for detecting methylation loci and differential methylation

Thomas J. Hardcastle

#### 30 October, 2025

#### Package

segmentSeq 2.44.0

# Contents

* [1 Introduction](#introduction)
* [2 Preparation](#preparation)
* [3 Segmentation by heuristic Bayesian methods](#segmentation-by-heuristic-bayesian-methods)
* [4 Segmentation by empirical Bayesian Methods](#segmentation-by-empirical-bayesian-methods)
* [5 Visualising loci](#visualising-loci)
* [6 Differential Methylation analysis](#differential-methylation-analysis)
* [7 Bibliography](#bibliography)
* [8 Session Info](#session-info)

# 1 Introduction

This vignette introduces analysis methods for data from high-throughput sequencing of bisulphite treated DNA to detect cytosine methylation. The `segmentSeq` package was originally designed to detect siRNA loci [Hardcastle2011](#Hardcastle2011) and many of the methods developed for this can be used to detect loci of cytosine methylation from replicated (or unreplicated) sequencing data.

# 2 Preparation

Preparation of the segmentSeq package proceeds as in siRNA analysis. We begin by loading the `segmentSeq` package.

```
library(segmentSeq)
#> Loading required package: baySeq
#> Loading required package: S4Vectors
#> Loading required package: stats4
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: parallel
#> Loading required package: GenomicRanges
#> Loading required package: IRanges
#> Loading required package: Seqinfo
#> Loading required package: ShortRead
#> Loading required package: BiocParallel
#> Loading required package: Biostrings
#> Loading required package: XVector
#>
#> Attaching package: 'Biostrings'
#> The following object is masked from 'package:base':
#>
#>     strsplit
#> Loading required package: Rsamtools
#> Loading required package: GenomicAlignments
#> Loading required package: SummarizedExperiment
#> Loading required package: MatrixGenerics
#> Loading required package: matrixStats
#>
#> Attaching package: 'MatrixGenerics'
#> The following objects are masked from 'package:matrixStats':
#>
#>     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
#>     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
#>     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
#>     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
#>     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
#>     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
#>     colWeightedMeans, colWeightedMedians, colWeightedSds,
#>     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
#>     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
#>     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
#>     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
#>     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
#>     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
#>     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
#>     rowWeightedSds, rowWeightedVars
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#>
#> Attaching package: 'Biobase'
#> The following object is masked from 'package:MatrixGenerics':
#>
#>     rowMedians
#> The following objects are masked from 'package:matrixStats':
#>
#>     anyMissing, rowMedians
```

Note that because the experiments that `segmentSeq` is designed to analyse are usually massive, we should use (if possible) parallel processing as implemented by the `parallel` package. If using this approach, we need to begin by define a *cluster*. The following command will use eight processors on a single machine; see the help page for ‘makeCluster’ for more information. If we don’t want to parallelise, we can proceed anyway with a `NULL` cluster. Results may be slightly different depending on whether or not a cluster is used owing to the non-deterministic elements of the method.

```
if(FALSE) { # set to FALSE if you don't want parallelisation
    numCores <- min(8, detectCores())
    cl <- makeCluster(numCores)
} else {
    cl <- NULL
}
```

The `segmentSeq` package is designed to read in output from the YAMA (Yet Another Methylome Aligner) program. This is a perl-based package using either bowtie or bowtie2 to align bisulphite treated reads (in an unbiased manner) to a reference and identify the number of times each cytosine is identified as methylated or unmethylated. Unlike most other aligners, YAMA does not require that reads that map to more than one location are discarded, instead it reports the number of alternate matches to the reference for each cytosine. This is then used by `segmentSeq` to weight the observed number of methylated/un-methylated cytosines at a location. The files used here have been compressed to save space.

```
datadir <- system.file("extdata", package = "segmentSeq")
files <- c(
  "short_18B_C24_C24_trim.fastq_CG_methCalls.gz",
  "short_Sample_17A_trimmed.fastq_CG_methCalls.gz",
  "short_13_C24_col_trim.fastq_CG_methCalls.gz",
  "short_Sample_28_trimmed.fastq_CG_methCalls.gz")

mD <- readMeths(files = files, dir = datadir,
libnames = c("A1", "A2", "B1", "B2"), replicates = c("A","A","B","B"),
nonconversion = c(0.004777, 0.005903, 0.016514, 0.006134))
#> Reading files.......done!
#> Finding unique cytosines......done!
#> Processing samples.......done!
```

We can begin by plotting the distribution of methylation for these samples. The distribution can be plotted for each sample individually, or as an average across multiple samples. We can also subtract one distribution from another to visualise patterns of differential methylation on the genome.

```
par(mfrow = c(2,1))
dists <- plotMethDistribution(mD, main = "Distributions of methylation", chr = "Chr1")
plotMethDistribution(mD,
                     subtract = rowMeans(sapply(dists, function(x) x[,2])),
                     main = "Differences between distributions", chr = "Chr1")
```

![Distributions of methylation on the genome (first two million bases of chromosome 1).](data:image/png;base64...)

Figure 1: Distributions of methylation on the genome (first two million bases of chromosome 1)

Next, we process this `alignmentData` object to produce a `segData` object. This `segData` object contains a set of potential segments on the genome defined by the start and end points of regions of overlapping alignments in the `alignmentData` object. It then evaluates the number of tags that hit in each of these segments.

```
sD <- processAD(mD, cl = cl)
#> Chromosome: Chr1
#> Finding start-stop co-ordinates...done!
#> 249271 candidate loci found.
```

We can now construct a segment map from these potential segments.

# 3 Segmentation by heuristic Bayesian methods

A fast method of segmentation can be achieved by assuming a binomial distribution on the data with an uninformative beta prior, and identifying those potential segments which have a sufficiently large posterior likelihood that the proportion of methylation exceeds some critical value. This value can be determined by examining the data using the ‘thresholdFinder’ function, but expert knowledge is likely to provide a better guess as to where methylation becomes biologically significant.

```
thresh = 0.2
hS <- heuristicSeg(sD = sD, aD = mD, prop = thresh, cl = cl, gap = 100, getLikes = FALSE)
#> Number of candidate loci: 249271
#> Number of candidate nulls: 163635......done!
#> Strand *
#> Checking overlaps.....done.
#> Selecting loci...done!
hS
#> GRanges object with 2955 ranges and 0 metadata columns:
#>          seqnames          ranges strand
#>             <Rle>       <IRanges>  <Rle>
#>      [1]     Chr1         108-948      *
#>      [2]     Chr1       5449-5465      *
#>      [3]     Chr1            6452      *
#>      [4]     Chr1            6520      *
#>      [5]     Chr1       7020-7034      *
#>      ...      ...             ...    ...
#>   [2951]     Chr1 1993118-1993128      *
#>   [2952]     Chr1         1993149      *
#>   [2953]     Chr1         1993335      *
#>   [2954]     Chr1         1994611      *
#>   [2955]     Chr1 1994857-1994886      *
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
#> An object of class "lociData"
#> 2955 rows and 4 columns
#>
#> Slot "replicates"
#> A A B B
#> Slot "groups":
#> list()
#>
#> Slot "data":
#>      [,1]    [,2]    [,3]    [,4]
#> [1,] 247:169 175:133 165:149 28:31
#> [2,] 0:49    1:86    23:36   2:2
#> [3,] 2:0     5:3     0:3     0:1
#> [4,] 0:3     0:9     2:1     0:0
#> [5,] 0:119   2:78    20:37   0:2
#> 2950 more rows...
#>
#> Slot "annotation":
#> data frame with 0 columns and 2955 rows
#>
#> Slot "locLikelihoods" (stored on log scale):
#> Matrix with  2955  rows.
#>        A   B
#> 1      1   1
#> 2      0   1
#> 3      1   0
#> 4      0   1
#> 5      0   1
#> ...  ... ...
#> 2951   1   1
#> 2952   1   1
#> 2953   1   0
#> 2954   1   0
#> 2955   0   1
#>
#> Expected number of loci in each replicate group
#>    A    B
#> 1968 2168
```

Within a methylation locus, it is not uncommon to find completely unmethylated cytosines. If the coverage of these cytosines is too high, it is possible that these will cause the locus to be split into two or more fragments. The `mergeMethSegs` function can be used to overcome this splitting by merging loci with identical patterns of expression that are not separated by too great a gap. Merging in this manner is optional, but recommended.

```
hS <- mergeMethSegs(hS, mD, gap = 5000, cl = cl)
```

We can then estimate posterior likelihoods on the defined loci by applying empirical Bayesian methods. These will not change the locus definition, but will assign likelihoods that the identified loci represent a true methylation locus in each replicate group.

```
hSL <- lociLikelihoods(hS, mD, cl = cl)
```

# 4 Segmentation by empirical Bayesian Methods

Classification of the potential segments can also be carried out using empirical Bayesian methods. These are extremely computationally intensive, but allow biological variation within replicates to be more accurately modelled, thus providing an improved identification of methylation loci.

```
%eBS <- classifySeg(sD, hS, mD, cl = cl)
```

# 5 Visualising loci

By one of these methods, we finally acquire an annotated `methData` object, with the annotations describing the co-ordinates of each segment.

We can use this `methData` object, in combination with the `alignmentMeth` object, to plot the segmented genome.

```
plotMeth(mD, hSL, chr = "Chr1", limits = c(1, 50000), cap = 10)
#> Plotting sample: 1
#> Plotting sample: 2
#> Plotting sample: 3
#> Plotting sample: 4
```

![](data:image/png;base64...)

# 6 Differential Methylation analysis

We can also examine the `methData` object for differentially methylated regions using the beta-binomial methods [Hardcastle:2013](#Hardcastle2013) implemented in `baySeq`. We first define a group structure on the data.

```
groups(hSL) <- list(NDE = c(1,1,1,1), DE = c("A", "A", "B", "B"))
```

The methObservables function pre-calculates a set of data to improve the speed of prior and posterior estimation (at some minor memory cost).

```
hSL <- methObservables(hSL)
```

The density function used here is a composite of the beta-binomial and a binomial distribution that accounts for the reported non-conversion rates.

```
densityFunction(hSL) <- bbNCDist
```

We can then determine a prior distribution on the parameters of the model for the data.

```
hSL <- getPriors(hSL, cl = cl)
```

We can then find the posterior likelihoods of the models defined in the groups structure.

```
hSL <- getLikelihoods(hSL, cl = cl)
```

We can then retrieve the data for the top differentially methylated regions.

```
topCounts(hSL, "DE")
```

Finally, to be a good citizen, we stop the cluster we started earlier:

```
if(!is.null(cl))
    stopCluster(cl)
```

# 7 Bibliography

Thomas J. Hardcastle and Krystyna A. Kelly and David C. Baulcombe. *Identifying small RNA loci from high-throughput sequencing data.* Bioinformatics (2012).

Thomas J. Hardcastle and Krystyna A. Kelly. *Empirical Bayesian analysis of paired high-throughput sequencing data with a beta-binomial distribution.* BMC Bioinformatics (2013).

# 8 Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] parallel  stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] segmentSeq_2.44.0           ShortRead_1.68.0
#>  [3] GenomicAlignments_1.46.0    SummarizedExperiment_1.40.0
#>  [5] Biobase_2.70.0              MatrixGenerics_1.22.0
#>  [7] matrixStats_1.5.0           Rsamtools_2.26.0
#>  [9] Biostrings_2.78.0           XVector_0.50.0
#> [11] BiocParallel_1.44.0         GenomicRanges_1.62.0
#> [13] Seqinfo_1.0.0               IRanges_2.44.0
#> [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [17] generics_0.1.4              baySeq_2.44.0
#> [19] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10         SparseArray_1.10.0  bitops_1.0-9
#>  [4] jpeg_0.1-11         lattice_0.22-7      magrittr_2.0.4
#>  [7] digest_0.6.37       RColorBrewer_1.1-3  evaluate_1.0.5
#> [10] grid_4.5.1          bookdown_0.45       fastmap_1.2.0
#> [13] jsonlite_2.0.0      Matrix_1.7-4        cigarillo_1.0.0
#> [16] limma_3.66.0        tinytex_0.57        BiocManager_1.30.26
#> [19] codetools_0.2-20    jquerylib_0.1.4     abind_1.4-8
#> [22] cli_3.6.5           rlang_1.1.6         crayon_1.5.3
#> [25] cachem_1.1.0        DelayedArray_0.36.0 yaml_2.3.10
#> [28] S4Arrays_1.10.0     tools_4.5.1         deldir_2.0-4
#> [31] interp_1.1-6        locfit_1.5-9.12     hwriter_1.3.2.1
#> [34] png_0.1-8           R6_2.6.1            magick_2.9.0
#> [37] lifecycle_1.0.4     pwalign_1.6.0       edgeR_4.8.0
#> [40] bslib_0.9.0         Rcpp_1.1.0          statmod_1.5.1
#> [43] xfun_0.53           knitr_1.50          latticeExtra_0.6-31
#> [46] htmltools_0.5.8.1   rmarkdown_2.30      compiler_4.5.1
```