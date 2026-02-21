# ATACCoGAPS

#### Rossin Erbe

## Introduction

Coordinated Gene Association in Pattern Sets (CoGAPS) is a technique for latent space learning. CoGAPS is a member of the Nonnegative Matrix Factorization (NMF) class of algorithms. NMFs factorize a data matrix into two related matrices containing gene weights, the Amplitude (A) matrix, and sample weights, the Pattern (P) Matrix. Each column of A or row of P defines a feature and together this set of features defines the latent space among features and samples, respectively. In NMF, the values of the elements in the A and P matrices are constrained to be greater than or equal to zero. This constraint simultaneously reflects the non-negative nature of molecular data and enforces the additive nature of the resulting feature dimensions, generating solutions that are biologically intuitive to interpret (Seung and Lee (1999)).

This package extends CoGAPS for usage with scATACseq data, allowing for summarization to genomic peaks or motifs as features for input into CoGAPS. A count matrix - peaks or motifs by cells is used as input, yielding patterns of accessibility that distinguish biological variation between cells.

## Installation

```
if (!require("BiocManager", quietly = TRUE))
install.packages("BiocManager")
BiocManager::install("ATACCoGAPS")
```

## Package Overview

```
library(ATACCoGAPS)
```

To outline the ATACCoGAPS pipeline, we will use as an example data set single-cell ATAC sequencing data containing 10 cell lines, published by Schep et al, 2017. The data was downloaded from GEO accession number GSE99172 and preprocessed using dataSubsetBySparsity() from the ATACCoGAPS package to remove cells and peaks with more than 99% sparsity (more than 99% zeroes). We will use a subset of the data containing 50 random cells from each cell line and the top ~5000 most variable peaks as an example for this vignette.

```
data("subsetSchepData")
data("schepPeaks")
data("schepCellTypes")
```

We use these data to set the hyperparameters of the CoGAPS algorithm. Here we tell CoGAPS to find 7 patterns in 10000 iterations of the algorithm. We use the sparseOptimization method as our data are sparse single-cell data. We run the algorithm distributed across the genome since we have more genomic features than cells (if it was the opposite we would set the distributed pattern to “single-cell”). We then input the peak and cell type information to be returned as part of our result object.

```
params <- CogapsParams(nPatterns=7, nIterations=10000, seed=42, sparseOptimization=TRUE, distributed="genome-wide", geneNames=schepPeaks, sampleNames=as.character(schepCellTypes))

params
```

```
## -- Standard Parameters --
## nPatterns            7
## nIterations          10000
## seed                 42
## sparseOptimization   TRUE
## distributed          genome-wide
##
## -- Sparsity Parameters --
## alpha          0.01
## maxGibbsMass   100
##
## -- Distributed CoGAPS Parameters --
## nSets          4
## cut            7
## minNS          2
## maxNS          6
##
## 5036 gene names provided
## first gene name: chr1-1051395-1051894
##
## 600 sample names provided
## first sample name: Fibroblasts
```

We now call CoGAPS via the R function. CoGAPS is a Bayesian Non-Negative Matrix Factorization algorithm (Fertig et al, 2010). It factorizes count matrices from RNA or epigenetic sequencing data and returns patterns which distinguish both features and samples, allowing for the discovery of regulatory differences between samples. In the case of scATAC-seq our features are usually peaks and our samples are indvidual cells.

```
schepCogapsResult <- CoGAPS(data = subsetSchepData, params = params, nThreads = 1)
```

Without parallelization the above takes a little while to run, so we provide the pre-computed output object

```
data("schepCogapsResult")
```

# Pattern Matrix Visualization

The first quick visualization of CoGAPS results is generally plotting the Pattern Matrix (the output matrix which is patterns x cells). These plots allow us to determine which patterns differentiate which cell types.

We can either plot each pattern indvidually

