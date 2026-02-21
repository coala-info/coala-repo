# MOFA+: downstream analysis in R

Ricard Argelaguet1\* and Britta Velten2\*\*

1European Bioinformatics Institute, Cambridge, UK
2German Cancer Research Center, Heidelberg, Germany

\*ricard@ebi.ac.uk
\*\*b.velten@dkfz-heidelberg.de

#### 2026-02-03

# 1 Introduction

In the MOFA2 R package we provide a wide range of downstream analysis
to visualise and interpret the model output.
Here we provide a brief description of the main functionalities.
This vignette is made of simulated data and
we do not highlight biologically relevant results.
Please see our [tutorials](https://biofam.github.io/MOFA2/tutorials.html) for real use cases.

# 2 Load libraries

```
library(ggplot2)
library(MOFA2)
```

# 3 Load trained model

```
filepath <- system.file("extdata", "model.hdf5", package = "MOFA2")
model <- load_model(filepath)
```

## 3.1 Overview of data

The function `plot_data_overview` can be used to obtain an overview of the input data.
It shows how many views (rows) and how many groups (columns) exist, what are
their corresponding dimensionalities and how many missing information they have (grey bars).

```
plot_data_overview(model)
```

![](data:image/png;base64...)

# 4 Add metadata to the model

The metadata is stored as a data.frame object in `model@samples_metadata`,
and it requires at least the column `sample`.
The column `group` is required only if you are doing multi-group inference.

Let’s add some artificial metadata…

```
Nsamples = sum(get_dimensions(model)[["N"]])

sample_metadata <- data.frame(
  sample = samples_names(model)[[1]],
  condition = sample(c("A","B"), size = Nsamples, replace = TRUE),
  age = sample(1:100, size = Nsamples, replace = TRUE)
)

samples_metadata(model) <- sample_metadata
head(samples_metadata(model), n=3)
```

```
##             sample condition age        group
## 1 sample_0_group_1         A  87 single_group
## 2 sample_1_group_1         B   1 single_group
## 3 sample_2_group_1         B  17 single_group
```

# 5 Variance decomposition

The first step in the MOFA analysis is to quantify the amount
of variance explained (\(R^2\)) by each factor in each data modality.

```
# Total variance explained per view
head(get_variance_explained(model)$r2_total[[1]])
```

```
##   view_0   view_1
## 76.20973 76.97777
```

```
# Variance explained for every factor in per view
head(get_variance_explained(model)$r2_per_factor[[1]])
```

```
##              view_0      view_1
## Factor1 19.20399955 19.41070871
## Factor2 15.47560732 17.94710458
## Factor3 16.47469843 16.48996544
## Factor4 13.42094721 11.09844071
## Factor5 11.76334520 11.82572116
## Factor6  0.03885712  0.07087386
```

Variance explained estimates can be plotted using `plot_variance_explained(model, ...)`. Options:

* **factors**: character vector with a factor name(s), or numeric vector with
  the index(es) of the factor(s). Default is “all”.
* **x**: character specifying the dimension for the x-axis (“view”, “factor”, or “group”).
* **y**: character specifying the dimension for the y-axis (“view”, “factor”, or “group”).
* **split\_by**: character specifying the dimension to be faceted (“view”, “factor”, or “group”).
* **plot\_total**: logical value to indicate if to plot the total variance explained
  (for the variable in the x-axis)

In this case we have 5 active factors that explain a large amount of variation in
both data modalities.

```
plot_variance_explained(model, x="view", y="factor")
```

![](data:image/png;base64...)

The model explains ~70% of the variance in both data modalities.

```
plot_variance_explained(model, x="view", y="factor", plot_total = TRUE)[[2]]
```

![](data:image/png;base64...)

# 6 Visualisation of Factors

The MOFA factors capture the global sources of variability in the data.
Mathematically, each factor ordinates cells along a one-dimensional axis centered at zero.
The value per se is not important, only the relative positioning of samples matters.
Samples with different signs manifest opposite “effects”
along the inferred axis of variation,
with higher absolute value indicating a stronger effect.
Note that the interpretation of factors is analogous to the interpretation of the principal components in PCA.

## 6.1 Visualisation of factors one at a time

Factors can be plotted using `plot_factor` (for beeswarm plots of individual factors) or
`plot_factors` (for scatter plots of factor combinations).

```
plot_factor(model,
  factor = 1:3,
  color_by = "age",
  shape_by = "condition"
)
```

![](data:image/png;base64...)

Adding more options

```
p <- plot_factor(model,
  factors = c(1,2,3),
  color_by = "condition",
  dot_size = 3,        # change dot size
  dodge = TRUE,           # dodge points with different colors
  legend = FALSE,          # remove legend
  add_violin = TRUE,      # add violin plots,
  violin_alpha = 0.25  # transparency of violin plots
)

# The output of plot_factor is a ggplot2 object that we can edit
p <- p +
  scale_color_manual(values=c("A"="black", "B"="red")) +
  scale_fill_manual(values=c("A"="black", "B"="red"))

print(p)
```

```
## Warning: No shared levels found between `names(values)` of the manual scale and the
## data's colour values.
```

![](data:image/png;base64...)

## 6.2 Visualisation of combinations of factors

Scatter plots

```
plot_factors(model,
  factors = 1:3,
  color_by = "condition"
)
```

![](data:image/png;base64...)

# 7 Visualisation of feature weights

The weights provide a score for how strong each feature relates to each factor.
Features with no association with the factor have values close to zero,
while features with strong association with the factor have large absolute values.
The sign of the weight indicates the direction of the effect:
a positive weight indicates that the feature has higher levels in the cells with
positive factor values, and vice versa.

Weights can be plotted using `plot_weights` or `plot_top_weights`

```
plot_weights(model,
  view = "view_0",
  factor = 1,
  nfeatures = 10,     # Number of features to highlight
  scale = TRUE,          # Scale weights from -1 to 1
  abs = FALSE             # Take the absolute value?
)
```

![](data:image/png;base64...)

```
plot_top_weights(model,
  view = "view_0",
  factor = 1,
  nfeatures = 10
)
```

![](data:image/png;base64...)

# 8 Visualisation of covariation patterns in the input data

Instead of looking at weights, it is useful to observe the coordinated heterogeneity
that MOFA captures in the original data.
This can be done using the `plot_data_heatmap` and `plot_data_scatter` function.

## 8.1 Heatmaps

Heatmap of observations.
Top features are selected by its weight in the selected factor.
By default, samples are ordered according to their corresponding factor value.

```
plot_data_heatmap(model,
  view = "view_1",         # view of interest
  factor = 1,             # factor of interest
  features = 20,          # number of features to plot (they are selected by weight)

  # extra arguments that are passed to the `pheatmap` function
  cluster_rows = TRUE, cluster_cols = FALSE,
  show_rownames = TRUE, show_colnames = FALSE
)
```

![](data:image/png;base64...)

## 8.2 Scatter plots

Scatter plots of observations vs factor values.
It is useful to add a linear regression estimate to visualise
if the relationship between (top) features and factor values is linear.

```
plot_data_scatter(model,
  view = "view_1",         # view of interest
  factor = 1,             # factor of interest
  features = 5,           # number of features to plot (they are selected by weight)
  add_lm = TRUE,          # add linear regression
  color_by = "condition"
)
```

![](data:image/png;base64...)

## 8.3 Non-linear dimensionality reduction

The MOFA factors are linear (as in Principal Component analysis),
so each one captures limited amount of information,
but they can be used as input to other methods that learn compact nonlinear manifolds,
e.g. t-SNE or UMAP.

Run UMAP or t-SNE

```
set.seed(42)
model <- run_umap(model)
model <- run_tsne(model)
```

Plot (nothing too interesting in this simulated data set)

```
plot_dimred(model,
  method = "TSNE",  # method can be either "TSNE" or "UMAP"
  color_by = "condition",
  dot_size = 5
)
```

```
## Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
## of ggplot2 3.3.4.
## ℹ The deprecated feature was likely used in the MOFA2 package.
##   Please report the issue at <https://github.com/bioFAM/MOFA2>.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

# 9 Other functionalities

## 9.1 Renaming dimensions

The user can rename the dimensions of the model

```
views_names(model) <- c("Transcriptomics", "Proteomics")
factors_names(model) <- paste("Factor", 1:get_dimensions(model)$K, sep=" ")
```

```
views_names(model)
```

```
## [1] "Transcriptomics" "Proteomics"
```

## 9.2 Extracting data for downstream analysis

The user can extract the feature weights, the data and the factors to
generate their own plots.

Extract factors

```
# "factors" is a list of matrices, one matrix per group with dimensions (nsamples, nfactors)
factors <- get_factors(model, factors = "all")
lapply(factors,dim)
```

```
## $single_group
## [1] 100  10
```

Extract weights

```
# "weights" is a list of matrices, one matrix per view with dimensions (nfeatures, nfactors)
weights <- get_weights(model, views = "all", factors = "all")
lapply(weights,dim)
```

```
## $Transcriptomics
## [1] 1000   10
##
## $Proteomics
## [1] 1000   10
```

Extract data

```
# "data" is a nested list of matrices, one matrix per view and group with dimensions (nfeatures, nsamples)
data <- get_data(model)
lapply(data, function(x) lapply(x, dim))[[1]]
```

```
## $single_group
## [1] 1000  100
```

For convenience, the user can extract the data in long data.frame format:

```
factors <- get_factors(model, as.data.frame = TRUE)
head(factors, n=3)
```

```
##             sample   factor      value        group
## 1 sample_0_group_1 Factor 1 -2.0102648 single_group
## 2 sample_1_group_1 Factor 1  0.2251219 single_group
## 3 sample_2_group_1 Factor 1 -0.2968025 single_group
```

```
weights <- get_weights(model, as.data.frame = TRUE)
head(weights, n=3)
```

```
##            feature   factor        value            view
## 1 feature_0_view_0 Factor 1 -0.002225892 Transcriptomics
## 2 feature_1_view_0 Factor 1 -0.353517945 Transcriptomics
## 3 feature_2_view_0 Factor 1  0.016938729 Transcriptomics
```

```
data <- get_data(model, as.data.frame = TRUE)
head(data, n=3)
```

```
##              view        group          feature           sample value
## 1 Transcriptomics single_group feature_0_view_0 sample_0_group_1  2.08
## 2 Transcriptomics single_group feature_1_view_0 sample_0_group_1  1.10
## 3 Transcriptomics single_group feature_2_view_0 sample_0_group_1 -2.50
```

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
##  [1] pheatmap_1.0.13  lubridate_1.9.4  forcats_1.0.1    stringr_1.6.0
##  [5] dplyr_1.2.0      purrr_1.2.1      readr_2.1.6      tidyr_1.3.2
##  [9] tibble_3.3.1     ggplot2_4.0.2    tidyverse_2.0.0  MOFA2_1.20.2
## [13] BiocStyle_2.38.0
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