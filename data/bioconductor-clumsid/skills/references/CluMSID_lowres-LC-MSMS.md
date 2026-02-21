# Clustering Mass Spectra from Low Resolution LC-MS/MS Data Using CluMSID

#### Tobias Depke

#### October 29, 2025

## Introduction

As described in the GC-EI-MS tutorial, CluMSID can also be used to analyse low resolution data – although using low resolution data comes at a cost.

In this example, we will use a similar sample (1uL *Pseudomonas aeruginosa* PA14 cell extract) as in the General Tutorial, measured with similar chromatography but on a different mass spectrometer, a Bruker amaZon ion trap instrument operated in ESI-(+) mode with auto-MS/MS. In addition to introducing a workflow for low resolution LC-MS/MS data, this example also demonstrates that CluMSID can work with data from different types of mass spectrometers.

## Data import

We load the file from the `CluMSIDdata` package:

```
library(CluMSID)
library(CluMSIDdata)

lowresfile <- system.file("extdata",
                        "PA14_amazon_lowres.mzXML",
                        package = "CluMSIDdata")
```

## Data preprocessing

The extraction of spectra works the same way as with high resolution LC-MS/MS data:

```
ms2list <- extractMS2spectra(lowresfile)
length(ms2list)
#> [1] 1989
```

Like in the GC-EI-MS example, we have to adjust `mz_tolerance` to a much higher value compared to high resolution data, while the retention time tolerance can remain unchanged.

```
featlist <- mergeMS2spectra(ms2list, mz_tolerance = 0.02)
```

```
length(featlist)
#> [1] 525
```

We see that we have similar numbers of spectra as in the General Tutorial, because we tried to keep all parameters except for the mass spectrometer type comparable.

## Generation of distance matrix

As we do not have low resolution spectral libraries at hand, we skip the integration of previous knowledge on feature identities in this example and generate a distance matrix right away:

```
distmat <- distanceMatrix(featlist)
```

## Data exploration

Starting from this distance matrix, we can use all the data exploration functions that `CluMSID` offers.

When we now make an MDS plot, we learn that the similarity data is very different from the comparable high resolution data:

```
MDSplot(distmat)
```

![](data:image/png;base64...)

**Figure 1:** Multidimensional scaling plot as a visualisation of MS2 spectra similarities of the low resolution LC-MS/MS example data set. Black dots signify spectra from unknown metabolites.

To get a better overview of the data and the general similarity behaviour, we create a heat map of the distance matrix:

```
HCplot(distmat, type = "heatmap",
                cexRow = 0.1, cexCol = 0.1,
                margins = c(6,6))
```

![](data:image/png;base64...)

**Figure 2:** Symmetric heat map of the distance matrix displaying MS2 spectra similarities of the low resolution LC-MS/MS example data set. along with dendrograms resulting from hierarchical clustering based on the distance matrix. The colour encoding is shown in the top-left insert.

We clearly see that the heat map is generally a lot “warmer” than in the General Tutorial (an intuition that is supported by the histogram in the top-left corner), i.e. we have a higher general degree of similarity between spectra. That is not surprising as the *m/z* information has much fewer levels than in high resolution data and fragments of different sum formula are more likely to have indistinguishable mass-to-charge ratios.

We also see that some more or less compact clusters can be identified. This is easier to inspect in the dendrogram visualisation:

```
HCplot(distmat, h = 0.8, cex = 0.3)
```

![](data:image/png;base64...)

**Figure 3:** Circularised dendrogram as a result of agglomerative hierarchical clustering with average linkage as agglomeration criterion based on MS2 spectra similarities of the low resolution LC-MS/MS example data set. Each leaf represents one feature and colours encode cluster affiliation of the features. Leaf labels display feature IDs. Distance from the central point is indicative of the height of the dendrogram.

