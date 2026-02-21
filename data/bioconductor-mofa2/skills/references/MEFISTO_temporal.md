# Illustration of MEFISTO on simulated data with a temporal covariate

Britta Velten1\*

1German Cancer Research Center, Heidelberg, Germany

\*b.velten@dkfz-heidelberg.de

#### 2026-02-03

```
library(MOFA2)
library(tidyverse)
library(pheatmap)
```

# 1 Temporal data: Simulate an example data set

To illustrate the MEFISTO method in MOFA2 we simulate a small example data set with 4 different views and one covariates defining a timeline using `make_example_data`. The simulation is based on 4 factors, two of which vary smoothly along the covariate (with different lengthscales) and two are independent of the covariate.

```
set.seed(2020)

# set number of samples and time points
N <- 200
time <- seq(0,1,length.out = N)

# generate example data
dd <- make_example_data(sample_cov = time, n_samples = N,
                        n_factors = 4, n_features = 200, n_views = 4,
                        lscales = c(0.5, 0.2, 0, 0))
# input data
data <- dd$data

# covariate matrix with samples in columns
time <- dd$sample_cov
rownames(time) <- "time"
```

Let’s have a look at the simulated latent temporal processes, which we want to recover:

```
df <- data.frame(dd$Z, t(time))
df <- gather(df, key = "factor", value = "value", starts_with("simulated_factor"))
ggplot(df, aes(x = time, y = value)) + geom_point() + facet_grid(~factor)
```

![](data:image/png;base64...)

# 2 MEFISTO framework

