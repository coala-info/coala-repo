---
name: hic-straw
description: hic-straw extracts contact matrix data from Juicebox-formatted .hic files at specific resolutions and normalization levels. Use when user asks to stream genomic interaction data, extract contact records from .hic files, or retrieve Hi-C matrices for specific chromosomal regions.
homepage: https://github.com/aidenlab/straw
metadata:
  docker_image: "quay.io/biocontainers/hic-straw:1.3.1--py311hb99c5bc_6"
---

# hic-straw

## Overview
hic-straw is a specialized library and command-line utility designed for high-speed data extraction from Juicebox-formatted .hic files. It enables users to stream specific slices of contact matrices at various resolutions and normalization levels without the overhead of loading entire datasets. It is particularly effective for large-scale genomic workflows where only specific chromosomal interactions are required for downstream processing.

## Installation
Install the tool using one of the following methods:
- **Conda**: `conda install bioconda::hic-straw`
- **Pip**: `pip install hic-straw`
- **Source**: Compile the C++ version using `g++ -std=c++0x -o straw main.cpp straw.cpp -lcurl -lz` (requires libcurl and zlib).

## Command Line Usage
The primary CLI tool is `straw`. It outputs data in a sparse upper triangular format (row, column, count).

### Basic Syntax
`straw <normalization> <hic_file> <chr1>[:x1:x2] <chr2>[:y1:y2] <unit> <binsize>`

### Parameters
- **normalization**: The normalization method to apply. Common options include:
  - `NONE`: Raw counts.
  - `VC`: Vanilla Coverage.
  - `VC_SQRT`: Square root of Vanilla Coverage.
  - `KR`: Knight-Ruiz (standard for balanced matrices).
  - `SCALE`: Iterative scaling.
- **hic_file**: Path to a local `.hic` file or a URL (http/https) for remote streaming.
- **chr1 / chr2**: Chromosome names (e.g., `1`, `X`). You can append coordinates to subset the region (e.g., `1:1000000:2000000`).
- **unit**: Use `BP` for base pairs or `FRAG` for restriction fragments.
- **binsize**: The resolution of the matrix (e.g., `10000` for 10kb). This must match a resolution existing within the `.hic` file.

### Common Patterns
- **Extract a whole chromosome interaction**:
  `straw KR sample.hic 1 1 BP 2500000`
- **Extract a specific sub-region**:
  `straw KR sample.hic 1:1000000:5000000 1:1000000:5000000 BP 10000`
- **Stream from a remote server**:
  `straw NONE https://example.com/data.hic 4 4 BP 500000`

## Python API Usage
The Python wrapper provides a more programmatic way to access records.

### Basic Extraction
```python
import hic_straw

# Returns a list of contact records
records = hic_straw.straw('KR', 'path/to/file.hic', '1', '1', 'BP', 10000)

for r in records:
    print(f"{r.binX} {r.binY} {r.counts}")
```

### Matrix Retrieval
Use `getRecordsAsMatrix` to retrieve data directly into a format suitable for numerical analysis:
```python
import hic_straw
matrix = hic_straw.getRecordsAsMatrix('KR', 'file.hic', '1', '1', 'BP', 10000)
```

## Best Practices and Expert Tips
- **Check Available Normalizations**: Before querying, ensure the requested normalization exists in the file. Newer versions of the API include functions to list available normalizations.
- **Resolution Matching**: If a query returns no data or an error, verify the `binsize` against the file's metadata using `Juicebox` or `hicInfo`.
- **Remote Streaming**: hic-straw is optimized for partial file reading via HTTP range requests. Use this for large files hosted on cloud buckets to avoid massive downloads.
- **Memory Efficiency**: Because straw streams data, it is significantly more memory-efficient than loading `.hic` files into objects in memory. Use it as a pre-processor to filter data before passing it to heavy analysis libraries.
- **Coordinate Handling**: When chr1 and chr2 are the same, straw returns the upper triangle of the matrix. Ensure your downstream logic accounts for the symmetric nature of Hi-C data.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_aidenlab_straw.md)
- [Straw Wiki and Documentation](./references/github_com_aidenlab_straw_wiki.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_hic-straw_overview.md)