In conclusion, CluMSID is capable of processing low resolution LC-MS/MS data and if high resolution data is not available, it can be very useful to provide an overview of spectral similarities in low resolution data, thereby helping metabolite annotation if some individual metabolites can be identified by comparison to authentic standards. However, concerning feature annotation, high resolution methods should always be favoured for the many benefits they provide.

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
#>  [1] magrittr_2.0.4      metaMSdata_1.45.0   metaMS_1.46.0
#>  [4] CAMERA_1.66.0       xcms_4.8.0          BiocParallel_1.44.0
#>  [7] Biobase_2.70.0      BiocGenerics_0.56.0 generics_0.1.4
#> [10] CluMSIDdata_1.25.0  CluMSID_1.26.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
#>   [3] jsonlite_2.0.0              MultiAssayExperiment_1.36.0
#>   [5] farver_2.1.2                MALDIquant_1.22.3
#>   [7] rmarkdown_2.30              fs_1.6.6
#>   [9] vctrs_0.6.5                 base64enc_0.1-3
#>  [11] htmltools_0.5.8.1           S4Arrays_1.10.0
#>  [13] BiocBaseUtils_1.12.0        progress_1.2.3
#>  [15] SparseArray_1.10.0          Formula_1.2-5
#>  [17] mzID_1.48.0                 sass_0.4.10
#>  [19] KernSmooth_2.23-26          bslib_0.9.0
#>  [21] htmlwidgets_1.6.4           plyr_1.8.9
#>  [23] impute_1.84.0               plotly_4.11.0
#>  [25] cachem_1.1.0                igraph_2.2.1
#>  [27] lifecycle_1.0.4             iterators_1.0.14
#>  [29] pkgconfig_2.0.3             Matrix_1.7-4
#>  [31] R6_2.6.1                    fastmap_1.2.0
#>  [33] MatrixGenerics_1.22.0       clue_0.3-66
#>  [35] digest_0.6.37               colorspace_2.1-2
#>  [37] pcaMethods_2.2.0            GGally_2.4.0
#>  [39] S4Vectors_0.48.0            Hmisc_5.2-4
#>  [41] GenomicRanges_1.62.0        labeling_0.4.3
#>  [43] Spectra_1.20.0              httr_1.4.7
#>  [45] abind_1.4-8                 compiler_4.5.1
#>  [47] bit64_4.6.0-1               withr_3.0.2
#>  [49] doParallel_1.0.17           backports_1.5.0
#>  [51] htmlTable_2.4.3             S7_0.2.0
#>  [53] DBI_1.2.3                   ggstats_0.11.0
#>  [55] gplots_3.2.0                MASS_7.3-65
#>  [57] MsExperiment_1.12.0         DelayedArray_0.36.0
#>  [59] gtools_3.9.5                caTools_1.18.3
#>  [61] mzR_2.44.0                  tools_4.5.1
#>  [63] PSMatch_1.14.0              foreign_0.8-90
#>  [65] ape_5.8-1                   nnet_7.3-20
#>  [67] glue_1.8.0                  dbscan_1.2.3
#>  [69] nlme_3.1-168                QFeatures_1.20.0
#>  [71] grid_4.5.1                  checkmate_2.3.3
#>  [73] cluster_2.1.8.1             reshape2_1.4.4
#>  [75] gtable_0.3.6                tzdb_0.5.0
#>  [77] preprocessCore_1.72.0       tidyr_1.3.1
#>  [79] sna_2.8                     data.table_1.17.8
#>  [81] hms_1.1.4                   MetaboCoreUtils_1.18.0
#>  [83] XVector_0.50.0              foreach_1.5.2
#>  [85] pillar_1.11.1               stringr_1.5.2
#>  [87] vroom_1.6.6                 limma_3.66.0
#>  [89] robustbase_0.99-6           dplyr_1.1.4
#>  [91] lattice_0.22-7              bit_4.6.0
#>  [93] tidyselect_1.2.1            RBGL_1.86.0
#>  [95] knitr_1.50                  gridExtra_2.3
#>  [97] IRanges_2.44.0              Seqinfo_1.0.0
#>  [99] ProtGenerics_1.42.0         SummarizedExperiment_1.40.0
#> [101] stats4_4.5.1                xfun_0.53
#> [103] statmod_1.5.1               MSnbase_2.36.0
#> [105] matrixStats_1.5.0           DEoptimR_1.1-4
#> [107] stringi_1.8.7               statnet.common_4.12.0
#> [109] lazyeval_0.2.2              yaml_2.3.10
#> [111] evaluate_1.0.5              codetools_0.2-20
#> [113] archive_1.1.12              MsCoreUtils_1.22.0
#> [115] tibble_3.3.0                BiocManager_1.30.26
#> [117] graph_1.88.0                cli_3.6.5
#> [119] affyio_1.80.0               rpart_4.1.24
#> [121] jquerylib_0.1.4             network_1.19.0
#> [123] dichromat_2.0-0.1           Rcpp_1.1.0
#> [125] MassSpecWavelet_1.76.0      coda_0.19-4.1
#> [127] XML_3.99-0.19               parallel_4.5.1
#> [129] readr_2.1.5                 ggplot2_4.0.0
#> [131] prettyunits_1.2.0           AnnotationFilter_1.34.0
#> [133] bitops_1.0-9                viridisLite_0.4.2
#> [135] MsFeatures_1.18.0           scales_1.4.0
#> [137] affy_1.88.0                 ncdf4_1.24
#> [139] purrr_1.1.0                 crayon_1.5.3
#> [141] rlang_1.1.6                 vsn_3.78.0
```