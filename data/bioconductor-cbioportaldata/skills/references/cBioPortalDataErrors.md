# cBioPortalData: Data Build Errors

Marcel Ramos & Levi Waldron

#### November 09, 2025

# Contents

* [Loading](#loading)
* [Overview](#overview)
  + [Data from the cBioPortal API (`cBioPortalData()`)](#data-from-the-cbioportal-api-cbioportaldata)
  + [Packaged data from `cBioDataPack()`](#packaged-data-from-cbiodatapack)
* [sessionInfo](#sessioninfo)

# Loading

```
library(cBioPortalData)
library(AnVIL)
library(jsonlite)
```

# Overview

This document serves as a reporting tool for errors that occur
when running our utility functions on the cBioPortal datasets.

## Data from the cBioPortal API (`cBioPortalData()`)

Typically, the number of errors encountered via the API are low.
There are only a handful of packages that error when we apply the
utility functions to provide a MultiAssayExperiment data representation.

First, we load the error `Rda` dataset.

```
api_errs <- system.file(
    "extdata", "api", "err_api_info.json",
    package = "cBioPortalData", mustWork = TRUE
)
err_api_info <- fromJSON(api_errs)
```

We can now inspect the contents of the data:

```
class(err_api_info)
```

```
## [1] "list"
```

```
length(err_api_info)
```

```
## [1] 6
```

```
lengths(err_api_info)
```

```
##                           Barcodes must start with 'TCGA'
##                                                         2
##                     group length is 0 but data length > 0
##                                                         1
##   Frequency of NA values higher than the cutoff tolerance
##                                                         2
##                          Inconsistent build numbers found
##                                                        33
##         `n` must be a single number, not an integer `NA`.
##                                                         1
## Argument 1 must be a data frame or a named atomic vector.
##                                                         1
```

There were about 6 unique errors during the last
build run.

```
names(err_api_info)
```

```
## [1] "Barcodes must start with 'TCGA'"
## [2] "group length is 0 but data length > 0"
## [3] "Frequency of NA values higher than the cutoff tolerance"
## [4] "Inconsistent build numbers found"
## [5] "`n` must be a single number, not an integer `NA`."
## [6] "Argument 1 must be a data frame or a named atomic vector."
```

The most common error was `Inconsistent build numbers found`. This is
due to annotations from different build numbers that were not able to
be resolved.

To see what datasets (`cancer_study_id` s) have that error we can use:

```
err_api_info[['Inconsistent build numbers found']]
```

```
##  [1] "msk_ch_2020"                       "msk_access_2021"
##  [3] "mixed_msk_tcga_2021"               "mixed_impact_subset_2022"
##  [5] "pan_origimed_2020"                 "prad_msk_stopsack_2021"
##  [7] "pancan_pcawg_2020"                 "prad_pik3r1_msk_2021"
##  [9] "skcm_tcga"                         "stad_tcga"
## [11] "stad_tcga_pub"                     "skcm_tcga_pan_can_atlas_2018"
## [13] "stad_tcga_pan_can_atlas_2018"      "stes_tcga_pub"
## [15] "summit_2018"                       "cfdna_msk_2019"
## [17] "blca_bcan_hcrn_2022"               "nsclc_ctdx_msk_2022"
## [19] "thyroid_mskcc_2016"                "skcm_mskcc_2014"
## [21] "tmb_mskcc_2018"                    "rectal_msk_2019"
## [23] "skcm_tcga_pub_2015"                "msk_spectrum_tme_2022"
## [25] "ucec_ccr_cfdna_msk_2022"           "paired_bladder_2022"
## [27] "mtnn_msk_2022"                     "pog570_bcgsc_2020"
## [29] "sarcoma_msk_2023"                  "bowel_colitis_msk_2022"
## [31] "luad_mskcc_2023_met_organotropism" "coad_silu_2022"
## [33] "paac_msk_jco_2023"
```

We can also have a look at the entirety of the dataset.

```
err_api_info
```

```
## $`Barcodes must start with 'TCGA'`
## [1] "blca_msk_tcga_2020"    "nsclc_tcga_broad_2016"
##
## $`group length is 0 but data length > 0`
## [1] "glioma_msk_2018"
##
## $`Frequency of NA values higher than the cutoff tolerance`
## [1] "mixed_selpercatinib_2020" "ucec_ccr_msk_2022"
##
## $`Inconsistent build numbers found`
##  [1] "msk_ch_2020"                       "msk_access_2021"
##  [3] "mixed_msk_tcga_2021"               "mixed_impact_subset_2022"
##  [5] "pan_origimed_2020"                 "prad_msk_stopsack_2021"
##  [7] "pancan_pcawg_2020"                 "prad_pik3r1_msk_2021"
##  [9] "skcm_tcga"                         "stad_tcga"
## [11] "stad_tcga_pub"                     "skcm_tcga_pan_can_atlas_2018"
## [13] "stad_tcga_pan_can_atlas_2018"      "stes_tcga_pub"
## [15] "summit_2018"                       "cfdna_msk_2019"
## [17] "blca_bcan_hcrn_2022"               "nsclc_ctdx_msk_2022"
## [19] "thyroid_mskcc_2016"                "skcm_mskcc_2014"
## [21] "tmb_mskcc_2018"                    "rectal_msk_2019"
## [23] "skcm_tcga_pub_2015"                "msk_spectrum_tme_2022"
## [25] "ucec_ccr_cfdna_msk_2022"           "paired_bladder_2022"
## [27] "mtnn_msk_2022"                     "pog570_bcgsc_2020"
## [29] "sarcoma_msk_2023"                  "bowel_colitis_msk_2022"
## [31] "luad_mskcc_2023_met_organotropism" "coad_silu_2022"
## [33] "paac_msk_jco_2023"
##
## $``n` must be a single number, not an integer `NA`.`
## [1] "msk_met_2021"
##
## $`Argument 1 must be a data frame or a named atomic vector.`
## [1] "makeanimpact_ccr_2023"
```

## Packaged data from `cBioDataPack()`

Now let’s look at the errors in the packaged datasets that are used for
`cBioDataPack`:

```
pack_errs <- system.file(
    "extdata", "pack", "err_pack_info.json",
    package = "cBioPortalData", mustWork = TRUE
)
err_pack_info <- fromJSON(pack_errs)
```

We can do the same for this data:

```
length(err_pack_info)
```

```
## [1] 5
```

```
lengths(err_pack_info)
```

```
##                                         more columns than column names
##                                                                     12
##                Frequency of NA values higher than the cutoff tolerance
##                                                                      5
## invalid class "ExperimentList" object: \n    Non-unique names provided
##                                                                      2
##                                                 non-character argument
##                                                                      2
##                                    'wget' call had nonzero exit status
##                                                                     13
```

We can get a list of all the errors present:

```
names(err_pack_info)
```

```
## [1] "more columns than column names"
## [2] "Frequency of NA values higher than the cutoff tolerance"
## [3] "invalid class \"ExperimentList\" object: \n    Non-unique names provided"
## [4] "non-character argument"
## [5] "'wget' call had nonzero exit status"
```

And finally the full list of errors:

```
err_pack_info
```

```
## $`more columns than column names`
##  [1] "ccrcc_utokyo_2013"                "gbm_cptac_2021"
##  [3] "luad_mskimpact_2021"              "mbl_dkfz_2017"
##  [5] "pan_origimed_2020"                "sarcoma_msk_2022"
##  [7] "bowel_colitis_msk_2022"           "prad_msk_mdanderson_2023"
##  [9] "brca_tcga_pan_can_atlas_2018"     "coadread_tcga_pan_can_atlas_2018"
## [11] "ov_tcga_pan_can_atlas_2018"       "sarc_tcga_pan_can_atlas_2018"
##
## $`Frequency of NA values higher than the cutoff tolerance`
## [1] "ihch_mskcc_2020"          "mixed_selpercatinib_2020"
## [3] "ucec_ccr_msk_2022"        "mixed_msk_tcga_2021"
## [5] "ihch_msk_2021"
##
## $`invalid class "ExperimentList" object: \n    Non-unique names provided`
## [1] "mpnst_mskcc"   "stad_tcga_pub"
##
## $`non-character argument`
## [1] "pcpg_tcga_pub"  "mbn_mdacc_2013"
##
## $`'wget' call had nonzero exit status`
##  [1] "braf_msk_impact_2024"  "braf_msk_archer_2024"  "prostate_msk_2024"
##  [4] "pcnsl_msk_2024"        "pdac_msk_2024"         "ucs_msk_2024"
##  [7] "asclc_msk_2024"        "lms_msk_2024"          "crc_orion_2024"
## [10] "brca_aurora_2023"      "hcc_msk_2024"          "pancreas_msk_2024"
## [13] "pancan_mimsi_msk_2024"
```

# sessionInfo

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
##  [1] jsonlite_2.0.0              survminer_0.5.1
##  [3] ggpubr_0.6.2                ggplot2_4.0.0
##  [5] survival_3.8-3              cBioPortalData_2.22.1
##  [7] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0               IRanges_2.44.0
## [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [15] generics_0.1.4              MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0           AnVIL_1.22.0
## [19] AnVILBase_1.4.0             dplyr_1.1.4
## [21] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] GCPtools_1.0.0            splines_4.5.1
##   [3] later_1.4.4               BiocIO_1.20.0
##   [5] bitops_1.0-9              filelock_1.0.3
##   [7] tibble_3.3.0              RaggedExperiment_1.34.0
##   [9] XML_3.99-0.20             lifecycle_1.0.4
##  [11] httr2_1.2.1               rstatix_0.7.3
##  [13] processx_3.8.6            lattice_0.22-7
##  [15] backports_1.5.0           magrittr_2.0.4
##  [17] sass_0.4.10               rmarkdown_2.30
##  [19] jquerylib_0.1.4           yaml_2.3.10
##  [21] httpuv_1.6.16             otel_0.2.0
##  [23] chromote_0.5.1            DBI_1.2.3
##  [25] RColorBrewer_1.1-3        abind_1.4-8
##  [27] rvest_1.0.5               purrr_1.2.0
##  [29] RCurl_1.98-1.17           rappdirs_0.3.3
##  [31] RTCGAToolbox_2.40.0       KMsurv_0.1-6
##  [33] commonmark_2.0.0          codetools_0.2-20
##  [35] DelayedArray_0.36.0       DT_0.34.0
##  [37] ggtext_0.1.2              xml2_1.4.1
##  [39] tidyselect_1.2.1          futile.logger_1.4.3
##  [41] UCSC.utils_1.6.0          farver_2.1.2
##  [43] BiocFileCache_3.0.0       GenomicAlignments_1.46.0
##  [45] Formula_1.2-5             tools_4.5.1
##  [47] Rcpp_1.1.0                glue_1.8.0
##  [49] GenomicDataCommons_1.34.1 gridExtra_2.3
##  [51] SparseArray_1.10.1        BiocBaseUtils_1.12.0
##  [53] xfun_0.54                 GenomeInfoDb_1.46.0
##  [55] websocket_1.4.4           withr_3.0.2
##  [57] formatR_1.14              BiocManager_1.30.26
##  [59] fastmap_1.2.0             litedown_0.8
##  [61] digest_0.6.37             R6_2.6.1
##  [63] mime_0.13                 dichromat_2.0-0.1
##  [65] markdown_2.0              RSQLite_2.4.3
##  [67] cigarillo_1.0.0           utf8_1.2.6
##  [69] tidyr_1.3.1               data.table_1.17.8
##  [71] rtracklayer_1.70.0        httr_1.4.7
##  [73] htmlwidgets_1.6.4         S4Arrays_1.10.0
##  [75] RJSONIO_2.0.0             pkgconfig_2.0.3
##  [77] gtable_0.3.6              blob_1.2.4
##  [79] S7_0.2.0                  XVector_0.50.0
##  [81] survMisc_0.5.6            htmltools_0.5.8.1
##  [83] carData_3.0-5             bookdown_0.45
##  [85] scales_1.4.0              rapiclient_0.1.8
##  [87] png_0.1-8                 knitr_1.50
##  [89] km.ci_0.5-6               lambda.r_1.2.4
##  [91] tzdb_0.5.0                rjson_0.2.23
##  [93] curl_7.0.0                cachem_1.1.0
##  [95] zoo_1.8-14                stringr_1.6.0
##  [97] parallel_4.5.1            miniUI_0.1.2
##  [99] AnnotationDbi_1.72.0      restfulr_0.0.16
## [101] pillar_1.11.1             grid_4.5.1
## [103] vctrs_0.6.5               promises_1.5.0
## [105] car_3.1-3                 dbplyr_2.5.1
## [107] xtable_1.8-4              evaluate_1.0.5
## [109] magick_2.9.0              readr_2.1.5
## [111] tinytex_0.57              GenomicFeatures_1.62.0
## [113] cli_3.6.5                 compiler_4.5.1
## [115] futile.options_1.0.1      Rsamtools_2.26.0
## [117] rlang_1.1.6               crayon_1.5.3
## [119] ggsignif_0.6.4            labeling_0.4.3
## [121] ps_1.9.1                  stringi_1.8.7
## [123] BiocParallel_1.44.0       Biostrings_2.78.0
## [125] Matrix_1.7-4              hms_1.1.4
## [127] bit64_4.6.0-1             KEGGREST_1.50.0
## [129] shiny_1.11.1              gridtext_0.1.5
## [131] broom_1.0.10              memoise_2.0.1
## [133] bslib_0.9.0               bit_4.6.0
## [135] TCGAutils_1.30.0
```