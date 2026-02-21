# ATACseqQC Guide

#### Jianhong Ou, Haibo Liu, Jun Yu, Michelle Kelliher, Lucio Castilla, Nathan Lawson, Lihua Julie Zhu

#### 29 October 2025

# Introduction

Assay for Transposase-Accessible Chromatin using sequencing (ATAC-seq) is an alternative or complementary technique to MNase-seq, DNase-seq, and FAIRE-seq for chromatin accessibility analysis. The results obtained from ATAC-seq are similar to those from DNase-seq and FAIRE-seq. ATAC-seq is gaining popularity because it does not require cross-linking, has higher signal to noise ratio, requires a much smaller amount of biological material and is faster and easier to perform, compared to other techniques.1

To help researchers quickly assess the quality of ATAC-seq data, we have developed the ATACseqQC package for easily making diagnostic plots following the published guidelines.1 In addition, it has functions to preprocess ATACseq data for subsequent peak calling.

# Quick start

Here is an example using ATACseqQC with a subset of published ATAC-seq data1. Currently, only bam input file format is supported.

First install ATACseqQC and other packages required to run the examples. Please note that the example dataset used here is from human. To run analysis with dataset from a different species or differnt assembly, please install the corresponding BSgenome, TxDb and phastCons. For example, to analyze mouse data aligned to mm10, please install BSgenome.Mmusculus.UCSC.mm10, TxDb.Mmusculus.UCSC.mm10.knownGene and phastCons60way.UCSC.mm10. Please note that phstCons60way.UCSC.mm10 is optional, which can be obtained according to the vignettes of GenomicScores.

```
library(BiocManager)
BiocManager::install(c("ATACseqQC", "ChIPpeakAnno", "MotifDb", "GenomicAlignments",
           "BSgenome.Hsapiens.UCSC.hg19", "TxDb.Hsapiens.UCSC.hg19.knownGene",
           "phastCons100way.UCSC.hg19"))
```

```
## load the library
library(ATACseqQC)
## input the bamFile from the ATACseqQC package
bamfile <- system.file("extdata", "GL1.bam",
                        package="ATACseqQC", mustWork=TRUE)
bamfile.labels <- gsub(".bam", "", basename(bamfile))
```

## IGV snapshot

Source code of IGVSnapshot function is available in extdata folder. To call the function, please try

```
source(system.file("extdata", "IGVSnapshot.R", package = "ATACseqQC"))
```

## Estimate the library complexity

```
#bamQC(bamfile, outPath=NULL)
estimateLibComplexity(readsDupFreq(bamfile))
```

![](data:image/png;base64...)

## Fragment size distribution

First, there should be a large proportion of reads with less than 100 bp, which represents the nucleosome-free region. Second, the fragment size distribution should have a clear periodicity, which is evident in the inset figure, indicative of nucleosome occupacy (present in integer multiples).

```
## generate fragement size distribution
fragSize <- fragSizeDist(bamfile, bamfile.labels)
```

![](data:image/png;base64...)

## Nucleosome positioning

### Adjust the read start sites

Tn5 transposase has been shown to bind as a dimer and inserts two adaptors into accessible DNA locations separated by 9 bp.2

Therefore, for downstream analysis, such as peak-calling and footprinting, all reads in input bamfile need to be shifted. The function `shiftGAlignmentsList` can be used to shift the reads. By default, all reads aligning to the positive strand are offset by +4bp, and all reads aligning to the negative strand are offset by -5bp.1

The adjusted reads will be written into a new bamfile for peak calling or footprinting.

