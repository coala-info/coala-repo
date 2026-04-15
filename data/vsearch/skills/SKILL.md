---
name: vsearch
description: VSEARCH is a high-performance tool for processing large-scale metagenomic and microbiome data, performing tasks like sequence alignment, filtering, dereplication, chimera removal, and clustering. Use when user asks to search sequences, align sequences, dereplicate sequences, detect chimeras, remove chimeras, cluster sequences, filter sequences by quality, or merge paired-end reads.
homepage: https://github.com/torognes/vsearch
metadata:
  docker_image: "quay.io/biocontainers/vsearch:2.30.4--hd6d6fdc_0"
---

# vsearch

## Overview

VSEARCH is a high-performance, vectorized tool designed for processing large-scale metagenomic and microbiome data. It serves as a drop-in replacement for many USEARCH functions, offering improved accuracy through optimal global alignment (Needleman-Wunsch) rather than heuristic approaches. Use this skill to implement workflows for sequence quality filtering, dereplication, chimera removal, and OTU/ASV clustering.

## Core CLI Patterns

### Global Alignment and Searching
To search query sequences against a database with a specific identity threshold:
```bash
vsearch --usearch_global queries.fsa --db database.fsa --id 0.9 --alnout results.txt
```
*   `--id`: Floating point value (0.0 to 1.0) representing the identity threshold.
*   `--alnout`: Produces a human-readable alignment output.

### Dereplication
Remove redundant sequences to reduce computational load in downstream steps. VSEARCH supports full-length and prefix dereplication:
```bash
vsearch --derep_fulllength input.fasta --output unique.fasta --sizeout --relabel ID_
```
*   `--sizeout`: Adds abundance information to the header (e.g., `;size=10;`).
*   `--relabel`: Renames sequences using a prefix.

### Chimera Detection
VSEARCH provides both *de novo* and reference-based chimera detection.

**De novo detection (requires abundance information):**
```bash
vsearch --uchime_denovo input.fasta --nonchimeras clean.fasta --chimeras detected_chimeras.fasta
```

**Reference-based detection:**
```bash
vsearch --uchime_ref input.fasta --db gold_standard.fasta --nonchimeras clean.fasta
```

### Clustering
Perform greedy clustering to group sequences into Operational Taxonomic Units (OTUs).

**Abundance-based greedy clustering (AGC):**
```bash
vsearch --cluster_size input.fasta --id 0.97 --centroids otus.fasta
```

**Distance-based greedy clustering (DGC):**
```bash
vsearch --cluster_fast input.fasta --id 0.97 --centroids otus.fasta
```

### FASTQ Processing
Merge paired-end reads and filter by quality:
```bash
vsearch --fastq_mergepairs forward.fastq --reverse reverse.fastq --fastqout merged.fastq
vsearch --fastq_filter merged.fastq --fastq_maxee 1.0 --fastaout filtered.fasta
```
*   `--fastq_maxee`: Maximum expected errors allowed for a read to pass the filter.

## Expert Tips

*   **Memory Management**: VSEARCH is a 64-bit application designed to handle very large databases exceeding 4GB of RAM. It automatically utilizes SIMD vectorization and multiple threads.
*   **Sorting**: Before clustering, always sort sequences by abundance (`--sortbysize`) or length (`--sortbylength`) to ensure deterministic and high-quality cluster centroids.
*   **Compressed Files**: VSEARCH can directly read `.gz` and `.bz2` files if the system libraries are present, avoiding the need for manual decompression.
*   **Masking**: Use `--mask_lowers` to ignore low-complexity regions during alignment if your sequences contain repetitive elements.

## Reference documentation

- [VSEARCH GitHub Repository](./references/github_com_torognes_vsearch.md)
- [VSEARCH Wiki and Documentation](./references/github_com_torognes_vsearch_wiki.md)
- [Bioconda VSEARCH Overview](./references/anaconda_org_channels_bioconda_packages_vsearch_overview.md)