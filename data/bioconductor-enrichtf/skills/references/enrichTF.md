# enrichTF-Introduction

#### Zheng Wei, Shining Ma, Duren Zhana

#### 2019-05-02

# 1 Introduction

As transcription factors (TFs) play a crucial role in regulating the transcription process through binding on the genome alone or in a combinatorial manner, TF enrichment analysis is an efficient and important procedure to locate the candidate functional TFs from a set of experimentally defined regulatory regions. While it is commonly accepted that structurally related TFs may have similar binding preference to sequences (i.e. motifs) and one TF may have multiple motifs, TF enrichment analysis is much more challenging than motif enrichment analysis. Here we present a R package for TF enrichment analysis which combine motif enrichment with the PECA model.

# 2 Quick Start

## 2.1 Download and Installation

The package enrichTF is part of Bioconductor project starting from Bioc 3.9 built on R 3.6. To install the latest version of enrichTF, please check your current Bioconductor version and R version first. The latest version of R is recommended, and then you can download and install enrichTF and all its dependencies as follows:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("enrichTF")
```

## 2.2 Loading

Similar with other R packages, please load enrichTF each time before using the package.

```
library(enrichTF)
```

## 2.3 Running with the default configuration

It is quite convenient to run the default pipeline.

Users only need to provide a region list in BED format which contains 3 columns (chr, start, end). It could be the peak calling result of sequencing data like ATAC-seq etc.

All required data and software will be installed automatically.

```
# Provide your region list in BED format with 3 columns.
foregroundBedPath <- system.file(package = "enrichTF", "extdata","testregion.bed")
# Call the whole pipeline
PECA_TF_enrich(inputForegroundBed = foregroundBedPath, genome = "testgenome") # change"testgenome" to one of "hg19", "hg38", "mm9", 'mm10' ! "testgenome" is only a test example.
```

```
## Configure bsgenome ...
```

```
## Configure bsgenome finished
```

```
## Configure motifpwm ...
```

```
## Configure motifpwm finished
```

```
## Configure motifPWMOBJ ...
```

```
## Configure motifPWMOBJ finished
```

```
## Configure RE_gene_corr ...
```

```
## Configure RE_gene_corr finished
```

```
## Configure Enhancer_RE_gene_corr ...
```

```
## Configure Enhancer_RE_gene_corr finished
```

```
## Configure MotifTFTable ...
```

```
## Configure MotifTFTable finished
```

```
## Configure MotifWeights ...
```

```
## Configure MotifWeights finished
```

```
## Configure TFgeneRelMtx ...
```

```
## Configure TFgeneRelMtx finished
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:parallel':
##
##     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
##     clusterExport, clusterMap, parApply, parCapply, parLapply,
##     parLapplyLB, parRapply, parSapply, parSapplyLB
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, intersect,
##     is.unsorted, lapply, mapply, match, mget, order, paste, pmax,
##     pmax.int, pmin, pmin.int, rank, rbind, rownames, sapply,
##     setdiff, sort, table, tapply, union, unique, unsplit, which,
##     which.max, which.min
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:base':
##
##     expand.grid
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

```
## >>>>>>========================================
```

```
## 2019-05-02 23:34:58
```

```
## start processing data: GenBackground
```

```
## 2019-05-02 23:34:59
```

```
## processing finished
```

```
## ========================================<<<<<<
```

```
##
```

```
## >>>>>>========================================
```

```
## 2019-05-02 23:34:59
```

```
## start processing data: RegionConnectTargetGene
```

```
## 2019-05-02 23:35:00
```

```
## processing finished
```

```
## ========================================<<<<<<
```

```
##
```

```
## >>>>>>========================================
```

```
## 2019-05-02 23:35:00
```

```
## start processing data: FindMotifsInRegions
```

```
## 2019-05-02 23:35:19
```

```
## processing finished
```

```
## ========================================<<<<<<
```

```
##
```

```
## >>>>>>========================================
```

```
## 2019-05-02 23:35:19
```

```
## start processing data: TFsEnrichInRegions
```

```
## 2019-05-02 23:35:35
```

```
## processing finished
```

```
## ========================================<<<<<<
```

```
##
```

# 3 How TF Enrichment Works

## 3.1 Basic Concept for Relations

In this work, we define four kinds of relations which will be introduced in detail. And we will show how to test on enriched TFs rather than enriched motifs.

### 3.1.1 Region-gene Relation Table

When users input a region list in BED format, the relations between regions and one gene can be obtained from two ways:

1. The regions which are overlapped with the functional region of this gene. This type of relation can be obtained from gene reference data.
2. The regions are enhancers or other distal regulatory elements of this gene. This type of relation can be derived from 3D genome sequencing experiments such as Hi-C and HiChIP.

