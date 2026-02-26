---
name: uvaia
description: Uvaia performs efficient pairwise sequence alignment and similarity searching for large genomic datasets. Use when user asks to 'align sequences to a reference' or 'search for similar sequences in a database'.
homepage: https://github.com/quadram-institute-bioscience/uvaia
---


# uvaia

## Overview

Uvaia is a specialized bioinformatics suite designed for efficient pairwise alignment and sequence similarity searching. It leverages the Wavefront Alignment (WFA) library to provide high-performance results, making it particularly suitable for processing massive genomic datasets like those generated during SARS-CoV-2 surveillance. The toolset consists of two primary utilities: `uvaialign` for generating alignments against a reference and `uvaia` for querying those alignments against a database to find nearest neighbors based on score distances.

## Command Line Usage

### Sequence Alignment with uvaialign
Use `uvaialign` to align query sequences against a single reference genome.

```bash
# Basic alignment (output to stdout)
uvaialign --ref reference.fasta queries.fasta > aligned_queries.fasta

# Alignment with multi-threading
uvaialign --ref reference.fasta --nthreads 8 queries.fasta > aligned_queries.fasta

# Alignment with sequence trimming
uvaialign --ref reference.fasta --trim queries.fasta > aligned_queries.fasta
```

### Database Searching with uvaia
Use `uvaia` to search for the closest neighbors of aligned query sequences within an aligned database. **Note**: Both the query and the database must have been aligned to the same reference sequence (using `uvaialign`, `mafft`, or `viralMSA`) before running this command.

```bash
# Search queries against an aligned database
uvaia --db aligned_database.fasta --query aligned_queries.fasta > search_results.tsv
```

## Best Practices and Expert Tips

- **Thread Management**: In version 2.0.1 and later, always use the long-form option `--nthreads` for parallel processing. The short-form `-t` is deprecated or may conflict with other options like `--trim`.
- **Compression Support**: Uvaia natively supports XZ compressed files. For massive datasets, use `.fasta.xz` formats to save disk space without needing to manually decompress before running the tools.
- **Consistency is Key**: When using the `uvaia` search tool, the search is based on score distances. If your query and database were aligned using different parameters or different reference sequences, the distance metrics will be invalid.
- **Large Datasets**: Uvaia was specifically optimized to replace slower tools (like `civet`) for SARS-CoV-2 analysis. It is the preferred choice when dealing with hundreds of thousands of viral genomes where standard MSA (Multiple Sequence Alignment) tools fail due to memory or time constraints.
- **Output Handling**: `uvaialign` outputs the alignment directly to `stdout`. Always redirect this to a file or pipe it into another process to avoid flooding the terminal.

## Reference documentation
- [uvaia GitHub Repository](./references/github_com_quadram-institute-bioscience_uvaia.md)
- [uvaia Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_uvaia_overview.md)