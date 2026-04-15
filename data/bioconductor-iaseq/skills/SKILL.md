---
name: bioconductor-iaseq
description: The iASeq package provides a Bayesian hierarchical model for detecting allele-specific events by integrating multiple sequencing datasets. Use when user asks to detect allele-specific binding or expression, integrate multiple ChIP-seq or RNA-seq studies, or identify common patterns of allelic skewness across different conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/iASeq.html
---

# bioconductor-iaseq

## Overview

The `iASeq` package provides a Bayesian hierarchical model for detecting allele-specific events by integrating multiple datasets. It is particularly effective for ChIP-seq (allele-specific binding), RNA-seq (allele-specific expression), and MeDIP-seq. By analyzing multiple studies simultaneously, the model learns common patterns (motifs) of skewness across different transcription factors or conditions, which helps overcome the low signal-to-noise ratio typical of individual heterozygotic SNPs.

## Core Workflow

### 1. Data Preparation

The model requires a matrix of read counts and three metadata vectors that describe the experimental design.

*   **`exprs`**: A matrix where rows are heterozygotic SNPs and columns are read counts. Each replicate of a study requires two columns: one for the reference allele and one for the non-reference allele.
*   **`studyid`**: A numeric vector identifying which study each column belongs to (e.g., `c(1,1,1,1, 2,2,2,2)`).
*   **`repid`**: A numeric vector identifying the replicate within a study. Reference and non-reference columns for the same sample must share the same `repid`.
*   **`refid`**: A binary vector where `0` indicates a reference allele column and `1` indicates a non-reference allele column.

```r
library(iASeq)
data(sampleASE) # Loads sampleASE_exprs, sampleASE_studyid, etc.

# Example structure check
head(sampleASE_exprs)
table(sampleASE_studyid)
```

### 2. Model Fitting

Use `iASeqmotif` to fit the model. You can test a range of motif numbers (`K`) and use the Bayesian Information Criterion (BIC) to select the optimal number of non-null patterns.

```r
# K=1:5 tests models with 1 to 5 non-null motif patterns
motif.fitted <- iASeqmotif(sampleASE_exprs, 
                           sampleASE_studyid, 
                           sampleASE_repid, 
                           sampleASE_refid, 
                           K=1:5, 
                           iter.max=50, 
                           tol=1e-3)
```

### 3. Model Selection and Evaluation

Check the BIC values to determine the best fit (lower is generally better).

```r
# View BIC for each K
motif.fitted$bic

# Plot BIC values
plotBIC(motif.fitted)

# Access the best model results
best_model <- motif.fitted$bestmotif
```

### 4. Visualization and Results

The package provides tools to visualize the learned motifs and extract posterior probabilities for each SNP.

*   **`plotMotif`**: Generates pattern graphs (showing probability of skewness per study) and frequency charts (showing SNP counts per pattern).
*   **`p.post`**: The posterior probability for each SNP being an allele-specific event.

```r
# Visualize motifs with a specific posterior probability cutoff
plotMotif(motif.fitted$bestmotif, cutoff=0.9)

# Extract posterior probabilities for SNPs
snp_probs <- motif.fitted$bestmotif$p.post
head(snp_probs)

# Identify SNPs exceeding a threshold
significant_as_snps <- which(snp_probs > 0.9)
```

## Tips for Success

*   **Interpretation**: If `refid` is coded as 0 (ref) and 1 (non-ref), a "up" skewness indicates a bias toward the reference allele.
*   **Iterations**: For real-world data, ensure `iter.max` is high enough (e.g., 50-100) to allow the EM algorithm to converge.
*   **Memory**: Jointly analyzing many studies with thousands of SNPs can be memory-intensive; ensure the input matrix only contains heterozygotic SNPs with sufficient coverage.

## Reference documentation

- [iASeq Vignette](./references/iASeqVignette.md)