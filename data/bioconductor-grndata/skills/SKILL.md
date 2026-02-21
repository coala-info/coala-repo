---
name: bioconductor-grndata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/grndata.html
---

# bioconductor-grndata

## Overview
The `grndata` package is a Bioconductor experiment data package providing five large-scale, noise-free synthetic gene expression datasets. These datasets are designed for testing and benchmarking Gene Regulatory Network (GRN) inference algorithms. The data includes simulations from three distinct sources: GeneNetWeaver (GNW), SynTReN, and the Rogers power-law generator.

## Loading the Data
The package uses the standard R data loading mechanism. Once the library is loaded, you can call `data()` on the specific dataset names.

```r
library(grndata)

# List available datasets in the package
data(package = "grndata")

# Load a specific dataset (e.g., GNW2000)
data(gnw2000)

# The data is typically loaded as a list containing 'ldat' (expression) and 'net' (topology)
# Access the expression matrix
expression_matrix <- gnw2000$ldat

# Access the gold standard adjacency matrix
gold_standard <- gnw2000$net
```

## Available Datasets
The package provides five primary datasources. Each contains a gene expression matrix and the underlying network structure:

| Dataset Name | Simulator | Genes | Experiments | Topology |
| :--- | :--- | :--- | :--- | :--- |
| `rogers1000` | Rogers | 1000 | 1000 | Power-law tail |
| `syntren300` | SynTReN | 300 | 800 | E. coli sub-network |
| `syntren1000` | SynTReN | 1000 | 1000 | E. coli sub-network |
| `gnw1565` | GNW | 1565 | 1565 | E. coli |
| `gnw2000` | GNW | 2000 | 2000 | Yeast |

## Typical Workflow
1. **Load Data**: Select a dataset based on the desired complexity (number of genes/experiments) or biological topology (E. coli vs. Yeast).
2. **Pre-processing**: Since the data is noise-free, users often add stochastic noise (e.g., Gaussian noise) to simulate realistic experimental conditions before running inference.
3. **Inference**: Apply a GRN inference algorithm (e.g., CLR, ARACNe, or MRNET) to the expression matrix.
4. **Validation**: Compare the inferred network against the provided gold-standard adjacency matrix (`net`) using metrics like AUPRC or AUROC.

## Usage Tips
- **Data Structure**: Datasets are stored as lists. `ldat` is the expression data (rows = experiments, columns = genes), and `net` is the true regulatory network (adjacency matrix).
- **Reproducibility**: Because the base data is noise-free and deterministic, it provides a perfectly reproducible baseline for benchmarking.
- **Multifactorial Data**: Note that the GNW and SynTReN datasets represent multifactorial simulations, which are generally considered less informative than knockout/knockdown data, providing a more challenging inference task.

## Reference documentation
- [GRNdata Overview](./references/grndata.md)