```
## bamfile tags to be read in
possibleTag <- list("integer"=c("AM", "AS", "CM", "CP", "FI", "H0", "H1", "H2",
                                "HI", "IH", "MQ", "NH", "NM", "OP", "PQ", "SM",
                                "TC", "UQ"),
                 "character"=c("BC", "BQ", "BZ", "CB", "CC", "CO", "CQ", "CR",
                               "CS", "CT", "CY", "E2", "FS", "LB", "MC", "MD",
                               "MI", "OA", "OC", "OQ", "OX", "PG", "PT", "PU",
                               "Q2", "QT", "QX", "R2", "RG", "RX", "SA", "TS",
                               "U2"))
library(Rsamtools)
bamTop100 <- scanBam(BamFile(bamfile, yieldSize = 100),
                     param = ScanBamParam(tag=unlist(possibleTag)))[[1]]$tag
tags <- names(bamTop100)[lengths(bamTop100)>0]
tags
```

```
##    integer2   integer13 character16
##        "AS"        "NM"        "MD"
```

```
## files will be output into outPath
outPath <- "splited"
dir.create(outPath)
## shift the coordinates of 5'ends of alignments in the bam file
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
## if you don't have an available TxDb, please refer
## GenomicFeatures::makeTxDbFromGFF to create one from gff3 or gtf file.
seqlev <- "chr1" ## subsample data for quick run
seqinformation <- seqinfo(TxDb.Hsapiens.UCSC.hg19.knownGene)
which <- as(seqinformation[seqlev], "GRanges")
gal <- readBamFile(bamfile, tag=tags, which=which, asMates=TRUE, bigFile=TRUE)
shiftedBamfile <- file.path(outPath, "shifted.bam")
gal1 <- shiftGAlignmentsList(gal, outbam=shiftedBamfile)
```

```
##   |                                                                              |                                                                      |   0%  |                                                                              |==============                                                        |  20%  |                                                                              |============================                                          |  40%  |                                                                              |==========================================                            |  60%  |                                                                              |========================================================              |  80%  |                                                                              |======================================================================| 100%
```

### Promoter/Transcript body (PT) score

PT score is calculated as the coverage of promoter divided by the coverage of its transcript body. PT score will show if the signal is enriched in promoters.

```
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txs <- transcripts(TxDb.Hsapiens.UCSC.hg19.knownGene)
pt <- PTscore(gal1, txs)
plot(pt$log2meanCoverage, pt$PT_score,
     xlab="log2 mean coverage",
     ylab="Promoter vs Transcript")
```

![](data:image/png;base64...)

### Nucleosome Free Regions (NFR) score

NFR score is a ratio between cut signal adjacent to TSS and that flanking the corresponding TSS. Each TSS window of 400 bp is first divided into 3 sub-regions: the most upstream 150 bp (n1), the most downstream of 150 bp (n2), and the middle 100 bp (nf). Then the number of fragments with 5’ ends overlapping each region are calculated for each TSS. The NFR score for each TSS is calculated as NFR-score = log2(nf) - log2((n1+n2)/2). A plot can be generated with the NFR scores as Y-axis and the average signals of 400 bp window as X-axis, very like a MA plot for gene expression data.

```
nfr <- NFRscore(gal1, txs)
plot(nfr$log2meanCoverage, nfr$NFR_score,
     xlab="log2 mean coverage",
     ylab="Nucleosome Free Regions score",
     main="NFRscore for 200bp flanking TSSs",
     xlim=c(-10, 0), ylim=c(-5, 5))
```

![](data:image/png;base64...)

### Transcription Start Site (TSS) Enrichment Score

TSS enrichment score is a raio between aggregate distribution of reads centered on TSSs and that flanking the corresponding TSSs. TSS score = the depth of TSS (each 100bp window within 1000 bp each side) / the depth of end flanks (100bp each end). TSSE score = max(mean(TSS score in each window)). TSS enrichment score is calculated according to the definition at <https://www.encodeproject.org/data-standards/terms/#enrichment>. Transcription start site (TSS) enrichment values are dependent on the reference files used; cutoff values for high quality data are listed in the following table from <https://www.encodeproject.org/atac-seq/>.

```
tsse <- TSSEscore(gal1, txs)
tsse$TSSEscore
```

```
## [1] 14.71465
```

```
plot(100*(-9:10-.5), tsse$values, type="b",
     xlab="distance to TSS",
     ylab="aggregate TSS score")
```

