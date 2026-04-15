---
name: bioconductor-elbow
description: This tool determines biologically significant fold-change thresholds in transcriptomics data using a data-driven logit curve approach. Use when user asks to calculate fold-change cut-offs based on dataset variance, identify significant probes in datasets with few replicates, or replace arbitrary fold-change rules in RNA-Seq and Microarray analyses.
homepage: https://bioconductor.org/packages/3.8/bioc/html/ELBOW.html
---

# bioconductor-elbow

name: bioconductor-elbow
description: Statistical analysis of transcriptomics data (Microarray, RNA-Seq) using the ELBOW method to determine biological significance. Use when Claude needs to calculate fold-change cut-offs based on dataset variance rather than arbitrary thresholds. Ideal for datasets with fewer than six replicates or non-symmetric distributions.

## Overview

ELBOW (Evaluating foLd change By the lOgit Way) is a Bioconductor package that replaces the arbitrary "two-fold" rule with a data-driven approach. It uses a logit curve and cluster analysis principles to identify the "elbows" of a fold-change distribution, providing mathematically sound upper and lower limits for biological significance.

## Core Workflow

### 1. Data Preparation
Data must be normalized (e.g., log2 transformed) and organized with probe names in the first column, followed by initial condition replicates, then final condition replicates.

```r
library(ELBOW)

# Load data from CSV
csv_data <- read.csv("your_data.csv")

# Extract working sets (e.g., 3 initial and 3 final replicates)
working_sets <- extract_working_sets(csv_data, init_count = 3, final_count = 3)
probes <- working_sets[[1]]
initial_conditions <- working_sets[[2]]
final_conditions <- working_sets[[3]]
```

### 2. Analysis and Visualization
The `analyze_elbow` function performs the core calculation, generates a plot, and returns significant probes.

```r
# Run analysis
sig_probes <- analyze_elbow(probes, initial_conditions, final_conditions)

# The output 'sig_probes' contains probes exceeding the calculated limits
# A plot is automatically generated showing the logit curve and limits
```

### 3. Integration with Other Pipelines

**Limma Pipeline:**
For Microarray data processed with `limma`, use the `MArrayLM` object directly.
```r
# Assuming 'fit' is your eBayes object from limma
elbow_limits <- get_elbow_limma(fit)
# Returns up_limit and low_limit for each contrast
```

**DESeq Pipeline:**
For RNA-Seq data processed with `DESeq`, use the results table.
```r
# Assuming 'results' is the output from nbinomTest
limits <- do_elbow_rnaseq(results)

# Plot the results
plot_dataset(results, "log2FoldChange", limits$up_limit, limits$low_limit)
```

## Interpreting Results

- **ELBOW Limits:** The red lines on the plot. Values outside these are biologically significant.
- **Replicate Variance Error:** ELBOW provides a range (e.g., 1.9 [2.1 to 1.2]) representing the sensitivity of the limit to specific replicate pairings.
- **P-value:** ELBOW provides a log chi-squared p-value. This indicates how well the data fits the logit model. It is NOT a significance test for individual probes.
- **Null Line:** The dashed line representing the variance within the initial conditions. If the final curve is flatter than the null line, the data may be too noisy for ELBOW.

## Troubleshooting

- **No P-value:** If the p-value is missing, the data does not fit the logit model. Check for high variance in replicates.
- **Flat Curves:** Use `plot(density(replicate_data))` to check for outliers. If one replicate is significantly different from others, removing it may allow the model to fit.
- **Formatting:** Ensure the column order is strictly: [Probes] [Initial Replicates] [Final Replicates].

## Reference documentation

- [ELBOW – Evaluating foLd change By the lOgit Way](./references/Elbow_tutorial_vignette.md)