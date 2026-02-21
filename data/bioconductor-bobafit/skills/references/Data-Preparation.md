# Data preparation using TCGA-BRCA database

Gaia Mazzocchetti1\*

1University of Bologna - DIMES

\*bioinformatics.seragnoli@gmail.com

#### 2025-10-29

#### Abstract

Best practise to download and prepare TCGA-BRCA dataset for BOBaFIT’s analysis

#### Package

BOBaFIT 1.14.0

# Contents

* [1 Introduction](#introduction)
* [2 Download from TCGA](#download-from-tcga)
* [3 Columns preparation](#columns-preparation)
* [4 Assign the chromosome arm with Popeye](#assign-the-chromosome-arm-with-popeye)
* [5 Calculation of the Copy Number](#calculation-of-the-copy-number)
* [Session info](#session-info)

# 1 Introduction

The data preparation is an important step before the BOBaFIT analysis. In this vignete we will explain how to download the TCGA-BRCA dataset(Tomczak, Czerwińska, and Wiznerowicz [2015](#ref-Tomczak2015)) the package TCGAbiolink (Colaprico et al. [2015](#ref-Colaprico2016)) and how to add information like chromosomal arm and CN value of each segments, which operating principle of the package. Further, here we show the column names of the input file for all the BOBaFIT function.

# 2 Download from TCGA

To download the TCGCA-BRCA(Tomczak, Czerwińska, and Wiznerowicz [2015](#ref-Tomczak2015)), we used the R package TCGAbiolinks (Colaprico et al. [2015](#ref-Colaprico2016))and we construct the query. The query includs Breast Cancer samples analyzed by SNParray method (GenomeWide\_SNP6), obtaining their Copy Number (CN) profile.

```
BiocManager::install("TCGAbiolinks")
library(TCGAbiolinks)

query <- GDCquery(project = "TCGA-BRCA",
                  data.category = "Copy Number Variation",
                  data.type = "Copy Number Segment",
                  sample.type = "Primary Tumor"
                  )

#Selecting first 100 samples using the TCGA barcode
subset <- query[[1]][[1]]
barcode <- subset$cases[1:100]

TCGA_BRCA_CN_segments <- GDCquery(project = "TCGA-BRCA",
                  data.category = "Copy Number Variation",
                  data.type = "Copy Number Segment",
                  sample.type = "Primary Tumor",
                  barcode = barcode
)

GDCdownload(TCGA_BRCA_CN_segments, method = "api", files.per.chunk = 50)

#prepare a data.frame where working
data <- GDCprepare(TCGA_BRCA_CN_segments, save = TRUE,
           save.filename= "TCGA_BRCA_CN_segments.txt")
```

In the last step, a dataframe with the segments of all samples is prepared. However some information are missing, so the dataset is not ready as BOBaFIT input.

# 3 Columns preparation

Further, here we show the **column names** of the input file for all the BOBaFIT function.

```
names(data)
BOBaFIT_names <- c("ID", "chr", "start", "end", "Num_Probes",
           "Segment_Mean","Sample")
names(data)<- BOBaFIT_names
names(data)
```

# 4 Assign the chromosome arm with Popeye

The arm column is an very important information that support the diploid region check of`DRrefit` and the chromosome list computation of `ComputeNormalChromosome`. As it is lacking in the TCGA-BRCAdataset, the function `Popeye`has been specially designed to calculate which chromosomal arm the segment belongs to. Thanks to this algorithm, not only the TCGA-BRCA dataset, but any database you want to analyze can be analyzed by any function of BOBaFIT.

```
library(BOBaFIT)
segments <- Popeye(data)
```

| chr | start | end | width | strand | ID | Num\_Probes | Segment\_Mean | Sample | arm | chrarm |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 62920 | 21996664 | 21933745 | \* | 01428281-1653-4839-b5cf-167bc62eb147 | 12088 | -0.4756 | TCGA-BH-A18R-01A-11D-A12A-01 | p | 1p |
| 1 | 22001786 | 22002025 | 240 | \* | 01428281-1653-4839-b5cf-167bc62eb147 | 2 | -7.4436 | TCGA-BH-A18R-01A-11D-A12A-01 | p | 1p |
| 1 | 22004046 | 22010750 | 6705 | \* | 01428281-1653-4839-b5cf-167bc62eb147 | 2 | -2.1226 | TCGA-BH-A18R-01A-11D-A12A-01 | p | 1p |
| 1 | 22011632 | 25256850 | 3245219 | \* | 01428281-1653-4839-b5cf-167bc62eb147 | 1914 | -0.4808 | TCGA-BH-A18R-01A-11D-A12A-01 | p | 1p |
| 1 | 25266637 | 25320198 | 53562 | \* | 01428281-1653-4839-b5cf-167bc62eb147 | 22 | -2.1144 | TCGA-BH-A18R-01A-11D-A12A-01 | p | 1p |
| 1 | 25320253 | 30316360 | 4996108 | \* | 01428281-1653-4839-b5cf-167bc62eb147 | 2434 | -0.4905 | TCGA-BH-A18R-01A-11D-A12A-01 | p | 1p |

# 5 Calculation of the Copy Number

The last step is the computation of the copy number value from the “`Segment_Mean`” column (logR), with the following formula. At this point the data is ready to be analyzed by the whole package.

```
#When data coming from SNParray platform are used, the user have to apply the
#compression factor in the formula (0.55). In case of WGS/WES data, the
#correction factor is equal to 1.
compression_factor <- 0.55
segments$CN <- 2^(segments$Segment_Mean/compression_factor + 1)
```

| chr | start | end | width | strand | ID | Num\_Probes | Segment\_Mean | Sample | arm | chrarm | CN |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 62920 | 21996664 | 21933745 | \* | 01428281-1653-4839-b5cf-167bc62eb147 | 12088 | -0.4756 | TCGA-BH-A18R-01A-11D-A12A-01 | p | 1p | 1.0983004 |
| 1 | 22001786 | 22002025 | 240 | \* | 01428281-1653-4839-b5cf-167bc62eb147 | 2 | -7.4436 | TCGA-BH-A18R-01A-11D-A12A-01 | p | 1p | 0.0001686 |
| 1 | 22004046 | 22010750 | 6705 | \* | 01428281-1653-4839-b5cf-167bc62eb147 | 2 | -2.1226 | TCGA-BH-A18R-01A-11D-A12A-01 | p | 1p | 0.1378076 |
| 1 | 22011632 | 25256850 | 3245219 | \* | 01428281-1653-4839-b5cf-167bc62eb147 | 1914 | -0.4808 | TCGA-BH-A18R-01A-11D-A12A-01 | p | 1p | 1.0911264 |
| 1 | 25266637 | 25320198 | 53562 | \* | 01428281-1653-4839-b5cf-167bc62eb147 | 22 | -2.1144 | TCGA-BH-A18R-01A-11D-A12A-01 | p | 1p | 0.1392391 |
| 1 | 25320253 | 30316360 | 4996108 | \* | 01428281-1653-4839-b5cf-167bc62eb147 | 2434 | -0.4905 | TCGA-BH-A18R-01A-11D-A12A-01 | p | 1p | 1.0778690 |

# Session info

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
## [1] dplyr_1.1.4      BOBaFIT_1.14.0   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   bitops_1.0-9
##   [3] RBGL_1.86.0                 gridExtra_2.3
##   [5] rlang_1.1.6                 magrittr_2.0.4
##   [7] biovizBase_1.58.0           matrixStats_1.5.0
##   [9] compiler_4.5.1              RSQLite_2.4.3
##  [11] GenomicFeatures_1.62.0      png_0.1-8
##  [13] vctrs_0.6.5                 reshape2_1.4.4
##  [15] ProtGenerics_1.42.0         stringr_1.5.2
##  [17] pkgconfig_2.0.3             crayon_1.5.3
##  [19] fastmap_1.2.0               magick_2.9.0
##  [21] backports_1.5.0             XVector_0.50.0
##  [23] labeling_0.4.3              Rsamtools_2.26.0
##  [25] rmarkdown_2.30              graph_1.88.0
##  [27] UCSC.utils_1.6.0            tinytex_0.57
##  [29] purrr_1.1.0                 bit_4.6.0
##  [31] xfun_0.53                   cachem_1.1.0
##  [33] cigarillo_1.0.0             GenomeInfoDb_1.46.0
##  [35] jsonlite_2.0.0              blob_1.2.4
##  [37] DelayedArray_0.36.0         tweenr_2.0.3
##  [39] BiocParallel_1.44.0         parallel_4.5.1
##  [41] cluster_2.1.8.1             plyranges_1.30.0
##  [43] VariantAnnotation_1.56.0    R6_2.6.1
##  [45] bslib_0.9.0                 stringi_1.8.7
##  [47] RColorBrewer_1.1-3          rtracklayer_1.70.0
##  [49] rpart_4.1.24                GenomicRanges_1.62.0
##  [51] jquerylib_0.1.4             Rcpp_1.1.0
##  [53] Seqinfo_1.0.0               bookdown_0.45
##  [55] SummarizedExperiment_1.40.0 knitr_1.50
##  [57] base64enc_0.1-3             IRanges_2.44.0
##  [59] Matrix_1.7-4                nnet_7.3-20
##  [61] tidyselect_1.2.1            rstudioapi_0.17.1
##  [63] dichromat_2.0-0.1           abind_1.4-8
##  [65] yaml_2.3.10                 codetools_0.2-20
##  [67] curl_7.0.0                  lattice_0.22-7
##  [69] tibble_3.3.0                plyr_1.8.9
##  [71] withr_3.0.2                 Biobase_2.70.0
##  [73] KEGGREST_1.50.0             S7_0.2.0
##  [75] evaluate_1.0.5              foreign_0.8-90
##  [77] polyclip_1.10-7             Biostrings_2.78.0
##  [79] pillar_1.11.1               BiocManager_1.30.26
##  [81] MatrixGenerics_1.22.0       checkmate_2.3.3
##  [83] stats4_4.5.1                OrganismDbi_1.52.0
##  [85] generics_0.1.4              RCurl_1.98-1.17
##  [87] ensembldb_2.34.0            S4Vectors_0.48.0
##  [89] ggplot2_4.0.0               scales_1.4.0
##  [91] ggbio_1.58.0                glue_1.8.0
##  [93] Hmisc_5.2-4                 lazyeval_0.2.2
##  [95] tools_4.5.1                 BiocIO_1.20.0
##  [97] data.table_1.17.8           BSgenome_1.78.0
##  [99] GenomicAlignments_1.46.0    XML_3.99-0.19
## [101] grid_4.5.1                  tidyr_1.3.1
## [103] AnnotationDbi_1.72.0        colorspace_2.1-2
## [105] ggforce_0.5.0               restfulr_0.0.16
## [107] htmlTable_2.4.3             Formula_1.2-5
## [109] cli_3.6.5                   NbClust_3.0.1
## [111] S4Arrays_1.10.0             AnnotationFilter_1.34.0
## [113] gtable_0.3.6                sass_0.4.10
## [115] digest_0.6.37               BiocGenerics_0.56.0
## [117] SparseArray_1.10.0          rjson_0.2.23
## [119] htmlwidgets_1.6.4           farver_2.1.2
## [121] memoise_2.0.1               htmltools_0.5.8.1
## [123] lifecycle_1.0.4             httr_1.4.7
## [125] MASS_7.3-65                 bit64_4.6.0-1
```

Colaprico, Antonio, Tiago C. Silva, Catharina Olsen, Luciano Garofano, Claudia Cava, Davide Garolini, Thais S. Sabedot, et al. 2015. “TCGAbiolinks: An R/Bioconductor Package for Integrative Analysis of Tcga Data.” *Nucleic Acids Research* 44 (8): e71–e71. <https://doi.org/10.1093/nar/gkv1507>.

Tomczak, Katarzyna, Patrycja Czerwińska, and Maciej Wiznerowicz. 2015. “Review the Cancer Genome Atlas (Tcga): An Immeasurable Source of Knowledge.” *Współczesna Onkologia* 1A: 68–77. <https://doi.org/10.5114/wo.2014.47136>.