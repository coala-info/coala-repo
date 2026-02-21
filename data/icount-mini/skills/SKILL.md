---
name: icount-mini
description: icount-mini is a specialized computational pipeline designed for protein-RNA interaction analytics.
homepage: https://github.com/ulelab/iCount-Mini
---

# icount-mini

## Overview

icount-mini is a specialized computational pipeline designed for protein-RNA interaction analytics. It is a fork of the original iCount project, specifically optimized for peak calling features and updated terminology. This skill assists in executing the full iCLIP analysis workflow—from raw FASTQ demultiplexing and BAM mapping to the identification of statistically significant cross-linked sites and the generation of metagene positional distribution plots.

## Core Workflow: Peak Calling

To successfully call peaks in icount-mini, you must follow a specific three-step sequence. Skipping the segmentation or significance testing steps will result in incomplete or inaccurate data.

1.  **Segment the Genome**: Prepare your genomic regions based on a GTF file.
    `iCount-Mini segment <gtf_file> <fai_file> <output_gtf>`
2.  **Identify Significant Crosslinks**: Calculate statistically significant cross-linked sites from your mapped data.
    `iCount-Mini sigxls <input_bed> <segmentation_file> <output_bed>`
3.  **Merge into Peaks**: Group significant crosslinks into broader peak regions (clusters).
    `iCount-Mini peaks <sigxls_bed> <output_bed>`

## Terminology Mapping

icount-mini uses updated terminology to align with current bioinformatics standards. When transitioning from the original iCount or reading older documentation, use this map:

| iCount (Original) | icount-mini |
| :--- | :--- |
| peaks | **sigxls** (Significant crosslinks) |
| clusters | **peaks** (Merged regions) |
| RNA-maps | **metagene** |

## Command-Line Usage Patterns

### Data Preparation
*   **Demultiplexing**: Use for initial processing of raw FASTQ files.
    `iCount-Mini demultiplex <fastq_file> <adapter_sequence> <barcodes_file>`
*   **Cross-link Identification**: Extract cross-link sites from BAM files into BED format.
    `iCount-Mini xlsites <input_bam> <output_bed>`

### Analysis and Visualization
*   **Metagene Generation**: Create plots showing the positional distribution of cross-linked sites relative to genomic landmarks (e.g., start codons, introns).
    `iCount-Mini metagene <crosslinks_bed> <segmentation_file> <output_pdf>`
*   **Kmer Enrichment**: Analyze the enrichment of specific sequences around cross-linked sites.
    `iCount-Mini kmers <crosslinks_bed> <genome_fasta> <output_file>`

## Expert Tips

*   **Virtual Environments**: Always install icount-mini within a dedicated Python virtual environment or a specific Conda environment to avoid dependency conflicts with libraries like Matplotlib.
*   **GTF Consistency**: Ensure the GTF file used in the `segment` command matches the genome version used for mapping your BAM files.
*   **Replicate Grouping**: Use the grouping features to combine individual replicates before running metagene or kmer analysis to increase statistical power.

## Reference documentation
- [iCount-Mini GitHub Repository](./references/github_com_ulelab_iCount-Mini.md)
- [Bioconda icount-mini Overview](./references/anaconda_org_channels_bioconda_packages_icount-mini_overview.md)