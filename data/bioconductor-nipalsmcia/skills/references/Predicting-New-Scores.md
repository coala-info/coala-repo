# Predicting New MCIA scores

Max Mattessich, Joaquin Reyna, Edel Aron and Anna Konstorum

#### Compiled: February 03, 2026

# Predicting MCIA global (factor) scores for new test samples

It may be of interest to use the embedding that is calculated on a training
sample set to predict scores on a test set (or, equivalently, on new data).

After loading the `nipalsMCIA` library, we randomly split the NCI60 cancer cell
line data into training and test sets.

## Installation

```
# devel version

# install.packages("devtools")
devtools::install_github("Muunraker/nipalsMCIA", ref = "devel",
                         force = TRUE, build_vignettes = TRUE) # devel version
```

```
# release version
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("nipalsMCIA")
```

```
library(ggplot2)
library(MultiAssayExperiment)
library(nipalsMCIA)
```

## Split the data

```
data(NCI60)
set.seed(8)

num_samples <- dim(data_blocks[[1]])[1]
num_train <- round(num_samples * 0.7, 0)
train_samples <- sample.int(num_samples, num_train)

data_blocks_train <- data_blocks
data_blocks_test <- data_blocks

for (i in seq_along(data_blocks)) {
  data_blocks_train[[i]] <- data_blocks_train[[i]][train_samples, ]
  data_blocks_test[[i]] <- data_blocks_test[[i]][-train_samples, ]
}

# Split corresponding metadata
metadata_train <- data.frame(metadata_NCI60[train_samples, ],
                             row.names = rownames(data_blocks_train$mrna))
colnames(metadata_train) <- c("cancerType")

metadata_test <- data.frame(metadata_NCI60[-train_samples, ],
                            row.names = rownames(data_blocks_test$mrna))
colnames(metadata_test) <- c("cancerType")

# Create train and test mae objects
data_blocks_train_mae <- simple_mae(data_blocks_train, row_format = "sample",
                                    colData = metadata_train)
data_blocks_test_mae <- simple_mae(data_blocks_test, row_format = "sample",
                                   colData = metadata_test)
```

## Run nipalsMCIA on training data

```
MCIA_train <- nipals_multiblock(data_blocks = data_blocks_train_mae,
                                col_preproc_method = "colprofile", num_PCs = 10,
                                plots = "none", tol = 1e-9)
```

## Visualize model on training data using metadata on cancer type

The `get_metadata_colors()` function returns an assignment of a color for the
metadata columns. The `nmb_get_gs()` function returns the global scores from the
input `NipalsResult` object.

```
meta_colors <- get_metadata_colors(mcia_results = MCIA_train, color_col = 1,
                                   color_pal_params = list(option = "E"))

global_scores <- nmb_get_gs(MCIA_train)
MCIA_out <- data.frame(global_scores[, 1:2])
MCIA_out$cancerType <- nmb_get_metadata(MCIA_train)$cancerType
colnames(MCIA_out) <- c("Factor.1", "Factor.2", "cancerType")

# plot the results
ggplot(data = MCIA_out, aes(x = Factor.1, y = Factor.2, color = cancerType)) +
  geom_point(size = 3) +
  labs(title = "MCIA for NCI60 training data") +
  scale_color_manual(values = meta_colors) +
  theme_bw()
```

![](data:image/jpeg;base64...)

## Generate factor scores for test data using the MCIA\_train model

We use the function to generate new factor scores on the test
data set using the MCIA\_train model. The new dataset in the form of an MAE object
is input using the parameter `test_data`.

```
MCIA_test_scores <- predict_gs(mcia_results = MCIA_train,
                               test_data = data_blocks_test_mae)
```

## Visualize new scores with old

We once again plot the top two factor scores for both the training and test
datasets

```
MCIA_out_test <- data.frame(MCIA_test_scores[, 1:2])
MCIA_out_test$cancerType <-
  MultiAssayExperiment::colData(data_blocks_test_mae)$cancerType

colnames(MCIA_out_test) <- c("Factor.1", "Factor.2", "cancerType")
MCIA_out_test$set <- "test"
MCIA_out$set <- "train"
MCIA_out_full <- rbind(MCIA_out, MCIA_out_test)
rownames(MCIA_out_full) <- NULL

# plot the results
ggplot(data = MCIA_out_full,
       aes(x = Factor.1, y = Factor.2, color = cancerType, shape = set)) +
  geom_point(size = 3) +
  labs(title = "MCIA for NCI60 training and test data") +
  scale_color_manual(values = meta_colors) +
  theme_bw()
```

![](data:image/jpeg;base64...)

# Session Info

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
## [1] stats4    grid      stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] MultiAssayExperiment_1.36.1 SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.1
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           stringr_1.6.0
## [13] nipalsMCIA_1.8.1            ggpubr_0.6.2
## [15] ggplot2_4.0.2               fgsea_1.36.2
## [17] dplyr_1.2.0                 ComplexHeatmap_2.26.1
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rlang_1.1.7          magrittr_2.0.4       clue_0.3-66
##  [4] GetoptLong_1.1.0     otel_0.2.0           compiler_4.5.2
##  [7] png_0.1-8            vctrs_0.7.1          pkgconfig_2.0.3
## [10] shape_1.4.6.1        crayon_1.5.3         fastmap_1.2.0
## [13] backports_1.5.0      magick_2.9.0         XVector_0.50.0
## [16] labeling_0.4.3       rmarkdown_2.30       pracma_2.4.6
## [19] tinytex_0.58         purrr_1.2.1          xfun_0.56
## [22] cachem_1.1.0         jsonlite_2.0.0       DelayedArray_0.36.0
## [25] BiocParallel_1.44.0  broom_1.0.12         parallel_4.5.2
## [28] cluster_2.1.8.1      R6_2.6.1             bslib_0.10.0
## [31] stringi_1.8.7        RColorBrewer_1.1-3   car_3.1-5
## [34] jquerylib_0.1.4      Rcpp_1.1.1           bookdown_0.46
## [37] iterators_1.0.14     knitr_1.51           BiocBaseUtils_1.12.0
## [40] Matrix_1.7-4         tidyselect_1.2.1     dichromat_2.0-0.1
## [43] abind_1.4-8          yaml_2.3.12          doParallel_1.0.17
## [46] codetools_0.2-20     lattice_0.22-7       tibble_3.3.1
## [49] withr_3.0.2          S7_0.2.1             evaluate_1.0.5
## [52] circlize_0.4.17      pillar_1.11.1        BiocManager_1.30.27
## [55] carData_3.0-6        foreach_1.5.2        scales_1.4.0
## [58] glue_1.8.0           tools_4.5.2          data.table_1.18.2.1
## [61] RSpectra_0.16-2      ggsignif_0.6.4       fastmatch_1.1-8
## [64] cowplot_1.2.0        Cairo_1.7-0          tidyr_1.3.2
## [67] colorspace_2.1-2     Formula_1.2-5        cli_3.6.5
## [70] S4Arrays_1.10.1      viridisLite_0.4.2    gtable_0.3.6
## [73] rstatix_0.7.3        sass_0.4.10          digest_0.6.39
## [76] SparseArray_1.10.8   rjson_0.2.23         farver_2.1.2
## [79] htmltools_0.5.9      lifecycle_1.0.5      GlobalOptions_0.1.3
```