Code

* Show All Code
* Hide All Code

# Utilizing Mechanism-Aware Imputation (MAI)

Jonathan Dekermanjian1\*, Elin Shaddox1\*\*, Debmalya Nandy1\*\*\*, Debashis Ghosh1\*\*\*\* and Katerina Kechris1\*\*\*\*\*

1University of Colorado Anschutz Medical Campus

\*Jonathan.Dekermanjian@CUAnschutz.edu
\*\*Elin.Shaddox@CUAnschutz.edu
\*\*\*Debmalya.Nandy@CUAnschutz.edu
\*\*\*\*Debashis.Ghosh@CUAnschutz.edu
\*\*\*\*\*Katerina.Kechris@CUAnschutz.edu

#### 7/21/2021

#### Package

MAI 1.16.0

# 1 Introduction

A two-step approach to imputing missing data in metabolomics.
Step 1 uses a random forest classifier to classify missing values as
either Missing Completely at Random/Missing At Random (MCAR/MAR) or Missing
Not At Random (MNAR). MCAR/MAR are combined because it is often difficult to
distinguish these two missing types in metabolomics data. Step 2 imputes the
missing values based on the classified missing mechanisms, using the
appropriate imputation algorithms. Imputation algorithms tested and
available for MCAR/MAR include Bayesian Principal Component Analysis (BPCA),
Multiple Imputation No-Skip K-Nearest Neighbors (Multi\_nsKNN), and
Random Forest. Imputation algorithms tested and available for MNAR include
nsKNN and a single imputation approach for imputation of metabolites where
left-censoring is present.

# 2 Installation

The following code chunk depicts how to install MAI from Bioconductor

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MAI")
```

# 3 Using MAI when your data is a data.frame or matrix

```
# Load the MAI package
library(MAI)
# Load the example data with missing values
data("untargeted_LCMS_data")
# Set a seed for reproducibility
## Estimating pattern of missingness involves imposing MCAR/MAR into the data
## these are done at random and as such may slightly change the results of the
## estimated parameters.
set.seed(137690)
# Impute the data using BPCA for predicted MCAR value imputation and
# use Single imputation for predicted MNAR value imputation

Results = MAI(data_miss = untargeted_LCMS_data, # The data with missing values
          MCAR_algorithm = "BPCA", # The MCAR algorithm to use
          MNAR_algorithm = "Single", # The MNAR algorithm to use
          assay_ix = 1, # If SE, designates the assay to impute
          forest_list_args = list( # random forest arguments for training
            ntree = 300,
            proximity = FALSE
        ),
          verbose = TRUE # allows console message output
        )
```

```
## Estimating pattern of missingness
```

```
## Imposing missingness
```

```
## Generating features
```

```
## Training
```

```
## Predicting
```

```
## Imputing
```

```
# Get MAI imputations
Results[["Imputed_data"]][1:5, 1:5] # show only 5x5
```

```
##          [,1]     [,2]     [,3]     [,4]     [,5]
## [1,] 12.87164 12.70516 12.11793 12.07897 11.18725
## [2,] 12.10813 12.36043 12.08463 12.07897 14.30504
## [3,] 12.10813 11.16815 12.08463 12.07897 11.79195
## [4,] 12.01395 12.28791 12.12017 12.07897 10.05397
## [5,] 11.32825 12.55314 12.23772 11.31292 12.28869
```

```
# Get the estimated mixed missingness parameters
Results[["Estimated_Params"]]
```

```
## $Alpha
## [1] 20
##
## $Beta
## [1] 80
##
## $Gamma
## [1] 60
```

These parameters estimate the ratio of MCAR/MAR to MNAR in the data. The parameters \(\alpha\) and \(\beta\) separate high, medium, and low average abundance metabolites, while the parameter \(\gamma\) is used to impose missingness in the medium and low abundance metabolites. A smaller \(\alpha\) corresponds to more MCAR/MAR being present, while larger \(\beta\) and \(\gamma\) values imply more MNAR values being present. The returned estimated parameters are then used to impose known missingness in the complete subset of the input data. Subsequently, a random forest classifier is trained to classify the known missingness in the complete subset of the input data. Once the classifier is established it is applied to the unknown missingness of the full input data to predict the missingness. Finally, the missing values are imputed using a specific algorithm, chosen by the user, according to the predicted missingness mechanism.

# 4 Using MAI when your data is a SummarizedExperiment (SE) class

```
# Load the SummarizedExperiment package
suppressMessages(
  library(SummarizedExperiment)
)

# Load the example data with missing values
data("untargeted_LCMS_data")
# Turn the data to a SummarizedExperiment
se = SummarizedExperiment(untargeted_LCMS_data)
# Set a seed for reproducibility
## Estimating pattern of missingness involves imposing MCAR/MAR into the data
## these are done at random and as such may slightly change the results of the
## estimated parameters.
set.seed(137690)
# Impute the data using BPCA for predicted MCAR value imputation and
# use Single imputation for predicted MNAR value imputation

