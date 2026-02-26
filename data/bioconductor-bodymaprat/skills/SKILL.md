---
name: bioconductor-bodymaprat
description: This package provides a transcriptomic dataset of raw RNA-Seq counts across 11 organs and 4 developmental stages from a rat BodyMap study. Use when user asks to access rat gene expression data, retrieve SummarizedExperiment objects for rat tissues, or analyze transcriptomic profiles across different rat developmental stages and organs.
homepage: https://bioconductor.org/packages/release/data/experiment/html/bodymapRat.html
---


# bioconductor-bodymaprat

## Overview

The `bodymapRat` package provides a comprehensive transcriptomic dataset from a rat BodyMap study. It contains gene expression data (raw counts) for 652 RNA-Seq samples. The data is structured as a `SummarizedExperiment` object, making it compatible with standard Bioconductor workflows for differential expression, normalization, and visualization.

Key features:
- **11 Organs**: Adrenal, brain, heart, kidney, liver, lung, muscle, ovary, spleen, testis, and thymus.
- **4 Developmental Stages**: 2, 6, 21, and 104 weeks.
- **Metadata**: Includes technical details (batch, flow cell, lane), biological factors (sex, organ, stage), and quality metrics (RIN).

## Loading the Data

The primary entry point is the `bodymapRat()` function, which retrieves the data from ExperimentHub.

```r
library(SummarizedExperiment)
library(bodymapRat)

# Download and load the SummarizedExperiment object
bm_rat <- bodymapRat()
```

## Data Exploration

Once loaded, you can interact with the object using standard `SummarizedExperiment` methods.

### Accessing Counts
The counts are stored in the primary assay. Note that these are raw counts and have not been normalized.

```r
# Extract the count matrix
counts <- assay(bm_rat)

# View dimensions (typically ~32,637 genes x 652 samples)
dim(counts)

# Preview first few entries
counts[1:5, 1:5]
```

### Accessing Metadata
The `colData` contains 22 columns of phenotypic and technical information.

```r
# Get sample metadata
meta <- colData(bm_rat)

# Common columns of interest:
# organ: The tissue type
# sex: M or F
# stage: Developmental age (2, 6, 21, 104 weeks)
# rnaRIN: RNA Integrity Number
# instrument/runID/fcID: Technical batch indicators

# Example: Count samples per organ
table(bm_rat$organ)
```

## Typical Workflows

### Filtering and Normalization
Because the data is provided as raw counts, you should perform filtering and normalization before downstream analysis (e.g., using `edgeR` or `DESeq2`).

```r
# Example: Filter for samples from a specific organ
liver_samples <- bm_rat[, bm_rat$organ == "Liver"]

# Example: Filter out lowly expressed genes
keep <- rowSums(assay(bm_rat) > 1) >= 10
bm_filtered <- bm_rat[keep, ]
```

### Batch Effect Analysis
The package includes machine identifiers and flow cell information, which are useful for identifying or correcting batch effects.

```r
# Check distribution across flow cells
table(bm_rat$fcID)
```

### Visualization
The `colOrgan` column provides a pre-defined color palette to maintain consistency in plots across different organs.

```r
# Example: Plotting RIN scores by organ using the provided colors
boxplot(bm_rat$rnaRIN ~ bm_rat$organ, col = unique(bm_rat$colOrgan), las = 2)
```

## Tips
- **Batch Surrogates**: Use `instrument`, `runID`, and `fcID` as surrogates for batch effects if you observe technical variation.
- **Normalization**: This data is often used as a benchmark for normalization methods (like `qsmooth`). Always normalize before comparing across organs or stages.
- **Gene IDs**: Row names are Ensembl Gene IDs (e.g., ENSRNOG...).

## Reference documentation
- [The bodymapRat data user's guide](./references/bodymapRat.md)