---
name: bioconductor-dapardata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/DAPARdata.html
---

# bioconductor-dapardata

name: bioconductor-dapardata
description: Accessing and using proteomics benchmark datasets from the DAPARdata package. Use when needing example MSnSet objects for differential protein abundance analysis, specifically those formatted for DAPAR and Prostar workflows.

# bioconductor-dapardata

## Overview
DAPARdata is a Bioconductor experiment data package that provides a collection of proteomics datasets. These datasets are primarily used as benchmarks or examples for the DAPAR (Differential Analysis of Protein Abundance with R) and Prostar (software for proteomics) ecosystem. The data typically consists of LC-MS/MS experiments stored as `MSnSet` objects, containing peptide-level or protein-level quantitative data and associated metadata.

## Installation and Loading
To use the datasets in an R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DAPARdata")

library(DAPARdata)
```

## Typical Workflow

### 1. List Available Datasets
To see all datasets bundled with the package:
```r
utils::data(package = "DAPARdata")
```

### 2. Load a Specific Dataset
Datasets are loaded into the global environment using the `data()` function. Common datasets include `Exp1_R25_pept` (peptide level) and `Exp1_R25_prot` (protein level).

```r
# Load a peptide-level dataset
data(Exp1_R25_pept)

# Inspect the object
Exp1_R25_pept
```

### 3. Explore the MSnSet Object
Since the data is stored in `MSnSet` format (from the `MSnbase` package), you can use standard accessors:

```r
# Access quantitative data (expression matrix)
exprs(Exp1_R25_pept)[1:5, 1:3]

# Access feature metadata (e.g., protein IDs, sequences)
fData(Exp1_R25_pept)[1:5, ]

# Access sample metadata (e.g., conditions, replicates)
pData(Exp1_R25_pept)
```

## Key Datasets
*   **Exp1_R25**: A controlled mixture of human proteins (UPS1) spiked into a yeast background at different concentrations. Available at both peptide (`Exp1_R25_pept`) and protein (`Exp1_R25_prot`) levels.
*   **Exp1_TF4L**: Another spike-in dataset used for benchmarking normalization and differential analysis methods.
*   **UPS1**: Datasets involving the Universal Proteomics Standard.

## Usage Tips
*   **DAPAR Compatibility**: These datasets are specifically structured to be compatible with `DAPAR` functions. If you are testing a new proteomics algorithm, these serve as excellent gold-standard benchmarks.
*   **Missing Values**: Many of these datasets contain missing values (NA), reflecting real-world LC-MS/MS data, making them ideal for testing imputation strategies.
*   **Experimental Design**: Always check `pData(object)` to understand the experimental groups (e.g., "Condition" or "Group" columns) before performing differential analysis.

## Reference documentation
- [DAPARdata](./references/dapardata.md)