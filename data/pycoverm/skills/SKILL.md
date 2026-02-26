---
name: pycoverm
description: pycoverm provides high-performance Python bindings for calculating metagenomic contig coverage from BAM files using a Rust-based engine. Use when user asks to estimate contig coverage, calculate mean coverage across multiple BAM files, or validate if BAM files are coordinate-sorted.
homepage: https://github.com/apcamargo/pycoverm
---


# pycoverm

## Overview
`pycoverm` provides high-performance Python bindings for the CoverM engine, a tool designed for rapid coverage estimation of metagenomic contigs. This skill enables the calculation of mean contig coverages across multiple BAM files simultaneously, returning results as structured NumPy arrays. It is specifically optimized for speed and low memory overhead by leveraging a Rust-based backend.

## Installation
The library can be installed via PyPI or Bioconda:

```bash
# Using pip
pip install pycoverm

# Using conda/mamba
mamba install -c conda-forge -c bioconda pycoverm
```

## Core Functions

### 1. Validating BAM Files
Before computing coverage, ensure the BAM file is coordinate-sorted. `pycoverm` provides a utility for this check:

```python
import pycoverm

is_sorted = pycoverm.is_bam_sorted("sample.bam")
if not is_sorted:
    print("BAM file must be coordinate-sorted.")
```

### 2. Estimating Coverage
The primary function `get_coverages_from_bam` processes a list of BAM files and returns a tuple containing contig names and a coverage matrix.

```python
import pycoverm

bam_files = ["sample1.bam", "sample2.bam"]
contig_names, coverage_matrix = pycoverm.get_coverages_from_bam(
    bam_files,
    threads=8,
    min_identity=0.95
)

# coverage_matrix is a NumPy array where:
# Rows = Contigs
# Columns = BAM files (samples)
```

## Expert Tips and Parameters

### Filtering and Quality Control
*   **`min_identity`**: Default is `0.97`. Adjust this to be more or less stringent regarding read mapping quality.
*   **`contig_end_exclusion`**: Default is `75`. This excludes bases at the ends of contigs to avoid edge-effect biases where mapping is often less reliable.
*   **Trimmed Means**: Use `trim_lower` and `trim_upper` (fractions between 0.0 and 1.0) to calculate trimmed mean coverages, which helps mitigate the impact of outliers or highly non-uniform coverage.

### Performance Optimization
*   **Multi-threading**: Always set the `threads` parameter when processing large BAM files or multiple samples to utilize parallel processing.
*   **Selective Calculation**: If you only need coverage for specific contigs, pass a Python `set` of names to the `contig_set` parameter. This significantly reduces memory usage and computation time.

### Data Handling
*   The output matrix is a `float32` NumPy array.
*   Ensure all BAM files in the `bam_list` are mapped to the same reference genome/assembly; otherwise, the results will be inconsistent or the function may fail.

## Reference documentation
- [pycoverm GitHub Repository](./references/github_com_apcamargo_pycoverm.md)
- [pycoverm Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pycoverm_overview.md)