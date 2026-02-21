---
name: bioconductor-ccdata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ccdata.html
---

# bioconductor-ccdata

name: bioconductor-ccdata
description: Access and utilize gene expression data from Connectivity Map (CMap) build 02 and LINCS L1000 for drug discovery and combination connectivity mapping. Use this skill when you need to load moderated effect sizes, variances, or pre-trained models (Neural Networks and XGBoost) required by the 'ccmap' package to mimic or reverse gene expression signatures.

## Overview

The `ccdata` package is a specialized data experiment package for Bioconductor. It serves as the data backbone for the `ccmap` package, providing processed microarray gene expression data and pre-trained machine learning models. The data includes unbiased effect sizes and variances for thousands of drugs and perturbagens, enabling the identification of compounds that can modulate specific gene expression signatures.

## Loading Data Resources

The package primarily consists of datasets that must be loaded into the R environment using the `data()` function.

### Connectivity Map (CMap) Build 02
Contains data for 1,309 drugs.
- `data(cmap_es)`: Loads a matrix of moderated unbiased effect sizes (13,832 genes x 1,309 drugs).
- `data(cmap_var)`: Loads a matrix of variances for the effect sizes.

### LINCS L1000
Contains data for 230,829 signatures.
- `data(l1000_es)`: Loads a matrix of moderated unbiased effect sizes (1,001 genes x 230,829 perturbagens).

### Gene Metadata
- `data(genes)`: Loads a character vector of 11,525 HGNC symbols. This defines the required order for inputs and outputs when using the neural network models.

## Machine Learning Models

The package includes pre-trained models used to predict the effects of drug combinations.

- `net1` and `net2`: Neural network models containing weight matrices (`W1`, `W2`) and bias vectors (`b1`, `b2`).
- `xgb_mod`: An XGBoost booster object that stacks predictions from `net1` and `net2` with CMap effect sizes and variances.

## Typical Workflow

1. **Load the Library**:
   ```r
   library(ccdata)
   ```

2. **Access Specific Data**:
   To find the effect size of a specific drug in CMap:
   ```r
   data(cmap_es)
   # View effect sizes for the first 5 drugs across the first 5 genes
   cmap_es[1:5, 1:5]
   ```

3. **Prepare for ccmap**:
   The `ccmap` package will automatically look for these objects, but you can inspect them manually to ensure gene symbols match your query signature:
   ```r
   data(genes)
   # Check if your signature genes are present in the model's gene set
   my_genes <- c("TP53", "BRCA1")
   intersect(my_genes, genes)
   ```

## Tips
- **Memory Management**: The `l1000_es` matrix is large (over 230,000 columns). Ensure your R session has sufficient RAM before loading.
- **Gene Symbols**: The package uses HGNC symbols. If your data uses Entrez IDs or Ensembl IDs, convert them to HGNC symbols before attempting to match with `cmap_es` or `genes`.
- **Integration**: This package is rarely used in isolation; it is designed to be the data source for `ccmap::ccmap()`.

## Reference documentation
- [ccdata Reference Manual](./references/reference_manual.md)