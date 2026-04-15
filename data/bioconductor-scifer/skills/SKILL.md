---
name: bioconductor-scifer
description: Bioconductor-scifer integrates single-cell BCR/TCR Sanger sequences with flow cytometry index data and performs automated quality control. Use when user asks to process .fcs index files, perform quality control on .ab1 chromatograms, merge sequencing results with flow data based on plate well positions, or perform IgBlast analysis for V(D)J assignment.
homepage: https://bioconductor.org/packages/release/bioc/html/scifer.html
---

# bioconductor-scifer

name: bioconductor-scifer
description: Integration and quality control of single-cell sorted B/T cell receptor (BCR/TCR) Sanger sequences with flow cytometry index data. Use when Claude needs to process .fcs index files, perform automated QC on .ab1 chromatograms, merge sequencing results with flow data based on plate well positions, and generate fasta files or summary reports for BCR/TCR analysis.

# bioconductor-scifer

## Overview
The `scifer` package is designed for researchers performing single-cell sorting (e.g., in 96 or 384-well plates) followed by Sanger sequencing of B cell or T cell receptors. It automates the tedious process of matching flow cytometry index data with sequencing chromatograms, performing quality control (QC) on sequences, and generating integrated reports.

## Installation
Install the package via Bioconductor:
```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("scifer")
library(scifer)
```

## Core Workflow

### 1. Processing Flow Cytometry Index Data
Use `fcs_processing` to read index sorting files. This function extracts well positions and assigns "specificity" based on fluorescence thresholds.

```r
fcs_data <- fcs_processing(
    folder_path = "path/to/fcs_files",
    compensation = TRUE,      # Apply internal compensation matrix
    plate_wells = 96,         # 96 or 384
    probe1 = "Pre.F",         # Channel name or marker
    probe2 = "Post.F",
    posvalue_probe1 = 600,    # Threshold for positivity
    posvalue_probe2 = 400
)

# Visualize the gating/thresholds
fcs_plot(fcs_data)
```

### 2. Sanger Sequence Quality Control
You can process a single file or an entire folder of `.ab1` files.

**Batch Processing:**
```r
sf <- summarise_quality(
    folder_sequences = "path/to/ab1_files",
    secondary.peak.ratio = 0.33, # Threshold for calling double peaks
    trim.cutoff = 0.01,          # Phred score based trimming
    processor = NULL             # NULL auto-detects cores for parallel processing
)

# View summary metrics (trimmed length, mean quality, etc.)
head(sf$summaries)
```

### 3. Integrated Quality Reporting
The `quality_report` function is the primary tool for merging flow and sequence data. It generates HTML reports, filtered fasta files, and chromatogram PDFs for sequences with secondary peaks (often indicating the CDR3 region).

```r
quality_report(
    folder_sequences = "path/to/ab1_files",
    folder_path_fcs = "path/to/fcs_files",
    output_dir = "results_folder",
    outputfile = "QC_report.html",
    probe1 = "Pre.F", 
    probe2 = "Post.F",
    posvalue_probe1 = 600, 
    posvalue_probe2 = 400
)
```

### 4. IgBlast Analysis
After generating a fasta file, use `igblast` to perform V(D)J assignment. This requires a local database folder containing `V.fasta`, `D.fasta`, and `J.fasta`.

```r
ighv_res <- igblast(
    database = "path/to/database_folder",
    fasta = "results_folder/sequences.fasta",
    threads = 1
)
```

## Key Tips
- **Folder Organization:** Ensure the nomenclature of `.fcs` files and the subfolders containing `.ab1` files match. This is critical for the merging logic.
- **Specificity Column:** The `fcs_processing` function automatically creates a `specificity` column (e.g., `DP` for double-positive, `DN` for double-negative) based on your probe thresholds.
- **TCR Usage:** While designed for BCRs, it works for TCRs; however, ensure your primers and QC parameters (like expected sequence length) are adjusted accordingly.
- **Parallelization:** For large plates, set `processor` in `summarise_quality` to use multiple cores to speed up chromatogram processing.

## Reference documentation
- [Using scifer to filter single-cell sorted B cell receptor (BCR) sanger sequences](./references/scifer_walkthrough.md)