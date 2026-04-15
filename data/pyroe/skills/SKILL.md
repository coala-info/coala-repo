---
name: pyroe
description: Pyroe is a Python toolkit that streamlines single-cell RNA-sequencing analysis by integrating with alevin-fry. Use when user asks to quantify gene expression from alevin-fry output or perform downstream scRNA-seq analysis.
homepage: https://github.com/COMBINE-lab/pyroe
metadata:
  docker_image: "quay.io/biocontainers/pyroe:0.9.3--pyhdfd78af_0"
---

# pyroe

---
## Overview

The `pyroe` package is a Python toolkit designed to streamline single-cell RNA-sequencing (scRNA-seq) analysis workflows, specifically by leveraging the capabilities of `alevin-fry`. It provides functions to facilitate the processing and analysis of scRNA-seq data, making it easier to derive insights from complex biological datasets. This tool is particularly useful for researchers working with `alevin-fry` outputs and looking for integrated Python-based solutions for their analysis pipelines.

## Usage

`pyroe` is primarily used as a Python library within your analysis scripts. While it integrates with `alevin-fry`, its direct command-line interface (CLI) usage is not extensively documented in the provided materials. The core functionality is accessed through Python functions.

### Core Functionality

The primary purpose of `pyroe` is to provide Python functions that wrap or complement `alevin-fry`'s capabilities for scRNA-seq data analysis. This includes tasks such as:

*   **Data Quantification**: Processing raw sequencing data to quantify gene or transcript expression levels.
*   **Downstream Analysis**: Performing various analytical steps on the quantified data, such as differential gene expression, dimensionality reduction, and clustering.
*   **Workflow Integration**: Seamlessly integrating with other bioinformatics tools and libraries within a Python environment.

### Example Usage (Conceptual)

While specific CLI commands for `pyroe` are not detailed, its usage within a Python script would typically involve importing the library and calling its functions. For instance, you might use `pyroe` to load `alevin-fry` output files and then perform further analysis.

```python
# Example of how pyroe might be used in a Python script
import pyroe

# Load data processed by alevin-fry
# (Specific function names and parameters would be detailed in pyroe's documentation)
quant_data = pyroe.load_alevin_fry_output("path/to/alevin_fry_output")

# Perform downstream analysis
# (Again, specific functions would be used here)
gene_expression_matrix = pyroe.get_gene_expression(quant_data)
pca_results = pyroe.perform_pca(gene_expression_matrix)

# Further analysis or visualization...
```

### Installation

To install `pyroe`, use conda:

```bash
conda install bioconda::pyroe
```



## Subcommands

| Command | Description |
|---------|-------------|
| pyroe | pyroe: error: argument command: invalid choice: 'Make' (choose from 'make-spliced+intronic', 'make-splici', 'make-spliced+unspliced', 'make-spliceu', 'fetch-quant', 'id-to-name', 'convert') |
| pyroe | pyroe: error: argument command: invalid choice: 'additional' (choose from 'make-spliced+intronic', 'make-splici', 'make-spliced+unspliced', 'make-spliceu', 'fetch-quant', 'id-to-name', 'convert') |
| pyroe | pyroe: error: argument command: invalid choice: 'valid' (choose from 'make-spliced+intronic', 'make-splici', 'make-spliced+unspliced', 'make-spliceu', 'fetch-quant', 'id-to-name', 'convert') |
| pyroe fetch-quant | The ids of the datasets to fetch |
| pyroe id-to-name | Converts gene/transcript IDs to names from a GTF/GFF3 file. |
| pyroe_convert | Convert quantification data to various formats. |

## Reference documentation

- [pyroe Overview](references/anaconda_org_channels_bioconda_packages_pyroe_overview.md)
- [pyroe GitHub Repository](references/github_com_COMBINE-lab_pyroe.md)