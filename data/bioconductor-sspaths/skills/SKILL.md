---
name: bioconductor-sspaths
description: bioconductor-sspaths estimates single-sample pathway deviation scores by applying gene weights learned from a reference cohort to new individual samples. Use when user asks to learn gene weightings from a reference dataset, calculate pathway activity scores for single samples, or characterize hypoxia and pathway deviations in precision oncology.
homepage: https://bioconductor.org/packages/release/bioc/html/ssPATHS.html
---

# bioconductor-sspaths

name: bioconductor-sspaths
description: Estimate single-sample pathway deviation scores using the ssPATHS R package. Use this skill when you need to learn gene weightings from a reference cohort (e.g., TCGA) to characterize pathway activity in new individual samples, particularly for precision oncology and hypoxia studies.

## Overview

ssPATHS (Single Sample PATHway Score) is a method for estimating pathway deviations for a single patient or sample. It works by learning a discriminative gene weighting from a reference cohort (where classes like "normal" vs "tumor" are known) and then applying those weights to new samples to calculate a continuous pathway score. This is particularly useful for identifying samples with high pathway activity (e.g., hypoxia) when traditional differential expression analysis is not possible for single samples.

## Data Formatting

The package utilizes `SummarizedExperiment` objects. Your input data should be formatted as follows:

1.  **Reference Expression Data**: A matrix or data frame where rows are genes (e.g., ENSG IDs) and columns are samples.
2.  **Column Data (colData)**: Must contain:
    *   `sample_id`: Unique identifiers for each sample.
    *   `Y`: A binary classifier (0 or 1). For example, set `0` for normal/control and `1` for tumor/hypoxia.
3.  **Gene Sets**: A character vector of gene IDs belonging to the pathway of interest. Use `get_hypoxia_genes()` for a built-in hypoxia set or `msigdbr` for custom sets.

```r
# Example conversion to SummarizedExperiment
library(ssPATHS)
library(SummarizedExperiment)

# Ensure Y is binary: 0 for baseline, 1 for the state of interest
colData(se)$Y <- ifelse(colData(se)$is_normal, 0, 1)
```

## Workflow: Learning and Applying Weights

### 1. Get Reference Gene Weightings
Use a reference dataset to calculate the importance of each gene in the pathway. The reference `SummarizedExperiment` should ideally contain at least 500 background genes for stable normalization.

```r
# res[[1]] contains gene weights; res[[2]] contains training sample scores
res <- get_gene_weights(se_reference, pathway_gene_ids, unidirectional = TRUE)
gene_weights <- res[[1]]
```

### 2. Evaluate Training Accuracy
Check how well the learned weights separate the reference classes using ROC and PR curves.

```r
training_res <- get_classification_accuracy(res[[2]], positive_val = 1)
# Access metrics: training_res$auc_roc, training_res$auc_pr
```

### 3. Score New Samples
Apply the learned `gene_weights` to a new `SummarizedExperiment` object. The new dataset must use the same gene identifiers as the reference.

```r
# Returns a DataFrame with sample_id and pathway_score
new_scores <- get_new_samp_score(gene_weights, se_new_samples)
```

## Interpretation of Results

*   **Pathway Score**: A higher score indicates that the sample more closely resembles the "1" class (e.g., more hypoxic or more tumor-like) based on the weighted expression of the pathway genes.
*   **Unidirectional Flag**: When `unidirectional = TRUE` in `get_gene_weights`, the model assumes most genes in the pathway move in the same direction (e.g., all increasing in hypoxia).

## Reference documentation

- [ssPATHS: Single Sample PATHway Score](./references/ssPATHS.md)