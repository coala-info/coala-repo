---
name: pyrle
description: Pyrle provides a Cython-optimized implementation of Run Length Encoding for memory-efficient storage and arithmetic of genomic data. Use when user asks to perform arithmetic on genomic tracks, store sparse data using Run Length Encoding, or manage memory-intensive vector operations.
homepage: https://github.com/endrebak/pyrle
metadata:
  docker_image: "quay.io/biocontainers/pyrle:0.0.43--py311haab0aaa_0"
---

# pyrle

## Overview
The `pyrle` library provides a Cython-optimized implementation of Run Length Encoding (RLE) for Python, inspired by R's S4Vectors. It allows for the representation of long vectors as a series of values and their corresponding lengths, significantly reducing memory overhead for sparse or repetitive genomic data. Unlike some R implementations, `pyrle` handles mismatched vector lengths by extending the shorter vector with zeros rather than rotating it, making it more predictable for genomic coordinate arithmetic.

## Usage Guidelines

### Core Concepts
- **Rle Object**: The primary data structure consisting of `runs` (lengths) and `values`.
- **Memory Efficiency**: Use `pyrle` when dealing with genome-wide tracks (e.g., BigWig-like data) where large regions have the same value (often zero).
- **Arithmetic**: Supports standard operators (`+`, `-`, `*`, `/`) directly on Rle objects.

### Common Patterns
- **Initialization**: Create Rle objects from lists or arrays of values and lengths.
- **Genomic Arithmetic**: When performing arithmetic between two Rle objects of different lengths, `pyrle` automatically pads the shorter one with zeros to match the longer one.
- **Integration with PyRanges**: `pyrle` is the underlying engine for coverage and signal operations in the PyRanges ecosystem.

### Performance Tips
- **Cython Backend**: Operations are executed in Cython; avoid manual looping over Rle elements in Python to maintain performance.
- **Vectorized Operations**: Always prefer using the built-in arithmetic operators over manual manipulation of the `runs` and `values` arrays.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_pyranges_pyrle.md)
- [Bioconda Package Summary](./references/anaconda_org_channels_bioconda_packages_pyrle_overview.md)