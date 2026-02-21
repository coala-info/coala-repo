---
name: markermag
description: MarkerMAG is a specialized bioinformatics tool used to bridge the gap between fragmented metagenomic assemblies and taxonomic identification.
homepage: https://pypi.org/project/MarkerMAG/
---

# markermag

## Overview
MarkerMAG is a specialized bioinformatics tool used to bridge the gap between fragmented metagenomic assemblies and taxonomic identification. While standard binning often fails to include the 16S rRNA gene due to assembly complexities, MarkerMAG utilizes paired-end read information and assembly graphs to accurately link these marker genes back to their source MAGs.

## Usage Guidelines

### Core Workflow
The tool typically operates in a multi-step process involving the alignment of reads to both MAGs and 16S sequences to establish connectivity.

1.  **Input Preparation**: Ensure you have your MAGs (in FASTA format), the original metagenomic reads (FASTQ), and identified 16S rRNA sequences.
2.  **Linkage Discovery**: Use the tool to identify read pairs where one mate maps to a MAG and the other maps to a 16S sequence.
3.  **Validation**: Review the consistency of links, especially when multiple 16S genes are associated with a single bin.

### Common CLI Patterns
While specific subcommands vary by version, the general execution follows this structure:

*   **Standard Execution**:
    `markermag -read1 <forward_reads.fq> -read2 <reverse_reads.fq> -mag <mag_folder> -16s <16s_fasta> -out <output_dir>`
*   **Resource Management**: Use the `-t` or `--threads` flag to speed up the alignment phases, as this is the most computationally expensive part of the process.

### Best Practices
*   **Read Quality**: Use trimmed and filtered reads to reduce false-positive links caused by sequencing artifacts.
*   **Assembly Graphs**: If available, providing the assembly graph (GFA) can significantly improve the confidence of the links.
*   **Redundancy**: Be aware that highly conserved regions of the 16S gene can lead to ambiguous mapping; always check the "linkage score" or "count" provided in the output tables.

## Reference documentation
- [MarkerMAG PyPI Project Page](./references/pypi_org_project_MarkerMAG.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_markermag_overview.md)