As we have already integrated and organized the potential relations between regions and genes from both gene reference and experiment profiles, users can use this source to obtain region-gene relations for their input region list quite easily.

Moreover, users can also customize potential relations from their own work.

### 3.1.2 Gene-TF Relation Matrix

The correlation scores between genes and TFs come from our previous approach named PECA. These scores are scaled in the range [-1,1]. Users can also customize this relation matrix based on their own experiment data.

### 3.1.3 TF-motif Relation Table

As we know, one TF may relate to multiple motifs. Here, we manually annotated more than 700 motifs with their corresponding TFs.

### 3.1.4 Motif-region Relation Table

We scan all annotated motifs on each input region to check if there are some motifs located in this region. Then, the motif-region relation table can be generated.

## 3.2 Enrichment Test

Based on the foreground region list from users, this package can randomly sample the same number of regions from genome as background.

### 3.2.1 Enrichment t-test

Foreground and background region lists can both be connected with genes in Region-gene Relation Table, so both of them will get a gene list. We name them as the foreground gene list and background gene list, respectively.

For each TF, we will perform t-test and obtain p-values for TF-Gene scores of foreground vs those of background. These scores come from Gene-TF Relation Matrix.

### 3.2.2 Enrichment Fisher’s exact test without threshold

Each TF may be correlated with multiple motifs. For each motif, this package will do the following Fisher’s exact test to test if one motif is enriched in foreground regions.

|  | # with TF’s motif | # without TF’s motif |
| --- | --- | --- |
| # Foreground regions |  |  |
| # Background regions |  |  |

Finally, the package will select the motif with the most significant p-value to represent this TF and then compute p-values for all of the TFs.

### 3.2.3 Enrichment Fisher’s exact test with threshold

Similar to previous section, the package will perform Fisher’s exact test with TF-Gene relation matrix. Different thresholds ([-1,1] with interval 0.1) for TF-Gene relation scores are used to filter the connected genes with foreground and background. In this way, we select the most significant p-value to represent this TF and calculate the p-values for all of TFs.

### 3.2.4 FDR

Finally, false discover rate correction is applied on the results of Fisher’s exact test with threshold. We rank all of the TFs based on their enrichment significance.

# 4 Customized Workflow

## 4.1 Prepare inputs

The function of `genBackground` is to generate random background regions based on the input regions and to set the length of input sequence regions. We try to select background sequence regions that match the GC-content distribution of the input sequence regions. The default length and number of background regions are 1000 and 10,000, respectively. The length of sequence regions used for motif finding is important. Here, we set 1000 as default value, which means for each region, we get sequences from -500 to +500 relative from center. For example,

```
setGenome("testgenome")
```

```
## Configure bsgenome ...
```

```
## Configure bsgenome finished
```

```
## Configure motifpwm ...
```

```
## Configure motifpwm finished
```

```
## Configure motifPWMOBJ ...
```

```
## Configure motifPWMOBJ finished
```

```
## Configure RE_gene_corr ...
```

```
## Configure RE_gene_corr finished
```

```
## Configure Enhancer_RE_gene_corr ...
```

```
## Configure Enhancer_RE_gene_corr finished
```

```
## Configure MotifTFTable ...
```

```
## Configure MotifTFTable finished
```

```
## Configure MotifWeights ...
```

```
## Configure MotifWeights finished
```

```
## Configure TFgeneRelMtx ...
```

```
## Configure TFgeneRelMtx finished
```

```
foregroundBedPath <- system.file(package = "enrichTF", "extdata","testregion.bed")
gen <- genBackground(inputForegroundBed = foregroundBedPath)
```

```
## >>>>>>========================================
```

```
## The step:`GenBackground` was finished. Nothing to do.
```

```
## If you need to redo,please call 'clearStepCache(YourObject)'
```

```
## ========================================<<<<<<
```

```
##
```

## 4.2 Motifscan

The function of `regionConnectTargetGene` is to connect foreground and background regions to their target genes, which are predicted from PECA model.

For example,

```
conTG <- enrichRegionConnectTargetGene(gen)
```

```
## >>>>>>========================================
```

```
## The step:`RegionConnectTargetGene` was finished. Nothing to do.
```

```
## If you need to redo,please call 'clearStepCache(YourObject)'
```

```
## ========================================<<<<<<
```

```
##
```

## 4.3 Connect regions with target genes

The function `MotifsInRegions` is to scan for motif occurrences using the prepared PWMs and obtain the promising candidate motifs in these regions.

For example,

```
findMotif <- enrichFindMotifsInRegions(gen,motifRc="integrate")
```

```
## >>>>>>========================================
```

```
## The step:`FindMotifsInRegions` was finished. Nothing to do.
```

```
## If you need to redo,please call 'clearStepCache(YourObject)'
```

