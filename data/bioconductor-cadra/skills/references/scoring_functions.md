# Scoring Functions

The **CaDrA** package currently supports four scoring functions to search for subsets of genomic features that are likely associated with a specific outcome of interest (e.g., protein expression, pathway activity, etc.)

1. Kolmogorov-Smirnov Method (`ks`)
2. Wilcoxon Rank-Sum Method (`wilcox`)
3. Conditional Mutual Information Method (`revealer`)
4. K-Nearest Neighbor Mutual Information Estimator (`knnmi`)
5. Correlation Method (`correlation`)
6. Custom - An User Defined Scoring Method (`custom`)

Below, we run `candidate_search()` over the top 3 starting features using each of the scoring functions described above.

**Important Notes:**

* The legacy or deprecated function `topn_eval()` is equivalent to the new and recommended `candidate_search()` function

# Load packages

```
library(CaDrA)
library(pheatmap)
library(SummarizedExperiment)
```

# Load required datasets

1. A `binary features matrix` also known as `Feature Set` (such as somatic mutations, copy number alterations, chromosomal translocations, etc.) The 1/0 row vectors indicate the presence/absence of ‘omics’ features in the samples. The `Feature Set` can be a matrix or an object of class **SummarizedExperiment** from **SummarizedExperiment** package)
2. A vector of continuous scores (or `Input Scores`) representing a functional response of interest (such as protein expression, pathway activity, etc.)

```
# Load pre-computed feature set
data(sim_FS)

# Load pre-computed input scores
data(sim_Scores)
```

# Heatmap of simulated feature set

The simulated dataset, `sim_FS`, comprises of 1000 genomic features and 100 sample profiles. There are 10 left-skewed (i.e. True Positive or TP) and 990 uniformly-distributed (i.e. True Null or TN) features simulated in the dataset. Below is a heatmap of the first 100 features.

```
mat <- SummarizedExperiment::assay(sim_FS)
pheatmap::pheatmap(mat[1:100, ], color = c("white", "red"), cluster_rows = FALSE, cluster_cols = FALSE)
```

![](data:image/png;base64...)

# Search for a subset of genomic features that are likely associated with a functional response of interest using each of the scoring methods

## 1. Kolmogorov-Smirnov Scoring Method

See `?ks_rowscore` for more details

```
ks_topn_l <- CaDrA::candidate_search(
  FS = sim_FS,
  input_score = sim_Scores,
  method = "ks_pval",          # Use Kolmogorov-Smirnov scoring function
  method_alternative = "less", # Use one-sided hypothesis testing
  weights = NULL,              # If weights is provided, perform a weighted-KS test
  search_method = "both",      # Apply both forward and backward search
  top_N = 3,                   # Evaluate top 3 starting points for the search
  max_size = 10,               # Allow at most 10 features in meta-feature matrix
  do_plot = FALSE,             # We will plot it AFTER finding the best hits
  best_score_only = FALSE      # Return all results from the search
)

# Now we can fetch the feature set of top N features that corresponded to the best scores over the top N search
ks_topn_best_meta <- topn_best(ks_topn_l)

# Visualize best meta-feature result
meta_plot(topn_best_list = ks_topn_best_meta)
```

![](data:image/png;base64...)

## 2. Wilcoxon Rank-Sum Scoring Method

See `?wilcox_rowscore` for more details

```
wilcox_topn_l <- CaDrA::candidate_search(
  FS = sim_FS,
  input_score = sim_Scores,
  method = "wilcox_pval",      # Use Wilcoxon Rank-Sum scoring function
  method_alternative = "less", # Use one-sided hypothesis testing
  search_method = "both",      # Apply both forward and backward search
  top_N = 3,                   # Evaluate top 3 starting points for the search
  max_size = 10,               # Allow at most 10 features in meta-feature matrix
  do_plot = FALSE,             # We will plot it AFTER finding the best hits
  best_score_only = FALSE      # Return all results from the search
)

# Now we can fetch the feature set of top N feature that corresponded to the best scores over the top N search
wilcox_topn_best_meta <- topn_best(topn_list = wilcox_topn_l)

# Visualize best meta-feature result
meta_plot(topn_best_list = wilcox_topn_best_meta)
```

![](data:image/png;base64...)

## 3. Conditional Mutual Information Scoring Method from REVEALER

See `?revealer_rowscore` for more details

```
revealer_topn_l <- CaDrA::candidate_search(
  FS = sim_FS,
  input_score = sim_Scores,
  method = "revealer",         # Use REVEALER's CMI scoring function
  search_method = "both",      # Apply both forward and backward search
  top_N = 3,                   # Evaluate top 3 starting points for the search
  max_size = 10,               # Allow at most 10 features in meta-feature matrix
  do_plot = FALSE,             # We will plot it AFTER finding the best hits
  best_score_only = FALSE      # Return all results from the search
)

# Now we can fetch the ESet of top feature that corresponded to the best scores over the top N search
revealer_topn_best_meta <- topn_best(topn_list = revealer_topn_l)

# Visualize best meta-feature result
meta_plot(topn_best_list = revealer_topn_best_meta)
```