```
#colors to plot by
col <- viridis::plasma(n=12)

cgapsPlot(cgaps_result = schepCogapsResult, sample.classifier = schepCellTypes, cols = col, ylab = "Pattern Weight")
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

Or all together in a heatmap

```
heatmapPatternMatrix(cgaps_result = schepCogapsResult, sample.classifier = schepCellTypes, cellCols = col, col = viridis::magma(n=9))
```

![](data:image/png;base64...)

We can note which patterns differentiate which cell types (for example that pattern 9 seems to be defining the LCL cells). If any patterns are unclear, such as pattern 5, we can perform a Wilcoxon Rank Sum test to determine which cell types are most significantly associated with the pattern.

```
#get the pattern Matrix
patMatrix <- getSampleFactors(schepCogapsResult)
#perform a pairwise Wilcoxon test
pairwise.wilcox.test(patMatrix[,5], schepCellTypes, p.adjust.method = "BH")
```

```
##
##  Pairwise comparisons using Wilcoxon rank sum test with continuity correction
##
## data:  patMatrix[, 5] and schepCellTypes
##
##                      Fibroblasts LCL 1   LCL 2 Rep1 LCL 2 Rep2 ESCs
## LCL 1                1.9e-13     -       -          -          -
## LCL 2 Rep1           7.9e-09     0.00215 -          -          -
## LCL 2 Rep2           4.8e-09     0.02188 0.73104    -          -
## ESCs                 0.38529     2.1e-11 2.4e-06    1.5e-06    -
## HL60 Leukemia        0.00182     8.6e-09 0.00105    0.00061    0.07705
## K562 Erythroleukemia 1.4e-09     9.7e-16 6.3e-15    7.7e-15    2.5e-09
## LMPP                 6.3e-11     0.00718 0.67835    0.95876    4.1e-08
## Monocyte             1.2e-12     0.21600 0.09527    0.28185    1.1e-09
## AML Patient 070      1.7e-10     0.06924 0.43176    0.74080    1.3e-07
## AML Patient 353      2.2e-11     0.10374 0.20668    0.38529    5.6e-09
## Erythroblast         1.2e-12     0.43285 0.00022    0.00306    1.7e-11
##                      HL60 Leukemia K562 Erythroleukemia LMPP    Monocyte
## LCL 1                -             -                    -       -
## LCL 2 Rep1           -             -                    -       -
## LCL 2 Rep2           -             -                    -       -
## ESCs                 -             -                    -       -
## HL60 Leukemia        -             -                    -       -
## K562 Erythroleukemia 1.7e-12       -                    -       -
## LMPP                 6.0e-05       1.4e-15              -       -
## Monocyte             6.3e-07       9.7e-16              0.22002 -
## AML Patient 070      0.00011       1.4e-15              0.76118 0.38301
## AML Patient 353      3.1e-06       1.8e-15              0.33555 0.80825
## Erythroblast         5.2e-09       1.4e-15              0.00039 0.05713
##                      AML Patient 070 AML Patient 353
## LCL 1                -               -
## LCL 2 Rep1           -               -
## LCL 2 Rep2           -               -
## ESCs                 -               -
## HL60 Leukemia        -               -
## K562 Erythroleukemia -               -
## LMPP                 -               -
## Monocyte             -               -
## AML Patient 070      -               -
## AML Patient 353      0.67361         -
## Erythroblast         0.02682         0.01342
##
## P value adjustment method: BH
```

We see that pattern 5 is most strongly associated with the K562 cells.

If we do not have pre-established cell annotations, we can cluster cells by pattern association.

```
cellClass <- patternMarkerCellClassifier(schepCogapsResult)
cellClasses <- cellClass$cellClassifier

heatmapPatternMatrix(schepCogapsResult, as.factor(cellClasses), col = viridis::magma(n=9))
```

![](data:image/png;base64...)

# Finding Regulatory Differences between Cell Types

Now that we know which patterns distinguish which cell types, we can look at those same patterns in the amplitude matrix (peaks by patterns) to determine which peaks are differentially accessible between the patterns and thus which peaks are differentially accessible between the cell types.

We can use the patternMarker Statistic (Stein-O’Brien et al, 2017) to find which peaks are most differentially accessible. To show the degree of differentiation, we can plot the most pattern differentiating peaks for each pattern from the original data.

```
heatmapPatternMarkers(cgaps_result = schepCogapsResult, atac_data = subsetSchepData, celltypes = schepCellTypes, numregions = 5, colColors = col, col = viridis::plasma(n = 2))
```

![](data:image/png;base64...)

# Pathway Based Analysis

To make use of these pttern marker peaks, one option is to try to find genes that fall within these peaks and determine whether the accessibility of certain groups of genes suggests differential pathway activation.

```
data("schepGranges")

