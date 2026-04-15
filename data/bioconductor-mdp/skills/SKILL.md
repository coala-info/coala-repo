---
name: bioconductor-mdp
description: The mdp package quantifies the molecular degree of perturbation by calculating how much a test sample's transcriptome deviates from a defined control group. Use when user asks to calculate perturbation scores, identify genes driving disease heterogeneity, or perform pathway-level deviation analysis using thresholded Z-scores.
homepage: https://bioconductor.org/packages/release/bioc/html/mdp.html
---

# bioconductor-mdp

## Overview

The `mdp` package implements the Molecular Degree of Perturbation algorithm. It quantifies how much a test sample's transcriptome deviates from a defined "healthy" or "baseline" control group. It transforms expression data into thresholded Z-scores, where values exceeding a specific standard deviation (default is 2) are considered "perturbed." This approach is particularly useful for studying disease heterogeneity and identifying specific genes or pathways that drive clinical differences.

## Basic Workflow

### 1. Data Preparation
The package requires two main inputs:
- **Expression Data**: A matrix or data frame with genes in rows and samples in columns.
- **Phenotype Data**: A data frame containing at least a `Sample` column (matching expression column names) and a `Class` column (defining control vs. test groups).

### 2. Running the MDP Analysis
The primary function is `mdp()`. You must specify the label used for the control group.

```r
library(mdp)
# data: expression matrix; pdata: phenotype data frame
results <- mdp(data = example_data, 
               pdata = example_pheno, 
               control_lab = "baseline")
```

### 3. Accessing Results
The output is a list containing several key elements:
- `results$sample_scores`: A list of data frames containing scores for each sample.
- `results$zscore`: The thresholded Z-score matrix (values below the threshold are set to 0).
- `results$gene_scores`: Average perturbation values per gene per class.
- `results$perturbed_genes`: The list of genes identified as most perturbed.

## Advanced Usage

### Pathway Analysis
You can calculate perturbation scores for specific gene sets (e.g., from a .gmt file) to see which biological processes are most deviated.

```r
# pathways should be a named list of gene symbols
results <- mdp(data = example_data, 
               pdata = example_pheno, 
               control_lab = "baseline", 
               pathways = pathways_list)

# View signal-to-noise ratio for pathways
head(results$pathways)
```

### Customizing Z-Score Calculation
By default, `mdp` uses the median and Median Absolute Deviation (MAD). You can switch to mean-based calculations or adjust the sensitivity threshold.

```r
# Use mean instead of median and a stricter threshold of 3 standard deviations
results <- mdp(data = example_data, 
               pdata = example_pheno, 
               control_lab = "baseline", 
               measure = "mean", 
               std = 3)
```

### Visualization
Use `sample_plot` to visualize the distribution of scores across different classes.

```r
# Extract scores for a specific pathway or the 'perturbedgenes' set
scores <- results$sample_scores[["perturbedgenes"]]
sample_plot(scores, control_lab = "baseline", title = "Total Perturbation")
```

## Tips for Success
- **Gene Symbols**: Ensure the gene identifiers in your expression data match the identifiers in your pathway list (e.g., both use HGNC symbols).
- **Control Selection**: The choice of `control_lab` is critical, as all Z-scores are relative to the distribution of this specific group.
- **Outlier Detection**: The `sample_scores` data frame includes an `outlier` column (0 or 1) based on the MDP calculation, which can help identify samples with extreme transcriptomic volatility.

## Reference documentation
- [Running the mdp package](./references/my-vignette.md)