![](data:image/png;base64...)

### Split reads

The shifted reads will be split into different bins, namely nucleosome free, mononucleosome, dinucleosome, and trinucleosome. Shifted reads that do not fit into any of the above bins will be discarded. Splitting reads is a time-consuming step because we are using random forest to classify the fragments based on fragment length, GC content and conservation scores.3

By default, we assign the top 10% of short reads (reads below 100\_bp) as nucleosome-free regions and the top 10% of intermediate length reads as (reads between 180 and 247 bp) mononucleosome. This serves as the training set to classify the rest of the fragments using random forest. The number of the tree will be set to 2 times of square root of the length of the training set.

```
library(BSgenome.Hsapiens.UCSC.hg19)
library(phastCons100way.UCSC.hg19)
## run program for chromosome 1 only
txs <- txs[seqnames(txs) %in% "chr1"]
genome <- Hsapiens
## split the reads into NucleosomeFree, mononucleosome,
## dinucleosome and trinucleosome.
## and save the binned alignments into bam files.
objs <- splitGAlignmentsByCut(gal1, txs=txs, genome=genome, outPath = outPath,
                              conservation=phastCons100way.UCSC.hg19)
## list the files generated by splitGAlignmentsByCut.
dir(outPath)
```

```
##  [1] "NucleosomeFree.bam"     "NucleosomeFree.bam.bai" "dinucleosome.bam"
##  [4] "dinucleosome.bam.bai"   "inter1.bam"             "inter1.bam.bai"
##  [7] "inter2.bam"             "inter2.bam.bai"         "inter3.bam"
## [10] "inter3.bam.bai"         "mononucleosome.bam"     "mononucleosome.bam.bai"
## [13] "others.bam"             "others.bam.bai"         "shifted.bam"
## [16] "shifted.bam.bai"        "trinucleosome.bam"      "trinucleosome.bam.bai"
```

You can also perform shifting, splitting and saving in one step by calling `splitBam`.

```
objs <- splitBam(bamfile, tags=tags, outPath=outPath,
                 txs=txs, genome=genome,
                 conservation=phastCons100way.UCSC.hg19)
```

Conservation is an optional parameter. If you do not have the conservation score or you would like to simply split the bam files using the fragment length, then you will just need to run the command without providing the conservation argument. Without setting the conservation parameter, it will run much faster.

```
## split reads by fragment length
## NOT RUN IN THIS example
objs <- splitGAlignmentsByCut(gal1, txs=txs, outPath = outPath)
```

### Heatmap and coverage curve for nucleosome positions

By averaging the signal across all active TSSs, we should observe that nucleosome-free fragments are enriched at the TSSs, whereas the nucleosome-bound fragments should be enriched both upstream and downstream of the active TSSs and display characteristic phasing of upstream and downstream nucleosomes. Because ATAC-seq reads are concentrated at regions of open chromatin, users should see a strong nucleosome signal at the +1 nucleosome, but the signal decreases at the +2, +3 and +4 nucleosomes.

```
library(ChIPpeakAnno)
bamfiles <- file.path(outPath,
                     c("NucleosomeFree.bam",
                     "mononucleosome.bam",
                     "dinucleosome.bam",
                     "trinucleosome.bam"))
## Plot the cumulative percentage of tag allocation in nucleosome-free
## and mononucleosome bam files.
cumulativePercentage(bamfiles[1:2], as(seqinformation["chr1"], "GRanges"))
```

![](data:image/png;base64...)

```
TSS <- promoters(txs, upstream=0, downstream=1)
TSS <- unique(TSS)
## estimate the library size for normalization
(librarySize <- estLibSize(bamfiles))
```

```
## splited/NucleosomeFree.bam splited/mononucleosome.bam
##                      33907                       2008
##   splited/dinucleosome.bam  splited/trinucleosome.bam
##                       1934                        425
```

