---
name: lambda-align2
description: Lambda is a high-performance local aligner designed for rapid protein-space searches and taxonomic analysis of massive biological datasets. Use when user asks to index a reference database, perform BLASTP or BLASTX searches, or conduct taxonomic binning using the lowest common ancestor algorithm.
homepage: http://seqan.github.io/lambda/
---


# lambda-align2

## Overview
Lambda is a high-performance local aligner designed for protein-space searches (BLASTP, BLASTX). It is optimized for "massive" data, offering significantly higher speeds than BLAST while maintaining compatibility. It is particularly effective when you have a large number of query sequences and need to perform taxonomic analysis or protein alignment on Linux-64 systems.

## Command Line Usage

The modern interface (v2.0+) uses a single `lambda2` executable with sub-commands.

### 1. Indexing the Database
Before searching, you must create an index of your reference database (e.g., NR, UniProt).

```bash
lambda2 mkindex -d database.fasta -i index_prefix
```
*   **Tip**: Indexing in version 0.9.1+ supports memory-mapped file access, allowing multiple instances to share the same memory on a single server.

### 2. Searching
Perform alignments by providing the query file and the index created in the previous step.

```bash
lambda2 search -q queries.fasta -i index_prefix -o output.m8
```

### 3. Taxonomic Analysis
Lambda supports advanced taxonomic features including ID retrieval and binning.
*   **LCA (Lowest Common Ancestor)**: Use this for taxonomic binning of matches.
*   **Taxonomic Annotation**: Ensure your index or search parameters include taxonomic mapping files if performing LCA or ID retrieval.

## Best Practices and Tips

*   **Memory Management**: Lambda estimates required memory before starting. Pay attention to early warnings to avoid crashes during long runs.
*   **Output Formats**: 
    *   Supports standard BLAST-like formats (e.g., `.m8`, `.m0`).
    *   Supports **SAM/BAM** formats for integration with downstream NGS pipelines.
    *   *Note*: In version 0.9.2+, the indexer truncates sequence IDs by default to save space. If you require full IDs in pairwise format (`.m0`), you must explicitly disable truncation.
*   **Performance**: 
    *   Pre-built binaries often include different optimization levels; the tool will automatically pick the fastest one supported by your CPU.
    *   If building from source, ensure optimizations are turned on (default in 0.9.1+).
*   **Updates**: The index format frequently changes between major versions (e.g., 1.0 to 2.0). Always re-create your index files when updating the Lambda software.

## Reference documentation
- [Lambda: the Local Aligner for Massive Biological DatA](./references/seqan_github_io_lambda.md)
- [Bioconda Lambda Package Overview](./references/anaconda_org_channels_bioconda_packages_lambda_overview.md)