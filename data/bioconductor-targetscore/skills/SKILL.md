---
name: bioconductor-targetscore
description: This tool infers microRNA targets by integrating fold-change data and sequence-based scores using a Variational Bayesian-Gaussian Mixture Model. Use when user asks to predict miRNA targets from differential expression results, compute target probabilities using sequence features, or retrieve pre-computed genomic scores for specific miRNAs.
homepage: https://bioconductor.org/packages/release/bioc/html/TargetScore.html
---


# bioconductor-targetscore

name: bioconductor-targetscore
description: Infer microRNA (miRNA) targets by integrating miRNA-overexpression data (log fold-change) and sequence-based scores (like TargetScan context scores and PCT) using a Variational Bayesian-Gaussian Mixture Model (VB-GMM). Use this skill when you need to predict condition-specific miRNA targets from differential expression results or pre-computed genomic data.

## Overview

TargetScore is an unsupervised probabilistic framework that identifies miRNA targets. Unlike correlation-based methods, it can work with a single overexpression experiment. It uses a Variational Bayesian-Gaussian Mixture Model (VB-GMM) to distinguish "target" components (genes with significant negative fold-changes and high sequence scores) from "background" components.

The package is often used in conjunction with `TargetScoreData`, which provides pre-computed logFC and sequence scores for human miRNAs.

## Core Workflow

### 1. Basic Target Prediction
If you have log fold-change (logFC) data and sequence scores (e.g., from TargetScan), use the `targetScore` function.

```R
library(TargetScore)

# logFC: vector of log2 fold-changes (treatment vs control)
# seqScores: matrix where columns are different sequence-based features
p.targetScore <- targetScore(logFC = my_logFC, seqScores = my_seqScores, tol = 1e-3)

# Results are probabilities (0 to 1) of being a target
head(p.targetScore)
```

### 2. Using Pre-computed Data (TargetScoreData)
The `getTargetScores` function (from the `TargetScoreData` package) automates the retrieval of sequence scores and pre-computed fold-changes.

```R
library(TargetScoreData)

# Predict targets for a specific miRNA using pre-computed data
# This retrieves TargetScan context scores and PCT automatically
myTargetScores <- getTargetScores("hsa-miR-1", tol = 1e-3, maxiter = 200)

# Access the probabilities
scores <- myTargetScores$targetScore
```

### 3. Integrating with Differential Expression Pipelines
TargetScore typically follows a differential expression analysis using `limma` or `DESeq2`.

**With limma:**
```R
# After running eBayes(fit)
limma_stats <- topTable(fit, coef=1, number=nrow(fit))
logFC <- as.matrix(limma_stats$logFC)
rownames(logFC) <- limma_stats$gene_symbol

# Compute target scores using the custom logFC and pre-computed sequence scores
myTargetScores <- getTargetScores("hsa-miR-205", logFC = logFC, tol = 1e-3)
```

**With DESeq:**
```R
# Extract log2FoldChange from results
logFC <- res$log2FoldChange
# Provide sequence scores (matrix)
p.targetScore <- targetScore(logFC, seqScores, tol = 1e-3)
```

## Key Functions

- `targetScore(logFC, seqScores, ...)`: The primary inference engine. `seqScores` is optional but recommended for better accuracy.
- `getTargetScores(mirID, logFC, ...)`: A wrapper that fetches sequence features (Context Score, PCT) for a specific miRNA ID and computes the score.
- `get_precomputed_logFC()`: (TargetScoreData) Retrieves a matrix of imputed logFC values across 112 miRNAs.

## Tips for Success

- **Input Direction**: TargetScore expects negative logFC values for targets (down-regulation). If your fold-change is calculated as `control - treatment`, you must flip the sign.
- **Sequence Scores**: The model assumes that the mixture component with the largest absolute means of negative values is the target component. Ensure sequence scores are scaled appropriately (TargetScan context scores are typically negative).
- **Convergence**: If the model fails to converge, try increasing `maxiter` or adjusting the tolerance `tol`.
- **Cutoffs**: TargetScore returns a probability. While 0.5 is a standard threshold, a more lenient cutoff (e.g., 0.1 or 0.3) is often used in exploratory analysis to capture more potential targets for validation.

## Reference documentation

- [TargetScore](./references/TargetScore.md)