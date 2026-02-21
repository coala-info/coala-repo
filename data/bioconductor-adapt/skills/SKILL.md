---
name: bioconductor-adapt
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ADAPT.html
---

# bioconductor-adapt

## Overview

ADAPT is a Bioconductor package designed for microbiome differential abundance analysis. It addresses the challenges of zero-inflation and compositionality by treating zero counts as left-censored observations within a Tobit model framework. The package identifies a set of non-differentially abundant "reference taxa" and compares other taxa against this pooled reference to determine statistical significance.

## Installation

```R
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("ADAPT")
```

## Core Workflow

### 1. Data Preparation
ADAPT requires a `phyloseq` object containing a count table and sample metadata.

```R
library(ADAPT)
# Example using built-in data
data(ecc_saliva) 
# ecc_saliva is a phyloseq object
```

### 2. Running the Analysis
The `adapt()` function is the primary interface. It supports both binary and continuous condition variables and allows for covariate adjustment.

```R
# Basic analysis
output <- adapt(
  input_data = ecc_saliva, 
  cond.var = "CaseStatus", 
  base.cond = "Control"
)

# Analysis with covariate adjustment
output_adj <- adapt(
  input_data = ecc_saliva, 
  cond.var = "CaseStatus", 
  base.cond = "Control", 
  adj.var = "Site"
)
```

**Key Arguments:**
- `input_data`: A `phyloseq` object.
- `cond.var`: The metadata column name for the condition of interest.
- `base.cond`: The reference group level (required if `cond.var` is categorical).
- `adj.var`: A vector of variable names to adjust for (covariates).
- `prev.filter`: Prevalence threshold (default = 0.05).
- `depth.filter`: Minimum sequencing depth (default = 1000 reads).
- `alpha`: Significance cutoff for BH-adjusted p-values (default = 0.05).

### 3. Exploring Results
The package provides S4 methods for summarizing and visualizing the output.

**Summary Table:**
Use `summary()` to extract a dataframe of results.
```R
# Options for 'select': "all", "da" (differentially abundant), or "ref" (reference set)
da_results <- summary(output, select = "da")
head(da_results)
```

**Visualization:**
Generate a volcano plot to visualize fold changes and significance.
```R
# n.label specifies how many top taxa to label by name
plot(output, n.label = 5)
```

## Tips for Success
- **Reference Taxa:** ADAPT automatically selects reference taxa. You can inspect which taxa were chosen by checking the `reference` slot of the output object or using `summary(output, select = "ref")`.
- **Zero Handling:** By default, zeros are censored at 1 (`censor = 1`). This is handled internally by the Tobit model, so manual pseudo-count addition is generally not required.
- **Phyloseq Integration:** Ensure your `phyloseq` object has a valid `tax_table` if you want taxonomic ranks included in the `summary()` output.

## Reference documentation
- [ADAPT Tutorial](./references/ADAPT-manual.md)