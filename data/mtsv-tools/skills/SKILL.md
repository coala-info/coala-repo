---
name: mtsv-tools
description: MTSv (Metagenomic Taxonomic Sequence viewer tools) is a high-performance suite designed for the taxonomic assignment of metagenomic sequencing reads.
homepage: https://github.com/FofanovLab/mtsv_tools
---

# mtsv-tools

## Overview

MTSv (Metagenomic Taxonomic Sequence viewer tools) is a high-performance suite designed for the taxonomic assignment of metagenomic sequencing reads. It utilizes a custom metagenomic index (MG-index) based on the FM-index data structure and performs full-alignment using a q-gram filter followed by SIMD-accelerated Smith-Waterman alignment. This skill assists in navigating the multi-step pipeline required to transform raw reference sequences into searchable indices and subsequently binning query reads against those indices.

## Reference Database Preparation

Before building indices, reference FASTA files must adhere to a strict header format to ensure the binner can map sequences to taxonomic identifiers.

- **Header Format**: `SEQID-TAXID`
- **Example**: A sequence with unique ID `12345` belonging to NCBI TaxID `987` must have the header `>12345-987`.
- **Requirement**: The TaxID must be an integer.

## Core Workflow and CLI Patterns

### 1. Chunking the Reference Database
Large reference databases should be split into smaller chunks to reduce memory overhead and enable parallel index generation.

```bash
mtsv-chunk --input /path/to/ref.fasta --output /path/to/chunks/ --gb 1.0
```
- **Expert Tip**: Use the `--gb` flag to set the chunk size based on your available RAM. MTSv indices typically require ~3.6x the RAM of the original FASTA size during the binning step.

### 2. Building the MG-Index
Each chunked FASTA file must be converted into an MG-index. This process generates the Suffix Array, BWT, and FM-index.

```bash
mtsv-build --fasta /path/to/chunk1.fasta --index /path/to/chunk1.index
```

**Performance Tuning:**
- `--sample-interval <INT>`: Controls BWT occurrence sampling (default: 64). Lower values speed up queries but increase index size.
- `--sa-sample <INT>`: Controls Suffix Array sampling (default: 32). Lower values reduce query time at the cost of memory.

### 3. Binning Reads
The `mtsv-binner` command assigns reads to the reference sequences. You must run the binner against each MG-index generated in the previous step.

**Key Parameters:**
- `--seed-size`: The size of the exact match substrings used for initial filtering.
- `--seed-interval`: The offset between seeds extracted from query sequences.
- `--min-hits`: Minimum number of seed hits required to trigger a full Smith-Waterman alignment for a candidate region.

### 4. Collapsing Results
After binning reads against multiple indices, use `mtsv-collapse` to aggregate the hits and finalize taxonomic assignments.

```bash
mtsv-collapse --input /path/to/binning_results/ --output /path/to/final_report/ --threads 8
```

## Best Practices
- **Parallelization**: Run `mtsv-binner` instances in parallel across different nodes or cores, each targeting a different index chunk, to significantly decrease total processing time.
- **Memory Management**: If you encounter out-of-memory errors during `mtsv-build` or `mtsv-binner`, increase the sampling intervals or decrease the chunk size in `mtsv-chunk`.
- **Logging**: Use the `-v` flag across all tools to trigger debug-level logging for troubleshooting complex alignment issues.

## Reference documentation
- [MTSv Tools GitHub Repository](./references/github_com_FofanovLab_mtsv_tools.md)
- [mtsv-tools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mtsv-tools_overview.md)