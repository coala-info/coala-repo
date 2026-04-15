---
name: khmer
description: khmer provides memory-efficient tools for analyzing DNA shotgun sequencing data using probabilistic data structures. Use when user asks to perform digital normalization, filter reads by k-mer abundance, partition metagenomes, or interleave and extract paired-end reads.
homepage: https://khmer.readthedocs.io/
metadata:
  docker_image: "quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0"
---

# khmer

## Overview

The khmer software provides a suite of memory-efficient tools for analyzing DNA shotgun sequencing data. Its primary purpose is to manage the "volume" problem in bioinformatics by using probabilistic data structures (Bloom filters) to perform tasks like digital normalization and k-mer abundance filtering. By reducing the number of reads while preserving the underlying genomic information, khmer makes downstream assembly faster and less memory-intensive.

## Core CLI Workflows

### 1. Digital Normalization (DigiNorm)
Use this to reduce high-coverage datasets to a manageable median coverage (e.g., 20x), which discards redundant data without losing information from low-coverage regions.

*   **Normalize reads**:
    `normalize-by-median.py -k 20 -C 20 -N 4 -x 1e9 reads.fq`
    *   `-k`: K-mer size (default is often 20).
    *   `-C`: Desired median coverage.
    *   `-x`: Maximum hash table size (adjust based on available RAM).
    *   `-N`: Number of hash tables.

### 2. Abundance Filtering
Use this to remove reads containing low-abundance k-mers, which are typically the result of sequencing errors.

*   **Step A: Load k-mers into a counting table**:
    `load-into-counting.py -k 20 -x 1e9 -N 4 table.ct reads.fq.keep`
*   **Step B: Filter reads by abundance**:
    `filter-abund.py table.ct reads.fq.keep`

### 3. Partitioning Metagenomes
Use this to divide large, complex datasets into smaller, independent groups of reads (partitions) that can be assembled separately.

*   **Load and partition**:
    1. `load-into-hashbits.py -k 32 -x 1e9 graph.ht reads.fq.gz`
    2. `do-partition.py graph.ht reads.fq.gz`
    3. `extract-partitions.py reads.fq.gz`

## Paired-End Data Handling

khmer tools generally expect paired-end reads to be interleaved in a single file to ensure that pairs are kept together during normalization and filtering.

*   **Interleave R1 and R2**:
    `interleave-reads.py read1.fq read2.fq > interleaved.fq`
*   **Extract paired reads after processing**:
    `extract-paired-reads.py interleaved.fq.keep`

## Expert Tips and Best Practices

*   **Memory Estimation**: The `-x` parameter is critical. If you set it too low, the false positive rate of the Bloom filter increases, leading to over-aggressive filtering. Aim for a false positive rate below 1% (check the tool output for "FP rate").
*   **K-mer Size**: For most applications, a k-mer size of 20–32 is standard. Metagenomic partitioning often benefits from larger k-mers (e.g., 32).
*   **File Extensions**: khmer scripts often append suffixes to output files. For example, `normalize-by-median.py` produces `.keep` files, and `filter-abund.py` produces `.abundfilt` files.
*   **Paired-End Integrity**: Always use `extract-paired-reads.py` after normalization or filtering to separate "orphaned" reads (where one mate was discarded) from properly paired reads. This is essential for assemblers like Velvet or Trinity.



## Subcommands

| Command | Description |
|---------|-------------|
| filter-abund.py | Filter sequences based on abundance using a k-prime countgraph. |
| interleave-reads.py | Interleave left and right reads from paired-end sequencing files. |
| khmer_fastq-to-fasta.py | Convert FASTQ files to FASTA format. |
| khmer_partition-graph.py | Partition a k-mer graph (Compact De Bruijn Graph) into disconnected components. |

## Reference documentation

- [Pipelines](./references/github_com_dib-lab_khmer_wiki_Pipelines.md)
- [Scripts and what they eat](./references/github_com_dib-lab_khmer_wiki_Scripts-and-what-they-eat.md)
- [Conda Support](./references/github_com_dib-lab_khmer_wiki_Conda-Support.md)
- [User Scripts Guide](./references/khmer_readthedocs_io_en_latest_user_scripts.html.md)