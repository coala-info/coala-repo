# Example for Survival Data – Skin Melanoma

Eunice Carrasquinha and André Veríssimo

#### 2025-10-30

# Contents

* [0.1 Instalation](#instalation)
* [1 Required Packages](#required-packages)
* [2 Load data](#load-data)
* [3 Fit models](#fit-models)
* [4 Results of Cross Validation](#results-of-cross-validation)
  + [4.1 Coefficients of selected model from Cross-Validation](#coefficients-of-selected-model-from-cross-validation)
  + [4.2 Survival curves and Log rank test](#survival-curves-and-log-rank-test)
* [5 Session Info](#session-info)

## 0.1 Instalation

```
if (!require("BiocManager")) {
    install.packages("BiocManager")
}
BiocManager::install("glmSparseNet")
```

# 1 Required Packages

```
library(dplyr)
library(ggplot2)
library(survival)
library(futile.logger)
library(curatedTCGAData)
library(TCGAutils)
library(MultiAssayExperiment)
#
library(glmSparseNet)
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

# 2 Load data

The data is loaded from an online curated dataset downloaded from TCGA using
`curatedTCGAData` bioconductor package and processed.

To accelerate the process we use a very reduced dataset down to 107 variables
only *(genes)*, which is stored as a data object in this package. However, the
procedure to obtain the data manually is described in the following chunk.

```
skcm <- curatedTCGAData(
    diseaseCode = "SKCM", assays = "RNASeq2GeneNorm",
    version = "1.1.38", dry.run = FALSE
)
```

Build the survival data from the clinical columns.

* Merge survival times for patients, which have different columns in case they
  are alive or dead.
* Build two matrix objects that fit the data `xdata` and `ydata`

```
skcmMetastatic <- TCGAutils::TCGAsplitAssays(skcm, "06")
xdataRaw <- t(assay(skcmMetastatic[[1]]))

# Get survival information
ydataRaw <- colData(skcmMetastatic) |>
    as.data.frame() |>
    # Find max time between all days (ignoring missings)
    dplyr::rowwise() |>
    dplyr::mutate(
        time = max(days_to_last_followup,
            days_to_death,
            na.rm = TRUE
        )
    ) |>
    # Keep only survival variables and codes
    dplyr::select(patientID, status = vital_status, time) |>
    # Discard individuals with survival time less or equal to 0
    dplyr::filter(!is.na(time) & time > 0) |>
    as.data.frame()

# Get survival information
ydataRaw <- colData(skcm) |>
    as.data.frame() |>
    # Find max time between all days (ignoring missings)
    dplyr::filter(
        !is.na(days_to_last_followup) | !is.na(days_to_death)
    ) |>
    dplyr::rowwise() |>
    dplyr::mutate(
        time = max(days_to_last_followup, days_to_death, na.rm = TRUE)
    ) |>
    # Keep only survival variables and codes
    dplyr::select(patientID, status = vital_status, time) |>
    # Discard individuals with survival time less or equal to 0
    dplyr::filter(!is.na(time) & time > 0) |>
    as.data.frame()

# Set index as the patientID
rownames(ydataRaw) <- ydataRaw$patientID

# keep only features that have standard deviation > 0
xdataRaw <- xdataRaw[
    TCGAbarcode(rownames(xdataRaw)) %in% rownames(ydataRaw),
]
xdataRaw <- xdataRaw[, apply(xdataRaw, 2, sd) != 0] |>
    scale()

# Order ydata the same as assay
ydataRaw <- ydataRaw[TCGAbarcode(rownames(xdataRaw)), ]

set.seed(params$seed)
smallSubset <- c(
    "FOXL2", "KLHL5", "PCYT2", "SLC6A10P", "STRAP", "TMEM33",
    "WT1-AS", sample(colnames(xdataRaw), 100)
)

xdata <- xdataRaw[, smallSubset[smallSubset %in% colnames(xdataRaw)]]
ydata <- ydataRaw |> dplyr::select(time, status)
```

# 3 Fit models

Fit model model penalizing by the hubs using the cross-validation function by
`cv.glmHub`.

```
fitted <- cv.glmHub(
    xdata,
    Surv(ydata$time, ydata$status),
    family = "cox",
    foldid = glmSparseNet:::balancedCvFolds(ydata$status)$output,
    network = "correlation",
    options = networkOptions(
        cutoff = .6,
        minDegree = .2
    )
)
```

# 4 Results of Cross Validation

Shows the results of `100` different parameters used to find the optimal value
in 10-fold cross-validation. The two vertical dotted lines represent the best
model and a model with less variables selected *(genes)*, but within a standard
error distance from the best.

```
plot(fitted)
```

![](data:image/png;base64...)

## 4.1 Coefficients of selected model from Cross-Validation

Taking the best model described by `lambda.min`

```
coefsCV <- Filter(function(.x) .x != 0, coef(fitted, s = "lambda.min")[, 1])
data.frame(
    ensembl.id = names(coefsCV),
    gene.name = geneNames(names(coefsCV))$external_gene_name,
    coefficient = coefsCV,
    stringsAsFactors = FALSE
) |>
    arrange(gene.name) |>
    knitr::kable()
```

|  | ensembl.id | gene.name | coefficient |
| --- | --- | --- | --- |
| AMICA1 | AMICA1 | AMICA1 | -0.2758400 |
| C4orf49 | C4orf49 | C4orf49 | -0.0059089 |
| PCYT2 | PCYT2 | PCYT2 | 0.0646641 |

## 4.2 Survival curves and Log rank test

```
separate2GroupsCox(as.vector(coefsCV),
    xdata[, names(coefsCV)],
    ydata,
    plotTitle = "Full dataset", legendOutside = FALSE
)
```

```
## $pvalue
## [1] 0.0001269853
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
## Low risk - 1  180     79   4000    2927    6164
## High risk - 1 179    114   2005    1524    2829
```

# 5 Session Info

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