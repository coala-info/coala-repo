---
name: turbocor
description: Turbocor calculates correlation matrices for very large datasets. Use when user asks to calculate correlation matrices, perform high-dimensional correlation computations, or correlate variables in large genomic or feature datasets.
homepage: https://github.com/dcjones/turbocor
---


# turbocor

## Overview
Turbocor is a specialized utility optimized for the heavy lifting of correlation matrix calculations. While standard libraries (like NumPy or Pandas) can struggle with the memory overhead and processing time required for "very large" matrices, turbocor is built to handle these high-dimensional computations from the command line. It is particularly useful for researchers working with genomic data or large-scale feature sets where every variable needs to be correlated against every other variable.

## Usage Guidelines

### Installation
The tool is primarily distributed via Bioconda. Ensure your environment is configured with the bioconda channel:
```bash
conda install -c bioconda turbocor
```

### Core Workflow
1. **Data Preparation**: Ensure your input data is in a structured format (typically tab-delimited or CSV) where rows and columns represent the variables you wish to correlate.
2. **Execution**: Run the tool directly from the terminal. Because it is designed for "very large" matrices, ensure you have sufficient disk space for the output matrix, as these files can grow quadratically relative to the number of input features.
3. **Output**: The tool generates a correlation matrix that can be used for downstream clustering, network analysis, or dimensionality reduction.

### Best Practices
- **Resource Management**: When dealing with extremely large datasets, monitor CPU and memory usage. Turbocor is optimized, but the sheer scale of "very large" matrices may still require significant hardware resources.
- **Input Validation**: Verify that your input data does not contain non-numeric values or excessive missing data, as these can impact the mathematical validity of the correlation coefficients.

## Reference documentation
- [turbocor Overview](./references/anaconda_org_channels_bioconda_packages_turbocor_overview.md)