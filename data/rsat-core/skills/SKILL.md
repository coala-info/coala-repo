---
name: rsat-core
description: The `rsat-core` skill provides a specialized interface for the Regulatory Sequence Analysis Tools (RSAT) suite.
homepage: http://rsat.eu/
---

# rsat-core

## Overview
The `rsat-core` skill provides a specialized interface for the Regulatory Sequence Analysis Tools (RSAT) suite. It enables the identification and characterization of cis-regulatory elements within genomic sequences. This skill is essential for workflows requiring high-throughput motif discovery (e.g., from ChIP-seq data), matrix-based pattern matching, and the comparison or clustering of DNA motifs across different organisms or datasets.

## Core CLI Patterns

### Sequence Retrieval and Manipulation
*   **retrieve-seq**: Use to fetch promoter sequences or specific genomic regions. Always specify the organism and the relative boundaries (e.g., `-from -1000 -to 0` for promoters).
*   **purge-seq**: Essential preprocessing step to mask repeats or redundant sequences before motif discovery to reduce false positives.
*   **convert-seq**: Use to translate between formats like FASTA, IG, and GCG.

### Motif Discovery
*   **oligo-analysis**: Best for finding over-represented k-mers (words). Use `-l 6` or `-l 7` for standard hexanucleotide/heptanucleotide searches.
*   **dyad-analysis**: Specifically designed for prokaryotic regulators that bind as dimers; it searches for spaced pairs of short words.
*   **peak-motifs**: The primary workflow for NGS data (ChIP-seq). It automatically chains sequence retrieval, discovery (using multiple algorithms), and motif comparison.

### Pattern Matching and Matrix Tools
*   **matrix-scan**: The standard tool for scanning sequences with PSSMs. 
    *   Use `quick` mode for large-scale genomic scans.
    *   Use `full` mode when detailed p-value calculations and site coordinates are required.
*   **convert-matrix**: Use to transform motifs between TRANSFAC, JASPAR, and MEME formats.
*   **matrix-clustering**: Use to reduce redundancy in discovered motifs by grouping similar PSSMs into trees and consensus motifs.

### Comparative Genomics
*   **footprint-discovery**: Use to identify conserved motifs in the promoters of orthologous genes across related species (phylogenetic footprinting).

## Expert Tips
*   **Background Models**: Always define an appropriate background model (Markov order 1 or 2) using `create-background` based on the specific organism's genome composition to ensure accurate p-value estimation.
*   **Thresholding**: When using `matrix-scan`, prefer using a p-value threshold (e.g., `-p-value 1e-4`) rather than a raw weight score to maintain consistency across different matrices.
*   **Integration**: Pipe commands together to create efficient workflows (e.g., `retrieve-seq | oligo-analysis`).

## Reference documentation
- [RSAT Overview](./references/anaconda_org_channels_bioconda_packages_rsat-core_overview.md)
- [RSAT Plant Specificity and Tools](./references/rsat_eead_csic_es_plants.md)