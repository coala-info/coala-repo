---
name: bioconductor-splicingfactory
description: SplicingFactory quantifies and compares transcript isoform diversity within genes using RNA-Seq expression data. Use when user asks to calculate diversity measures like Shannon entropy or Gini index, identify changes in splicing profiles between biological conditions, or perform differential diversity analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/SplicingFactory.html
---


# bioconductor-splicingfactory

name: bioconductor-splicingfactory
description: Analyze alternative splicing isoform diversity from RNA-Seq data. Use this skill to calculate diversity measures (Shannon entropy, Gini index, Simpson index) at the gene level from transcript-level expression data and perform differential diversity analysis between conditions.

# bioconductor-splicingfactory

## Overview

SplicingFactory is an R package designed to quantify and compare transcript isoform diversity within genes. It transforms transcript-level expression estimates (from tools like Salmon, Kallisto, or RSEM) into gene-level diversity scores. This allows researchers to identify genes where the "splicing profile" changes significantly between biological conditions, even if total gene expression remains constant.

## Core Workflow

### 1. Data Preparation
The package requires transcript-level expression data (TPM is highly recommended over raw counts to account for transcript length).

*   **Input Formats:** Supports `matrix`, `data.frame`, `SummarizedExperiment`, `DGEList`, and `tximport` lists.
*   **Structure:** Rows must be transcripts, columns must be samples.
*   **Gene Vector:** A character vector mapping each transcript (row) to a gene ID.
*   **Sample Vector:** A factor or character vector defining the condition for each sample (column).

### 2. Calculating Diversity
Use `calculate_diversity()` to generate gene-level scores.

```r
library(SplicingFactory)

# Example using a matrix of TPM values
# genes: vector of gene names corresponding to rows in tpm_matrix
diversity_se <- calculate_diversity(
  x = tpm_matrix, 
  genes = gene_vector, 
  method = "laplace", # Options: "shannon", "naive", "laplace", "gini", "simpson", "invsimpson"
  norm = TRUE,        # Normalize entropy values between 0 and 1
  verbose = TRUE
)

# Results are returned as a SummarizedExperiment object
diversity_values <- assay(diversity_se)
```

**Key Methods:**
*   **Laplace/Shannon Entropy:** Measures the uncertainty/complexity of the isoform distribution.
*   **Gini Index:** Measures inequality (0 = all isoforms equal, 1 = one dominant isoform).
*   **Simpson Index:** Measures the probability that two randomly selected reads come from the same isoform.

### 3. Differential Diversity Analysis
Use `calculate_difference()` to find genes with significant changes in diversity between groups.

```r
# samples: vector or colData column name defining groups
# control: the reference group name
diff_results <- calculate_difference(
  x = diversity_se, 
  samples = "condition", 
  control = "Normal",
  method = "mean",    # Use "mean" or "median" for group averages
  test = "wilcoxon"   # Options: "wilcoxon" or "label_shuffling"
)
```

## Technical Tips

*   **Filtering:** Always filter out low-expression transcripts before analysis. Highly variable low-count estimates can produce misleading diversity scores.
*   **Single Isoform Genes:** SplicingFactory automatically excludes genes with only one transcript isoform, as diversity cannot be calculated.
*   **NA Values:** If a gene has zero expression across all isoforms in a sample, the diversity value will be `NA`.
*   **Interpretation:** 
    *   For **Normalized Entropy**: High values = high diversity (many isoforms expressed equally); Low values = low diversity (one dominant isoform).
    *   For **Gini Index**: High values = low diversity (inequality/dominance); Low values = high diversity (equality).
*   **Sample Size:** For Wilcoxon tests, ensure at least 3 samples per category (8 total recommended). For label shuffling, at least 5 samples per category are required.

## Reference documentation

- [SplicingFactory Vignette (Rmd)](./references/SplicingFactory.Rmd)
- [SplicingFactory Vignette (Markdown)](./references/SplicingFactory.md)