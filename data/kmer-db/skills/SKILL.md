---
name: kmer-db
description: kmer-db is a high-performance utility for indexing genomic or proteomic data and calculating similarity metrics between massive sets of k-mers. Use when user asks to build k-mer databases, perform all-to-all comparisons, or calculate Jaccard distances to estimate evolutionary relationships.
homepage: https://github.com/refresh-bio/kmer-db
---


# kmer-db

## Overview

kmer-db is a high-performance utility designed for processing massive sets of k-mers with minimal memory overhead. It excels at indexing genomic or proteomic data and calculating similarity metrics between samples. Use this skill to guide the construction of k-mer databases, perform all-to-all comparisons, or query individual sequences against a reference database to estimate evolutionary relationships via Jaccard distances.

## Core CLI Patterns

### 1. Building a Database
The `build` mode is the prerequisite for most analyses. It processes FASTA files into a compact database format.

*   **Standard Nucleotide Build**:
    `kmer-db build -k 18 -t 16 input_list.txt output.db`
*   **Protein/Amino Acid Build**:
    `kmer-db build -alphabet aa -k 10 input.fasta output.db`
*   **From Multi-sample FASTA**:
    Use `-multisample-fasta` if a single FASTA file contains multiple distinct samples (e.g., different genomes).
    `kmer-db build -multisample-fasta all_genomes.fasta output.db`

### 2. Comparing Sequences
Once a database is built, use these modes to find common k-mers.

*   **New vs. Database (`new2all`)**: Compare a set of new sequences against an existing database.
    `kmer-db new2all reference.db query_list.txt results.csv`
*   **Single vs. Database (`one2all`)**: Compare one specific FASTA against the database.
    `kmer-db one2all reference.db query.fasta results.csv`
*   **All-to-All (`all2all`)**: Compare every sample within a database against every other sample.
    `kmer-db all2all reference.db results.csv`

### 3. Calculating Distances
Transform the raw common k-mer counts into biological distance metrics.

*   **Jaccard Index**:
    `kmer-db distance jaccard results.csv distances.jaccard`

## Expert Tips and Best Practices

*   **Memory Optimization (MinHash)**: For extremely large datasets, use the `-f <fraction>` flag during `build` to accept only a fraction of k-mers (e.g., `-f 0.01` for 1%). This implements a MinHash-like sketch that significantly reduces database size while maintaining distance estimation accuracy.
*   **Sparse Computation**: When dealing with thousands of samples where most pairs share few k-mers, use `all2all-sp` or `all2all-parts` for sparse matrix computation to save time and disk space.
*   **Database Extension**: Use the `-extend` flag in `build` mode to add new samples to an existing `.db` file without rebuilding from scratch.
*   **Input Lists**: For large batches, create a text file containing paths to your FASTA files (one per line) and pass that as the input argument.
*   **Thread Management**: Always specify `-t` to match your available CPU cores, as kmer-db is highly parallelized.
*   **Alphabet Selection**: Beyond `nt` and `aa`, kmer-db supports reduced amino acid alphabets like `aa12_mmseqs` and `aa11_diamond` for sensitive protein searches.

## Reference documentation
- [kmer-db GitHub Repository](./references/github_com_refresh-bio_kmer-db.md)
- [kmer-db Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kmer-db_overview.md)