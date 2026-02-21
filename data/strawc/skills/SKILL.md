---
name: strawc
description: The `strawc` skill provides guidance for using the high-performance Straw library to access Hi-C contact maps.
homepage: https://github.com/aidenlab/straw
---

# strawc

## Overview
The `strawc` skill provides guidance for using the high-performance Straw library to access Hi-C contact maps. Unlike the Java-based Juicebox tools, `strawc` is optimized for speed and minimal memory overhead by reading only the specific matrix slices requested. It outputs data in a sparse upper triangular format, making it ideal for downstream processing in R, Python, or custom C++ pipelines.

## Installation and Setup

### Bioconda (Recommended)
To install the pre-compiled version of strawc:
```bash
conda install bioconda::strawc
```

### Python Integration
The modern Python implementation uses pybind11 to wrap the C++ code for maximum performance.
```bash
pip install hic-straw
```

### Manual C++ Compilation
If building from source, ensure you have `libcurl` and `zlib` installed on your system.
```bash
g++ -std=c++0x -o straw main.cpp straw.cpp -lcurl -lz
```

## Usage Patterns

### Data Extraction Logic
Straw is designed to query specific "slices" of a Hi-C matrix. When using the tool, you must typically specify:
1.  **Normalization**: (e.g., NONE, VC, VC_SQRT, KR).
2.  **File Path**: The local or remote URL for the `.hic` file.
3.  **Coordinates**: Chromosome and range for both dimensions (e.g., `chr1` and `chr1` for intrachromosomal).
4.  **Units**: Usually `BP` (Base Pairs) or `FRAG` (Fragments).
5.  **Resolution**: The bin size (e.g., 10000 for 10kb).

### Output Format
The tool outputs a sparse triplet format to stdout:
- **Column 1**: Bin index/position for the first chromosome.
- **Column 2**: Bin index/position for the second chromosome.
- **Column 3**: Contact frequency (count).

Note: If the output contains `NaN` in the third column, it typically indicates a normalization issue or a region with no data.

### Python API (hic-straw)
When using the Python wrapper, utilize the following methods for data retrieval:
- `getRecords`: Returns individual contact records.
- `getRecordsAsMatrix`: Returns a dense matrix representation for a specific region.

## Expert Tips
- **Remote Access**: Because `strawc` uses `libcurl`, it can stream data directly from hosted URLs (e.g., ENCODE or 4DN servers) without downloading the full multi-gigabyte `.hic` file.
- **Normalization Availability**: Not all `.hic` files contain all normalization types. Use the library's metadata functions to check available normalizations before attempting extraction to avoid "normalization not present" errors.
- **Performance**: The pybind11 version of the Python library is significantly faster than the legacy pure-python `pystraw` implementation. Always prefer `hic-straw` for production scripts.

## Reference documentation
- [github_com_aidenlab_straw.md](./references/github_com_aidenlab_straw.md)
- [github_com_aidenlab_straw_wiki.md](./references/github_com_aidenlab_straw_wiki.md)
- [anaconda_org_channels_bioconda_packages_strawc_overview.md](./references/anaconda_org_channels_bioconda_packages_strawc_overview.md)