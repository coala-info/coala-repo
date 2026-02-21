# Wrench

#### M. Senthil Kumar\(^1\), Héctor Corrada Bravo\(^1\)

#### \(^1\)Center for Bioinformatics and Computational Biology, University of Maryland, College Park, MD 20740.

#### 9/23/2018

* [1 Abstract](#abstract)
* [2 Introduction](#introduction)
* [3 Installation](#installation)
* [4 Running Wrench](#running-wrench)
* [5 Some caveats / work in development](#some-caveats-work-in-development)
* [6 The “detrend” option](#the-detrend-option)
* [7 Session Info](#session-info)

# 1 Abstract

*Wrench* is a normalization technique for metagenomic count data. While principally developed for sparse 16S count data from metagenomic experiments, it can also be applied to normalizing count data from other sparse technologies like single cell RNAseq, functional microbiome etc.,.

Given (a) count data organized as features (OTUs, genes etc.,) x samples, and (b) experimental group labels associated with samples, Wrench outputs a normalization factor for each sample. The data is normalized by dividing each sample’s counts with its normalization factor.

The manuscript can be accessed here: <https://www.biorxiv.org/content/early/2018/01/31/142851>

# 2 Introduction

An unwanted side-effect of DNA sequencing is that the observed counts retain only relative abundance/expression information. Comparing such relative abundances between experimental conditions/groups (for e.g., with differential abundance analysis) can cause problems. Specifically, in the presence of features that are differentially abundant in absolute abundances, truly unperturbed features can be identified as being differentially abundant. Commonly used techniques like rarefaction/subsampling/dividing by the total count and other variants of these approaches, do not correct for this issue. Wrench was developed to address this problem of reconstructing absolute from relative abundances based on some commonly exploited assumptions in genomics.

The Introduction section in the manuscript presented here: <https://www.biorxiv.org/content/early/2018/01/31/142851> provide some perspective on various commonly used normalization techniques from the above standpoint, and we recommend reading through it.

# 3 Installation

Download package.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Wrench")
```

Or install the development version of the package from Github.

```
BiocManager::install(“HCBravoLab/Wrench”)
```

Load the package.

```
library(Wrench)
```

# 4 Running Wrench

Below, we present a quick tutorial, where we pass count data, and group information to generate compositional and normalization factors. Details on any optional parameters are provided by typing “?wrench” in the R terminal window.

```
#extract count and group information for from the mouse microbiome data in the metagenomeSeq package
data(mouseData)
mouseData
```

```
## MRexperiment (storageMode: environment)
## assayData: 10172 features, 139 samples
##   element names: counts
## protocolData: none
## phenoData
##   sampleNames: PM1:20080107 PM1:20080108 ... PM9:20080303 (139 total)
##   varLabels: mouseID date ... status (5 total)
##   varMetadata: labelDescription
## featureData
##   featureNames: Prevotellaceae:1 Lachnospiraceae:1 ...
##     Parabacteroides:956 (10172 total)
##   fvarLabels: superkingdom phylum ... OTU (7 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

```
counts <- MRcounts( mouseData, norm=FALSE )  #get the counts
counts[1:10,1:2]
```

```
##                                      PM1:20080107 PM1:20080108
## Prevotellaceae:1                                0            0
## Lachnospiraceae:1                               0            0
## Unclassified-Screened:1                         0            0
## Clostridiales:1                                 0            0
## Clostridiales:2                                 0            0
## Firmicutes:1                                    0            0
## PeptostreptococcaceaeIncertaeSedis:1            0            0
## Clostridiales:3                                 0            0
## Lachnospiraceae:7                               0            0
## Lachnospiraceae:8                               0            0
```

```
group <- pData(mouseData)$diet #get the group/condition vector
head(group)
```

```
## [1] "BK" "BK" "BK" "BK" "BK" "BK"
```

```
#Running wrench with defaults
W <- wrench( counts, condition=group  )
compositionalFactors <- W$ccf
normalizationFactors <- W$nf

head( compositionalFactors ) #one factor for each sample
```

```
## PM1:20080107 PM1:20080108 PM1:20080114 PM1:20071211 PM1:20080121 PM1:20071217
##    0.7540966    0.8186825    1.0423187    1.2690286    0.7860119    1.3059309
```

```
head( normalizationFactors)  #one factor for each sample
```

```
## PM1:20080107 PM1:20080108 PM1:20080114 PM1:20071211 PM1:20080121 PM1:20071217
##    0.3364660    0.7051424    1.3295084    0.8530978    0.7545386    2.1273695
```

## 4.1 Usage with differential abundance pipelines

Introducing the above normalization factors for the most commonly used tools is shown below.

```
# -- If using metagenomeSeq
normalizedObject <- mouseData  #mouseData is already a metagenomeSeq object
normFactors(normalizedObject) <- normalizationFactors

# -- If using edgeR, we must pass in the compositional factors
edgerobj <- edgeR::DGEList( counts=counts,
                     group = as.matrix(group),
                     norm.factors=compositionalFactors )

# -- If using DESeq/DESeq2
deseq.obj <- DESeq2::DESeqDataSetFromMatrix(countData = counts,
                                   DataFrame(group),
                                   ~ group )
```

```
## converting counts to integer mode
```

```
deseq.obj
```

```
## class: DESeqDataSet
## dim: 10172 139
## metadata(1): version
## assays(1): counts
## rownames(10172): Prevotellaceae:1 Lachnospiraceae:1 ... Bryantella:103
##   Parabacteroides:956
## rowData names(0):
## colnames(139): PM1:20080107 PM1:20080108 ... PM9:20080225 PM9:20080303
## colData names(1): group
```

```
sizeFactors(deseq.obj) <- normalizationFactors
```

# 5 Some caveats / work in development

Wrench currently implements strategies for categorical group labels only. While extension to continuous covariates is still in development, you can create factors/levels out of your continuous covariates (however you think is reasonable) by discretizing/cutting them in pieces.

```
time <- as.numeric(as.character(pData(mouseData)$relativeTime))
time.levs <- cut( time, breaks = c(0, 6, 28, 42, 56, 70) )
overall_group <- paste( group, time.levs ) #merge the time information and the group information together
W <- wrench( counts, condition = overall_group )
```

# 6 The “detrend” option

In cases of very low sample depths and high sparsity, one might find a roughly linear trend between the reconstructed compositional factors (“ccf” entry in the returned list object from Wrench) and the sample depths (total count of a sample) within each experimental group. This can potentially be caused by a large number of zeros affecting the average estimate of the sample-wise ratios of proportions in a downward direction. Existing approaches that exploit zeroes during estimation also suffer from this issue (for instance, varying Scran’s abundance filtering by changing the “min.mean” parameter will reveal the same issue, although in general we have found their pooling approach to be slightly less sensitive with their default abundance filtering).

If you find this happening with the Wrench reconstructed compositional factors, and if you can assume it is reasonable to do so, you can use the detrend=T option (a work in progress) in Wrench to remove such linear trends within groups. It is also worth mentioning that even though low sample-depth samples’ compositional factors can show this behavior, in our experience, we have often found that group-wise averages of compositional factors can still be robust.

# 7 Session Info

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
##  [1] DESeq2_1.50.0               SummarizedExperiment_1.40.0
##  [3] MatrixGenerics_1.22.0       matrixStats_1.5.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] Wrench_1.28.0               edgeR_4.8.0
## [11] metagenomeSeq_1.52.0        RColorBrewer_1.1-3
## [13] glmnet_4.1-10               Matrix_1.7-4
## [15] limma_3.66.0                Biobase_2.70.0
## [17] BiocGenerics_0.56.0         generics_0.1.4
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        shape_1.4.6.1       xfun_0.53
##  [4] bslib_0.9.0         ggplot2_4.0.0       caTools_1.18.3
##  [7] lattice_0.22-7      vctrs_0.6.5         tools_4.5.1
## [10] bitops_1.0-9        parallel_4.5.1      tibble_3.3.0
## [13] pkgconfig_2.0.3     KernSmooth_2.23-26  S7_0.2.0
## [16] lifecycle_1.0.4     compiler_4.5.1      farver_2.1.2
## [19] gplots_3.2.0        statmod_1.5.1       codetools_0.2-20
## [22] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
## [25] pillar_1.11.1       jquerylib_0.1.4     BiocParallel_1.44.0
## [28] DelayedArray_0.36.0 cachem_1.1.0        iterators_1.0.14
## [31] abind_1.4-8         foreach_1.5.2       gtools_3.9.5
## [34] tidyselect_1.2.1    locfit_1.5-9.12     digest_0.6.37
## [37] dplyr_1.1.4         splines_4.5.1       fastmap_1.2.0
## [40] grid_4.5.1          cli_3.6.5           SparseArray_1.10.0
## [43] magrittr_2.0.4      S4Arrays_1.10.0     dichromat_2.0-0.1
## [46] survival_3.8-3      scales_1.4.0        rmarkdown_2.30
## [49] XVector_0.50.0      evaluate_1.0.5      knitr_1.50
## [52] rlang_1.1.6         Rcpp_1.1.0          glue_1.8.0
## [55] jsonlite_2.0.0      R6_2.6.1
```