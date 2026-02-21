[[![](data:image/png;base64...)](https://www.bioconductor.org/packages/release/data/experiment/html/CytoMethIC.html)](index.html)

* [Basic Information](CytoMethIC.html)
* [Oncology](Oncology.html)

# 2. CytoMethIC Oncology

#### 6 November 2025

`CytoMethIC-Oncology` is a collection machine learning models for oncology. This includes CNS tumor classification, pan-cancer classification, cell of origin classification, and subtype classification models.

# MODELS

Models available are listed below:

CytoMethIC Oncology Models

| EHID | ModelID | PredictionLabel |
| --- | --- | --- |
| EH8423 | CancerCellOfOrigin21\_rfc | Cell of origin defined in TCGA (N=21) |
| NA | CancerType33\_InfHum3\_20230807 | TCGA cancer types (N=33) |
| EH8398 | CancerType33\_mlp | TCGA cancer types (N=33) |
| EH8395 | CancerType33\_rfc | TCGA cancer types (N=33) |
| NA | CancerType33\_rfcTCGA\_InfHum3 | TCGA cancer types (N=33) |
| EH8396 | CancerType33\_svm | TCGA cancer types (N=33) |
| EH8397 | CancerType33\_xgb | TCGA cancer types (N=33) |
| NA | CancerType33\_xgbTCGA\_InfHum3 | TCGA cancer types (N=33) |
| EH8402 | CNSTumor66\_mlp | CNS Tumor Class (N=66) |
| EH8399 | CNSTumor66\_rfc | CNS Tumor Class (N=66) |
| NA | CNSTumor66\_rfcCapper\_InfHum3 | CNS Tumor Class (N=66) |
| EH8400 | CNSTumor66\_svm | CNS Tumor Class (N=66) |
| EH8401 | CNSTumor66\_xgb | CNS Tumor Class (N=66) |
| NA | CNSTumor66\_xgbCapper\_InfHum3 | CNS Tumor Class (N=66) |
| EH8422 | Subtype91\_rfc | Cancer subtypes defined in TCGA (N=91) |
| NA | TumorPurity\_HM450 | Tumor purity (%) |
| NA | TumorPurity\_HM450\_20240318 | Tumor purity (%) |

One can access the model using the EHID above in `ExperimentHub()[["EHID"]]`.

More models (if EHID is NA) are available in the following [Github Repo](https://github.com/zhou-lab/CytoMethIC_models/tree/main/models). You can directly download them and load with `readRDS()`. Some examples using either approach are below.

# CANCER TYPE

The below snippet shows a demonstration of the model abstraction working on random forest and support vector models from CytoMethIC models on ExperimentHub.

```
## for missing data
library(sesame)
library(CytoMethIC)
betas = imputeBetas(sesameDataGet("HM450.1.TCGA.PAAD")$betas)
model = ExperimentHub()[["EH8395"]] # Random forest model
cmi_predict(betas, model)
```

```
## $response
## [1] "PAAD"
##
## $prob
##  PAAD
## 0.852
```

```
model = ExperimentHub()[["EH8396"]] # SVM model
```

```
cmi_predict(betas, model)
```

```
## $response
## [1] "PAAD"
##
## $prob
## betas[, attr(model$terms, "term.labels")]
##                                 0.9864795
```

```
model = ExperimentHub()[["EH8422"]] # Cancer subtype
```

```
cmi_predict(sesameDataGet("HM450.1.TCGA.PAAD")$betas, model)
```

```
## $response
## [1] "GI.CIN"
##
## $prob
## GI.CIN
##  0.462
```

# CELL-OF-ORIGIN

The below snippet shows a demonstration of the cmi\_predict function working to predict the cell of origin of the cancer.

```
model = ExperimentHub()[["EH8423"]]
cmi_predict(sesameDataGet("HM450.1.TCGA.PAAD")$betas, model)
```

```
## $response
## [1] "C20:Mixed (Stromal/Immune)"
##
## $prob
## C20:Mixed (Stromal/Immune)
##                      0.768
```

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] sesame_1.28.0       sesameData_1.28.0   CytoMethIC_1.6.0
##  [4] ExperimentHub_3.0.0 AnnotationHub_4.0.0 BiocFileCache_3.0.0
##  [7] dbplyr_2.5.1        BiocGenerics_0.56.0 generics_0.1.4
## [10] knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] farver_2.1.2                blob_1.2.4
##  [5] filelock_1.0.3              Biostrings_2.78.0
##  [7] S7_0.2.0                    fastmap_1.2.0
##  [9] digest_0.6.37               lifecycle_1.0.4
## [11] KEGGREST_1.50.0             RSQLite_2.4.3
## [13] magrittr_2.0.4              compiler_4.5.1
## [15] rlang_1.1.6                 sass_0.4.10
## [17] tools_4.5.1                 yaml_2.3.10
## [19] S4Arrays_1.10.0             bit_4.6.0
## [21] curl_7.0.0                  DelayedArray_0.36.0
## [23] plyr_1.8.9                  RColorBrewer_1.1-3
## [25] abind_1.4-8                 BiocParallel_1.44.0
## [27] withr_3.0.2                 purrr_1.2.0
## [29] grid_4.5.1                  stats4_4.5.1
## [31] preprocessCore_1.72.0       wheatmap_0.2.0
## [33] e1071_1.7-16                colorspace_2.1-2
## [35] ggplot2_4.0.0               scales_1.4.0
## [37] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
## [39] cli_3.6.5                   rmarkdown_2.30
## [41] crayon_1.5.3                reshape2_1.4.4
## [43] httr_1.4.7                  tzdb_0.5.0
## [45] proxy_0.4-27                DBI_1.2.3
## [47] cachem_1.1.0                stringr_1.6.0
## [49] parallel_4.5.1              AnnotationDbi_1.72.0
## [51] BiocManager_1.30.26         XVector_0.50.0
## [53] matrixStats_1.5.0           vctrs_0.6.5
## [55] Matrix_1.7-4                jsonlite_2.0.0
## [57] IRanges_2.44.0              hms_1.1.4
## [59] S4Vectors_0.48.0            bit64_4.6.0-1
## [61] fontawesome_0.5.3           jquerylib_0.1.4
## [63] glue_1.8.0                  codetools_0.2-20
## [65] stringi_1.8.7               gtable_0.3.6
## [67] BiocVersion_3.22.0          GenomicRanges_1.62.0
## [69] tibble_3.3.0                pillar_1.11.1
## [71] rappdirs_0.3.3              htmltools_0.5.8.1
## [73] Seqinfo_1.0.0               randomForest_4.7-1.2
## [75] R6_2.6.1                    httr2_1.2.1
## [77] evaluate_1.0.5              Biobase_2.70.0
## [79] lattice_0.22-7              readr_2.1.5
## [81] png_0.1-8                   memoise_2.0.1
## [83] BiocStyle_2.38.0            bslib_0.9.0
## [85] class_7.3-23                Rcpp_1.1.0
## [87] SparseArray_1.10.1          xfun_0.54
## [89] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```