# Vignette illustrating the use of MOFA on simulated data

Britta Velten and Ricard Argelaguet

#### 2 May 2019

#### Package

MOFA 1.0.0

# Contents

* [1 Simulate an example data set](#simulate-an-example-data-set)
* [2 Prepare MOFA: Set the training and model options](#prepare-mofa-set-the-training-and-model-options)
* [3 Run MOFA](#run-mofa)
* [4 Compare different random inits and select the best model](#compare-different-random-inits-and-select-the-best-model)
* [5 Downstream analyses](#downstream-analyses)
* [6 SessionInfo](#sessioninfo)

# 1 Simulate an example data set

To illustrate the MOFA workflow we simulate a small example data set with 3 different views. `makeExampleData` generates an untrained MOFAobject containing the simulated data. If you work on your own data use `createMOFAobject` to create the untrained MOFA object (see our vignettes for CLL and scMT data).

```
library(MOFA)
```

By default the function `makeExampleData` produces a small data set containing 3 views with 100 features each and 50 samples. These parameters can be varied using the arguments `n_views`, `n_features` and `n_samples`.

```
set.seed(1234)
data <- makeExampleData()
MOFAobject <- createMOFAobject(data)
```

```
## Creating MOFA object from list of matrices,
##  please make sure that samples are columns and features are rows...
```

```
MOFAobject
```

```
## Untrained MOFA model with the following characteristics:
##   Number of views: 3
##   View names: view_1 view_2 view_3
##   Number of features per view: 100 100 100
##   Number of samples: 50
```

# 2 Prepare MOFA: Set the training and model options

Once the untrained MOFAobject was created, we can specify details on data processing, model specifications and training options such as the number of factors, the likelihood models etc. Default option can be obtained using the functions `getDefaultTrainOptions`, `getDefaultModelOptions` and `getDefaultDataOptions`. We describe details on these option in our vignettes for CLL and scMT data.

Using `prepareMOFA` the model is set up for training.

```
TrainOptions <- getDefaultTrainOptions()
ModelOptions <- getDefaultModelOptions(MOFAobject)
DataOptions <- getDefaultDataOptions()

TrainOptions$DropFactorThreshold <- 0.01
```

# 3 Run MOFA

Once the MOFAobject is set up we can use `runMOFA` to train the model. As depending on the random initilization the results might differ, we recommend to use runMOFA multiple times (e.g. ten times, here we use a smaller number for illustration as the model training can take some time). As a next step we will compare the different fits and select the best model for downstream analyses.

```
n_inits <- 3
MOFAlist <- lapply(seq_len(n_inits), function(it) {

  TrainOptions$seed <- 2018 + it

  MOFAobject <- prepareMOFA(
  MOFAobject,
  DataOptions = DataOptions,
  ModelOptions = ModelOptions,
  TrainOptions = TrainOptions
)

  runMOFA(MOFAobject)
})
```

```
## Checking data options...
```

```
## Checking training options...
```

```
## Checking model options...
```

```
## [1] "No output file provided, using a temporary file..."
```

```
## Checking data options...
```

```
## Checking training options...
```

```
## Checking model options...
```

```
## [1] "No output file provided, using a temporary file..."
```

```
## Checking data options...
```

```
## Checking training options...
```

```
## Checking model options...
```

```
## [1] "No output file provided, using a temporary file..."
```

# 4 Compare different random inits and select the best model

Having a list of trained models we can use `compareModels` to get an overview of how many factors were inferred in each run and what the optimized ELBO value is (a model with larger ELBO is preferred).

```
compareModels(MOFAlist)
```

![](data:image/png;base64...)

With `compareFactors` we can get an overview of how robust the factors are between different model instances.

```
compareFactors(MOFAlist)
```

![](data:image/png;base64...)

For down-stream analyses we recommned to choose the model with the best ELBO value as is done by `selectModel`.

```
MOFAobject <- selectModel(MOFAlist, plotit = FALSE)
MOFAobject
```

```
## Trained MOFA model with the following characteristics:
##   Number of views: 3
##  View names: view_1 view_2 view_3
##   Number of features per view: 100 100 100
##   Number of samples: 50
##   Number of factors: 5
```

# 5 Downstream analyses

On the trained MOFAobject we can now start looking into the inferred factors, its weights etc. Here the data was generated using five factors, whose activity patterns we can recover using `plotVarianceExplained`.

```
plotVarianceExplained(MOFAobject)
```

![](data:image/png;base64...)

For details on downstream analyses please have a look at the vignettes on the CLL data and scMT data.

# 6 SessionInfo

```
sessionInfo()
```

```
## R version 3.6.0 (2019-04-26)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.2 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.9-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.9-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] ggplot2_3.1.1               MOFAdata_0.99.6
##  [3] MOFA_1.0.0                  MultiAssayExperiment_1.10.0
##  [5] SummarizedExperiment_1.14.0 DelayedArray_0.10.0
##  [7] BiocParallel_1.18.0         matrixStats_0.54.0
##  [9] Biobase_2.44.0              GenomicRanges_1.36.0
## [11] GenomeInfoDb_1.20.0         IRanges_2.18.0
## [13] S4Vectors_0.22.0            BiocGenerics_0.30.0
## [15] BiocStyle_2.12.0
##
## loaded via a namespace (and not attached):
##  [1] ggrepel_0.8.0          Rcpp_1.0.1             lattice_0.20-38
##  [4] assertthat_0.2.1       digest_0.6.18          foreach_1.4.4
##  [7] R6_2.4.0               plyr_1.8.4             evaluate_0.13
## [10] pillar_1.3.1           zlibbioc_1.30.0        rlang_0.3.4
## [13] lazyeval_0.2.2         Matrix_1.2-17          reticulate_1.12
## [16] rmarkdown_1.12         labeling_0.3           stringr_1.4.0
## [19] pheatmap_1.0.12        RCurl_1.95-4.12        munsell_0.5.0
## [22] compiler_3.6.0         vipor_0.4.5            xfun_0.6
## [25] pkgconfig_2.0.2        ggbeeswarm_0.6.0       htmltools_0.3.6
## [28] tidyselect_0.2.5       tibble_2.1.1           GenomeInfoDbData_1.2.1
## [31] bookdown_0.9           codetools_0.2-16       reshape_0.8.8
## [34] withr_2.1.2            crayon_1.3.4           dplyr_0.8.0.1
## [37] bitops_1.0-6           grid_3.6.0             GGally_1.4.0
## [40] jsonlite_1.6           gtable_0.3.0           magrittr_1.5
## [43] scales_1.0.0           stringi_1.4.3          XVector_0.24.0
## [46] reshape2_1.4.3         doParallel_1.0.14      cowplot_0.9.4
## [49] Rhdf5lib_1.6.0         RColorBrewer_1.1-2     iterators_1.0.10
## [52] tools_3.6.0            glue_1.3.1             beeswarm_0.2.3
## [55] purrr_0.3.2            yaml_2.2.0             rhdf5_2.28.0
## [58] colorspace_1.4-1       BiocManager_1.30.4     corrplot_0.84
## [61] knitr_1.22
```