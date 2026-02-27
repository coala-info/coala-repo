---
name: bioconductor-logitt
description: This tool detects differentially expressed genes in Affymetrix GeneChip data by calculating the Logit-t statistic from probe-level data. Use when user asks to identify differentially expressed genes in AffyBatch objects, calculate Median t-statistics, or perform probe-level analysis of Affymetrix data.
homepage: https://bioconductor.org/packages/3.6/bioc/html/logitT.html
---


# bioconductor-logitt

name: bioconductor-logitt
description: Use the logitT package to detect differentially expressed genes in Affymetrix GeneChip data using probe-level data. This skill should be used when analyzing AffyBatch objects to calculate the Logit-t (Median t) statistic, which provides an alternative to probe-set summary methods like MAS5, RMA, or dChip.

# bioconductor-logitt

## Overview

The `logitT` package implements the Logit-t algorithm (also known as Median t) for identifying differentially expressed genes. Unlike standard methods that summarize probe sets into a single expression value before statistical testing, Logit-t operates on probe-level data. It applies a logit-log transformation and Z-standardization to individual probes, performs t-tests on each probe, and then defines the gene-level statistic as the median of these probe-level t-statistics. This approach often yields higher sensitivity and specificity in spike-in datasets.

## Workflow and Usage

### 1. Data Preparation
The package requires an `AffyBatch` object as input. This is typically created by reading Affymetrix CEL files using the `affy` package.

```r
library(logitT)
library(affy)

# Read CEL files from the current working directory
data_batch <- ReadAffy()
```

### 2. Calculating Logit-t Statistics
The primary function is `logitTAffy`. You must provide the `AffyBatch` object and a group vector defining the experimental conditions (e.g., Control vs. Treatment).

```r
# Define groups (must match the number of samples in the AffyBatch)
# Example for 6 arrays: 3 Control (A) and 3 Treatment (B)
group_vector <- c("A", "A", "A", "B", "B", "B")

# Generate the Logit-t statistics
logit_results <- logitTAffy(data_batch, group = group_vector)

# The result is a named vector of t-statistics for each probe set
head(logit_results)
```

### 3. Significance Testing
The output of `logitTAffy` is a vector of t-statistics. To identify differentially expressed genes, you must calculate p-values based on the Student's t-distribution using the appropriate degrees of freedom ($df = n_1 + n_2 - 2$).

```r
# Calculate degrees of freedom
n1 <- 3
n2 <- 3
df_val <- n1 + n2 - 2

# Calculate two-sided p-values
p_values <- (1 - pt(abs(logit_results), df = df_val)) * 2

# Identify significant probe sets (e.g., p < 0.01)
significant_genes <- names(logit_results)[p_values < 0.01]
```

## Tips and Best Practices
- **Group Labels**: Group labels in the `group` vector can be any string or factor, provided there are exactly two unique groups.
- **Memory**: Because the algorithm processes data at the probe level before summarization, ensure your R environment has sufficient memory for large `AffyBatch` objects.
- **Thresholds**: The original authors suggested a p-value threshold of 0.01 using the comparison's degrees of freedom for making detection calls.

## Reference documentation
- [Description of Logit-t: Detecting Differentially Expressed Genes Using Probe-Level Data](./references/logitT.md)