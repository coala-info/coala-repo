# SCFA package manual

Duc Tran

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Using SCFA](#using-scfa)
  + [3.1 Preparing data](#preparing-data)
  + [3.2 Subtyping](#subtyping)
  + [3.3 Predicting risk score](#predicting-risk-score)

# 1 Introduction

Cancer is an umbrella term that includes a range of disorders, from those that are fast-growing and lethal to indolent lesions with low or delayed potential for progression to death. One critical unmet challenge is that molecular disease subtypes characterized by relevant clinical differences, such as survival, are difficult to differentiate. With the advancement of multi-omics technologies, subtyping methods have shifted toward data integration in order to differentiate among subtypes from a holistic perspective that takes into consideration phenomena at multiple levels. However, these integrative methods are still limited by their statistical assumption and their sensitivity to noise. In addition, they are unable to predict the risk scores of patients using multi-omics data.

To address this problem, we introduce Subtyping via Consensus Factor Analysis (SCFA), a novel method for cancer subtyping and risk prediction using consensus factor analysis. SCFA follows a three-stage hierarchical process to ensure the robustness of the discovered subtypes. First, the method uses an autoencoder to filter out genes with an insignificant contribution in characterizing each patient. Second, it applies a modified factor analysis to generate a collection of factor representations of the high-dimensional multi-omics data. Finally, it utilizes a consensus ensemble to find subtypes that are shared across all factor representations.

# 2 Installation

To install `SCFA`, you need to install the R pacakge from Bioconductor.

```
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")

BiocManager::install("SCFA")
```

SCFA depends on the `torch` package to build and train the autoencoders. When SCFA package is loaded, it will check for the availability of `C++ libtorch`. `torch` package can be used to install `C++ libtorch`, which is necessary for neural network computation.

```
library(SCFA)

# If libtorch is not automatically installed by torch, it can be installed manually using:
torch::install_torch()
```

# 3 Using SCFA

## 3.1 Preparing data

Load the example data `GBM`. `GBM` is the Glioblastoma cancer dataset.

```
#Load required library
library(SCFA)
```

```
## libtorch is not installed. Use `torch::install_torch()` to download and install libtorch
```

```
library(survival)

# Load example data (GBM dataset), for other dataset, download the rds file from the Data folder at https://bioinformatics.cse.unr.edu/software/scfa/Data/ and load the rds object
data("GBM")
# List of one matrix of microRNA data, other examples would have 3 matrices of 3 data types
dataList <- GBM$data
# Survival information
survival <- GBM$survival
```

## 3.2 Subtyping

We can use the main funtion `SCFA` to generate subtypes from multi-omics data. The input of this function is a list of matrices from different data types. Each matrix has rows as samples and columns as features. The output of this function is subtype assignment for each patient. We can perform survival analysis to determine the significance in survival differences between discovered subtypes.

```
# Generating subtyping result
set.seed(1)
subtype <- SCFA(dataList, seed = 1, ncores = 4L)

# Perform survival analysis on the result
coxFit <- coxph(Surv(time = Survival, event = Death) ~ as.factor(subtype), data = survival, ties="exact")
coxP <- round(summary(coxFit)$sctest[3],digits = 20)
print(coxP)
```

```
##     pvalue
## 0.01213664
```

## 3.3 Predicting risk score

We can use the function `SCFA.class` to predict risk score of patients using available survival information from training data. We need to provide the function with training data with survival information, and testing data. The output is the risk score of each patient. Patient with higher risk scores have higher probablity to experience event before the other patient. Concordance index is use to confirm the correlation between predicted risk scores and survival information.

```
# Split data to train and test
set.seed(1)
idx <- sample.int(nrow(dataList[[1]]), round(nrow(dataList[[1]])/2) )

survival$Survival <- survival$Survival - min(survival$Survival) + 1 # Survival time must be positive

trainList <- lapply(dataList, function(x) x[idx, ] )
trainSurvival <- Surv(time = survival[idx,]$Survival, event =  survival[idx,]$Death)

testList <- lapply(dataList, function(x) x[-idx, ] )
testSurvival <- Surv(time = survival[-idx,]$Survival, event =  survival[-idx,]$Death)

# Perform risk prediction
result <- SCFA.class(trainList, trainSurvival, testList, seed = 1, ncores = 4L)

# Validation using concordance index
c.index <- survival::concordance(coxph(testSurvival ~ result))$concordance
print(c.index)
```

```
## [1] 0.5783241
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
## [1] survival_3.8-3   SCFA_1.20.0      knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4        glmnet_4.1-10       bit_4.6.0
##  [4] jsonlite_2.0.0      compiler_4.5.1      BiocManager_1.30.26
##  [7] psych_2.5.6         Rcpp_1.1.0          parallel_4.5.1
## [10] callr_3.7.6         cluster_2.1.8.1     jquerylib_0.1.4
## [13] splines_4.5.1       BiocParallel_1.44.0 RhpcBLASctl_0.23-42
## [16] yaml_2.3.10         fastmap_1.2.0       lattice_0.22-7
## [19] R6_2.6.1            igraph_2.2.1        shape_1.4.6.1
## [22] iterators_1.0.14    bookdown_0.45       snow_0.4-4
## [25] bslib_0.9.0         rlang_1.1.6         cachem_1.1.0
## [28] xfun_0.53           sass_0.4.10         bit64_4.6.0-1
## [31] cli_3.6.5           magrittr_2.0.4      ps_1.9.1
## [34] digest_0.6.37       foreach_1.5.2       grid_4.5.1
## [37] processx_3.8.6      torch_0.16.1        nlme_3.1-168
## [40] lifecycle_1.0.4     coro_1.1.0          mnormt_2.1.1
## [43] evaluate_1.0.5      codetools_0.2-20    rmarkdown_2.30
## [46] matrixStats_1.5.0   pkgconfig_2.0.3     tools_4.5.1
## [49] htmltools_0.5.8.1
```