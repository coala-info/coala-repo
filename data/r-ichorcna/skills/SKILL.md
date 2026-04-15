---
name: r-ichorcna
description: This tool estimates tumor fraction and copy number alterations from ultra-low-pass whole genome sequencing of cell-free DNA. Use when user asks to estimate tumor purity, segment the genome, or predict copy number states in cfDNA samples.
homepage: https://cran.r-project.org/web/packages/ichorcna/index.html
---

# r-ichorcna

name: r-ichorcna
description: Estimating tumor fraction and copy number alterations (CNA) in cell-free DNA (cfDNA) from ultra-low-pass whole genome sequencing (ULP-WGS, ~0.1x coverage). Use this skill when analyzing cfDNA to determine tumor presence, segment the genome, and predict large-scale CNAs using HMM-based probabilistic modeling.

# r-ichorcna

## Overview
ichorCNA is an R package designed to estimate the fraction of tumor DNA in cell-free DNA (cfDNA) samples using ultra-low-pass whole genome sequencing (ULP-WGS). It employs a Hidden Markov Model (HMM) to simultaneously segment the genome, predict copy number states, and estimate tumor purity (fraction). It is particularly effective for guiding decisions on whether to proceed with deeper sequencing (e.g., Whole Exome Sequencing).

## Installation
To install the package from GitHub (as it is primarily hosted by the Broad Institute):

```r
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
devtools::install_github("broadinstitute/ichorCNA")
```

## Core Workflow
The R workflow typically follows these steps after generating read counts (often using the `HMMcopy` package):

1. **Data Loading and Preprocessing**:
   Load read counts and correct for GC content and mappability biases.
   ```r
   library(ichorCNA)
   # Load bin-level read counts (wig format or data frame)
   counts <- readCounter(wigFile, binSize = 1000000)
   ```

2. **Normalization**:
   Correct for GC and mappability using a Panel of Normals (PoN) if available.
   ```r
   # Apply GC and mappability correction
   correctedData <- correctReadCounts(counts, gc, map, centromeres)
   ```

3. **HMM Analysis**:
   Run the main HMM to estimate tumor fraction and CNA.
   ```r
   # Run ichorCNA analysis
   results <- runIchorCNA(id = "Sample1", 
                          bins = correctedData,
                          ploidy = c(2, 3), 
                          normal = c(0.5, 0.9),
                          maxCN = 5)
   ```

4. **Result Extraction**:
   Access the estimated tumor fraction and segmented copy number profiles.
   ```r
   # Extract tumor fraction estimate
   tumorFraction <- results$summary$tumorFraction
   ```

## Key Functions
- `runIchorCNA()`: The primary interface for running the HMM and estimating parameters.
- `readCounter()`: Utility to read WIG files containing read counts.
- `correctReadCounts()`: Performs normalization for technical biases.
- `plotGenomeWide()`: Visualizes the copy number profile across the genome.

## Tips for Success
- **Bin Size**: For ULP-WGS (0.1x), a 1Mb bin size is standard.
- **Panel of Normals (PoN)**: Using a PoN significantly improves performance by removing systematic biases found in healthy cfDNA.
- **Ploidy Initialization**: If the tumor type is known to be polyploid, include higher ploidy values (e.g., `ploidy = c(2, 4)`) in the initial parameters.
- **Tumor Fraction**: Samples with tumor fractions < 0.03 are generally considered to have "no tumor detected" or are below the limit of reliable detection for ULP-WGS.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)