Using the MEFISTO framework is very similar to using MOFA2. In addition to the omics data, however, we now additionally specify the time points for each sample. If you are not familiar with the MOFA2 framework, it might be helpful to have a look at [MOFA2 tutorials](https://biofam.github.io/MOFA2/tutorials.html) first.

## 2.1 Create a MOFA object with covariates

To create the MOFA object we need to specify the training data and the covariates for pattern detection and inference of smooth factors. Here, `sample_cov` is a matrix with samples in columns and one row containing the time points. The sample order must match the order in data columns. Alternatively, a data frame can be provided containing one `sample` columns with samples names matching the sample names in the data.

First, we start by creating a standard MOFA model.

```
sm <- create_mofa(data = dd$data)
```

```
## Creating MOFA object from a list of matrices (features as rows, sample as columns)...
```

Now, we can add the additional temporal covariate, that we want to use for training.

```
sm <- set_covariates(sm, covariates = time)
sm
```

```
## Untrained MEFISTO model with the following characteristics:
##  Number of views: 4
##  Views names: view_1 view_2 view_3 view_4
##  Number of features (per view): 200 200 200 200
##  Number of groups: 1
##  Groups names: group1
##  Number of samples (per group): 200
##  Number of covariates per sample: 1
##
```

We now successfully created a MOFA object that contains 4 views, 1 group and 1 covariate giving the time point for each sample.

## 2.2 Prepare a MOFA object

Before training, we can specify various options for the model, the training and the data preprocessing. If no options are specified, the model will use the default options. See also `get_default_data_options`, `get_default_model_options` and `get_default_training_options` to have a look at the defaults and change them where required. For illustration, we only use a small number of iterations.

Importantly, to activate the use of the covariate for a functional decomposition (MEFISTO) we now additionally to the standard MOFA options need to specify `mefisto_options`. For this you can just use the default options (`get_default_mefisto_options`), unless you want to make use of advanced options such as alignment across groups.

```
data_opts <- get_default_data_options(sm)

model_opts <- get_default_model_options(sm)
model_opts$num_factors <- 4

train_opts <- get_default_training_options(sm)
train_opts$maxiter <- 100

mefisto_opts <- get_default_mefisto_options(sm)

sm <- prepare_mofa(sm, model_options = model_opts,
                   mefisto_options = mefisto_opts,
                   training_options = train_opts,
                   data_options = data_opts)
```

## 2.3 Run MOFA

Now, the MOFA object is ready for training. Using `run_mofa` we can fit the model, which is saved in the file specified as `outfile`. If none is specified the output is saved in a temporary location.

```
outfile = file.path(tempdir(),"model.hdf5")
sm <- run_mofa(sm, outfile, use_basilisk = TRUE)
```

```
##
##         #########################################################
##         ###           __  __  ____  ______                    ###
##         ###          |  \/  |/ __ \|  ____/\    _             ###
##         ###          | \  / | |  | | |__ /  \ _| |_           ###
##         ###          | |\/| | |  | |  __/ /\ \_   _|          ###
##         ###          | |  | | |__| | | / ____ \|_|            ###
##         ###          |_|  |_|\____/|_|/_/    \_\              ###
##         ###                                                   ###
##         #########################################################
##
##
##
## use_float32 set to True: replacing float64 arrays by float32 arrays to speed up computations...
##
## Successfully loaded view='view_1' group='group1' with N=200 samples and D=200 features...
## Successfully loaded view='view_2' group='group1' with N=200 samples and D=200 features...
## Successfully loaded view='view_3' group='group1' with N=200 samples and D=200 features...
## Successfully loaded view='view_4' group='group1' with N=200 samples and D=200 features...
##
##
## Loaded 1 covariate(s) for each sample...
##
##
## Model options:
## - Automatic Relevance Determination prior on the factors: False
## - Automatic Relevance Determination prior on the weights: True
## - Spike-and-slab prior on the factors: False
## - Spike-and-slab prior on the weights: False
## Likelihoods:
## - View 0 (view_1): gaussian
## - View 1 (view_2): gaussian
## - View 2 (view_3): gaussian
## - View 3 (view_4): gaussian
##
##
##
##
## ######################################
## ## Training the model with seed 42 ##
## ######################################
##
##
## ELBO before training: -668156.68
##
## Iteration 1: time=0.03, ELBO=-112628.54, deltaELBO=555528.137 (83.14339377%), Factors=4
## Iteration 2: time=0.02, Factors=4
## Iteration 3: time=0.02, Factors=4
## Iteration 4: time=0.02, Factors=4
## Iteration 5: time=0.02, Factors=4
## Iteration 6: time=0.02, ELBO=-60038.14, deltaELBO=52590.398 (7.87096789%), Factors=4
## Iteration 7: time=0.02, Factors=4
## Iteration 8: time=0.02, Factors=4
## Iteration 9: time=0.02, Factors=4
## Iteration 10: time=0.02, Factors=4
## Iteration 11: time=0.02, ELBO=-59874.42, deltaELBO=163.718 (0.02450296%), Factors=4
## Iteration 12: time=0.02, Factors=4
## Iteration 13: time=0.02, Factors=4
## Iteration 14: time=0.02, Factors=4
## Iteration 15: time=0.02, Factors=4
## Iteration 16: time=0.02, ELBO=-59706.33, deltaELBO=168.096 (0.02515810%), Factors=4
## Iteration 17: time=0.02, Factors=4
## Iteration 18: time=0.02, Factors=4
## Iteration 19: time=0.02, Factors=4
## Optimising sigma node...
## Iteration 20: time=2.79, Factors=4
## Iteration 21: time=0.02, ELBO=-58693.09, deltaELBO=1013.237 (0.15164655%), Factors=4
## Iteration 22: time=0.02, Factors=4
## Iteration 23: time=0.02, Factors=4
## Iteration 24: time=0.02, Factors=4
## Iteration 25: time=0.02, Factors=4
## Iteration 26: time=0.02, ELBO=-58472.73, deltaELBO=220.363 (0.03298072%), Factors=4
## Iteration 27: time=0.02, Factors=4
## Iteration 28: time=0.02, Factors=4
## Iteration 29: time=0.02, Factors=4
## Optimising sigma node...
## Iteration 30: time=2.27, Factors=4
## Iteration 31: time=0.02, ELBO=-58287.07, deltaELBO=185.663 (0.02778738%), Factors=4
## Iteration 32: time=0.02, Factors=4
## Iteration 33: time=0.02, Factors=4
## Iteration 34: time=0.02, Factors=4
## Iteration 35: time=0.02, Factors=4
## Iteration 36: time=0.02, ELBO=-58181.32, deltaELBO=105.749 (0.01582698%), Factors=4
## Iteration 37: time=0.02, Factors=4
## Iteration 38: time=0.02, Factors=4
## Iteration 39: time=0.02, Factors=4
## Optimising sigma node...
## Iteration 40: time=2.28, Factors=4
## Iteration 41: time=0.02, ELBO=-58026.90, deltaELBO=154.422 (0.02311168%), Factors=4
## Iteration 42: time=0.02, Factors=4
## Iteration 43: time=0.02, Factors=4
## Iteration 44: time=0.02, Factors=4
## Iteration 45: time=0.02, Factors=4
## Iteration 46: time=0.02, ELBO=-57938.98, deltaELBO=87.920 (0.01315853%), Factors=4
## Iteration 47: time=0.02, Factors=4
## Iteration 48: time=0.02, Factors=4
## Iteration 49: time=0.02, Factors=4
## Optimising sigma node...
## Iteration 50: time=2.28, Factors=4
## Iteration 51: time=0.02, ELBO=-57831.58, deltaELBO=107.392 (0.01607286%), Factors=4
## Iteration 52: time=0.02, Factors=4
## Iteration 53: time=0.02, Factors=4
## Iteration 54: time=0.02, Factors=4
## Iteration 55: time=0.02, Factors=4
## Iteration 56: time=0.02, ELBO=-57760.45, deltaELBO=71.133 (0.01064609%), Factors=4
## Iteration 57: time=0.02, Factors=4
## Iteration 58: time=0.02, Factors=4
## Iteration 59: time=0.02, Factors=4
## Optimising sigma node...
## Iteration 60: time=1.81, Factors=4
## Iteration 61: time=0.02, ELBO=-57683.57, deltaELBO=76.884 (0.01150688%), Factors=4
## Iteration 62: time=0.02, Factors=4
## Iteration 63: time=0.02, Factors=4
## Iteration 64: time=0.02, Factors=4
## Iteration 65: time=0.02, Factors=4
## Iteration 66: time=0.02, ELBO=-57646.15, deltaELBO=37.413 (0.00559944%), Factors=4
## Iteration 67: time=0.02, Factors=4
## Iteration 68: time=0.02, Factors=4
## Iteration 69: time=0.02, Factors=4
## Optimising sigma node...
## Iteration 70: time=1.98, Factors=4
## Iteration 71: time=0.02, ELBO=-57618.65, deltaELBO=27.501 (0.00411601%), Factors=4
## Iteration 72: time=0.02, Factors=4
## Iteration 73: time=0.02, Factors=4
## Iteration 74: time=0.02, Factors=4
## Iteration 75: time=0.02, Factors=4
## Iteration 76: time=0.02, ELBO=-57601.36, deltaELBO=17.293 (0.00258813%), Factors=4
## Iteration 77: time=0.02, Factors=4
## Iteration 78: time=0.02, Factors=4
## Iteration 79: time=0.02, Factors=4
## Optimising sigma node...
## Iteration 80: time=2.47, Factors=4
## Iteration 81: time=0.02, ELBO=-57581.25, deltaELBO=20.111 (0.00300999%), Factors=4
## Iteration 82: time=0.02, Factors=4
## Iteration 83: time=0.02, Factors=4
## Iteration 84: time=0.02, Factors=4
## Iteration 85: time=0.02, Factors=4
## Iteration 86: time=0.02, ELBO=-57565.76, deltaELBO=15.488 (0.00231797%), Factors=4
## Iteration 87: time=0.02, Factors=4
## Iteration 88: time=0.02, Factors=4
## Iteration 89: time=0.02, Factors=4
## Optimising sigma node...
## Iteration 90: time=2.34, Factors=4
## Iteration 91: time=0.02, ELBO=-57548.36, deltaELBO=17.405 (0.00260489%), Factors=4
## Iteration 92: time=0.02, Factors=4
## Iteration 93: time=0.02, Factors=4
## Iteration 94: time=0.02, Factors=4
## Iteration 95: time=0.02, Factors=4
## Iteration 96: time=0.02, ELBO=-57534.17, deltaELBO=14.187 (0.00212331%), Factors=4
## Iteration 97: time=0.02, Factors=4
## Iteration 98: time=0.02, Factors=4
## Iteration 99: time=0.02, Factors=4
##
##
## #######################
## ## Training finished ##
## #######################
##
##
## Saving model in /tmp/RtmpGoV8q6/model.hdf5...
```

## 2.4 Down-stream analysis

### 2.4.1 Variance explained per factor

Using `plot_variance_explained` we can explore which factor is active in which view. `plot_factor_cor` shows us whether the factors are correlated.

```
plot_variance_explained(sm)
```

![](data:image/png;base64...)

```
r <- plot_factor_cor(sm)
```

![](data:image/png;base64...)

### 2.4.2 Relate factors to the covariate

The MOFA model has learnt scale parameters for each factor, which give us an indication of the smoothness per factor along the covariate (here time) and are between 0 and 1. A scale of 0 means that the factor captures variation independent of time, a value close to 1 tells us that this factor varys very smoothly along time.

```
get_scales(sm)
```

```
##    Factor1    Factor2    Factor3    Factor4
## 0.00000000 0.01082415 0.99875934 0.99602045
```

In this example, we find two factors that are non-smooth and two smooth factors. Using `plot_factors_vs_cov` we can plot the factors along the time line, where we can distinguish smooth and non smooth variation along time.

```
plot_factors_vs_cov(sm, color_by = "time")
```

![](data:image/png;base64...)

For more customized plots, we can extract the underlying data containing the factor and covariate values for each sample.

```
df <- plot_factors_vs_cov(sm, color_by = "time",
                    legend = FALSE, return_data = TRUE)
head(df)
```

```
##      sample covariate value.covariate  factor value.factor  group   color_by
## 1  sample_1      time      0.00000000 Factor1   -4.7768636 group1 0.00000000
## 2  sample_1      time      0.00000000 Factor2    0.5450541 group1 0.00000000
## 3  sample_1      time      0.00000000 Factor4   -1.4026470 group1 0.00000000
## 4  sample_1      time      0.00000000 Factor3   -2.5425439 group1 0.00000000
## 5 sample_10      time      0.04522613 Factor4   -1.4980550 group1 0.04522613
## 6 sample_10      time      0.04522613 Factor2    0.1091704 group1 0.04522613
##   shape_by
## 1        1
## 2        1
## 3        1
## 4        1
## 5        1
## 6        1
```

We can compare the above plots to the factors that were simulated above and find that the model recaptured the two smooth as well as two non-smooth patterns in time. Note that factors are invariant to the sign, e.g. Factor 4 is the negative of the simulated factor but we can simply multiply the factors and its weights by -1 to obtain exactly the simulated factor.

### 2.4.3 Exploration of weights

As with standard MOFA, we can now look deeper into the meaning of these factors by exploring the weights or performing feature set enrichment analysis.

```
plot_weights(sm, factors = 4, view = 1)
```

![](data:image/png;base64...)

```
plot_top_weights(sm, factors = 3, view = 2)
```

![](data:image/png;base64...)

In addition, we can take a look at the top feature values per factor along time and see that their patterns are in line with the pattern of the corresponding Factor (here Factor 3).

```
plot_data_vs_cov(sm, factor=3,
                         features = 2,
                         color_by = "time",
                         dot_size = 1)
```

![](data:image/png;base64...)

### 2.4.4 Interpolation

Furthermore, we can interpolate or extrapolate a factor to new values. Here, we only show the mean of the prediction, to obtain uncertainties you need to specify the new values before training in `get_default_mefisto_options(sm)$new_values`.

```
sm <- interpolate_factors(sm, new_values = seq(0,1.1,0.01))
plot_interpolation_vs_covariate(sm, covariate = "time",
                                factors = "Factor3")
```

![](data:image/png;base64...)

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
##  [1] gtable_0.3.6          dir.expiry_1.18.0     xfun_0.56
##  [4] bslib_0.10.0          ggrepel_0.9.6         corrplot_0.95
##  [7] rhdf5_2.54.1          lattice_0.22-7        tzdb_0.5.0
## [10] rhdf5filters_1.22.0   vctrs_0.7.1           tools_4.5.2
## [13] generics_0.1.4        stats4_4.5.2          parallel_4.5.2
## [16] pkgconfig_2.0.3       Matrix_1.7-4          RColorBrewer_1.1-3
## [19] S7_0.2.1              S4Vectors_0.48.0      lifecycle_1.0.5
## [22] compiler_4.5.2        farver_2.1.2          tinytex_0.58
## [25] htmltools_0.5.9       sass_0.4.10           yaml_2.3.12
## [28] pillar_1.11.1         jquerylib_0.1.4       uwot_0.2.4
## [31] DelayedArray_0.36.0   cachem_1.1.0          magick_2.9.0
## [34] abind_1.4-8           basilisk_1.22.0       tidyselect_1.2.1
## [37] digest_0.6.39         mvtnorm_1.3-3         Rtsne_0.17
## [40] stringi_1.8.7         reshape2_1.4.5        bookdown_0.46
## [43] labeling_0.4.3        cowplot_1.2.0         fastmap_1.2.0
## [46] grid_4.5.2            cli_3.6.5             SparseArray_1.10.8
## [49] magrittr_2.0.4        S4Arrays_1.10.1       dichromat_2.0-0.1
## [52] h5mread_1.2.1         withr_3.0.2           filelock_1.0.3
## [55] scales_1.4.0          timechange_0.4.0      rmarkdown_2.30
## [58] XVector_0.50.0        matrixStats_1.5.0     otel_0.2.0
## [61] reticulate_1.44.1     hms_1.1.4             png_0.1-8
## [64] HDF5Array_1.38.0      evaluate_1.0.5        knitr_1.51
## [67] IRanges_2.44.0        rlang_1.1.7           Rcpp_1.1.1
## [70] glue_1.8.0            BiocManager_1.30.27   BiocGenerics_0.56.0
## [73] jsonlite_2.0.0        R6_2.6.1              Rhdf5lib_1.32.0
## [76] plyr_1.8.9            MatrixGenerics_1.22.0
```