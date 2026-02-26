---
name: trawler
description: Trawler identifies over-represented DNA sequence motifs and calculates their enrichment. Use when user asks to find DNA sequence motifs, analyze ChIP-seq data, calculate motif enrichment, cluster motifs, or compare motifs to databases.
homepage: https://trawler.erc.monash.edu.au/help.html
---


# trawler

## Overview
Trawler is a specialized bioinformatics tool designed to find over-represented DNA sequences (motifs) within a set of genomic coordinates. It is particularly effective for analyzing ChIP-seq data. The tool works by comparing a "sample" set of sequences against a "background" set to calculate enrichment scores (Z-scores) and then clusters these motifs to identify representative consensus sequences.

## Usage Guidelines

### Input Formats
*   **BED Format**: Preferred for genomic regions. Ensure the file is tab-separated with three columns: `chromosome`, `start`, and `end`. Chromosome names must match UCSC nomenclature (e.g., `chr1`).
*   **FASTA Format**: Use when working with specific sequences or organisms not supported by the built-in library. All sequences should be repeat-masked (using 'N').

### Organism Selection
When using BED input, you must specify the correct genome assembly. Supported accessions include:
*   **Human**: hg19
*   **Mouse**: mm9, mm10
*   **Rat**: rn5
*   **Zebrafish**: danRer7
*   **Fruit fly**: dm3
*   **Yeast**: sacCer3
*   **Arabidopsis**: TAIR10

### Background Dataset Requirements
*   **Ratio**: The background dataset must contain at least 5 times more regions than the sample dataset.
*   **Size**: Background regions should generally be larger than sample regions to ensure statistical robustness.
*   **Reproducibility**: BED inputs trigger random background generation. For 100% reproducible results, provide a fixed background file in FASTA format.

### Parameter Optimization
*   **Motif Length**: Restricted to 6–20 bp.
*   **Occurrence**: Defines the minimum number of times a motif must appear. While the limit is 2, a value of 10–20 is recommended for high-confidence results.
*   **Wildcards**: Set the maximum number of degenerate nucleotides allowed within a motif to balance sensitivity and specificity.
*   **Clustering**: 
    *   Set `number of clusters` to 0 to use SCC (Strongly Connected Components) clustering (default).
    *   Set a specific integer to use k-means clustering.

### Interpreting Results
*   **Z-score**: Motifs are ranked by decreasing Z-score; higher scores indicate stronger enrichment.
*   **Conservation**: Use the "average conservation score" (PhastCons) to prioritize motifs that are evolutionarily maintained.
*   **Database Comparison**: Trawler automatically compares discovered motifs against JASPAR and UniPROBE. Ensure the `motif database` parameter matches your target clade (e.g., vertebrates, insects, or plants).

## Reference documentation
- [Trawler Help and Usage Guide](./references/trawler_erc_monash_edu_au_help.html.md)
- [Bioconda Trawler Package Overview](./references/anaconda_org_channels_bioconda_packages_trawler_overview.md)