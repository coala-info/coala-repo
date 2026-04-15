---
name: ngsindex
description: ngsindex is a Python utility that standardizes the resolution and parsing of various Next-Generation Sequencing index formats into programmatic objects. Use when user asks to find index files, parse BAI, TBI, CSI, or SBI structures, or verify index integrity within a Python pipeline.
homepage: https://github.com/jdidion/ngsindex
metadata:
  docker_image: "quay.io/biocontainers/ngsindex:0.1.7--pyh7cba7a3_0"
---

# ngsindex

## Overview
ngsindex is a Python-based utility designed to standardize the handling of various NGS index formats. It provides a clean API to automatically find index files based on their associated data files and parse their internal structures into Python objects. This tool is essential for developers building genomic pipelines who need to verify index integrity or iterate through reference indexes without relying on external command-line dependencies like samtools or tabix for simple metadata retrieval.

## Installation
Install the package via Bioconda or pip:
```bash
conda install bioconda::ngsindex
# OR
pip install ngsindex
```

## Core Python API Usage
The primary utility of ngsindex is its programmatic interface for resolving and loading index data.

### Resolving and Parsing Indices
Use `resolve_index_file` to find the index path and `parse_index` to load the object.

```python
from ngsindex import IndexType, resolve_index_file, parse_index
from pathlib import Path

# Define the data file path
data_file = Path('/path/to/data.bam')

# Automatically find the BAI index (e.g., data.bam.bai or data.bai)
index_file = resolve_index_file(data_file, IndexType.BAI)

# Load the index into memory
index = parse_index(index_file)

# Access reference information
for ref_idx in index.ref_indexes:
    # Process reference-specific index data
    pass
```

### Supported Index Types
Pass these constants to the resolution and parsing functions:
- `IndexType.BAI`: BAM Index
- `IndexType.TBI`: Tabix Index
- `IndexType.CSI`: Coordinate-Sorted Index
- `IndexType.SBI`: Sequence Binary Index

## Best Practices and Tips
- **Path Handling**: Always use `pathlib.Path` objects when interacting with the API to ensure cross-platform compatibility and robust file resolution.
- **Index Discovery**: `resolve_index_file` is preferred over hardcoding paths, as it accounts for common naming variations (e.g., `file.bam.bai` vs `file.bai`).
- **Limitations**: Note that CRAM index files (`.crai`) are currently not supported by this library.
- **SBI Support**: This library is one of the few lightweight Python tools that explicitly supports the SBI (Sequence Binary Index) format.

## Reference documentation
- [ngsindex GitHub Repository](./references/github_com_jdidion_ngsindex.md)
- [Bioconda ngsindex Overview](./references/anaconda_org_channels_bioconda_packages_ngsindex_overview.md)