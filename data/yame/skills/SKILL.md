---
name: yame
description: YAME (Yet Another Methylation Encoder/Extractor) is a high-performance toolkit designed for the efficient storage and manipulation of DNA methylation data.
homepage: https://github.com/zhou-lab/YAME
---

# yame

## Overview
YAME (Yet Another Methylation Encoder/Extractor) is a high-performance toolkit designed for the efficient storage and manipulation of DNA methylation data. It addresses the challenges of handling massive methylation matrices by introducing compact binary formats (CX formats) stored within BGZF frames. This skill assists in navigating the YAME command-line interface to pack raw data, subset large datasets, perform statistical row operations, and integrate methylation workflows with other genomic tools like bedtools.

## Installation
Install YAME via bioconda:
```bash
conda install yame -c bioconda
```

## Core CLI Operations

### Data Conversion (Packing/Unpacking)
YAME uses specialized binary formats to achieve high compression and fast access.
- **Packing**: Convert text-based methylation data into compressed CX formats.
- **Unpacking**: Extract binary data back into human-readable formats for inspection or downstream processing.

### Subsetting and Filtering
Use `rowsub` to extract specific genomic regions or subsets of cells/samples.
- Use the `-f` flag to specify the format version (e.g., format 6 is a common target for recent updates).
- Subsetting is essential for focusing analysis on specific CpG sites or genomic features.

### Downsampling
The `dsample` command is used to reduce the depth or size of methylation datasets while preserving biological signals.
- **Pattern**: `yame dsample -b [input.cx]`
- Useful for normalizing coverage across different samples or testing pipeline robustness with smaller data slices.

### Row Operations and Statistics
Perform mathematical or logical operations across rows of the methylation matrix using `rowop`.
- **Summary Statistics**: `yame rowop -o stat [input.cx]`
- **Categorical States**: Use row operations to call methylation states or identify differential methylation patterns.

### Data Summarization
The `summary` command provides a global overview of the methylation landscape within a file.
- Use this to check data integrity, total CpG counts, and global methylation levels.
- Note: If encountering segmentation faults in `summary`, ensure the input file is properly indexed and matches the expected CX format version.

## Expert Tips and Best Practices
- **Format Consistency**: YAME has evolved through several format versions (e.g., format 5 is considered obsolete in newer versions). Always ensure your files are packed using the version compatible with your specific analysis scripts.
- **Single-Cell Scaling**: When working with single-cell data, utilize YAME's ability to handle hundreds of thousands of cells by keeping data in the compressed CX format as long as possible.
- **BGZF Integration**: Since YAME uses BGZF (Blocked GNU Zip Format), files are compatible with random access. Use this to your advantage when querying specific genomic coordinates without decompressing the entire file.
- **Tool Integration**: YAME is designed to work alongside `bedtools`. You can often pipe unpacked coordinate streams directly into bedtools for genomic intersections.

## Reference documentation
- [YAME Overview](./references/anaconda_org_channels_bioconda_packages_yame_overview.md)
- [YAME GitHub Repository](./references/github_com_zhou-lab_YAME.md)
- [YAME Issues and Troubleshooting](./references/github_com_zhou-lab_YAME_issues.md)