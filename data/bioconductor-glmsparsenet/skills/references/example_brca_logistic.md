# Example for Classification Data – Breast Invasive Carcinoma

Marta Lopes and André Veríssimo

#### 2025-10-30

# Contents

* [0.1 Instalation](#instalation)
* [1 Required Packages](#required-packages)
* [2 Load data](#load-data)
* [3 Fit models](#fit-models)
* [4 Results of Cross Validation](#results-of-cross-validation)
  + [4.1 Coefficients of selected model from Cross-Validation](#coefficients-of-selected-model-from-cross-validation)
  + [4.2 Accuracy](#accuracy)
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
library(MultiAssayExperiment)
library(TCGAutils)
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
brca <- curatedTCGAData(
    diseaseCode = "BRCA", assays = "RNASeq2GeneNorm",
    version = "1.1.38", dry.run = FALSE
)
```

```
brca <- TCGAutils::TCGAsplitAssays(brca, c("01", "11"))
xdataRaw <- t(cbind(assay(brca[[1]]), assay(brca[[2]])))

# Get matches between survival and assay data
classV <- TCGAbiospec(rownames(xdataRaw))$sample_definition |> factor()
names(classV) <- rownames(xdataRaw)

# keep features with standard deviation > 0
xdataRaw <- xdataRaw[, apply(xdataRaw, 2, sd) != 0] |>
    scale()

set.seed(params$seed)
smallSubset <- c(
    "CD5", "CSF2RB", "HSF1", "IRGC", "LRRC37A6P", "NEUROG2",
    "NLRC4", "PDE11A", "PIK3CB", "QARS", "RPGRIP1L", "SDC1",
    "TMEM31", "YME1L1", "ZBTB11",
    sample(colnames(xdataRaw), 100)
)

xdata <- xdataRaw[, smallSubset[smallSubset %in% colnames(xdataRaw)]]
ydata <- classV
```

# 3 Fit models

Fit model model penalizing by the hubs using the cross-validation function by
`cv.glmHub`.

```
fitted <- cv.glmHub(xdata, ydata,
    family = "binomial",
    network = "correlation",
    nlambda = 1000,
    options = networkOptions(
        cutoff = .6,
        minDegree = .2
    )
)
```

# 4 Results of Cross Validation

Shows the results of `1000` different parameters used to find the optimal value
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
| (Intercept) | (Intercept) | (Intercept) | -6.8189813 |
| AMOTL1 | AMOTL1 | AMOTL1 | 0.4430643 |
| ATR | ATR | ATR | 1.2498304 |
| B3GALT2 | B3GALT2 | B3GALT2 | -0.0867011 |
| BAG2 | BAG2 | BAG2 | -0.1841676 |
| C16orf82 | C16orf82 | C16orf82 | 0.0396368 |
| CD5 | CD5 | CD5 | -1.1200445 |
| CIITA | CIITA | CIITA | 0.4256103 |
| DCP1A | DCP1A | DCP1A | 0.2994599 |
| FAM86B1 | FAM86B1 | FAM86B1 | 0.2025463 |
| FNIP2 | FNIP2 | FNIP2 | 0.6101759 |
| GDF11 | GDF11 | GDF11 | -0.2676642 |
| GNG11 | GNG11 | GNG11 | 3.0659066 |
| GREM2 | GREM2 | GREM2 | -0.2014884 |
| GZMB | GZMB | GZMB | -2.7663574 |
| HAX1 | HAX1 | HAX1 | -0.1516837 |
| IL2 | IL2 | IL2 | 0.6327083 |
| MMP28 | MMP28 | MMP28 | -0.8438024 |
| MS4A4A | MS4A4A | MS4A4A | 1.1614779 |
| NDRG2 | NDRG2 | NDRG2 | 1.1142519 |
| NLRC4 | NLRC4 | NLRC4 | -1.4434578 |
| PIK3CB | PIK3CB | PIK3CB | -0.3880002 |
| ZBTB11 | ZBTB11 | ZBTB11 | -0.3325729 |

## 4.2 Accuracy

```
## [INFO] Misclassified (11)
```

```
## [INFO]   * False primary solid tumour: 7
```

```
## [INFO]   * False normal              : 4
```

Histogram of predicted response

![](data:image/png;base64...)

ROC curve

```
## Setting levels: control = Primary Solid Tumor, case = Solid Tissue Normal
```

```
## Setting direction: controls < cases
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] glmSparseNet_1.28.0         TCGAutils_1.30.0
##  [3] curatedTCGAData_1.31.3      MultiAssayExperiment_1.36.0
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] BiocGenerics_0.56.0         generics_0.1.4
## [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [15] futile.logger_1.4.3         survival_3.8-3
## [17] ggplot2_4.0.0               dplyr_1.1.4
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
##   [3] shape_1.4.6.1             magrittr_2.0.4
##   [5] magick_2.9.0              GenomicFeatures_1.62.0
##   [7] farver_2.1.2              rmarkdown_2.30
##   [9] BiocIO_1.20.0             vctrs_0.6.5
##  [11] memoise_2.0.1             Rsamtools_2.26.0
##  [13] RCurl_1.98-1.17           tinytex_0.57
##  [15] htmltools_0.5.8.1         S4Arrays_1.10.0
##  [17] BiocBaseUtils_1.12.0      progress_1.2.3
##  [19] AnnotationHub_4.0.0       lambda.r_1.2.4
##  [21] curl_7.0.0                pROC_1.19.0.1
##  [23] SparseArray_1.10.0        sass_0.4.10
##  [25] bslib_0.9.0               httr2_1.2.1
##  [27] futile.options_1.0.1      cachem_1.1.0
##  [29] GenomicAlignments_1.46.0  lifecycle_1.0.4
##  [31] iterators_1.0.14          pkgconfig_2.0.3
##  [33] Matrix_1.7-4              R6_2.6.1
##  [35] fastmap_1.2.0             digest_0.6.37
##  [37] AnnotationDbi_1.72.0      ps_1.9.1
##  [39] ExperimentHub_3.0.0       RSQLite_2.4.3
##  [41] labeling_0.4.3            filelock_1.0.3
##  [43] httr_1.4.7                abind_1.4-8
##  [45] compiler_4.5.1            bit64_4.6.0-1
##  [47] withr_3.0.2               S7_0.2.0
##  [49] backports_1.5.0           BiocParallel_1.44.0
##  [51] DBI_1.2.3                 biomaRt_2.66.0
##  [53] rappdirs_0.3.3            DelayedArray_0.36.0
##  [55] rjson_0.2.23              tools_4.5.1
##  [57] chromote_0.5.1            otel_0.2.0
##  [59] glue_1.8.0                restfulr_0.0.16
##  [61] promises_1.4.0            grid_4.5.1
##  [63] checkmate_2.3.3           gtable_0.3.6
##  [65] tzdb_0.5.0                websocket_1.4.4
##  [67] hms_1.1.4                 xml2_1.4.1
##  [69] XVector_0.50.0            BiocVersion_3.22.0
##  [71] foreach_1.5.2             pillar_1.11.1
##  [73] stringr_1.5.2             later_1.4.4
##  [75] splines_4.5.1             BiocFileCache_3.0.0
##  [77] lattice_0.22-7            rtracklayer_1.70.0
##  [79] bit_4.6.0                 tidyselect_1.2.1
##  [81] Biostrings_2.78.0         knitr_1.50
##  [83] bookdown_0.45             xfun_0.53
##  [85] stringi_1.8.7             UCSC.utils_1.6.0
##  [87] yaml_2.3.10               evaluate_1.0.5
##  [89] codetools_0.2-20          cigarillo_1.0.0
##  [91] tibble_3.3.0              BiocManager_1.30.26
##  [93] cli_3.6.5                 processx_3.8.6
##  [95] jquerylib_0.1.4           dichromat_2.0-0.1
##  [97] Rcpp_1.1.0                GenomeInfoDb_1.46.0
##  [99] GenomicDataCommons_1.34.0 dbplyr_2.5.1
## [101] png_0.1-8                 XML_3.99-0.19
## [103] parallel_4.5.1            readr_2.1.5
## [105] blob_1.2.4                prettyunits_1.2.0
## [107] bitops_1.0-9              glmnet_4.1-10
## [109] scales_1.4.0              purrr_1.1.0
## [111] crayon_1.5.3              rlang_1.1.6
## [113] KEGGREST_1.50.0           rvest_1.0.5
## [115] formatR_1.14
```