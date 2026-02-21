---
name: colorid_bv
description: `colorid_bv` is a high-performance tool utilizing a BIGSI (Bloom Filter Index) implementation to facilitate metagenomic analysis and quality control.
homepage: https://github.com/hcdenbakker/colorid_bv
---

# colorid_bv

## Overview

`colorid_bv` is a high-performance tool utilizing a BIGSI (Bloom Filter Index) implementation to facilitate metagenomic analysis and quality control. It allows users to index large volumes of genomic data—either reference sequences or raw reads—into a searchable structure. Once indexed, users can rapidly query the data to determine k-mer similarity, detect the presence of specific genes in unassembled data, or classify reads using a majority-rule algorithm. It is particularly effective for screening thousands of datasets for specific markers without the computational overhead of full assembly.

## Core Workflows

### 1. Building a BIGSI Index
To search sequences, you must first create an index from your reference material or raw data.

*   **Prepare a reference file**: Create a tab-delimited text file where each line contains an identifier and the path to the corresponding sequence file.
    ```bash
    # Example reference file (refs.txt)
    sample1    /path/to/sample1.fastq.gz
    sample2    /path/to/sample2.fastq.gz
    ```
*   **Execute the build**:
    ```bash
    colorid_bv build -r refs.txt -b my_index_name -k 31 -s 50000000 -n 4 -c 4
    ```
    *   `-k`: K-mer size (default 31).
    *   `-s`: Bloom filter size (adjust based on sample complexity).
    *   `-n`: Number of hash functions.
    *   `-t`: Number of threads for parallel building.

### 2. Searching the Index
Search for k-mer similarity between a query and the indexed references.

*   **Standard Search**:
    ```bash
    colorid_bv search -b my_index_name -q query.fastq.gz -r query_reverse.fastq.gz
    ```
*   **Gene Detection (Gene Search)**: Use the `-g` flag to report the proportion of k-mers from a query (e.g., a specific gene sequence) matching entries in the index.
    ```bash
    colorid_bv search -b my_index_name -q gene_of_interest.fasta -g
    ```
*   **Perfect Match Search**: Use `-s` for a fast "perfect match" algorithm.

### 3. Read Classification and Filtering
Classify individual reads to identify taxa or filter specific sequences from a dataset.

*   **Identify Reads**:
    ```bash
    colorid_bv read_id --bigsi my_index_name --prefix output_prefix --query reads.fastq.gz
    ```
*   **Filter Reads**: Use the output from `read_id` with the `read_filter` subcommand to extract or remove specific taxa.

## Expert Tips and Best Practices

*   **Parameter Tuning**: For complex metagenomic samples, increase the Bloom filter size (`-s`) to reduce the false positive rate.
*   **Gene Search Optimization**: When searching for small genes in large datasets, a smaller k-mer size (e.g., `-k 21`) is often more sensitive than the default 31.
*   **Memory Management**: Use the `-H` (high memory load) flag during `read_id` for faster processing if your system has RAM at least 2x the size of the index.
*   **Batch Processing**: For large numbers of samples, use `batch_id` to classify multiple files in a single run.
*   **Index Inspection**: Use the `info` subcommand to dump index parameters and accessions if you forget the settings used during the build.

## Reference documentation
- [colorid_bv GitHub Repository](./references/github_com_hcdenbakker_colorid_bv.md)
- [colorid_bv Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_colorid_bv_overview.md)