```
## calculate the signals around TSSs.
NTILE <- 101
dws <- ups <- 1010
sigs <- enrichedFragments(gal=objs[c("NucleosomeFree",
                                     "mononucleosome",
                                     "dinucleosome",
                                     "trinucleosome")],
                          TSS=TSS,
                          librarySize=librarySize,
                          seqlev=seqlev,
                          TSS.filter=0.5,
                          n.tile = NTILE,
                          upstream = ups,
                          downstream = dws)
## log2 transformed signals
sigs.log2 <- lapply(sigs, function(.ele) log2(.ele+1))
#plot heatmap
featureAlignedHeatmap(sigs.log2, reCenterPeaks(TSS, width=ups+dws),
                      zeroAt=.5, n.tile=NTILE)
```

![](data:image/png;base64...)

```
## get signals normalized for nucleosome-free and nucleosome-bound regions.
out <- featureAlignedDistribution(sigs,
                                  reCenterPeaks(TSS, width=ups+dws),
                                  zeroAt=.5, n.tile=NTILE, type="l",
                                  ylab="Averaged coverage")
```

```
## rescale the nucleosome-free and nucleosome signals to 0~1
range01 <- function(x){(x-min(x))/(max(x)-min(x))}
out <- apply(out, 2, range01)
matplot(out, type="l", xaxt="n",
        xlab="Position (bp)",
        ylab="Fraction of signal")
axis(1, at=seq(0, 100, by=10)+1,
     labels=c("-1K", seq(-800, 800, by=200), "1K"), las=2)
abline(v=seq(0, 100, by=10)+1, lty=2, col="gray")
```

![](data:image/png;base64...)

## plot Footprints

ATAC-seq footprints infer factor occupancy genome-wide. The `factorFootprints` function uses `matchPWM` to predict the binding sites using the input position weight matrix (PWM). Then it calculates and plots the accumulated coverage for those binding sites to show the status of the occupancy genome-wide. Unlike CENTIPEDE4, the footprints generated here do not take the conservation (PhyloP) into consideration. `factorFootprints` function could also accept the binding sites as a GRanges object.

```
## foot prints
library(MotifDb)
CTCF <- query(MotifDb, c("CTCF"))
CTCF <- as.list(CTCF)
print(CTCF[[1]], digits=2)
```

```
##      1    2    3    4    5    6     7     8     9      10    11      12      13
## A 0.17 0.23 0.29 0.10 0.33 0.06 0.052 0.037 0.023 0.00099 0.245 0.00099 0.00099
## C 0.42 0.28 0.30 0.32 0.11 0.33 0.562 0.005 0.960 0.99702 0.670 0.68901 0.99702
## G 0.25 0.23 0.26 0.27 0.42 0.55 0.052 0.827 0.013 0.00099 0.027 0.00099 0.00099
## T 0.16 0.27 0.15 0.31 0.14 0.06 0.334 0.131 0.004 0.00099 0.058 0.30900 0.00099
##      14    15    16    17      18    19   20
## A 0.050 0.253 0.004 0.172 0.00099 0.019 0.19
## C 0.043 0.073 0.418 0.150 0.00099 0.063 0.43
## G 0.017 0.525 0.546 0.055 0.99702 0.865 0.15
## T 0.890 0.149 0.032 0.623 0.00099 0.053 0.23
```

```
sigs <- factorFootprints(shiftedBamfile, pfm=CTCF[[1]],
                         genome=genome, ## Don't have a genome? ask ?factorFootprints for help
                         min.score="90%", seqlev=seqlev,
                         upstream=100, downstream=100)
```

![](data:image/png;base64...)

```
featureAlignedHeatmap(sigs$signal,
                      feature.gr=reCenterPeaks(sigs$bindingSites,
                                               width=200+width(sigs$bindingSites[1])),
                      annoMcols="score",
                      sortBy="score",
                      n.tile=ncol(sigs$signal[[1]]))
```

![](data:image/png;base64...)

```
sigs$spearman.correlation
```

