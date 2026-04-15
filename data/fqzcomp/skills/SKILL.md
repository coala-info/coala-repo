---
name: fqzcomp
description: fqzcomp is a high-performance command-line utility designed for the efficient compression and decompression of FASTQ files using specialized models for sequence, quality, and metadata. Use when user asks to compress genomic datasets, decompress fqz files, or perform lossy quality score reduction.
homepage: https://sourceforge.net/projects/fqzcomp/
metadata:
  docker_image: "quay.io/biocontainers/fqzcomp:4.6--h077b44d_6"
---

# fqzcomp

## Overview

fqzcomp is a specialized command-line utility designed for the high-performance compression of FASTQ files. It achieves compression ratios comparable to bzip2 but with significantly higher throughput by using distinct models for sequence, quality, and metadata. It supports both lossless and lossy quality score compression and is particularly effective for large-scale genomic datasets from Illumina, 454, PacBio, and SOLiD platforms.

## Basic Usage

The tool can operate via standard input/output for pipelining or directly on files.

### Compression
```bash
# Using redirection (standard)
fastq_comp [options] < input.fastq > output.fqz

# Direct file access (v4.0+)
fastq_comp -s5 -q3 input.fastq output.fqz
```

### Decompression
```bash
# Using redirection
fastq_comp -d < input.fqz > output.fastq

# Direct file access
fastq_comp -d input.fqz output.fastq
```

## Command Line Options

### Sequence Compression (-s, -b, -e)
- `-s <level>`: Sets the sequence context size (default is 3). Each increment quadruples memory usage.
- `-s<level>+`: Adding a `+` (e.g., `-s5+`) uses two context sizes, which significantly improves compression for small files.
- `-b`: Uses both strands for context updates. Slower, but provides a small compression gain. Do not use with SOLiD data.
- `-e`: Forces 16-bit counters instead of 8-bit. Increases memory usage but slightly improves compression.

### Quality Compression (-q, -Q)
- `-q <level>`: Sets quality compression level (1-3, default is 2).
    - `-q1`: Uses previous quality values as context.
    - `-q2`: Adds a running-delta measure (variability).
    - `-q3`: Adds sequence position to the context (highest memory/slowest).
- `-Q <distance>`: Enables **lossy** compression. Quality values are stored within `+/- <distance>` of the original. Default is `-Q0` (lossless).

### Name Compression (-n)
- `-n1`: Simple string-based compression.
- `-n2`: Token-based compression (default). Best for regular Illumina naming conventions.

### General
- `-d`: Decompress mode.
- `-P`: Disables multi-threading.
- `-X`: Ignore checksum failures during decompression.

## Expert Tips and Best Practices

### Memory Management
The `-s` parameter is the primary memory driver. While `-s9` is theoretically possible, it is rarely practical. Most users find the sweet spot between `-s4` and `-s6`. If you encounter memory errors, reduce the `-s` level.

### Handling Checksum Failures
fqzcomp enforces a strict policy: `N` bases must have a quality of 0, and non-`N` bases must have a quality > 0. If your original FASTQ violates this (e.g., an `N` with quality 20), fqzcomp will "fix" it during compression, which leads to a checksum mismatch during decompression. Use the `-X` flag during decompression to bypass these errors if the data integrity of those specific points is not critical.

### Metadata Limitations
Note that fqzcomp ignores names on the "+" line (the third line of a FASTQ record). Upon decompression, the "+" line will be empty or contain only a placeholder, even if it originally contained a duplicate of the sequence ID.

### Input Requirements
- Sequences must be on a single line.
- Quality scores must be on a single line.
- Supported characters are `[ACGTN]` or `[0123.]`. Other characters are treated as `N` or `.`.

## Reference documentation
- [fqzcomp Files and README](./references/sourceforge_net_projects_fqzcomp_files.md)
- [fqzcomp Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fqzcomp_overview.md)