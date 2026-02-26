---
name: kmindex
description: "kmindex builds and queries k-mer indices from large-scale genomic datasets to identify sequence overlaps across multiple samples. Use when user asks to build a searchable k-mer index from genomic files, query sequences against an indexed databank, or calculate k-mer overlap between a query and multiple sequencing samples."
homepage: https://github.com/tlemane/kmindex
---


# kmindex

## Overview

kmindex is a specialized bioinformatics tool designed for the efficient indexing and querying of sequencing samples. Built on top of kmtricks, it enables users to build searchable indices from multiple genomic datasets and subsequently calculate the k-mer overlap between a query sequence and the indexed samples. It is particularly effective for large-scale comparative genomics, sample identification, and determining the presence of specific sequences across vast databanks.

## Installation

The tool is available via Bioconda:
```bash
conda install bioconda::kmindex
```

## Core Workflows

### 1. Building an Index
To index a databank, you must provide a File of Files (fof) containing the paths to your genomic datasets.

```bash
kmindex build --fof samples.txt --run-dir ./work_dir --index ./output_index --register-as MyDataset --hard-min 2 --kmer-size 25 --nb-cell 1000000
```

**Key Parameters:**
- `--fof`: Path to a text file listing input genomic files (one per line).
- `--run-dir`: Temporary directory for the indexing process.
- `--index`: The destination path for the generated index.
- `--register-as`: A label for the dataset within the index.
- `--hard-min`: Minimum k-mer abundance to be included in the index.
- `--kmer-size`: The length of k-mers to index (e.g., 25 or 31).
- `--nb-cell`: The number of cells in the underlying Bloom filter; should be scaled based on the expected number of unique k-mers.

### 2. Querying an Index
Once an index is built, you can query it using FASTA or FASTQ files.

```bash
kmindex query --index ./output_index --fastx query.fasta --zvalue 3
```

**Key Parameters:**
- `--index`: Path to the previously built kmindex directory.
- `--fastx`: Path to the query file (FASTA/FASTQ).
- `--zvalue`: Used by the findere algorithm to reduce false positives. It queries (k+z)-mers instead of k-mers. Increasing this value improves precision but may impact sensitivity.

## Best Practices and Tips

- **Memory Management**: The `--nb-cell` parameter directly impacts memory usage and the False Positive Rate (FPR). Ensure this value is sufficiently large for complex metagenomes or large eukaryotic genomes.
- **Findere Optimization**: Use the `--zvalue` parameter to leverage the findere algorithm. A small z-value (e.g., 1-3) significantly reduces false positive k-mer matches without the overhead of larger k-mer sizes.
- **Input Preparation**: When using `--fof`, ensure paths are absolute or correctly relative to the execution directory to avoid "file not found" errors during the build phase.
- **K-mer Size**: Choose a k-mer size that balances specificity and sensitivity. For most genomic applications, k=21 to k=31 is standard.

## Reference documentation
- [kmindex Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kmindex_overview.md)
- [kmindex GitHub Repository](./references/github_com_tlemane_kmindex.md)