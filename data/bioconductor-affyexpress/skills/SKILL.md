---
name: bioconductor-affyexpress
description: This package provides an integrated pipeline for quality control, preprocessing, and differential expression analysis of Affymetrix microarray data. Use when user asks to perform quality assessment, normalize raw data, filter probes, or identify significant genes using single-factor and interaction models.
homepage: https://bioconductor.org/packages/3.5/bioc/html/AffyExpress.html
---

# bioconductor-affyexpress

## Overview

The `AffyExpress` package provides an integrated pipeline for Affymetrix microarray analysis. It is designed to simplify the statistical complexities of generating design and contrast matrices for various experimental layouts, including single-factor, multi-factor, and interaction models. The package automates quality control (QC) reporting and provides hyperlinked HTML tables for results.

## Core Workflow

### 1. Data Loading and Quality Assessment
Load raw data into an `AffyBatch` object and generate a comprehensive HTML QC report.

```R
library(AffyExpress)
# Assuming 'raw' is an AffyBatch object
# parameters: vector of phenoData column names for grouping
AffyQA(parameters = c("treatment", "time"), raw = raw)
```
The `AffyQA` function generates RNA digestion plots, sample clustering, and pseudo-chip images (NUSE/RLE).

### 2. Preprocessing and Filtering
Convert raw data to an `ExpressionSet` and filter out low-expression probes.

```R
# Preprocess using "rma" or "gcrma"
normaldata <- pre.process(method = "rma", raw = raw)

# Filter: keep genes with expression > 6 in at least 2 chips
filtered <- Filter(object = normaldata, numChip = 2, bg = 6)
```

### 3. Differential Expression Analysis
`AffyExpress` uses a specific approach to building design and contrast matrices.

#### Single Factor Analysis
```R
# Create design matrix
design <- make.design(target = pData(filtered), cov = "estrogen")

# Create contrast (compare 'present' vs 'absent')
contrast <- make.contrast(design.matrix = design, compare1 = "present", compare2 = "absent")

# Run regression (method: "L" for LIMMA, "P" for Permutation, "O" for Ordinary)
result <- regress(object = filtered, design = design, contrast = contrast, method = "L", adj = "fdr")

# Select significant genes
sig_genes <- select.sig.gene(top.table = result, p.value = 0.05, m.value = log2(1.5))

# Export to HTML
result2html(cdf.name = annotation(filtered), result = sig_genes, filename = "results")
```

#### Interaction and Multi-factor Analysis
To test if the treatment effect differs across time points:

```R
# Design with interaction
design.int <- make.design(pData(filtered), cov = c("estrogen", "time.h"), int = c(1, 2))

# Contrast for interaction effect
contrast.int <- make.contrast(design.int, interaction = TRUE)

# Identify genes with significant interaction
result.int <- regress(object = filtered, design = design.int, contrast = contrast.int, method = "L")
```

### 4. Wrapper Functions
For standard analyses, use high-level wrappers to execute the full pipeline (design, contrast, regression, selection, and output).

*   **AffyRegress**: For single factor or randomized block designs.
*   **AffyInteraction**: For complex interaction models. It automatically splits analysis for genes with and without significant interaction effects.

```R
result.wrapper <- AffyRegress(
  normal.data = filtered, 
  cov = "estrogen", 
  compare1 = "present", 
  compare2 = "absent", 
  method = "L", 
  p.value = 0.05, 
  m.value = log2(1.5)
)
```

## Tips and Best Practices
*   **Phenotype Data**: Ensure `pData` is correctly formatted before calling `make.design`. The column names in `cov` must match the metadata exactly.
*   **Method Selection**: Use `method = "L"` (LIMMA) for most studies, especially those with small sample sizes, as it uses empirical Bayes shrinkage.
*   **Interaction Logic**: If an interaction is significant, use `post.interaction` to analyze the treatment effect at specific levels of the second factor.
*   **HTML Reports**: The package automatically creates files in the working directory. Use `result2html` or `interaction.result2html` to share annotated results with collaborators.

## Reference documentation
- [Affymetrix Quality Assessment and Analysis Tool](./references/AffyExpress.md)