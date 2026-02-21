# cBioPortalData: User Guide

Marcel Ramos & Levi Waldron

#### November 09, 2025

# Contents

* [Installation](#installation)
* [Introduction](#introduction)
* [Citations](#citations)
  + [Overview](#overview)
    - [Data Structures](#data-structures)
    - [Identifying available studies](#identifying-available-studies)
    - [Choosing download method](#choosing-download-method)
  + [Two main functions](#two-main-functions)
    - [cBioDataPack: Obtain Study Data as Zipped Tarballs](#cbiodatapack-obtain-study-data-as-zipped-tarballs)
    - [cBioPortalData: Obtain data from the cBioPortal API](#cbioportaldata-obtain-data-from-the-cbioportal-api)
  + [Considerations](#considerations)
    - [metadata](#metadata)
    - [Build prompts](#build-prompts)
    - [Manual downloads](#manual-downloads)
  + [Clearing the cache](#clearing-the-cache)
    - [cBioDataPack](#cbiodatapack)
    - [cBioPortalData](#cbioportaldata)
  + [Example Analysis: Kaplan-Meier Plot](#example-analysis-kaplan-meier-plot)
    - [Data update requests](#data-update-requests)
* [sessionInfo](#sessioninfo)
* [References](#references)

# Installation

```
library(cBioPortalData)
library(AnVIL)
```

# Introduction

The cBioPortal for Cancer Genomics [website](https://cbioportal.org) is a great
resource for interactive exploration of study datasets. However, it does not
easily allow the analyst to obtain and further analyze the data.

We’ve developed the `cBioPortalData` package to fill this need to
programmatically access the data resources available on the cBioPortal.

The `cBioPortalData` package provides an R interface for accessing the
cBioPortal study data within the Bioconductor ecosystem.

It downloads study data from the cBioPortal API (the full API specification can
be found here <https://cbioportal.org/api>) and uses Bioconductor infrastructure
to cache and represent the data.

We demonstrate common use cases of `cBioPortalData` and `curatedTCGAData`
during Bioconductor conference
[workshops](https://waldronlab.io/MultiAssayWorkshop/).

We use the `MultiAssayExperiment` (Ramos et al. [2017](#ref-Ramos2017-og)) package to integrate,
represent, and coordinate multiple experiments for the studies available in the
cBioPortal. This package in conjunction with `curatedTCGAData` give access to
a large trove of publicly available bioinformatic data. Please see our
JCO Clinical Cancer Informatics publication (Ramos et al. [2020](#ref-Ramos2020-ya)).

# Citations

Our free and open source project depends on citations for funding. When using
`cBioPortalData`, please cite the following publications:

```
citation("MultiAssayExperiment")
citation("cBioPortalData")
```

## Overview

### Data Structures

Data are provided as a single `MultiAssayExperiment` per study. The
`MultiAssayExperiment` representation usually contains `SummarizedExperiment`
objects for expression data and `RaggedExperiment` objects for mutation and
CNV-type data. `RaggedExperiment` is a data class for representing ‘ragged’
genomic location data, meaning that the measurements per sample vary.

For more information, please see the `RaggedExperiment` and
`SummarizedExperiment` vignettes.

### Identifying available studies

As we work through the data, there are some datasest that cannot be represented
as `MultiAssayExperiment` objects. This can be due to a number of reasons such
as the way the data is handled, presence of mis-matched identifiers, invalid
data types, etc. To see what datasets are currently not building, we can
look refer to `getStudies()` with the `buildReport = TRUE` argument.

```
cbio <- cBioPortal()
studies <- getStudies(cbio, buildReport = TRUE)
head(studies)
```

```
## # A tibble: 6 × 15
##   name           description publicStudy pmid  citation groups status importDate
##   <chr>          <chr>       <lgl>       <chr> <chr>    <chr>   <int> <chr>
## 1 Ewing Sarcoma… "Whole-gen… TRUE        2522… Tirode … "PUBL…      0 2025-06-0…
## 2 Kidney Renal … "Whole-exo… TRUE        2379… TCGA, N… "PUBL…      0 2024-12-2…
## 3 Diffuse Large… "Whole-exo… TRUE        2971… Chapuy … "PUBL…      0 2025-06-0…
## 4 Kidney Renal … "TCGA Kidn… TRUE        <NA>  <NA>     "PUBL…      0 2024-12-1…
## 5 Adenoid Cysti… "Targeted … TRUE        2441… Ross et… "ACYC…      0 2024-12-0…
## 6 Lung Cancer i… "Whole-gen… TRUE        3449… Zhang e… ""          0 2025-06-0…
## # ℹ 7 more variables: allSampleCount <int>, readPermission <lgl>,
## #   studyId <chr>, cancerTypeId <chr>, referenceGenome <chr>, api_build <lgl>,
## #   pack_build <lgl>
```

The last two columns will show the availability of each `studyId` for
either download method (`pack_build` for `cBioDataPack` and `api_build` for
`cBioPortalData`).

### Choosing download method

There are two main user-facing functions for downloading data from the
cBioPortal API.

* `cBioDataPack` makes use of the tarball distribution of study data. This is
  useful when the user wants to download and analyze the entirety of the data as
  available from the cBioPortal.org website.
* `cBioPortalData` allows a more flexibile approach to obtaining study data
  based on the available parameters such as molecular profile identifiers. This
  option is useful for users who have a set of gene symbols or identifiers and
  would like to get a smaller subset of the data that correspond to a particular
  molecular profile.

## Two main functions

### cBioDataPack: Obtain Study Data as Zipped Tarballs

This function will access the packaged data from
<https://cbioportal.org/datasets> and return an integrative
`MultiAssayExperiment` representation.

```
## Use ask=FALSE for non-interactive use
laml <- cBioDataPack("laml_tcga", ask = FALSE)
```

```
laml
```

```
## A MultiAssayExperiment object of 12 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 12:
##  [1] cna: SummarizedExperiment with 24776 rows and 191 columns
##  [2] cna_hg19.seg: RaggedExperiment with 13571 rows and 191 columns
##  [3] linear_cna: SummarizedExperiment with 24776 rows and 191 columns
##  [4] methylation_hm27: SummarizedExperiment with 10968 rows and 194 columns
##  [5] methylation_hm450: SummarizedExperiment with 10968 rows and 194 columns
##  [6] mrna_seq_rpkm: SummarizedExperiment with 19720 rows and 179 columns
##  [7] mrna_seq_rpkm_zscores_ref_all_samples: SummarizedExperiment with 19720 rows and 179 columns
##  [8] mrna_seq_rpkm_zscores_ref_diploid_samples: SummarizedExperiment with 19719 rows and 179 columns
##  [9] mrna_seq_v2_rsem: SummarizedExperiment with 20531 rows and 173 columns
##  [10] mrna_seq_v2_rsem_zscores_ref_all_samples: SummarizedExperiment with 20531 rows and 173 columns
##  [11] mrna_seq_v2_rsem_zscores_ref_diploid_samples: SummarizedExperiment with 20440 rows and 173 columns
##  [12] mutations: RaggedExperiment with 2584 rows and 197 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

### cBioPortalData: Obtain data from the cBioPortal API

This function provides a more flexible and granular way to request a
`MultiAssayExperiment` object from a study ID, molecular profile, set of genes,
and a sample list.

In this example, we will obtain data from the Adrenocortical carcinoma (ACC;
`acc_tcga`) study. The list of `genes` below are based on potential driving
alterations including amplifications, deletions, and point mutations. Also
included are a set of genes known to initiate familial syndromes including
adrenocortical neoplasms as described in Zheng et al. ([2016](#ref-Zheng2016-au)).

```
acc <- cBioPortalData(
    api = cbio,
    by = "hugoGeneSymbol",
    studyId = "acc_tcga",
    genes = c(
        "TERT", "TERF2", "CDK4", "ZNRF3", "CDKN2A", "RB1", "RPL22",
        "TP53", "CTNNB1", "PRKAR1A", "MEN1"
    ),
    molecularProfileIds = c("acc_tcga_linear_CNA", "acc_tcga_mutations"),
)
```

```
## harmonizing input:
##   removing 1 colData rownames not in sampleMap 'primary'
```

```
acc
```

```
## A MultiAssayExperiment object of 2 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 2:
##  [1] acc_tcga_mutations: RangedSummarizedExperiment with 54 rows and 37 columns
##  [2] acc_tcga_linear_CNA: SummarizedExperiment with 11 rows and 90 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

Note. To avoid overloading the API service, the API was designed to only query
a part of the study data. Therefore, the user is required to enter either a set
of genes of interest or a gene panel identifier.

## Considerations

Note that `cBioPortalData` and `cBioDataPack` obtain data diligently curated
by the cBio Portal data team. The original data and curation lies in the
<https://github.com/cBioPortal/cBioPortal> GitHub repository. However, despite
the curation efforts there may be some inconsistencies in identifiers
in the data. This causes our software to not work as intended though we have
made efforts to represent all the data from both API and tarball formats.

### metadata

You may notice that the `metadata()` may have some additional data that was
not able to be integrated in the `MultiAssayExperiment`.

```
metadata(acc)
```

```
## [[1]]
## # A tibble: 62 × 22
##    uniqueSampleKey    uniquePatientKey molecularProfileId patientId entrezGeneId
##    <chr>              <chr>            <chr>              <chr>            <int>
##  1 VENHQS1PUi1BNUoyL… VENHQS1PUi1BNUo… acc_tcga_mutations TCGA-OR-…         1499
##  2 VENHQS1PUi1BNUoyL… VENHQS1PUi1BNUo… acc_tcga_mutations TCGA-OR-…         7157
##  3 VENHQS1PUi1BNUozL… VENHQS1PUi1BNUo… acc_tcga_mutations TCGA-OR-…         5573
##  4 VENHQS1PUi1BNUo1L… VENHQS1PUi1BNUo… acc_tcga_mutations TCGA-OR-…         4221
##  5 VENHQS1PUi1BNUo1L… VENHQS1PUi1BNUo… acc_tcga_mutations TCGA-OR-…         6146
##  6 VENHQS1PUi1BNUo1L… VENHQS1PUi1BNUo… acc_tcga_mutations TCGA-OR-…         7157
##  7 VENHQS1PUi1BNUo1L… VENHQS1PUi1BNUo… acc_tcga_mutations TCGA-OR-…        84133
##  8 VENHQS1PUi1BNUo4L… VENHQS1PUi1BNUo… acc_tcga_mutations TCGA-OR-…         7157
##  9 VENHQS1PUi1BNUpBL… VENHQS1PUi1BNUp… acc_tcga_mutations TCGA-OR-…         4221
## 10 VENHQS1PUi1BNUpBL… VENHQS1PUi1BNUp… acc_tcga_mutations TCGA-OR-…         5573
## # ℹ 52 more rows
## # ℹ 17 more variables: studyId <chr>, center <chr>, mutationStatus <chr>,
## #   validationStatus <chr>, tumorAltCount <int>, tumorRefCount <int>,
## #   normalAltCount <int>, normalRefCount <int>, referenceAllele <chr>,
## #   proteinChange <chr>, variantType <chr>, keyword <chr>, variantAllele <chr>,
## #   refseqMrnaId <chr>, proteinPosStart <int>, proteinPosEnd <int>, type <chr>
##
## [[2]]
## # A tibble: 990 × 7
##    uniqueSampleKey    uniquePatientKey entrezGeneId molecularProfileId patientId
##    <chr>              <chr>                   <int> <chr>              <chr>
##  1 VENHQS1PUi1BNUoxL… VENHQS1PUi1BNUo…         5573 acc_tcga_linear_C… TCGA-OR-…
##  2 VENHQS1PUi1BNUoxL… VENHQS1PUi1BNUo…         4221 acc_tcga_linear_C… TCGA-OR-…
##  3 VENHQS1PUi1BNUoxL… VENHQS1PUi1BNUo…         5925 acc_tcga_linear_C… TCGA-OR-…
##  4 VENHQS1PUi1BNUoxL… VENHQS1PUi1BNUo…         6146 acc_tcga_linear_C… TCGA-OR-…
##  5 VENHQS1PUi1BNUoxL… VENHQS1PUi1BNUo…         7014 acc_tcga_linear_C… TCGA-OR-…
##  6 VENHQS1PUi1BNUoxL… VENHQS1PUi1BNUo…         7015 acc_tcga_linear_C… TCGA-OR-…
##  7 VENHQS1PUi1BNUoxL… VENHQS1PUi1BNUo…         7157 acc_tcga_linear_C… TCGA-OR-…
##  8 VENHQS1PUi1BNUoxL… VENHQS1PUi1BNUo…        84133 acc_tcga_linear_C… TCGA-OR-…
##  9 VENHQS1PUi1BNUoxL… VENHQS1PUi1BNUo…         1019 acc_tcga_linear_C… TCGA-OR-…
## 10 VENHQS1PUi1BNUoxL… VENHQS1PUi1BNUo…         1029 acc_tcga_linear_C… TCGA-OR-…
## # ℹ 980 more rows
## # ℹ 2 more variables: studyId <chr>, type <chr>
```

### Build prompts

You will also get a message for `studyId`s whose data has not been fully
integrated into a `MultiAssayExperiment`.

```
## Our testing shows that '%s' is not currently building.
##    Use 'downloadStudy()' to manually obtain the data.
##    Proceed anyway? [y/n]: y
```

### Manual downloads

For this reason, we have also provided the `downloadStudy`, `untarStudy`, and
`loadStudy` functions to allow researchers to simply download the data and
potentially, manually curate it. Generally, we advise researchers to report
inconsistencies in the data in the cBioPortal [data repository](https://github.com/cbioportal/datahub).

## Clearing the cache

### cBioDataPack

In cases where a download is interrupted, the user may experience a corrupt
cache. The user can clear the cache for a particular study by using the
`removeCache` function. Note that this function only works for data downloaded
through the `cBioDataPack` function.

```
removeCache("laml_tcga")
```

### cBioPortalData

For users who wish to clear the entire `cBioPortalData` cache, it is
recommended that they use:

```
unlink("~/.cache/cBioPortalData/")
```

## Example Analysis: Kaplan-Meier Plot

We can use information in the `colData` to draw a K-M plot with a few
variables from the `colData` slot of the `MultiAssayExperiment`. First, we load
the necessary packages:

```
library(survival)
library(survminer)
```

We can check the data to lookout for any issues.

```
table(colData(laml)$OS_STATUS)
```

```
##
##   0:LIVING 1:DECEASED
##         67        133
```

```
class(colData(laml)$OS_MONTHS)
```

```
## [1] "character"
```

Now, we clean the data a bit to ensure that our variables are of the right type
for the subsequent survival model fit.

```
collaml <- colData(laml)
collaml[collaml$OS_MONTHS == "[Not Available]", "OS_MONTHS"] <- NA
collaml$OS_MONTHS <- as.numeric(collaml$OS_MONTHS)
colData(laml) <- collaml
```

We specify a simple survival model using `SEX` as a covariate and we draw
the K-M plot.

```
fit <- survfit(
    Surv(OS_MONTHS, as.numeric(substr(OS_STATUS, 1, 1))) ~ SEX,
    data = colData(laml)
)
ggsurvplot(fit, data = colData(laml), risk.table = TRUE)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the ggpubr package.
##   Please report the issue at <https://github.com/kassambara/ggpubr/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Ignoring unknown labels:
## • colour : "Strata"
```

![](data:image/png;base64...)

### Data update requests

If you are interested in a particular study dataset that is not currently
building, please open an issue at our [GitHub repository](https://github.com/waldronlab/cBioPortalData/issues) and we will do our
best to resolve the issues with the code base. Data issues can be opened at
the cBioPortal [data repository](https://github.com/cbioportal/datahub).

We appreciate your feedback!

# sessionInfo

Click to see session info

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
##  [1] survminer_0.5.1             ggpubr_0.6.2
##  [3] ggplot2_4.0.0               survival_3.8-3
##  [5] cBioPortalData_2.22.1       MultiAssayExperiment_1.36.0
##  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [11] IRanges_2.44.0              S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0         generics_0.1.4
## [15] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [17] AnVIL_1.22.0                AnVILBase_1.4.0
## [19] dplyr_1.1.4                 BiocStyle_2.38.0
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
##  [45] jsonlite_2.0.0            Formula_1.2-5
##  [47] tools_4.5.1               Rcpp_1.1.0
##  [49] glue_1.8.0                GenomicDataCommons_1.34.1
##  [51] gridExtra_2.3             SparseArray_1.10.1
##  [53] BiocBaseUtils_1.12.0      xfun_0.54
##  [55] GenomeInfoDb_1.46.0       websocket_1.4.4
##  [57] withr_3.0.2               formatR_1.14
##  [59] BiocManager_1.30.26       fastmap_1.2.0
##  [61] litedown_0.8              digest_0.6.37
##  [63] R6_2.6.1                  mime_0.13
##  [65] dichromat_2.0-0.1         markdown_2.0
##  [67] RSQLite_2.4.3             cigarillo_1.0.0
##  [69] utf8_1.2.6                tidyr_1.3.1
##  [71] data.table_1.17.8         rtracklayer_1.70.0
##  [73] httr_1.4.7                htmlwidgets_1.6.4
##  [75] S4Arrays_1.10.0           RJSONIO_2.0.0
##  [77] pkgconfig_2.0.3           gtable_0.3.6
##  [79] blob_1.2.4                S7_0.2.0
##  [81] XVector_0.50.0            survMisc_0.5.6
##  [83] htmltools_0.5.8.1         carData_3.0-5
##  [85] bookdown_0.45             scales_1.4.0
##  [87] rapiclient_0.1.8          png_0.1-8
##  [89] knitr_1.50                km.ci_0.5-6
##  [91] lambda.r_1.2.4            tzdb_0.5.0
##  [93] rjson_0.2.23              curl_7.0.0
##  [95] cachem_1.1.0              zoo_1.8-14
##  [97] stringr_1.6.0             parallel_4.5.1
##  [99] miniUI_0.1.2              AnnotationDbi_1.72.0
## [101] restfulr_0.0.16           pillar_1.11.1
## [103] grid_4.5.1                vctrs_0.6.5
## [105] promises_1.5.0            car_3.1-3
## [107] dbplyr_2.5.1              xtable_1.8-4
## [109] evaluate_1.0.5            magick_2.9.0
## [111] readr_2.1.5               tinytex_0.57
## [113] GenomicFeatures_1.62.0    cli_3.6.5
## [115] compiler_4.5.1            futile.options_1.0.1
## [117] Rsamtools_2.26.0          rlang_1.1.6
## [119] crayon_1.5.3              ggsignif_0.6.4
## [121] labeling_0.4.3            ps_1.9.1
## [123] stringi_1.8.7             BiocParallel_1.44.0
## [125] Biostrings_2.78.0         Matrix_1.7-4
## [127] hms_1.1.4                 bit64_4.6.0-1
## [129] KEGGREST_1.50.0           shiny_1.11.1
## [131] gridtext_0.1.5            broom_1.0.10
## [133] memoise_2.0.1             bslib_0.9.0
## [135] bit_4.6.0                 TCGAutils_1.30.0
```

# References

Ramos, Marcel, Ludwig Geistlinger, Sehyun Oh, Lucas Schiffer, Rimsha Azhar, Hanish Kodali, Ino de Bruijn, et al. 2020. “Multiomic Integration of Public Oncology Databases in Bioconductor.” *JCO Clin Cancer Inform* 4: 958–71. <https://doi.org/10.1200/CCI.19.00119>.

Ramos, Marcel, Lucas Schiffer, Angela Re, Rimsha Azhar, Azfar Basunia, Carmen Rodriguez, Tiffany Chan, et al. 2017. “Software for the Integration of Multiomics Experiments in Bioconductor.” *Cancer Res.* 77 (21): e39–e42. <https://doi.org/10.1158/0008-5472.CAN-17-0344>.

Zheng, Siyuan, Andrew D Cherniack, Ninad Dewal, Richard A Moffitt, Ludmila Danilova, Bradley A Murray, Antonio M Lerario, et al. 2016. “Comprehensive Pan-Genomic Characterization of Adrenocortical Carcinoma.” *Cancer Cell* 29 (5): 723–36. <https://doi.org/10.1016/j.ccell.2016.04.002>.