---
name: bigsi
description: BIGSI (BItsliced Genomic Signature Index) is a specialized tool for the efficient storage and querying of k-mers across massive genomic datasets.
homepage: https://github.com/Phelimb/BIGSI
---

# bigsi

## Overview

BIGSI (BItsliced Genomic Signature Index) is a specialized tool for the efficient storage and querying of k-mers across massive genomic datasets. It transforms raw sequencing data into bit-sliced Bloom filters, allowing for near-instantaneous searching of sequences across thousands of experiments. Use this skill to build genomic indices, perform high-throughput bulk searches, and manage the memory-intensive process of indexing large-scale WGS collections.

## Installation and Setup

Install BIGSI via Bioconda:

```bash
conda install -c bioconda bigsi
```

## Core CLI Patterns

### Building an Index
Create a new index from a collection of samples. For large datasets, it is preferred to provide a list of files.

*   **Build from file**: Use the "from file" parameter to specify a list of input Bloom filters or sequence files rather than passing them all as individual arguments.
*   **Sample Naming**: Ensure unique sample names are used; recent versions use `sample_name` instead of `sample_id`.

### Searching the Index
Query the index to find which samples contain a specific sequence or k-mer.

*   **Standard Search**: Query a single sequence against the index.
*   **Bulk Search**: Use `bulk_search` for querying multiple sequences simultaneously.
*   **Streaming**: When performing bulk searches, enable the streaming option to process results without storing the entire result set in memory.
*   **Variant Search**: Use `variant_search` specifically when looking for genomic variants across the indexed samples.

## Expert Tips and Best Practices

### Memory Management
*   **RAM Requirements**: Ensure the system has at least 8 times the memory of the Bloom filter size in bytes to avoid `OverflowError` or indexing failures.
*   **Multiprocessing**: BIGSI supports multiprocessing for building Bloom filters. However, if the number of jobs is set to 1 or less, it will default to single-threaded execution to save overhead.
*   **BerkeleyDB Interface**: For backend operations, BIGSI utilizes the `db.DB()` interface. Ensure your environment supports BerkeleyDB if not using the default storage engines.

### Search Optimization
*   **Thresholding**: Adjust the search threshold (e.g., 100% match vs. partial match) to optimize for speed or sensitivity depending on the biological question.
*   **Output Format**: Set the output format to text for easier parsing in downstream shell pipelines.

### Troubleshooting Common Issues
*   **File Format Mismatch**: If using Docker, ensure input `.txt` files are correctly formatted and accessible within the container volume to avoid `ValueError`.
*   **Exact Search**: Be aware that in some older versions, exact search might incorrectly return the first sample name; verify results with a known positive control.

## Reference documentation

- [BIGSI Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bigsi_overview.md)
- [BIGSI GitHub Repository](./references/github_com_Phelimb_BIGSI.md)
- [BIGSI Commit History](./references/github_com_Phelimb_BIGSI_commits_master.md)
- [BIGSI Known Issues](./references/github_com_Phelimb_BIGSI_issues.md)