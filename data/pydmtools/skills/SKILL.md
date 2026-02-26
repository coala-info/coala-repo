---
name: pydmtools
description: pydmtools is a high-performance Python extension that provides rapid access to DNA methylation files for reading and writing genomic data. Use when user asks to extract methylation statistics, retrieve base-level values, query genomic intervals, or create new DM files.
homepage: https://github.com/ZhouQiangwei/pydmtools
---


# pydmtools

## Overview

`pydmtools` is a high-performance Python extension written in C that provides rapid access to DNA methylation (DM) files. It serves as a wrapper for `dmtools`, supporting both local and remote file access. Use this skill when you need to integrate DM file processing into bioinformatics pipelines, specifically for tasks involving genomic range queries, methylation statistics (mean, max, weighted), or the creation of new DM files from scratch.

## Installation and Requirements

The tool requires `libcurl` and `zlib` (including headers) to be installed on the system.

```bash
# Via Conda
conda install pydmtools -c bioconda

# Via Pip
pip install pydmtools
```

## Core Usage Patterns

### Opening and Closing Files

Files are opened using `pydm.openfile()`. By default, files are opened for reading.

```python
import pydmtools as pydm

# Open for reading
dm = pydm.openfile("input.dm")

# Open for writing (cannot be queried for intervals/stats while writing)
dm_write = pydm.openfile("output.dm", "w")

# Always close the file handle when finished
dm.close()
```

### Metadata and Chromosome Information

Access genomic metadata and chromosome lengths stored within the DM file.

*   **Chromosome List**: `dm.chroms()` returns a dictionary of chromosomes and their lengths.
*   **Specific Chromosome**: `dm.chroms("chr1")` returns the length of a specific chromosome.
*   **File Header**: `dm.header()` returns a dictionary containing versioning, zoom levels, and data summaries (min, max, sum, sumSquared).

### Data Retrieval Methods

There are three primary ways to extract data from a DM file:

1.  **Summary Statistics (`stats`)**: Best for binned data or averages over a range.
    *   `type`: "mean" (default), "max", or "weighted" (DNA methylation specific).
    *   `nBins`: Number of evenly spaced bins to compute.
    ```python
    # Get mean methylation for a range
    mean_val = dm.stats("chr1", 0, 10000)
    # Get max value in 2 bins
    bins = dm.stats("chr1", 100, 200, type="max", nBins=2)
    ```

2.  **Base-Level Values (`getvalues`)**: Returns a list of values for every single base in the range.
    *   Missing data points are returned as `nan`.
    ```python
    values = dm.getvalues("chr1", 0, 100)
    ```

3.  **Interval Extraction (`intervals`)**: Returns a list of tuples `(start, end, value)` for entries overlapping the range.
    ```python
    # Get all intervals on chr1
    all_intervals = dm.intervals("chr1")
    ```

## Creating DM Files

When writing a new DM file, you must follow a strict sequence: Open -> Add Header -> Add Entries -> Close.

### 1. Adding the Header
The header must include all chromosomes and their sizes in the order they will appear.
```python
# maxZooms=0 creates a file without zoom levels (saves space, but breaks IGV compatibility)
dm_write.addHeader([("chr1", 1000000), ("chr2", 1500000)], maxZooms=10)
```

### 2. Adding Entries
Entries must be added in genomic order.
```python
# Format: chromosome, start, end, value
dm_write.addEntries(["chr1", "chr1"], [0, 100], [100, 120], [0.5, 0.8])
```

## Expert Tips and Best Practices

*   **Coordinate System**: `pydmtools` uses **0-based, half-open** coordinates (standard for BED files). The start is inclusive, and the end is exclusive.
*   **IGV Compatibility**: Always use the default `maxZooms` (or at least 1) when creating files intended for visualization in IGV. Setting `maxZooms=0` will cause many external tools to fail.
*   **Remote Access**: Because it uses `libcurl`, you can pass URLs to `openfile()` to stream data from remote servers without downloading the entire file.
*   **Write Mode Limitations**: A file opened with mode `"w"` is strictly for writing. You cannot perform `stats()` or `intervals()` queries on a file handle until it has been closed and re-opened in read mode.
*   **Memory Efficiency**: For very large ranges, prefer `intervals()` over `getvalues()` if the data is sparse, as `getvalues()` will allocate memory for every single base (including `nan` values).

## Reference documentation
- [pydmtools GitHub README](./references/github_com_ZhouQiangwei_pydmtools.md)
- [pydmtools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pydmtools_overview.md)