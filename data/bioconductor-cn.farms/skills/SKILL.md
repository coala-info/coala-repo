---
name: bioconductor-cn.farms
description: This tool detects copy number variations in microarray data using a latent variable model based on the FARMS algorithm. Use when user asks to normalize SNP data, perform single-locus or multi-loci summarization, and identify genomic segments with constant copy number.
homepage: https://bioconductor.org/packages/release/bioc/html/cn.farms.html
---

# bioconductor-cn.farms

name: bioconductor-cn.farms
description: Expert guidance for the cn.farms R package to detect copy number variations (CNV) in microarray data (SNP 6.0, 250K/500K, CytoscanHD). Use this skill when performing CNV analysis pipelines including normalization (SOR), single-locus modeling, multi-loci modeling, and segmentation.

## Overview

The `cn.farms` package implements a latent variable model for CNV detection. It adapts the FARMS (Factor Analysis for Robust Microarray Summarization) algorithm to DNA copy number analysis. The workflow typically follows a three-step pipeline:
1.  **Normalization**: Correcting for cross-hybridization (Sparse Overcomplete Representation - SOR) and array-wide effects.
2.  **Modeling**: 
    *   *Single-locus modeling*: Summarizing probes targeting the same fragment/locus.
    *   *Multi-loci modeling*: Combining neighboring fragments into "meta-probes" to reduce False Discovery Rates (FDR).
3.  **Segmentation**: Identifying breakpoints using `fastseg` or `DNAcopy`.

## Typical Workflow

### 1. Initialization and Annotation
Set up the environment and create necessary annotation files from CEL files.

```R
library(cn.farms)
# Set up parallel processing and storage
cores <- 2
runtype <- "ff" # or "bm" for persistent storage
workDir <- tempdir()
setwd(workDir)

# Create annotation (required for SNP 6.0 or 250K/500K)
filenames <- dir(path = "path/to/cels", full.names = TRUE)
createAnnotation(filenames = filenames)
```

### 2. Normalization
Use `normalizeCels` for SNP data and `normalizeNpData` for non-polymorphic (CN) probes.

```R
# Normalize SNP data
normData <- normalizeCels(filenames, method = "SOR", cores = cores, alleles = TRUE, runtype = runtype)

# Normalize Non-polymorphic data
npData <- normalizeNpData(filenames, cores = cores, runtype = runtype)
```

### 3. Summarization (Modeling)
Perform single-locus summarization, combine data types, and then perform multi-loci summarization.

```R
# Single-locus summarization
slData <- slSummarization(normData, 
                          summaryMethod = "Variational", 
                          summaryParam = list(cyc = 10), 
                          callParam = list(cores = cores, runtype = runtype),
                          summaryWindow = "std")

# Combine SNP and CN probe data
combData <- combineData(slData, npData, runtype = runtype)

# Multi-loci summarization (The core CNV detection step)
# windowSize 5 is default; 3 for high resolution; 10 for low FDR
mlData <- mlSummarization(combData, 
                          windowMethod = "std", 
                          windowParam = list(windowSize = 5, overlap = TRUE),
                          summaryMethod = "Variational",
                          summaryParam = list(cyc = 20),
                          callParam = list(cores = cores, runtype = runtype))
```

### 4. Segmentation
Identify genomic segments with constant copy number.

```R
# Using the internal parallel DNAcopy wrapper
segments <- dnaCopySf(x = assayData(mlData)$L_z, 
                      chrom = fData(mlData)$chrom, 
                      maploc = fData(mlData)$start, 
                      cores = cores, 
                      smoothing = FALSE)
```

## Key Functions and Parameters

*   `cn.farms(filenames)`: Quick-start function for SNP 6.0 arrays (uses CN probes only).
*   `slSummarization`: Summarizes probe-level data to fragment-level. `summaryWindow="fragment"` summarizes probes on the same DNA fragment.
*   `mlSummarization`: The "multi-loci" step. It uses FARMS to ensure neighboring loci agree on a CNV, significantly reducing false positives.
*   `I/NI calls`: FARMS provides Informative/Non-Informative calls which indicate the signal-to-noise ratio of the estimated copy number.
*   `L_z`: The assay data element containing relative copy number values (often used for segmentation).

## Tips for Large Datasets
*   **Memory Management**: Use `runtype = "ff"` (flat-files) or `runtype = "bm"` (bigmemory) to handle large datasets that exceed RAM.
*   **Parallelization**: Always specify the `cores` parameter in `normalizeCels`, `slSummarization`, and `mlSummarization` to utilize multi-core CPUs.
*   **Window Size**: Adjust `windowParam$windowSize` in `mlSummarization` to balance between detection sensitivity (smaller window) and FDR control (larger window).

## Reference documentation
- [cn.farms](./references/cn.farms.md)