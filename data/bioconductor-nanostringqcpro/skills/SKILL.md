---
name: bioconductor-nanostringqcpro
description: This tool performs quality control and preprocessing of NanoString nCounter gene expression data. Use when user asks to import RCC and RLF files, perform positive control normalization, background correction, RNA content normalization, or generate HTML QC reports.
homepage: https://bioconductor.org/packages/3.8/bioc/html/NanoStringQCPro.html
---


# bioconductor-nanostringqcpro

name: bioconductor-nanostringqcpro
description: Quality control and preprocessing of NanoString nCounter gene expression data. Use this skill to import RCC and RLF files into RccSet objects, perform positive control normalization, background correction (including probe-specific methods), RNA content normalization (housekeeping or median), and generate comprehensive HTML QC reports.

# bioconductor-nanostringqcpro

## Overview

The `NanoStringQCPro` package is designed for the analysis of NanoString nCounter mRNA gene expression data. It extends the standard Bioconductor `ExpressionSet` class into a specialized `RccSet` object. The package provides a structured workflow for technical normalization and quality assessment, specifically addressing platform-specific variations and probe-specific background noise.

## Core Workflow

### 1. Data Import and RccSet Creation

The primary entry point is `newRccSet()`. It requires raw count files (.RCC) and a library file (.RLF).

```r
library(NanoStringQCPro)

# Define paths to data
rcc_files <- dir("path/to/RCC_folder", full.names = TRUE, pattern = "\\.RCC$")
rlf_file <- "path/to/library_file.rlf"

# Create the RccSet
rcc_set <- newRccSet(
  rccFiles = rcc_files,
  rlf = rlf_file,
  cdrDesignData = "path/to/CDR_DesignData.csv", # Optional but recommended
  extraPdata = "path/to/sample_annotation.txt", # Optional
  blankLabel = "blank"                          # Label used for water runs
)
```

### 2. Preprocessing

Preprocessing can be performed in a single step using `preprocRccSet()` or sequentially.

**Single-step approach:**
```r
# Performs positive control, background, and housekeeping normalization
norm_rcc_set <- preprocRccSet(rccSet = rcc_set, normMethod = "housekeeping")
```

**Sequential approach:**

*   **Positive Control Normalization:** Adjusts for hybridization efficiency.
    ```r
    rcc_set <- posCtrlNorm(rcc_set, summaryFunction = "sum")
    ```
*   **Background Correction:** Supports lane-specific (negative controls) or probe-specific (blanks) correction.
    ```r
    # Combined approach mimicking nSolver
    bg_estimates <- getBackground(rcc_set, bgReference = "both", stringency = 1)
    rcc_set <- subtractBackground(rcc_set, bgEstimates = bg_estimates)
    ```
*   **Content Normalization:** Adjusts for RNA input differences.
    ```r
    # Housekeeping (recommended for focused panels)
    rcc_set <- contentNorm(rcc_set, method = "housekeeping")
    
    # Median (recommended for >300 probes)
    rcc_set <- contentNorm(rcc_set, method = "median")
    ```

### 3. Quality Control Reporting

Generate a comprehensive HTML report and diagnostic files.

```r
makeQCReport(norm_rcc_set, outputName = "My_Project_QC_Report")
```
This produces:
*   An HTML report with visualization of scaling factors and flags.
*   `SampleFlags.txt`: Technical, Control, and Count flags for each sample.
*   `HousekeepingGeneStats.txt`: Performance metrics for housekeeping genes.

## Key Functions and Data Access

*   `exprs(rcc_set)`: Access the main expression matrix. Note: `normData` is stored on the log2 scale, while others are on the natural scale.
*   `pData(rcc_set)`: Access sample metadata, including `PosFactor` (scaling factors).
*   `fData(rcc_set)`: Access probe metadata (CodeClass, GeneName, Accession).
*   `preproc(rcc_set)`: View the parameters used during preprocessing.

## Tips for Success

*   **Blanks:** Include at least 3 "blank" (water) samples to enable superior probe-specific background correction.
*   **Housekeeping Genes:** Ensure at least 3 housekeeping genes are defined. If the default panel genes are poor, pass a custom vector to the `hk` argument in `contentNorm`.
*   **Scaling Factors:** Check the `PosFactor` in the QC report. Values outside the 0.3 - 3.0 range indicate potential technical failure of the lane.
*   **Pseudo-counts:** The package automatically adds a pseudo-count of 1 to all measurements to facilitate log transformation.

## Reference documentation

- [NanoStringQCPro Vignette](./references/vignetteNanoStringQCPro.md)