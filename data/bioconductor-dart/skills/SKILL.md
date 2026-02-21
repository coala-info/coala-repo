---
name: bioconductor-dart
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DART.html
---

# bioconductor-dart

name: bioconductor-dart
description: Denoising Algorithm based on Relevance network Topology (DART). Use this skill to estimate pathway or perturbation gene signature activity scores in gene expression data. It is particularly effective for denoising signatures by removing genes inconsistent with the training data's correlation structure.

## Overview

DART (Denoising Algorithm based on Relevance network Topology) is an unsupervised method for inferring the activity of a gene signature (e.g., a pathway or drug response) in gene expression matrices. It works by building a relevance network of the signature genes, pruning edges that are inconsistent with the prior knowledge (the "model signature"), and then calculating a robust activity score for each sample.

## Typical Workflow

### 1. Data Preparation
DART requires a gene expression matrix (rows as genes, columns as samples) and a model signature. The model signature is a named vector where values represent expected log-fold changes or statistics, and names match the row identifiers of the expression matrix.

```R
library(DART)
# expression_matrix: rows = Entrez IDs, cols = samples
# model_signature: named vector of weights (e.g., +1 for up, -1 for down)
```

### 2. Building and Evaluating the Relevance Network
The relevance network connects genes that show significant correlation in the training data.

```R
# Build the network (default FDR is 1e-6)
rn.o <- BuildRN(expression_matrix, model_signature, fdr = 0.000001)

# Evaluate consistency between the data and the signature
evalNet.o <- EvalConsNet(rn.o)

# Check significance (Pval < 0.05)
print(evalNet.o$netcons['Pval(consist)'])
```

### 3. Pruning and Scoring
Pruning removes edges where the correlation in the data contradicts the signs in the model signature.

```R
# Prune inconsistent edges
prNet.o <- PruneNet(evalNet.o)

# Predict activity scores for the samples
pred.o <- PredActScore(prNet.o, expression_matrix)
# Access scores via pred.o$score
```

## Simplified Wrapper Functions

DART provides high-level wrappers that combine the steps above:

*   `DoDART(data, signature, fdr)`: Performs the full pipeline using the entire pruned correlation network.
*   `DoDARTCLQ(data, signature, fdr)`: An enhanced version that uses maximal cliques within the pruned network to estimate activity, often resulting in a more compact and robust signature.

```R
# Using the standard wrapper
results <- DoDART(expression_matrix, model_signature, fdr = 1e-6)
scores <- results$score

# Using the Clique-based wrapper
results_clq <- DoDARTCLQ(expression_matrix, model_signature, fdr = 1e-6)
scores_clq <- results_clq$pred
```

## Applying to Independent Data
Once a network is trained and pruned on a large, representative dataset, it can be applied to independent samples or smaller datasets.

```R
# Use the pruned network from the training set on new data
independent_scores <- PredActScore(prNet.o, new_expression_data)
```

## Tips for Success
*   **Identifier Matching**: Ensure the row names of your expression matrix and the names of your signature vector use the same ID type (e.g., Entrez IDs or Gene Symbols).
*   **Training Set Size**: The denoising step (relevance network construction) requires a relatively large and representative dataset to accurately estimate correlations.
*   **Consistency Check**: If `EvalConsNet` returns a non-significant p-value, the signature's directional information does not match the data's variation, and DART scores may not be reliable.
*   **Preprocessing**: DART does not perform normalization. Ensure data is preprocessed (e.g., RMA or DESeq2 normalization) before use.

## Reference documentation
- [DART](./references/DART.md)