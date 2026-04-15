---
name: rampler
description: Rampler is a tool for the targeted sampling and splitting of genomic sequences in FASTA and FASTQ formats. Use when user asks to subsample reads to a specific fold-coverage or split large sequence files into smaller fragments.
homepage: https://github.com/rvaser/rampler
metadata:
  docker_image: "biocontainers/rampler:v1.1.0-1-deb_cv1"
---

# rampler

---

## Overview
Rampler is a high-performance tool designed for the targeted sampling of genomic sequences. It provides two primary functions: random subsampling of reads to achieve a specific fold-coverage (given a reference genome length) and splitting large sequence files into smaller, fixed-size fragments. It natively supports both FASTA and FASTQ formats, including gzip-compressed files.

## Command Line Usage

### Subsampling Sequences
Use the `subsample` mode to extract a random subset of reads that corresponds to a desired depth of coverage.

```bash
rampler subsample <sequences> <reference_length> <coverage> [<coverage> ...]
```

*   **sequences**: Path to the input FASTA/FASTQ file (can be `.gz`).
*   **reference_length**: The integer length of the reference genome or assembly.
*   **coverage**: One or more integers representing the desired fold-coverage (e.g., 10, 30, 50).

**Example: Subsampling to 20x and 50x coverage**
```bash
rampler subsample reads.fastq.gz 4641652 20 50 -o ./subsampled_data
```

### Splitting Files
Use the `split` mode to break a large sequence file into smaller chunks based on byte size.

```bash
rampler split <sequences> <chunk_size>
```

*   **chunk_size**: Integer denoting the desired size of each chunk in bytes.

**Example: Splitting a file into 500MB chunks**
```bash
rampler split large_dataset.fasta 524288000
```

## Best Practices and Tips

*   **Reference Length Accuracy**: The `subsample` mode relies on the provided reference length to calculate how many reads to keep. Ensure this value is as accurate as possible for the specific organism or assembly you are working with.
*   **Handling Compressed Data**: Rampler can read and process gzipped files directly. To save time and disk I/O, provide the `.gz` files directly rather than decompressing them first.
*   **Output Organization**: Always use the `-o` or `--out-directory` flag to specify a destination. By default, rampler creates files in the current directory, which can lead to clutter when generating multiple coverage subsets.
*   **Batch Subsampling**: You can pass multiple coverage values in a single command. Rampler will generate a separate file for each specified coverage level, which is more efficient than running the tool multiple times.
*   **Memory Efficiency**: As a standalone C++ module, rampler is designed to be lightweight. It is generally faster and more memory-efficient than general-purpose sequence manipulation toolkits for these specific sampling tasks.

## Reference documentation
- [Rampler README](./references/github_com_rvaser_rampler.md)