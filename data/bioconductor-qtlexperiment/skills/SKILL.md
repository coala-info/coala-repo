---
name: bioconductor-qtlexperiment
description: The QTLExperiment package provides an S4 class container for storing and manipulating QTL summary statistics across multiple states or conditions. Use when user asks to create QTLExperiment objects from summary statistic files, convert mashr objects to QTL format, or access and subset QTL effect sizes and standard errors.
homepage: https://bioconductor.org/packages/release/bioc/html/QTLExperiment.html
---


# bioconductor-qtlexperiment

## Overview

The `QTLExperiment` package provides an S4 class container for storing and manipulating QTL summary statistics (effect sizes, standard errors, p-values) across multiple "states" (e.g., tissues or conditions). It extends the `RangedSummarizedExperiment` class, where rows represent QTL associations (feature-variant pairs) and columns represent states.

## Core Workflows

### 1. Creating QTLExperiment Objects

**Manual Creation:**
If you have matrices for betas and errors where rows are named `feature_id|variant_id`:
```r
library(QTLExperiment)
qtle <- QTLExperiment(
    assays = list(betas = beta_matrix, errors = error_matrix),
    metadata = list(study = "my_study")
)
```

**From Summary Statistic Files:**
Use `sumstats2qtle()` to load data from multiple files (one per state).
```r
input_df <- data.frame(
    state = c("lung", "blood"),
    path = c("path/to/lung_stats.tsv", "path/to/blood_stats.tsv")
)

qtle <- sumstats2qtle(
    input_df,
    feature_id = "gene_id",
    variant_id = "snp_id",
    betas = "beta",
    errors = "se",
    pvalues = "pvalue"
)
```

**From mashr:**
Convert `mash` objects directly:
```r
qtle <- mash2qtle(mash_object)
```

### 2. Accessing and Manipulating Data

The package provides specific getters and setters to ensure metadata consistency:

*   **Assays:** Use `betas(qtle)`, `errors(qtle)`, `pvalues(qtle)`, or `lfsrs(qtle)`.
*   **Identifiers:** Use `state_id(qtle)`, `feature_id(qtle)`, and `variant_id(qtle)`.
*   **Subsetting:** Standard R subsetting works. `qtle[rows, cols]` or `subset(qtle, , sample_size > 100)`.

### 3. Adding Custom Assays
You can store arbitrary metrics (e.g., significance flags) using the generic `assay` function:
```r
assay(qtle, "significant") <- assay(qtle, "pvalues") < 0.05
```

## Key Functions Reference

| Function | Description |
| :--- | :--- |
| `QTLExperiment()` | Constructor for manual object creation. |
| `sumstats2qtle()` | Loads and merges summary stats from files into one object. |
| `mockQTLE()` | Generates a random QTLExperiment object for testing. |
| `mash2qtle()` | Converts mashr output to QTLExperiment format. |
| `betas()`, `errors()` | Specialized getters/setters for primary QTL statistics. |
| `state_id()` | Accesses or renames the states (columns). |

## Tips for Success
*   **Row Naming:** The package expects row names in the format `feature_id|variant_id`. If you provide these IDs separately in the constructor, ensure the assay rows match that order.
*   **Memory:** `sumstats2qtle` uses `vroom` for fast loading. For very large datasets, ensure your environment has sufficient RAM as it merges states into a dense matrix.
*   **Missing Data:** Use the `na.rm = TRUE` argument in `sumstats2qtle()` if you only want to keep QTLs tested across all states.

## Reference documentation
- [An introduction to the QTLExperiment class](./references/QTLExperiment.md)