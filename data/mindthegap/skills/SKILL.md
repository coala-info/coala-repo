---
name: mindthegap
description: MindTheGap detects and assembles genomic insertion variants or fills gaps between contigs using local de novo assembly of NGS data. Use when user asks to detect insertion breakpoints, assemble insertion sequences, or bridge gaps between genomic contigs.
homepage: https://github.com/GATB/mindthegap
---


# mindthegap

## Overview

MindTheGap is a specialized bioinformatics tool designed for the integrated detection and assembly of genomic insertion variants using Next-Generation Sequencing (NGS) data. Unlike general structural variant callers, it focuses on resolving the actual sequence of insertions by performing local de novo assembly. It also functions as an assembly finishing tool, capable of filling gaps between contigs without prior information regarding their relative order or orientation.

## Command Line Usage

The tool is executed via the `MindTheGap` binary using two primary modules: `find` and `fill`.

### Insertion Variant Calling Workflow

Perform insertion calling in two sequential steps:

1.  **Detect Breakpoints**: Use the `find` module to identify potential insertion sites.
    ```bash
    MindTheGap find -in reads_r1.fq,reads_r2.fq -ref reference.fa -out output_prefix
    ```
    *   **Inputs**: FASTQ reads (comma-separated for pairs) and a FASTA reference.
    *   **Outputs**: An `.h5` file (De Bruijn graph) and a `.breakpoints` file.

2.  **Assemble Insertions**: Use the `fill` module to resolve the sequences at the detected breakpoints.
    ```bash
    MindTheGap fill -graph output_prefix.h5 -bkpt output_prefix.breakpoints -out output_prefix
    ```
    *   **Inputs**: The graph and breakpoints generated in the previous step.
    *   **Outputs**: A `.insertions.vcf` file containing genotypes and a `.insertions.fasta` file with the assembled sequences.

### Genome Assembly Gap-Filling

To bridge gaps between existing contigs:
```bash
MindTheGap fill -in reads.fq.gz -contig contigs.fa -out gap_fill_output
```
*   **Mechanism**: It performs local assembly between all pairs of contig ends.
*   **Output**: Results are provided in GFA (Graphical Fragment Assembly) format.

## Best Practices and Expert Tips

-   **Graph Reuse**: Always use the `-graph` option in the `fill` module if you have already run the `find` module. This avoids the computationally expensive step of rebuilding the De Bruijn graph from raw reads.
-   **K-mer Abundance**: Adjust the `-abundance-min` parameter (default is often 2 or 3) to filter out sequencing errors. Increase this value for high-coverage datasets to improve assembly speed and reduce noise.
-   **Memory Management**: MindTheGap is highly memory-efficient (typically <6GB for human-sized datasets). If running on a cluster, ensure the temporary directory has sufficient space for the HDF5 graph construction.
-   **Input Flexibility**: The tool accepts compressed FASTQ files (`.gz`) directly, saving disk space and I/O time.
-   **Local Assembly Mode**: When using MindTheGap as a component of larger pipelines (like MinYS or MTG-link), focus on the `fill` module's ability to handle unanchored contigs.

## Reference documentation

- [MindTheGap GitHub Repository](./references/github_com_GATB_MindTheGap.md)