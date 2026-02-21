---
name: biox
description: BioX is a specialized utility designed to handle the high-redundancy nature of biological data.
homepage: https://github.com/TianMayCry9/BioX
---

# biox

## Overview
BioX is a specialized utility designed to handle the high-redundancy nature of biological data. It provides a dual-purpose workflow: significantly reducing the storage footprint of genomic files and performing alignment-free sequence analysis. It is particularly effective for large-scale datasets like plant genomes and supports multi-threaded processing to accelerate both compression and distance-based calculations.

## Core CLI Patterns

### Compression and Decompression
BioX requires a mode flag (`-c`, `-d`, or `-a`) and an input path.

*   **Standard Compression**:
    `biox -c -t dna -i input.fasta -o output.biox`
*   **High-Efficiency Compression (Level 9)**:
    `biox -c -t protein -l 9 -i sequences.fasta`
*   **Parallel Processing**:
    Use `--num_processes` to speed up operations on multi-core systems:
    `biox -c -t rna --num_processes 8 -i large_transcriptome.fastq`
*   **Decompression**:
    `biox -d -t dna -i data.biox -o restored.fasta`

### Sequence Analysis and Phylogeny
Analysis mode (`-a`) typically operates on directories containing multiple sequence files to compute pairwise relationships.

*   **Distance Calculation**:
    Compute distances using Normalized Compression Distance (NCD):
    `biox -a -i ./sequence_dir/ --method ncd`
*   **Phylogenetic Tree Construction**:
    Generate a tree using specific clustering methods (single, average, weighted, or complete):
    `biox -a -i ./samples/ --tree average`
*   **Taxonomic Classification**:
    Classify sequences using KNN based on NCBI taxonomy levels:
    `biox -a -i ./query_dir/ -k 3 --tax family --confidence 0.95`

## Expert Tips and Best Practices

*   **Plant Genomes**: Always use the `-p` or `--plant` flag when working with plant genomic data. This triggers a specialized compression scheme optimized for the specific repeat structures found in plant DNA.
*   **FASTQ Quality Scores**: By default, BioX ignores the "+" line in FASTQ files to maximize compression. If you must preserve the exact original format including these lines, use `-ps compress`.
*   **Memory Management**: For extremely large files, combine the plant genome parameter (`-p`) with a moderate compression level (default is 3 or 5) to prevent excessive memory consumption.
*   **Distance Methods**: 
    *   `ncd`: Best for general purpose biological sequence similarity.
    *   `lzjd`: Often faster for very large datasets.
    *   `bcd`: Alternative compression-based metric for specific structural comparisons.
*   **Parallel Jobs**: In analysis mode, use `-j` to specify parallel jobs for distance matrix calculations, which is distinct from the `--num_processes` used in compression.

## Reference documentation
- [BioX GitHub Repository](./references/github_com_TianMayCry9_BioX.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_biox_overview.md)