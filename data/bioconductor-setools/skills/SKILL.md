---
name: bioconductor-setools
description: The SEtools package provides convenience functions for manipulating, merging, and aggregating SummarizedExperiment objects. Use when user asks to merge multiple experiments, aggregate data by feature columns, or calculate log-fold changes relative to control samples.
homepage: https://bioconductor.org/packages/release/bioc/html/SEtools.html
---


# bioconductor-setools

## Overview

The `SEtools` package provides convenience functions for the `SummarizedExperiment` class. Its primary utility lies in robustly merging multiple experiments while handling metadata and scaling, and aggregating data by specific feature columns. 

**Note:** Heatmap and melting functions previously in `SEtools` have moved to the `sechm` package.

## Core Workflows

### 1. Merging SummarizedExperiments
Use `mergeSEs()` to combine a list of SE objects. Unlike standard `cbind`, this function handles rowData alignment and can automatically scale data.

```r
library(SEtools)

# Basic merge of a list of SE objects
se_list <- list(batch1 = se1, batch2 = se2)
merged_se <- mergeSEs(se_list)

# Merge without automatic z-score scaling
merged_se <- mergeSEs(se_list, do.scale = FALSE)

# Specify different scaling for different assays
merged_se <- mergeSEs(se_list, 
                      use.assays = c("counts", "logcpm"), 
                      do.scale = c(FALSE, TRUE))
```

### 2. Aggregating Features
Use `aggSE()` to collapse rows based on a column in `rowData` (e.g., aggregating multiple transcripts to a single gene ID).

```r
# Aggregate by a 'gene_id' column in rowData
se_aggregated <- aggSE(se, by = "gene_id")

# The function guesses aggregation methods (e.g., sum for counts, mean for logcpm)
# but you can specify them manually if needed.
```

### 3. Merging by Row Metadata
You can merge objects that do not share the same row names by using a common `rowData` column.

```r
# Merge by a 'metafeature' column and aggregate duplicates using median
merged_se <- mergeSEs(se_list, 
                      mergeBy = "metafeature", 
                      aggFun = median, 
                      do.scale = FALSE)
```

### 4. Calculating Log-Fold Changes
The `log2FC()` function calculates log2 fold-changes relative to a specific set of control samples within the same SE object.

```r
# Calculate log2FC from 'logcpm' assay using 'Homecage' samples as controls
SE <- log2FC(SE, fromAssay = "logcpm", controls = SE$Condition == "Homecage")
# This adds a new assay named 'log2FC' to the object
```

## Tips and Best Practices
- **Scaling:** By default, `mergeSEs` calculates row z-scores. If you are merging data that is already normalized or if you intend to perform downstream batch correction, set `do.scale = FALSE`.
- **Naming:** `mergeSEs` adds the list names as prefixes to the column names (e.g., `batch1.Sample1`) to prevent collisions.
- **Aggregation:** `aggSE` is a wrapper that preserves metadata slots better than generic aggregation functions. It is particularly useful for converting probe-level data to gene-level data.
- **Dependencies:** Ensure `SummarizedExperiment` is loaded alongside `SEtools`. For visualization of the results, use the `sechm` package.

## Reference documentation
- [SEtools Vignette (Rmd)](./references/SEtools.Rmd)
- [SEtools Vignette (Markdown)](./references/SEtools.md)