```
## $`+`
##
##  Spearman's rank correlation rho
##
## data:  predictedBindingSiteScore and highest.sig.windows
## S = 6179324, p-value = 1.241e-06
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##       rho
## 0.2499378
##
##
## $`-`
##
##  Spearman's rank correlation rho
##
## data:  predictedBindingSiteScore and highest.sig.windows
## S = 6521273, p-value = 5.731e-05
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##       rho
## 0.2084312
```

```
sigs$Profile.segmentation
```

```
##           pos   distal_abun proximal_abun       binding
##   51.75000000    0.08269190    0.11405437    0.06159158
```

Here is the CTCF footprints for the full dataset. ![CTCF footprints](data:image/png;base64...)

### V-plot

V-plot is a plot to visualize fragment midpoint vs length for a given transcription factors.

```
vp <- vPlot(shiftedBamfile, pfm=CTCF[[1]],
            genome=genome, min.score="90%", seqlev=seqlev,
            upstream=200, downstream=200,
            ylim=c(30, 250), bandwidth=c(2, 1))
```

![](data:image/png;base64...)

```
distanceDyad(vp, pch=20, cex=.5)
```

![](data:image/png;base64...)

Here is the CTCF vPlot for the full dataset. ![CTCF footprints](data:image/png;base64...)

# Plot correlations for multiple samples

```
path <- system.file("extdata", package="ATACseqQC", mustWork=TRUE)
bamfiles <- dir(path, "*.bam$", full.name=TRUE)
gals <- lapply(bamfiles, function(bamfile){
               readBamFile(bamFile=bamfile, tag=character(0),
                          which=GRanges("chr1", IRanges(1, 1e6)),
                          asMates=FALSE)
         })
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txs <- transcripts(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(GenomicAlignments)
plotCorrelation(GAlignmentsList(gals), txs, seqlev="chr1")
```

![](data:image/png;base64...)

