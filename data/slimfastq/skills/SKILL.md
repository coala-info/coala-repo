---
name: slimfastq
description: slimfastq is a specialized utility for the efficient, lossless compression and decompression of FASTQ files. Use when user asks to compress FASTQ files into sfq format, decompress sfq files, or stream genomic data through pipes for storage and analysis.
homepage: https://github.com/Infinidat/slimfastq
metadata:
  docker_image: "quay.io/biocontainers/slimfastq:2.04--h503566f_5"
---

# slimfastq

## Overview

The `slimfastq` tool is a specialized utility designed for the efficient, lossless compression of FASTQ files. Unlike general-purpose compressors, it leverages the specific structure of genomic data to achieve high compression ratios while maintaining relatively low CPU and memory footprints. It is particularly useful for long-term storage of sequencing data and for pipelines where data needs to be streamed through standard POSIX pipes.

## Core CLI Usage

### Compression
The basic syntax for compression requires an input FASTQ file and a destination `.sfq` file.

```bash
# Standard compression (default level -3)
slimfastq input.fastq output.sfq

# Fast compression (minimal CPU/memory usage)
slimfastq -1 input.fastq output.sfq

# Maximum compression (higher resource usage)
slimfastq -4 input.fastq output.sfq
```

### Decompression
Decompression can be directed to a file or streamed directly to standard output.

```bash
# Decompress to a specific file
slimfastq input.sfq output.fastq

# Decompress to stdout (useful for piping to other tools)
slimfastq input.sfq
```

## Advanced Patterns and Best Practices

### Working with Pipes
`slimfastq` is designed to be "pipe-friendly." Use the `-f` flag when the input is coming from a stream rather than a named file on disk.

```bash
# Convert from gzip to sfq without intermediate files
gzip -dc sample.fastq.gz | slimfastq -f sample.sfq

# Verify integrity using md5sum without decompressing to disk
slimfastq sample.sfq | md5sum -
```

### Parallel Processing
The core `slimfastq` application is single-threaded to minimize overhead from context switches and memory flushes. To process multiple files in parallel, use the provided wrapper script:

```bash
# Use the multi-threaded wrapper for batch jobs
slimfastq.multi -h
```

### Integrity Verification
To ensure a lossless round-trip, compare the MD5 checksum of the original FASTQ with the checksum of the decompressed output:

1. `md5sum original.fastq`
2. `slimfastq original.fastq compressed.sfq`
3. `slimfastq compressed.sfq | md5sum -`

## Expert Tips
- **Compression Levels**: The tool supports levels -1 through -4. Level -3 is the default balance. Use -1 for rapid archiving where CPU time is at a premium.
- **Format Detection**: During decompression, `slimfastq` determines the output format based on internal "stamps" rather than the file extension.
- **Memory Constraints**: If working on a system with very limited RAM, stick to the `-1` compression level.

## Reference documentation
- [slimfastq GitHub README](./references/github_com_Infinidat_slimfastq.md)
- [slimfastq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_slimfastq_overview.md)