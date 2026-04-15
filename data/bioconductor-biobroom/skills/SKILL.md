---
name: bioconductor-biobroom
description: The biobroom package converts Bioconductor S4 objects into tidy data frames for easier analysis and visualization. Use when user asks to tidy differential expression results, flatten high-dimensional assay data, or convert genomic ranges into long-format tibbles.
homepage: https://bioconductor.org/packages/release/bioc/html/biobroom.html
---

# bioconductor-biobroom

## Overview

The `biobroom` package bridges the gap between Bioconductor's specialized S4 object structures and the tidy data paradigm. It provides methods for the three core verbs from the `broom` package:
- `tidy()`: Summarizes an object's statistical findings (e.g., per-gene coefficients and p-values).
- `augment()`: Adds columns to the original data (e.g., fitted values, q-values, or cluster assignments).
- `glance()`: Provides a one-row summary of the entire model or experiment.

## Core Workflows

### Differential Expression Analysis
Convert results from popular DE packages into data frames for plotting or filtering.

```r
library(biobroom)

# DESeq2
# results is a DESeqResults object
tidy_de <- tidy(results) 

# edgeR
# et is a DGEExact object
tidy_et <- tidy(et)
glance(et, alpha = 0.05) # Summary of significant genes

# limma
# eb is an MArrayLM object (after eBayes)
tidy_eb <- tidy(eb)
```

### Expression and Proteomics Data
Flatten high-dimensional assay data into long-format tibbles.

```r
# ExpressionSet (Biobase)
# addPheno = TRUE joins sample metadata (pData) to the expression values
tidy_eset <- tidy(hammer, addPheno = TRUE)

# MSnSet (MSnbase)
tidy_msn <- tidy(msnset, addPheno = TRUE)

# SummarizedExperiment / RangedSummarizedExperiment
tidy_se <- tidy(airway_se)
```

### Multiple Hypothesis Testing
Tidy `qvalue` objects to evaluate FDR and local FDR.

```r
library(qvalue)
qobj <- qvalue(p_values)

tidy(qobj)    # pi0 estimates across lambda
augment(qobj) # p-values, q-values, and lfdr for each observation
glance(qobj)  # overall pi0 estimate
```

### Genomic Ranges
Convert `GRanges` or `GRangesList` objects to tidy data frames for genomic interval analysis.

```r
# gr is a GRanges object
tidy_gr <- tidy(gr)
```

## Tips and Configuration

### Return Types
By default, `biobroom` returns `tbl_df` (tibbles). You can change the global return type to standard data frames or data tables:
```r
options(biobroom.return = "data.frame")
options(biobroom.return = "data.table")
```

### Visualization Integration
Because the output is tidy, you can pipe directly into `ggplot2`:
```r
library(ggplot2)
library(dplyr)

# Example: Volcano plot from DESeq2 results
tidy(results) %>%
  ggplot(aes(x = estimate, y = -log10(p.value))) +
  geom_point(alpha = 0.4)
```

## Reference documentation
- [biobroom Vignette (Rmd)](./references/biobroom_vignette.Rmd)
- [biobroom Vignette (md)](./references/biobroom_vignette.md)