---
name: iscc-sum
description: iscc-sum is a high-performance implementation of the ISCC hashing standard used for content identification and similarity detection. Use when user asks to generate ISCC codes, verify file integrity, find similar files based on content, or process large datasets for similarity matching.
homepage: https://github.com/bio-codes/iscc-sum
metadata:
  docker_image: "quay.io/biocontainers/iscc-sum:0.1.0--py314hc1c3326_0"
---

# iscc-sum

## Overview

iscc-sum is a high-performance implementation of the ISCC hashing standard, written in Rust with Python bindings. While traditional hashes like MD5 or SHA-256 are used for strict integrity, ISCC codes are designed for content identification and similarity detection. This tool is specifically optimized for massive datasets, offering 50-130x faster performance than reference implementations. Use this skill to manage file integrity, generate content identifiers, and find similar files within large repositories.

## Installation

The recommended way to install the CLI tool is via `uv`:

```bash
uv tool install iscc-sum
```

Alternatively, use conda:
```bash
conda install bioconda::iscc-sum
```

## Common CLI Patterns

### Generating Checksums
Generate a standard ISCC-CODE for a file. By default, this uses the "WIDE" subtype (256-bit) which supports advanced similarity matching.

```bash
# Single file
iscc-sum document.pdf

# Multiple files using wildcards
iscc-sum *.jpg

# Read from stdin
cat data.bin | iscc-sum
```

### Verification
Verify files against a previously generated checksum file, similar to `sha256sum -c`.

```bash
# Create the checksum file
iscc-sum *.txt > checksums.iscc

# Verify the files
iscc-sum -c checksums.iscc

# Quiet verification (only show failures)
iscc-sum -c -q checksums.iscc
```

### Similarity Matching
One of the primary advantages of ISCC is the ability to find files with similar content based on Hamming distance.

```bash
# Find similar files in a directory (default threshold: 12 bits)
iscc-sum --similar *.jpg

# Adjust the similarity threshold (lower = more similar)
iscc-sum --similar --threshold 6 *.pdf
```

### Directory and Project Hashing
Process an entire directory structure as a single unit to create a combined checksum.

```bash
iscc-sum --tree /path/to/project
```

## Expert Tips

- **ISO Compliance**: By default, the tool uses "WIDE" codes for better similarity matching. For ISO 24138:2024 conformant 128-bit codes, always use the `--narrow` flag.
- **Component Analysis**: Use the `--units` flag to see the individual Data-Code and Instance-Code components that make up the final ISCC string.
- **Output Formatting**: Use `--tag` for BSD-style output or `-z/--zero` for NUL-terminated lines when piping to `xargs`.
- **Performance**: For multi-GB files, iscc-sum maintains a consistent ~1 GB/s throughput. It is significantly more efficient than standard Python-based ISCC implementations for batch processing.

## Python API Quick Start

For integration into Python scripts, use the `code_iscc_sum` function or the streaming processor for large files.

```python
from iscc_sum import code_iscc_sum, IsccSumProcessor

# Simple file hashing
result = code_iscc_sum("data.zip", wide=True)
print(f"ISCC: {result.iscc}")

# Streaming for very large files
processor = IsccSumProcessor()
with open("huge_file.bin", "rb") as f:
    while chunk := f.read(1024*1024):
        processor.update(chunk)
print(processor.result(wide=False).iscc)
```

## Reference documentation
- [iscc-sum Overview](./references/anaconda_org_channels_bioconda_packages_iscc-sum_overview.md)
- [iscc-sum GitHub Repository](./references/github_com_bio-codes_iscc-sum.md)