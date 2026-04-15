---
name: bioconductor-biomformat
description: This tool provides an R interface for reading, writing, and manipulating Biological Observation Matrix (BIOM) files. Use when user asks to read or write BIOM files, access sample and observation metadata, or convert BIOM data into R matrices for microbiome analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/biomformat.html
---

# bioconductor-biomformat

name: bioconductor-biomformat
description: Interface for the Biological Observation Matrix (BIOM) format in R. Use this skill when you need to read, write, or manipulate BIOM files, which are standard for representing biological sample-by-observation contingency tables (e.g., OTU tables from microbiome studies).

## Overview

The `biomformat` package provides a specialized R interface for the BIOM file format. It is primarily an I/O-oriented utility designed to bridge BIOM files with R's data structures like matrices and data frames. While it does not provide complex statistical analysis (which is often handled by the `phyloseq` package), it offers essential accessor functions to extract observation data, sample metadata, and observation metadata.

## Core Workflow

### 1. Loading the Package
```r
library(biomformat)
```

### 2. Reading BIOM Files
Use `read_biom()` to import a BIOM file. The function automatically handles different BIOM types (dense/sparse, rich/minimal).
```r
biom_file <- "path/to/your_file.biom"
x <- read_biom(biom_file)

# View a summary of the object
print(x)
```

### 3. Accessing Data
The package uses specific accessor functions to retrieve components of the BIOM object:

*   **Observation Data (The Matrix):** Use `biom_data(x)` to get the contingency table. This often returns a sparse matrix (from the `Matrix` package).
    *   To convert to a standard R matrix: `as(biom_data(x), "matrix")`
*   **Sample Metadata:** Use `sample_metadata(x)` to get a data frame of sample properties.
*   **Observation Metadata:** Use `observation_metadata(x)` to get metadata for the units being counted (e.g., taxonomy).

### 4. Writing BIOM Files
Export a biom object back to a file using `write_biom()`.
```r
outfile <- "output_file.biom"
write_biom(x, outfile)
```

## Common Operations and Tips

*   **Coercion for Analysis:** Many standard R functions (like `heatmap` or `boxplot`) require standard matrices or vectors. Use `as(biom_data(x), "matrix")` or `as(biom_data(x), "vector")` to prepare data for these functions.
*   **Checking for Metadata:** Metadata functions return `NULL` if the metadata is not present in the BIOM file. Always check for `NULL` before attempting to subset metadata.
*   **Integration with Phyloseq:** If you need advanced microbiome analysis (alpha/beta diversity, ordination), the objects created by `biomformat` are designed to be easily imported into the `phyloseq` package.
*   **Sparse vs. Dense:** The package preserves the sparsity of the original file. Sparse matrices are more memory-efficient for large microbiome datasets.

## Reference documentation

- [The biomformat package vignette](./references/biomformat.Rmd)
- [The biomformat package vignette (Markdown)](./references/biomformat.md)