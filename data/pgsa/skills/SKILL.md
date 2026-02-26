---
name: pgsa
description: PgSA creates a compact, searchable index from high-throughput sequencing reads using a pseudogenome suffix array approach. Use when user asks to build a searchable index from reads, query the presence of k-mers, or perform efficient sequence searches within a read set.
homepage: http://sun.aei.polsl.pl/pgsa/
---


# pgsa

## Overview
PgSA (Pseudogenome Suffix Array) is a specialized bioinformatics tool designed to create a compact, searchable index from high-throughput sequencing reads. Unlike traditional suffix arrays that might be memory-intensive, PgSA leverages a "pseudogenome" approach to organize reads, making it possible to query the presence of arbitrary-length k-mers efficiently. This skill provides the necessary CLI patterns to build these indices and perform searches within them.

## Installation
The tool is available via Bioconda. It is recommended to use a dedicated environment:
```bash
conda install -c bioconda pgsa
```

## Core Workflows

### Building an Index
To create a pseudogenome suffix array from a set of reads (typically in FASTA or FASTQ format), use the primary build command.
*Note: Specific flags may vary by version; always check `pgsa --help` for the latest parameter requirements.*

```bash
# Basic index construction
pgsa build -i reads.fastq -o index_prefix
```

### Querying k-mers
Once the index is built, you can query it for specific sequences. PgSA is optimized for determining if a k-mer exists within the original read set.

```bash
# Querying the index for a specific k-mer
pgsa query -x index_prefix -q "ATGCATGC"
```

## Expert Tips
- **Memory Management**: PgSA is designed for compactness, but building indices for very large datasets (e.g., whole human genomes at high coverage) still requires significant RAM. Ensure your environment has sufficient overhead for the initial pseudogenome construction.
- **Input Formats**: While primarily used for sequencing reads, ensure your input files are clean of non-IUPAC characters to prevent indexing errors.
- **K-mer Length**: PgSA supports arbitrary-length k-mers, but performance is generally best when queries match the typical read length or biological features of interest (e.g., 21-31 mers).

## Reference documentation
- [PgSA GitHub Repository](./references/github_com_kowallus_PgSA.md)
- [Bioconda PgSA Overview](./references/anaconda_org_channels_bioconda_packages_pgsa_overview.md)