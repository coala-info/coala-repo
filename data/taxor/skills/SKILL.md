---
name: taxor
description: Taxor performs taxonomic classification and profiling of long-read sequencing data using a memory-efficient Hierarchical Interleaved XOR Filter index. Use when user asks to build a taxonomic index, search DNA sequences against a database, or generate abundance reports using an EM algorithm.
homepage: https://github.com/JensUweUlrich/Taxor
---


# taxor

## Overview

Taxor is a high-performance bioinformatics tool designed for the taxonomic classification of long-read sequencing data. It utilizes a Hierarchical Interleaved XOR Filter (HIXF) index to store k-mers or syncmers, providing a significantly smaller memory footprint compared to traditional k-mer-based classifiers. The tool is optimized for precision, incorporating an Expectation-Maximization (EM) algorithm to resolve multi-matching reads and applying genome size correction for accurate taxonomic and sequence abundance reporting.

## Installation

The recommended method for installing Taxor is via Bioconda:

```bash
conda install bioconda::taxor
```

## Core Workflows

### 1. Building an Index (taxor build)

The `build` command creates the HIXF index required for searching. It requires a tab-separated (TSV) file containing metadata and a directory containing the corresponding FASTA files.

**The Input TSV Format:**
The file must contain six tab-separated columns:
1. Assembly accession (e.g., GCF_000002495.2)
2. NCBI Taxonomy ID
3. FTP path (used to match the FASTA file stem)
4. Organism name
5. Taxonomy string (k__;p__;...)
6. Taxonomy ID string (semicolon-separated IDs)

**Command Pattern:**
```bash
taxor build --input-file metadata.tsv --input-sequence-dir ./genomes --output-filename database.hixf --threads 8
```

**Optimization Tips:**
- **Syncmers:** Use `--use-syncmer` to significantly reduce the index size.
- **Parameter Constraints:** When using syncmers, both `--kmer-size` and `--syncmer-size` must be **even-numbered**.
- **K-mer Size:** Default is 20 (max 30). Syncmer size must be smaller than k-mer size (max 26).

### 2. Searching Sequences (taxor search)

The `search` command queries DNA sequences against the pre-built HIXF index.

**Command Pattern:**
```bash
taxor search --index database.hixf --input-file query_reads.fastq --output-file search_results.txt
```

### 3. Taxonomic Profiling (taxor profile)

The `profile` command processes search results to generate abundance reports. It uses an EM algorithm to reassign reads that match multiple taxa.

**Command Pattern:**
```bash
taxor profile --search-file search_results.txt --index database.hixf --output-prefix sample_report
```

**Key Parameters:**
- `--em-step`: Adjusts the iterations for the EM algorithm (found in version 0.2.0+).
- `--threshold`: Sets a minimum abundance threshold for reporting.

## Expert Tips and Best Practices

- **Memory Efficiency:** If working with limited RAM, always enable syncmers (`--use-syncmer`). This downsampling scheme maintains high sensitivity for long reads while drastically lowering the memory required to load the index.
- **File Naming:** Ensure the file stem of your FASTA files in the `--input-sequence-dir` matches the last part of the FTP path provided in column 3 of your metadata TSV.
- **Thread Scaling:** Taxor scales well with threads during the `build` process. Use the `--threads` parameter to speed up the construction of large databases (e.g., RefSeq).
- **NCBI Integration:** Taxor is designed to work seamlessly with NCBI taxonomy. Ensure your taxonomy strings and IDs are formatted correctly in the input TSV to ensure the `profile` step generates valid reports.

## Reference documentation
- [Taxor Overview](./references/anaconda_org_channels_bioconda_packages_taxor_overview.md)
- [Taxor GitHub Documentation](./references/github_com_JensUweUlrich_Taxor.md)