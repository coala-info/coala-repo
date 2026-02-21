# Holdout Testing with SIAMCAT

Jakob Wirbel, Konrad Zych, and Georg Zeller1\*

1EMBL Heidelberg

\*georg.zeller@embl.de

#### Date last modified: 2018-09-24

# Contents

* [1 Introduction](#introduction)
* [2 Load the Data](#load-the-data)
* [3 Model Building on the French Dataset](#model-building-on-the-french-dataset)
  + [3.1 Preprocessing](#preprocessing)
  + [3.2 Model Training](#model-training)
  + [3.3 Predictions](#predictions)
* [4 Application on the Holdout Dataset](#application-on-the-holdout-dataset)
  + [4.1 Frozen Normalization](#frozen-normalization)
  + [4.2 Holdout Predictions](#holdout-predictions)
* [5 Model Evaluation](#model-evaluation)
* [6 Session Info](#session-info)

# 1 Introduction

One of the functionalities of the `SIAMCAT` package is the training of
statistical machine learning models on metagenomics data. In this vignette,
we demonstrate how such a model can be built on one dataset and then be applied
on another, similarly processed holdout dataset. This might be of interest
when comparing data from two different studies on the same disease.

In this vignette, we look at two datasets from studies on colorectal cancer
(CRC). The first study from
[Zeller et al.](http://europepmc.org/abstract/MED/25432777) investigated
metagenomic markers for CRC in a population in France, while the second study
from [Yu et al.](https://europepmc.org/abstract/MED/26408641) used samples
from China for the same goal. Both datasets were profiled with the same
[taxonomic profiling tool](https://github.com/motu-tool/mOTUs_v2), yielding
the same taxonomic identifiers, which is required for holdout testing.

# 2 Load the Data

The datasets can be found on the web repository for public metagenomics
datasets from the
[Zeller group](https://www.embl.de/research/units/scb/zeller/index.html).

```
library("SIAMCAT")

data.loc <- 'https://zenodo.org/api/files/d81e429c-870f-44e0-a44a-2a4aa541b6c1/'
# this is data from Zeller et al., Mol. Syst. Biol. 2014
fn.meta.fr  <- paste0(data.loc, 'meta_Zeller.tsv')
fn.feat.fr  <- paste0(data.loc, 'specI_Zeller.tsv')

# this is the external dataset from Yu et al., Gut 2017
fn.meta.cn  <- paste0(data.loc, 'meta_Yu.tsv')
fn.feat.cn  <- paste0(data.loc, 'specI_Yu.tsv')
```

First of all, we build a `SIAMCAT` object using the data from the French study
in the same way that we have seen before in the main `SIAMCAT` vignette.

```
# features
# be vary of the defaults in R!!!
feat.fr  <- read.table(fn.feat.fr, sep='\t', quote="",
    check.names = FALSE, stringsAsFactors = FALSE)
# the features are counts, but we want to work with relative abundances
feat.fr.rel <- prop.table(as.matrix(feat.fr), 2)

# metadata
meta.fr  <- read.table(fn.meta.fr, sep='\t', quote="",
    check.names=FALSE, stringsAsFactors=FALSE)

# create SIAMCAT object
siamcat.fr <- siamcat(feat=feat.fr.rel, meta=meta.fr,
    label='Group', case='CRC')
```

```
## + starting create.label
```

```
## Label used as case:
##    CRC
## Label used as control:
##    CTR
```

```
## + finished create.label.from.metadata in 0.004 s
```

```
## + starting validate.data
```

```
## +++ checking overlap between labels and features
```

```
## + Keeping labels of 141 sample(s).
```

```
## +++ checking sample number per class
```

```
## +++ checking overlap between samples and metadata
```

```
## + finished validate.data in 0.036 s
```

We can load the data from the Chinese study in a similar way and also create a
`SIAMCAT` object for the holdout dataset.

```
# features
feat.cn  <- read.table(fn.feat.cn, sep='\t', quote="",
    check.names = FALSE)
feat.cn.rel <- prop.table(as.matrix(feat.cn), 2)

# metadata
meta.cn  <- read.table(fn.meta.cn, sep='\t', quote="",
    check.names=FALSE, stringsAsFactors = FALSE)

# SIAMCAT object
siamcat.cn <- siamcat(feat=feat.cn.rel, meta=meta.cn,
        label='Group', case='CRC')
```

```
## + starting create.label
```

```
## Label used as case:
##    CRC
## Label used as control:
##    CTR
```

```
## + finished create.label.from.metadata in 0.002 s
```

```
## + starting validate.data
```

```
## +++ checking overlap between labels and features
```

```
## + Keeping labels of 128 sample(s).
```

```
## +++ checking sample number per class
```

```
## +++ checking overlap between samples and metadata
```

```
## + finished validate.data in 0.029 s
```

# 3 Model Building on the French Dataset

## 3.1 Preprocessing

With the French dataset, we perform the complete process of model building
within `SIAMCAT`, including data preprocessing steps like data validation,
filtering, and data normalization.

```
siamcat.fr <- filter.features(
    siamcat.fr,
    filter.method = 'abundance',
    cutoff = 0.001,
    rm.unmapped = TRUE,
    verbose=2
)
```

```
## + starting filter.features
```

```
## +++ before filtering, the data have 1754 features
```

```
## +++ removed 1 features corresponding to UNMAPPED reads
```

```
## +++ removed 1539 features whose values did not exceed 0.001 in any sample (retaining 215)
```

```
## + finished filter.features in 0.006 s
```

```
siamcat.fr <- normalize.features(
    siamcat.fr,
    norm.method = "log.std",
    norm.param = list(log.n0 = 1e-06, sd.min.q = 0.1),
    verbose = 2
)
```

```
## + starting normalize.features
```

```
## +++ performing de novo normalization using the  log.std  method
```

```
## + feature sparsity before normalization: 46.05%
```

```
## +++ feature sparsity after normalization:      0 %
```

```
## + finished normalize.features in 0.006 s
```

## 3.2 Model Training

Now, we can build the statistical model. We use the same parameters as in
the main `SIAMCAT` vignette, where the process is explained in more detail.

```
siamcat.fr <-  create.data.split(
    siamcat.fr,
    num.folds = 5,
    num.resample = 2
)
```

```
## Features splitted for cross-validation successfully.
```

```
siamcat.fr <- train.model(
    siamcat.fr,
    method = "lasso"
)
```

```
## Trained lasso models successfully.
```

## 3.3 Predictions

Finally, we can make predictions for each cross-validation fold and evaluate
the predictions as seen in the main `SIAMCAT` vignette.

```
siamcat.fr <- make.predictions(siamcat.fr)
```

```
## Made predictions successfully.
```

```
siamcat.fr <-  evaluate.predictions(siamcat.fr)
```

```
## Evaluated predictions successfully.
```

# 4 Application on the Holdout Dataset

Now that we have successfully built the model for the French dataset, we can
apply it to the Chinese holdout dataset. First, we will normalize the Chinese
dataset with the same parameters that we used for the French dataset in order
to make the data comparable. For that step, we can use the frozen normalization
functionality in the `normalize.features` function in `SIAMCAT`. We supply to
the function all normalization parameters saved in the `siamcat.fr` object,
which can be accessed using the `norm_params` accessor.

## 4.1 Frozen Normalization

```
siamcat.cn <- normalize.features(siamcat.cn,
    norm.param=norm_params(siamcat.fr),
    feature.type='original',
    verbose = 2)
```

```
## + starting normalize.features
```

```
## + normalizing original features
```

```
## + performing frozen  log.std  normalization using the supplied parameters
```

```
## + feature sparsity before normalization: 49.77%
```

```
## + feature sparsity after normalization:     0%
```

```
## + finished normalize.features in 0.005 s
```

## 4.2 Holdout Predictions

Next, we apply the trained model to predict the holdout dataset.

```
siamcat.cn <- make.predictions(
    siamcat = siamcat.fr,
    siamcat.holdout = siamcat.cn,
    normalize.holdout = FALSE)
```

```
## Warning in make.external.predictions(siamcat.trained = siamcat,
## siamcat.external = siamcat.holdout, : holdout set is not being normalized!
```

```
## Made predictions successfully.
```

Note that the `make.predictions` function can also take care of the
normalization of the holdout dataset.

```
## Alternative Code, not run here
siamcat.cn <- siamcat(feat=feat.cn.rel, meta=meta.cn,
    label='Group', case='CRC')
siamcat.cn <- make.predictions(siamcat = siamcat.fr,
    siamcat.holdout = siamcat.cn,
    normalize.holdout = TRUE)
```

Again, we have to evaluate the predictions:

```
siamcat.cn <- evaluate.predictions(siamcat.cn)
```

# 5 Model Evaluation

Now, we can compare the performance of the classifier on the original and
the holdout dataset by using the `model.evaluation.plot` function. Here,
we can supply several `SIAMCAT` objects for which the model evaluation will be
plotted in the same plot. Note that we can supply the objects as named objects
in order to print the names in the legend.

```
model.evaluation.plot('FR-CRC'=siamcat.fr,
    'CN-CRC'=siamcat.cn,
    colours=c('dimgrey', 'orange'))
```

![](data:image/png;base64...)

# 6 Session Info

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
##  [1] ggpubr_0.6.2     SIAMCAT_2.14.0   phyloseq_1.54.0  mlr3_1.2.0
##  [5] lubridate_1.9.4  forcats_1.0.1    stringr_1.5.2    dplyr_1.1.4
##  [9] purrr_1.1.0      readr_2.1.5      tidyr_1.3.1      tibble_3.3.0
## [13] ggplot2_4.0.0    tidyverse_2.0.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3   jsonlite_2.0.0       shape_1.4.6.1
##   [4] magrittr_2.0.4       magick_2.9.0         farver_2.1.2
##   [7] corrplot_0.95        nloptr_2.2.1         rmarkdown_2.30
##  [10] vctrs_0.6.5          multtest_2.66.0      minqa_1.2.8
##  [13] PRROC_1.4            tinytex_0.57         rstatix_0.7.3
##  [16] htmltools_0.5.8.1    progress_1.2.3       curl_7.0.0
##  [19] broom_1.0.10         Rhdf5lib_1.32.0      Formula_1.2-5
##  [22] rhdf5_2.54.0         pROC_1.19.0.1        sass_0.4.10
##  [25] parallelly_1.45.1    bslib_0.9.0          plyr_1.8.9
##  [28] palmerpenguins_0.1.1 mlr3tuning_1.4.0     cachem_1.1.0
##  [31] uuid_1.2-1           igraph_2.2.1         lifecycle_1.0.4
##  [34] iterators_1.0.14     pkgconfig_2.0.3      Matrix_1.7-4
##  [37] R6_2.6.1             fastmap_1.2.0        rbibutils_2.3
##  [40] future_1.67.0        digest_0.6.37        numDeriv_2016.8-1.1
##  [43] S4Vectors_0.48.0     mlr3misc_0.19.0      vegan_2.7-2
##  [46] labeling_0.4.3       timechange_0.3.0     abind_1.4-8
##  [49] mgcv_1.9-3           compiler_4.5.1       beanplot_1.3.1
##  [52] bit64_4.6.0-1        withr_3.0.2          S7_0.2.0
##  [55] backports_1.5.0      carData_3.0-5        ggsignif_0.6.4
##  [58] LiblineaR_2.10-24    MASS_7.3-65          biomformat_1.38.0
##  [61] permute_0.9-8        tools_4.5.1          ape_5.8-1
##  [64] glue_1.8.0           lgr_0.5.0            nlme_3.1-168
##  [67] rhdf5filters_1.22.0  grid_4.5.1           checkmate_2.3.3
##  [70] gridBase_0.4-7       cluster_2.1.8.1      reshape2_1.4.4
##  [73] ade4_1.7-23          generics_0.1.4       gtable_0.3.6
##  [76] tzdb_0.5.0           data.table_1.17.8    hms_1.1.4
##  [79] car_3.1-3            XVector_0.50.0       BiocGenerics_0.56.0
##  [82] foreach_1.5.2        pillar_1.11.1        vroom_1.6.6
##  [85] bbotk_1.7.1          splines_4.5.1        lattice_0.22-7
##  [88] survival_3.8-3       bit_4.6.0            tidyselect_1.2.1
##  [91] Biostrings_2.78.0    knitr_1.50           reformulas_0.4.2
##  [94] infotheo_1.2.0.1     gridExtra_2.3        bookdown_0.45
##  [97] IRanges_2.44.0       Seqinfo_1.0.0        stats4_4.5.1
## [100] xfun_0.53            Biobase_2.70.0       matrixStats_1.5.0
## [103] stringi_1.8.7        yaml_2.3.10          boot_1.3-32
## [106] evaluate_1.0.5       codetools_0.2-20     BiocManager_1.30.26
## [109] cli_3.6.5            Rdpack_2.6.4         jquerylib_0.1.4
## [112] mlr3learners_0.13.0  dichromat_2.0-0.1    Rcpp_1.1.0
## [115] globals_0.18.0       parallel_4.5.1       prettyunits_1.2.0
## [118] paradox_1.0.1        lme4_1.1-37          listenv_0.9.1
## [121] glmnet_4.1-10        lmerTest_3.1-3       scales_1.4.0
## [124] crayon_1.5.3         rlang_1.1.6          mlr3measures_1.1.0
```