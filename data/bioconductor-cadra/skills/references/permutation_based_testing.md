# Permutation-Based Testing

By default, **CaDrA** performs both forward and backward search algorithm to look for a subset of features whose union is maximally associated with an outcome of interest, based on (currently) one of four scoring functions (**Kolmogorov-Smirnov**, **Conditional Mutual Information**, **Wilcoxon**, and **custom-defined**). To test whether the strength of the association between the set of features and the observed input scores (e.g., pathway activity, drug sensitivity, etc.) is greater than it would be expected by chance, **CaDrA** supports permutation-based significance testing. Importantly, the permutation test iterates over the entire search procedure (e.g., if `top_N = 7`, each permutation iteration will consist of running the search over the top 7 features).

# Load packages

```
library(CaDrA)
```

# Load required datasets

1. A `binary features matrix` also known as `Feature Set` (such as somatic mutations, copy number alterations, chromosomal translocations, etc.) The 1/0 row vectors indicate the presence/absence of ‘omics’ features in the samples. The `Feature Set` can be a matrix or an object of class **SummarizedExperiment** from **SummarizedExperiment** package)
2. A vector of continuous scores (or `Input Scores`) representing a functional response of interest (such as protein expression, pathway activity, etc.)

```
# Load pre-simulated feature set
# See ?sim_FS for more information
data(sim_FS)

# Load pre-computed input-score
# See ?sim_Scores for more information
data(sim_Scores)
```

# Find a subset of features that maximally associated with a given outcome of interest

Here we are using **Kolmogorow-Smirnow** (KS) scoring method to search for best features

```
candidate_search_res <- CaDrA::candidate_search(
  FS = sim_FS,
  input_score = sim_Scores,
  method = "ks_pval",          # Use Kolmogorow-Smirnow scoring function
  method_alternative = "less", # Use one-sided hypothesis testing
  weights = NULL,              # If weights is provided, perform a weighted-KS test
  search_method = "both",      # Apply both forward and backward search
  top_N = 7,                   # Number of top features to kick start the search
  max_size = 10,               # Allow at most 10 features in meta-feature matrix
  best_score_only = FALSE      # Return all results from the search
)
```

# Visualize best meta-features result

```
# Extract the best meta-feature result
topn_best_meta <- CaDrA::topn_best(topn_list = candidate_search_res)

# Visualize meta-feature result
CaDrA::meta_plot(topn_best_list = topn_best_meta)
```

![](data:image/png;base64...)

# Perform permutation-based testing

```
# Set seed for permutation-based testing
set.seed(123)

perm_res <- CaDrA::CaDrA(
  FS = sim_FS,
  input_score = sim_Scores,
  method = "ks_pval",             # Use Kolmogorow-Smirnow scoring function
  method_alternative = "less",    # Use one-sided hypothesis testing
  weights = NULL,                 # If weights is provided, perform a weighted-KS test
  search_method = "both",         # Apply both forward and backward search
  top_N = 7,                      # Repeat the search with the top N features
  max_size = 10,                  # Allow at most 10 features in the meta-feature matrix
  n_perm = 100,                   # Number of permutations to perform
  perm_alternative = "one.sided", # One-sided permutation-based p-value alternative type
  plot = FALSE,                   # We will plot later
  ncores = 2                      # Number of cores to perform parallelization
)
```

# Visualize permutation result

```
# Visualize permutation results
permutation_plot(perm_res = perm_res)
```

![](data:image/png;base64...)

# SessionInfo

```
sessionInfo()
R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base

other attached packages:
[1] CaDrA_1.8.0    testthat_3.2.3 devtools_2.4.6 usethis_3.2.1

loaded via a namespace (and not attached):
 [1] tidyselect_1.2.1            dplyr_1.1.4
 [3] farver_2.1.2                R.utils_2.13.0
 [5] S7_0.2.0                    bitops_1.0-9
 [7] fastmap_1.2.0               digest_0.6.37
 [9] lifecycle_1.0.4             ellipsis_0.3.2
[11] magrittr_2.0.4              compiler_4.5.1
[13] rlang_1.1.6                 sass_0.4.10
[15] tools_4.5.1                 yaml_2.3.10
[17] knitr_1.50                  labeling_0.4.3
[19] S4Arrays_1.10.0             pkgbuild_1.4.8
[21] DelayedArray_0.36.0         plyr_1.8.9
[23] RColorBrewer_1.1-3          pkgload_1.4.1
[25] abind_1.4-8                 KernSmooth_2.23-26
[27] R.cache_0.17.0              withr_3.0.2
[29] purrr_1.1.0                 BiocGenerics_0.56.0
[31] desc_1.4.3                  R.oo_1.27.1
[33] grid_4.5.1                  stats4_4.5.1
[35] caTools_1.18.3              ggplot2_4.0.0
[37] scales_1.4.0                gtools_3.9.5
[39] iterators_1.0.14            MASS_7.3-65
[41] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
[43] cli_3.6.5                   ppcor_1.1
[45] rmarkdown_2.30              generics_0.1.4
[47] remotes_2.5.0               rstudioapi_0.17.1
[49] reshape2_1.4.4              sessioninfo_1.2.3
[51] cachem_1.1.0                stringr_1.5.2
[53] parallel_4.5.1              XVector_0.50.0
[55] matrixStats_1.5.0           vctrs_0.6.5
[57] misc3d_0.9-1                Matrix_1.7-4
[59] jsonlite_2.0.0              IRanges_2.44.0
[61] S4Vectors_0.48.0            foreach_1.5.2
[63] jquerylib_0.1.4             glue_1.8.0
[65] codetools_0.2-20            stringi_1.8.7
[67] gtable_0.3.6                GenomicRanges_1.62.0
[69] tibble_3.3.0                knnmi_1.0
[71] pillar_1.11.1               brio_1.1.5
[73] htmltools_0.5.8.1           Seqinfo_1.0.0
[75] gplots_3.2.0                R6_2.6.1
[77] tcltk_4.5.1                 doParallel_1.0.17
[79] rprojroot_2.1.1             evaluate_1.0.5
[81] Biobase_2.70.0              lattice_0.22-7
[83] R.methodsS3_1.8.2           memoise_2.0.1
[85] bslib_0.9.0                 Rcpp_1.1.0
[87] SparseArray_1.10.0          xfun_0.53
[89] fs_1.6.6                    MatrixGenerics_1.22.0
[91] pkgconfig_2.0.3
```