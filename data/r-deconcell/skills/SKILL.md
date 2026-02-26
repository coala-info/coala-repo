---
name: r-deconcell
description: This tool estimates cell subpopulation proportions from bulk molecular profiling data using the DeconCell statistical framework. Use when user asks to perform cell type deconvolution, estimate cell counts from expression or methylation data, or adjust for cell-type composition in heterogeneous samples.
homepage: https://cran.r-project.org/web/packages/deconcell/index.html
---


# r-deconcell

name: r-deconcell
description: Statistical framework for estimating cell counts from molecular profiling data (expression or methylation) using the DeconCell method. Use this skill when you need to perform cell type deconvolution on bulk transcriptomic or epigenetic data in R to estimate cell subpopulation proportions.

## Overview

The `deconcell` package implements the DeconCell framework, part of the Decon2 system. It allows researchers to estimate cell counts from heterogeneous samples by leveraging pre-trained models or custom reference data. This is particularly useful for adjusting for cell-type composition in differential expression or eQTL studies.

## Installation

To install the package from CRAN:

```R
install.packages("deconcell")
```

To install the development version from GitHub:

```R
# install.packages("devtools")
devtools::install_github("molgenis/systemsgenetics/Decon2/DeconCell")
```

## Core Workflow

### 1. Prepare Data
Ensure your expression or methylation data is in a matrix or data frame format where rows represent features (genes/probes) and columns represent samples.

### 2. Load Reference Models
DeconCell relies on models trained on specific datasets (e.g., LLDeep). You must load these models before deconvolution.

```R
library(deconcell)

# Load the pre-trained models (usually provided as an RData file or via a helper function)
# data("models") 
```

### 3. Perform Deconvolution
Use the main deconvolution function to predict cell proportions.

```R
# Example deconvolution call
# predictions <- deconvolution(data = your_expression_matrix, model = loaded_model)
```

## Key Functions

- `DeconCell()`: The primary function for executing the deconvolution algorithm on a bulk dataset.
- `getModels()`: Utility to retrieve or specify the training models used for prediction.

## Tips for Success

- **Gene Identifiers**: Ensure the gene symbols or IDs in your bulk data match the identifiers used in the training models (typically HGNC symbols).
- **Normalization**: Input data should be appropriately normalized (e.g., TMM, CPM, or FPKM for RNA-seq) before running deconvolution.
- **Heterogeneity**: DeconCell is specifically designed for heterogeneous samples like whole blood; ensure your reference model is biologically appropriate for your sample source.

## Reference documentation

- [GitHub Articles](./references/articles.md)
- [DeconCell Home Page](./references/home_page.md)
- [SystemsGenetics Wiki](./references/wiki.md)