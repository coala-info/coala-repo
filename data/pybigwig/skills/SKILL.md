---
name: pybigwig
description: The `pybigwig` skill enables efficient programmatic access to bigWig and bigBed files, which are standard formats for storing dense, indexed genomic data.
homepage: https://github.com/deeptools/pyBigWig
---

# pybigwig

## Overview
The `pybigwig` skill enables efficient programmatic access to bigWig and bigBed files, which are standard formats for storing dense, indexed genomic data. This skill should be used when you need to perform high-performance data extraction from local or remote genomic tracks, calculate binned statistics for visualization, or generate new bigWig files from signal data. It is particularly useful for processing data from ChIP-seq, RNA-seq, or other sequencing-based assays where signal intensity is mapped across a reference genome.

## Core Usage Patterns

### Reading and Querying Files
Always open files using `pyBigWig.open()`. This works for both local paths and remote URLs (HTTP/HTTPS/FTP).

```python
import pyBigWig

# Open a local or remote file
bw = pyBigWig.open("path/to/file.bw")

# Check file type if unknown
if bw.isBigWig():
    print("Processing bigWig signal...")
elif bw.isBigBed():
    print("Processing bigBed intervals...")

# Get chromosome lengths
chrom_sizes = bw.chroms()
length_chr1 = bw.chroms("chr1")
```

### Retrieving Statistics
The `.stats()` method is the most efficient way to get summary data.
- **Types**: `"mean"` (default), `"max"`, `"min"`, `"coverage"`, `"std"`.
- **nBins**: Divide the interval into N equal parts and return a list of values.
- **exact**: Set `exact=True` to bypass zoom levels and calculate from raw data (slower but precise).

```python
# Get the mean signal for chr1:0-1000
mean_val = bw.stats("chr1", 0, 1000)

# Get 100 binned max values for a region (useful for plotting)
binned_max = bw.stats("chr1", 0, 10000, type="max", nBins=100)
```

### Accessing Raw Data
- `values(chrom, start, end)`: Returns a list of floats for every base (NaN where no data exists).
- `intervals(chrom, start, end)`: Returns a list of triplets `(start, end, value)` representing the underlying data chunks.
- `entries(chrom, start, end)`: Specifically for bigBed files to retrieve the string entries.

### Creating bigWig Files
Writing requires a specific sequence: open in `"w"` mode, add a header, then add entries.

```python
bw = pyBigWig.open("output.bw", "w")

# Header must be a list of (chrom, length) tuples
bw.addHeader([("chr1", 1000000), ("chr2", 1500000)])

# Add data (chroms, starts, ends, values)
# Note: Coordinates must be sorted by chromosome and then by start position
bw.addEntries(["chr1", "chr1"], [0, 100], ends=[50, 150], values=[1.5, 2.5])

bw.close()
```

## Expert Tips and Best Practices
- **Coordinate System**: `pybigwig` uses 0-indexed, half-open coordinates (start is inclusive, end is exclusive), matching standard Python slicing and BED format.
- **Memory Management**: Always call `.close()` on your file objects, especially when writing, to ensure the file index is properly finalized.
- **Remote Access**: When working with remote files, `pybigwig` uses `libcurl`. Ensure your environment has network access. It only downloads the specific chunks of data requested, making it very efficient for large remote tracks.
- **Numpy Integration**: If you have `numpy` installed, `values()` and `stats()` can return numpy arrays if requested, which is significantly faster for downstream numerical analysis.
- **Error Handling**: If a chromosome name does not exist in the file, `pybigwig` methods typically return `None` or an empty list. Always verify chromosome names against `bw.chroms()` before querying.

## Reference documentation
- [pyBigWig README](./references/github_com_deeptools_pyBigWig.md)
- [Bioconda pybigwig Overview](./references/anaconda_org_channels_bioconda_packages_pybigwig_overview.md)