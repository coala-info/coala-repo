# miaSim: Microbiome Data Simulation

#### 2025-10-30

#### Package

miaSim 1.16.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Installation](#installation)
  + [1.2 Examples](#examples)
  + [1.3 Data containers](#data-containers)
  + [1.4 Case studies](#case-studies)
  + [1.5 Related work](#related-work)
* [2 Session info](#session-info)

# 1 Introduction

`miaSim` implements tools for microbiome data simulation based on
varying ecological modeling assumptions. These can be used to simulate
species abundance matrices, including time series. Detailed function
documentation is available at the [function reference](https://microbiome.github.io/miaSim/reference/index.html)

The miaSim package supports the R/Bioconductor multi-assay
framework. For more information on operating with this data format in
microbial ecology, see the [online
tutorial](https://microbiome.github.io/OMA).

## 1.1 Installation

The stable Bioconductor release version can be installed as follows.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
if (!requireNamespace("miaSim", quietly = TRUE))
    BiocManager::install("miaSim")
```

The experimental Bioconductor devel version can be installed as follows.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
# The following initializes usage of Bioc devel
BiocManager::install(version='devel')
BiocManager::install("miaSim")
```

Load the library

```
library(miaSim)
```

## 1.2 Examples

### 1.2.1 Generate species interaction matrices for the models

Some of the models rely on interaction matrices that represents interaction
heterogeneity between species. The interaction matrix can be generated with
different distributional assumptions.

Generate interactions from normal distribution:

```
A_normal <- powerlawA(n_species = 4, alpha = 3)
```

Generate interactions from uniform distribution:

```
A_uniform <- randomA(n_species = 10,
                 diagonal = -0.4,
                     connectance = 0.5,
             interactions = runif(n = 10^2, min = -0.8, max = 0.8))
```

### 1.2.2 Hubbell model

Hubbell Neutral simulation model characterizes diversity and relative
abundance of species in ecological communities assuming migration,
births and deaths but no interactions. Losses become replaced by
migration or birth.

```
tse_hubbell <- simulateHubbell(n_species = 8,
                               M = 10,
                   carrying_capacity = 1000,
                               k_events = 50,
                   migration_p = 0.02,
                   t_end = 100)
```

One can also simulate parameters for the Hubbell model.

```
params_hubbell <- simulateHubbellRates(x0 = c(0,5,10),
    migration_p = 0.1, metacommunity_probability = NULL, k_events = 1,
    growth_rates = NULL, norm = FALSE, t_end=1000)
```

### 1.2.3 Stochastic logistic model

Stochastic logistic model is used to determine dead and alive counts
in community.

```
tse_logistic <- simulateStochasticLogistic(n_species = 5)
```

### 1.2.4 Self-Organised Instability (SOI)

The Self-Organised Instability (SOI) model generates time series for
communities and accelerates stochastic simulation.

```
tse_soi <- simulateSOI(n_species = 4, carrying_capacity = 1000,
                       A = A_normal, k_events=5,
               x0 = NULL,t_end = 150, norm = TRUE)
```

### 1.2.5 Consumer-resource model

The consumer resource model requires the `randomE` function. This
returns a matrix containing the production rates and consumption rates
of each species. The resulting matrix is used as a determination of
resource consumption efficiency.

```
# Consumer-resource model as a TreeSE object
tse_crm <- simulateConsumerResource(n_species = 2,
                                    n_resources = 4,
                                    E = randomE(n_species = 2, n_resources = 4))
```

You could visualize the simulated dynamics using tools from the [miaTime](https://microbiome.github.io/miaTime/) package.

### 1.2.6 Generalized Lotka-Volterra (gLV)

The generalized Lotka-Volterra simulation model generates time-series assuming
microbial population dynamics and interaction.

```
tse_glv <- simulateGLV(n_species = 4,
                       A = A_normal,
               t_start = 0,
                       t_store = 1000,
               stochastic = FALSE,
               norm = FALSE)
```

### 1.2.7 Ricker model

Ricker model is a discrete version of the gLV:

```
tse_ricker <- simulateRicker(n_species=4, A = A_normal, t_end=100, norm = FALSE)
```

The number of species specified in the interaction matrix must be the
same as the species used in the models.

## 1.3 Data containers

The simulated data sets are returned as `TreeSummarizedExperiment`
objects. This provides access to a broad range of tools for microbiome
analysis that support this format (see
[microbiome.github.io](http://microbiome.github.io)). More examples on
the object manipulation and analysis can be found at [OMA Online
Manual](https://microbiome.github.io/OMA).

For instance, to plot population density we can use the `miaViz` package:

## 1.4 Case studies

Source code for replicating the published case studies using the
miaSim package ([Gao et
al. 2023](https://doi.org/10.1111/2041-210X.14129)) is available in
[Github](https://github.com/microbiome/miaSim/tree/main/inst/extdata/phyloseq) (based on the phyloseq data container).

## 1.5 Related work

* [micodymora](https://github.com/OSS-Lab/micodymora) Python package for microbiome simulation

# 2 Session info

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
##  [1] miaSim_1.16.0                   TreeSummarizedExperiment_2.18.0
##  [3] Biostrings_2.78.0               XVector_0.50.0
##  [5] SingleCellExperiment_1.32.0     SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0                  GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0                   IRanges_2.44.0
## [11] S4Vectors_0.48.0                BiocGenerics_0.56.0
## [13] generics_0.1.4                  MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0               BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] yulab.utils_0.2.1   rappdirs_0.3.3      tidyr_1.3.1
##  [4] sass_0.4.10         SparseArray_1.10.0  lattice_0.22-7
##  [7] digest_0.6.37       magrittr_2.0.4      evaluate_1.0.5
## [10] grid_4.5.1          bookdown_0.45       fastmap_1.2.0
## [13] jsonlite_2.0.0      Matrix_1.7-4        ape_5.8-1
## [16] deSolve_1.40        BiocManager_1.30.26 purrr_1.1.0
## [19] lazyeval_0.2.2      codetools_0.2-20    jquerylib_0.1.4
## [22] abind_1.4-8         cli_3.6.5           rlang_1.1.6
## [25] crayon_1.5.3        tidytree_0.4.6      cachem_1.1.0
## [28] DelayedArray_0.36.0 yaml_2.3.10         S4Arrays_1.10.0
## [31] tools_4.5.1         parallel_4.5.1      BiocParallel_1.44.0
## [34] dplyr_1.1.4         vctrs_0.6.5         R6_2.6.1
## [37] lifecycle_1.0.4     fs_1.6.6            treeio_1.34.0
## [40] pkgconfig_2.0.3     bslib_0.9.0         pillar_1.11.1
## [43] glue_1.8.0          Rcpp_1.1.0          poweRlaw_1.0.0
## [46] tidyselect_1.2.1    tibble_3.3.0        xfun_0.53
## [49] knitr_1.50          htmltools_0.5.8.1   nlme_3.1-168
## [52] rmarkdown_2.30      compiler_4.5.1
```