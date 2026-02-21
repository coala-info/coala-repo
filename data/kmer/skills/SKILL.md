---
name: kmer
description: This skill provides guidance on using the `kmer-cnt` suite, a collection of high-performance k-mer counters designed for bioinformatics workflows.
homepage: https://github.com/lh3/kmer-cnt
---

# kmer

## Overview
This skill provides guidance on using the `kmer-cnt` suite, a collection of high-performance k-mer counters designed for bioinformatics workflows. It is used to calculate the frequency of canonical k-mers—the lexicographically smaller sequence between a k-mer and its reverse complement. The suite is ideal for pre-processing steps in genome assembly, mapping, and metagenomic profiling where speed and memory efficiency are critical.

## Implementation Selection
The repository provides multiple implementations. Choose the one that fits your specific performance or educational needs:

- **yak-count**: The most advanced and recommended version. It uses a Bloom filter to ignore singleton k-mers (those appearing only once), significantly reducing memory usage.
- **kc-c4**: The fastest multi-threaded implementation in the suite. It uses an ensemble of hash tables to parallelize insertions.
- **kc-c1**: A lightweight C implementation (under 100 lines) that packs k-mers into 64-bit integers. Best for k-mer lengths ≤ 32.
- **kc-py1.py**: A basic Python 3 implementation for quick prototyping or educational purposes.

## Common CLI Patterns

### Building the Tools
The C and C++ implementations must be compiled before use. A C++11 compatible compiler is required.
```bash
make
```

### Basic K-mer Counting
To count k-mers in a compressed FASTA or FASTQ file using the optimized `yak-count` implementation:
```bash
./yak-count input.fa.gz > output.kc
```

### Using the Bloom Filter
To reduce memory consumption by filtering out most singleton k-mers, use the `-b` flag to set the Bloom filter size (in bits):
```bash
# Example: Using a Bloom filter with 1 billion bits (~125MB RAM)
./yak-count -b30 input.fastq.gz > output.kc
```

### Multi-threading
`kc-c4` and `yak-count` support multi-threading. By default, they typically use 4 threads, but this can be adjusted via the command line (check specific implementation help for the `-t` or `-p` flags depending on the version).

## Expert Tips
- **K-mer Length Limit**: Most optimized implementations in this suite (kc-c1 through kc-c4 and yak-count) are hard-coded or optimized for k-mer lengths up to 32. For k > 32, you may need to use the Python or C++ STL-based versions, though they are significantly slower.
- **Canonical K-mers**: You do not need to manually reverse-complement your reads; the tools automatically identify and count the canonical (lexicographically smaller) strand.
- **Memory Management**: If you encounter memory issues with large datasets, prioritize `yak-count` with the `-b` flag. This is the most memory-efficient way to handle high-coverage data.
- **Data Locality**: `kc-c4` is often faster than simpler versions not just because of threading, but because batching k-mer insertions improves CPU cache locality.

## Reference documentation
- [Main README and Results](./references/github_com_lh3_kmer-cnt.md)
- [Build Instructions](./references/github_com_lh3_kmer-cnt_blob_master_Makefile.md)