![](data:image/png;base64...)

## 4. K-Nearest Neighbor Mutual Information Estimator from knnmi package

See `?knnmi_rowscore` for more details

```
knnmi_topn_l <- CaDrA::candidate_search(
  FS = sim_FS,
  input_score = sim_Scores,
  method = "knnmi",            # Use knnmi scoring function
  search_method = "both",      # Apply both forward and backward search
  top_N = 3,                   # Evaluate top 3 starting points for the search
  max_size = 10,               # Allow at most 10 features in meta-feature matrix
  do_plot = FALSE,             # We will plot it AFTER finding the best hits
  best_score_only = FALSE      # Return all results from the search
)

# Now we can fetch the ESet of top feature that corresponded to the best scores over the top N search
knnmi_topn_best_meta <- topn_best(topn_list = knnmi_topn_l)

# Visualize best meta-feature result
meta_plot(topn_best_list = knnmi_topn_best_meta)
```

![](data:image/png;base64...)

## 5. Correlation Scoring Method

See `?corr_rowscore` for more details

```
corr_topn_l <- CaDrA::candidate_search(
  FS = SummarizedExperiment::assay(sim_FS),
  input_score = sim_Scores,
  method = "correlation",      # Use correlation scoring function
  cmethod = "spearman",        # Use spearman correlation scoring function
  top_N = 3,                   # Evaluate top 3 starting points for the search
  max_size = 10,               # Allow at most 10 features in meta-feature matrix
  do_plot = FALSE,             # We will plot it AFTER finding the best hits
  best_score_only = FALSE      # Return all results from the search
)

# Now we can fetch the feature set of top N feature that corresponded to the best scores over the top N search
corr_topn_best_meta <- topn_best(topn_list = corr_topn_l)

# Visualize best meta-feature result
meta_plot(topn_best_list = corr_topn_best_meta)
```

![](data:image/png;base64...)

## 6. Custom - An User Defined Scoring Method

See `?custom_rowscore` for more details

```
# A customized function using ks-test
customized_ks_rowscore <- function(FS, input_score, weights=NULL, meta_feature=NULL, alternative="less", metric="pval"){

  metric <- match.arg(metric)
  alternative <- match.arg(alternative)

  # Check if meta_feature is provided
  if(!is.null(meta_feature)){
    # Getting the position of the known meta features
    locs <- match(meta_feature, row.names(FS))

    # Taking the union across the known meta features
    if(length(locs) > 1) {
      meta_vector <- as.numeric(ifelse(colSums(FS[locs,]) == 0, 0, 1))
    }else{
      meta_vector <- as.numeric(FS[locs, , drop=FALSE])
    }

    # Remove the meta features from the binary feature matrix
    # and taking logical OR btw the remaining features with the meta vector
    FS <- base::sweep(FS[-locs, , drop=FALSE], 2, meta_vector, `|`)*1

    # Check if there are any features that are all 1s generated from
    # taking the union between the matrix
    # We cannot compute statistics for such features and thus they need
    # to be filtered out
    if(any(rowSums(FS) == ncol(FS))){
      verbose("Features with all 1s generated from taking the matrix union ",
              "will be removed before progressing...\n")
      FS <- FS[rowSums(FS) != ncol(FS), , drop=FALSE]
      # If no features remained after filtering, exist the function
      if(nrow(FS) == 0) return(NULL)
    }
  }

  # KS is a ranked-based method
  # So we need to sort input_score from highest to lowest values
  input_score <- sort(input_score, decreasing=TRUE)

  # Re-order the matrix based on the order of input_score
  FS <- FS[, names(input_score), drop=FALSE]

  # Check if weights is provided
  if(length(weights) > 0){
    # Check if weights has any labels or names
    if(is.null(names(weights)))
      stop("The weights object must have names or labels that ",
           "match the labels of input_score\n")

    # Make sure its labels or names match the
    # the labels of input_score
    weights <- as.numeric(weights[names(input_score)])
  }

  # Get the alternative hypothesis testing method
  alt_int <- switch(alternative, two.sided=0L, less=1L, greater=-1L, 1L)

  # Compute the ks statistic and p-value per row in the matrix
  ks <- .Call(ks_genescore_mat_, FS, weights, alt_int)

  # Obtain score statistics from KS method
  # Change values of 0 to the machine lowest value to avoid taking -log(0)
  stat <- ks[1,]

  # Obtain p-values from KS method
  # Change values of 0 to the machine lowest value to avoid taking -log(0)
  pval <- ks[2,]
  pval[which(pval == 0)] <- .Machine$double.xmin

  # Compute the scores according to the provided metric
  scores <- ifelse(rep(metric, nrow(FS)) %in% "pval", -log(pval), stat)
  names(scores) <- rownames(FS)

  return(scores)

}

# Search for best features using a custom-defined function
custom_topn_l <- CaDrA::candidate_search(
  FS = SummarizedExperiment::assay(sim_FS),
  input_score = sim_Scores,
  method = "custom",                        # Use custom scoring function
  custom_function = customized_ks_rowscore, # Use a customized scoring function
  custom_parameters = NULL,                 # Additional parameters to pass to custom_function
  weights = NULL,                           # If weights is provided, perform a weighted test
  search_method = "both",                   # Apply both forward and backward search
  top_N = 3,                                # Evaluate top 3 starting points for the search
  max_size = 10,                            # Allow at most 10 features in meta-feature matrix
  do_plot = FALSE,                          # We will plot it AFTER finding the best hits
  best_score_only = FALSE                   # Return all results from the search
)

# Now we can fetch the feature set of top N feature that corresponded to the best scores over the top N search
custom_topn_best_meta <- topn_best(topn_list = custom_topn_l)

# Visualize best meta-feature result
CaDrA::meta_plot(topn_best_list = custom_topn_best_meta)
```

