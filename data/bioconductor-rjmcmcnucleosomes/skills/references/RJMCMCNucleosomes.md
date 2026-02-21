# Nucleosome Positioning

#### 30 October 2025

# Contents

* [1 Licensing and citing](#licensing-and-citing)
* [2 Introduction](#introduction)
* [3 Loading the RJMCMC package](#loading-the-rjmcmc-package)
* [4 RJMCMCNucleosomes analysis](#rjmcmcnucleosomes-analysis)
* [5 RJMCMCNucleosomes analysis step by step](#rjmcmcnucleosomes-analysis-step-by-step)
  + [5.1 Split the analyzed region into segments](#split-the-analyzed-region-into-segments)
  + [5.2 Run RJMCMCNucleosomes for nucleosome predictions](#run-rjmcmcnucleosomes-for-nucleosome-predictions)
  + [5.3 Regroup all regions](#regroup-all-regions)
  + [5.4 Post-process predictions](#post-process-predictions)
  + [5.5 Visualisation of the predicted nucleosomes](#visualisation-of-the-predicted-nucleosomes)
* [6 RJMCMCNucleosomes analysis of one chromosome in one step](#rjmcmcnucleosomes-analysis-of-one-chromosome-in-one-step)
* [7 Session info](#session-info)
* [References](#references)

**Package**: *RJMCMCNucleosomes*
**Authors**: Pascal Belleau [aut],
Rawane Samb [aut],
Astrid Deschênes [cre, aut],
Khader Khadraoui [aut],
Lajmi Lakhal-Chaieb [aut],
Arnaud Droit [aut]
**Version**: 1.34.0
**Compiled date**: 2025-10-30
**License**: Artistic-2.0

# 1 Licensing and citing

The **RJMCMCNucleosomes** package and the underlying **RJMCMCNucleosomes** code
are distributed under the Artistic license 2.0. You are free to use and
redistribute this software.

If you use this package for a publication, we would ask you to cite the
following:

> Samb R, Khadraoui K, Belleau P, et al. (2015) Using informative Multinomial-Dirichlet prior in a t-mixture with reversible jump estimation of nucleosome positions for genome-wide profiling. Statistical Applications in Genetics and Molecular Biology. Volume 14, Issue 6, Pages 517-532, ISSN (Online) 1544-6115, ISSN (Print) 2194-6302, December 2015, [doi:10.1515/sagmb-2014-0098](http://dx.doi.org/10.1515/sagmb-2014-0098)

# 2 Introduction

Global gene expression patterns are established and maintained by the
concerted actions of transcription factors (TFs) and the proteins that
constitute chromatin. The key structural element of chromatin is the
nucleosome, which consists of an octameric histone core wrapped by 146 bps
of DNA and connected to its neighbour by approximately 10-80 pbs of linker
DNA (Polishko et al. [2012](#ref-Polishko2012)).

The literature on nucleosome positioning commonly focuses on frequentist
inferences within parametric approaches (see for instance Chen et al. ([2010](#ref-Chen2010)) and
Xi et al. ([2010](#ref-Xi2010))). In those works, the detection of nucleosome positions is done
using a hidden Markov model with an assumed known order.

The **RJMCMCNucleosomes** package is an implementation of a fully Bayesian
hierarchical model for profiling of nucleosome positions based on
high-throughput short-read data (MNase-Seq data). The implementation is based
on a strategy which incorporates four aspects. First, it jointly models local
concentrations of directional reads. Second, it uses a Multinomial-Dirichlet
model in the construction of an informative prior distribution coupled to a
t-mixture model with unknown degrees of freedom. Third, the number of
nucleosomes is considered to be a random variable and refers to a prior
distribution. Fourth, the unknown parameters are simultaneously using the
reversible jump Markov chain Monte Carlo (RJMCMC) simulation technique
(see for instance Green ([1995](#ref-Green1995)) and Richardson and Green ([1997](#ref-Richardson1997))).

Detailed information about the model can be found in the article
mentioned in the citing section.

# 3 Loading the RJMCMC package

As with any R package, the **RJMCMCNucleosomes** package should first be loaded
with the following command:

```
library(RJMCMCNucleosomes)
```

# 4 RJMCMCNucleosomes analysis

A typical **RJMCMCNucleosomes** analysis consists of the following steps:

1. Segment the analysed region into candidate regions that have sufficient
   aligned reads. The initial region cannot be wider than one chromosome.
2. Estimate nucleosome positions for each region.
3. Regroup all regions together. The final region cannot be wider than
   one chromosome.
4. Post-process predictions of the regrouped region to revise certain
   predictions.

# 5 RJMCMCNucleosomes analysis step by step

A synthetic nucleosome sample containing 100 nucleosomes (80
well-positioned + 20 fuzzy) has been created using the
Bioconductor package *[nucleoSim](https://bioconductor.org/packages/3.22/nucleoSim)*. This synthetic sample will be
used throughout this analysis.

```
## Load nucleoSim package
library(nucleoSim)

val.num       <- 50     ### Number of well-positioned nucleosomes
val.del       <- 10     ### Number of well-positioned nucleosomes to delete
val.var       <- 30     ### variance associated to well-positioned nucleosomes
val.fuz       <- 10     ### Number of fuzzy nucleosomes
val.fuz.var   <- 50     ### variance associated to fuzzy nucleosomes
val.max.cover <- 70     ### Maximum coverage for one nucleosome
val.nuc.len   <- 147    ### Distance between nucleosomes
val.len.var   <- 10     ### Variance associated to the length of the reads
val.lin.len   <- 20     ### The length of the DNA linker
val.rnd.seed  <- 100    ### Set seed when result needs to be reproducible
val.offset    <- 10000  ### The number of bases used to offset
                        ### all nucleosomes and reads

## Create sample using a Normal distribution
sample <- nucleoSim::syntheticNucReadsFromDist(wp.num=val.num,
                                    wp.del=val.del, wp.var=val.var,
                                    fuz.num=val.del, fuz.var=val.fuz.var,
                                    max.cover=val.max.cover,
                                    nuc.len=val.nuc.len,
                                    len.var=val.len.var,
                                    lin.len=val.lin.len,
                                    rnd.seed=val.rnd.seed,
                                    distr="Normal", offset=val.offset)

## Create visual representation of the synthetic nucleosome sample
plot(sample)
```

![](data:image/png;base64...)

## 5.1 Split the analyzed region into segments

It is suggested, in order to accelerate the learning process, to split the
analyzed region into segments to accelerate the analysis. Moreover,
it is mandatory to analyse each chromosome separately since the
`rjmcmc` function can only analyze one chromosome at the time.

Region segmentation can be done using the `segmentation` function. Beware
that larger is the size of a segment (parameter `maxLength`), the higher
the number of iterations needs to be to reach convergence during nucleosome
predictions step.

```
## Load needed packages
library(GenomicRanges)

## Transform sample dataset into GRanges object
sampleGRanges <- GRanges(seqnames = sample$dataIP$chr,
                        ranges = IRanges(start = sample$dataIP$start,
                                        end = sample$dataIP$end),
                        strand = sample$dataIP$strand)

## Segment sample into candidate regions
sampleSegmented <- segmentation(reads = sampleGRanges, zeta = 147,
                                delta = 40, maxLength = 1000)

## Number of segments created
length(sampleSegmented)
## [1] 11
```

## 5.2 Run RJMCMCNucleosomes for nucleosome predictions

The `rjmcmc` function must be run on each candidate region. As an
example, the first candidate region is processed using a very low number
of iterations. On real data, the number of iterations should be higher
(easily 1000000 iterations).

```
## Extract the first segment
segment01 <- sampleSegmented[[1]]

## Run RJMCMC analysis
## A higher number of iterations is recommanded for real analysis
resultSegment01 <- rjmcmc(reads  = segment01, nbrIterations = 100000,
                            lambda = 3, kMax = 30,
                            minInterval = 100, maxInterval = 200,
                            minReads = 5, vSeed = 1921)

## Print the predicted nucleosomes for the first segment
resultSegment01
## RJMCMCNucleosomes - Predicted nucleosomes
##
## Call:
## rjmcmc(reads = segment01, nbrIterations = 1e+05, kMax = 30, lambda = 3,
##     minInterval = 100, maxInterval = 200, minReads = 5, vSeed = 1921)
##
## Number of nucleosomes:
## [1] 5
##
## Nucleosomes positions:
## GRanges object with 5 ranges and 0 metadata columns:
##            seqnames    ranges strand
##               <Rle> <IRanges>  <Rle>
##   [1] chr_SYNTHETIC     10078      *
##   [2] chr_SYNTHETIC     10260      *
##   [3] chr_SYNTHETIC     10322      *
##   [4] chr_SYNTHETIC     10406      *
##   [5] chr_SYNTHETIC     10796      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## 5.3 Regroup all regions

Once all segments have been analyzed, the predicted nucleosomes can be merged
together. Two functions are available to facilitate the merging process:

* *mergeRDSFiles* function: An array containing the name of all RDS files
  to merge is passed to it
* *mergeAllRDSFilesFromDirectory* function: the name of the directory
  (relative or absolute path) containing all RDS files to merge is passed to it

Beware that segment from different chromosomes should not be merged together.

The segments of the sample, which has been created sooner, have all been
processed (using 500000 iterations) and saved in RDS files. Those will
now be merged together.

```
## The directory containing the results of all segments
## On RDS file has been created for each segment
directory <- system.file("extdata", "demo_vignette",
                            package = "RJMCMCNucleosomes")

## Merging predicted nucleosomes from all segments
resultsAllMerged <- mergeAllRDSFilesFromDirectory(directory)

resultsAllMerged
##
## RJMCMCNucleosomes - Predicted nucleosomes
##
## Number of nucleosomes:
## [1] 63
##
## Nucleosomes positions:
## GRanges object with 63 ranges and 0 metadata columns:
##             seqnames    ranges strand
##                <Rle> <IRanges>  <Rle>
##    [1] chr_SYNTHETIC     10075      *
##    [2] chr_SYNTHETIC     10245      *
##    [3] chr_SYNTHETIC     10407      *
##    [4] chr_SYNTHETIC     10571      *
##    [5] chr_SYNTHETIC     10742      *
##    ...           ...       ...    ...
##   [59] chr_SYNTHETIC     17421      *
##   [60] chr_SYNTHETIC     17589      *
##   [61] chr_SYNTHETIC     17756      *
##   [62] chr_SYNTHETIC     17771      *
##   [63] chr_SYNTHETIC     18257      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## 5.4 Post-process predictions

In some cases the RJMCMC method tends to over split the distribution of reads
for a single nucleosome. Although this characteristic increases the number
of false positives, it is still beneficial for the region’s rich in
nucleosomes.

A function, that merges closely positioned nucleosomes, has been implemented
to rectify the over splitting and provide more conservative results.

The `postTreatment` function must be run on the entire analyzed region to
be efficient. **It should not be run on segmented results**. The function
needs the positions of the reads used for the RJMCMC analysis.

The value of `extendingSize` should be kept low (below 20). A larger
value could cause the possible merge of true nucleosomes.

```
## Split reads from the initial sample data into forward and reverse subsets
reads <- GRanges(sample$dataIP)

## Number of nucleosomes before the post-treatment
resultsAllMerged$k
## [1] 63

## Use the post-treatment function
resultsPostTreatment <- postTreatment(reads = reads,
                            resultRJMCMC = resultsAllMerged,
                            extendingSize = 15,
                            chrLength = max(start(reads), end(reads)) + 1000)

## Number of nucleosomes after the post-treatment
length(resultsPostTreatment)
## [1] 49
```

The `postTreatment` function can significantly reduce the number of
nucleosomes by merging closely positioned nucleosomes.

## 5.5 Visualisation of the predicted nucleosomes

Visualisation of the predicted nucleosomes, with its associated read coverage,
is available in the **RJMCMCNucleosomes** package.

The `plotNucleosomes` function needs the nucleosome positions and the reads,
in an `GRanges` format, to create a graph. When reads are used
to predict more than one set of nucleosome positions (as examples, before and
after post-treatment or results from different software), the predictions can
be merged in a `list` so that all predictions can be plotted
simultaneously.

```
## Extract reads to create a GRanges
reads <-GRanges(sample$dataIP)

## Merge predictions from before post-treatment and after post-treatment in
## a list so that both results will be shown in graph
# resultsBeforeAndAfter <- list(Sample = c(sample$wp$nucleopos,
#                                             sample$fuz$nucleopos),
#                                BeforePostTreatment = resultsAllMerged$mu,
#                                AfterPostTreatment = resultsPostTreatment)
resultsBeforeAndAfter <- GRangesList(Sample = GRanges(
        rep("chr_SYNTHETIC",
            length(c(sample$wp$nucleopos,sample$fuz$nucleopos))),
        ranges = IRanges(start=c(sample$wp$nucleopos,sample$fuz$nucleopos),
                        end=c(sample$wp$nucleopos,sample$fuz$nucleopos)),
        strand=rep("*", length(c(sample$wp$nucleopos,
                                sample$fuz$nucleopos)))),
                        BeforePostTreatment = resultsAllMerged$mu,
                        AfterPostTreatment = resultsPostTreatment)
## Create graph using nucleosome positions and reads
## The plot will shows :
## 1. nucleosomes from the sample
## 2. nucleosomes detected by rjmcmc() function
## 3. nucleosomes obtained after post-treament
plotNucleosomes(nucleosomePositions = resultsBeforeAndAfter, reads = reads,
                    names=c("Sample", "RJMCMC", "After Post-Treatment"))
```

![](data:image/png;base64...)

# 6 RJMCMCNucleosomes analysis of one chromosome in one step

The `rjmcmcCHR` can analyse an entire chromosome by automatically
split the reads into segments, run `rjmcmc` on each segment, merge and
post-process the results. The intermediary steps are conserved in a
directory set by the `dirOut` parameter.

On real chromosome data, the `rjmcmcCHR` can take some time to execute. We
strongly suggest running it on a multi-core computer and to use a maximum
of cores available by setting the `nbCores` parameter.

```
## Load synthetic dataset of reads
data(syntheticNucleosomeReads)

## Number of reads in the dataset
nrow(syntheticNucleosomeReads$dataIP)

## Use the dataset to create a GRanges object
sampleGRanges <- GRanges(syntheticNucleosomeReads$dataIP)

## All reads are related to one chromosome called "chr_SYNTHETIC"
seqnames(sampleGRanges)

## Run RJMCMC on all reads
result <- rjmcmcCHR(reads = sampleGRanges,
                seqName = "chr_SYNTHETIC", dirOut = "testRJMCMCCHR",
                zeta = 147, delta=50, maxLength=1200,
                nbrIterations = 500, lambda = 3, kMax = 30,
                minInterval = 146, maxInterval = 292, minReads = 5,
                vSeed = 10113, nbCores = 2, saveAsRDS = FALSE,
                saveSEG = FALSE)

result
```

When the `saveSEG` parameter is set to `TRUE`, the segments created
during the segmentation step are saved in RDS files. To save the results for
each segment, the `saveRDS` parameter has to be set to `TRUE`.

# 7 Session info

Here is the output of `sessionInfo()` on the system on which this document was
compiled:

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
## [1] nucleoSim_1.38.0         RJMCMCNucleosomes_1.34.0 GenomicRanges_1.62.0
## [4] Seqinfo_1.0.0            IRanges_2.44.0           S4Vectors_0.48.0
## [7] BiocGenerics_0.56.0      generics_0.1.4           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10                 SparseArray_1.10.0
##  [3] bitops_1.0-9                stringi_1.8.7
##  [5] lattice_0.22-7              magrittr_2.0.4
##  [7] digest_0.6.37               grid_4.5.1
##  [9] evaluate_1.0.5              bookdown_0.45
## [11] fastmap_1.2.0               jsonlite_2.0.0
## [13] Matrix_1.7-4                cigarillo_1.0.0
## [15] restfulr_0.0.16             consensusSeekeR_1.38.0
## [17] tinytex_0.57                BiocManager_1.30.26
## [19] httr_1.4.7                  XML_3.99-0.19
## [21] Biostrings_2.78.0           codetools_0.2-20
## [23] jquerylib_0.1.4             abind_1.4-8
## [25] cli_3.6.5                   rlang_1.1.6
## [27] crayon_1.5.3                XVector_0.50.0
## [29] Biobase_2.70.0              DelayedArray_0.36.0
## [31] cachem_1.1.0                yaml_2.3.10
## [33] S4Arrays_1.10.0             tools_4.5.1
## [35] parallel_4.5.1              BiocParallel_1.44.0
## [37] Rsamtools_2.26.0            SummarizedExperiment_1.40.0
## [39] curl_7.0.0                  R6_2.6.1
## [41] magick_2.9.0                BiocIO_1.20.0
## [43] matrixStats_1.5.0           lifecycle_1.0.4
## [45] stringr_1.5.2               rtracklayer_1.70.0
## [47] bslib_0.9.0                 glue_1.8.0
## [49] Rcpp_1.1.0                  xfun_0.53
## [51] GenomicAlignments_1.46.0    MatrixGenerics_1.22.0
## [53] knitr_1.50                  rjson_0.2.23
## [55] htmltools_0.5.8.1           rmarkdown_2.30
## [57] compiler_4.5.1              RCurl_1.98-1.17
```

# References

Chen, K., L. Wang, M. Yang, J. Liu, C. Xin, S. Hu, and J. Yu. 2010. “Sequence Signature of Nucleosome Positioning in Caenorhabditis Elegans.” *Genomics Proteomics Bioinformatics* 8: 92–102. [https://doi.org/10.1016/S1672-0229(10)60010-1](https://doi.org/10.1016/S1672-0229%2810%2960010-1).

Green, P. 1995. “Reversible Jump Markov Chain Monte Carlo Computation and Bayesian Model Determination.” *Biometrika* 82: 711–32. <https://doi.org/10.1093/biomet/82.4.711>.

Polishko, Anton, Nadia Ponts, Karine G. Le Roch, and Stefano Lonardi. 2012. “NOrMAL: Accurate Nucleosome Positioning Using a Modified Gaussian Mixture Model.” *Bioinformatics* 28 (12): 242–49. <https://doi.org/10.1093/bioinformatics/bts206>.

Richardson, S., and P. Green. 1997. “On Bayesian Analysis of Mixtures with an Unknown Number of Components.” *Journal of Royal Statistical Society B* 59: 731–92.

Xi, L., Y. Fondufe-Mittendorf, L. Xia, J. Flatow, J. Widom, and J-P. Wang. 2010. “Predicting Nucleosome Positioning Using a Duration Hidden Markov Model.” *BMC Bioinformatics* 11: 346. <https://doi.org/10.1186/1471-2105-11-346>.