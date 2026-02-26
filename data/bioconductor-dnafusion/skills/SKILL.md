---
name: bioconductor-dnafusion
description: This package detects and characterizes EML4-ALK fusions in cfDNA sequencing BAM files. Use when user asks to detect EML4-ALK fusions, identify genomic breakpoint positions, or classify specific EML4-ALK variants.
homepage: https://bioconductor.org/packages/release/bioc/html/DNAfusion.html
---


# bioconductor-dnafusion

name: bioconductor-dnafusion
description: Analyze BAM files from cfDNA sequencing to detect and characterize EML4-ALK fusions. Use this skill when a user needs to identify EML4-ALK variants, determine breakpoint positions, or perform comprehensive fusion analysis in R using the DNAfusion package.

# bioconductor-dnafusion

## Overview

The **DNAfusion** package is designed to detect and characterize EML4-ALK fusions in circulating tumor DNA (ctDNA) from paired-end sequencing BAM files. It is particularly optimized for position-deduplicated BAM files generated from targeted hybridization NGS approaches (like the AVENIO pipeline). The package identifies fusion mate pairs, determines genomic breakpoint positions, and classifies specific EML4-ALK variants.

## Installation

Install the package via Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("DNAfusion")
library(DNAfusion)
```

## Core Workflow

### 1. Detection
The primary entry point is `EML4_ALK_detection()`, which scans a BAM file for mate pair reads supporting the EML4-ALK fusion.

```r
# Detect fusion reads
results <- EML4_ALK_detection(file = "path/to/sample.bam", 
                             genome = "hg38", 
                             mates = 2)

# Check if any reads were found
if (length(results) > 0) {
    print(results)
} else {
    message("No EML4-ALK fusion detected.")
}
```

### 2. Characterization
Once reads are detected, use exploratory functions to extract specific fusion details:

*   **Sequences**: Identify basepairs leading up to or following the breakpoint.
    ```r
    EML4_seq <- EML4_sequence(results, genome = "hg38", basepairs = 20)
    ALK_seq <- ALK_sequence(results, genome = "hg38", basepairs = 20)
    ```
*   **Breakpoints**: Find the exact genomic coordinates and read depth.
    ```r
    pos_eml4 <- break_position(results, genome = "hg38", gene = "EML4")
    depth_eml4 <- break_position_depth("sample.bam", results, genome = "hg38", gene = "EML4")
    ```

### 3. Variant Identification
To identify the specific EML4-ALK variant (e.g., Variant 1, 2, or 3) based on intron locations:

```r
# Identify the specific variant and involved introns
variant_info <- find_variants(file = "sample.bam", genome = "hg38")
print(variant_info)

# Get specific intron numbers
intron_info <- introns_ALK_EML4(file = "sample.bam", genome = "hg38")
```

### 4. All-in-One Analysis
Use `EML4_ALK_analysis()` to run the detection and characterization steps in a single call, returning a list of all results.

```r
full_analysis <- EML4_ALK_analysis(file = "sample.bam", 
                                  genome = "hg38", 
                                  mates = 2, 
                                  basepairs = 20)

# Access components
full_analysis$clipped_reads
full_analysis$breakpoint_ALK
```

## Tips and Interpretation

*   **Genome Support**: The package supports "hg38" (default) and "hg19". Ensure this matches your BAM file alignment.
*   **Mate Threshold**: The `mates` parameter (default = 2) controls the sensitivity. Lowering it may increase sensitivity but also false positives.
*   **Empty Results**: If `EML4_ALK_detection()` returns an empty `GAlignments` object, subsequent characterization functions will typically return "No EML4-ALK was detected".
*   **Input Requirements**: BAM files should be indexed. The package is designed for paired-end data where one mate maps to EML4 and the other to ALK, or where soft-clipped reads span the junction.

## Reference documentation

- [Introduction to DNAfusion](./references/Introduction_to_DNAfusion.Rmd)
- [Introduction to DNAfusion](./references/Introduction_to_DNAfusion.md)