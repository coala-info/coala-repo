---
name: squeakr
description: Squeakr is a memory-efficient bioinformatics tool that uses the Counting Quotient Filter data structure to count and represent k-mer multisets from sequencing reads. Use when user asks to count k-mers in FASTQ files, query k-mer frequencies, list k-mers from exact representations, or compute the inner product between genomic datasets.
homepage: https://github.com/splatlab/squeakr
---


# squeakr

## Overview

Squeakr is a specialized bioinformatics tool designed for the efficient counting and representation of k-mer multisets. By utilizing the Counting Quotient Filter (CQF) data structure, it offers a memory-efficient alternative to traditional k-mer counters, consuming significantly less RAM while maintaining high performance. This skill should be used to process FASTQ files to generate k-mer representations, perform membership queries, list k-mers in exact representations, and compute the inner product between different genomic datasets.

## Installation and Setup

Squeakr can be installed via Bioconda or built from source.

**Conda Installation:**
```bash
conda install bioconda::squeakr
```

**Source Build:**
Requires `libboost-dev`, `libssl-dev`, `zlib1g-dev`, and `bzip2`.
```bash
make squeakr
```
*Note: If building on hardware older than Intel Haswell, use `make NH=1 squeakr` to avoid using incompatible CPU instructions.*

## Core CLI Commands

### 1. Counting k-mers (`squeakr count`)
This is the primary command used to generate a Squeakr representation from sequencing reads.

```bash
squeakr count -k <k-size> -s <log-slots> -o <out-file> <input_files.fastq>
```

**Key Options:**
- `-e, --exact`: Enables exact counting (default is approximate).
- `-k <int>`: Length of the k-mers to count.
- `-c <int>`: Cutoff; only output k-mers with a count greater than or equal to this value (default = 1).
- `-n, --no-counts`: Store only k-mers without their frequency counts.
- `-s <int>`: The log of the number of slots in the CQF. This determines the initial memory allocation.
- `-t <int>`: Number of threads. **Note:** Auto-resizing of the filter only works when `-t` is set to 1.

### 2. Querying k-mers (`squeakr query`)
Retrieve the counts of specific k-mers from a previously generated Squeakr file.

```bash
squeakr query -f <squeakr-file> -q <query-file> -o <output-file>
```

### 3. Comparing Datasets (`squeakr inner_prod`)
Calculate the inner product of two Squeakr representations to estimate similarity.

```bash
squeakr inner_prod <file1.squeakr> <file2.squeakr>
```

### 4. Utility Commands
- `squeakr info`: Displays metadata about a Squeakr file, including k-mer size, version, and CQF-specific information.
- `squeakr list`: Lists all k-mers present in the representation. This command is only available for **exact** representations (`-e`).

## Expert Tips and Best Practices

- **Input Format Restriction:** Squeakr currently only supports FASTQ files (including gzipped or bzipped FASTQ). Passing other formats like FASTA will result in a segmentation fault.
- **Sizing the Filter:** Use the provided `lognumslots.sh` script to estimate the required `-s` (log-slots) parameter. This script typically takes the output of `ntCard` as input to calculate the optimal size for the CQF.
- **Thread Management:** While Squeakr supports multi-threading for speed, remember that the auto-resizing feature is disabled in multi-threaded mode. If you are unsure of the required size, run with a single thread to allow the filter to grow dynamically.
- **Memory Efficiency:** Squeakr is optimized for large k-mers. It often outperforms other systems in query speed and memory usage when k-mer sizes increase.
- **Validation:** If you are integrating Squeakr into a C++ pipeline, you can validate k-mer counts directly via the C++ query API or refer to `kmer_query.cc` in the source code for implementation examples.

## Reference documentation
- [Squeakr GitHub Repository](./references/github_com_splatlab_squeakr.md)
- [Bioconda Squeakr Package](./references/anaconda_org_channels_bioconda_packages_squeakr_overview.md)