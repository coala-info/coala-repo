---
name: cobs
description: COBS is a specialized indexing tool designed for rapid search across massive collections of genomic data.
homepage: https://panthema.net/cobs
---

# cobs

## Overview
COBS is a specialized indexing tool designed for rapid search across massive collections of genomic data. It utilizes a compact bit-sliced signature index to determine if specific k-mers or q-grams exist within a dataset. This skill provides the necessary CLI patterns to build indices from FASTA/FASTQ files and query them efficiently, making it ideal for metagenomics and large-scale sequence comparison where traditional BLAST-like tools are too slow or memory-intensive.

## Installation
The recommended way to install COBS is via Bioconda:
```bash
conda install -c bioconda cobs
```

## Core Workflows

### 1. Index Construction
To search data, you must first construct an index. COBS supports two main index types: `classic` and `compact`.

**Classic Index:**
Best for datasets with similar document sizes.
```bash
cobs index --threads 8 --kmer-size 31 --false-positive 0.01 --input-path ./data_folder --index-file my_index.cobs_classic
```

**Compact Index:**
Best for datasets with varying document sizes to save space.
```bash
cobs index --threads 8 --kmer-size 31 --compact --input-path ./data_folder --index-file my_index.cobs_compact
```

### 2. Querying the Index
Once the index is built, you can query it for specific sequences.

**CLI Query:**
```bash
cobs query --index-file my_index.cobs_compact --threshold 0.8 "GATTACA..."
```
*   `--threshold`: The fraction of k-mers in the query that must match a document for it to be reported.

### 3. Index Maintenance
You can combine multiple indices or check the metadata of an existing index.

**Check Index Info:**
```bash
cobs info my_index.cobs_compact
```

## Best Practices
- **K-mer Selection**: For most genomic applications, a k-mer size of 31 is standard. Smaller k-mers increase sensitivity but also increase false positive rates and index size.
- **Memory Management**: During construction, COBS can be memory-intensive. Use the `--threads` flag to match your CPU cores, but monitor RAM usage as bit-slicing requires significant workspace.
- **False Positive Rate**: The default is often 0.01 (1%). If you are performing very sensitive searches, consider lowering this (e.g., 0.001), though it will result in a larger index file.
- **Input Preparation**: Ensure your input directory contains clean FASTA/FASTQ files. COBS treats each file in the input directory as a separate "document" in the index.

## Reference documentation
- [COBS Overview](./references/anaconda_org_channels_bioconda_packages_cobs_overview.md)
- [COBS Project Page](./references/panthema_net_cobs.md)