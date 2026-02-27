---
name: bioconductor-qubicdata
description: This package provides access to standardized E. coli gene expression data and weight matrices from the Many Microbe Microarrays Database. Use when user asks to load E. coli transcriptomic datasets, perform biclustering benchmarks, or conduct gene regulatory network analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/QUBICdata.html
---


# bioconductor-qubicdata

name: bioconductor-qubicdata
description: Access and load E. coli gene expression data and weight matrices from the Many Microbe Microarrays Database (M3D). Use this skill when a user needs to perform biclustering benchmarks, gene regulatory network analysis, or data mining on standardized E. coli transcriptomic datasets provided by the QUBICdata package.

## Overview
The `QUBICdata` package is a Bioconductor ExperimentData package providing high-quality gene expression data for *Escherichia coli*. This data is sourced from the Many Microbe Microarrays Database (M3D) and is specifically formatted for use with biclustering algorithms like QUBIC. It includes both the expression matrix and a pre-calculated weight matrix.

## Data Loading and Usage
The package contains two primary datasets. Load them using the standard `data()` function after loading the library.

```r
# Load the package
library(QUBICdata)

# Load the E. coli expression dataset
# This is a matrix of gene expression levels
data("ecoli")

# Load the E. coli weight matrix
# This is typically used for weighted biclustering or network inference
data("ecoli.weight")
```

### Data Structures
- `ecoli`: A numeric matrix where rows represent genes and columns represent experimental conditions/samples.
- `ecoli.weight`: A numeric matrix representing the weights associated with the E. coli dataset, often used to prioritize specific gene-condition pairs in mining algorithms.

## Typical Workflow
1. **Initialization**: Load the `QUBICdata` package to access the stored experiment data.
2. **Data Retrieval**: Use `data("ecoli")` to bring the matrix into the global environment.
3. **Preprocessing**: Inspect the dimensions using `dim(ecoli)` and check for missing values.
4. **Analysis**: Pass the `ecoli` matrix into biclustering packages (such as `QUBIC` or `biclust`) or differential expression pipelines.

## Tips
- The data is already normalized according to the M3D pipeline (Faith et al., 2008), making it suitable for immediate computational analysis.
- Use `head(ecoli)` to view the gene identifiers (rows) and sample identifiers (columns).

## Reference documentation
- [QUBIC Data Tutorial (RMarkdown)](./references/qubic_data_vignette.Rmd)
- [QUBIC Data Tutorial (Markdown)](./references/qubic_data_vignette.md)