---
name: short-read-connector
description: Short Read Connector is a resource-frugal tool designed for the rapid comparison of large sequencing datasets using k-mer indexing. Use when user asks to compare metagenomic datasets, identify shared sequences between samples, or filter reads based on k-mer presence in a reference bank.
homepage: https://github.com/GATB/short_read_connector
---


# short-read-connector

## Overview
Short Read Connector (SRC) is a resource-frugal tool designed for the rapid comparison of large sequencing datasets. It operates in two primary modes: **Counter**, which provides quantitative data on how many times k-mers from a query set appear in a reference bank, and **Linker**, which identifies specific read-to-read relationships based on shared k-mer content. This tool is particularly useful for metagenomic comparisons, identifying common sequences between samples, or filtering reads based on presence/absence in a reference dataset.

## Core Workflow
The tool follows a two-step process: indexing a "Bank" (B) and then querying a "Query" set (Q) against that index.

### 1. Indexing the Bank
Before querying, you must create a probabilistic index of the reference read set.
```bash
# For Counter mode
sh short_read_connector_counter.sh index -b bank_reads.fasta.gz -i bank_index.dumped

# For Linker mode
sh short_read_connector_linker.sh index -b bank_reads.fasta.gz -i bank_index.dumped
```
**Key Indexing Options:**
- `-k <int>`: K-mer length (Default: 31, Maximum: 31).
- `-a <int>`: Minimum k-mer abundance. K-mers appearing fewer than this many times in the bank are ignored (Default: 2).
- `-f <int>`: Fingerprint size. Increasing this reduces false positives but increases memory usage (Default: 12).

### 2. Querying the Index
Queries require a "File of Files" (FOF) containing the paths to the query read sets.
```bash
# Create the FOF
ls query_reads.fastq.gz > query_list.fof

# Run the query
sh short_read_connector_counter.sh query -i bank_index.dumped -q query_list.fof
```
**Key Query Options:**
- `-w <int>`: Window size. If set to 0 (default), the full read is considered.
- `-s <int>`: K-mer threshold. The minimal percentage of shared k-mer span required to report a match.
- `-t <int>`: Number of threads (Default: 0, uses all available).
- `-p <string>`: Output file prefix (Default: "short_read_connector_res").

## Expert Tips and Best Practices
- **Memory Efficiency**: SRC uses a Minimal Perfect Hash Function (MPHF). If you encounter memory issues during indexing, ensure you aren't indexing unique k-mers (singletons) by keeping `-a` at 2 or higher.
- **Input Formats**: The tool supports FASTA and FASTQ formats, including gzipped files.
- **Low Complexity Regions**: By default, low complexity regions are filtered. Use the `-l` flag in both indexing and querying if your analysis requires keeping these regions (e.g., repetitive elements).
- **Understanding the Counter Output**:
  - The output includes `mean`, `median`, `min`, and `max` occurrences of the query read's k-mers in the bank.
  - `percentage_shared_positions` refers to the best window within the read. A value of 100% means every base in that window is covered by at least one k-mer found in the bank.
- **Linker vs. Counter**: Use **Counter** when you need statistics on k-mer frequency (e.g., digital normalization or abundance estimation). Use **Linker** when you need to extract the actual reads from the bank that overlap with your query.

## Reference documentation
- [Short Read Connector GitHub Repository](./references/github_com_GATB_short_read_connector.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_short-read-connector_overview.md)