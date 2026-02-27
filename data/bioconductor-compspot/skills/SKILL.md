---
name: bioconductor-compspot
description: The compSPOT package identifies significant genomic mutation hotspots and compares their mutational burden across different experimental groups or clinical variables. Use when user asks to identify significant mutation hotspots, compare mutation distributions between cohorts, or correlate hotspot mutation counts with clinical features.
homepage: https://bioconductor.org/packages/release/bioc/html/compSPOT.html
---


# bioconductor-compspot

## Overview

The `compSPOT` package is designed to identify and analyze mutation hotspots—genomic regions with significantly higher mutation frequencies that may serve as markers for cancer risk or progression. It is often used as a downstream analysis tool for regions identified by `seq.hotSPOT`. The package provides statistical frameworks (primarily Kolmogorov-Smirnov tests) to define hotspots and compare their mutational burden across different experimental groups or clinical variables.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("compSPOT")
library(compSPOT)
```

## Data Structures

### Mutation Data
A data frame containing:
- `Chromosome`: Chromosome ID.
- `Position`: Genomic coordinate.
- `Sample`: Unique sample identifier.
- `Gene`: (Optional) Gene name.
- `Group`: (Required for `compare_groups`) Classification ID.
- Clinical columns: (Required for `compare_features`) e.g., Age, Sex, Smoking History.

### Regions Data
A data frame containing:
- `Chromosome`: Chromosome ID.
- `Lowerbound`: Start position.
- `Upperbound`: End position.
- `Gene`: (Optional) Gene name.

## Core Workflow

### 1. Identifying Significant Hotspots
Use `find_hotspots` to filter a list of candidate regions down to those with statistically significant mutation frequencies.

```r
# data: mutation dataframe; regions: candidate regions dataframe
significant_spots <- find_hotspots(
  data = my_mutations, 
  regions = my_regions, 
  pvalue = 0.05, 
  threshold = 0.2, 
  include_genes = TRUE, 
  rank = TRUE
)

# Access the results table
hotspot_table <- significant_spots[[1]]
```

### 2. Comparing Groups
Use `compare_groups` to determine if specific hotspots show different mutation distributions between two cohorts (e.g., High-Risk vs. Low-Risk).

```r
# Filter for identified hotspots first
hotspots_only <- subset(hotspot_table, type == "Hotspot")

group_results <- compare_groups(
  data = my_mutations, 
  regions = hotspots_only, 
  pval = 0.05, 
  threshold = 0.2, 
  name1 = "Group_A", 
  name2 = "Group_B", 
  include_genes = TRUE
)

# View statistical comparison
print(group_results[[1]])
```

### 3. Clinical Feature Correlation (EDA)
Use `compare_features` to correlate mutation counts within hotspots against clinical or personal risk factors. It automatically handles categorical (Wilcox/Kruskal-Wallis) and sequential (Pearson correlation) variables.

```r
clinical_vars <- c("AGE", "SEX", "SMOKING_HISTORY")
feature_analysis <- compare_features(
  data = my_mutations, 
  regions = my_regions, 
  feature = clinical_vars
)
```

## Tips and Best Practices
- **Sequential Workflow**: `compSPOT` is designed to work with `seq.hotSPOT`. Use the latter to generate the initial `regions` input.
- **Output Format**: Most functions return a list where the first element `[[1]]` is the numerical summary table and subsequent elements are visualization objects (e.g., ggplot or plotly).
- **Normalization**: The package internally normalizes mutation frequencies when performing Kolmogorov-Smirnov tests to ensure comparisons across regions of different sizes or mutation densities are valid.

## Reference documentation
- [compSPOT-Vignette](./references/compSPOT-vignette.md)
- [compSPOT-Vignette Source](./references/compSPOT-vignette.Rmd)