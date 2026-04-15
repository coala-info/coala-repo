---
name: bioconductor-signifinder
description: This tool applies and explores published gene expression tumor signatures for bulk, single-cell, and spatial transcriptomics data. Use when user asks to compute signature scores, browse available cancer signatures, visualize score distributions, or perform survival analysis based on gene expression signatures.
homepage: https://bioconductor.org/packages/release/bioc/html/signifinder.html
---

# bioconductor-signifinder

name: bioconductor-signifinder
description: Apply and explore gene expression tumor signatures from literature using the signifinder R package. Use this skill when you need to compute signature scores for bulk, single-cell, or spatial transcriptomics data, visualize score distributions, or perform survival analysis based on cancer signatures.

## Overview

The `signifinder` package provides a standardized interface to over 60 published gene expression signatures related to cancer processes (e.g., EMT, hypoxia, immune response, ferroptosis). It integrates seamlessly with Bioconductor objects like `SummarizedExperiment`, `SingleCellExperiment`, and `SpatialExperiment`. The package handles data transformation (TPM, CPM, FPKM) and gene ID conversion automatically based on the requirements of the original signature publications.

## Core Workflow

### 1. Data Preparation
Input data should be normalized counts or normalized microarray data.
- **Object Types**: `matrix`, `data.frame`, or `SummarizedExperiment`.
- **Gene IDs**: SYMBOL, ENTREZID, or ENSEMBL (specify via `nametype`).
- **Assay Name**: If using `SummarizedExperiment`, the normalized assay should ideally be named "norm_expr".

### 2. Exploring Available Signatures
Use `availableSignatures()` to browse the collection.
```r
library(signifinder)
# List all signatures
avail <- availableSignatures()

# Filter by tissue or topic
ovary_signs <- availableSignatures(tissue = "ovary")
immune_signs <- availableSignatures(topic = "immune system")
```

### 3. Computing Scores
You can compute signatures individually or in batches. Scores are appended to the `colData` of the input object.

**Individual Signature:**
```r
# inputType must be "rnaseq" or "microarray"
result <- ferroptosisSign(dataset = my_se, inputType = "rnaseq")

# For functions with multiple authors (e.g., EMTSign), specify the author
result <- EMTSign(dataset = my_se, inputType = "rnaseq", author = "Miow")
```

**Multiple Signatures:**
```r
# By metadata
result <- multipleSign(dataset = my_se, inputType = "rnaseq", tissue = "ovary")

# By specific names
result <- multipleSign(dataset = my_se, inputType = "rnaseq", 
                       whichSign = c("EMT_Miow", "IPSOV_Shen"))
```

### 4. Evaluating Signature Quality
Check if the signature is appropriate for your dataset (e.g., gene coverage).
```r
# Get the gene list for a signature
genes <- getSignGenes("VEGF_Hu")

# Visual evaluation of technical parameters (zero values, correlation with depth)
evaluationSignPlot(data = result)
```

## Visualization Functions

`signifinder` provides several plotting functions to interpret scores:

- **Score Distribution**: `oneSignPlot(data, whichSign = "Hypoxia_Buffa")`
- **Pairwise Correlation**: `correlationSignPlot(data)`
- **Heatmaps**: `heatmapSignPlot(data, whichSign = c(...))`
- **Ridgeline Plots**: `ridgelineSignPlot(data, whichSign = c(...), groupByAnnot = data$group)`
- **Survival Analysis**: 
  ```r
  # survData is a data frame with time and status
  survivalSignPlot(data = result, survData = my_surv, 
                   whichSign = "Pyroptosis_Ye", cutpoint = "optimal")
  ```

## Key Parameters
- `inputType`: "rnaseq" or "microarray". Critical for internal data transformations.
- `nametype`: "SYMBOL", "ENTREZID", or "ENSEMBL".
- `whichAssay`: Name of the assay in `SummarizedExperiment` containing normalized data (default "norm_expr").

## Reference documentation
- [signifinder vignette](./references/signifinder.Rmd)
- [signifinder documentation](./references/signifinder.md)