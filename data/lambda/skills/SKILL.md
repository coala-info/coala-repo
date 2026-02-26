---
name: lambda
description: Lambda is a high-speed sequence alignment tool designed for searching large biological datasets with BLAST-like sensitivity. Use when user asks to index sequence databases, perform local alignments, conduct taxonomic classification, or manage memory-efficient parallel searches.
homepage: http://seqan.github.io/lambda/
---


# lambda

## Overview
Lambda (Local Aligner for Massive Biological DatA) is a specialized sequence alignment tool designed to bridge the gap between the sensitivity of BLAST and the speed required for modern "big data" genomics. It excels in protein-space searches and is optimized for workflows where millions of query sequences must be aligned against large databases. Beyond simple alignment, Lambda provides integrated features for taxonomic classification and efficient memory management for multi-instance processing on shared servers.

## Installation
The recommended way to install Lambda is via Bioconda:
```bash
conda install -c bioconda lambda
```

## Core CLI Usage
Starting with version 2.0.0, Lambda uses a single executable `lambda2` with sub-commands.

### 1. Database Indexing
Before searching, you must create an index of your subject sequences.
```bash
lambda2 index -d subject_sequences.fasta -p index_prefix
```
*   **Tip**: Indexing in newer versions is significantly faster and more memory-efficient.
*   **Note**: Indexes are version-specific; if you upgrade Lambda, you may need to re-create your index files.

### 2. Sequence Search
Perform local alignment of queries against the created index.
```bash
lambda2 search -q queries.fasta -d index_prefix -o output.m8
```
*   **Compatibility**: Lambda supports BLAST-style output formats (e.g., .m0, .m8).

### 3. Working with SAM/BAM
Lambda natively supports SAM and BAM formats for integration into standard bioinformatics pipelines.
```bash
# Example for SAM output
lambda2 search -q queries.fasta -d index_prefix -o output.sam
```

## Advanced Features and Best Practices

### Taxonomic Analysis
Lambda can perform taxonomic binning using the Lowest Common Ancestor (LCA) algorithm.
*   Use this when you need to annotate queries with taxonomic IDs or perform metagenomic classification.
*   Ensure your database is properly annotated with taxonomic information during the indexing phase.

### Memory Management
*   **Memory Mapping**: Lambda supports memory-mapped file access. This allows multiple instances of Lambda running on the same server to share the same database in memory, drastically reducing the total RAM footprint for parallel jobs.
*   **Memory Checks**: The tool includes a pre-run check that estimates required memory against available system RAM to prevent crashes during long-running alignments.

### Performance Optimization
*   **Binary Selection**: Pre-built packages often include multiple binaries optimized for different CPU instruction sets. The `lambda2` wrapper typically selects the fastest version compatible with your hardware automatically.
*   **Query Length**: Version 1.9.3+ includes specific optimizations for short sequences.

## Reference documentation
- [Anaconda Bioconda Lambda Overview](./references/anaconda_org_channels_bioconda_packages_lambda_overview.md)
- [SeqAn Lambda Homepage](./references/seqan_github_io_lambda.md)