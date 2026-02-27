---
name: bioconductor-rcgh
description: This tool provides a comprehensive pipeline for the analysis, normalization, and visualization of array-based Comparative Genomic Hybridization data. Use when user asks to process Agilent or Affymetrix array data, perform signal adjustment and CBS segmentation, normalize genomic profiles using EM-based centralization, or generate interactive visualizations and gene-level reports.
homepage: https://bioconductor.org/packages/release/bioc/html/rCGH.html
---


# bioconductor-rcgh

name: bioconductor-rcgh
description: Comprehensive analysis and visualization of array-based Comparative Genomic Hybridization (aCGH) data. Use this skill to process Agilent (44K to 400K), Affymetrix (SNP6.0, CytoScanHD), and custom array data. It supports signal adjustment, CBS segmentation, EM-based normalization (centralization), and interactive visualization for precision medicine workflows.

## Overview
The `rCGH` package provides a unified pipeline for aCGH data analysis. It uses a specific object class (inheriting from a general `rCGH` superclass) to store probe data, segmentation results, and workflow parameters, ensuring full traceability. The workflow typically moves from raw data reading to signal adjustment, segmentation, normalization, and finally visualization or gene-level reporting.

## Typical Workflow

### 1. Data Loading
Load data based on the platform. For Affymetrix, files must first be processed via ChAS or APT to export `.chp.txt` files.

```R
library(rCGH)

# For Affymetrix CytoScanHD
cgh <- readAffyCytoScan("path/to/file.cnchp.txt", genome = "hg19")

# For Affymetrix SNP6.0
cgh <- readAffySNP6("path/to/file.cnchp.txt", genome = "hg19")

# For Agilent
cgh <- readAgilent("path/to/file.txt", genome = "hg19")

# For Custom/Generic arrays (requires ProbeName, ChrNum, ChrStart, Log2Ratio)
cgh <- readGeneric("path/to/generic.txt", genome = "hg19")
```

### 2. Signal Adjustment and Segmentation
Adjust for GC content and biases, then identify genomic breakpoints using Circular Binary Segmentation (CBS).

```R
# Adjust signal (scaling and filtering)
cgh <- adjustSignal(cgh)

# Perform segmentation
# UndoSD can be specified (0.5 to 1.5) or left NULL for auto-estimation
cgh <- segmentCGH(cgh, nCores = 1)

# View the segmentation table
segTable <- getSegTable(cgh)
```

### 3. EM Normalization (Centralization)
Define the 2-copy baseline using an Expectation-Maximization algorithm to model LRR distributions.

```R
# Normalize/Center the profile
cgh <- EMnormalize(cgh)

# Check the density plot to verify the chosen peak
plotDensity(cgh)

# If the auto-selection is incorrect, recenter on a specific peak index
recenter(cgh) <- 2
```

### 4. Visualization and Reporting
Generate static plots or launch an interactive Shiny-based viewer.

```R
# Static profile with specific genes highlighted
plotProfile(cgh, symbol = c("ERBB2", "EGFR"))

# Multiplot (Profile + LOH) - requires cnchp files with allelic differences
multiplot(cgh, symbol = "ERBB2")

# Interactive Shiny viewer
view(cgh)

# Generate a by-gene table for downstream analysis
geneTable <- byGeneTable(getSegTable(cgh), genome = "hg19")
```

## Key Functions and Parameters
- `setInfo()` / `getInfo()`: Manage sample metadata within the rCGH object.
- `getParam()`: Retrieve parameters used during the analysis for reproducibility.
- `genome`: Supported builds are "hg18", "hg19" (default), and "hg38".
- `nCores`: Supported for `segmentCGH` and `EMnormalize` on Linux/OSX to speed up processing.

## Tips for Success
- **Affymetrix Files**: Use `.cnchp.txt` instead of `.cychp.txt` if you need Allelic Difference data for LOH estimation.
- **Custom Arrays**: Ensure the input file has the four mandatory columns: `ProbeName`, `ChrNum`, `ChrStart`, and `Log2Ratio`.
- **Gene Symbols**: When plotting or creating gene tables, use official HUGO symbols.
- **Memory/Speed**: For large arrays, use `nCores` > 1 on supported systems to parallelize the CBS algorithm.

## Reference documentation
- [rCGH](./references/rCGH.md)