#loading TxDb of human genes
library(Homo.sapiens)

#find genes known to fall within thresholded patternMarker peaks for each pattern
genes <- genePatternMatch(cogapsResult = schepCogapsResult, generanges = schepGranges, genome = Homo.sapiens)

#download hallmark pathways using msigdbr
library(dplyr)
```

```
pathways <- msigdbr::msigdbr(species = "Homo sapiens", category =
"H") %>% dplyr::select(gs_name, gene_symbol) %>% as.data.frame()

#match these pattern Gene sets to hallmark pathways, using an adjusted p-value threshold of 0.001.
matchedPathways <- pathwayMatch(gene_list = genes, pathways = pathways, p_threshold = 0.001)

lapply(matchedPathways, function(x) {x[4]})
```

```
## [[1]]
## [[1]]$summaryTable
## NULL
##
##
## [[2]]
## [[2]]$summaryTable
##                   pathway       PValue
## 2 HALLMARK_MYC_TARGETS_V1 3.906362e-08
## 1 HALLMARK_G2M_CHECKPOINT 3.582665e-05
##
##
## [[3]]
## [[3]]$summaryTable
##                     pathway       PValue
## 1      HALLMARK_E2F_TARGETS 7.899126e-07
## 2 HALLMARK_MTORC1_SIGNALING 7.899126e-07
##
##
## [[4]]
## [[4]]$summaryTable
##                            pathway       PValue
## 4        HALLMARK_MTORC1_SIGNALING 8.302835e-10
## 5          HALLMARK_MYC_TARGETS_V1 8.013316e-09
## 1             HALLMARK_E2F_TARGETS 2.386788e-08
## 6 HALLMARK_PI3K_AKT_MTOR_SIGNALING 1.646846e-06
## 3         HALLMARK_MITOTIC_SPINDLE 7.983985e-06
## 2          HALLMARK_G2M_CHECKPOINT 9.009109e-06
##
##
## [[5]]
## [[5]]$summaryTable
## NULL
##
##
## [[6]]
## [[6]]$summaryTable
## NULL
##
##
## [[7]]
## [[7]]$summaryTable
## NULL
##
##
## [[8]]
## [[8]]$summaryTable
##                            pathway       PValue
## 3 HALLMARK_TNFA_SIGNALING_VIA_NFKB 8.651397e-07
## 2             HALLMARK_E2F_TARGETS 3.035592e-06
## 1       HALLMARK_ANDROGEN_RESPONSE 6.473813e-06
##
##
## [[9]]
## [[9]]$summaryTable
## NULL
```

Several patterns do not return Hallmark pathways at this level of significance, but those that do seem logical in the cell types those patterns differentiate.

# Motif/Transcription Factor Based Analysis

The other way we can use pattern marker peak information is to match to DNA motifs and known Transcription Factor binding at those motifs.

```
motifResults <- simpleMotifTFMatch(cogapsResult = schepCogapsResult, generanges = schepGranges, organism = "Homo sapiens", genome = "hg19", motifsPerRegion = 1)
```

```
##
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:base':
##
##     strsplit
```

We can get a summary of TF binding, generally having more confidence in those TFs that have higher numbers of motifs at which the same TF could bind.

```
motifResults$tfMatchSummary[[1]]
```

```
##        ZNF263          EGR1           SP2         KLF16          NRF1
##            11             5             5             4             3
##         CEBPA          CTCF    JUN(var.2)          NFYA         NHLH1
##             2             2             2             2             2
##           SP1          SPI1          SPIC        ZNF740          ATF4
##             2             2             2             2             1
##     BATF::JUN          E2F6          EGR2          ELK1         FOSL1
##             1             1             1             1             1
##   GATA1::TAL1          HSF4   JDP2(var.2)         KLF13         KLF14
##             1             1             1             1             1
##          KLF5          LEF1     MAF::NFE2          MAFG      MAX::MYC
##             1             1             1             1             1
##         MEIS2        MLXIPL           MSC          NFE2       ONECUT3
##             1             1             1             1             1
##          PBX1         PLAG1        POU3F3   RARA(var.2)         RREB1
##             1             1             1             1             1
##           SP4         SPDEF        SREBF1  STAT1::STAT2 TFAP2A(var.2)
##             1             1             1             1             1
## TFAP2B(var.3)          TP53          ZIC4
##             1             1             1
```

We can also examine the accessibility of the TF itself in a cell type of interest in order to gather information on whether the TF is expressed to bind at accessible sites. We’ll test the accessibility of EGR1 in monocytes as an example.

```
#get peaks overlapping with the gene
EGR1peaks <- geneAccessibility("EGR1", schepGranges, subsetSchepData, Homo.sapiens)
```

```
##   403 genes were dropped because they have exons located on both strands
##   of the same reference sequence or on more than one reference sequence,
##   so cannot be represented by a single genomic range.
##   Use 'single.strand.genes.only=FALSE' to get all the genes in a
##   GRangesList object, or use suppressMessages() to suppress this message.
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
##   403 genes were dropped because they have exons located on both strands
##   of the same reference sequence or on more than one reference sequence,
##   so cannot be represented by a single genomic range.
##   Use 'single.strand.genes.only=FALSE' to get all the genes in a
##   GRangesList object, or use suppressMessages() to suppress this message.
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
#make binary accessibility matrix
binaryMatrix <- (subsetSchepData > 0) + 0

