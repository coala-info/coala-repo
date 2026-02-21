---
name: cirtap
description: cirtap is a specialized CLI utility designed to handle the large-scale acquisition and organization of PATRIC genomic data.
homepage: https://github.com/MGXlab/cirtap/
---

# cirtap

## Overview

cirtap is a specialized CLI utility designed to handle the large-scale acquisition and organization of PATRIC genomic data. It automates the process of maintaining a local mirror of the PATRIC FTP repository and provides tools to parse, index, and filter these datasets. By using cirtap, you can avoid the instability of web APIs when dealing with thousands of genomes, instead working with a structured local database that supports parallelized sequence extraction and quality-based genome selection.

## Installation and Setup

Install cirtap via bioconda or pip:

```bash
conda install bioconda::cirtap
# OR
pip install cirtap
```

## Core Workflows

### 1. Mirroring the PATRIC FTP
The `mirror` command is the entry point for all other functionality. It creates a local copy of the FTP data.

*   **Start a new mirror**: Use the `-j` flag to specify parallel download threads.
    ```bash
    cirtap mirror -j 8 /path/to/local_db
    ```
*   **Resume a failed job**: Use the `-r` flag to pick up where a previous mirror attempt stopped.
    ```bash
    cirtap mirror -j 8 -r /path/to/local_db
    ```
*   **Notifications**: Set up email alerts for long-running mirror jobs.
    ```bash
    cirtap mirror -j 8 --notify user@example.com /path/to/local_db
    ```

### 2. Indexing Local Data
Before running analysis or collection commands, you must generate a presence/absence index of the files in your mirror.

```bash
cirtap index -j 16 /path/to/genomes index.tsv
```

### 3. Collecting Sequence Sets
Extract specific sequence types across all genomes in your index into a single compressed FASTA file.

*   **Collect all proteins**:
    ```bash
    cirtap collect -t proteins -j 4 -i index.tsv /path/to/genomes all_proteins.fa.gz
    ```
*   **Collect 16S SSU sequences**:
    ```bash
    cirtap collect -t SSU -j 4 -i index.tsv /path/to/genomes SSU.fa.gz
    ```

### 4. Selecting High-Quality Genomes
Use the `best` command to filter genomes based on completeness and consistency statistics retrieved from the genome summary.

```bash
cirtap best -i index.tsv -d /path/to/local/patric output_best_genomes.txt
```

### 5. Archiving Specific Genomes
Create a gzipped tar archive from a specific list of PATRIC genome IDs.

```bash
cirtap pack -i genome_ids.txt -d /path/to/local/patric archive.tar.gz
```

## Best Practices

*   **Parallelization**: Always utilize the `-j` flag. For mirroring, 8-16 threads are usually optimal depending on your network; for indexing and collection, you can scale higher based on available CPU cores.
*   **Index Maintenance**: Re-run the `index` command whenever you update your mirror to ensure the `index.tsv` reflects the current state of the local filesystem.
*   **Storage**: Ensure the destination path for `mirror` has significant disk space, as the PATRIC FTP contains a massive volume of genomic data and annotations.

## Reference documentation
- [cirtap GitHub README](./references/github_com_MGXlab_cirtap.md)
- [cirtap Wiki](./references/github_com_MGXlab_cirtap_wiki.md)