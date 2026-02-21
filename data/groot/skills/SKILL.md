---
name: groot
description: GROOT (Graphing Resistance Out Of meTagenomes) is a bioinformatics tool specifically designed for "resistome profiling"—the identification and quantification of antibiotic resistance genes within a metagenomic sample.
homepage: https://github.com/will-rowe/groot
---

# groot

## Overview

GROOT (Graphing Resistance Out Of meTagenomes) is a bioinformatics tool specifically designed for "resistome profiling"—the identification and quantification of antibiotic resistance genes within a metagenomic sample. It distinguishes itself by using variation graphs to represent gene sets rather than simple linear sequences. This approach, combined with Locality Sensitive Hashing (LSH), allows for fast and accurate classification of reads even when they contain significant variation. The tool is ideal for researchers needing to reconstruct full-length ARG sequences from short-read metagenomic data.

## Core Workflow

The standard GROOT workflow consists of three primary stages: database acquisition, indexing, and alignment/reporting.

### 1. Database Acquisition
Use the `get` subcommand to download pre-clustered ARG databases.
```bash
groot get -d arg-annot
```

### 2. Indexing
The `index` command creates the variation graphs and the LSH index.
```bash
groot index -m arg-annot.90 -i grootIndex -w 100
```
*   **-m**: The clustered database directory.
*   **-i**: The name for the output index directory.
*   **-w**: The window size.

### 3. Alignment and Reporting
Align your metagenomic reads to the index and pipe the output directly into the report generator.
```bash
groot align -i grootIndex -f reads.fq | groot report
```
*   **-i**: The index directory created in the previous step.
*   **-f**: The input FASTQ file (supports multiple files).

## Expert Tips and Best Practices

### Window Size Optimization
The most critical parameter for accuracy is the window size (`-w`) during the indexing phase. 
*   **Rule of Thumb**: Set the window size to be approximately equal to your maximum expected read length (e.g., for 100bp reads, use `-w 100`).
*   If your reads are significantly shorter than the window size, seeding may fail.

### Handling Output Formats
*   **BAM Files**: `groot align` produces alignments in BAM format. These contain the graph traversals possible for each query read.
*   **GFA Files**: Since version 0.4, GROOT outputs variation graphs in GFA format. These can be loaded into visualization tools like **Bandage** to inspect which variants of an ARG are dominant in your sample.

### Performance Considerations
*   GROOT uses an LSH Ensemble library for containment search, which is highly efficient for read seeding.
*   If you are working with very large metagenomes, ensure you have sufficient RAM for the LSH index, though the tool is optimized for modern dev environments.

### Version Compatibility
If you are upgrading from a version prior to 1.0.0, note that the CLI has changed significantly due to a partial re-write of the indexing scheme. Always verify your command flags using `groot --help`.

## Reference documentation
- [groot - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_groot_overview.md)
- [GitHub - will-rowe/groot: A resistome profiler for Graphing Resistance Out Of meTagenomes](./references/github_com_will-rowe_groot.md)