#find accessibility of those peaks relative to others among monocyte cells
foldAccessibility(peaksAccessibility = EGR1peaks$EGR1, cellTypeList = schepCellTypes, cellType = "Monocyte", binaryMatrix = binaryMatrix)
```

```
## [1] 1.429779
```

EGR1 is 1.42 times more accessible than average in Monocytes

## Session Info

```
## R version 4.2.1 (2022-06-23)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.5 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.16-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.16-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] BSgenome.Hsapiens.UCSC.hg19_1.4.3
##  [2] BSgenome_1.66.0
##  [3] rtracklayer_1.58.0
##  [4] Biostrings_2.66.0
##  [5] XVector_0.38.0
##  [6] dplyr_1.0.10
##  [7] Homo.sapiens_1.3.1
##  [8] TxDb.Hsapiens.UCSC.hg19.knownGene_3.2.2
##  [9] org.Hs.eg.db_3.16.0
## [10] GO.db_3.16.0
## [11] OrganismDbi_1.40.0
## [12] GenomicFeatures_1.50.0
## [13] GenomicRanges_1.50.0
## [14] GenomeInfoDb_1.34.0
## [15] AnnotationDbi_1.60.0
## [16] IRanges_2.32.0
## [17] S4Vectors_0.36.0
## [18] Biobase_2.58.0
## [19] BiocGenerics_0.44.0
## [20] ATACCoGAPS_1.0.0
## [21] CoGAPS_3.18.0
##
## loaded via a namespace (and not attached):
##   [1] BSgenome.Mmusculus.UCSC.mm10_1.4.3
##   [2] utf8_1.2.2
##   [3] R.utils_2.12.1
##   [4] tidyselect_1.2.0
##   [5] poweRlaw_0.70.6
##   [6] RSQLite_2.2.18
##   [7] htmlwidgets_1.5.4
##   [8] grid_4.2.1
##   [9] BiocParallel_1.32.0
##  [10] munsell_0.5.0
##  [11] codetools_0.2-18
##  [12] DT_0.26
##  [13] miniUI_0.1.1.1
##  [14] withr_2.5.0
##  [15] colorspace_2.0-3
##  [16] chromVAR_1.20.0
##  [17] filelock_1.0.2
##  [18] highr_0.9
##  [19] knitr_1.40
##  [20] SingleCellExperiment_1.20.0
##  [21] MatrixGenerics_1.10.0
##  [22] GenomeInfoDbData_1.2.9
##  [23] bit64_4.0.5
##  [24] rhdf5_2.42.0
##  [25] vctrs_0.5.0
##  [26] generics_0.1.3
##  [27] xfun_0.34
##  [28] BiocFileCache_2.6.0
##  [29] R6_2.5.1
##  [30] msigdbr_7.5.1
##  [31] bitops_1.0-7
##  [32] rhdf5filters_1.10.0
##  [33] cachem_1.0.6
##  [34] DelayedArray_0.24.0
##  [35] assertthat_0.2.1
##  [36] promises_1.2.0.1
##  [37] BiocIO_1.8.0
##  [38] scales_1.2.1
##  [39] googlesheets4_1.0.1
##  [40] gtable_0.3.1
##  [41] org.Mm.eg.db_3.16.0
##  [42] seqLogo_1.64.0
##  [43] rlang_1.0.6
##  [44] lazyeval_0.2.2
##  [45] gargle_1.2.1
##  [46] broom_1.0.1
##  [47] BiocManager_1.30.19
##  [48] yaml_2.3.6
##  [49] reshape2_1.4.4
##  [50] modelr_0.1.9
##  [51] backports_1.4.1
##  [52] httpuv_1.6.6
##  [53] RBGL_1.74.0
##  [54] tools_4.2.1
##  [55] ggplot2_3.3.6
##  [56] ellipsis_0.3.2
##  [57] gplots_3.1.3
##  [58] jquerylib_0.1.4
##  [59] RColorBrewer_1.1-3
##  [60] Rcpp_1.0.9
##  [61] plyr_1.8.7
##  [62] progress_1.2.2
##  [63] zlibbioc_1.44.0
##  [64] purrr_0.3.5
##  [65] RCurl_1.98-1.9
##  [66] prettyunits_1.1.1
##  [67] viridis_0.6.2
##  [68] SummarizedExperiment_1.28.0
##  [69] haven_2.5.1
##  [70] cluster_2.1.4
##  [71] fs_1.5.2
##  [72] motifmatchr_1.20.0
##  [73] magrittr_2.0.3
##  [74] data.table_1.14.4
##  [75] reprex_2.0.2
##  [76] googledrive_2.0.0
##  [77] matrixStats_0.62.0
##  [78] hms_1.1.2
##  [79] mime_0.12
##  [80] evaluate_0.17
##  [81] xtable_1.8-4
##  [82] XML_3.99-0.12
##  [83] readxl_1.4.1
##  [84] gridExtra_2.3
##  [85] compiler_4.2.1
##  [86] biomaRt_2.54.0
##  [87] tibble_3.1.8
##  [88] KernSmooth_2.23-20
##  [89] crayon_1.5.2
##  [90] R.oo_1.25.0
##  [91] htmltools_0.5.3
##  [92] later_1.3.0
##  [93] tzdb_0.3.0
##  [94] TFBSTools_1.36.0
##  [95] tidyr_1.2.1
##  [96] lubridate_1.8.0
##  [97] DBI_1.1.3
##  [98] dbplyr_2.2.1
##  [99] rappdirs_0.3.3
## [100] babelgene_22.9
## [101] Matrix_1.5-1
## [102] readr_2.1.3
## [103] cli_3.4.1
## [104] JASPAR2016_1.25.0
## [105] R.methodsS3_1.8.2
## [106] parallel_4.2.1
## [107] forcats_0.5.2
## [108] pkgconfig_2.0.3
## [109] GenomicAlignments_1.34.0
## [110] TFMPvalue_0.0.9
## [111] Mus.musculus_1.3.1
## [112] plotly_4.10.0
## [113] xml2_1.3.3
## [114] annotate_1.76.0
## [115] bslib_0.4.0
## [116] DirichletMultinomial_1.40.0
## [117] GeneOverlap_1.34.0
## [118] rvest_1.0.3
## [119] stringr_1.4.1
## [120] digest_0.6.30
## [121] pracma_2.4.2
## [122] CNEr_1.34.0
## [123] graph_1.76.0
## [124] rmarkdown_2.17
## [125] cellranger_1.1.0
## [126] restfulr_0.0.15
## [127] curl_4.3.3
## [128] shiny_1.7.3
## [129] Rsamtools_2.14.0
## [130] gtools_3.9.3
## [131] rjson_0.2.21
## [132] lifecycle_1.0.3
## [133] jsonlite_1.8.3
## [134] Rhdf5lib_1.20.0
## [135] viridisLite_0.4.1
## [136] fansi_1.0.3
## [137] pillar_1.8.1
## [138] lattice_0.20-45
## [139] KEGGREST_1.38.0
## [140] fastmap_1.1.0
## [141] httr_1.4.4
## [142] glue_1.6.2
## [143] png_0.1-7
## [144] bit_4.0.4
## [145] stringi_1.7.8
## [146] sass_0.4.2
## [147] blob_1.2.3
## [148] TxDb.Mmusculus.UCSC.mm10.knownGene_3.10.0
## [149] caTools_1.18.2
## [150] memoise_2.0.1
## [151] tidyverse_1.3.2
```