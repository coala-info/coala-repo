---
name: cdbfasta
description: "cdbfasta creates high-performance indices for FASTA files to enable rapid retrieval of genomic records. Use when user asks to index FASTA files, retrieve specific sequences by accession, perform batch record extraction, or extract sub-sequences from large genomic databases."
homepage: https://github.com/gpertea/cdbfasta
---


# cdbfasta

## Overview
The `cdbfasta` suite provides a high-performance, file-based hashing mechanism to create indices for FASTA files. By pairing the indexer (`cdbfasta`) with the query tool (`cdbyank`), you can instantly pull specific records or sub-sequences from gigabyte-scale genomic databases. The tool is particularly useful for bioinformaticians who need to manage large sequence sets where loading the entire file into memory is impractical.

## Core Workflows

### 1. Indexing a FASTA File
The basic command creates an index file with a `.cidx` extension.
```bash
cdbfasta <fasta_file>
```
*   **Default Behavior**: The key for each record is the first space-delimited token after the `>` character.
*   **Multiple Keys**: Use `-m` to index every space-delimited token in the definition line as a separate key pointing to the same record.
*   **Shortcut Keys**: For complex accessions (e.g., `db|accession|other`), use `-c` to index only the first `db|accession` pair, or `-C` to index both the shortcut and the full string.

### 2. Retrieving Records
Use `cdbyank` to query the index created by `cdbfasta`.
```bash
# Retrieve a single record by accession
cdbyank -a 'AccessionID' <index_file.cidx>

# Batch retrieval from a list of accessions
cat accessions.txt | cdbyank <index_file.cidx> > output.fasta
```
*   **Database Location**: `cdbyank` assumes the FASTA file is in the same directory as the index (with the `.cidx` suffix removed). If the database has been moved, use `-d <path_to_fasta>`.
*   **Non-Unique Keys**: If your database contains multiple records with the same key, use `-x` to retrieve all of them; otherwise, only the first match is returned.

### 3. Advanced Retrieval Options
*   **Defline Only**: Use `-F` to retrieve only the definition line of the records.
*   **Sequence Ranges**: Use `-R` to extract specific sub-sequences. The input format should be `key start_coord end_coord` (1-based indexing).
    ```bash
    echo "chr1 100 500" | cdbyank -R <index_file.cidx>
    ```

## Database Inspection
You can query the index file itself for metadata without needing the original FASTA file:
*   **Record Count**: `cdbyank -n <index_file.cidx>` returns the total number of indexed records.
*   **List All Keys**: `cdbyank -l <index_file.cidx>` prints every key stored in the index.
*   **Index Summary**: `cdbyank -s <index_file.cidx>` provides details on how the index was built (e.g., if `-m` or `-c` flags were used).

## Expert Tips
*   **Architecture Independence**: Index files are portable across different Unix platforms (32-bit/64-bit, big-endian/little-endian) and Windows.
*   **Compression**: If the tool was compiled with zlib support, it can handle compressed data records to save disk space.
*   **Exit Status**: When using `cdbyank -a`, the tool returns a shell exit status of `0` on success and `1` if the key is not found, making it useful for automated scripts.

## Reference documentation
- [CDB (Constant DataBase) indexing and retrieval tools for FASTA files](./references/github_com_gpertea_cdbfasta.md)