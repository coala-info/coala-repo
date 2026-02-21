---
name: centrifuge
description: Centrifuge is a highly efficient taxonomic classification system designed for metagenomics.
homepage: https://github.com/DaehwanKimLab/centrifuge
---

# centrifuge

## Overview
Centrifuge is a highly efficient taxonomic classification system designed for metagenomics. It utilizes a specialized indexing scheme based on the Burrows-Wheeler Transform (BWT) and the Ferragina-Manzini (FM) index to provide high-speed classification with a significantly smaller memory footprint than k-mer based classifiers. This skill provides the necessary command-line patterns for building indices, classifying reads, and generating human-readable taxonomic reports.

## Installation
The most reliable way to install Centrifuge is via Bioconda:
```bash
conda install -c bioconda centrifuge
```

## Core Workflows

### 1. Index Generation
Before classification, you must build or download an index. Centrifuge provides a utility to download NCBI genomes and taxonomy.

**Download and Build (Standard Bacterial/Viral):**
```bash
# Download taxonomy and bacterial/viral genomes
centrifuge-download -o taxonomy taxonomy
centrifuge-download -o library -domain bacteria,viral refseq > seqid2taxid.map

# Combine and build the index
cat library/*/*.fna > all_sequences.fna
centrifuge-build -p 4 --conversion-table seqid2taxid.map \
                 --taxonomy-tree taxonomy/nodes.dmp \
                 --name-table taxonomy/names.dmp \
                 all_sequences.fna abv_index
```

### 2. Sequence Classification
Classify paired-end or single-end reads against a pre-built index.

**Paired-end classification:**
```bash
centrifuge -x /path/to/index_prefix -1 reads_1.fq -2 reads_2.fq -S classification_results.tsv
```

**Single-end classification with performance tuning:**
```bash
centrifuge -p 8 -x index_prefix -U reads.fq -S classification_results.tsv --report-file summary.txt
```

### 3. Reporting and Visualization
The raw output (`-S`) is a tab-delimited file. Use `centrifuge-kreport` to generate a Kraken-style report for downstream tools like Pavian.

```bash
centrifuge-kreport -x index_prefix classification_results.tsv > centrifuge_report.kreport
```

## Expert Tips and Best Practices
- **Memory Management**: Use the `--mm` flag during classification to use memory-mapped I/O. This allows multiple Centrifuge instances to share the same index in memory, which is critical for high-throughput environments.
- **Sensitivity vs. Speed**: Adjust the `-k` parameter (default is 5). Increasing `-k` can report more assignments per read but will increase output file size and processing time.
- **Compressed Indices**: For very large databases (like NCBI nt), use the `centrifuge-compress.pl` script provided in the source to compress genomes at the species level, significantly reducing index size without major loss in classification accuracy.
- **Successor Tool**: For users requiring even higher memory efficiency or single-cell data support, consider the successor tool **Centrifuger**.

## Reference documentation
- [Centrifuge GitHub Repository](./references/github_com_DaehwanKimLab_centrifuge.md)
- [Bioconda Centrifuge Overview](./references/anaconda_org_channels_bioconda_packages_centrifuge_overview.md)