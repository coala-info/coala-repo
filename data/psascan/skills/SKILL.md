---
name: psascan
description: psascan is a parallel external memory tool designed to construct suffix arrays for datasets that exceed available system memory. Use when user asks to construct suffix arrays, perform external memory suffix array construction, or process large-scale genomic data with limited RAM.
homepage: https://www.cs.helsinki.fi/group/pads/pSAscan.html
metadata:
  docker_image: "quay.io/biocontainers/psascan:0.1.0--h9948957_5"
---

# psascan

## Overview
psascan is a specialized C++ tool designed for constructing suffix arrays when the input data is significantly larger than the system's physical memory. It utilizes a "divide and conquer" approach by building suffix arrays for smaller text blocks and merging them into a final global suffix array. This tool is particularly effective for high-throughput bioinformatics workflows where memory efficiency and disk-space management are critical.

## Usage Guidelines

### Basic Execution
The tool is typically invoked via the command line. While specific flags can vary by version, the core logic requires an input file and a specified amount of RAM to utilize.

```bash
psascan [options] <input_file>
```

### Performance Optimization
*   **RAM Allocation**: psascan is designed to fully utilize available RAM to speed up computation. Increasing the memory limit significantly reduces the number of disk-based merge passes. For example, increasing RAM from 3.5GiB to 120GiB can reduce processing time for a 200GiB file from 170 hours to under 12 hours.
*   **Disk Space Requirements**: Ensure you have at least 7.2x the size of the input file in free disk space. This includes the input text, temporary block files, and the final output suffix array.
*   **Parallelization**: The algorithm is natively parallel. Ensure your environment allows for multi-threading to take advantage of the block-sorting phase.

### Best Practices
*   **Input Preparation**: Ensure the input file is a flat text or genomic sequence file.
*   **External Memory Management**: Use fast I/O storage (like SSDs or NVMe drives) for the temporary directory to minimize the bottleneck during the external memory merging phase.
*   **Large Scale Processing**: For datasets approaching 1TiB, expect a runtime of approximately one week on high-end hardware with 120GiB of RAM.

## Reference documentation
- [Parallel external memory suffix array construction](./references/www_cs_helsinki_fi_group_pads_pSAscan.html.md)
- [psascan Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_psascan_overview.md)