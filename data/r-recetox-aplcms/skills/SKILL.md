---
name: r-recetox-aplcms
description: R package recetox-aplcms (documentation from project home).
homepage: https://cran.r-project.org/web/packages/recetox-aplcms/index.html
---

# r-recetox-aplcms

## Overview
`recetox-aplcms` is a custom fork of the `apLCMS` R package, optimized for large-scale untargeted metabolomics studies. It provides a complete pipeline for processing high-resolution mass spectrometry data, including noise reduction, peak identification, peak grouping across samples, and alignment. This version includes performance adaptations and bug fixes specifically designed for high-throughput environmental and health risk research.

## Installation
To install the package from CRAN:
```R
install.packages("recetox-aplcms")
```

## Core Workflow
The package typically follows a multi-step process to transform raw LC-MS data into a feature table.

### 1. Peak Detection (Single Sample)
Use `proc.qc()` or `semisup.pk()` to extract peaks from individual samples.
```R
# Basic peak extraction
peaks <- proc.qc(filename, mz.tol = 1e-05, peak.width = c(5, 60))
```

### 2. Peak Alignment and Grouping
Combine multiple samples into a single feature table.
```R
# Align peaks across multiple samples
aligned_features <- feature.align(peak_list, min.exp = 2)
```

### 3. Feature Table Generation
Generate the final intensity matrix where rows are features (m/z and retention time) and columns are samples.

## Key Functions
- `proc.qc()`: The primary function for unsupervised peak detection and quantification.
- `semisup.pk()`: Semi-supervised peak detection using a provided list of known metabolites.
- `feature.align()`: Aligns features across different samples based on m/z and retention time tolerances.
- `rt.corrector()`: Performs retention time correction to account for chromatographic shifts between runs.

## Usage Tips
- **Large Scale Studies**: This fork is specifically optimized for memory management and speed when processing hundreds or thousands of samples.
- **Tolerance Settings**: Ensure `mz.tol` matches the resolution of your instrument (e.g., 1e-05 for 10 ppm).
- **Data Input**: The package typically expects data in standard formats supported by `mzR` or pre-processed peak lists.

## Reference documentation
- [GitHub Articles](./references/articles.md)
- [RECETOX Home Page](./references/home_page.md)