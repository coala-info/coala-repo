# Clustering Spectra from High Resolution DI-MS/MS Data Using CluMSID

#### Tobias Depke

#### October 29, 2025

## Introduction

Although originally developed for liquid chromatography-tandem mass spectrometry (LC-MS/MS) data, CluMSID can also be used with direct infusion-tandem mass spectrometry (DI-MS/MS) data.

Generally, the missing retention time dimension makes feature annotation in metabolomics harder but if only direct infusion data is at hand, CluMSID can help to get an overview of the chemodiversity of a sample measured by DI-MS/MS.

In this example, we will use a similar sample (1uL *Pseudomonas aeruginosa* PA14 cell extract) as in the General Tutorial, measured on the same machine, a Bruker maxisHD qTOF operated in ESI-(+) mode with auto-MS/MS but without chromatographic separation.

## Data import

We load the file from the `CluMSIDdata` package:

```
library(CluMSID)
library(CluMSIDdata)

DIfile <- system.file("extdata",
                        "PA14_maxis_DI.mzXML",
                        package = "CluMSIDdata")
```

## Data preprocessing

The extraction of spectra works the same way as with LC-MS/MS data:

```
ms2list <- extractMS2spectra(DIfile)
length(ms2list)
#> [1] 373
```

Merging of redundant spectra is less straightforward when retention time is not available. Depending on the MS/MS method it can be next to impossible to decide whether two spectra with the same precursor *m/z* and similar fragmentation patterns derive from the same analyte or from two different but structurally similar ones.

In this example, we would like to merge spectra with identical precursor ions only if they were recorded one right after another. We can do so by setting `rt_tolerance` to 1 second:

```
featlist <- mergeMS2spectra(ms2list, rt_tolerance = 1)
length(featlist)
#> [1] 349
```

We see that we have hardly reduced the number of spectra in the list. If we would decide to merge all spectra with identical precursor *m/z* from the entire run, we could do so by setting `rt_tolerance` to the duration of the run, in this case approx. 250 seconds:

```
testlist <- mergeMS2spectra(ms2list, rt_tolerance = 250)
length(testlist)
#> [1] 75
```

The resulting number of spectra is drastically lower but the danger of merging spectra that do not actually derive from the same analyte is also very big.

## Generation of distance matrix

In this very explorative example, we skip the integration of previous knowledge on feature identities and generate a distance matrix right away:

```
distmat <- distanceMatrix(featlist)
```

## Data exploration

Starting from this distance matrix, we can use all the data exploration functions that `CluMSID` offers. In this example workflow, we look at a cluster dendrogram:

```
HCplot(distmat, cex = 0.5)
```

![](data:image/png;base64...)

**Figure 1:** Circularised dendrogram as a result of agglomerative hierarchical clustering with average linkage as agglomeration criterion based on MS2 spectra similarities of the DI-MS/MS example data set. Each leaf represents one feature and colours encode cluster affiliation of the features. Leaf labels display feature IDs, along with feature annotations, if existent. Distance from the central point is indicative of the height of the dendrogram.

It is directly obvious that we have some spectra that are nearly identical and thus most likely derive from the same analyte, e.g. the many spectra with a precursor *m/z* of 270.19. But we still see nice clustering of similar spectra with different precursor *m/z*, e.g. the huge gray cluster that contains a lot of different alkylquinolone type metabolites (see General Tutorial).

In conclusion, CluMSID is very useful to provide an overview of spectral similarities within DI-MS/MS runs but wherever annotation is in the focus, one should not do without the additional layer of information created by chromatographic separation.

# Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] CluMSIDdata_1.25.0 CluMSID_1.26.0
#>
#> loaded via a namespace (and not attached):
#>   [1] bitops_1.0-9                rlang_1.1.6
#>   [3] magrittr_2.0.4              clue_0.3-66
#>   [5] matrixStats_1.5.0           compiler_4.5.1
#>   [7] vctrs_0.6.5                 reshape2_1.4.4
#>   [9] stringr_1.5.2               ProtGenerics_1.42.0
#>  [11] pkgconfig_2.0.3             MetaboCoreUtils_1.18.0
#>  [13] fastmap_1.2.0               XVector_0.50.0
#>  [15] caTools_1.18.3              rmarkdown_2.30
#>  [17] preprocessCore_1.72.0       network_1.19.0
#>  [19] purrr_1.1.0                 xfun_0.53
#>  [21] MultiAssayExperiment_1.36.0 cachem_1.1.0
#>  [23] jsonlite_2.0.0              DelayedArray_0.36.0
#>  [25] BiocParallel_1.44.0         parallel_4.5.1
#>  [27] cluster_2.1.8.1             R6_2.6.1
#>  [29] bslib_0.9.0                 stringi_1.8.7
#>  [31] RColorBrewer_1.1-3          limma_3.66.0
#>  [33] GGally_2.4.0                GenomicRanges_1.62.0
#>  [35] jquerylib_0.1.4             Rcpp_1.1.0
#>  [37] Seqinfo_1.0.0               SummarizedExperiment_1.40.0
#>  [39] iterators_1.0.14            knitr_1.50
#>  [41] IRanges_2.44.0              BiocBaseUtils_1.12.0
#>  [43] Matrix_1.7-4                igraph_2.2.1
#>  [45] tidyselect_1.2.1            dichromat_2.0-0.1
#>  [47] abind_1.4-8                 yaml_2.3.10
#>  [49] gplots_3.2.0                doParallel_1.0.17
#>  [51] codetools_0.2-20            affy_1.88.0
#>  [53] lattice_0.22-7              tibble_3.3.0
#>  [55] plyr_1.8.9                  Biobase_2.70.0
#>  [57] S7_0.2.0                    coda_0.19-4.1
#>  [59] evaluate_1.0.5              Spectra_1.20.0
#>  [61] ggstats_0.11.0              pillar_1.11.1
#>  [63] affyio_1.80.0               BiocManager_1.30.26
#>  [65] MatrixGenerics_1.22.0       KernSmooth_2.23-26
#>  [67] foreach_1.5.2               stats4_4.5.1
#>  [69] plotly_4.11.0               MSnbase_2.36.0
#>  [71] MALDIquant_1.22.3           ncdf4_1.24
#>  [73] generics_0.1.4              dbscan_1.2.3
#>  [75] S4Vectors_0.48.0            ggplot2_4.0.0
#>  [77] scales_1.4.0                gtools_3.9.5
#>  [79] glue_1.8.0                  lazyeval_0.2.2
#>  [81] tools_4.5.1                 data.table_1.17.8
#>  [83] mzID_1.48.0                 QFeatures_1.20.0
#>  [85] vsn_3.78.0                  mzR_2.44.0
#>  [87] fs_1.6.6                    XML_3.99-0.19
#>  [89] grid_4.5.1                  impute_1.84.0
#>  [91] tidyr_1.3.1                 ape_5.8-1
#>  [93] MsCoreUtils_1.22.0          nlme_3.1-168
#>  [95] PSMatch_1.14.0              cli_3.6.5
#>  [97] viridisLite_0.4.2           S4Arrays_1.10.0
#>  [99] dplyr_1.1.4                 AnnotationFilter_1.34.0
#> [101] pcaMethods_2.2.0            gtable_0.3.6
#> [103] sass_0.4.10                 digest_0.6.37
#> [105] BiocGenerics_0.56.0         SparseArray_1.10.0
#> [107] htmlwidgets_1.6.4           sna_2.8
#> [109] farver_2.1.2                htmltools_0.5.8.1
#> [111] lifecycle_1.0.4             httr_1.4.7
#> [113] statnet.common_4.12.0       statmod_1.5.1
#> [115] MASS_7.3-65
```