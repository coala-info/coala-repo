---
name: short-read-connector
description: Short Read Connector compares large sets of sequencing reads by indexing k-mers to identify overlaps without full sequence alignment. Use when user asks to count k-mer frequencies between datasets, link reads sharing significant k-mer overlaps, or filter reads based on a reference bank.
homepage: https://github.com/GATB/short_read_connector
---


# short-read-connector

## Overview
Short Read Connector (SRC) is a high-performance bioinformatics tool designed to compare large sets of sequencing reads without the overhead of full sequence alignment. It operates by indexing a "Bank" (B) dataset and then processing a "Query" (Q) dataset against that index. The tool provides two primary functionalities: counting k-mer frequencies and linking reads that share significant k-mer overlaps. This is particularly useful for dataset cross-referencing, read filtering, and identifying common sequences across different sequencing runs.

## Core Workflows

### 1. K-mer Counting (short_read_connector_counter)
Use this mode to determine how many k-mers from each query read are present in the reference bank.

**Step 1: Index the Bank**
```bash
sh short_read_connector_counter.sh index -b bank_reads.fasta.gz -i bank_index.dumped -k 31 -a 2
```
*   `-b`: Input bank file (FASTA/FASTQ, supports .gz).
*   `-i`: Name of the index file to create.
*   `-k`: K-mer length (default 31, max 32).
*   `-a`: Minimum k-mer abundance in bank to be indexed (default 2).

**Step 2: Query the Index**
```bash
# Create a 'file of files' (fof) for the query
ls query_reads.fasta.gz > query_list.fof

sh short_read_connector_counter.sh query -i bank_index.dumped -q query_list.fof
```
*   `-q`: A text file containing paths to query read files (one per line).
*   Output: `short_read_connector_res.txt` containing k-mer counts per read.

### 2. Read Linking (short_read_connector_linker)
Use this mode to find specific reads in the bank that share k-mers with the query reads.

**Step 1: Index the Bank**
```bash
sh short_read_connector_linker.sh index -b bank_reads.fasta.gz -i linker_index.dumped
```

**Step 2: Query the Index**
```bash
sh short_read_connector_linker.sh query -i linker_index.dumped -q query_list.fof -s 50
```
*   `-s`: Similarity threshold. Minimal percentage of shared k-mers required to link reads.

## Expert Tips and Best Practices

*   **Input Handling**: The query command (`query`) requires a "File of Files" (fof). Even if you have only one query file, you must list its path in a text file and pass that text file to the `-q` parameter.
*   **Performance**: Use the `-t` flag during both indexing and querying to specify the number of threads. Setting `-t 0` (default) will utilize all available cores.
*   **Memory Efficiency**: If dealing with highly repetitive or low-complexity data, the `-l` flag can be used during indexing to keep low-complexity regions, though this increases index size.
*   **K-mer Selection**: The default k-mer size is 31. If you need a different size, ensure it is set during the indexing phase; the query phase must match the index's k-mer size.
*   **Abundance Filtering**: Use the `-a` parameter to filter out sequencing errors in the bank. Setting `-a 2` or higher ensures that only k-mers appearing multiple times in the bank are indexed, significantly reducing noise and memory usage.



## Subcommands

| Command | Description |
|---------|-------------|
| short_read_connector_counter.sh | Compare reads from two read sets (distinct or not) |
| short_read_connector_linker.sh | Compare reads from two read sets (distinct or not) |

## Reference documentation
- [Short Read Connector README](./references/github_com_GATB_short_read_connector_blob_master_README.md)
- [Counter Script Documentation](./references/github_com_GATB_short_read_connector_blob_master_short_read_connector_counter.sh.md)
- [Linker Script Documentation](./references/github_com_GATB_short_read_connector_blob_master_short_read_connector_linker.sh.md)