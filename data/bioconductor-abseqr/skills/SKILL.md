---
name: bioconductor-abseqr
description: "bioconductor-abseqr generates interactive HTML reports and visualizations for antibody library sequencing datasets processed by abseqPy. Use when user asks to visualize antibody repertoires, generate interactive reports from abseqPy outputs, compare multiple B-cell or T-cell receptor datasets, and perform diversity or productivity analysis."
homepage: https://bioconductor.org/packages/release/bioc/html/abseqR.html
---


# bioconductor-abseqr

name: bioconductor-abseqr
description: Analysis and reporting for antibody library sequencing (Rep-Seq) datasets. Use this skill to visualize abseqPy outputs, generate interactive HTML reports, compare multiple antibody repertoires, and perform diversity or productivity analysis on B-cell/T-cell receptor data.

# bioconductor-abseqr

## Overview
The `abseqR` package is the R component of the AbSeq suite. It is designed to visualize and analyze high-throughput sequencing data from antibody libraries. It takes the output from `abseqPy` (CSV/HDF files) and transforms them into comprehensive, interactive HTML reports. Key features include sequence quality assessment, V-(D)-J germline abundance analysis, productivity/frameshift prediction, and repertoire diversity estimation (rarefaction, capture-recapture).

## Core Workflow

### 1. Initializing a Report
The primary entry point is `abseqReport`. It processes a directory containing `abseqPy` output and generates visualizations.

```r
library(abseqR)
library(BiocParallel)

# Define the path to abseqPy output directory
dataPath <- "path/to/abseqPy_output"

# Basic run: generates individual reports for all samples
# report = 3 (default) creates interactive plotly graphs
samples <- abseqReport(dataPath, report = 3)
```

### 2. Comparative Analysis
To compare specific samples within the same dataset, use the `compare` argument.

```r
# Compare PCR1, PCR2, and PCR3 together
samples <- abseqReport(dataPath, 
                       compare = c("PCR1, PCR2, PCR3"),
                       report = 3)

# Multiple separate comparisons
samples <- abseqReport(dataPath,
                       compare = c("PCR1, PCR2", "PCR2, PCR3"))
```

### 3. Custom Comparisons with S4 Objects
`abseqReport` returns a named list of `AbSeqRep` objects. You can use the `+` operator to combine these into an `AbSeqCRep` (Comparative) object for custom reporting.

```r
# Combine specific samples
myComparison <- samples[["SampleA"]] + samples[["SampleB"]]

# Generate a standalone report for this comparison
report(myComparison, outputDir = "custom_comparison_report")
```

## Key Parameters
- `report`: 
    - `0`: No plots/reports (lazy loading of S4 objects only).
    - `1`: Static PNG plots only.
    - `2`: Static plots + HTML report.
    - `3`: Static plots + Interactive (plotly) HTML report (Default).
- `BPPARAM`: Used for parallelization via `BiocParallel`.
    - `SerialParam()`: Sequential execution.
    - `MulticoreParam(workers)`: Parallel execution.

## Analysis Categories
1.  **Sequence Quality**: Length distributions and alignment quality (bitscore vs. alignment length).
2.  **Abundance**: V-(D)-J germline distribution and V-J associations (chord diagrams).
3.  **Productivity**: Identification of stop codons, frameshifts, and indels in FR/CDR regions.
4.  **Diversity**: 
    - **Duplication levels**: Singleton/doubleton proportions.
    - **Rarefaction**: Species richness estimation.
    - **Capture-recapture**: Repertoire size estimation.
    - **Spectratypes**: Amino acid length distributions.
    - **Composition Logos**: Position-specific frequency matrices (PSFM).
5.  **Comparison**: Overlapping clonotypes (Venn diagrams), scatter plots of frequencies, and clustering (Morisita-Horn/Jaccard).

## Tips
- **Unique Names**: When combining samples from different `abseqPy` runs using `+`, ensure sample names are unique.
- **Directory Structure**: `abseqReport` creates a `report/` folder. The `index.html` file is the entry point, but it requires the `html_files/` subdirectory to function.
- **Lazy Loading**: Use `report = 0` to quickly load sample data into R for downstream analysis without re-rendering heavy visualizations.

## Reference documentation
- [abseqR: reporting and data analysis functionalities for Rep-Seq datasets of antibody libraries](./references/abseqR.Rmd)
- [abseqR Package Manual](./references/abseqR.md)