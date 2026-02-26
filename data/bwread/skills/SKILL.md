---
name: bwread
description: The bwread library loads BigWig genomic signal data into PyRanges or pandas objects for high-performance analysis. Use when user asks to read BigWig files, convert genomic signal data to PyRanges objects, or load BigWig data for overlap analysis and signal averaging.
homepage: http://github.com/endrebak/bwread
---


# bwread

## Overview
The `bwread` library is a high-performance utility designed to bridge the gap between BigWig files (a standard format for genomic signal data) and the PyRanges/pandas ecosystem. It is particularly useful when you need to quickly load specific genomic intervals or entire chromosomes into memory-efficient objects for overlap analysis, signal averaging, or plotting.

## Usage Instructions

### Installation
Ensure the tool is available in your environment:
```bash
conda install -c bioconda bwread
```

### Basic Python Usage
The primary function is `read_bw`, which allows you to extract data from a BigWig file.

```python
import bwread
import pyranges as pr

# Read a BigWig file into a PyRanges object
# This is the most memory-efficient way to handle genomic intervals
gr = bwread.read_bw("path/to/file.bw")

# Read specific chromosomes or regions if supported by the API
# Note: bwread is optimized for speed by leveraging Cython
```

### Integration with PyRanges
Once loaded, the resulting object integrates seamlessly with the PyRanges library:
- **Filtering**: `gr[gr.Chromosome == "chr1"]`
- **Overlap Analysis**: `gr.overlap(other_ranges)`
- **Statistics**: Calculate mean signal across regions using PyRanges' integration features.

### Best Practices
- **Memory Management**: While `bwread` is fast, BigWig files can be large. If you only need specific regions, filter the resulting PyRanges object immediately or check if the specific version supports indexed fetching.
- **DataFrames**: If you require standard tabular analysis, you can convert the PyRanges object to a pandas DataFrame using `gr.df`.

## Reference documentation
- [bwread GitHub Repository](./references/github_com_pyranges_bwread.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bwread_overview.md)