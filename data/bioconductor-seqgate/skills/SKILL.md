---
name: bioconductor-seqgate
description: SeqGate filters lowly expressed features in RNA-Seq data using a data-driven threshold derived from replicates. Use when user asks to filter RNA-Seq features, remove lowly expressed genes, or calculate a count threshold based on biological replicates.
homepage: https://bioconductor.org/packages/release/bioc/html/SeqGate.html
---

# bioconductor-seqgate

## Overview

SeqGate is an R package designed to filter lowly expressed features in RNA-Seq experiments. Unlike methods that use an arbitrary fixed threshold (e.g., "counts > 10"), SeqGate uses the replicates within the experiment to determine a data-driven threshold. It identifies features that are likely not expressed by looking at the distribution of counts in replicates where some samples have zero counts. It then calculates a threshold based on a customizable percentile of this distribution and filters features that do not meet this threshold in a minimum proportion of replicates.

## Installation

To install the package from Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("SeqGate")
```

## Core Workflow

The primary function is `applySeqGate()`, which operates on `SummarizedExperiment` objects.

### 1. Data Preparation
SeqGate requires a `SummarizedExperiment` object containing:
- An assay with numeric count data.
- `colData` containing a column that defines the biological conditions (groups).

```r
library(SeqGate)
library(SummarizedExperiment)

# Example: Creating a SummarizedExperiment from a matrix 'count_matrix'
# and a condition vector 'groups'
se <- SummarizedExperiment(
    assays = list(counts = count_matrix),
    colData = DataFrame(Conditions = groups)
)
```

### 2. Applying the Filter
Run the filter using the default parameters, which are optimized for most RNA-Seq datasets.

```r
# se: The SummarizedExperiment object
# "counts": The name of the assay to use
# "Conditions": The name of the column in colData defining groups
se <- applySeqGate(se, assayName = "counts", conditionCol = "Conditions")
```

### 3. Extracting Results
The function adds information to the input object:
- **`rowData(se)$onFilter`**: A logical vector where `TRUE` means the feature passed the filter and `FALSE` means it should be discarded.
- **`metadata(se)$threshold`**: The specific count threshold calculated by the algorithm.

```r
# Get features that passed the filter
kept_features <- se[rowData(se)$onFilter == TRUE, ]

# Get the count matrix of kept features
kept_counts <- assay(kept_features)

# Check the calculated threshold
thresh <- metadata(se)$threshold
```

## Customizing Parameters

You can refine the filtering logic using three main parameters:

- **`prop0`**: The minimal proportion of zeros in a condition required to consider a feature "lowly expressed" for the purpose of calculating the threshold. (Default: `(max_reps - 1) / max_reps`).
- **`percentile`**: The percentile of the distribution of maximum counts found alongside zeros used to set the threshold. (Default: `0.9` if replicates < 5).
- **`propUpThresh`**: The proportion of replicates that must have counts above the threshold in at least one condition to keep the feature. (Default: `0.9`).

```r
se <- applySeqGate(se, "counts", "Conditions",
                  prop0 = 0.33,
                  percentile = 0.8,
                  propUpThresh = 0.5)
```

## Tips for Success
- **Input Scale**: SeqGate is designed for raw or normalized count data. Do not use log-transformed data.
- **Replicates**: The method relies on biological replicates. It is most effective when at least 3 replicates per condition are available.
- **Downstream Analysis**: Apply SeqGate after initial data quality control but before normalization and differential expression testing (e.g., with DESeq2 or edgeR).

## Reference documentation

- [SeqGate: Filter lowly expressed features](./references/Seqgate-html-vignette.md)
- [SeqGate: Filter lowly expressed features (Rmd source)](./references/Seqgate-html-vignette.Rmd)