---
name: pybmtools
description: pybmtools provides programmatic access to BigMethyl and DM files for analyzing methylation data and generating summary statistics. Use when user asks to read or write DM files, calculate methylation statistics across genomic intervals, or retrieve raw values and metadata from BigMethyl files.
homepage: https://github.com/ZhouQiangwei/pybmtools
metadata:
  docker_image: "quay.io/biocontainers/pybmtools:0.1.3--py38h5df1436_1"
---

# pybmtools

## Overview
The `pybmtools` (also referred to as `pydmtools`) skill enables efficient programmatic access to BigMethyl (BM) and DM files. This tool is particularly useful for bioinformatics workflows requiring fast random access to methylation levels, generation of summary statistics (mean, max, weighted averages) across genomic bins, and the creation of new DM files from scratch. It bridges the gap between low-level C performance and Pythonic data analysis.

## Basic Usage

### Loading and Opening Files
Files can be opened for reading (default) or writing ("w").
```python
import pydmtools as pydm

# Open for reading
dm = pydm.openfile("data.dm")

# Open for writing (requires header initialization)
dm_out = pydm.openfile("output.dm", "w")
```

### Inspecting Metadata
Access chromosome names and lengths or the file header information.
```python
# Get all chromosomes and lengths
chroms = dm.chroms()

# Get length of a specific chromosome
length = dm.chroms("chr1")

# View file header (version, zoom levels, min/max values)
header = dm.header()
```

### Querying Data
Retrieve values or statistics for specific genomic intervals.
```python
# Get average methylation in a range
mean_val = dm.stats("chr1", 0, 10000)

# Get max value in a range
max_val = dm.stats("chr1", 0, 1000, type="max")

# Get binned statistics (e.g., 2 bins across a range)
binned = dm.stats("chr1", 100, 200, nBins=2)

# Get raw values for every base (returns 'nan' for missing data)
values = dm.getvalues("chr1", 0, 100)

# Get all intervals (start, end, value) in a range
intervals = dm.intervals("chr1", 0, 100)
```

## Writing DM Files
When creating a new file, you must define the header before adding data.
1. **Add Header**: Provide a list of tuples `(chromosome_name, length)`.
2. **Add Entries**: Entries must be added in genomic order.
3. **Zoom Levels**: By default, 10 zoom levels are created. Use `maxZooms=0` for a flat file (though this may break compatibility with tools like IGV).

```python
# Initialize header
dm_out.addHeader([("chr1", 1000000), ("chr2", 1500000)], maxZooms=10)

# Close file when finished
dm_out.close()
```

## Expert Tips
- **Coordinate System**: Be mindful of 0-based vs 1-based coordinates; `pydmtools` typically follows standard Python/C 0-based indexing for ranges.
- **Performance**: Use `getvalues()` for dense data extraction and `stats()` for summarizing large regions to leverage the file's internal zoom levels.
- **Writing Constraints**: Files opened in write mode ("w") cannot be queried for intervals or statistics until they are closed and re-opened in read mode.

## Reference documentation
- [Python wrapper of dmtools](./references/github_com_ZhouQiangwei_pydmtools.md)
- [pybmtools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pybmtools_overview.md)