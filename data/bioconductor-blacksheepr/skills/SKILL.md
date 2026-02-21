---
name: bioconductor-blacksheepr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/blacksheepr.html
---

# bioconductor-blacksheepr

name: bioconductor-blacksheepr
description: Perform Differential Extreme Value Analysis (DEVA) on biological data (proteomics, phosphoproteomics, RNAseq) to identify features with significant shifts in outlier proportions between groups. Use when analyzing extreme values in count data across binary comparisons.

# bioconductor-blacksheepr

## Overview
The `blacksheepr` package is designed for outlier analysis in biological datasets. Unlike standard differential expression which looks at mean shifts, `blacksheepr` (via the `deva` function) identifies features where one subpopulation has a significantly higher proportion of extreme values (outliers) compared to another. This is particularly useful for phosphoproteomics (where specific sites may be hyper-phosphorylated in only a subset of samples) and other -omics data with high variability.

## Core Workflow

### 1. Data Preparation
Input requires two main components:
- **Count Data**: A matrix or table with features as rows and samples as columns.
- **Annotation Data**: A dataframe where rows are samples and columns are binary comparisons (e.g., "Mutant" vs "WT").

```r
library(blacksheepr)
library(SummarizedExperiment)

# Load example data
data("sample_phosphodata")
data("sample_annotationdata")

# Create SummarizedExperiment (required for deva)
blacksheep_SE <- SummarizedExperiment(
    assays = list(counts = as.matrix(sample_phosphodata)), 
    colData = DataFrame(sample_annotationdata)
)
```

### 2. Running DEVA
The `deva` function is the primary entry point. It performs outlier calling, aggregation, and statistical testing in one step.

```r
deva_out <- deva(
    se = blacksheep_SE,
    analyze_negative_outliers = FALSE, # TRUE for low-expression outliers
    aggregate_features = TRUE,         # Collapse sub-features (e.g., sites to proteins)
    feature_delineator = "-",          # Character used to split feature names for aggregation
    fraction_samples_cutoff = 0.3,     # Min fraction of samples in a group needing an outlier
    fdrcutoffvalue = 0.1               # Significance threshold
)
```

### 3. Exploring Results
Use `deva_results` to extract tables and heatmaps from the output object.

```r
# List significant analyses
deva_results(deva_out)

# Extract a specific results table
res_table <- deva_results(deva_out, ID = "Her2", type = "table")

# Extract and plot a heatmap
res_hm <- deva_results(deva_out, ID = "Her2", type = "heatmap")
ComplexHeatmap::draw(res_hm)
```

## Specialized Tasks

### Feature Aggregation
When working with phosphoproteomics, multiple sites (e.g., `ProteinA-S102`) often belong to one protein. Setting `aggregate_features = TRUE` and providing the `feature_delineator` (e.g., `-`) allows the tool to count a protein as an outlier if *any* of its sites are outliers in that sample.

### Normalization
If data is not pre-normalized, use the built-in Median of Ratios + Log2 transformation:
```r
norm_cts <- deva_normalization(raw_counts, method = "MoR-log")
```

### Handling Multi-factor Annotations
If your metadata has more than two groups (e.g., "A", "B", "C"), use the utility function to generate binary comparison columns:
```r
expanded_annotations <- make_comparison_columns(multi_factor_df)
```

## Tips for Success
- **Binary Comparisons**: Ensure `colData` columns are strings and strictly binary.
- **Sample Matching**: Rownames of annotations must exactly match column names of the count matrix.
- **RNAseq**: For RNAseq data, set `aggregate_features = FALSE`.
- **Outlier Direction**: Run `deva` twice (once with `analyze_negative_outliers = TRUE` and once `FALSE`) if you need to see both hyper- and hypo-extreme values.

## Reference documentation
- [Outlier Analysis using blacksheepr](./references/blacksheepr_vignette.md)
- [Outlier Analysis using blacksheepr (RMarkdown)](./references/blacksheepr_vignette.Rmd)