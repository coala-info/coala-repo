---
name: dream-stellar
description: DREAM-Stellar is a high-performance pairwise local aligner designed to find conserved regions between large genomic datasets. Use when user asks to build an index from reference sequences, search query sequences for local alignments, or identify conserved regions with a specific error tolerance.
homepage: https://github.com/seqan/dream-stellar
---


# dream-stellar

## Overview

DREAM-Stellar is a high-performance pairwise local aligner designed to compare large genomic datasets. It operates using a two-stage process: first, it constructs an index from reference sequences using an Interleaved Bloom Filter (IBF), and second, it searches query sequences against this index to find local alignments. This tool is ideal for researchers needing to find all conserved regions between two sets of sequences with a specific error tolerance.

## Installation

The recommended way to install DREAM-Stellar is via Bioconda:

```bash
conda install -c bioconda -c conda-forge dream-stellar
```

## Core Workflow

DREAM-Stellar requires a two-step process to complete an alignment task.

### 1. Building the Index
Before searching, you must create an index file (`.ibf`) from your reference FASTA files.

```bash
dream-stellar build <reference.fasta> --pattern <length> --output <index.ibf>
```

*   **--pattern**: Defines the length of the conserved subsequences you are looking for.
*   **--output**: The resulting index file used in the search step.

### 2. Searching for Alignments
Once the index is built, run the search against your query sequences.

```bash
dream-stellar search --index <index.ibf> --query <query.fasta> --error-rate <rate> --output <results.gff>
```

*   **--error-rate**: The maximum allowed error rate for the local alignments (e.g., 0.02 for 2%).
*   **--output**: Results are typically saved in GFF format.

## CLI Best Practices and Tips

### Parameter Tuning
*   **Error Rate**: The `--error-rate` parameter is critical for sensitivity. Lower rates increase speed but may miss more divergent sequences.
*   **Pattern Size**: The `--pattern` size in the build step should match the expected length of the conserved regions. Smaller patterns increase the index size and sensitivity but may slow down the search.

### Accessing Documentation
DREAM-Stellar provides granular help menus for each subcommand. Use these to discover advanced filtering or performance options:
*   General help: `dream-stellar --help`
*   Indexing options: `dream-stellar build --help`
*   Search parameters: `dream-stellar search --help`

### Performance
*   DREAM-Stellar is optimized for Linux environments (linux-64 and linux-aarch64).
*   Ensure your reference and query files are in standard FASTA format for compatibility.

## Reference documentation
- [GitHub Repository: seqan/dream-stellar](./references/github_com_seqan_dream-stellar.md)
- [Bioconda: dream-stellar Overview](./references/anaconda_org_channels_bioconda_packages_dream-stellar_overview.md)