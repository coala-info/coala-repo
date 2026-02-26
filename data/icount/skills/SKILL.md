---
name: icount
description: iCount is a Python-based framework for analyzing protein-RNA interactions by processing raw iCLIP data into cross-link sites and binding motifs. Use when user asks to demultiplex FASTQ files, identify single-nucleotide cross-link positions, call peaks, cluster significant sites, or generate RNAmaps for positional distribution analysis.
homepage: https://github.com/tomazc/iCount
---


# icount

## Overview

iCount is a dedicated Python-based framework designed for the high-resolution analysis of protein-RNA interactions. It manages the complex transition from raw FASTQ data to biologically meaningful cross-link sites. Use this skill to navigate the iCLIP pipeline, which includes demultiplexing, genomic mapping, identifying single-nucleotide cross-link positions, and performing downstream statistical clustering and positional distribution analysis (RNAmaps).

## Core CLI Workflow

The iCount pipeline typically follows a sequential progression. Ensure you have your genome fasta and GTF annotation files ready before starting.

### 1. Pre-processing and Demultiplexing
The first step separates reads based on experimental barcodes and removes adapter sequences.
- Use `icount demultiplex` to handle raw FASTQ files.
- You must provide a library description file (usually a tab-delimited file) specifying barcodes and sample names.

### 2. Genome Preparation and Mapping
iCount relies on the STAR aligner for mapping reads.
- Use `icount indexstar` to generate the necessary genome indices for alignment.
- Mapping is typically performed outside of iCount using STAR, or via integrated scripts that call STAR, to produce BAM files.

### 3. Identifying Cross-linked Sites
This is the core function of iCount, identifying the exact nucleotide where the protein was cross-linked to the RNA.
- Use `icount xlsites` to process BAM files and generate BED files containing cross-link sites.
- **Expert Tip**: Ensure your BAM files are sorted and indexed. The tool identifies the site immediately preceding the mapped read (the "minus one" position) as the cross-link site.

### 4. Peak Calling and Clustering
To distinguish biological signal from background noise, iCount identifies statistically significant sites.
- Use `icount peaks` to identify significant cross-link sites compared to a null model.
- Use `icount clusters` to group significant sites that are spatially close to each other, which often represent the actual protein binding footprint.

### 5. Genomic Segmentation
Before spatial analysis, the genome must be partitioned into functional categories (exons, introns, UTRs).
- Use `icount segment` to create a "segmentation" file from a GTF. This file is required for most downstream analysis commands.

### 6. Downstream Analysis
- **RNAmaps**: Use `icount rnamap` to visualize the distribution of cross-links relative to genomic landmarks (e.g., splice sites, start/stop codons).
- **Kmer Enrichment**: Use `icount kmer` to find enriched sequences around cross-link sites, helping identify the binding motif of the protein.

## Best Practices
- **File Formats**: iCount heavily utilizes BED files for intermediate steps. Always keep your `.bed` and `.bam` files organized by replicate.
- **Replicates**: Use the grouping functions to combine replicates only after individual quality control.
- **Memory Management**: Commands like `indexstar` and `xlsites` can be memory-intensive; ensure your environment has sufficient RAM for the target genome size.

## Reference documentation
- [iCount GitHub Repository](./references/github_com_tomazc_iCount.md)
- [iCount Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_icount_overview.md)