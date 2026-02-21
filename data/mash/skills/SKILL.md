---
name: mash
description: Mash is a high-performance bioinformatics tool designed for the rapid comparison of large genomic and metagenomic datasets.
homepage: https://github.com/marbl/Mash
---

# mash

## Overview
Mash is a high-performance bioinformatics tool designed for the rapid comparison of large genomic and metagenomic datasets. By utilizing the MinHash algorithm, Mash reduces sequences into small, representative "sketches." This allows for the estimation of Jaccard distances and Mash distances (which correlates with Mutation Rate) without the need for computationally expensive sequence alignments. It is particularly effective for clustering thousands of genomes, identifying unknown isolates, and searching metagenomic reads against massive reference databases.

## Core CLI Patterns

### Sketching Sequences
Before comparing sequences, they must be converted into sketch files (`.msh`).

*   **Basic sketch**: Create a sketch of a genome with default parameters (k=21, s=1000).
    ```bash
    mash sketch genome.fasta
    ```
*   **Sketching individual sequences**: Use the `-i` flag when providing a multi-FASTA file to create a separate sketch for every sequence (e.g., every contig or every chromosome) within the file.
    ```bash
    mash sketch -i multi_genome.fasta
    ```
*   **Adjusting resolution**: Increase the sketch size (`-s`) for higher accuracy when comparing very similar genomes, or adjust k-mer size (`-k`).
    ```bash
    mash sketch -s 10000 -k 31 genome.fasta
    ```

### Estimating Distances
Compare sketches or raw sequences to calculate distances.

*   **Compare two sketches**:
    ```bash
    mash dist reference.msh query.msh
    ```
*   **Compare a sketch against a FASTA**: Mash will sketch the FASTA on the fly.
    ```bash
    mash dist reference.msh query.fasta
    ```
*   **All-vs-all distance matrix**: Use `triangle` to produce a lower-triangular distance matrix suitable for clustering tools.
    ```bash
    mash triangle genomes_directory/*.msh > distance_matrix.txt
    ```

### Metagenomic Screening
Identify which reference genomes are present in a metagenomic sample.

*   **Screening reads**: Screen a set of sequencing reads against a reference sketch (e.g., RefSeq).
    ```bash
    mash screen reference_database.msh sequences.fastq
    ```
*   **Taxonomic reporting**: Use `taxscreen` (available in newer versions) to generate taxonomic reports based on screening results.

## Expert Tips and Best Practices

*   **K-mer Selection**: The default k-mer size of 21 is generally sufficient for bacterial genomes. For highly divergent sequences, consider reducing `k`. For very large or complex genomes, increasing `k` reduces the probability of chance k-mer matches.
*   **Handling Multiplicity**: When sketching raw sequencing reads, use the `-m` flag to ignore unique k-mers that are likely sequencing errors.
    ```bash
    mash sketch -m 2 reads.fastq
    ```
*   **P-value Interpretation**: `mash dist` provides a p-value. A low p-value indicates that the observed Jaccard distance is unlikely to have occurred by chance given the sketch size and k-mer size.
*   **Memory Mapping**: Mash uses memory mapping for large sketch files. If you encounter "too many mapped files" errors on high-core systems, ensure your system's `max_map_count` is sufficient.
*   **Output Formatting**: For `mash triangle`, use the `-E` flag if you require an edge-list output (ID1, ID2, distance, p-value, matches) instead of a matrix.

## Reference documentation
- [Mash Overview](./references/anaconda_org_channels_bioconda_packages_mash_overview.md)
- [Mash GitHub Repository](./references/github_com_marbl_Mash.md)
- [Mash Issues and Command Usage](./references/github_com_marbl_Mash_issues.md)
- [Mash Commit History (Feature Updates)](./references/github_com_marbl_Mash_commits_master.md)