# Session Info

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
##  [1] GenomicAlignments_1.46.0
##  [2] Rsamtools_2.26.0
##  [3] SummarizedExperiment_1.40.0
##  [4] MatrixGenerics_1.22.0
##  [5] matrixStats_1.5.0
##  [6] MotifDb_1.52.0
##  [7] phastCons100way.UCSC.hg19_3.7.2
##  [8] GenomicScores_2.22.0
##  [9] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
## [10] GenomicFeatures_1.62.0
## [11] AnnotationDbi_1.72.0
## [12] Biobase_2.70.0
## [13] BSgenome.Hsapiens.UCSC.hg19_1.4.3
## [14] BSgenome_1.78.0
## [15] rtracklayer_1.70.0
## [16] BiocIO_1.20.0
## [17] Biostrings_2.78.0
## [18] XVector_0.50.0
## [19] ChIPpeakAnno_3.44.0
## [20] GenomicRanges_1.62.0
## [21] Seqinfo_1.0.0
## [22] IRanges_2.44.0
## [23] ATACseqQC_1.34.0
## [24] S4Vectors_0.48.0
## [25] BiocGenerics_0.56.0
## [26] generics_0.1.4
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              farver_2.1.2
##   [5] rmarkdown_2.30              vctrs_0.6.5
##   [7] multtest_2.66.0             Cairo_1.7-0
##   [9] memoise_2.0.1               RCurl_1.98-1.17
##  [11] base64enc_0.1-3             polynom_1.4-1
##  [13] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [15] progress_1.2.3              AnnotationHub_4.0.0
##  [17] lambda.r_1.2.4              curl_7.0.0
##  [19] Rhdf5lib_1.32.0             SparseArray_1.10.0
##  [21] rhdf5_2.54.0                sass_0.4.10
##  [23] KernSmooth_2.23-26          bslib_0.9.0
##  [25] htmlwidgets_1.6.4           httr2_1.2.1
##  [27] futile.options_1.0.1        cachem_1.1.0
##  [29] lifecycle_1.0.4             pkgconfig_2.0.3
##  [31] Matrix_1.7-4                R6_2.6.1
##  [33] fastmap_1.2.0               digest_0.6.37
##  [35] TFMPvalue_0.0.9             regioneR_1.42.0
##  [37] RSQLite_2.4.3               seqLogo_1.76.0
##  [39] filelock_1.0.3              randomForest_4.7-1.2
##  [41] httr_1.4.7                  abind_1.4-8
##  [43] compiler_4.5.1              bit64_4.6.0-1
##  [45] S7_0.2.0                    BiocParallel_1.44.0
##  [47] DBI_1.2.3                   preseqR_4.0.0
##  [49] HDF5Array_1.38.0            biomaRt_2.66.0
##  [51] MASS_7.3-65                 rappdirs_0.3.3
##  [53] DelayedArray_0.36.0         rjson_0.2.23
##  [55] gtools_3.9.5                caTools_1.18.3
##  [57] splitstackshape_1.4.8       tools_4.5.1
##  [59] glue_1.8.0                  VennDiagram_1.7.3
##  [61] h5mread_1.2.0               restfulr_0.0.16
##  [63] InteractionSet_1.38.0       rhdf5filters_1.22.0
##  [65] grid_4.5.1                  ade4_1.7-23
##  [67] TFBSTools_1.48.0            gtable_0.3.6
##  [69] tidyr_1.3.1                 ensembldb_2.34.0
##  [71] data.table_1.17.8           hms_1.1.4
##  [73] BiocVersion_3.22.0          pillar_1.11.1
##  [75] stringr_1.5.2               limma_3.66.0
##  [77] splines_4.5.1               dplyr_1.1.4
##  [79] BiocFileCache_3.0.0         lattice_0.22-7
##  [81] survival_3.8-3              bit_4.6.0
##  [83] DirichletMultinomial_1.52.0 universalmotif_1.28.0
##  [85] tidyselect_1.2.1            RBGL_1.86.0
##  [87] locfit_1.5-9.12             knitr_1.50
##  [89] grImport2_0.3-3             ProtGenerics_1.42.0
##  [91] edgeR_4.8.0                 futile.logger_1.4.3
##  [93] xfun_0.53                   statmod_1.5.1
##  [95] stringi_1.8.7               UCSC.utils_1.6.0
##  [97] lazyeval_0.2.2              yaml_2.3.10
##  [99] evaluate_1.0.5              codetools_0.2-20
## [101] cigarillo_1.0.0             tibble_3.3.0
## [103] BiocManager_1.30.26         graph_1.88.0
## [105] cli_3.6.5                   jquerylib_0.1.4
## [107] dichromat_2.0-0.1           Rcpp_1.1.0
## [109] GenomeInfoDb_1.46.0         dbplyr_2.5.1
## [111] png_0.1-8                   XML_3.99-0.19
## [113] parallel_4.5.1              ggplot2_4.0.0
## [115] blob_1.2.4                  prettyunits_1.2.0
## [117] jpeg_0.1-11                 AnnotationFilter_1.34.0
## [119] bitops_1.0-9                pwalign_1.6.0
## [121] motifStack_1.54.0           scales_1.4.0
## [123] purrr_1.1.0                 crayon_1.5.3
## [125] BiocStyle_2.38.0            rlang_1.1.6
## [127] KEGGREST_1.50.0             formatR_1.14
```

# References

1. Buenrostro, J. D., Giresi, P. G., Zaba, L. C., Chang, H. Y. & Greenleaf, W. J. Transposition of native chromatin for fast and sensitive epigenomic profiling of open chromatin, dna-binding proteins and nucleosome position. *Nature methods* **10,** 1213–1218 (2013).

2. Adey, A. *et al.* Rapid, low-input, low-bias construction of shotgun fragment libraries by high-density in vitro transposition. *Genome biology* **11,** R119 (2010).

3. Chen, K. *et al.* DANPOS: Dynamic analysis of nucleosome position and occupancy by sequencing. *Genome research* **23,** 341–351 (2013).

4. Pique-Regi, R. *et al.* Accurate inference of transcription factor binding from dna sequence and chromatin accessibility data. *Genome research* **21,** 447–455 (2011).