```
## ========================================<<<<<<
```

```
##
```

## 4.4 TF enrichment test

The function of `TFsEnrichInRegions` is to test whether each TF is enriched on input regions. For example,

```
result <- enrichTFsEnrichInRegions(gen)
```

```
## >>>>>>========================================
```

```
## The step:`TFsEnrichInRegions` was finished. Nothing to do.
```

```
## If you need to redo,please call 'clearStepCache(YourObject)'
```

```
## ========================================<<<<<<
```

```
##
```

## 4.5 Building a pipeline

Users can build a pipeline easily based on pipeFrame (pipeline framework)

```
library(magrittr)
setGenome("testgenome")
```

```
## Configure bsgenome ...
```

```
## Configure bsgenome finished
```

```
## Configure motifpwm ...
```

```
## Configure motifpwm finished
```

```
## Configure motifPWMOBJ ...
```

```
## Configure motifPWMOBJ finished
```

```
## Configure RE_gene_corr ...
```

```
## Configure RE_gene_corr finished
```

```
## Configure Enhancer_RE_gene_corr ...
```

```
## Configure Enhancer_RE_gene_corr finished
```

```
## Configure MotifTFTable ...
```

```
## Configure MotifTFTable finished
```

```
## Configure MotifWeights ...
```

```
## Configure MotifWeights finished
```

```
## Configure TFgeneRelMtx ...
```

```
## Configure TFgeneRelMtx finished
```

```
foregroundBedPath <- system.file(package = "enrichTF", "extdata","testregion.bed")
result <- genBackground(inputForegroundBed = foregroundBedPath) %>%
enrichRegionConnectTargetGene%>%
enrichFindMotifsInRegions(motifRc="integrate") %>%
enrichTFsEnrichInRegions
```

```
## >>>>>>========================================
```

```
## The step:`GenBackground` was finished. Nothing to do.
```

```
## If you need to redo,please call 'clearStepCache(YourObject)'
```

```
## ========================================<<<<<<
```

```
##
```

```
## >>>>>>========================================
```

```
## The step:`RegionConnectTargetGene` was finished. Nothing to do.
```

```
## If you need to redo,please call 'clearStepCache(YourObject)'
```

```
## ========================================<<<<<<
```

```
##
```

```
## >>>>>>========================================
```

```
## The step:`FindMotifsInRegions` was finished. Nothing to do.
```

```
## If you need to redo,please call 'clearStepCache(YourObject)'
```

```
## ========================================<<<<<<
```

```
##
```

```
## >>>>>>========================================
```

```
## The step:`TFsEnrichInRegions` was finished. Nothing to do.
```

```
## If you need to redo,please call 'clearStepCache(YourObject)'
```

```
## ========================================<<<<<<
```

```
##
```

## 4.6 Result

Here we show an example result when applying this package on our own data.

```
examplefile  <- system.file(package = "enrichTF", "extdata","result.example.txt")
read.table(examplefile, sep='\t', header = TRUE)%>%
  knitr::kable()
```

| TF | Motif\_enrichment | Targt\_gene\_enrichment | P\_value | FDR |
| --- | --- | --- | --- | --- |
| MITF | 0.0000000 | 0.0383390 | 0e+00 | 0.00e+00 |
| TFEC | 0.0000000 | 0.4857386 | 0e+00 | 0.00e+00 |
| MLX | 0.0000000 | 0.8147766 | 0e+00 | 0.00e+00 |
| TFEB | 0.0000000 | 0.5303603 | 0e+00 | 0.00e+00 |
| TFE3 | 0.0000000 | 0.4067377 | 0e+00 | 0.00e+00 |
| MZF1 | 0.0000000 | 0.0532782 | 0e+00 | 5.00e-07 |
| USF2 | 0.0000000 | 0.5766573 | 0e+00 | 9.00e-07 |
| USF1 | 0.0000000 | 0.2185547 | 0e+00 | 9.00e-07 |
| CEBPA | 0.0000012 | 0.0046147 | 0e+00 | 1.50e-06 |
| PKNOX2 | 0.0000001 | 0.0140376 | 0e+00 | 2.30e-06 |
| FOXA3 | 0.0000071 | 0.8939957 | 0e+00 | 2.30e-06 |
| CEBPB | 0.0000012 | 0.0118270 | 0e+00 | 2.30e-06 |
| PKNOX1 | 0.0000001 | 0.9561768 | 0e+00 | 2.30e-06 |
| MEIS1 | 0.0000001 | 0.1229445 | 1e-07 | 2.40e-06 |
| TGIF1 | 0.0000001 | 0.2912322 | 1e-07 | 2.40e-06 |
| TGIF2 | 0.0000001 | 0.9898682 | 1e-07 | 2.40e-06 |
| FOXD3 | 0.0000071 | 0.8125302 | 1e-07 | 4.10e-06 |
| MEIS2 | 0.0000001 | 0.8463790 | 1e-07 | 5.00e-06 |
| DLX3 | 0.0000477 | 0.0043755 | 2e-07 | 5.90e-06 |
| MYCN | 0.0000004 | 0.4520504 | 2e-07 | 7.30e-06 |
| FOXG1 | 0.0000071 | 0.8432650 | 2e-07 | 7.40e-06 |
| ID1 | 0.0000017 | 0.0093116 | 3e-07 | 9.60e-06 |
| MAX | 0.0000017 | 0.5516440 | 3e-07 | 1.04e-05 |
| FOXC2 | 0.0000071 | 0.8538362 | 4e-07 | 1.09e-05 |
| DLX5 | 0.0000477 | 0.0017341 | 4e-07 | 1.09e-05 |
| MYC | 0.0000004 | 0.2194055 | 4e-07 | 1.11e-05 |
| MEIS3 | 0.0000001 | 0.8591956 | 4e-07 | 1.11e-05 |
| RORA | 0.0001585 | 0.0021495 | 4e-07 | 1.11e-05 |
| CREB3L2 | 0.0000017 | 0.6550453 | 5e-07 | 1.15e-05 |

