---
name: bioconductor-cadra
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CaDrA.html
---

# bioconductor-cadra

name: bioconductor-cadra
description: Candidate Driver Analysis (CaDrA) for identifying a subset of genomic features (e.g., mutations, SCNA) whose union is maximally associated with a continuous functional outcome (e.g., pathway activity, drug sensitivity). Use this skill to perform forward/backward heuristic searches, permutation-based significance testing, and visualization of meta-feature associations in multi-omics datasets.

# bioconductor-cadra

## Overview
CaDrA is an R package designed to identify "meta-features"—unions of binary genomic events—that explain a continuous input score. It uses a heuristic search algorithm (forward and backward) to find a combination of features that maximizes a specific association metric. This is particularly useful for identifying complementary drivers of a biological phenotype or pathway activity.

## Core Workflow

### 1. Data Preparation
CaDrA requires two main inputs:
- **Feature Set (FS)**: A binary matrix (0/1) where rows are features (e.g., genes) and columns are samples. This can be a standard matrix or a `SummarizedExperiment` object.
- **Input Score**: A named numeric vector of continuous values (e.g., gene expression signatures, protein levels) corresponding to the samples in the FS.

```r
library(CaDrA)
library(SummarizedExperiment)

# Load example data
data(sim_FS)
data(sim_Scores)

# Pre-filter data based on event frequency (e.g., between 3% and 60%)
fs_filtered <- CaDrA::prefilter_data(
  FS = sim_FS,
  max_cutoff = 0.6,
  min_cutoff = 0.03
)
```

### 2. Candidate Search
The `candidate_search()` function (formerly `topn_eval`) is the primary engine for finding driver sets.

```r
search_res <- CaDrA::candidate_search(
  FS = fs_filtered,
  input_score = sim_Scores,
  method = "ks_pval",          # Scoring method (ks_pval, wilcox_pval, revealer, knnmi, correlation)
  method_alternative = "less", # Direction of association
  search_method = "both",      # Forward and backward search
  top_N = 7,                   # Number of top starting features to evaluate
  max_size = 7,                # Max number of features in the meta-feature union
  best_score_only = FALSE
)

# Extract the best meta-feature set
best_meta <- CaDrA::topn_best(search_res)
```

### 3. Scoring Methods
CaDrA supports several scoring functions via the `method` parameter:
- `ks_pval`: Kolmogorov-Smirnov test (rank-based, sensitive to distribution shifts).
- `wilcox_pval`: Wilcoxon Rank-Sum test.
- `revealer`: Conditional Mutual Information (from the REVEALER algorithm).
- `knnmi`: K-Nearest Neighbor Mutual Information.
- `correlation`: Pearson or Spearman correlation.
- `custom`: User-defined scoring function.

### 4. Permutation Testing
To assess if the identified meta-feature association is statistically significant compared to random chance, use the `CaDrA()` wrapper function.

```r
perm_res <- CaDrA::CaDrA(
  FS = sim_FS,
  input_score = sim_Scores,
  n_perm = 100,                # Number of permutations
  ncores = 2,                  # Parallel processing
  top_N = 7,
  method = "ks_pval"
)
```

### 5. Visualization
- `meta_plot()`: Visualizes the union of features (meta-feature) against the input score.
- `topn_plot()`: Displays the scores across different starting points (top N).
- `permutation_plot()`: Shows the distribution of permuted scores vs. the observed score.

```r
# Plot the best meta-feature result
CaDrA::meta_plot(topn_best_list = best_meta, input_score_label = "Phenotype Score")

# Plot permutation results
CaDrA::permutation_plot(perm_res)
```

## Reference documentation
- [How to run CaDrA within a Docker Environment](./references/docker.md)
- [Permutation-Based Testing](./references/permutation_based_testing.md)
- [Scoring Functions](./references/scoring_functions.md)