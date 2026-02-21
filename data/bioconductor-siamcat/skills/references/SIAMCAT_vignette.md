# SIAMCAT: Statistical Inference of Associations between Microbial Communities And host phenoTypes

Konrad Zych, Jakob Wirbel, and Georg Zeller

EMBL Heidelberg

georg.zeller@embl.de

#### Date last modified: 2020-04-04

# Contents

* [1 About This Vignette](#about-this-vignette)
* [2 Introduction](#introduction)
* [3 Quick Start](#quick-start)
* [4 Association Testing](#association-testing)
* [5 Confounder Testing](#confounder-testing)
* [6 Model Building](#model-building)
  + [6.1 Data Normalization](#data-normalization)
  + [6.2 Prepare Cross-Validation](#prepare-cross-validation)
  + [6.3 Model Training](#model-training)
  + [6.4 Make Predictions](#make-predictions)
* [7 Model Evaluation and Interpretation](#model-evaluation-and-interpretation)
  + [7.1 Evaluation Plot](#evaluation-plot)
  + [7.2 Interpretation Plot](#interpretation-plot)
* [8 Session Info](#session-info)

# 1 About This Vignette

This vignette aims to be a short tutorial for the main functionalities of
`SIAMCAT`. Examples of additional workflows or more detailed tutorials can
be found in other vignettes (see the
[BioConductor page](https://bioconductor.org/packages/SIAMCAT)).

`SIAMCAT` is part of the suite of computational microbiome analysis tools
hosted at [EMBL](https://www.embl.org) by the groups of
[Peer Bork](https://www.embl.de/research/units/scb/bork/index.html) and
[Georg Zeller](https://www.embl.de/research/units/scb/zeller/index.html). Find
out more at [EMBL-microbiome tools](http://microbiome-tools.embl.de/).

# 2 Introduction

Associations between microbiome and host phenotypes are ideally described by
quantitative models able to predict host status from microbiome composition.
`SIAMCAT` can do so for data from hundreds of thousands of microbial taxa, gene
families, or metabolic pathways over hundreds of samples. `SIAMCAT` produces
graphical output for convenient assessment of the quality of the input data and
statistical associations, for model diagnostics and inference revealing the
most predictive microbial biomarkers.

# 3 Quick Start

For this vignette, we use an example dataset included in the `SIAMCAT` package.
As example dataset we use the data from the publication of
[Zeller et al](http://europepmc.org/abstract/MED/25432777), which demonstrated
the potential of microbial species in fecal samples to distinguish patients
with colorectal cancer (CRC) from healthy controls.

```
library("SIAMCAT")

data("feat_crc_zeller", package="SIAMCAT")
data("meta_crc_zeller", package="SIAMCAT")
```

First, `SIAMCAT` needs a feature matrix (can be either a `matrix`, a
`data.frame`, or a `phyloseq-otu_table`), which contains values of different
features (in rows) for different samples (in columns). For example, the
feature matrix included here contains relative abundances for bacterial
species calculated with the [mOTU profiler](motu-tool.org) for 141 samples:

```
feat.crc.zeller[1:3, 1:3]
```

```
##                                  CCIS27304052ST-3-0 CCIS15794887ST-4-0
## UNMAPPED                                   0.589839          0.7142157
## Methanoculleus marisnigri [h:1]            0.000000          0.0000000
## Methanococcoides burtonii [h:10]           0.000000          0.0000000
##                                  CCIS74726977ST-3-0
## UNMAPPED                                  0.7818674
## Methanoculleus marisnigri [h:1]           0.0000000
## Methanococcoides burtonii [h:10]          0.0000000
```

```
dim(feat.crc.zeller)
```

```
## [1] 1754  141
```

> Please note that `SIAMCAT` is supposed to work with **relative abundances**.
> Other types of data (e.g. counts) will also work, but not all functions of the
> package will result in meaningful outputs.

Secondly, we also have metadata about the samples in another `data.frame`:

```
head(meta.crc.zeller)
```

```
##                    Age BMI Gender AJCC_stage     FOBT Group
## CCIS27304052ST-3-0  52  20      F         -1 Negative   CTR
## CCIS15794887ST-4-0  37  18      F         -1 Negative   CTR
## CCIS74726977ST-3-0  66  24      M         -1 Negative   CTR
## CCIS16561622ST-4-0  54  26      M         -1 Negative   CTR
## CCIS79210440ST-3-0  65  30      M         -1 Positive   CTR
## CCIS82507866ST-3-0  57  24      M         -1 Negative   CTR
```

In order to tell `SIAMCAT`, which samples are cancer cases and which are
healthy controls, we can construct a label object from the `Group` column in
the metadata.

```
label.crc.zeller <- create.label(meta=meta.crc.zeller,
    label='Group', case='CRC')
```

```
## Label used as case:
##    CRC
## Label used as control:
##    CTR
```

```
## + finished create.label.from.metadata in 0.001 s
```

Now we have all the ingredients to create a `SIAMCAT` object. Please have a
look at the [vignette about input formats](SIAMCAT_read-in.html) for more
information about supported formats and other ways to create a `SIAMCAT` object.

```
sc.obj <- siamcat(feat=feat.crc.zeller,
    label=label.crc.zeller,
    meta=meta.crc.zeller)
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
## + finished validate.data in 0.061 s
```

A few information about the `SIAMCAT` object can be accessed with the `show`
function from `phyloseq` (`SIAMCAT` builds on the `phyloseq` data structure):

```
show(sc.obj)
```

```
## siamcat-class object
## label()                Label object:         88 CTR and 53 CRC samples
##
## contains phyloseq-class experiment-level object @phyloseq:
## phyloseq@otu_table()   OTU Table:            [ 1754 taxa and 141 samples ]
## phyloseq@sam_data()    Sample Data:          [ 141 samples by 6 sample variables ]
```

Since we have quite a lot of microbial species in the dataset at the moment, we
can perform unsupervised feature selection using the function `filter.features`.

```
sc.obj <- filter.features(sc.obj,
    filter.method = 'abundance',
    cutoff = 0.001)
```

```
## Features successfully filtered
```

# 4 Association Testing

Associations between microbial species and the label can be tested
with the `check.associations` function. The function computes for each species
the significance using a non-parametric Wilcoxon test and different effect
sizes for the association (e.g. AUC or fold change).

```
sc.obj <- check.associations(sc.obj, log.n0 = 1e-06, alpha = 0.05)
association.plot(sc.obj, sort.by = 'fc',
                panels = c('fc', 'prevalence', 'auroc'))
```

The function produces a pdf file as output, since the plot is optimized for a
landscape DIN-A4 layout, but can also used to plot on an active graphic device,
e.g. in RStudio. The resulting plot then looks like that:
![Association Plot](data:image/png;base64...)

# 5 Confounder Testing

As many biological and technical factors beyond the primary phenotype of
interest can influence microbiome composition, simple association studies may
suffer confounding by other variables, which can lead to spurious results.
The `check.confounders` function provides the option to test the associated
metadata variables for potential confounding influence. No information is stored
in the `SIAMCAT` object, but the different analyses are visualized and saved to
a combined pdf file for qualitative interpretation.

```
check.confounders(sc.obj, fn.plot = 'confounder_plots.pdf',
                    meta.in = NULL, feature.type = 'filtered')
```

The conditional entropy check primarily serves to remove nonsensical
variables from subsequent checks. Conditional entropy quantifies the unique
information contained in one variable (row) respective to another (column).
Identical variables and derived variables which share the exact same information
will have a value of zero. In this example, the label was derived from the
Group variable which was determined from AJCC stage, so both are excluded.

![](data:image/png;base64...)

Conditional Entropy Plot

To better quantify potential confounding effects of metadata variables on
individual microbial features, `check.confounder` plots the variance explained
by the label in comparison with the variance explained by the metadata variable
for each individual feature. Variables with many features in the upper left
corner might be confounding the label associations.

![](data:image/png;base64...)

Variance Explained Plot

# 6 Model Building

One strength of `SIAMCAT` is the versatile but easy-to-use interface for the
construction of machine learning models on the basis of microbial species.
`SIAMCAT` contains functions for data normalization, splitting the data into
cross-validation folds, training the model, and making predictions based on
cross-validation instances and the trained models.

## 6.1 Data Normalization

Data normalization is performed with the `normalize.features` function. Here,
we use the `log.unit` method, but several other methods and customization
options are available (please check the documentation).

```
sc.obj <- normalize.features(sc.obj, norm.method = "log.unit",
    norm.param = list(log.n0 = 1e-06, n.p = 2,norm.margin = 1))
```

```
## Features normalized successfully.
```

## 6.2 Prepare Cross-Validation

Preparation of the cross-validation fold is a crucial step in machine learning.
`SIAMCAT` greatly simplifies the set-up of cross-validation schemes, including
stratification of samples or keeping samples inseperable based on metadata.
For this small example, we choose a twice-repeated 5-fold cross-validation
scheme. The data-split will be saved in the `data_split` slot of the `SIAMCAT`
object.

```
sc.obj <-  create.data.split(sc.obj, num.folds = 5, num.resample = 2)
```

```
## Features splitted for cross-validation successfully.
```

## 6.3 Model Training

The actual model training is performed using the function `train.model`.
Again, multiple options for customization are available, ranging from the
machine learning method to the measure for model selection or customizable
parameter set for hyperparameter tuning.

```
sc.obj <- train.model(sc.obj, method = "lasso")
```

The models are saved in the `model_list` slot of the `SIAMCAT` object. The
model building is performed using the `mlr` R package. All models can easily be
accessed.

```
# get information about the model type
model_type(sc.obj)
```

```
## [1] "lasso"
```

```
# access the models
models <- models(sc.obj)
models[[1]]$model
```

```
##
## ── <LearnerClassifCVGlmnet> (classif.cv_glmnet): GLM with Elastic Net Regulariza
## • Model: cv.glmnet
## • Parameters: alpha=1, use_pred_offset=TRUE, s=0.03566
## • Packages: mlr3, mlr3learners, and glmnet
## • Predict Types: response and [prob]
## • Feature Types: logical, integer, and numeric
## • Encapsulation: none (fallback: -)
## • Properties: multiclass, offset, selected_features, twoclass, and weights
## • Other settings: use_weights = 'use'
```

## 6.4 Make Predictions

Using the data-split and the models trained in previous step, we can use the
function `make.predictions` in order to apply the models on the test instances
in the data-split. The predictions will be saved in the `pred_matrix` slot of
the `SIAMCAT` object.

```
sc.obj <- make.predictions(sc.obj)
pred_matrix <- pred_matrix(sc.obj)
```

```
head(pred_matrix)
```

```
##                      CV_rep1    CV_rep2
## CCIS27304052ST-3-0 0.1926214 0.19742175
## CCIS15794887ST-4-0 0.2147436 0.15394803
## CCIS74726977ST-3-0 0.4342722 0.50272329
## CCIS16561622ST-4-0 0.2631763 0.31503250
## CCIS79210440ST-3-0 0.3148595 0.24079464
## CCIS82507866ST-3-0 0.1596903 0.09154444
```

# 7 Model Evaluation and Interpretation

In the final part, we want to find out how well the model performed and which
microbial species had been selected in the model. In order to do so, we first
calculate how well the predictions fit the real data using the function
`evaluate.predictions`. This function calculates the Area Under the Receiver
Operating Characteristic (ROC) Curve (AU-ROC) and the Precision Recall (PR)
Curve for each resampled cross-validation run.

```
sc.obj <-  evaluate.predictions(sc.obj)
```

```
## Evaluated predictions successfully.
```

## 7.1 Evaluation Plot

To plot the results of the evaluation, we can use the function
`model.evaluation.plot`, which produces a pdf-file showing the ROC and PR
Curves for the different resamples runs as well as the mean ROC and PR Curve.

```
model.evaluation.plot(sc.obj)
```

![](data:image/png;base64...)

## 7.2 Interpretation Plot

The final plot produced by `SIAMCAT` is the model interpretation plot, created
by the `model.interpretation.plot` function. The plot shows for the top
selected features the

* model weights (and how robust they are) as a barplot,
* a heatmap with the z-scores or fold changes for the top selected features,
  and
* a boxplot showing the proportions of weight per model which is captured by
  the top selected features.

Additionally, the distribution of metadata is shown in a heatmap below.

The function again produces a pdf-file optimized for a landscape DIN-A4
plotting region.

```
model.interpretation.plot(sc.obj, fn.plot = 'interpretation.pdf',
    consens.thres = 0.5, limits = c(-3, 3), heatmap.type = 'zscore')
```

The resulting plot looks like this:
![Model Interpretation Plot](data:image/png;base64...)

# 8 Session Info

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
##  [79] utf8_1.2.6           car_3.1-3            XVector_0.50.0
##  [82] BiocGenerics_0.56.0  foreach_1.5.2        pillar_1.11.1
##  [85] vroom_1.6.6          bbotk_1.7.1          splines_4.5.1
##  [88] lattice_0.22-7       survival_3.8-3       bit_4.6.0
##  [91] tidyselect_1.2.1     Biostrings_2.78.0    knitr_1.50
##  [94] reformulas_0.4.2     infotheo_1.2.0.1     gridExtra_2.3
##  [97] bookdown_0.45        IRanges_2.44.0       Seqinfo_1.0.0
## [100] stats4_4.5.1         xfun_0.53            Biobase_2.70.0
## [103] matrixStats_1.5.0    stringi_1.8.7        yaml_2.3.10
## [106] boot_1.3-32          evaluate_1.0.5       codetools_0.2-20
## [109] archive_1.1.12       BiocManager_1.30.26  cli_3.6.5
## [112] Rdpack_2.6.4         jquerylib_0.1.4      mlr3learners_0.13.0
## [115] dichromat_2.0-0.1    Rcpp_1.1.0           globals_0.18.0
## [118] parallel_4.5.1       prettyunits_1.2.0    paradox_1.0.1
## [121] lme4_1.1-37          listenv_0.9.1        glmnet_4.1-10
## [124] lmerTest_3.1-3       scales_1.4.0         crayon_1.5.3
## [127] rlang_1.1.6          mlr3measures_1.1.0
```