# 5 Session Information

```
sessionInfo()
```

```
## R version 3.6.0 (2019-04-26)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.2 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.9-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.9-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] magrittr_1.5                      BSgenome.Hsapiens.UCSC.hg19_1.4.0
##  [3] BSgenome_1.52.0                   rtracklayer_1.44.0
##  [5] Biostrings_2.52.0                 XVector_0.24.0
##  [7] GenomicRanges_1.36.0              GenomeInfoDb_1.20.0
##  [9] IRanges_2.18.0                    S4Vectors_0.22.0
## [11] BiocGenerics_0.30.0               enrichTF_1.0.0
## [13] pipeFrame_1.0.0
##
## loaded via a namespace (and not attached):
##  [1] bitops_1.0-6                matrixStats_0.54.0
##  [3] DirichletMultinomial_1.26.0 TFBSTools_1.22.0
##  [5] bit64_0.9-7                 httr_1.4.0
##  [7] tools_3.6.0                 R6_2.4.0
##  [9] seqLogo_1.50.0              DBI_1.0.0
## [11] lazyeval_0.2.2              colorspace_1.4-1
## [13] tidyselect_0.2.5            bit_1.1-14
## [15] compiler_3.6.0              Biobase_2.44.0
## [17] DelayedArray_0.10.0         caTools_1.17.1.2
## [19] scales_1.0.0                readr_1.3.1
## [21] stringr_1.4.0               digest_0.6.18
## [23] Rsamtools_2.0.0             rmarkdown_1.12
## [25] motifmatchr_1.6.0           R.utils_2.8.0
## [27] pkgconfig_2.0.2             htmltools_0.3.6
## [29] highr_0.8                   htmlwidgets_1.3
## [31] rlang_0.3.4                 RSQLite_2.1.1
## [33] VGAM_1.1-1                  visNetwork_2.0.6
## [35] jsonlite_1.6                BiocParallel_1.18.0
## [37] gtools_3.8.1                dplyr_0.8.0.1
## [39] R.oo_1.22.0                 RCurl_1.95-4.12
## [41] GO.db_3.8.2                 GenomeInfoDbData_1.2.1
## [43] Matrix_1.2-17               Rcpp_1.0.1
## [45] munsell_0.5.0               R.methodsS3_1.7.1
## [47] stringi_1.4.3               yaml_2.2.0
## [49] SummarizedExperiment_1.14.0 zlibbioc_1.30.0
## [51] plyr_1.8.4                  grid_3.6.0
## [53] blob_1.1.1                  crayon_1.3.4
## [55] CNEr_1.20.0                 lattice_0.20-38
## [57] splines_3.6.0               annotate_1.62.0
## [59] hms_0.4.2                   KEGGREST_1.24.0
## [61] knitr_1.22                  pillar_1.3.1
## [63] reshape2_1.4.3              JASPAR2018_1.1.1
## [65] TFMPvalue_0.0.8             XML_3.98-1.19
## [67] glue_1.3.1                  evaluate_0.13
## [69] BiocManager_1.30.4          png_0.1-7
## [71] gtable_0.3.0                poweRlaw_0.70.2
## [73] purrr_0.3.2                 assertthat_0.2.1
## [75] ggplot2_3.1.1               xfun_0.6
## [77] xtable_1.8-4                tibble_2.1.1
## [79] GenomicAlignments_1.20.0    AnnotationDbi_1.46.0
## [81] memoise_1.1.0
```