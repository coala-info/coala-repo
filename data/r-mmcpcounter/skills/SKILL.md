---
name: r-mmcpcounter
description: The r-mmcpcounter package quantifies 16 immune and stromal cell populations from mouse transcriptomic data to estimate relative cell abundance in heterogeneous tissue samples. Use when user asks to estimate immune cell infiltration, quantify stromal cell populations in mouse samples, or calculate abundance scores from murine expression matrices.
homepage: https://cran.r-project.org/web/packages/mmcpcounter/index.html
---


# r-mmcpcounter

## Overview
The `mmcpcounter` package is the murine version of the Microenvironment Cell Population-counter (MCP-counter). It allows for the robust quantification of 16 immune and stromal cell populations from mouse transcriptomic data. It is designed for heterogeneous tissue samples, such as tumor biopsies, to provide inter-sample comparable scores representing relative cell abundance.

## Installation
To install the package from CRAN:
```R
install.packages("mmcpcounter")
```

To install the development version from GitHub:
```R
# install.packages("devtools")
devtools::install_github("cit-bioinfo/mMCP-counter")
```

## Usage
The primary workflow involves a single function call to estimate cell population scores from an expression matrix.

### Main Function: `mMCPcounter.estimate`
This function calculates the abundance scores for various cell types.

```R
library(mmcpcounter)

# expressionData: A matrix or data frame with genes as rows and samples as columns.
# features: The type of gene identifiers used ("Gene.Symbol", "ENSEMBL.ID", or "Probes").
# genomeVersion: The mouse genome assembly version ("GCRm38" or "GCRm39").

results <- mMCPcounter.estimate(
  expressionData, 
  features = "Gene.Symbol", 
  genomeVersion = "GCRm39"
)
```

### Parameters
- **expressionData**: Numeric matrix or data frame. Ensure data is in non-log scale (linear) for best results, though the method is based on rank-based signatures and is generally robust.
- **features**: 
  - `"Gene.Symbol"`: Standard official gene symbols (default).
  - `"ENSEMBL.ID"`: Ensembl gene identifiers (e.g., ENSMUSG...).
  - `"Probes"`: Microarray probe identifiers.
- **genomeVersion**: 
  - `"GCRm38"`: For older datasets.
  - `"GCRm39"`: For newer datasets (recommended for recent Ensembl/Gencode versions).

### Output
The function returns a matrix where:
- **Rows**: Represent the 16 estimated cell populations (e.g., T cells, CD8 T cells, B cells, NK cells, Monocytes/Macrophages, Granulocytes, Endothelial cells, Fibroblasts, etc.).
- **Columns**: Represent the samples from the input data.
- **Values**: Numerical scores. These scores are comparable across samples within the same dataset but do not represent absolute cell counts or percentages.

## Tips for Success
- **Data Normalization**: While the method is robust, ensure your data is properly normalized (e.g., TPM, FPKM, or RMA) before running the estimation.
- **Species Specificity**: Do not use this package for human data; use the original `MCPcounter` package for human samples.
- **Gene ID Consistency**: Ensure that the `features` argument strictly matches the row names of your `expressionData`. If using Gene Symbols, ensure they follow the mouse convention (e.g., *Cd3e* instead of *CD3E*).

## Reference documentation
- [LICENSE.md](./references/LICENSE.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)