Results = MAI(se, # The data with missing values
          MCAR_algorithm = "BPCA", # The MCAR algorithm to use
          MNAR_algorithm= "Single", # The MNAR algorithm to use
          assay_ix = 1, # If SE, designates the assay to impute
          forest_list_args = list( # random forest arguments for training
            ntree = 300,
            proximity = FALSE
        ),
          verbose = TRUE # allows console message output
        )
```

```
## Estimating pattern of missingness
```

```
## Imposing missingness
```

```
## Generating features
```

```
## Training
```

```
## Predicting
```

```
## Imputing
```

```
# Get MAI imputations
assay(Results)[1:5, 1:5] # show only 5x5
```

```
##          [,1]     [,2]     [,3]     [,4]     [,5]
## [1,] 12.87164 12.70516 12.11793 12.07897 11.18725
## [2,] 12.10813 12.36043 12.08463 12.07897 14.30504
## [3,] 12.10813 11.16815 12.08463 12.07897 11.79195
## [4,] 12.01395 12.28791 12.12017 12.07897 10.05397
## [5,] 11.32825 12.55314 12.23772 11.31292 12.28869
```

```
# Get the estimated mixed missingness parameters
metadata(Results)[["meta_assay_1"]][["Estimated_Params"]]
```

```
## $Alpha
## [1] 20
##
## $Beta
## [1] 80
##
## $Gamma
## [1] 60
```

# 5 Session Information

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
##  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [5] IRanges_2.44.0              S4Vectors_0.48.0
##  [7] BiocGenerics_0.56.0         generics_0.1.4
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] caret_7.0-1                 lattice_0.22-7
## [13] ggplot2_4.0.0               MAI_1.16.0
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Rdpack_2.6.4         pROC_1.19.0.1        rlang_1.1.6
##  [4] magrittr_2.0.4       e1071_1.7-16         compiler_4.5.1
##  [7] vctrs_0.6.5          reshape2_1.4.4       stringr_1.5.2
## [10] pkgconfig_2.0.3      fastmap_1.2.0        XVector_0.50.0
## [13] rmarkdown_2.30       prodlim_2025.04.28   itertools_0.1-3
## [16] purrr_1.1.0          xfun_0.53            randomForest_4.7-1.2
## [19] cachem_1.1.0         jsonlite_2.0.0       recipes_1.3.1
## [22] DelayedArray_0.36.0  parallel_4.5.1       R6_2.6.1
## [25] bslib_0.9.0          stringi_1.8.7        RColorBrewer_1.1-3
## [28] ranger_0.17.0        parallelly_1.45.1    rpart_4.1.24
## [31] lubridate_1.9.4      jquerylib_0.1.4      Rcpp_1.1.0
## [34] bookdown_0.45        iterators_1.0.14     knitr_1.50
## [37] future.apply_1.20.0  Matrix_1.7-4         splines_4.5.1
## [40] nnet_7.3-20          timechange_0.3.0     tidyselect_1.2.1
## [43] dichromat_2.0-0.1    abind_1.4-8          yaml_2.3.10
## [46] timeDate_4051.111    doParallel_1.0.17    codetools_0.2-20
## [49] listenv_0.9.1        doRNG_1.8.6.2        tibble_3.3.0
## [52] plyr_1.8.9           withr_3.0.2          S7_0.2.0
## [55] evaluate_1.0.5       future_1.67.0        survival_3.8-3
## [58] proxy_0.4-27         pillar_1.11.1        BiocManager_1.30.26
## [61] rngtools_1.5.2       foreach_1.5.2        scales_1.4.0
## [64] globals_0.18.0       class_7.3-23         glue_1.8.0
## [67] tools_4.5.1          data.table_1.17.8    ModelMetrics_1.2.2.2
## [70] gower_1.0.2          grid_4.5.1           missForest_1.6.1
## [73] rbibutils_2.3        tidyverse_2.0.0      ipred_0.9-15
## [76] nlme_3.1-168         cli_3.6.5            S4Arrays_1.10.0
## [79] lava_1.8.1           dplyr_1.1.4          pcaMethods_2.2.0
## [82] gtable_0.3.6         sass_0.4.10          digest_0.6.37
## [85] SparseArray_1.10.0   farver_2.1.2         htmltools_0.5.8.1
## [88] lifecycle_1.0.4      hardhat_1.4.2        MASS_7.3-65
```

# 6 References

# Appendix

Dekermanjian, J.P., Shaddox, E., Nandy, D. et al. Mechanism-aware imputation: a two-step approach in handling missing values in metabolomics. BMC Bioinformatics 23, 179 (2022). <https://doi.org/10.1186/s12859-022-04659-1>