---
name: sincei
description: sincei is a command-line toolkit for processing and analyzing single-cell epigenomic data from BAM files. Use when user asks to generate signal tracks, filter barcodes, perform quality control on count matrices, or conduct dimensionality reduction for single-cell chromatin accessibility and histone marks.
homepage: https://github.com/bhardwaj-lab/sincei
metadata:
  docker_image: "quay.io/biocontainers/sincei:0.5.2--pyhdfd78af_0"
---

# sincei

## Overview
sincei is a specialized command-line toolkit designed to handle the unique challenges of single-cell epigenomic data. It allows researchers to transform raw BAM files into interpretable signal tracks, count matrices, and clusters. By providing tools for both read-level and count-level quality control, sincei ensures that downstream analyses—such as dimensionality reduction for chromatin accessibility or histone marks—are based on high-quality cellular data.

## Installation
The recommended method is via bioconda:
```bash
conda create -n sincei -c bioconda -c conda-forge sincei
conda activate sincei
```

## Core CLI Usage
All sincei tools are prefixed with `sc`. You can view the full list of available tools by running:
```bash
sincei --help
```

### Common Tool Patterns
- **scBulkCoverage**: Aggregates signal from single cells into group-specific coverage files (bigWigs).
  ```bash
  scBulkCoverage -b input.bam -g group_info.txt -o output_prefix
  ```
- **scFilterBarcodes**: Used to clean datasets by removing low-quality barcodes based on custom metrics.
- **scCountQC**: Generates quality control metrics for count matrices to identify outliers or failed libraries.
- **scDimensionalityReduction**: Performs PCA or other reduction techniques specifically tuned for sparse single-cell epigenomic features.

## Best Practices and Tips
- **Input Preparation**: Ensure your BAM files are indexed (`samtools index`). sincei relies on rapid access to genomic coordinates.
- **Group Information**: When using tools like `scBulkCoverage`, the group info file (`-g`) should typically be a tab-separated file mapping barcodes to clusters or sample IDs.
- **Memory Management**: Single-cell datasets can be massive. When processing large BAM files, monitor your peak memory usage; you may need to adjust bin sizes or feature sets to stay within system limits.
- **Feature Selection**: For epigenomic data, aggregating signal into bins (e.g., 500bp) is often a more robust starting point than using gene bodies alone, especially for non-coding regulatory analysis.

## Reference documentation
- [github_com_bhardwaj-lab_sincei.md](./references/github_com_bhardwaj-lab_sincei.md)
- [anaconda_org_channels_bioconda_packages_sincei_overview.md](./references/anaconda_org_channels_bioconda_packages_sincei_overview.md)