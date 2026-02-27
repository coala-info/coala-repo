---
name: bioconductor-zitools
description: This tool analyzes zero-inflated count data by fitting mixture models and generating deinflated count matrices. Use when user asks to fit zero-inflated mixture models, calculate weights for structural zeros, generate deinflated count matrices, or perform differential abundance analysis on zero-inflated data.
homepage: https://bioconductor.org/packages/release/bioc/html/zitools.html
---


# bioconductor-zitools

name: bioconductor-zitools
description: Analyze zero-inflated count data (e.g., microbiome, single-cell) using the zitools R package. Use this skill to fit zero-inflated mixture models, calculate weights for structural zeros, generate deinflated count matrices (replacing structural zeros with NA), and perform downstream statistical analyses (mean, boxplots, PCA, differential abundance) that account for zero inflation.

## Overview
The `zitools` package addresses the challenge of "excess zeros" in high-dimensional count data. It distinguishes between "structural zeros" (true absences or technical dropouts) and "sampling zeros" (low abundance). By fitting a zero-inflated negative binomial model, it provides a weighting strategy and a deinflated count matrix that allows standard R functions and Bioconductor workflows (like `DESeq2` and `phyloseq`) to operate on zero-inflated data with reduced bias.

## Core Workflow

### 1. Initialization and Model Fitting
The primary entry point is `ziMain()`, which fits the mixture model and calculates probabilities for structural zeros.

```r
library(zitools)
library(phyloseq)

# Works directly with phyloseq objects
# Estimates structural zeros using features and samples as predictors
Zi <- ziMain(your_phyloseq_object)

# Inspect the resulting Zi-class object
print(Zi)
```

### 2. Accessing Data and Weights
The `Zi` object contains the original counts, the deinflated counts (with NAs), and the calculated weights.

```r
# Get counts where predicted structural zeros are replaced by NA
deinflated <- deinflatedcounts(Zi)

# Get the weight matrix (probability that a zero is NOT a structural zero)
w <- weights(Zi)

# Get original input counts
orig <- inputcounts(Zi)
```

### 3. Statistical Analysis (Polymorphism)
`zitools` overloads standard R functions to handle `Zi` objects automatically, accounting for the weights/NAs.

```r
# Basic statistics
mean(Zi)
sd(Zi)
median(Zi)
quantile(Zi)

# Visualization
# Compares ZI-considered vs ZI-not-considered
boxplot(log2p(Zi), main = "ZI considered")
boxplot(log2p(inputcounts(Zi)), main = "Original")

# Visualize structural zeros
MissingValueHeatmap(Zi)
```

### 4. Differential Abundance with DESeq2
`zitools` integrates with `DESeq2` by providing weights to the `DESeqDataSet`.

```r
# Convert Zi object to DESeqDataSet with weights
DDS <- zi2deseq2(Zi, design = ~condition)

# Run DESeq using Wald test and specific normalization for sparse data
DDS <- DESeq(DDS, test = "Wald", fitType = "local", sfType = "poscounts")
res <- results(DDS)
```

### 5. Integration with Phyloseq
To use the full suite of `phyloseq` tools (e.g., alpha/beta diversity) on deinflated data:

```r
# Create a new phyloseq object with deinflated counts
ps_deinflated <- zi2phyloseq(Zi)

# Use standard phyloseq functions
plot_richness(ps_deinflated, measures = "Chao1", color = "group")
plot_heatmap(ps_deinflated)
```

## Tips and Best Practices
- **Randomness**: The deinflation process involves random drawing. Use `resample_deinflatedcounts(Zi)` to check if your results are robust to the specific zeros replaced by NA.
- **PCA**: Standard PCA doesn't accept weights. To perform a ZI-aware PCA, compute weighted correlations first: `PCA <- princomp(covmat = cor(t(Zi)), cor = FALSE)`.
- **Log Transformation**: Use `log2p()` (log2(x+1)) provided by the package for transforming `Zi` objects before plotting.

## Reference documentation
- [An Introduction to zitools](./references/zitools_tutorial.md)
- [zitools R Markdown Source](./references/zitools_tutorial.Rmd)