---
name: fastmd5
description: fastmd5 is a parallelized utility designed for high-throughput MD5 checksum generation and verification. Use when user asks to generate MD5 sums for files or directories, verify file integrity against a checksum list, or perform fast probabilistic hashing on massive datasets.
homepage: https://github.com/moold/fastMD5
metadata:
  docker_image: "quay.io/biocontainers/fastmd5:1.0.0--h3ab6199_0"
---

# fastmd5

## Overview
fastmd5 is a Rust-based utility designed for high-throughput MD5 operations. It serves as a parallelized alternative to the standard `md5sum` tool, offering significant speed improvements through multi-threading and adjustable computation modes. It is particularly effective for bioinformatics and data science workflows involving massive datasets where traditional checksumming becomes a performance bottleneck.

## Core Usage Patterns

### 1. Generating Checksums
Compute MD5 sums for files or directories. By default, the tool uses speed level 5.

*   **Standard (Default) Mode**:
    `fastmd5 -t 8 file1.zip file2.zip`
*   **GNU-Compatible Mode (Level 0)**: Use this for bit-perfect parity with standard `md5sum`.
    `fastmd5 -s 0 -t 4 data_file.tar.gz`
*   **Optimized Full-File Mode (Level 1)**: Full computation but optimized for speed (up to 4x faster than GNU).
    `fastmd5 -s 1 -t 12 large_database.db`
*   **Recursive Directory Processing**:
    `fastmd5 -t 10 path/to/directory/`

### 2. Verifying Checksums
Validate files against a precomputed MD5 list.

*   **Check Mode**:
    `fastmd5 --check checksums.md5`

## Speed Levels (-s)
The speed level determines how much of the file is processed:
*   **0**: Full sequential computation. 100% accurate and GNU-compatible.
*   **1**: Full-file computation with optimized performance. 100% accurate.
*   **2–9**: Block-based sampling. Only parts of the file are hashed. Use this for extremely large files (>100GB) where a "probabilistic" check is sufficient to detect major corruption or accidental truncation.

## Expert Tips and Best Practices

*   **Thread Optimization**: Always specify threads with `-t`. A good rule of thumb is to set this to the number of available physical CPU cores for maximum throughput.
*   **Large File Handling**: For files exceeding 100GB, using speed level 2 or higher can reduce processing time from minutes to seconds. However, remember that levels 2-9 do not guarantee 100% integrity of every single bit.
*   **Piping to Files**: Like `md5sum`, `fastmd5` outputs to stdout. Redirect to create a checksum file:
    `fastmd5 -s 0 -t 8 *.fastq.gz > hashes.md5`
*   **Bioconda Installation**: The tool is most easily managed via conda:
    `conda install bioconda::fastmd5`

## Reference documentation
- [fastMD5 GitHub README](./references/github_com_moold_fastMD5.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_fastmd5_overview.md)