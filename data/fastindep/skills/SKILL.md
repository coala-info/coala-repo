---
name: fastindep
description: This tool identifies genetically unrelated individuals and markers using a fast heuristic algorithm. Use when user asks to select a subset of individuals that are not closely related or to identify a set of markers that are largely independent.
homepage: https://github.com/endrebak/fastindep
metadata:
  docker_image: "quay.io/biocontainers/fastindep:1.0.0--h9948957_7"
---

# fastindep

yaml
name: fastindep
description: A fast heuristic algorithm for identifying large sets of genetically unrelated individuals and unrelated markers. Use when analyzing population genetics data to select a subset of individuals that are not closely related, or to identify a set of markers that are largely independent.
```
## Overview
The `fastindep` tool is designed to efficiently identify a set of individuals or markers that are genetically unrelated. This is particularly useful in population genetics and genomics research where you need to select a representative, non-redundant sample from a larger dataset. It employs a heuristic algorithm to achieve this efficiently, making it suitable for large datasets.

## Usage Instructions

### Installation

To install `fastindep`, use conda:

```bash
conda install -c bioconda fastindep
```

### Basic Usage

The primary function of `fastindep` is to take an input file (typically a genotype or marker relationship matrix) and output a list of indices representing an independent set.

The general command structure is:

```bash
fastindep [options] <input_file>
```

### Input File Formats

`fastindep` expects input files that represent relationships between individuals or markers. While the exact format can vary, common inputs include:

*   **Marker relationship matrices**: These files describe the pairwise relationships between genetic markers.
*   **Individual relationship matrices**: These files describe the pairwise relationships between individuals.

The specific format details (e.g., delimiter, header presence) might depend on the version or how the tool is compiled, but it generally expects numerical data representing relationships.

### Key Options

While the provided documentation does not detail specific command-line options, typical usage would involve specifying the input file. For advanced use or specific filtering criteria, consult the tool's documentation or source code if available.

### Expert Tips

*   **Data Preparation**: Ensure your input data is clean and correctly formatted. Incorrectly formatted input can lead to errors or unexpected results.
*   **Large Datasets**: `fastindep` is designed for speed. For very large datasets, consider the memory and CPU resources available on your system.
*   **Interpretation of Output**: The output is a list of indices. These indices correspond to the rows/columns in your input file. You will need to map these indices back to your original sample or marker identifiers.

## Reference documentation
- [Overview](https://anaconda.org/bioconda/fastindep)
- [GitHub Repository](https://github.com/endrebak/fastindep)