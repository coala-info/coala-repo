# GenomicPlot: an R package for efficient and flexible visualization of genome-wide NGS coverage profiles

Shuye Pu

#### 11 December 2025

#### Package

GenomicPlot 1.8.1

# Introduction

Visualization of next generation sequencing (NGS) data at various genomic features on a genome-wide scale provides an effective way of exploring and communicating experimental results on one hand, yet poses as a tremendous challenge on the other hand, due to the huge amount of data to be processed. Existing software tools like [deeptools](https://github.com/deeptools/deepTools), [ngs.plot](https://github.com/shenlab-sinai/ngsplot), *[CoverageView](https://bioconductor.org/packages/3.22/CoverageView)* and *[metagene2](https://bioconductor.org/packages/3.22/metagene2)*, while having attractive features and perform reasonably well in relatively simple scenarios, like plotting coverage profiles of fixed genomic loci or regions, have serious limitations in terms of efficiency and flexibility. For instance, deeptools requires 3 steps (3 sub-programs to be run) to generate plots from input files: first, convert .bam files to .bigwig format; second, compute coverage matrix; and last, plot genomic profiles. Huge amount of intermediate data are generated along the way and additional efforts have to be made to integrate these 3 closely related steps. All of them focus on plotting signals within genomic regions or around genomic loci, but not within or around combinations of genomic features. None of them have the capability of performing statistical tests on the data displayed in the profile plots.

To meet the diverse needs of experimental biologists, we have developed `GenomicPlot` using rich resources available on the R platform (particularly, the Bioconductor). Our `GenomicPlot` has the following major features:

* Generating genomic (with introns) or metagenomic (without introns) plots around gene body and its upstream and downstream regions, the gene body can be further segmented into 5’ UTR, CDS and 3’ UTR
* Plotting genomic profiles around the start and end of genomic features (like exons or introns), or custom defined genomic regions
* Plotting distance between sample peaks and genomic features, or distance from one set of peaks to another set of peaks
* Plotting peak annotation statistics (distribution in different type of genes, and in different parts of genes)
* Plotting peak overlaps as Venn diagrams
* All profile line plots have error bands
* Random features can be generated and plotted to serve as contrast to real features
* Statistical analysis results on user defined regions are plotted along with the profile plots

# Installation

The following packages are prerequisites:

GenomicRanges (>= 1.46.1), GenomicFeatures, Rsamtools, ggplot2 (>= 3.3.5), tidyr, rtracklayer (>= 1.54.0), plyranges (>= 1.14.0), dplyr (>= 1.0.8), cowplot (>= 1.1.1), VennDiagram, ggplotify, Seqinfo, IRanges, ComplexHeatmap, RCAS (>= 1.20.0), scales (>= 1.2.0), GenomicAlignments (>= 1.30.0), edgeR, forcats, circlize, viridis, ggsignif (>= 0.6.3), ggsci (>= 2.9), genomation (>= 1.26.0), ggpubr

You can install the current release version from Bioconductor:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("GenomicPlot")
```

or the development version from [Github](%22shuye2009/GenomicPlot%22) with:

```
if (!require("remotes", quietly = TRUE))
   install.packages("remotes")
remotes::install_github("shuye2009/GenomicPlot",
                        build_manual = TRUE,
                        build_vignettes = TRUE)
```

# Core functions

## 0.1 Plot gene/metagene with 5’UTR, CDS and 3’UTR

The lengths of each part of the genes are prorated based on the median length of 5’UTR, CDS and 3’UTR of protein-coding genes in the genome. The total length (including upstream and downstream extensions) are divided into the specified number of bins. Subsets of genes can be plotted as overlays for comparison.

```
suppressPackageStartupMessages(library(GenomicPlot, quietly = TRUE))
```

```
## Warning: replacing previous import 'Biostrings::pattern' by 'grid::pattern'
## when loading 'genomation'
```

```
txdb <- AnnotationDbi::loadDb(system.file("extdata", "txdb.sql",
                                          package = "GenomicPlot"))
```

```
## Loading required package: GenomicFeatures
```

```
## Loading required package: AnnotationDbi
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
data(gf5_meta)

queryfiles <- system.file("extdata", "treat_chr19.bam",
                          package = "GenomicPlot")
names(queryfiles) <- "clip_bam"
inputfiles <- system.file("extdata", "input_chr19.bam",
                          package = "GenomicPlot")
names(inputfiles) <- "clip_input"

bamimportParams <- setImportParams(
  offset = -1, fix_width = 0, fix_point = "start", norm = TRUE,
  useScore = FALSE, outRle = TRUE, useSizeFactor = FALSE, genome = "hg19"
)

plot_5parts_metagene(
  queryFiles = queryfiles,
  gFeatures_list = list("metagene" = gf5_meta),
  inputFiles = inputfiles,
  scale = FALSE,
  verbose = FALSE,
  transform = NA,
  smooth = TRUE,
  stranded = TRUE,
  outPrefix = NULL,
  importParams = bamimportParams,
  heatmap = TRUE,
  rmOutlier = 0,
  nc = 2
)
```

```
## 565 [set_seqinfo]
## 418 [set_seqinfo]
## 75% of values are not unique, heatmap may not show
##                     signals effectively
##
## [draw_matrix_heatmap] finished!
##
## 75% of values are not unique, heatmap may not show
##                     signals effectively
##
## [draw_matrix_heatmap] finished!
##
## 75% of values are not unique, heatmap may not show
##                     signals effectively
##
## [draw_matrix_heatmap] finished!
##
## [draw_region_profile] started ...
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the GenomicPlot package.
##   Please report the issue at <https://github.com/shuye2009/GenomicPlot/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## [draw_region_profile] finished!
##
## [draw_region_profile] started ...
##
## [draw_region_profile] finished!
##
## [draw_region_profile] started ...
##
## [draw_region_profile] finished!
##
## [draw_region_profile] started ...
##
## [draw_region_profile] finished!
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

## 0.2 Plot along the ranges of genomic features

Signal profiles along with heatmaps in genomic features or user defined genomic regions provided through a .bed file or narrowPeak file can be plotted. Multiple samples (.bam files) and multiple set of regions (.bed file) can be overlayed on the same figure, or can be output as various combinations. When input files (for input samples) are available, ratio-over-input are displayed as well. Statistical comparisons between samples or between features can be plotted as boxplots or barplots of means±SE.

```
centerfiles <- system.file("extdata", "test_chip_peak_chr19.narrowPeak",
                           package = "GenomicPlot")
names(centerfiles) <- c("NarrowPeak")
queryfiles <- c(
  system.file("extdata", "chip_treat_chr19.bam", package = "GenomicPlot")
)
names(queryfiles) <- c("chip_bam")
inputfiles <- c(
  system.file("extdata", "chip_input_chr19.bam", package = "GenomicPlot")
)
names(inputfiles) <- c("chip_input")

chipimportParams <- setImportParams(
  offset = 0, fix_width = 150, fix_point = "start", norm = TRUE,
  useScore = FALSE, outRle = TRUE, useSizeFactor = FALSE, genome = "hg19"
)

plot_region(
  queryFiles = queryfiles,
  centerFiles = centerfiles,
  inputFiles = inputfiles,
  nbins = 100,
  heatmap = TRUE,
  scale = FALSE,
  regionName = "narrowPeak",
  importParams = chipimportParams,
  verbose = FALSE,
  fiveP = -500,
  threeP = 500,
  smooth = TRUE,
  transform = NA,
  stranded = TRUE,
  outPrefix = NULL,
  Ylab = "Coverage/base/peak",
  rmOutlier = 0,
  nc = 2
)
```

```
## [set_seqinfo]
## [set_seqinfo]
## [set_seqinfo]
```

```
## [check_constraints]
```

```
## [set_seqinfo]
```

```
## [check_constraints]
```

```
## [set_seqinfo]
```

```
## [check_constraints]
```

```
## [set_seqinfo]
```

```
## [check_constraints]
```

```
## [set_seqinfo]
```

```
## [check_constraints]
```

```
## [set_seqinfo]
```

```
## [check_constraints]
```

```
## [set_seqinfo]
```

```
## 75% of values are not unique, heatmap may not show
##                     signals effectively
```

```
## [draw_matrix_heatmap] finished!
```

```
## 75% of values are not unique, heatmap may not show
##                     signals effectively
```

```
## [draw_matrix_heatmap] finished!
```

```
## [draw_region_profile] started ...
```

```
## [draw_region_profile] finished!
```

```
## [draw_region_profile] started ...
```

```
## [draw_region_profile] finished!
```

```
## [draw_region_profile] started ...
```

```
## [draw_region_profile] finished!
```

```
## [draw_region_profile] started ...
```

```
## [draw_region_profile] finished!
```

```
## 75% of values are not unique, heatmap may not show
##                     signals effectively
```

```
## [draw_matrix_heatmap] finished!
```

```
## [draw_region_profile] started ...
```

```
## [draw_region_profile] finished!
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

## 0.3 Plot genomic loci (start, end or center of a feature)

Difference in signal intensity within specific regions around the reference loci can be tested, and the test statistics can be plotted as boxplot and barplot of mean±SE. The test can be done among loci or among samples.

```
centerfiles <- c(
  system.file("extdata", "test_clip_peak_chr19.bed", package = "GenomicPlot"),
  system.file("extdata", "test_chip_peak_chr19.bed", package = "GenomicPlot")
)
names(centerfiles) <- c("iCLIPPeak", "SummitPeak")
queryfiles <- c(
  system.file("extdata", "chip_treat_chr19.bam", package = "GenomicPlot")
)
names(queryfiles) <- c("chip_bam")
inputfiles <- c(
  system.file("extdata", "chip_input_chr19.bam", package = "GenomicPlot")
)
names(inputfiles) <- c("chip_input")

plot_locus(
  queryFiles = queryfiles,
  centerFiles = centerfiles,
  ext = c(-500, 500),
  hl = c(-100, 100),
  shade = TRUE,
  smooth = TRUE,
  importParams = chipimportParams,
  binSize = 10,
  refPoint = "center",
  Xlab = "Center",
  inputFiles = inputfiles,
  stranded = TRUE,
  scale = FALSE,
  outPrefix = NULL,
  verbose = FALSE,
  transform = NA,
  rmOutlier = 0,
  Ylab = "Coverage/base/peak",
  statsMethod = "wilcox.test",
  heatmap = TRUE,
  nc = 2
)
```

```
## [set_seqinfo]
## [set_seqinfo]
## [set_seqinfo]
## [set_seqinfo]
```

```
## [check_constraints]
```

```
## [set_seqinfo]
```

```
## [check_constraints]
```

```
## [set_seqinfo]
```

```
## 75% of values are not unique, heatmap may not show
##                     signals effectively
```

```
## [draw_matrix_heatmap] finished!
##
## [draw_matrix_heatmap] finished!
```

```
## 75% of values are not unique, heatmap may not show
##                     signals effectively
```

```
## [draw_matrix_heatmap] finished!
```

```
## 75% of values are not unique, heatmap may not show
##                     signals effectively
```

```
## [draw_matrix_heatmap] finished!
```

```
## [draw_locus_profile] started ...
```

```
## [draw_locus_profile] finished
```

```
## [draw_locus_profile] started ...
```

```
## [draw_locus_profile] finished
```

```
## [draw_locus_profile] started ...
```

```
## [draw_locus_profile] finished
```

```
## [draw_locus_profile] started ...
```

```
## [draw_locus_profile] finished
```

```
## [draw_locus_profile] started ...
```

```
## [draw_locus_profile] finished
```

```
## [draw_locus_profile] started ...
```

```
## [draw_locus_profile] finished
```

```
## [draw_locus_profile] started ...
```

```
## [draw_locus_profile] finished
```

```
## [draw_locus_profile] started ...
```

```
## [draw_locus_profile] finished
```

```
## 75% of values are not unique, heatmap may not show
##                     signals effectively
```

```
## [draw_matrix_heatmap] finished!
##
## [draw_matrix_heatmap] finished!
```

```
## [draw_locus_profile] started ...
```

```
## [draw_locus_profile] finished
```

```
## [draw_locus_profile] started ...
```

```
## [draw_locus_profile] finished
```

```
## [draw_locus_profile] started ...
```

```
## [draw_locus_profile] finished
```

```
## [draw_locus_profile] started ...
```

```
## [draw_locus_profile] finished
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

## 0.4 Plot peak annotation statistics

Aside from reads coverage profiles, distribution of binding peaks in different gene types and genomic features is also important. Peak annotation statistics are plotted as bar chart for distribution in gene types, and as pie charts for distribution in genomic features. The pie charts are plotted in two different ways: either as percentage of absolute counts or as percentage of feature length-normalized counts in each features. For DNA binding samples, the features (in order of precedence) include “Promoter”, “TTS” (Transcript Termination Site), “5’UTR”, “CDS”, “3’UTR” and “Intron”; for RNA binding samples, “Promoter” and “TTS” are excluded. In the following example, “Promoter” is defined as regions 2000 bp upstream of transcription start site (TSS) and 300 bp downstream TSS, “TTS” is defined as the region 1000 bp downstream cleavage site or the length between cleavage site and the start of the next gene, whichever is shorter, but these lengths can be adjusted. To save annotation results (both peak-oriented and gene-oriented), set `verbose = TRUE`.

```
gtffile <- system.file("extdata", "gencode.v19.annotation_chr19.gtf",
                       package = "GenomicPlot")

centerfile <- system.file("extdata", "test_chip_peak_chr19.bed",
                          package = "GenomicPlot")
names(centerfile) <- c("SummitPeak")

bedimportParams <- setImportParams(
  offset = 0, fix_width = 100, fix_point = "center", norm = FALSE,
  useScore = FALSE, outRle = FALSE, useSizeFactor = FALSE, genome = "hg19"
)

pa <- plot_peak_annotation(
  peakFile = centerfile,
  gtfFile = gtffile,
  importParams = bedimportParams,
  fiveP = -2000,
  dsTSS = 300,
  threeP = 1000,
  simple = FALSE,
  verbose = FALSE,
  outPrefix = NULL
)
```

```
## [set_seqinfo]
## [set_seqinfo]
```

```
## Reading existing granges.rds object from /tmp/Rtmp1JSyk7/Rinst32715483bd293/GenomicPlot/extdata/gencode.v19.annotation_chr19.gtf.granges.rds
```

```
## Keeping standard chromosomes only
```

```
## File /tmp/Rtmp1JSyk7/Rinst32715483bd293/GenomicPlot/extdata/gencode.v19.annotation_chr19.gtf.granges.rds already exists.
##                   Use overwriteObjectAsRds = TRUE to overwrite the file
```

```
## Warning in .get_cds_IDX(mcols0$type, mcols0$phase): The "phase" metadata column contains non-NA values for features of type
##   stop_codon. This information was ignored.
```

```
## Warning in .makeTxDb_normarg_chrominfo(chrominfo): genome version information
## is not available for this TxDb object
```

```
## [get_txdb_features]
```

```
## [get_genomic_feature_coordinates] for utr5
```

```
## [extract_longest_tx]
```

```
## [get_genomic_feature_coordinates] for utr5 finished!
```

```
## [get_genomic_feature_coordinates] for utr3
```

```
## [extract_longest_tx]
```

```
## [get_genomic_feature_coordinates] for utr3 finished!
```

```
## [get_genomic_feature_coordinates] for cds
```

```
## [extract_longest_tx]
```

```
## [get_genomic_feature_coordinates] for cds finished!
```

```
## [get_genomic_feature_coordinates] for intron
```

```
## [extract_longest_tx]
```

```
## [get_genomic_feature_coordinates] for intron finished!
```

```
## [get_genomic_feature_coordinates] for transcript
```

```
## [extract_longest_tx]
```

```
## [get_genomic_feature_coordinates] for transcript finished!
```

```
## [check_constraints]
```

```
## [set_seqinfo]
```

```
## [check_constraints]
```

```
## [set_seqinfo]
```

```
## [get_targeted_genes]
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

# Auxillary functions

## 0.5 Plot bam correlations

Four plots are produced, the first one is equivalent of the ‘fingerprint plot’ of the deeptools (not shown), the second is a heatmap of correlation coefficients (not shown), the third one is a composite plot showing pairwise correlations, with histograms on the main diagonal, dotplots on the lower triangle and correlation coefficients on the upper triangle, and the last one is a plot of PCA analysis of samples from which the bam files are derived.

```
bamQueryFiles <- c(
   system.file("extdata", "chip_input_chr19.bam", package = "GenomicPlot"),
   system.file("extdata", "chip_treat_chr19.bam", package = "GenomicPlot")
)
names(bamQueryFiles) <- c("chip_input", "chip_treat")

bamImportParams <- setImportParams(
   offset = 0, fix_width = 150, fix_point = "start", norm = FALSE,
   useScore = FALSE, outRle = FALSE, useSizeFactor = FALSE,
   genome = "hg19"
)

plot_bam_correlation(
   bamFiles = bamQueryFiles, binSize = 100000, outPrefix = NULL,
   importParams = bamImportParams, nc = 2, verbose = FALSE
)
```

```
## [set_seqinfo]
## [set_seqinfo]
## [set_seqinfo]
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

## 0.6 Plot bed overlaps

Due to peak width variations, the number of overlapping peaks between set A and set B may be different for each set. This asymmetry is caught with a overlap matrix in addition to Venn diagrams (not shown).

```
queryFiles <- c(
   system.file("extdata", "test_chip_peak_chr19.narrowPeak",
             package = "GenomicPlot"),
   system.file("extdata", "test_chip_peak_chr19.bed",
             package = "GenomicPlot"),
   system.file("extdata", "test_clip_peak_chr19.bed",
             package = "GenomicPlot")
)
names(queryFiles) <- c("narrowPeak", "summitPeak", "clipPeak")

bedimportParams <- setImportParams(
   offset = 0, fix_width = 100, fix_point = "center", norm = FALSE,
   useScore = FALSE, outRle = FALSE, useSizeFactor = FALSE, genome = "hg19"
)

plot_overlap_bed(
   bedList = queryFiles, importParams = bedimportParams, pairOnly = FALSE,
   stranded = FALSE, outPrefix = NULL
)
```

```
## [set_seqinfo]
## [set_seqinfo]
## [set_seqinfo]
```

```
## [filter_by_overlaps_nonstranded]
##
## [filter_by_overlaps_nonstranded]
##
## [filter_by_overlaps_nonstranded]
##
## [filter_by_overlaps_nonstranded]
##
## [filter_by_overlaps_nonstranded]
##
## [filter_by_overlaps_nonstranded]
##
## [filter_by_overlaps_nonstranded]
##
## [filter_by_overlaps_nonstranded]
##
## [filter_by_overlaps_nonstranded]
##
## [filter_by_overlaps_nonstranded]
```

```
## The overlaps is from the Subject instead of the Query!
```

```
## [filter_by_overlaps_nonstranded]
```

```
## The overlaps is from the Subject instead of the Query!
```

```
## [filter_by_overlaps_nonstranded]
##
## [filter_by_overlaps_nonstranded]
```

```
## The overlaps is from the Subject instead of the Query!
```

```
## [filter_by_overlaps_nonstranded]
```

```
## The overlaps is from the Subject instead of the Query!
```

```
## [filter_by_overlaps_nonstranded]
##
## [filter_by_overlaps_nonstranded]
```

```
## The overlaps is from the Subject instead of the Query!
```

```
## [filter_by_overlaps_nonstranded]
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

# Appendix

## Session info

Here is the output of `sessionInfo()` on the system on which this document was
compiled:

```
## R version 4.5.2 (2025-10-31)
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
##  [1] GenomicFeatures_1.62.0 AnnotationDbi_1.72.0   Biobase_2.70.0
##  [4] GenomicPlot_1.8.1      GenomicRanges_1.62.1   Seqinfo_1.0.0
##  [7] IRanges_2.44.0         S4Vectors_0.48.0       BiocGenerics_0.56.0
## [10] generics_0.1.4         BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] BiocIO_1.20.0                     bitops_1.0-9
##   [3] ggplotify_0.1.3                   filelock_1.0.3
##   [5] tibble_3.3.0                      XML_3.99-0.20
##   [7] lifecycle_1.0.4                   httr2_1.2.2
##   [9] rstatix_0.7.3                     edgeR_4.8.1
##  [11] doParallel_1.0.17                 lattice_0.22-7
##  [13] backports_1.5.0                   magrittr_2.0.4
##  [15] limma_3.66.0                      plotly_4.11.0
##  [17] sass_0.4.10                       rmarkdown_2.30
##  [19] jquerylib_0.1.4                   yaml_2.3.12
##  [21] plotrix_3.8-13                    otel_0.2.0
##  [23] cowplot_1.2.0                     pbapply_1.7-4
##  [25] DBI_1.2.3                         RColorBrewer_1.1-3
##  [27] abind_1.4-8                       purrr_1.2.0
##  [29] RCurl_1.98-1.17                   yulab.utils_0.2.2
##  [31] rappdirs_0.3.3                    circlize_0.4.17
##  [33] seqLogo_1.76.0                    pheatmap_1.0.13
##  [35] codetools_0.2-20                  DelayedArray_0.36.0
##  [37] DT_0.34.0                         tidyselect_1.2.1
##  [39] shape_1.4.6.1                     futile.logger_1.4.3
##  [41] UCSC.utils_1.6.1                  farver_2.1.2
##  [43] viridis_0.6.5                     matrixStats_1.5.0
##  [45] BiocFileCache_3.0.0               GenomicAlignments_1.46.0
##  [47] jsonlite_2.0.0                    GetoptLong_1.1.0
##  [49] Formula_1.2-5                     iterators_1.0.14
##  [51] foreach_1.5.2                     tools_4.5.2
##  [53] progress_1.2.3                    Rcpp_1.1.0
##  [55] glue_1.8.0                        gridExtra_2.3
##  [57] SparseArray_1.10.7                xfun_0.54
##  [59] ranger_0.17.0                     MatrixGenerics_1.22.0
##  [61] GenomeInfoDb_1.46.2               dplyr_1.1.4
##  [63] withr_3.0.2                       formatR_1.14
##  [65] BiocManager_1.30.27               fastmap_1.2.0
##  [67] digest_0.6.39                     R6_2.6.1
##  [69] gridGraphics_0.5-1                seqPattern_1.42.0
##  [71] colorspace_2.1-2                  Cairo_1.7-0
##  [73] dichromat_2.0-0.1                 biomaRt_2.66.0
##  [75] RSQLite_2.4.5                     cigarillo_1.0.0
##  [77] tidyr_1.3.1                       ggsci_4.1.0
##  [79] data.table_1.17.8                 rtracklayer_1.70.0
##  [81] prettyunits_1.2.0                 httr_1.4.7
##  [83] htmlwidgets_1.6.4                 S4Arrays_1.10.1
##  [85] pkgconfig_2.0.3                   gtable_0.3.6
##  [87] blob_1.2.4                        ComplexHeatmap_2.26.0
##  [89] S7_0.2.1                          impute_1.84.0
##  [91] XVector_0.50.0                    htmltools_0.5.9
##  [93] carData_3.0-5                     bookdown_0.46
##  [95] plyranges_1.30.1                  clue_0.3-66
##  [97] scales_1.4.0                      png_0.1-8
##  [99] RCAS_1.36.0                       knitr_1.50
## [101] lambda.r_1.2.4                    tzdb_0.5.0
## [103] reshape2_1.4.5                    rjson_0.2.23
## [105] curl_7.0.0                        proxy_0.4-28
## [107] cachem_1.1.0                      GlobalOptions_0.1.3
## [109] stringr_1.6.0                     KernSmooth_2.23-26
## [111] parallel_4.5.2                    restfulr_0.0.16
## [113] pillar_1.11.1                     grid_4.5.2
## [115] vctrs_0.6.5                       ggpubr_0.6.2
## [117] car_3.1-3                         dbplyr_2.5.1
## [119] cluster_2.1.8.1                   evaluate_1.0.5
## [121] tinytex_0.58                      magick_2.9.0
## [123] readr_2.1.6                       VennDiagram_1.7.3
## [125] cli_3.6.5                         locfit_1.5-9.12
## [127] compiler_4.5.2                    futile.options_1.0.1
## [129] Rsamtools_2.26.0                  rlang_1.1.6
## [131] crayon_1.5.3                      ggsignif_0.6.4
## [133] labeling_0.4.3                    gprofiler2_0.2.4
## [135] plyr_1.8.9                        fs_1.6.6
## [137] stringi_1.8.7                     genomation_1.42.0
## [139] viridisLite_0.4.2                 gridBase_0.4-7
## [141] BiocParallel_1.44.0               txdbmaker_1.6.2
## [143] Biostrings_2.78.0                 lazyeval_0.2.2
## [145] Matrix_1.7-4                      BSgenome_1.78.0
## [147] BSgenome.Hsapiens.UCSC.hg19_1.4.3 hms_1.1.4
## [149] bit64_4.6.0-1                     ggplot2_4.0.1
## [151] KEGGREST_1.50.0                   statmod_1.5.1
## [153] SummarizedExperiment_1.40.0       broom_1.0.11
## [155] memoise_2.0.1                     bslib_0.9.0
## [157] bit_4.6.0
```