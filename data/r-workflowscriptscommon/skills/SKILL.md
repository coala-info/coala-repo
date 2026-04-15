---
name: r-workflowscriptscommon
description: This package provides accessory functions and standardized utilities for developing R-based bioinformatics workflow scripts. Use when user asks to parse command-line arguments, handle input/output for Seurat or SingleCellExperiment objects, or manage environment-specific configurations in R pipelines.
homepage: https://cran.r-project.org/web/packages/workflowscriptscommon/index.html
---

# r-workflowscriptscommon

name: r-workflowscriptscommon
description: Accessory functions for R-based single-cell analysis workflows. Use this skill when developing or maintaining R wrapper scripts that require standardized argument parsing, input/output handling for Seurat/SingleCellExperiment objects, and common utility functions for bioinformatics pipelines.

## Overview

The `workflowscriptscommon` package provides a set of utility functions designed to simplify the creation of R wrapper scripts for bioinformatics workflows, particularly in the single-cell RNA-seq domain. It standardizes common tasks such as command-line argument processing, reading and writing various single-cell object formats (Seurat, SingleCellExperiment, Loom, AnnData), and managing environment-specific configurations.

## Installation

To install the package from GitHub:

```R
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
devtools::install_github("ebi-gene-expression-group/workflowscriptscommon")
```

## Main Functions and Workflows

### Argument Parsing
Standardize how scripts receive inputs by using the built-in parsing helpers. This ensures consistency across different steps of a pipeline.

### Single-Cell I/O (Seurat 3/4)
The package provides wrappers to handle complex I/O operations across different versions of Seurat and other formats:
- **Seurat to Loom/AnnData**: Facilitates conversion between R-native objects and exchange formats.
- **SingleCellExperiment Support**: Functions to bridge the gap between Bioconductor objects and Seurat-based workflows.

### Workflow Utilities
- **Environment Management**: Tools to help scripts identify their execution context.
- **Accessory Functions**: Small, reusable logic blocks that prevent code duplication in wrapper scripts.

## Usage Tips

- **Version Compatibility**: When using Seurat 3 I/O methods, ensure `loomR` and `scater` are installed.
- **Loom Versions**: Note that `r-loom` (used by Seurat 3 functions) typically supports Loom files < 3.0. For newer files, use Seurat 4 and `SeuratDisk`.
- **Error Handling**: Use the package's standardized error reporting to ensure that workflow managers (like Nextflow or Snakemake) receive appropriate exit codes and messages.

## Reference documentation

- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)