![](data:image/png;base64...)

```
# Evaluate results across top N features you started from
CaDrA::topn_plot(custom_topn_l)
```

![](data:image/png;base64...)

For validation purposes, compare the custom and built-in function.

```
topn_res <- CaDrA::candidate_search(
  FS = sim_FS,
  input_score = sim_Scores,
  method = "ks_pval",          # Use Kolmogorov-Smirnov scoring function
  method_alternative = "less", # Use one-sided hypothesis testing
  weights = NULL,              # If weights is provided, perform a weighted-KS test
  search_method = "both",      # Apply both forward and backward search
  top_N = 3,                   # Evaluate top 7 starting points for each search
  max_size = 10,               # Maximum size a meta-feature matrix can extend to
  do_plot = FALSE,             # Plot after finding the best features
  best_score_only = FALSE      # Return all results from the search
)

## Fetch the meta-feature set corresponding to its best scores over top N features searches
topn_best_meta <- topn_best(topn_res)

# Visualize the best results with the meta-feature plot
meta_plot(topn_best_list = topn_best_meta)
```

![](data:image/png;base64...)

```
# Evaluate results across top N features you started from
topn_plot(topn_res)
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
[1] stats4    stats     graphics  grDevices utils     datasets  methods
[8] base

other attached packages:
 [1] CaDrA_1.8.0                 pheatmap_1.0.13
 [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
 [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
 [7] IRanges_2.44.0              S4Vectors_0.48.0
 [9] BiocGenerics_0.56.0         generics_0.1.4
[11] MatrixGenerics_1.22.0       matrixStats_1.5.0
[13] testthat_3.2.3              devtools_2.4.6
[15] usethis_3.2.1

loaded via a namespace (and not attached):
 [1] tidyselect_1.2.1    dplyr_1.1.4         farver_2.1.2
 [4] R.utils_2.13.0      S7_0.2.0            bitops_1.0-9
 [7] fastmap_1.2.0       digest_0.6.37       lifecycle_1.0.4
[10] ellipsis_0.3.2      magrittr_2.0.4      compiler_4.5.1
[13] rlang_1.1.6         sass_0.4.10         tools_4.5.1
[16] yaml_2.3.10         knitr_1.50          labeling_0.4.3
[19] S4Arrays_1.10.0     pkgbuild_1.4.8      DelayedArray_0.36.0
[22] plyr_1.8.9          RColorBrewer_1.1-3  pkgload_1.4.1
[25] abind_1.4-8         KernSmooth_2.23-26  R.cache_0.17.0
[28] withr_3.0.2         purrr_1.1.0         desc_1.4.3
[31] R.oo_1.27.1         grid_4.5.1          caTools_1.18.3
[34] ggplot2_4.0.0       scales_1.4.0        gtools_3.9.5
[37] iterators_1.0.14    MASS_7.3-65         dichromat_2.0-0.1
[40] cli_3.6.5           ppcor_1.1           rmarkdown_2.30
[43] remotes_2.5.0       rstudioapi_0.17.1   reshape2_1.4.4
[46] sessioninfo_1.2.3   cachem_1.1.0        stringr_1.5.2
[49] parallel_4.5.1      XVector_0.50.0      vctrs_0.6.5
[52] misc3d_0.9-1        Matrix_1.7-4        jsonlite_2.0.0
[55] foreach_1.5.2       jquerylib_0.1.4     glue_1.8.0
[58] codetools_0.2-20    stringi_1.8.7       gtable_0.3.6
[61] tibble_3.3.0        knnmi_1.0           pillar_1.11.1
[64] brio_1.1.5          htmltools_0.5.8.1   gplots_3.2.0
[67] R6_2.6.1            tcltk_4.5.1         doParallel_1.0.17
[70] rprojroot_2.1.1     evaluate_1.0.5      lattice_0.22-7
[73] R.methodsS3_1.8.2   memoise_2.0.1       bslib_0.9.0
[76] Rcpp_1.1.0          SparseArray_1.10.0  xfun_0.53
[79] fs_1.6.6            pkgconfig_2.0.3
```