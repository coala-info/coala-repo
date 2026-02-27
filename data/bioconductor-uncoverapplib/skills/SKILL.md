---
name: bioconductor-uncoverapplib
description: This tool provides an interactive Shiny application for the clinical assessment and visualization of sequence coverage at base-pair resolution. Use when user asks to launch the unCOVERApp interface, download clinical annotation files, prepare coverage input files from BAM files, or analyze gene coverage gaps for clinical significance.
homepage: https://bioconductor.org/packages/release/bioc/html/uncoverappLib.html
---


# bioconductor-uncoverapplib

name: bioconductor-uncoverapplib
description: Clinical assessment of sequence coverage at base-pair resolution using the uncoverappLib R package. Use this skill to launch the unCOVERApp Shiny application, download required clinical annotation files, prepare coverage input files from BAM files and gene lists, and perform binomial distribution calculations for variant supporting reads.

# bioconductor-uncoverapplib

## Overview

`uncoverappLib` is a Bioconductor package that provides **unCOVERApp**, an interactive Shiny application designed for the clinical assessment of sequence coverage. It allows researchers and clinicians to visualize gene coverage at base-pair resolution, identify coverage gaps, and annotate these gaps with functional and clinical data (e.g., ClinVar, dbNSFP). It also includes tools for calculating maximum credible population allele frequencies and binomial probabilities for variant calling support.

## Core Workflow

### 1. Initial Setup and Annotations
Before using the application for clinical assessment, you must download the necessary annotation files. These are stored in a local cache using `BiocFileCache`.

```r
library(uncoverappLib)

# Download clinical annotation files (required once)
# Use vignette = TRUE for a smaller example set during testing
getAnnotationFiles(verbose = TRUE)
```

### 2. Launching the Interactive App
The primary interface is a Shiny application. You can control where the app opens (browser, RStudio viewer, or a new window).

```r
# Launch the app in your default web browser
run.uncoverapp(where = "browser")
```

### 3. Preparing Input Files
unCOVERApp requires a specific BED-style input file containing genomic coordinates, coverage values, and allele counts. You can generate this within the app's "Preprocessing" page or via the R console for large gene lists.

**Required Inputs:**
- **Gene List**: A `.txt` file with one HGNC gene symbol per row.
- **BAM List**: A `.list` file containing absolute paths to BAM files (one per row).

**Console-based Preprocessing:**
For more than 50 genes, use the `buildInput` function to avoid GUI timeouts.

```r
# Example: Creating a BAM list file
bam_path <- system.file("extdata", "example_POLG.bam", package = "uncoverappLib")
write.table(bam_path, file = "samples.list", quote = FALSE, row.names = FALSE, col.names = FALSE)

# Note: buildInput is typically called internally or used to generate 
# the file required for the 'Coverage Analysis' tab.
```

### 4. Coverage Analysis Features
Once the input file is loaded into the app:
- **Gene Coverage**: Visualize the entire gene with Ensembl and UCSC annotations.
- **Exon Zoom**: Focus on specific exons (e.g., Exon 10 of *POLG*) to see base-pair resolution.
- **Clinical Annotation**: View low-coverage positions overlapping with ClinVar pathogenic variants or high-impact dbNSFP predictions.
- **Binomial Distribution**: Calculate the probability of observing variant-supporting reads based on depth of coverage and expected allele fraction.

## Key Functions

- `getAnnotationFiles()`: Downloads and caches Zenodo-hosted annotation databases.
- `run.uncoverapp(where)`: Starts the Shiny GUI. Options for `where` include `"browser"`, `"viewer"`, or `"window"`.
- `buildInput()`: Helper function to process BAM files into the unCOVERApp-compatible BED format.

## Tips for Success
- **Java Requirement**: Ensure Java is installed on the system, as it is a dependency for some underlying processing.
- **Chromosome Notation**: Match the notation in your BAM files (e.g., "1" vs "chr1") in the Preprocessing settings to avoid empty outputs.
- **Memory Management**: For very large BAM files or extensive gene panels, generate the input BED file using command-line tools like `samtools depth` or `bedtools` and load the result directly into the "Coverage Analysis" page.

## Reference documentation

- [uncoverappLib: interactive graphical application for clinical assessment of sequence coverage](./references/uncoverappLib.md)
- [uncoverappLib R Markdown Source](./references/uncoverappLib.Rmd)