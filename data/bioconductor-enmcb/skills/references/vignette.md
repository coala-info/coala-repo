# EnMCB

#### Xin Yu

#### 2025-10-29

* [Introduction](#introduction)
* [Installation](#installation)
* [Useage](#useage)
* [Session Info](#session-info)
* [References](#references)

## Introduction

This package is designed to help you to create the methylation correlated blocks using methylation profiles. A stacked ensemble of machine learning models, which combined the Cox regression, support vector regression and elastic-net regression model, can be constructed using this package[1](#fn1). You also can choose one of them to build DNA methylation signatures associated with disease progression.

Note: This package is still under developing. Some of the functions may change.

Followings are brief insturctions for using this package:

You can install and test our package by downloading source package.

## Installation

```
#if(!requireNamespace("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#BiocManager::install("EnMCB")
```

## Useage

First, you need a methylation data set, currently only most common platform ‘Illumina Infinium Human Methylation 450K’ is supported.

You can use your own datasets,or use our demo data.

You can automatically run following:

```
suppressPackageStartupMessages(library(EnMCB))

methylation_dataset<-create_demo()

res<-IdentifyMCB(methylation_dataset)
```

IdentfyMCB() function will calculated Pearson correlation coefficients between the any two CpGs. A value of Pearson correlation coefficients which under the threshold was used to identify boundaries between any two adjacent markers indicating uncorrelated methylation. Markers not separated by a boundary were combined into the MCB. You can extract the MCB information with,

```
MCB<-res$MCBinformation
```

and select some of MCBs for further modeling.

```
MCB<-MCB[MCB[,"CpGs_num"]>=5,]
```

In order to get differentially methylated blocks, one may run following:

```
#simulation for the group data
groups = c(rep("control",200),rep("dis",255))

DiffMCB_resutls<-DiffMCB(methylation_dataset,
                         groups,
                         MCB)$tab
```

In order to build survival models, one may run following:

```
# sample the dataset into training set and testing set
trainingset<-colnames(methylation_dataset) %in% sample(colnames(methylation_dataset),0.6*length(colnames(methylation_dataset)))

testingset<-!trainingset

#build the models
library(survival)
data(demo_survival_data)

models<-metricMCB(MCB,
                    training_set = methylation_dataset[,trainingset],
                    Surv = demo_survival_data[trainingset],
                    Method = "cox",ci = TRUE)

#select the best
onemodel<-models$best_cox_model$cox_model
```

Then, you can predict the risk by the model you build:

```
newcgdata<-data.frame(t(methylation_dataset[,testingset]))

prediction_results<-predict(onemodel, newcgdata)
```

In order to build ensemble model, one may run following:

```
# You can choose one of MCBs:
select_single_one=1

em<-ensemble_model(t(MCB[select_single_one,]),
                    training_set=methylation_dataset[,trainingset],
                    Surv_training=demo_survival_data[trainingset])
```

Note that this function only can be used for single MCB only, otherwise the precessing time could be very long.

Then, you can predict the risk by the model you build:

```
em_prediction_results<-ensemble_prediction(ensemble_model = em,
                    prediction_data = methylation_dataset[,testingset])
```

This function will return the single vector with risk scores predicted by ensemble model.

For detailed information, you can find at our references.

## Session Info

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
## [1] survival_3.8-3 EnMCB_1.22.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1    libcoin_1.0-10      dplyr_1.1.4
##  [4] farver_2.1.2        blob_1.2.4          filelock_1.0.3
##  [7] S7_0.2.0            fastmap_1.2.0       TH.data_1.1-4
## [10] BiocFileCache_3.0.0 pracma_2.4.6        digest_0.6.37
## [13] rpart_4.1.24        lifecycle_1.0.4     cluster_2.1.8.1
## [16] RSQLite_2.4.3       magrittr_2.0.4      kernlab_0.9-33
## [19] compiler_4.5.1      rlang_1.1.6         Hmisc_5.2-4
## [22] sass_0.4.10         tools_4.5.1         partykit_1.2-24
## [25] yaml_2.3.10         data.table_1.17.8   knitr_1.50
## [28] htmlwidgets_1.6.4   bit_4.6.0           curl_7.0.0
## [31] RColorBrewer_1.1-3  multcomp_1.4-29     polspline_1.1.25
## [34] foreign_0.8-90      nnet_7.3-20         grid_4.5.1
## [37] colorspace_2.1-2    ggplot2_4.0.0       MASS_7.3-65
## [40] scales_1.4.0        iterators_1.0.14    dichromat_2.0-0.1
## [43] cli_3.6.5           mvtnorm_1.3-3       inum_1.0-5
## [46] rmarkdown_2.30      rms_8.1-0           generics_0.1.4
## [49] rstudioapi_0.17.1   DBI_1.2.3           cachem_1.1.0
## [52] stringr_1.5.2       splines_4.5.1       nnls_1.6
## [55] parallel_4.5.1      base64enc_0.1-3     vctrs_0.6.5
## [58] sandwich_3.1-1      boot_1.3-32         glmnet_4.1-10
## [61] Matrix_1.7-4        SparseM_1.84-2      jsonlite_2.0.0
## [64] survivalsvm_0.0.6   bit64_4.6.0-1       Formula_1.2-5
## [67] htmlTable_2.4.3     foreach_1.5.2       jquerylib_0.1.4
## [70] glue_1.8.0          stabs_0.6-4         codetools_0.2-20
## [73] mboost_2.9-11       stringi_1.8.7       shape_1.4.6.1
## [76] gtable_0.3.6        quadprog_1.5-8      tibble_3.3.0
## [79] pillar_1.11.1       quantreg_6.1        rappdirs_0.3.3
## [82] htmltools_0.5.8.1   R6_2.6.1            dbplyr_2.5.1
## [85] httr2_1.2.1         survivalROC_1.0.3.1 evaluate_1.0.5
## [88] lattice_0.22-7      backports_1.5.0     memoise_2.0.1
## [91] bslib_0.9.0         MatrixModels_0.5-4  Rcpp_1.1.0
## [94] nlme_3.1-168        gridExtra_2.3       checkmate_2.3.3
## [97] xfun_0.53           zoo_1.8-14          pkgconfig_2.0.3
```

## References

---

1. Xin Yu et al. 2019 Predicting disease progression in lung adenocarcinoma patients based on methylation correlated blocks using ensemble machine learning classifiers (under review)[↩︎](#fnref1)