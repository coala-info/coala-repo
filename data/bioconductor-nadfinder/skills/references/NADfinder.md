# NADfinder Guide

Jianhong Ou, Haibo Liu, Jun Yu, Paul Kaufman and Lihua Julie Zhu

#### 30 October 2025

#### Package

NADfinder 1.34.0

# Contents

* [1 Introduction](#introduction)
* [2 Single pair of nucleoleus associated DNA and whole genomic DNA sequencing](#single-pair-of-nucleoleus-associated-dna-and-whole-genomic-dna-sequencing)
  + [2.1 Coverage calculation](#coverage-calculation)
  + [2.2 Call peaks](#call-peaks)
* [3 Samples with more than one replicate](#samples-with-more-than-one-replicate)
* [4 Session Info](#session-info)
* [References](#references)

# 1 Introduction

Nucleoli serve as major organizing hubs for the three-dimensional structure
of mammalian heterochromatin[1](#ref-politz2016redundancy). Specific loci, termed
nucleolar-associated domains (NADs), form frequent three-dimensional
associations with nucleoli.[2](#ref-nemeth2010initial) Early mammalian
development is a critical period to study NAD biological function, because
interactions between pericentromeric chromatin and perinucleolar regions are
particularly dynamic during embryonic development.[4](#ref-aguirre20123d) Here, we developed a Bioconductor
package NADfinder for bioinformatic analysis of the NAD-seq data, including
normalization, smoothing, peak calling, peak trimming and annotation.
We demonstrate the application of NADfinder in mapping the NADs in the mouse
genome, determining how these associations are altered during embryonic stem
cell (ESC) differentiation, and develop tools for study of these higher-order
chromosome interactions in fixed and live single cells (Fig. 1).

![](data:image/png;base64...)

Fig. 1 Workflow for NAD peak identification. Read counts are summarized for
each 50kb moving window with step size of 1kb for nucleolar and genomic
samples. Log2 ratio between nucleolar and genomic samples was computed for
each window, followed by local background correction, smoothing, peak calling,
filtering and annotation.

# 2 Single pair of nucleoleus associated DNA and whole genomic DNA sequencing

samples
Here is an example to use NADfinder for peak calling.

## 2.1 Coverage calculation

Here is the code snippet for calculating coverage with a sliding window in a
given step along the genome using a pair of bam files from genomic sample as
background and purified nucleoleus-associated DNA as target signal.

```
## load the library
library(NADfinder)
library(SummarizedExperiment)
## test bam files in the package
path <- system.file("extdata", package = "NADfinder", lib.loc = NULL,
            mustWork = TRUE)
bamFiles <- dir(path, ".bam$")

## window size for tile of genome. Here we set it to a big window size,
## ie., 50k because of the following two reasons:
## 1. peaks of NADs are wide;
## 2. data will be smoothed better with bigger window size.
ws <- 50000
## step for tile of genome
step <- 5000
## Set the background.
## 0.25 means 25% of the lower ratios will be used for background training.
backgroundPercentage <- 0.25
## Count the reads for each window with a given step in the genome.
## The output will be a GRanges object.
library(BSgenome.Mmusculus.UCSC.mm10)
```

```
se <- tileCount(reads=file.path(path, bamFiles),
                genome=Mmusculus,
                windowSize=ws,
                step=step,
                mode = IntersectionNotStrict,
                dataOverSamples = FALSE)
```

Here we load the pre-computed coverage data single.count to save build time.

```
data(single.count)
se <- single.count
```

For quality asessment, `cumulativePercentage` can be used to plot the
cumulative sums of sorted read counts for nucleolus-associated DNA and
whole genomic DNA. We expect the cumulative sum in the genomic DNA to
be close to a straight line because the coverage for the genomic DNA
sample should be uniformly distributed. Unlike ChIP-seq data, the
cumulative sum for the nucleoleus sample will not exhibit sharp changes
because most of NADs are broad regions as wide as 100 kb. However, we
should observe clear differences between the two curves.

```
## Calculate ratios for peak calling. We use nucleoleus vs genomic DNA.
dat <- log2se(se, nucleolusCols = "N18.subsampled.srt.bam",
              genomeCols ="G18.subsampled.srt.bam",
              transformation = "log2CPMRatio")
## Smooth the ratios for each chromosome.
## We found that for each chromosome, the ratios are higher in 5'end than 3'end.
datList <- smoothRatiosByChromosome(dat, chr = c("chr18", "chr19"), N = 100)
## check the difference between the cumulative percentage tag allocation
## in genome and nucleoleus samples.
cumulativePercentage(datList[["chr18"]])
```

![](data:image/png;base64...)

## 2.2 Call peaks

Before peak calling, the function `smoothRatiosByChromosome` is used for
log ratios calculation, normalization and smoothing.

The peaks will be called if the ratios are significantly higher than
chromosome-specific background determined by `trimPeaks`.
The following figure shows the peaks (black rectangles) called
using normalized (green curve) and smoothed (red curve) log2 ratios.

```
## check the results of smooth function
chr18 <- datList[["chr18"]] ## we only have reads in chr18 in test data.
chr18subset <- subset(chr18, seq.int(floor(length(chr18)/10))*10)
chr18 <- assays(chr18subset)
ylim <- range(c(chr18$ratio[, 1],
                chr18$bcRatio[, 1],
                chr18$smoothedRatio[, 1]))
plot(chr18$ratio[, 1],
     ylim=ylim*c(.9, 1.1),
     type="l", main="chr18")
abline(h=0, col="cyan", lty=2)
points(chr18$bcRatio[, 1], type="l", col="green")
points(chr18$smoothedRatio[, 1], type="l", col="red")
legend("topright",
       legend = c("raw_ratio", "background_corrected", "smoothed"),
       fill = c("black", "green", "red"))
## call peaks for each chromosome
peaks <- lapply(datList, trimPeaks,
                backgroundPercentage=backgroundPercentage,
                cutoffAdjPvalue=0.05, countFilter=1000)
## plot the peaks in "chr18"
peaks.subset <- countOverlaps(rowRanges(chr18subset), peaks$chr18)>=1
peaks.run <- rle(peaks.subset)
run <- cumsum(peaks.run$lengths)
run <- data.frame(x0=c(1, run[-length(run)]), x1=run)
#run <- run[peaks.run$values, , drop=FALSE]
rect(xleft = run$x0, ybottom = ylim[2]*.75,
     xright = run$x1, ytop = ylim[2]*.8,
     col = "black")
```

![](data:image/png;base64...)

```
## convert list to a GRanges object
peaks.gr <- unlist(GRangesList(peaks))
```

The following shows how to save or export the called peaks for
downstream analysis.

```
## output the peaks
write.csv(as.data.frame(unname(peaks.gr)), "peaklist.csv", row.names=FALSE)
## export peaks to a bed file.
library(rtracklayer)
#export(peaks.gr, "peaklist.bed", "BED")
```

# 3 Samples with more than one replicate

Data analysis with multiple biological replicates follows the same steps as
that of a single paired samples, i.e., coverage calculation, normalization
and smoothing, and peak calling. The only difference is that limma is used
to determine the statistical significance in peak calling.

```
library(NADfinder)
## bam file path
path <- system.file("extdata", package = "NADfinder", lib.loc = NULL,
            mustWork = TRUE)
bamFiles <- dir(path, ".bam$")

f <- bamFiles
ws <- 50000
step <- 5000
library(BSgenome.Mmusculus.UCSC.mm10)
```

```
se <- tileCount(reads=file.path(path, f),
                genome=Mmusculus,
                windowSize=ws,
                step=step)
```

Load saved coverage.

```
data(triplicate.count)
se <- triplicate.count

## Calculate ratios for nucleoloar vs genomic samples.
se <- log2se(se,
             nucleolusCols = c("N18.subsampled.srt-2.bam",
                                "N18.subsampled.srt-3.bam",
                                "N18.subsampled.srt.bam" ),
             genomeCols = c("G18.subsampled.srt-2.bam",
                            "G18.subsampled.srt-3.bam",
                            "G18.subsampled.srt.bam"),
             transformation = "log2CPMRatio")
seList<- smoothRatiosByChromosome(se, chr="chr18")
cumulativePercentage(seList[["chr18"]])
```

![](data:image/png;base64...)

```
peaks <- lapply(seList, callPeaks,
                cutoffAdjPvalue=0.05, countFilter=1)
peaks <- unlist(GRangesList(peaks))
peaks
```

```
## GRanges object with 552 ranges and 6 metadata columns:
##             seqnames            ranges strand | N18.subsampled.srt.2.bam
##                <Rle>         <IRanges>  <Rle> |                <numeric>
##     chr18.1    chr18   2956001-3138000      * |                  1.97569
##     chr18.2    chr18   3141001-3249000      * |                  2.15444
##     chr18.3    chr18   3302001-3381000      * |                  1.82705
##     chr18.4    chr18   3413001-3455000      * |                  1.91337
##     chr18.5    chr18   3480001-3510000      * |                  1.86436
##         ...      ...               ...    ... .                      ...
##   chr18.552    chr18 90001001-90086000      * |                 2.017107
##   chr18.553    chr18 90087001-90182000      * |                 2.055698
##   chr18.554    chr18 90291001-90421000      * |                 1.223125
##   chr18.555    chr18 90465001-90554000      * |                 0.849524
##   chr18.556    chr18 90645001-90649000      * |                 1.937102
##             N18.subsampled.srt.3.bam N18.subsampled.srt.bam    AveSig
##                            <numeric>              <numeric> <numeric>
##     chr18.1                  1.97569                1.97569   1.97569
##     chr18.2                  2.15444                2.15444   2.15444
##     chr18.3                  1.82705                1.82705   1.82705
##     chr18.4                  1.91337                1.91337   1.91337
##     chr18.5                  1.86436                1.86436   1.86436
##         ...                      ...                    ...       ...
##   chr18.552                 2.017107               2.017107  2.017107
##   chr18.553                 2.055698               2.055698  2.055698
##   chr18.554                 1.223125               1.223125  1.223125
##   chr18.555                 0.849524               0.849524  0.849524
##   chr18.556                 1.937102               1.937102  1.937102
##                 P.value   adj.P.Val
##               <numeric>   <numeric>
##     chr18.1 6.26990e-45  1.1357e-43
##     chr18.2 6.57176e-45  1.1357e-43
##     chr18.3 7.60885e-45  1.1357e-43
##     chr18.4 7.76846e-45  1.1357e-43
##     chr18.5 7.83128e-45  1.1357e-43
##         ...         ...         ...
##   chr18.552 6.55868e-45 1.13570e-43
##   chr18.553 7.45587e-45 1.13570e-43
##   chr18.554 1.01613e-44 1.25293e-43
##   chr18.555 9.66813e-45 1.20790e-43
##   chr18.556 2.52998e-43 1.87847e-42
##   -------
##   seqinfo: 66 sequences (1 circular) from mm10 genome
```

The peaks can be visualized along the ideogram using `plotSig`.

```
ideo <- readRDS(system.file("extdata", "ideo.mm10.rds",
                            package = "NADfinder"))
plotSig(ideo=ideo, grList=GRangesList(peaks), mcolName="AveSig",
        layout=list("chr18"),
        parameterList=list(types="heatmap"))
```

![](data:image/png;base64...)

# 4 Session Info

```
sessionInfo()
```

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
##  [1] BSgenome.Mmusculus.UCSC.mm10_1.4.3 BSgenome_1.78.0
##  [3] rtracklayer_1.70.0                 BiocIO_1.20.0
##  [5] Biostrings_2.78.0                  XVector_0.50.0
##  [7] NADfinder_1.34.0                   SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0                     MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0                  GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0                      IRanges_2.44.0
## [15] S4Vectors_0.48.0                   BiocGenerics_0.56.0
## [17] generics_0.1.4                     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] ProtGenerics_1.42.0          bitops_1.0-9
##   [3] DirichletMultinomial_1.52.0  TFBSTools_1.48.0
##   [5] httr_1.4.7                   RColorBrewer_1.1-3
##   [7] InteractionSet_1.38.0        numDeriv_2016.8-1.1
##   [9] tools_4.5.1                  backports_1.5.0
##  [11] R6_2.6.1                     HDF5Array_1.38.0
##  [13] lazyeval_0.2.2               Gviz_1.54.0
##  [15] sn_2.1.1                     rhdf5filters_1.22.0
##  [17] prettyunits_1.2.0            gridExtra_2.3
##  [19] VennDiagram_1.7.3            cli_3.6.5
##  [21] formatR_1.14                 EmpiricalBrownsMethod_1.38.0
##  [23] ATACseqQC_1.34.0             grImport_0.9-7
##  [25] sandwich_3.1-1               sass_0.4.10
##  [27] mvtnorm_1.3-3                S7_0.2.0
##  [29] randomForest_4.7-1.2         Rsamtools_2.26.0
##  [31] txdbmaker_1.6.0              foreign_0.8-90
##  [33] dichromat_2.0-0.1            plotrix_3.8-4
##  [35] limma_3.66.0                 rstudioapi_0.17.1
##  [37] RSQLite_2.4.3                gtools_3.9.5
##  [39] dplyr_1.1.4                  Matrix_1.7-4
##  [41] interp_1.1-6                 futile.logger_1.4.3
##  [43] abind_1.4-8                  lifecycle_1.0.4
##  [45] multcomp_1.4-29              yaml_2.3.10
##  [47] edgeR_4.8.0                  mathjaxr_1.8-0
##  [49] rhdf5_2.54.0                 SparseArray_1.10.0
##  [51] BiocFileCache_3.0.0          grid_4.5.1
##  [53] blob_1.2.4                   crayon_1.5.3
##  [55] pwalign_1.6.0                lattice_0.22-7
##  [57] GenomicFeatures_1.62.0       cigarillo_1.0.0
##  [59] KEGGREST_1.50.0              magick_2.9.0
##  [61] GenomicScores_2.22.0         pillar_1.11.1
##  [63] knitr_1.50                   metapod_1.18.0
##  [65] rjson_0.2.23                 codetools_0.2-20
##  [67] strawr_0.0.92                mutoss_0.1-13
##  [69] glue_1.8.0                   data.table_1.17.8
##  [71] vctrs_0.6.5                  png_0.1-8
##  [73] Rdpack_2.6.4                 gtable_0.3.6
##  [75] cachem_1.1.0                 xfun_0.53
##  [77] rbibutils_2.3                S4Arrays_1.10.0
##  [79] preseqR_4.0.0                baseline_1.3-7
##  [81] survival_3.8-3               signal_1.8-1
##  [83] tinytex_0.57                 statmod_1.5.1
##  [85] TH.data_1.1-4                bit64_4.6.0-1
##  [87] progress_1.2.3               filelock_1.0.3
##  [89] GenomeInfoDb_1.46.0          bslib_0.9.0
##  [91] KernSmooth_2.23-26           rpart_4.1.24
##  [93] colorspace_2.1-2             seqLogo_1.76.0
##  [95] DBI_1.2.3                    Hmisc_5.2-4
##  [97] nnet_7.3-20                  ade4_1.7-23
##  [99] motifStack_1.54.0            mnormt_2.1.1
## [101] tidyselect_1.2.1             bit_4.6.0
## [103] compiler_4.5.1               curl_7.0.0
## [105] httr2_1.2.1                  graph_1.88.0
## [107] csaw_1.44.0                  htmlTable_2.4.3
## [109] h5mread_1.2.0                SparseM_1.84-2
## [111] TFisher_0.2.0                DelayedArray_0.36.0
## [113] bookdown_0.45                checkmate_2.3.3
## [115] scales_1.4.0                 caTools_1.18.3
## [117] RBGL_1.86.0                  rappdirs_0.3.3
## [119] stringr_1.5.2                digest_0.6.37
## [121] rmarkdown_2.30               htmltools_0.5.8.1
## [123] pkgconfig_2.0.3              jpeg_0.1-11
## [125] base64enc_0.1-3              dbplyr_2.5.1
## [127] regioneR_1.42.0              fastmap_1.2.0
## [129] ensembldb_2.34.0             rlang_1.1.6
## [131] htmlwidgets_1.6.4            UCSC.utils_1.6.0
## [133] farver_2.1.2                 jquerylib_0.1.4
## [135] zoo_1.8-14                   jsonlite_2.0.0
## [137] BiocParallel_1.44.0          VariantAnnotation_1.56.0
## [139] RCurl_1.98-1.17              magrittr_2.0.4
## [141] polynom_1.4-1                Formula_1.2-5
## [143] Rhdf5lib_1.32.0              Rcpp_1.1.0
## [145] trackViewer_1.46.0           stringi_1.8.7
## [147] MASS_7.3-65                  AnnotationHub_4.0.0
## [149] parallel_4.5.1               deldir_2.0-4
## [151] splines_4.5.1                multtest_2.66.0
## [153] hms_1.1.4                    locfit_1.5-9.12
## [155] qqconf_1.3.2                 biomaRt_2.66.0
## [157] futile.options_1.0.1         TFMPvalue_0.0.9
## [159] BiocVersion_3.22.0           XML_3.99-0.19
## [161] evaluate_1.0.5               metap_1.12
## [163] universalmotif_1.28.0        latticeExtra_0.6-31
## [165] biovizBase_1.58.0            lambda.r_1.2.4
## [167] BiocManager_1.30.26          tidyr_1.3.1
## [169] purrr_1.1.0                  ggplot2_4.0.0
## [171] restfulr_0.0.16              AnnotationFilter_1.34.0
## [173] ChIPpeakAnno_3.44.0          tibble_3.3.0
## [175] memoise_2.0.1                AnnotationDbi_1.72.0
## [177] GenomicAlignments_1.46.0     cluster_2.1.8.1
## [179] corrplot_0.95
```

# References

1. Politz, J. C. R., Scalzo, D. & Groudine, M. The redundancy of the mammalian heterochromatic compartment. *Current opinion in genetics & development* **37,** 1–8 (2016).

2. Németh, A. *et al.* Initial genomics of the human nucleolus. *PLoS Genet* **6,** e1000889 (2010).

3. Koningsbruggen, S. van *et al.* High-resolution whole-genome sequencing reveals that specific chromatin domains from most human chromosomes associate with nucleoli. *Molecular biology of the cell* **21,** 3735–3748 (2010).

4. Aguirre-Lavin, T. *et al.* 3D-fish analysis of embryonic nuclei in mouse highlights several abrupt changes of nuclear organization during preimplantation development. *BMC developmental biology* **12,** 1 (2012).

5. Popken, J. *et al.* Reprogramming of fibroblast nuclei in cloned bovine embryos involves major structural remodeling with both striking similarities and differences to nuclear phenotypes of in vitro fertilized embryos. *Nucleus* **5,** 555–589 (2014).