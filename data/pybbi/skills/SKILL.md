---
name: pybbi
description: pybbi provides high-performance Python bindings for reading BigWig and BigBed genomic data files into NumPy and Pandas. Use when user asks to fetch quantitative signal from BigWig files, retrieve intervals from BigBed files, inspect genomic file metadata, or generate stacked heatmaps from multiple genomic regions.
homepage: https://github.com/nvictus/pybbi
metadata:
  docker_image: "quay.io/biocontainers/pybbi:0.4.2--py39h2d95d83_0"
---

# pybbi

## Overview
pybbi provides high-performance Python bindings to the UCSC Big Binary Indexed (BBI) file library. It is specifically optimized for fast, read-only access to genomic data stored in BigWig (quantitative signal) and BigBed (versioned intervals) formats. By leveraging Cython, it allows researchers to bypass slow parsing and move genomic data directly into the PyData stack (NumPy and Pandas) for analysis. It supports both local file paths and remote URLs.

## Core Usage Patterns

### Opening Files
Always use the context manager to ensure resources are properly cleaned up.
```python
import bbi

with bbi.open('path/to/file.bw') as f:
    # Perform operations
    pass
```

### Inspecting Metadata
Use introspection properties to validate file contents before processing.
- `f.chromsizes`: Returns an OrderedDict of chromosome names and lengths.
- `f.info`: Returns a dictionary containing header information (version, summary data).
- `f.schema`: Returns the autoSql schema for BigBed files, including numpy dtypes.
- `f.is_bigwig` / `f.is_bigbed`: Boolean flags for file type.

### Fetching Quantitative Signal (BigWig)
The `fetch` method returns a 1D numpy array.
```python
# Fetch raw signal for a specific range
data = f.fetch('chr1', 1000000, 2000000)

# Fetch binned data (summary statistics)
# summary can be: 'mean', 'min', 'max', 'cov', 'std', 'sum'
binned_data = f.fetch('chr1', 1000000, 2000000, bins=100, summary='mean')
```

### Fetching Intervals (BigBed)
Retrieve records as a pandas DataFrame or an iterator.
```python
# As a DataFrame (parsed according to schema)
df = f.fetch_intervals('chr1', 1000000, 2000000)

# As an iterator of tuples for memory efficiency
for interval in f.fetch_intervals('chr1', 1000000, 2000000, iterator=True):
    print(interval)
```

### Generating Stacked Heatmaps
The `stackup` method is highly efficient for generating 2D matrices from multiple genomic regions (e.g., centered on TSS or peaks).
```python
# chroms, starts, ends should be arrays/lists of equal length
matrix = f.stackup(chroms, starts, ends, bins=50)
```

## Expert Tips and Best Practices

### Handling Out-of-Bounds (OOB) Queries
pybbi allows queries that extend beyond chromosome boundaries, which is useful for centered heatmaps.
- Use the `oob` parameter to set the fill value for regions outside the chromosome (default is `NaN`).
- Use the `missing` parameter to set the fill value for regions within the chromosome that have no data (default is `0`).

### Performance with Remote Files
Since pybbi supports URLs, it can stream data from servers like the UCSC Genome Browser. To optimize performance:
- Minimize the number of `fetch` calls by batching queries if possible.
- Use `bins` to retrieve summarized data rather than raw signal for large regions to reduce network overhead.

### Error Handling Caution
The underlying UCSC C library is known to call `exit()` on certain internal errors, which will terminate the entire Python interpreter. 
- **Validation**: Always validate chromosome names against `f.chromsizes` before calling `fetch`.
- **Bounds**: While `oob` handles ranges outside chromosome lengths, passing negative coordinates or invalid chromosome names can still trigger hard exits in some versions.

### Summary Statistics
When using `bins`, the default summary statistic is `mean`. If you are looking for peak signal in a window, use `summary='max'`. If you need to know the fraction of the bin covered by data, use `summary='cov'`.

## Reference documentation
- [pybbi GitHub README](./references/github_com_nvictus_pybbi.md)
- [pybbi Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pybbi_overview.md)