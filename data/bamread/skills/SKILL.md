---
name: bamread
description: bamread converts BAM alignment files into Pandas DataFrames for high-performance data analysis in Python. Use when user asks to load BAM files into Python, convert genomic alignments to a DataFrame, or perform exploratory data analysis on alignment records.
homepage: http://github.com/endrebak/bamread
---


# bamread

## Overview
`bamread` is a specialized, high-performance utility designed to bridge the gap between binary Sequence Alignment Map (BAM) files and the Python data science ecosystem. By utilizing Cython for its core logic, it enables researchers to bypass slow, pure-Python parsing methods, directly converting alignment records into Pandas DataFrames. This tool is particularly effective when performing exploratory data analysis or building custom genomic pipelines where speed and ease of manipulation are critical.

## Installation
The package is available via Bioconda or PyPI.

```bash
# Using Conda
conda install bioconda::bamread

# Using pip
pip install bamread
```

## Core Usage
The primary interface for `bamread` is the `read_bam` function, which returns a standard Pandas DataFrame.

### Python API
```python
import bamread

# Load a BAM file into a DataFrame
df = bamread.read_bam("path/to/alignments.bam")

# Standard Pandas operations can now be performed
print(df.head())
print(df.columns)
```

### Quick CLI Inspection
You can quickly preview a BAM file's contents as a DataFrame directly from the terminal using Python's command-line interface:

```bash
python -c "import bamread; print(bamread.read_bam('alignments.bam'))"
```

## Best Practices and Tips
- **Memory Management**: While `bamread` is fast, loading extremely large BAM files into memory as DataFrames can consume significant RAM. For massive datasets, consider filtering your BAM file (e.g., using `samtools`) before reading it into Python.
- **Indexing**: Ensure your BAM files are indexed (`.bai` files) in the same directory, as many underlying alignment libraries require indices for efficient access, even if `bamread` simplifies the loading process.
- **Data Types**: Once loaded, the resulting DataFrame uses standard Pandas types. You can optimize memory further by downcasting specific columns (like mapping quality or flags) using `df.astype()`.
- **Integration**: Use `bamread` as the ingestion layer for libraries like `seaborn` or `matplotlib` to quickly generate coverage plots or insert-size distributions from your alignment data.

## Reference documentation
- [Anaconda Bioconda bamread Overview](./references/anaconda_org_channels_bioconda_packages_bamread_overview.md)
- [GitHub pyranges/bamread](./references/github_com_pyranges_bamread.md)