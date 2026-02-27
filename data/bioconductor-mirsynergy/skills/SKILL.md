---
name: bioconductor-mirsynergy
description: Mirsynergy is a deterministic clustering algorithm that identifies miRNA regulatory modules by maximizing synergy scores between miRNAs, mRNAs, and gene-gene interactions. Use when user asks to identify miRNA regulatory modules, perform overlapping clustering of miRNA-mRNA interactions, or analyze synergistic gene regulation.
homepage: https://bioconductor.org/packages/3.5/bioc/html/Mirsynergy.html
---


# bioconductor-mirsynergy

## Overview

Mirsynergy is a deterministic overlapping clustering algorithm designed to identify miRNA regulatory modules (MiRMs). Unlike stochastic methods or those requiring a fixed number of clusters, Mirsynergy uses a two-stage approach:
1.  **Initial Module Formation**: Groups miRNAs based on co-occurrence.
2.  **Greedy Expansion**: Expands modules by adding or excluding mRNAs to maximize a "synergy score," which accounts for miRNA-mRNA targets and gene-gene interactions (PPI/TFBS).

## Core Workflow

### 1. Data Preparation
Mirsynergy requires three primary inputs:
*   **W**: A miRNA-mRNA interaction matrix (e.g., target site predictions or LASSO-derived scores).
*   **H**: A gene-gene interaction (GGI) matrix (e.g., Protein-Protein Interactions or Transcription Factor Binding Sites).
*   **Expression Data (Optional)**: Used to refine the interaction matrix `W` using regression techniques like LASSO.

### 2. Constructing the Interaction Matrix (W)
If you only have expression data, you should first estimate the interaction strengths. A common approach is using LASSO regression where mRNA expression is the response and miRNA expression is the predictor, often constrained by sequence-based predictions.

```r
library(Mirsynergy)
library(glmnet)

# Example: Estimating W using LASSO (simplified logic)
# Z: miRNA expression, X: mRNA expression, C: binary target prediction matrix
W <- lapply(1:nrow(X), function(i) {
  # Filter miRNAs that target mRNA i based on prior knowledge C
  target_idx <- which(C[i, ] > 0)
  if(length(target_idx) >= 2) {
    fit <- cv.glmnet(t(Z[target_idx, ]), X[i, ], nfolds=3)
    coefs <- as.numeric(coef(fit, s="lambda.min")[-1])
    # Mirsynergy typically uses absolute values or specific weights
    return(abs(coefs))
  }
})
```

### 3. Running Mirsynergy
The main function `mirsynergy` performs the clustering.

```r
# W: miRNA-mRNA matrix, H: mRNA-mRNA matrix
V <- mirsynergy(W, H, verbose = FALSE)
```

### 4. Summarizing and Visualizing Results
The package provides several tools to interpret the identified modules.

*   **Text Summary**: `summary_modules(V)` provides counts of miRNAs/mRNAs and synergy scores.
*   **Detailed Print**: `print_modules2(V)` lists the specific genes and miRNAs in each module.
*   **Visual Summary**: `plot_module_summary(V)` shows distributions of module sizes and synergy scores.
*   **Network Plot**: `plot_modules(V, W, H)` visualizes the assignments for specific examples.

```r
# Get summary statistics
stats <- summary_modules(V)
print(stats$moduleSummaryInfo)

# Plot distributions
plot_module_summary(V)
```

### 5. Exporting Data
To use results in external tools like Cytoscape:
```r
# Export to a tabular format
tab_data <- tabular_module(V)
# This typically returns node and edge lists for network analysis
```

## Tips for Success
*   **Input Scaling**: Ensure your interaction matrices `W` and `H` are appropriately scaled. Mirsynergy is sensitive to the relative weights of these interactions.
*   **Sparsity**: The algorithm performs best when the input matrices are sparse (i.e., using high-confidence PPIs or validated miRNA targets).
*   **Synergy Score**: A higher synergy score indicates a more robust regulatory unit where the combined effect of miRNAs on a set of targets is reinforced by the internal interactions of those targets.

## Reference documentation
- [Mirsynergy](./references/Mirsynergy.md)