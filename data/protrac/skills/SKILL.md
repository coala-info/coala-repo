---
name: protrac
description: protrac (probabilistic tracking) is a specialized bioinformatics tool designed to identify piRNA clusters within genomic sequences.
homepage: http://www.smallrnagroup.uni-mainz.de/software.html
---

# protrac

## Overview
protrac (probabilistic tracking) is a specialized bioinformatics tool designed to identify piRNA clusters within genomic sequences. Unlike simple density-based methods, it uses a probabilistic approach to distinguish true piRNA clusters from other small RNA-rich regions (like rRNA or tRNA degradation products). It is particularly effective for researchers working on germline small RNA silencing and transposon control.

## Usage Guidelines

### Core Workflow
The primary execution of protrac typically involves providing mapped sequence data (often in SAM or a specific map format) and a reference genome.

1.  **Input Preparation**: Ensure your small RNA reads are mapped to the reference genome. protrac often requires a specific input format or SAM files.
2.  **Cluster Identification**: Run the main algorithm to scan the genome for regions showing significant piRNA signatures.
3.  **Filtering**: Use the tool's built-in scoring system to filter out clusters that do not meet specific biological criteria (e.g., minimum read count, strand asymmetry, or presence of the "Ping-Pong" signature).

### Key Parameters and Best Practices
*   **Strand Bias**: piRNA clusters are often characterized by a strong bias toward one genomic strand. Adjust the polarity threshold to fine-tune sensitivity.
*   **1U and 10A Motifs**: protrac can analyze the sequence composition of reads. Look for the enrichment of Uracil at the first position (1U) or Adenine at the tenth position (10A) as hallmarks of primary and secondary piRNAs.
*   **Normalization**: When comparing multiple samples, ensure read counts are normalized (e.g., reads per million) before interpreting cluster magnitude.
*   **Species Specificity**: While protrac is versatile, ensure your reference genome and any repeat masks used are appropriate for the species being studied (e.g., *Drosophila*, mouse, or human).

### Common CLI Patterns
While specific flags vary by version, the general execution pattern follows:
`protrac -i <input_map_file> -g <genome_fasta> -o <output_directory> [options]`

*   Use `-p` to set the p-value threshold for cluster significance.
*   Use `-s` to define the minimum size (in bp) for a region to be considered a cluster.
*   Use `-m` to filter by the minimum number of unique read sequences required per cluster.

## Reference documentation
- [protrac Overview](./references/anaconda_org_channels_bioconda_packages_protrac_overview.md)