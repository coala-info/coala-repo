---
name: bioconductor-genomicinstability
description: This tool infers genomic instability and copy number variation from single-cell RNA-Seq data by calculating Genomic Instability Scores. Use when user asks to identify malignant cells, estimate copy number variations, or calculate genomic instability scores from gene expression matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/genomicInstability.html
---


# bioconductor-genomicinstability

name: bioconductor-genomicinstability
description: Infer genomic instability and copy number variation (CNV) from single-cell RNA-Seq (scRNA-Seq) data using the genomicInstability R package. Use this skill to classify cells as neoplastic (tumor) or normal based on Genomic Instability Scores (GIS) derived from gene expression and chromosomal location.

# bioconductor-genomicinstability

## Overview

The `genomicInstability` package implements Genomic Instability Analysis (GIA) to identify malignant cells in scRNA-Seq datasets without requiring matched normal samples or BAM files. It uses the aREA algorithm to estimate the association between gene expression and chromosomal loci-blocks. High variance in these associations across the genome indicates genomic instability (CNVs), which is quantified as a Genomic Instability Score (GIS).

## Core Workflow

### 1. Data Preparation
The package requires a gene expression matrix (e.g., TPM). While not required, a reference matrix of known normal cells can improve the prior for CNV estimation.

```R
library(genomicInstability)
# tpm_matrix: rows are genes (EntrezID), columns are cells
```

### 2. Inferring CNV (Loci-Block Enrichment)
Use `inferCNV()` to calculate Normalized Enrichment Scores (NES) for contiguous gene blocks.

```R
# Default: 100 genes per block, 75% overlap
cnv <- inferCNV(tpm_matrix, species = "human")

# Optional: Use a normal reference matrix
# cnv <- inferCNV(tpm_matrix, nullmat = normal_tpm_matrix)
```

### 3. Calculating Genomic Instability Score (GIS)
The GIS is the log2 variance of the NES across all loci-blocks for each cell.

```R
cnv <- genomicInstabilityScore(cnv)
# Access scores: cnv$gis
```

### 4. Estimating Neoplastic Likelihood
Fit Gaussian mixture models to the GIS distribution to calculate the probability of a cell being genomically unstable.

```R
cnv <- giLikelihood(cnv)

# If defaults fail, manually specify which Gaussian components are normal/tumor
# cnv <- giLikelihood(cnv, recompute = FALSE, normal = 1, tumor = 2:3)
```

### 5. Refinement with Inferred Normal Cells
A common pattern is to use cells with low GI likelihood (< 0.25) as a "normal" reference to re-run the analysis for higher precision.

```R
# Identify stable cells
stable_cells <- cnv$gi_likelihood < 0.25

# Re-run with inferred reference
cnv_ref <- inferCNV(tpm_matrix, nullmat = tpm_matrix[, stable_cells, drop = FALSE])
cnv_ref <- genomicInstabilityScore(cnv_ref, likelihood = TRUE)
```

## Visualization

### GIS Density Plot
Visualize the GIS distribution and the fitted Gaussian models.
```R
giDensityPlot(cnv)
```

### CNV Heatmap
Generate a heatmap of loci-block enrichment (red for amplifications, blue for deletions).
```R
# Cells are automatically sorted by GIS and grouped by likelihood
plot(cnv, output = "heatmap.png", resolution = 120, gamma = 2)
```

## Tips for Success
- **Gene Identifiers**: Ensure the input matrix uses Entrez IDs.
- **Species**: The package currently supports "human" and "mouse".
- **Parameters**: Adjust `k` (genes per block) and `skip` (displacement) in `inferCNV()` to change the resolution of the CNV inference.
- **Classification**: A GI likelihood threshold of 0.5 is typically used to distinguish tumor from normal cells.

## Reference documentation
- [genomicInstability](./references/genomicInstability.md)