# Example Data for RNAseqCovarImpute

Brennan H Baker1\*

1University of Washington

\*brennanhilton@gmail.com

#### 30 October 2025

#### Package

RNAseqCovarImpute 1.8.0

# Contents

* [1 Generate random data](#generate-random-data)
* [2 Simulate missingness in the random data](#simulate-missingness-in-the-random-data)
* [Session info](#session-info)

# 1 Generate random data

Normally you would have your own covariate and RNA-sequencing data. We generate random data below for the purpose of demonstrating how the functions in the RNAseqCovarImpute package work.

```
library(dplyr)
library(stringr)
library(tidyr)
library(edgeR)
library(mice)
# Generate random covariate data
set.seed(2023)
x1 <- rnorm(n = 500)
y1 <- rnorm(n = 500)
z1 <- rnorm(n = 500)
a1 <- rbinom(n = 500, prob = .25, size = 1)
b1 <- rbinom(n = 500, prob = .5, size = 1)
data <- data.frame(x = x1, y = y1, z = z1, a = a1, b = b1)

# Generate random count data from Poisson distribution
nsamp <- nrow(data)
ngene <- 500
mat <- matrix(stats::rpois(n = nsamp * ngene, lambda = sample(1:500, ngene, replace = TRUE)),
    nrow = ngene,
    ncol = nsamp
)

# Make fake ENSEMBL gene numbers
annot <- tibble(number = seq_len(ngene), name1 = "ENS") %>%
    mutate(ENSEMBL = str_c(name1, number)) %>%
    dplyr::select(ENSEMBL)
rownames(mat) <- annot$ENSEMBL

# Make DGE list and set rownames to ENSEMBL gene numbers above
example_DGE <- DGEList(mat, genes = annot)
rownames(example_DGE) <- annot$ENSEMBL
```

# 2 Simulate missingness in the random data

Now we simulate missingness in the random data generated above using the mice ampute function. The below code simulates missingness in the data for all but the first variable (x), which we consider the main predictor of interest in this example. See the ampute documentation for more details.

```
# First get all combos of 0 or 1 for the 4 other variables (y, z, a, and b)
pattern_vars <- expand.grid(c(0, 1), c(0, 1), c(0, 1), c(0, 1))
# Then add back a column for the predictor of interest, which is never amputed, so the first col =1 the whole way down
pattern2 <- matrix(1, nrow = nrow(pattern_vars), ncol = 1)
pattern1 <- cbind(pattern2, pattern_vars)
# Remove last row which is all 1s (all 1s means no missingness induced)
pattern <- pattern1[seq_len(15), ]

# Specify proportion of missing data and missingness mechanism for the ampute function
prop_miss <- 25
miss_mech <- "MAR"
result <- ampute(data = data, prop = prop_miss, mech = miss_mech, patterns = pattern)

# Extract the missing data
example_data <- result$amp
# Ampute function turns factors to numeric, so convert back to factors
example_data <- example_data %>% mutate(
    a = as.factor(a),
    b = as.factor(b)
)

# Calculate the new sample size if NAs are dropped as in a complete case analysis
sample_size <- example_data %>%
    drop_na() %>%
    nrow()

# As shown below, we have 24.2% missingness.
100 * (nsamp - sample_size) / nsamp
```

```
## [1] 24.2
```

Table 1: The first 10 rows of simulated covariate data with missingness

| x | y | z | a | b |
| --- | --- | --- | --- | --- |
| -0.084 | 1.179 | -0.269 | 0 | 0 |
| -0.983 | 0.795 | -0.119 | 0 | 0 |
| -1.875 | -0.820 | 0.065 | 0 | 1 |
| -0.186 | 2.238 | 1.291 | 0 | 0 |
| -0.633 | 1.552 | -0.451 | 0 | 1 |
| 1.091 | NA | NA | NA | 1 |
| -0.914 | 0.951 | 0.853 | 0 | 1 |
| 1.002 | -2.007 | 1.766 | 1 | NA |
| -0.399 | 0.900 | 0.640 | NA | 1 |
| -0.468 | 0.716 | 0.705 | 0 | 1 |

# Session info

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
## [1] mice_3.18.0      edgeR_4.8.0      limma_3.66.0     tidyr_1.3.1
## [5] stringr_1.5.2    dplyr_1.1.4      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         generics_0.1.4      shape_1.4.6.1
##  [4] stringi_1.8.7       lattice_0.22-7      lme4_1.1-37
##  [7] digest_0.6.37       magrittr_2.0.4      mitml_0.4-5
## [10] evaluate_1.0.5      grid_4.5.1          bookdown_0.45
## [13] iterators_1.0.14    fastmap_1.2.0       foreach_1.5.2
## [16] jomo_2.7-6          jsonlite_2.0.0      glmnet_4.1-10
## [19] Matrix_1.7-4        nnet_7.3-20         backports_1.5.0
## [22] survival_3.8-3      BiocManager_1.30.26 purrr_1.1.0
## [25] codetools_0.2-20    jquerylib_0.1.4     Rdpack_2.6.4
## [28] reformulas_0.4.2    cli_3.6.5           rlang_1.1.6
## [31] rbibutils_2.3       splines_4.5.1       withr_3.0.2
## [34] cachem_1.1.0        yaml_2.3.10         pan_1.9
## [37] tools_4.5.1         nloptr_2.2.1        minqa_1.2.8
## [40] locfit_1.5-9.12     boot_1.3-32         broom_1.0.10
## [43] rpart_4.1.24        vctrs_0.6.5         R6_2.6.1
## [46] lifecycle_1.0.4     MASS_7.3-65         pkgconfig_2.0.3
## [49] pillar_1.11.1       bslib_0.9.0         glue_1.8.0
## [52] Rcpp_1.1.0          statmod_1.5.1       xfun_0.53
## [55] tibble_3.3.0        tidyselect_1.2.1    knitr_1.50
## [58] nlme_3.1-168        htmltools_0.5.8.1   rmarkdown_2.30
## [61] compiler_4.5.1
```