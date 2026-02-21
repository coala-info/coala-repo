---
name: lambda-align
description: The `lambda-align` skill provides procedural knowledge for using the Local Aligner for Massive Biological DatA.
homepage: http://seqan.github.io/lambda/
---

# lambda-align

## Overview
The `lambda-align` skill provides procedural knowledge for using the Local Aligner for Massive Biological DatA. It is specifically designed for high-throughput protein sequence searches. Unlike general-purpose aligners, Lambda is optimized for speed in protein space and supports advanced features like taxonomic LCA (Lowest Common Ancestor) binning and memory-mapped database access for multi-instance efficiency.

## Core Workflows

### 1. Database Indexing
Before searching, a database must be indexed. Modern versions (2.0+) use a unified executable.

```bash
# Create an index from a protein FASTA file
lambda2 mkindex -d database.fasta -p index_prefix
```
*   **Optimization**: Indexing in version 0.9.1+ uses memory-mapped files, allowing multiple search instances to share the same memory space.
*   **ID Truncation**: By default, the indexer truncates sequence IDs to save space. If using pairwise format (`.m0`), ensure this behavior is acceptable or adjust parameters if full IDs are required.

### 2. Sequence Search
Perform local alignment of query sequences against the generated index.

```bash
# Basic search
lambda2 search -i index_prefix -q queries.fasta -o output.m8
```
*   **Speed**: Lambda is significantly faster than BLAST while maintaining compatibility.
*   **Memory Management**: The tool estimates required memory before execution; pay attention to early warnings to avoid mid-run crashes.

### 3. Taxonomic Analysis
Lambda supports taxonomic annotation and binning during the search phase.

*   **LCA Binning**: Computes the lowest common ancestor for all matches of each query sequence.
*   **Retrieval**: Can retrieve and annotate taxonomic IDs directly.

## Output Formats
Lambda supports several standard bioinformatics formats:
*   **BLAST Tabular (-m 8)**: Default compatible output.
*   **SAM/BAM**: Supported since version 0.9.2 for integration with downstream mapping pipelines.
*   **Pairwise (-m 0)**: Traditional alignment view.

## Expert Tips
*   **Binary Selection**: Pre-built packages often include multiple binaries optimized for different CPU instruction sets. The system typically auto-picks the fastest one.
*   **Version Compatibility**: Note that index formats are generally not backward compatible between major versions (e.g., 1.0 indexes will not work with 2.0).
*   **Multi-threading**: Lambda is designed for massive data; always utilize available cores to maximize the performance gap over BLAST.

## Reference documentation
- [Lambda Overview](./references/anaconda_org_channels_bioconda_packages_lambda_overview.md)
- [Lambda Project Home](./references/seqan_github_io_lambda.md)