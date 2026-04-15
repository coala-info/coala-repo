---
name: bx-python
description: bx-python is a high-performance library and suite of scripts designed for rapid genomic analysis and manipulation of large-scale sequence alignments. Use when user asks to process multiple sequence alignments, index genomic files for random access, perform interval arithmetic, or manage memory-efficient chromosome coverage data.
homepage: https://github.com/bxlab/bx-python
metadata:
  docker_image: "quay.io/biocontainers/bx-python:0.14.0--py312h5e9d817_0"
---

# bx-python

## Overview
bx-python is a high-performance library and suite of scripts designed for rapid implementation of genomic analyses. It is particularly effective for researchers working with large-scale multiple sequence alignments and complex interval-based data. The tool provides specialized data structures like "Binned Bitsets" for memory-efficient chromosome coverage and "Intersecters" for rapid spatial queries. Use this skill to handle alignment blocks, index flat files for network-optimized random access, and perform interval arithmetic on genomic coordinates.

## Core Capabilities
- **Alignment Processing**: Native support for reading and manipulating MAF (Multiple Alignment Format), AXT, and LAV files.
- **On-Disk Indexing**: Provides a generic data structure for indexing large data blocks associated with genomic intervals, optimized for random access over network filesystems.
- **Interval Arithmetic**: High-speed IntervalTree implementation for performing intersection tests that preserve both query/target intervals and associated annotations.
- **Binned Bitsets**: Chromosome-sized bit arrays that use lazy allocation to store large blocks of set/unset bits compactly.

## Common CLI Patterns

### Working with Multiple Sequence Alignments (MAF)
The most common use case involves indexing a large MAF file to allow for rapid extraction of specific genomic regions without loading the entire file into memory.

**1. Indexing a MAF file**
Most bx-python MAF tools require an index file (.index) for random access.
```bash
# Typical pattern for creating an index for a MAF file
maf_build_index.py input.maf
```

**2. Extracting ranges from an indexed MAF**
Once indexed, you can extract specific coordinates across all species in the alignment.
```bash
# Extracting a specific genomic range
maf_extract_ranges_indexed.py input.maf < intervals.bed
```

### Interval and Bitset Operations
bx-python scripts often handle coordinate-based filtering and intersection.

**1. Fast Intersection**
Use the intersecter logic to find overlaps between two sets of genomic features.
```bash
# Finding intersections between two interval sets
interval_intersect.py file1.bed file2.bed
```

**2. Coordinate Transformation**
The library is frequently used to project coordinates between different alignment blocks or species.

## Expert Tips
- **Memory Management**: When working with whole-genome data, prefer `BinnedBitSet` over standard Python sets or arrays. It is specifically optimized to handle the "sparse" nature of genomic features across large chromosomes.
- **Network Optimization**: The on-disk indexing system is designed to minimize I/O. If your data resides on an NFS or cloud-mounted drive, ensure you use the indexed versions of the scripts to prevent massive sequential reads.
- **Format Strengths**: 
    - Use **MAF** for multiple species alignments.
    - Use **AXT** for pairwise alignments.
    - Use **LAV** for raw alignment output from tools like Blastz.



## Subcommands

| Command | Description |
|---------|-------------|
| maf_build_index.py | Build an index file for a set of MAF alignment blocks. |
| maf_extract_ranges_indexed.py | Extract ranges from MAF files. |

## Reference documentation
- [bx-python GitHub Repository](./references/github_com_bxlab_bx-python.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bx-python_overview.md)