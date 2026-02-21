# Breast survival dataset using network from STRING DB

André Veríssimo

#### 2025-10-30

# Contents

* [1 Instalation](#instalation)
* [2 Required Packages](#required-packages)
* [3 Overview](#overview)
  + [3.1 Download Data from STRING](#download-data-from-string)
* [4 Build network matrix](#build-network-matrix)
* [5 Network Statistics](#network-statistics)
  + [5.1 Graph information](#graph-information)
  + [5.2 Summary of degree *(indegree + outdegree)*](#summary-of-degree-indegree-outdegree)
  + [5.3 Histogram of degree *(up until 99.999% quantile)*](#histogram-of-degree-up-until-99.999-quantile)
* [6 `glmSparseNet`](#glmsparsenet)
  + [6.1 Select balanced folds for cross-validation](#select-balanced-folds-for-cross-validation)
  + [6.2 glmHub model](#glmhub-model)
  + [6.3 glmOrphan model](#glmorphan-model)
  + [6.4 Elastic Net model *(without network-penalization)*](#elastic-net-model-without-network-penalization)
  + [6.5 Selected genes](#selected-genes)
* [7 Session Info](#session-info)

# 1 Instalation

```
if (!require("BiocManager")) {
    install.packages("BiocManager")
}
BiocManager::install("glmSparseNet")
```

# 2 Required Packages

```
library(dplyr)
library(Matrix)
library(ggplot2)
library(forcats)
library(parallel)
library(reshape2)
library(survival)
library(VennDiagram)
library(futile.logger)
library(curatedTCGAData)
library(MultiAssayExperiment)
library(TCGAutils)
#
library(glmSparseNet)
#
#
# Some general options for futile.logger the debugging package
flog.layout(layout.format("[~l] ~m"))
options(
    "glmSparseNet.show_message" = FALSE,
    "glmSparseNet.base_dir" = withr::local_tempdir()
)
# Setting ggplot2 default theme as minimal
theme_set(ggplot2::theme_minimal())
```

# 3 Overview

This vignette uses the STRING database (<https://string-db.org/>) of
protein-protein interactions as the network-based penalizer in generalized
linear models using Breast invasive carcinoma sample dataset.

The degree vector is calculated manually to account for genes that are not
present in the STRING database, as these will not have any interactions,
i.e. edges.

## 3.1 Download Data from STRING

Retrieve all interactions from [STRING databse](https://string-db.org/).
We have included a helper function that retrieves the Homo sapiens known
interactions.

For this vignette, we use a cached version of all interaction with
`score_threshold = 700`

*Note*: Text-based interactions are excluded from the network.

```
# Not evaluated in vignette as it takes too long to download and process
allInteractions700 <- stringDBhomoSapiens(scoreThreshold = 700)
stringNetwork <- buildStringNetwork(allInteractions700, "external")
```

# 4 Build network matrix

Build a sparse matrix object that contains the network.

```
stringNetworkUndirected <- stringNetwork + Matrix::t(stringNetwork)
stringNetworkUndirected <- (stringNetworkUndirected != 0) * 1
```

# 5 Network Statistics

## 5.1 Graph information

```
## [INFO] Directed graph (score_threshold = 700)
## [INFO]   *       total edges: 225330
## [INFO]   *    unique protein: 11033
## [INFO]   * edges per protein: 20.423276
## [INFO]
## [INFO] Undirected graph (score_threshold = 700)
## [INFO]   *       total edges: 225209
## [INFO]   *    unique protein: 11033
## [INFO]   * edges per protein: 20.412309
```

## 5.2 Summary of degree *(indegree + outdegree)*

```
## [INFO] Summary of degree:
##
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##    1.00    3.00   13.00   40.82   43.00 4175.00
```

## 5.3 Histogram of degree *(up until 99.999% quantile)*

```
qplot(
    degreeNetworkVector[
        degreeNetworkVector <= quantile(degreeNetworkVector, probs = .99999)
    ],
    geom = "histogram", fill = my.colors(2), bins = 100
) +
    theme(legend.position = "none") + xlab("Degree (up until 99.999% quantile)")
```

![](data:image/png;base64...)

# 6 `glmSparseNet`

* Dataset from curatedTCGAdata

```
brca <- curatedTCGAData(
    diseaseCode = "BRCA", assays = "RNASeq2GeneNorm",
    version = "1.1.38", dry.run = FALSE
)
```

Build the survival data from the clinical columns.

* Selects only primary solid tumour samples
* Merge survival times for patients, which have different columns in case they
  are alive or dead.
* Build two matrix objects that fit the data `xdata` and `ydata`

```
# keep only solid tumour (code: 01)
brcaPrimarySolidTumor <- TCGAutils::TCGAsplitAssays(brca, "01")
xdataRaw <- t(assay(brcaPrimarySolidTumor[[1]]))

# Get survival information
ydataRaw <- colData(brcaPrimarySolidTumor) |>
    as.data.frame() |>
    # Convert days to integer
    dplyr::mutate(
        Days.to.date.of.Death = as.integer(Days.to.date.of.Death),
        Days.to.Last.Contact  = as.integer(Days.to.Date.of.Last.Contact)
    ) |>
    # Find max time between all days (ignoring missings)
    dplyr::rowwise() |>
    dplyr::mutate(
        time = max(days_to_last_followup, Days.to.date.of.Death,
            Days.to.Last.Contact, days_to_death,
            na.rm = TRUE
        )
    ) |>
    # Keep only survival variables and codes
    dplyr::select(patientID, status = vital_status, time) |>
    # Discard individuals with survival time less or equal to 0
    dplyr::filter(!is.na(time) & time > 0) |>
    as.data.frame()

# Set index as the patientID
rownames(ydataRaw) <- ydataRaw$patientID

# keep only features that are in degreeNetworkVector and have
#  standard deviation > 0
validFeatures <- colnames(xdataRaw)[
    colnames(xdataRaw) %in% names(degreeNetworkVector[degreeNetworkVector > 0])
]
xdataRaw <- xdataRaw[
    TCGAbarcode(rownames(xdataRaw)) %in% rownames(ydataRaw), validFeatures
]
xdataRaw <- scale(xdataRaw)

# Order ydata the same as assay
ydataRaw <- ydataRaw[TCGAbarcode(rownames(xdataRaw)), ]

# Using only a subset of genes previously selected to keep this short example.
set.seed(params$seed)
smallSubset <- c(
    "AAK1", "ADRB1", "AK7", "ALK", "APOBEC3F", "ARID1B", "BAMBI",
    "BRAF", "BTG1", "CACNG8", "CASP12", "CD5", "CDA", "CEP72",
    "CPD", "CSF2RB", "CSN3", "DCT", "DLG3", "DLL3", "DPP4",
    "DSG1", "EDA2R", "ERP27", "EXD1", "GABBR2", "GADD45A",
    "GBP1", "HTR1F", "IFNK", "IRF2", "IYD", "KCNJ11", "KRTAP5-6",
    "MAFA", "MAGEB4", "MAP2K6", "MCTS1", "MMP15", "MMP9",
    "NFKBIA", "NLRC4", "NT5C1A", "OPN4", "OR13C5", "OR13C8",
    "OR2T6", "OR4K2", "OR52E6", "OR5D14", "OR5H1", "OR6C4",
    "OR7A17", "OR8J3", "OSBPL1A", "PAK6", "PDE11A", "PELO",
    "PGK1", "PIK3CB", "PMAIP1", "POLR2B", "POP1", "PPFIA3",
    "PSME1", "PSME2", "PTEN", "PTGES3", "QARS", "RABGAP1",
    "RBM3", "RFC3", "RGPD8", "RPGRIP1L", "SAV1", "SDC1", "SDC3",
    "SEC16B", "SFPQ", "SFRP5", "SIPA1L1", "SLC2A14", "SLC6A9",
    "SPATA5L1", "SPINT1", "STAR", "STXBP5", "SUN3", "TACC2",
    "TACR1", "TAGLN2", "THPO", "TNIP1", "TP53", "TRMT2B", "TUBB1",
    "VDAC1", "VSIG8", "WNT3A", "WWOX", "XRCC4", "YME1L1",
    "ZBTB11", "ZSCAN21"
) |>
    sample(size = 50) |>
    sort()

# make sure we have 100 genes
smallSubset <- c(smallSubset, sample(colnames(xdataRaw), 51)) |>
    unique() |>
    sort()

xdata <- xdataRaw[, smallSubset[smallSubset %in% colnames(xdataRaw)]]
ydata <- ydataRaw |>
    dplyr::select(time, status) |>
    dplyr::filter(!is.na(time) | time < 0)
```

* Build dataset that overlaps with STRING data

```
#
# Add degree 0 to genes not in STRING network

myDegree <- degreeNetworkVector[smallSubset]
myString <- stringNetworkBinary[smallSubset, smallSubset]
```

Degree distribution for sample set of gene features *(in xdata)*.

![](data:image/png;base64...)

## 6.1 Select balanced folds for cross-validation

```
set.seed(params$seed)
foldid <- glmSparseNet:::balancedCvFolds(ydata$status)$output
```

## 6.2 glmHub model

Penalizes using the Hub heuristics, see `hubHeuristic` function definition for
more details.

```
resultCVHub <- cv.glmHub(xdata,
    Surv(ydata$time, ydata$status),
    family = "cox",
    foldid = foldid,
    network = myString,
    network.options = networkOptions(minDegree = 0.2)
)
```

Kaplan-Meier estimator separating individuals by low and high risk *(based on
model’s coefficients)*

```
## Warning: The `plot.title` argument of `separate2GroupsCox()` is deprecated as of
## glmSparseNet 1.21.0.
## ℹ Please use the `plotTitle` argument instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `legend.outside` argument of `separate2GroupsCox()` is deprecated as of
## glmSparseNet 1.21.0.
## ℹ Please use the `legendOutside` argument instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## $pvalue
## [1] 9.628346e-05
##
## $plot
```

![](data:image/png;base64...)

```
##
## $km
## Call: survfit(formula = survival::Surv(time, status) ~ group, data = prognosticIndexDf)
##
##                 n events median 0.95LCL 0.95UCL
## Low risk - 1  983    129   3959    3738    7455
## High risk - 1  97     23   2911    2469      NA
```

## 6.3 glmOrphan model

Penalizes using the Orphan heuristics, see `orphanHeuristic` function
definition for more details.

```
resultCVOrphan <- cv.glmOrphan(xdata,
    Surv(ydata$time, ydata$status),
    family = "cox",
    foldid = foldid,
    network = myString,
    network.options = networkOptions(minDegree = 0.2)
)
```

Kaplan-Meier estimator separating individuals by low and high risk
*(based on model’s coefficients)*

```
## $pvalue
## [1] 0
##
## $plot
```

![](data:image/png;base64...)

```
##
## $km
## Call: survfit(formula = survival::Surv(time, status) ~ group, data = prognosticIndexDf)
##
##                 n events median 0.95LCL 0.95UCL
## Low risk - 1  540     34   7455    6456      NA
## High risk - 1 540    118   2866    2573    3472
```

## 6.4 Elastic Net model *(without network-penalization)*

Uses regular glmnet model as simple baseline

```
library(glmnet)
```

```
## Loaded glmnet 4.1-10
```

```
resultCVGlmnet <- cv.glmnet(xdata,
    Surv(ydata$time, ydata$status),
    family = "cox",
    foldid = foldid
)
```

Kaplan-Meier estimator separating individuals by low and high risk
*(based on model’s coefficients)*

```
## $pvalue
## [1] 0
##
## $plot
```

![](data:image/png;base64...)

```
##
## $km
## Call: survfit(formula = survival::Surv(time, status) ~ group, data = prognosticIndexDf)
##
##                 n events median 0.95LCL 0.95UCL
## Low risk - 1  540     38   6593    4398      NA
## High risk - 1 540    114   2854    2551    3461
```

## 6.5 Selected genes

Venn diagram of overlapping genes.

![](data:image/png;base64...)

Descriptive table showing which genes are selected in each model

We can observe, that elastic net without network-based penalization selects the
best model with 40% more genes than glmOrphan and glmHub, without loosing
accuracy.

*note*: size of circles represent the degree of that gene in network.

![](data:image/png;base64...)

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
##  [1] grid      parallel  stats4    stats     graphics  grDevices utils
##  [8] datasets  methods   base
##
## other attached packages:
##  [1] glmnet_4.1-10               VennDiagram_1.7.3
##  [3] reshape2_1.4.4              forcats_1.0.1
##  [5] Matrix_1.7-4                glmSparseNet_1.28.0
##  [7] TCGAutils_1.30.0            curatedTCGAData_1.31.3
##  [9] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0              GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0               IRanges_2.44.0
## [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [17] generics_0.1.4              MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0           futile.logger_1.4.3
## [21] survival_3.8-3              ggplot2_4.0.0
## [23] dplyr_1.1.4                 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
##   [3] shape_1.4.6.1             magrittr_2.0.4
##   [5] magick_2.9.0              GenomicFeatures_1.62.0
##   [7] farver_2.1.2              rmarkdown_2.30
##   [9] BiocIO_1.20.0             vctrs_0.6.5
##  [11] memoise_2.0.1             Rsamtools_2.26.0
##  [13] RCurl_1.98-1.17           rstatix_0.7.3
##  [15] tinytex_0.57              htmltools_0.5.8.1
##  [17] S4Arrays_1.10.0           BiocBaseUtils_1.12.0
##  [19] progress_1.2.3            AnnotationHub_4.0.0
##  [21] lambda.r_1.2.4            curl_7.0.0
##  [23] broom_1.0.10              Formula_1.2-5
##  [25] pROC_1.19.0.1             SparseArray_1.10.0
##  [27] sass_0.4.10               bslib_0.9.0
##  [29] plyr_1.8.9                httr2_1.2.1
##  [31] zoo_1.8-14                futile.options_1.0.1
##  [33] cachem_1.1.0              GenomicAlignments_1.46.0
##  [35] lifecycle_1.0.4           iterators_1.0.14
##  [37] pkgconfig_2.0.3           R6_2.6.1
##  [39] fastmap_1.2.0             digest_0.6.37
##  [41] AnnotationDbi_1.72.0      ps_1.9.1
##  [43] ExperimentHub_3.0.0       RSQLite_2.4.3
##  [45] ggpubr_0.6.2              labeling_0.4.3
##  [47] filelock_1.0.3            km.ci_0.5-6
##  [49] httr_1.4.7                abind_1.4-8
##  [51] compiler_4.5.1            bit64_4.6.0-1
##  [53] withr_3.0.2               S7_0.2.0
##  [55] backports_1.5.0           BiocParallel_1.44.0
##  [57] carData_3.0-5             DBI_1.2.3
##  [59] ggsignif_0.6.4            biomaRt_2.66.0
##  [61] rappdirs_0.3.3            DelayedArray_0.36.0
##  [63] rjson_0.2.23              tools_4.5.1
##  [65] chromote_0.5.1            otel_0.2.0
##  [67] glue_1.8.0                restfulr_0.0.16
##  [69] promises_1.4.0            checkmate_2.3.3
##  [71] gtable_0.3.6              KMsurv_0.1-6
##  [73] tzdb_0.5.0                tidyr_1.3.1
##  [75] survminer_0.5.1           websocket_1.4.4
##  [77] data.table_1.17.8         hms_1.1.4
##  [79] car_3.1-3                 xml2_1.4.1
##  [81] XVector_0.50.0            BiocVersion_3.22.0
##  [83] foreach_1.5.2             pillar_1.11.1
##  [85] stringr_1.5.2             later_1.4.4
##  [87] splines_4.5.1             BiocFileCache_3.0.0
##  [89] lattice_0.22-7            rtracklayer_1.70.0
##  [91] bit_4.6.0                 tidyselect_1.2.1
##  [93] Biostrings_2.78.0         knitr_1.50
##  [95] gridExtra_2.3             bookdown_0.45
##  [97] xfun_0.53                 stringi_1.8.7
##  [99] UCSC.utils_1.6.0          yaml_2.3.10
## [101] evaluate_1.0.5            codetools_0.2-20
## [103] cigarillo_1.0.0           tibble_3.3.0
## [105] BiocManager_1.30.26       cli_3.6.5
## [107] xtable_1.8-4              processx_3.8.6
## [109] jquerylib_0.1.4           survMisc_0.5.6
## [111] dichromat_2.0-0.1         Rcpp_1.1.0
## [113] GenomeInfoDb_1.46.0       GenomicDataCommons_1.34.0
## [115] dbplyr_2.5.1              png_0.1-8
## [117] XML_3.99-0.19             readr_2.1.5
## [119] blob_1.2.4                prettyunits_1.2.0
## [121] bitops_1.0-9              scales_1.4.0
## [123] purrr_1.1.0               crayon_1.5.3
## [125] rlang_1.1.6               KEGGREST_1.50.0
## [127] rvest_1.0.5               formatR_1.14
```