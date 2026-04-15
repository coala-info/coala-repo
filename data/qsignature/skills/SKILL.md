---
name: qsignature
description: qsignature detects potential sample mix-ups in genetic data using SNP distance measurements. Use when user asks to detect sample mix-ups or check sample identity.
homepage: https://anaconda.org/channels/bioconda/packages/qsignature/overview
metadata:
  docker_image: "quay.io/biocontainers/qsignature:0.1pre--3"
---

# qsignature

yaml
name: qsignature
description: Detects potential sample mix-ups in genetic data using SNP distance measurements. Use when analyzing genetic samples to identify discrepancies or errors in sample identity.
---
## Overview

The qsignature tool is designed to identify potential sample mix-ups in genetic datasets. It achieves this by calculating distance metrics between Single Nucleotide Polymorphisms (SNPs) across different samples. This is particularly useful in genomic research and clinical settings where ensuring sample integrity is paramount.

## Usage Instructions

qsignature is a command-line tool. The primary function involves providing input files and specifying output options.

### Core Command Structure

The basic command structure is as follows:

```bash
qsignature [options] <input_files>
```

### Input Files

qsignature typically accepts genotype data as input. The exact format may vary, but common formats include VCF or similar genotype array outputs. Ensure your input files are correctly formatted and accessible.

### Key Options

While the provided documentation is limited, common options for such tools often include:

*   **Output File**: Specify a file to write the results to.
*   **Distance Metric**: Choose the method for calculating distances between samples (e.g., Euclidean, Manhattan).
*   **SNP Filtering**: Options to filter SNPs based on quality, minor allele frequency, or other criteria.
*   **Sample Filtering**: Options to include or exclude specific samples from the analysis.

**Expert Tip**: Always consult the tool's `--help` or `man` page for the most up-to-date and comprehensive list of options and their specific usage. For example, running `qsignature --help` will provide detailed information on all available parameters.

### Best Practices

*   **Data Quality**: Ensure your input genotype data is of high quality. Low-quality data can lead to inaccurate distance calculations and false positives/negatives for sample mix-ups.
*   **Reference Samples**: If possible, include known, correctly identified reference samples in your analysis to help validate the qsignature results.
*   **Reproducibility**: Document the exact command-line arguments used, including input file paths and versions of qsignature, to ensure reproducibility of your results.

## Reference documentation

- [qsignature Overview](./references/anaconda_org_channels_bioconda_packages_qsignature_overview.md)