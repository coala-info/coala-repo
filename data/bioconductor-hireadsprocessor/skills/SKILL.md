---
name: bioconductor-hireadsprocessor
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/hiReadsProcessor.html
---

# bioconductor-hireadsprocessor

name: bioconductor-hireadsprocessor
description: Functions to process LM-PCR reads from next-generation sequencing. Use when analyzing genomic integration sites, performing linker/adapter trimming, primer identification, and genomic alignment processing for high-throughput sequencing data.

# bioconductor-hireadsprocessor

## Overview
The `hiReadsProcessor` package provides a comprehensive suite of tools for processing raw sequences derived from Linear Amplification Mediated PCR (LAM-PCR) or similar specialized sequencing protocols. It excels at handling "many-to-one" mapping scenarios where multiple reads must be trimmed of technical sequences (linkers, primers) and mapped to a reference genome to identify integration sites or specific genomic features.

## Core Workflow

### 1. Project Initialization
The package uses a configuration-based approach. Start by defining your sample information.

```r
library(hiReadsProcessor)

# Define sample information (usually from a spreadsheet)
# Required columns typically include: SampleName, PrimerSequence, LinkerSequence
sampleInfo <- read.delim("sampleInfo.txt")

# Initialize the project object
# This object tracks metadata and file paths
project <- readSampleInfo(sampleInfo)
```

### 2. Sequence Pre-processing
Before alignment, reads must be cleaned of technical sequences.

- **Primer/Linker Trimming**: Use `trimSequences()` to remove technical sequences based on bitwise alignment or exact matches.
- **Quality Filtering**: Use `filterReads()` to remove low-quality sequences.

```r
# Example of trimming primers
trimmedReads <- trimSequences(reads, primer = "ATCG...", side = "left")

# Finding specific features
matches <- findSequences(reads, feature = "T7-promoter")
```

### 3. Genomic Alignment and Processing
After trimming, reads are typically aligned (using external tools like BLAT or Bowtie2). `hiReadsProcessor` helps manage these results.

- **BLAT Integration**: Use `readBLAT()` to import PSL files.
- **Integration Site Identification**: The core functionality often involves finding the exact genomic coordinate where the viral/transposon sequence ends and the genomic sequence begins.

```r
# Process BLAT alignments
alignments <- readBLAT("alignments.psl")

# Annotate alignments with sample info
annotatedAlignments <- annotateAlignments(alignments, project)
```

### 4. Data Analysis and Visualization
- **Clustering**: Use `clusterSites()` to group nearby integration sites that likely represent the same insertion event.
- **Visualization**: Use `plotVenn()` or `plotPoints()` to visualize distribution and overlap between samples.

## Key Functions
- `readSampleInfo()`: Creates a metadata object for the sequencing run.
- `replicate_alignments()`: Handles replicates and consolidates hits.
- `get_integration_sites()`: Extracts genomic coordinates from processed alignments.
- `extract_sequences()`: Retrieves genomic sequences flanking the integration site.

## Tips for Success
- **Metadata is Critical**: Ensure your `sampleInfo` file accurately reflects the primers and linkers used for each barcode; the package relies heavily on this for automated trimming.
- **Parallelization**: Many functions support `mc.cores` for faster processing on multi-core systems.
- **Object Classes**: Familiarize yourself with the `SimpleList` and `GRanges` outputs, as the package integrates tightly with the `GenomicRanges` ecosystem.

## Reference documentation
- [hiReadsProcessor Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/hiReadsProcessor.html)