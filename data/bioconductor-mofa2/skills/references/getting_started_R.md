# MOFA2: training a model in R

Ricard Argelaguet1\* and Britta Velten2\*\*

1European Bioinformatics Institute, Cambridge, UK
2German Cancer Research Center, Heidelberg, Germany

\*ricard@ebi.ac.uk
\*\*b.velten@dkfz-heidelberg.de

#### 2026-02-03

This vignette contains a detailed tutorial on how to train a MOFA model using R.
A concise template script can be found [here](https://github.com/bioFAM/MOFA2/blob/87e615bf0d49481821bd03cb32baa5d2e66ad6d8/inst/scripts/template_script.R).
Many more examples on application of MOFA to various multi-omics data sets can be found [here](https://biofam.github.io/MOFA2/tutorials.html).

# 1 Load libraries

```
library(data.table)
library(MOFA2)
```

# 2 Is MOFA the right method for my data?

MOFA (and factor analysis models in general) are useful to uncover variation
in complex data sets that contain multiple sources of heterogeneity.
This requires a **relatively large sample size (at least ~15 samples)**.
In addition, MOFA needs the multi-modal measurements to be derived **from the same samples**. It is fine if you have samples that are missing some data modality,
but there has to be a significant degree of matched measurements.

# 3 Preprocessing the data

## 3.1 Normalisation

Proper normalisation of the data is critical.
**The model can handle three types of data**:
continuous (modelled with a gaussian likelihood),
small counts (modelled with a Poisson likelihood)
and binary measurements (modelled with a bernoulli likelihood).
Non-gaussian likelihoods give non-optimal results,
we recommend the user to apply data transformations to obtain continuous measurements.
For example, for count-based data such as RNA-seq or ATAC-seq we recommend
size factor normalisation + variance stabilisation (i.e. a log transformation).

## 3.2 Feature selection

It is strongly recommended that you select **highly variable features (HVGs) per assay**
before fitting the model. This ensures a faster training and a more robust inference
procedure. Also, for data modalities that have very different dimensionalities we
suggest a stronger feature selection fort he bigger views, with the aim of
reducing the feature imbalance between data modalities.

# 4 Create the MOFA object

To create a MOFA object you need to specify three dimensions: samples, features and view(s).
Optionally, a group can also be specified for each sample (no group structure by default).
MOFA objects can be created from a wide range of input formats, including:

* **a list of matrices**: this is recommended for relatively simple data.
* **a long data.frame**: this is recommended for complex data sets with
  multiple views and/or groups.
* **MultiAssayExperiment**: to connect with Bioconductor objects.
* **Seurat**: for single-cell genomics users.
  See [this vignette](https://raw.githack.com/bioFAM/MOFA2/master/MOFA2/vignettes/scRNA_gastrulation.html)

## 4.1 List of matrices

A list of matrices, where each entry corresponds to one view.
Samples are stored in columns and features in rows.

Let’s simulate some data to start with

```
data <- make_example_data(
  n_views = 2,
  n_samples = 200,
  n_features = 1000,
  n_factors = 10
)[[1]]

lapply(data,dim)
```

```
## $view_1
## [1] 1000  200
##
## $view_2
## [1] 1000  200
```

Create the MOFA object:

```
MOFAobject <- create_mofa(data)
```

Plot the data overview

```
plot_data_overview(MOFAobject)
```

![](data:image/png;base64...)

In case you are using the multi-group functionality, the groups can be specified
using the `groups` argument as a vector with the group ID for each sample.
Keep in mind that the multi-group functionality is a rather advanced option that we
discourage for beginners. For more details on how the multi-group inference works,
read the [FAQ section](https://biofam.github.io/MOFA2/faq.html) and
[check this vignette](https://raw.githack.com/bioFAM/MOFA2/master/MOFA2/vignettes/scRNA_gastrulation.html).

```
N = ncol(data[[1]])
groups = c(rep("A",N/2), rep("B",N/2))

MOFAobject <- create_mofa(data, groups=groups)
```

Plot the data overview

```
plot_data_overview(MOFAobject)
```

![](data:image/png;base64...)

## 4.2 Long data.frame

A long data.frame with columns `sample`, `feature`, `view`, `group` (optional), `value`
might be the best format for complex data sets with multiple omics and potentially multiple groups of data. Also, there is no need to add rows that correspond to missing data:

```
filepath <- system.file("extdata", "test_data.RData", package = "MOFA2")
load(filepath)

head(dt)
```

```
##              sample          feature   view value
##              <char>           <char> <char> <num>
## 1: sample_0_group_1 feature_0_view_0 view_0  2.08
## 2: sample_1_group_1 feature_0_view_0 view_0  0.01
## 3: sample_2_group_1 feature_0_view_0 view_0 -0.11
## 4: sample_3_group_1 feature_0_view_0 view_0 -0.82
## 5: sample_4_group_1 feature_0_view_0 view_0 -1.13
## 6: sample_5_group_1 feature_0_view_0 view_0 -0.25
```

Create the MOFA object

```
MOFAobject <- create_mofa(dt)
```

```
## Creating MOFA object from a data.frame...
```

```
print(MOFAobject)
```

```
## Untrained MOFA model with the following characteristics:
##  Number of views: 2
##  Views names: view_0 view_1
##  Number of features (per view): 1000 1000
##  Number of groups: 1
##  Groups names: single_group
##  Number of samples (per group): 100
##
```

Plot data overview

```
plot_data_overview(MOFAobject)
```

![](data:image/png;base64...)

# 5 Define options

## 5.1 Define data options

* **scale\_groups**: if groups have different ranges/variances,
  it is good practice to scale each group to unit variance. Default is `FALSE`
* **scale\_views**: if views have different ranges/variances,
  it is good practice to scale each view to unit variance. Default is `FALSE`

```
data_opts <- get_default_data_options(MOFAobject)
head(data_opts)
```

```
## $scale_views
## [1] FALSE
##
## $scale_groups
## [1] FALSE
##
## $center_groups
## [1] TRUE
##
## $use_float32
## [1] TRUE
##
## $views
## [1] "view_0" "view_1"
##
## $groups
## [1] "single_group"
```

## 5.2 Define model options

* **num\_factors**: number of factors
* **likelihoods**: likelihood per view (options are “gaussian”, “poisson”, “bernoulli”).
  Default is “gaussian”.
* **spikeslab\_factors**: use spike-slab sparsity prior in the factors?
  Default is `FALSE`.
* **spikeslab\_weights**: use spike-slab sparsity prior in the weights?
  Default is `TRUE`.
* **ard\_factors**: use ARD prior in the factors?
  Default is `TRUE` if using multiple groups.
* **ard\_weights**: use ARD prior in the weights?
  Default is `TRUE` if using multiple views.

Only change the default model options if you are familiar
with the underlying mathematical model.

```
model_opts <- get_default_model_options(MOFAobject)
model_opts$num_factors <- 10
head(model_opts)
```

```
## $likelihoods
##     view_0     view_1
## "gaussian" "gaussian"
##
## $num_factors
## [1] 10
##
## $spikeslab_factors
## [1] FALSE
##
## $spikeslab_weights
## [1] FALSE
##
## $ard_factors
## [1] FALSE
##
## $ard_weights
## [1] TRUE
```

## 5.3 Define training options

* **maxiter**: number of iterations. Default is 1000.
* **convergence\_mode**: “fast” (default), “medium”, “slow”.
  For exploration, the fast mode is sufficient. For a final model,
  consider using medium" or even “slow”, but hopefully results should not change much.
* **gpu\_mode**: use GPU mode?
  (needs [cupy](https://cupy.chainer.org/) installed and a functional GPU).
* **verbose**: verbose mode?

```
train_opts <- get_default_training_options(MOFAobject)
head(train_opts)
```

```
## $maxiter
## [1] 1000
##
## $convergence_mode
## [1] "fast"
##
## $drop_factor_threshold
## [1] -1
##
## $verbose
## [1] FALSE
##
## $startELBO
## [1] 1
##
## $freqELBO
## [1] 5
```

# 6 Build and train the MOFA object

Prepare the MOFA object

```
MOFAobject <- prepare_mofa(
  object = MOFAobject,
  data_options = data_opts,
  model_options = model_opts,
  training_options = train_opts
)
```

Train the MOFA model. Remember that in this step the `MOFA2` R package connets with the
`mofapy2` Python package using `reticulate`. This is the source of most problems when
running MOFA. See our [FAQ section](https://biofam.github.io/MOFA2/faq.html)
if you have issues. The output is saved in the file specified as `outfile`. If none is specified, the output is saved in a temporary location.

```
outfile = file.path(tempdir(),"model.hdf5")
MOFAobject.trained <- run_mofa(MOFAobject, outfile, use_basilisk=TRUE)
```

```
## Warning: Output file /tmp/RtmpGoV8q6/model.hdf5 already exists, it will be replaced
```

```
## Connecting to the mofapy2 package using basilisk.
##     Set 'use_basilisk' to FALSE if you prefer to manually set the python binary using 'reticulate'.
```

If everything is successful, you should observe an output analogous to the following:

```
######################################
## Training the model with seed 1 ##
######################################

Iteration 1: time=0.03, ELBO=-52650.68, deltaELBO=837116.802 (94.082647669%), Factors=10

(...)

Iteration 9: time=0.04, ELBO=-50114.43, deltaELBO=23.907 (0.002686924%), Factors=10

#######################
## Training finished ##
#######################

Saving model in `/var/folders/.../model.hdf5.../tmp/RtmpGoV8q6/model.hdf5.
```

# 7 Downstream analysis

This finishes the tutorial on how to train a MOFA object from R.
To continue with the downstream analysis, follow [this tutorial](https://raw.githack.com/bioFAM/MOFA2_tutorials/master/R_tutorials/downstream_analysis.html)

**Session Info**

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] data.table_1.18.2.1 pheatmap_1.0.13     lubridate_1.9.4
##  [4] forcats_1.0.1       stringr_1.6.0       dplyr_1.2.0
##  [7] purrr_1.2.1         readr_2.1.6         tidyr_1.3.2
## [10] tibble_3.3.1        ggplot2_4.0.2       tidyverse_2.0.0
## [13] MOFA2_1.20.2        BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1      farver_2.1.2          filelock_1.0.3
##  [4] S7_0.2.1              fastmap_1.2.0         GGally_2.4.0
##  [7] digest_0.6.39         timechange_0.4.0      lifecycle_1.0.5
## [10] magrittr_2.0.4        compiler_4.5.2        rlang_1.1.7
## [13] sass_0.4.10           tools_4.5.2           yaml_2.3.12
## [16] corrplot_0.95         knitr_1.51            ggsignif_0.6.4
## [19] S4Arrays_1.10.1       labeling_0.4.3        reticulate_1.44.1
## [22] DelayedArray_0.36.0   plyr_1.8.9            RColorBrewer_1.1-3
## [25] abind_1.4-8           HDF5Array_1.38.0      Rtsne_0.17
## [28] withr_3.0.2           BiocGenerics_0.56.0   grid_4.5.2
## [31] stats4_4.5.2          ggpubr_0.6.2          Rhdf5lib_1.32.0
## [34] scales_1.4.0          dichromat_2.0-0.1     tinytex_0.58
## [37] cli_3.6.5             mvtnorm_1.3-3         rmarkdown_2.30
## [40] generics_0.1.4        otel_0.2.0            RSpectra_0.16-2
## [43] reshape2_1.4.5        tzdb_0.5.0            cachem_1.1.0
## [46] rhdf5_2.54.1          splines_4.5.2         parallel_4.5.2
## [49] BiocManager_1.30.27   XVector_0.50.0        matrixStats_1.5.0
## [52] basilisk_1.22.0       vctrs_0.7.1           Matrix_1.7-4
## [55] carData_3.0-6         jsonlite_2.0.0        dir.expiry_1.18.0
## [58] car_3.1-5             bookdown_0.46         IRanges_2.44.0
## [61] hms_1.1.4             S4Vectors_0.48.0      ggrepel_0.9.6
## [64] rstatix_0.7.3         Formula_1.2-5         magick_2.9.0
## [67] h5mread_1.2.1         jquerylib_0.1.4       glue_1.8.0
## [70] codetools_0.2-20      ggstats_0.12.0        cowplot_1.2.0
## [73] uwot_0.2.4            RcppAnnoy_0.0.23      stringi_1.8.7
## [76] gtable_0.3.6          pillar_1.11.1         htmltools_0.5.9
## [79] rhdf5filters_1.22.0   R6_2.6.1              evaluate_1.0.5
## [82] lattice_0.22-7        backports_1.5.0       png_0.1-8
## [85] broom_1.0.12          bslib_0.10.0          Rcpp_1.1.1
## [88] nlme_3.1-168          SparseArray_1.10.8    mgcv_1.9-4
## [91] xfun_0.56             MatrixGenerics_1.22.0 pkgconfig_2.0.3
```