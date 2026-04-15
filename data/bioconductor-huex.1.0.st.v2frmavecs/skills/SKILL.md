---
name: bioconductor-huex.1.0.st.v2frmavecs
description: This package provides frozen parameter vectors for performing Frozen Robust Multi-array Analysis on Affymetrix Human Exon 1.0 ST v2 microarray data. Use when user asks to perform fRMA preprocessing, estimate gene expression probabilities using the barcode function, or calculate GNUSE scores for quality control.
homepage: https://bioconductor.org/packages/release/data/annotation/html/huex.1.0.st.v2frmavecs.html
---

# bioconductor-huex.1.0.st.v2frmavecs

name: bioconductor-huex.1.0.st.v2frmavecs
description: Provides frozen parameter vectors for the Affymetrix Human Exon 1.0 ST v2 microarray chip. Use this skill when performing Frozen Robust Multi-array Analysis (fRMA) or calculating Gene-specific Normalized Unscaled Standard Error (GNUSE) for huex.1.0.st.v2 data.

# bioconductor-huex.1.0.st.v2frmavecs

## Overview

The `huex.1.0.st.v2frmavecs` package is an annotation data package containing the frozen parameter vectors required to run the `frma` algorithm on Affymetrix Human Exon 1.0 ST v2 arrays. fRMA allows for the preprocessing of individual arrays or small batches by utilizing these pre-computed vectors (derived from a large training set), ensuring consistency across different studies and batches.

This package specifically supports:
- **fRMA Preprocessing**: Normalization and summarization of exon-level data.
- **Barcode Function**: Estimating the probability of gene expression (active/inactive states).
- **Quality Control**: Calculating GNUSE scores to assess array quality.

## Usage and Workflows

### Loading the Data
The package contains two primary data objects: `huex.1.0.st.v2frmavecs` (for fRMA) and `huex.1.0.st.v2barcodevecs` (for the barcode function).

```r
library(huex.1.0.st.v2frmavecs)

# Load fRMA vectors
data(huex.1.0.st.v2frmavecs)

# Load barcode vectors
data(huex.1.0.st.v2barcodevecs)
```

### Standard fRMA Workflow
To use these vectors, you typically pass the package name or the loaded data to the `frma` function from the `frma` package.

```r
library(frma)
library(huex.1.0.st.v2frmavecs)

# Assuming 'affyBatch' is your loaded Exon ST v2 data
# fRMA will automatically detect and use these vectors if the package is installed
eset <- frma(affyBatch, target = "core") 
```

### Data Structures

#### fRMA Vectors (`huex.1.0.st.v2frmavecs`)
This is a list containing parameters for normalization and summarization:
- `normVec`: Normalization vector.
- `probeVec`: Probe effect vector.
- `probeVarWithin` / `probeVarBetween`: Variance components.
- `probesetSD`: Standard deviation within probesets.
- `medianSE`: Median standard error for expression estimates.
- `mapCore`, `mapExt`, `mapFull`: Mappings between exons and transcript levels (Core, Extended, Full).

#### Barcode Vectors (`huex.1.0.st.v2barcodevecs`)
Used with the `barcode()` function to determine if a gene is expressed:
- `mu`: Background distribution means.
- `tau`: Background standard deviations.
- `entropy`: Observed gene entropy.

### Quality Control (GNUSE)
You can calculate the Gene-specific Normalized Unscaled Standard Error (GNUSE) to identify outlier arrays.

```r
# Calculate GNUSE using the frozen vectors
gnuse_values <- GNUSE(affyBatch, type="stats")
```

## Tips
- **Target Levels**: When using fRMA with exon arrays, specify the `target` level (e.g., "core", "extended", or "full"). The "core" level is most commonly used as it focuses on well-annotated transcripts.
- **Memory**: Exon array data is large. Ensure your R environment has sufficient memory when loading these vectors alongside large CEL file batches.

## Reference documentation
- [huex.1.0.st.v2frmavecs Reference Manual](./references/reference_manual.md)