# `EpiCompare`: Getting started

#### Authors: *Sera Choi, Brian Schilder, Leyla Abbasova, Alan Murphy, Nathan Skene, Thomas Roberts, Hiranyamaya Dash*

#### Vignette updated: *Oct-29-2025*

# Contents

* [1 Overview](#overview)
  + [1.1 Introduction](#introduction)
* [2 Data](#data)
* [3 Installation](#installation)
* [4 Running *EpiCompare*](#running-epicompare)
  + [4.1 Load package and example datasets](#load-package-and-example-datasets)
  + [4.2 Prepare input data](#prepare-input-data)
    - [4.2.1 Peaklist](#peaklist)
    - [4.2.2 Blacklist](#blacklist)
    - [4.2.3 Picard summary files](#picard-summary-files)
    - [4.2.4 Reference file](#reference-file)
    - [4.2.5 Output Directory](#output-directory)
  + [4.3 Run EpiCompare](#run-epicompare)
    - [4.3.1 Optional plots](#optional-plots)
    - [4.3.2 Other options](#other-options)
  + [4.4 Output](#output)
* [5 Future Enhancements](#future-enhancements)
* [6 Code used to generate the example report](#code-used-to-generate-the-example-report)
* [7 Session Information](#session-information)

# 1 Overview

The *EpiCompare* package is designed to facilitate the comparison of epigenomic
datasets for quality control and benchmarking purposes. The package combines
several downstream analysis tools for epigenomic data and generates a single
report that collates all results of the analysis. This allows users to conduct
downstream analysis of multiple epigenomic datasets simultaneously and compare
the results in a simple and efficient way.

## 1.1 Introduction

For many years, ChIP-seq has been the standard method for epigenomic profiling,
but it suffers from a host of limitations. Recently, many other epigenomic
technologies (e.g. CUT&Run, CUT&Tag and TIP-seq etc.), designed to overcome
these constraints, have been developed. To better understand the performance of
these novel approaches, it is important that we systematically compare these
technologies and benchmark against a “gold-standard”.

There are many tools in R (e.g. *ChIPseeker*) that can be used to conduct
downstream analysis and comparison of epigenomic datasets. However, these are
often scattered across different packages and difficult to use for researchers
with none or little computational experience.

*EpiCompare* is designed to provide a simple and comprehensive way of analysing
and comparing epigenomic datasets. It combines many useful downstream analysis
tools, which can easily be controlled by users and it collates the results in a
single report. This allows researchers to systematically compare different
epigenomic technologies.

While the main functionality of *EpiCompare* is to contrast epigenomic
technologies, it can also be used to compare datasets generated using different
experimental conditions and data analysis workflows of one technology. This
can help researchers to establish a consensus regarding the optimal use of the
method.

Currently, *EpiCompare* supports human and mouse genomes (hg19, hg38, mm9 and
mm10).

# 2 Data

The *EpiCompare* package contains a small subset of histone mark H3K27ac profile
data obtained/generated from:

* ENCODE (data accession: ENCFF044JNJ)
* CUT&Tag from Kaya-Okur et al., (2019). (PMID: 31036827)
* CUT&Run from Meers et al., (2019). (PMID: 31232687)

It also contains human genome hg19 and hg38 blacklisted regions obtained from
ENCODE. The ENCODE blacklist includes regions of the genome that have anomalous
and/or unstructured signals independent of the cell-line or experiment. Removal
of ENCODE blacklist is recommended for quality measure.

These dataset will be used to showcase *EpiCompare* functionality

# 3 Installation

To install the package, run the following:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("EpiCompare")
```

# 4 Running *EpiCompare*

In this example analysis, we will compare CUT&Run and CUT&Tag of histone mark
H3K27ac against ENCODE ChIP-seq.

## 4.1 Load package and example datasets

Once installed, load the package:

```
library(EpiCompare)
```

```
##
```

```
## Warning: replacing previous import 'Biostrings::pattern' by 'grid::pattern'
## when loading 'genomation'
```

Load example datasets used in this analysis:

```
data("encode_H3K27ac") # ENCODE ChIP-seq
data("CnT_H3K27ac") # CUT&Tag
data("CnR_H3K27ac") # CUT&Run
data("hg19_blacklist") # hg19 genome blacklist
data("CnT_H3K27ac_picard") # CUT&Tag Picard summary output
data("CnR_H3K27ac_picard") # CUT&Run Picard summary output
```

## 4.2 Prepare input data

### 4.2.1 Peaklist

*EpiCompare* accepts datasets both as `GRanges` object and as paths to BED
files. Peakfiles (`GRanges` or paths) that you would like to analyse must be
listed and named (see below).

```
# To import BED files as GRanges object
peak_GRanges <-ChIPseeker::readPeakFile("/path/to/peak/file.bed",as = "GRanges")
# EpiCompare also accepts paths (to BED files) as input
peak_path <- "/path/to/BED/file1.bed"
# Create named peak list
peaklist <- list(peak_GRanges, peak_path)
names(peaklist) <- c("sample1", "sample2")
```

In this example, we will use built-in data, which have been converted into
`GRanges` object previously (`CnT_H3K27ac` and `CnR_H3K27ac`).

```
peaklist <- list(CnT_H3K27ac, CnR_H3K27ac) # create list of peakfiles
names(peaklist) <- c("CnT", "CnR") # set names
```

### 4.2.2 Blacklist

ENCODE blacklist contains regions of the genome that have anomalous
and/or unstructured signals independent of the cell-line or experiment. Removal
of these regions from peakfiles is recommended for quality measure.

*EpiCompare* has three built-in blacklist files, hg19, hg38 and mm10, downloaded
from ENCODE. Run `?hg19_blacklist` for more information.

In this example analysis, since all peakfiles (`encode_H3K27ac`, `CnT_H3K27ac`,
`CnR_H3K27ac`) were generated using human genome reference build hg19,
`hg19_blacklist` will be used. For hg38, use `data(hg38_blacklist)`.

Please ensure that you specify the correct blacklist.

### 4.2.3 Picard summary files

Note that this is *OPTIONAL*. If you want the report to include metrics on
DNA fragments (e.g. mapped fragments and duplication rate), please input summary
files from Picard.

[Picard *MarkDuplicates*](https://broadinstitute.github.io/picard/command-line-overview.html#MarkDuplicates) can be used to mark duplicate reads that are found within the alignment. This
tool outputs a metrics file with the ending `.MarkDuplicates.metrics.txt`. To
import this text file into R as data frame, use:

```
picard <- read.table("/path/to/Picard/.MarkDuplicates.metrics.txt", header = TRUE, fill = TRUE)
```

In this example. we will use built-in data, which have been converted into data
frame previously (`CnT_H3K27ac_picard` and `CnR_H3K27ac_picard`). The files
must be listed and named:

```
# create list of Picard summary
picard <- list(CnT_H3K27ac_picard, CnR_H3K27ac_picard)
names(picard) <- c("CnT", "CnR") # set names
```

### 4.2.4 Reference file

This is OPTIONAL. If reference peak file is provided, `stat_plot` and
`chromHMM_plot` of overlapping peaks are included in the report (see
*Optional plots* section below).

Reference file must be listed and named. In this example, we will use built-in
data (`encode_H3K27ac`), which has been converted to `GRanges` previously:

```
reference_peak <- list("ENCODE_H3K27ac" = encode_H3K27ac)
```

### 4.2.5 Output Directory

When running `EpiCompare()`, please ensure that you specify `output_dir`. All
outputs (figures and HTML report) will be saved in the specified `output_dir`.

## 4.3 Run EpiCompare

Running EpiCompare is done using the function, `EpiCompare()` . Users can choose
which analyses to run and include in the report by setting parameters to `TRUE`
or `FALSE`.

```
EpiCompare(peakfiles = peaklist,
           genome_build = "hg19",
           blacklist = hg19_blacklist,
           picard_files = picard,
           reference = reference_peak,
           upset_plot = FALSE,
           stat_plot = FALSE,
           chromHMM_plot = FALSE,
           chromHMM_annotation = "K562",
           chipseeker_plot = FALSE,
           enrichment_plot = FALSE,
           tss_plot = FALSE,
           interact = FALSE,
           save_output = FALSE,
           output_filename = "EpiCompare_test",
           output_timestamp = FALSE,
           output_dir = tempdir())
```

```
## NOTE: The following EpiCompare features are NOT being used:
##  - upset_plot=
##  - stat_plot=
##  - chromHMM_plot=
##  - chipseeker_plot=
##  - enrichment_plot=
##  - tss_plot=
##  - precision_recall_plot=
##  - corr_plot=
##  - add_download_button=
```

```
## processing file: EpiCompare.Rmd
```

```
## output file: EpiCompare.knit.md
```

```
## /usr/bin/pandoc +RTS -K512m -RTS EpiCompare.knit.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output /tmp/Rtmp2MHp3o/EpiCompare_test.html --lua-filter /home/biocbuild/bbs-3.22-bioc/R/site-library/rmarkdown/rmarkdown/lua/pagebreak.lua --lua-filter /home/biocbuild/bbs-3.22-bioc/R/site-library/rmarkdown/rmarkdown/lua/latex-div.lua --self-contained --variable bs3=TRUE --section-divs --table-of-contents --toc-depth 3 --variable toc_float=1 --variable toc_selectors=h1,h2,h3 --variable toc_collapsed=1 --variable toc_smooth_scroll=1 --variable toc_print=1 --template /home/biocbuild/bbs-3.22-bioc/R/site-library/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --number-sections --variable theme=bootstrap --css custom.css --mathjax --variable 'mathjax-url=https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --include-in-header /tmp/Rtmp2MHp3o/rmarkdown-str4bcc55ad79d3.html --variable code_folding=hide --variable code_menu=1
```

```
##
## Output created: /tmp/Rtmp2MHp3o/EpiCompare_test.html
```

```
## [1] "Done in 0.14 min."
```

```
## All outputs saved to: /tmp/Rtmp2MHp3o
```

```
## [1] "/tmp/Rtmp2MHp3o/EpiCompare_test.html"
```

### 4.3.1 Optional plots

By default, these plots will not be included in the report unless set `TRUE`.

* `upset_plot` : Upset plot showing the number of overlapping peaks between
  samples. *EpiCompare* uses `UpSetR` package.
* `stat_plot` : A `reference` peakfile must be included for this plot. The plot
  displays distribution of statistical significance (q-values) of sample peaks
  that are overlapping/non-overlapping with the `reference` dataset.
* `chromHMM_plot` : [ChromHMM](http://compbio.mit.edu/ChromHMM/#:~:text=ChromHMM%20is%20software%20for%20learning,and%20spatial%20patterns%20of%20marks.)
  annotation of peaks. If `reference` is provided, ChromHMM annotation of
  overlapping and non-overlapping peaks with the `reference` is also included in
  the report.
* `chipseeker_plot` : `ChIPseeker` functional annotation of peaks.
* `enrichment_plot` : KEGG pathway and GO enrichment analysis of peaks.
* `tss_plot` : Peak frequency around (+/- 3000bp) transcriptional start site.
  Note that it may take awhile to generate this plot for large sample sizes.

### 4.3.2 Other options

* `chromHMM_annotation` : Cell-line annotation for ChromHMM. Default is K562.
  Options are:
  + “K562” = K-562 cells
  + “Gm12878” = Cellosaurus cell-line GM12878
  + “H1hesc” = H1 Human Embryonic Stem Cell
  + “Hepg2” = Hep G2 cell
  + “Hmec” = Human Mammary Epithelial Cell
  + “Hsmm” = Human Skeletal Muscle Myoblasts
  + “Huvec” = Human Umbilical Vein Endothelial Cells
  + “Nhek” = Normal Human Epidermal Keratinocytes
  + “Nhlf” = Normal Human Lung Fibroblasts
* `interact` : By default, all heatmaps (percentage overlap and
  ChromHMM heatmaps) in the report will be interactive. If set FALSE, all heatmaps
  will be static. N.B. If `interact=TRUE`, interactive heatmaps will be saved as
  html files, which may take time for larger sample sizes.
* `output_filename` : By default, the report is named EpiCompare.html. You can
  specify the filename of the report here.
* `output_timestamp` : By default FALSE. If TRUE, the filename of the report
  includes the date.

## 4.4 Output

*EpiCompare* outputs

* An HTML report consisting of three sections:
  + 1. **General Metrics**: Metrics on peaks (percentage of blacklisted and
       non-standard peaks, and peak widths) and fragments (duplication rate) of
       samples.
  + 2. **Peak Overlap**: Percentage and statistical significance of overlapping
       and non-overlapping peaks. Also includes upset plot.
  + 3. **Functional Annotation**: Functional annotation (ChromHMM, ChIPseeker
       and enrichment analysis) of peaks. Also includes peak enrichment around TSS.
* `EpiCompare_file` containing all plots generated by EpiCompare if
  `save_output = TRUE`.

Both outputs are saved in the specified `output_dir`.

# 5 Future Enhancements

In the current version, *EpiCompare* only recognizes certain BED formats. We hope
to improve this. Moreover, if there are other downstream analysis tools that may
be suitable in *EpiCompare*, feel free to report this through
[Github](https://github.com/neurogenomics/EpiCompare).

# 6 Code used to generate the example report

An example report comparing ATAC-seq, DNase-seq and ChIP-seq of K562 can be found
[here](https://neurogenomics.github.io/EpiCompare/articles/example_report.html).

Code used to generate this:

```
## Load data
# ATAC-seq data: https://www.encodeproject.org/files/ENCFF558BLC/
atac1_hg38 <- ChIPseeker::readPeakFile("/path/to/bed/ENCFF558BLC.bed", as="GRanges")
# Dnase-seq data: https://www.encodeproject.org/files/ENCFF274YGF/
dna1_hg38 <- ChIPseeker::readPeakFile("/path/to/bed/ENCFF274YGF.bed", as="GRanges")
# Dnase-seq data: https://www.encodeproject.org/files/ENCFF185XRG/
dna2_hg38 <- ChIPseeker::readPeakFile("/path/to/bed/ENCFF185XRG.bed", as="GRanges")
# ChIP-seq data: https://www.encodeproject.org/files/ENCFF038DDS/
chip_hg38 <- ChIPseeker::readPeakFile("/path/to/bed/ENCODE_H3K27ac_hg38_ENCFF038DDS.bed", as="GRanges")

## Peaklist
peaklist <- list("ATAC_ENCFF558BLC" = atac1_hg38_unique,
                 "Dnase_ENCFF274YGF" = dna1_hg38,
                 "ChIP_ENCFF038DDS" = chip_hg38)

## Reference
reference <- list("Dnase_ENCFF185XRG_reference"=dna2_hg38)

## Blacklist
data("hg38_blacklist")

## Run Epicompare
EpiCompare(peakfiles = peaklist,
           genome_build = "hg38",
           genome_build_output = "hg38",
           blacklist = hg38_blacklist,
           reference = reference,
           picard_files = NULL,
           upset_plot = T,
           stat_plot = T,
           save_output = F,
           chromHMM_plot = T,
           chromHMM_annotation = "K562",
           chipseeker_plot = T,
           enrichment_plot = T,
           tss_plot = T,
           precision_recall_plot =T,
           corr_plot = T,
           interact = T,
           output_dir = "/path/")
```

# 7 Session Information

```
utils::sessionInfo()
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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] EpiCompare_1.14.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1
##   [2] BiocIO_1.20.0
##   [3] bitops_1.0-9
##   [4] ggplotify_0.1.3
##   [5] filelock_1.0.3
##   [6] tibble_3.3.0
##   [7] R.oo_1.27.1
##   [8] XML_3.99-0.19
##   [9] lifecycle_1.0.4
##  [10] httr2_1.2.1
##  [11] lattice_0.22-7
##  [12] magrittr_2.0.4
##  [13] plotly_4.11.0
##  [14] sass_0.4.10
##  [15] rmarkdown_2.30
##  [16] jquerylib_0.1.4
##  [17] yaml_2.3.10
##  [18] plotrix_3.8-4
##  [19] ggtangle_0.0.7
##  [20] cowplot_1.2.0
##  [21] DBI_1.2.3
##  [22] RColorBrewer_1.1-3
##  [23] lubridate_1.9.4
##  [24] abind_1.4-8
##  [25] GenomicRanges_1.62.0
##  [26] purrr_1.1.0
##  [27] R.utils_2.13.0
##  [28] BiocGenerics_0.56.0
##  [29] RCurl_1.98-1.17
##  [30] yulab.utils_0.2.1
##  [31] rappdirs_0.3.3
##  [32] gdtools_0.4.4
##  [33] IRanges_2.44.0
##  [34] S4Vectors_0.48.0
##  [35] enrichplot_1.30.0
##  [36] ggrepel_0.9.6
##  [37] tidytree_0.4.6
##  [38] ChIPseeker_1.46.0
##  [39] codetools_0.2-20
##  [40] DelayedArray_0.36.0
##  [41] DOSE_4.4.0
##  [42] tidyselect_1.2.1
##  [43] aplot_0.2.9
##  [44] UCSC.utils_1.6.0
##  [45] farver_2.1.2
##  [46] base64enc_0.1-3
##  [47] matrixStats_1.5.0
##  [48] stats4_4.5.1
##  [49] BiocFileCache_3.0.0
##  [50] Seqinfo_1.0.0
##  [51] GenomicAlignments_1.46.0
##  [52] jsonlite_2.0.0
##  [53] systemfonts_1.3.1
##  [54] tools_4.5.1
##  [55] treeio_1.34.0
##  [56] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
##  [57] Rcpp_1.1.0
##  [58] glue_1.8.0
##  [59] SparseArray_1.10.0
##  [60] xfun_0.53
##  [61] qvalue_2.42.0
##  [62] MatrixGenerics_1.22.0
##  [63] GenomeInfoDb_1.46.0
##  [64] dplyr_1.1.4
##  [65] withr_3.0.2
##  [66] BiocManager_1.30.26
##  [67] fastmap_1.2.0
##  [68] boot_1.3-32
##  [69] caTools_1.18.3
##  [70] digest_0.6.37
##  [71] timechange_0.3.0
##  [72] R6_2.6.1
##  [73] mime_0.13
##  [74] gridGraphics_0.5-1
##  [75] seqPattern_1.42.0
##  [76] GO.db_3.22.0
##  [77] gtools_3.9.5
##  [78] dichromat_2.0-0.1
##  [79] RSQLite_2.4.3
##  [80] cigarillo_1.0.0
##  [81] R.methodsS3_1.8.2
##  [82] tidyr_1.3.1
##  [83] generics_0.1.4
##  [84] fontLiberation_0.1.0
##  [85] data.table_1.17.8
##  [86] rtracklayer_1.70.0
##  [87] bsplus_0.1.5
##  [88] httr_1.4.7
##  [89] htmlwidgets_1.6.4
##  [90] S4Arrays_1.10.0
##  [91] downloadthis_0.5.0
##  [92] pkgconfig_2.0.3
##  [93] gtable_0.3.6
##  [94] blob_1.2.4
##  [95] S7_0.2.0
##  [96] impute_1.84.0
##  [97] XVector_0.50.0
##  [98] htmltools_0.5.8.1
##  [99] fontBitstreamVera_0.1.1
## [100] bookdown_0.45
## [101] fgsea_1.36.0
## [102] scales_1.4.0
## [103] Biobase_2.70.0
## [104] png_0.1-8
## [105] ggfun_0.2.0
## [106] knitr_1.50
## [107] tzdb_0.5.0
## [108] reshape2_1.4.4
## [109] rjson_0.2.23
## [110] nlme_3.1-168
## [111] curl_7.0.0
## [112] cachem_1.1.0
## [113] stringr_1.5.2
## [114] BiocVersion_3.22.0
## [115] KernSmooth_2.23-26
## [116] parallel_4.5.1
## [117] AnnotationDbi_1.72.0
## [118] restfulr_0.0.16
## [119] pillar_1.11.1
## [120] grid_4.5.1
## [121] vctrs_0.6.5
## [122] gplots_3.2.0
## [123] dbplyr_2.5.1
## [124] evaluate_1.0.5
## [125] magick_2.9.0
## [126] tinytex_0.57
## [127] readr_2.1.5
## [128] GenomicFeatures_1.62.0
## [129] cli_3.6.5
## [130] compiler_4.5.1
## [131] Rsamtools_2.26.0
## [132] rlang_1.1.6
## [133] crayon_1.5.3
## [134] labeling_0.4.3
## [135] plyr_1.8.9
## [136] fs_1.6.6
## [137] ggiraph_0.9.2
## [138] stringi_1.8.7
## [139] genomation_1.42.0
## [140] viridisLite_0.4.2
## [141] gridBase_0.4-7
## [142] BiocParallel_1.44.0
## [143] Biostrings_2.78.0
## [144] lazyeval_0.2.2
## [145] GOSemSim_2.36.0
## [146] fontquiver_0.2.1
## [147] Matrix_1.7-4
## [148] BSgenome_1.78.0
## [149] hms_1.1.4
## [150] patchwork_1.3.2
## [151] bit64_4.6.0-1
## [152] ggplot2_4.0.0
## [153] KEGGREST_1.50.0
## [154] SummarizedExperiment_1.40.0
## [155] AnnotationHub_4.0.0
## [156] igraph_2.2.1
## [157] memoise_2.0.1
## [158] bslib_0.9.0
## [159] ggtree_4.0.0
## [160] fastmatch_1.1-6
## [161] bit_4.6.0
## [162] ape_5.8-1
```