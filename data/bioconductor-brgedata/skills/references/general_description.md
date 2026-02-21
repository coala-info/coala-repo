# brgedata – data R package with three omic data-set and exposome data-set from the same Spanish pupulation

Carles Hernandez-Ferrer1, Carlos Ruiz-Arenas1 and Juan R. Gonzalez1\*

1Barcelona Institute for Global Health

\*juanr.gonzalez@isglobal.org

#### 30 October 2025

#### Abstract

This document indicates the different data-sets included in `brgedata`. The description includes the technology used to create the and the number of samples and features in each one.

#### Package

brgedata 1.32.0

# Contents

* [1 Getting started](#getting-started)
* [2 Data Resources](#data-resources)
  + [2.1 Exposome Data](#exposome-data)
  + [2.2 Transcriptome Data](#transcriptome-data)
  + [2.3 Methylome Data](#methylome-data)
  + [2.4 Proteome Data](#proteome-data)
* [Session info](#session-info)

# 1 Getting started

`brgedata` includes a collection of BRGE omic and exposome data from the same cohort. The diferent objects guarantees a minimum of samples in common between all sets.

Data available in this R package:

| Data Type | Number of Samples | Number of Features | Technology | Object Name | Class |
| --- | --- | --- | --- | --- | --- |
| Exposome | 110 | 15 |  | `brge_expo` | [`ExposomeSet`](https://github.com/isglobal-brge/rexposome) |
| Transcriptome | 75 | 67528 | Affymetrix HTA 2.0 | `brge_gexp` | [`ExpressionSet`](https://bioconductor.org/packages/release/bioc/html/Biobase.html) |
| Methylome | 20 | 392277 | Illumina Human Methylation 450K | `brge_methy` | [`GenomicRatioSet`](https://bioconductor.org/packages/release/bioc/html/minfi.html) |
| Proteome | 90 | 47 |  | `brge_prot` | [`ExpressionSet`](https://bioconductor.org/packages/release/bioc/html/Biobase.html) |

`sex` and `age` was included as phenotipic data in each set. Moreover, the `ExposomeSet` includes *asthma status* and *rhinitis status* of each sample.

# 2 Data Resources

## 2.1 Exposome Data

To load the **exposome data**, stored in an `ExposomeSet`, run the follow commands:

```
data("brge_expo", package = "brgedata")
brge_expo
```

```
## Object of class 'ExposomeSet' (storageMode: environment)
##  . exposures description:
##     . categorical:  0
##     . continuous:  15
##  . exposures transformation:
##     . categorical: 0
##     . transformed: 0
##     . standardized: 0
##     . imputed: 0
##  . assayData: 15 exposures 110 individuals
##     . element names: exp, raw
##     . exposures: Ben_p, ..., PCB153
##     . individuals: x0001, ..., x0119
##  . phenoData: 110 individuals 6 phenotypes
##     . individuals: x0001, ..., x0119
##     . phenotypes: Asthma, ..., Age
##  . featureData: 15 exposures 12 explanations
##     . exposures: Ben_p, ..., PCB153
##     . descriptions: Family, ..., .imp
## experimentData: use 'experimentData(object)'
## Annotation:
```

The summary of the data contained by `brge_expo`:

| Data Type | Number of Samples | Number of Features | Technology | Object Name | Class |
| --- | --- | --- | --- | --- | --- |
| Exposome | 110 | 15 |  | `brge_expo` | [`ExposomeSet`](https://github.com/isglobal-brge/rexposome) |

## 2.2 Transcriptome Data

To load the **transcriptome data**, saved in an `ExpressionSet`, run the follow commands:

```
data("brge_gexp", package = "brgedata")
brge_gexp
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 67528 features, 100 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: x0001 x0002 ... x0139 (100 total)
##   varLabels: age sex
##   varMetadata: labelDescription
## featureData
##   featureNames: TC01000001.hg.1 TC01000002.hg.1 ...
##     TCUn_gl000247000001.hg.1 (67528 total)
##   fvarLabels: transcript_cluster_id probeset_id ... notes (11 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

The summary of the data contained by `brge_gexp`:

| Data Type | Number of Samples | Number of Features | Technology | Object Name | Class |
| --- | --- | --- | --- | --- | --- |
| Transcriptome | 75 | 67528 | Affymetrix HTA 2.0 | `brge_gexp` | [`ExpressionSet`](https://bioconductor.org/packages/release/bioc/html/Biobase.html) |

## 2.3 Methylome Data

To load the **methylation data**, encapsulated in a `GenomicRatioSet`, run the follow commands:

```
data("brge_methy", package = "brgedata")
brge_methy
```

```
## class: GenomicRatioSet
## dim: 392277 20
## metadata(0):
## assays(1): Beta
## rownames(392277): cg13869341 cg24669183 ... cg26251715 cg25640065
## rowData names(14): Forward_Sequence SourceSeq ...
##   Regulatory_Feature_Group DHS
## colnames(20): x0017 x0043 ... x0077 x0079
## colData names(9): age sex ... Mono Neu
## Annotation
##   array: IlluminaHumanMethylation450k
##   annotation: ilmn12.hg19
## Preprocessing
##   Method: NA
##   minfi version: NA
##   Manifest version: NA
```

The summary of the data contained by `brge_methy`:

| Data Type | Number of Samples | Number of Features | Technology | Object Name | Class |
| --- | --- | --- | --- | --- | --- |
| Methylome | 20 | 392277 | Illumina Human Methylation 450K | `brge_methy` | [`GenomicRatioSet`](https://bioconductor.org/packages/release/bioc/html/minfi.html) |

## 2.4 Proteome Data

To load the **protein data**, stored in an `ExpressionSet`, run the follow commands:

```
data("brge_prot", package = "brgedata")
brge_prot
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 47 features, 90 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: x0001 x0002 ... x0090 (90 total)
##   varLabels: age sex
##   varMetadata: labelDescription
## featureData
##   featureNames: Adiponectin_ok Alpha1AntitrypsinAAT_ok ...
##     VitaminDBindingProte_ok (47 total)
##   fvarLabels: chr start end
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

The summary of the data contained by `brge_prot`:

| Data Type | Number of Samples | Number of Features | Technology | Object Name | Class |
| --- | --- | --- | --- | --- | --- |
| Proteome | 90 | 47 |  | `brge_prot` | [`ExpressionSet`](https://bioconductor.org/packages/release/bioc/html/Biobase.html) |

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
## [1] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1               BiocIO_1.20.0
##   [3] norm_1.0-11.1               bitops_1.0-9
##   [5] tibble_3.3.0                preprocessCore_1.72.0
##   [7] XML_3.99-0.19               rpart_4.1.24
##   [9] lifecycle_1.0.4             Rdpack_2.6.4
##  [11] lattice_0.22-7              MASS_7.3-65
##  [13] base64_2.0.2                scrime_1.3.5
##  [15] flashClust_1.01-2           backports_1.5.0
##  [17] magrittr_2.0.4              minfi_1.56.0
##  [19] limma_3.66.0                Hmisc_5.2-4
##  [21] sass_0.4.10                 rmarkdown_2.30
##  [23] jquerylib_0.1.4             yaml_2.3.10
##  [25] doRNG_1.8.6.2               askpass_1.2.1
##  [27] DBI_1.2.3                   minqa_1.2.8
##  [29] RColorBrewer_1.1-3          multcomp_1.4-29
##  [31] abind_1.4-8                 quadprog_1.5-8
##  [33] GenomicRanges_1.62.0        purrr_1.1.0
##  [35] RCurl_1.98-1.17             BiocGenerics_0.56.0
##  [37] nnet_7.3-20                 TH.data_1.1-4
##  [39] sandwich_3.1-1              circlize_0.4.16
##  [41] IRanges_2.44.0              S4Vectors_0.48.0
##  [43] ggrepel_0.9.6               rentrez_1.2.4
##  [45] genefilter_1.92.0           annotate_1.88.0
##  [47] DelayedMatrixStats_1.32.0   codetools_0.2-20
##  [49] DelayedArray_0.36.0         xml2_1.4.1
##  [51] DT_0.34.0                   tidyselect_1.2.1
##  [53] gmm_1.9-1                   shape_1.4.6.1
##  [55] farver_2.1.2                lme4_1.1-37
##  [57] beanplot_1.3.1              matrixStats_1.5.0
##  [59] stats4_4.5.1                base64enc_0.1-3
##  [61] illuminaio_0.52.0           Seqinfo_1.0.0
##  [63] GenomicAlignments_1.46.0    jsonlite_2.0.0
##  [65] multtest_2.66.0             Formula_1.2-5
##  [67] survival_3.8-3              iterators_1.0.14
##  [69] emmeans_2.0.0               foreach_1.5.2
##  [71] tools_4.5.1                 pryr_0.1.6
##  [73] Rcpp_1.1.0                  glue_1.8.0
##  [75] gridExtra_2.3               SparseArray_1.10.0
##  [77] xfun_0.53                   MatrixGenerics_1.22.0
##  [79] dplyr_1.1.4                 HDF5Array_1.38.0
##  [81] BiocManager_1.30.26         fastmap_1.2.0
##  [83] boot_1.3-32                 rhdf5filters_1.22.0
##  [85] openssl_2.3.4               caTools_1.18.3
##  [87] digest_0.6.37               R6_2.6.1
##  [89] estimability_1.5.1          imputeLCMD_2.1
##  [91] colorspace_2.1-2            gtools_3.9.5
##  [93] dichromat_2.0-0.1           RSQLite_2.4.3
##  [95] cigarillo_1.0.0             h5mread_1.2.0
##  [97] tidyr_1.3.1                 generics_0.1.4
##  [99] data.table_1.17.8           rtracklayer_1.70.0
## [101] httr_1.4.7                  htmlwidgets_1.6.4
## [103] S4Arrays_1.10.0             scatterplot3d_0.3-44
## [105] pkgconfig_2.0.3             gtable_0.3.6
## [107] blob_1.2.4                  S7_0.2.0
## [109] siggenes_1.84.0             impute_1.84.0
## [111] XVector_0.50.0              htmltools_0.5.8.1
## [113] bookdown_0.45               multcompView_0.1-10
## [115] scales_1.4.0                Biobase_2.70.0
## [117] rexposome_1.32.0            png_0.1-8
## [119] tmvtnorm_1.7                leaps_3.2
## [121] reformulas_0.4.2            corrplot_0.95
## [123] knitr_1.50                  rstudioapi_0.17.1
## [125] tzdb_0.5.0                  rjson_0.2.23
## [127] reshape2_1.4.4              curl_7.0.0
## [129] coda_0.19-4.1               checkmate_2.3.3
## [131] nlme_3.1-168                nloptr_2.2.1
## [133] bumphunter_1.52.0           cachem_1.1.0
## [135] zoo_1.8-14                  rhdf5_2.54.0
## [137] GlobalOptions_0.1.2         stringr_1.5.2
## [139] KernSmooth_2.23-26          parallel_4.5.1
## [141] foreign_0.8-90              AnnotationDbi_1.72.0
## [143] restfulr_0.0.16             GEOquery_2.78.0
## [145] pillar_1.11.1               grid_4.5.1
## [147] reshape_0.8.10              vctrs_0.6.5
## [149] gplots_3.2.0                pcaMethods_2.2.0
## [151] xtable_1.8-4                cluster_2.1.8.1
## [153] htmlTable_2.4.3             evaluate_1.0.5
## [155] readr_2.1.5                 GenomicFeatures_1.62.0
## [157] Rsamtools_2.26.0            locfit_1.5-9.12
## [159] mvtnorm_1.3-3               cli_3.6.5
## [161] compiler_4.5.1              rngtools_1.5.2
## [163] rlang_1.1.6                 crayon_1.5.3
## [165] nor1mix_1.3-3               mclust_6.1.1
## [167] plyr_1.8.9                  stringi_1.8.7
## [169] lsr_0.5.2                   BiocParallel_1.44.0
## [171] Biostrings_2.78.0           glmnet_4.1-10
## [173] Matrix_1.7-4                hms_1.1.4
## [175] sparseMatrixStats_1.22.0    bit64_4.6.0-1
## [177] ggplot2_4.0.0               Rhdf5lib_1.32.0
## [179] KEGGREST_1.50.0             statmod_1.5.1
## [181] FactoMineR_2.12             SummarizedExperiment_1.40.0
## [183] rbibutils_2.3               memoise_2.0.1
## [185] bslib_0.9.0                 bit_4.6.0
```