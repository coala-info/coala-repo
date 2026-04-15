---
name: bioconductor-methylclockdata
description: This package provides public datasets and coefficients for estimating DNA methylation age using various epigenetic and gestational clocks. Use when user asks to retrieve clock coefficients, access reference CpG lists, or load data for estimating biological and chronological age.
homepage: https://bioconductor.org/packages/release/data/experiment/html/methylclockData.html
---

# bioconductor-methylclockdata

name: bioconductor-methylclockdata
description: Access public datasets and clock coefficients for estimating DNA methylation (DNAm) age. Use when needing coefficients for epigenetic clocks (Horvath, Hannum, Levine, etc.) or gestational age clocks (Knight, Lee, etc.) to be used with the methylclock package.

# bioconductor-methylclockdata

## Overview

The `methylclockData` package serves as a data repository for the `methylclock` package. It provides the necessary coefficients, CpG lists, and reference datasets required to estimate chronological, gestational, and biological DNA methylation (DNAm) age. The package includes data for well-known clocks such as Horvath's, Hannum's, and Levine's (PhenoAge), as well as specialized clocks for placental and buccal samples.

## Installation

Install the package using `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("methylclockData")
```

## Loading Data via ExperimentHub

The package data is primarily hosted on `ExperimentHub`. You can query and retrieve specific records using the following workflow:

```r
library(ExperimentHub)
library(methylclockData)

# Initialize ExperimentHub
eh <- ExperimentHub()

# Query for methylclockData records
pData <- query(eh, "methylclockData")

# View available records
df <- mcols(pData)
print(df)

# Retrieve a specific record (e.g., Horvath's clock coefficients)
horvath_coefs <- pData[["EH6071"]]
```

## Direct Access Functions

The package provides convenient wrapper functions to access specific clock coefficients and CpG lists without manually searching `ExperimentHub`.

### Chronological Age Clocks (Years)

Use these functions to retrieve coefficients for clocks predicting chronological age:

*   **Horvath's Clock (353 CpGs):** `get_coefHorvath()`
*   **Hannum's Clock (71 CpGs):** `get_coefHannum()`
*   **Horvath's Skin+Blood Clock (391 CpGs):** `get_coefSkin()`
*   **PedBE Clock (Buccal samples, 0-20 years):** `get_coefPedBE()`
*   **Wu's Clock (Children):** `get_coefWu()`
*   **BLUP and EN Clocks (Blood/Saliva):** `get_coefBLUP()` or `get_coefEN()`
*   **Bayesian Neural Network (BNN):** `get_cpgs_bn()` (retrieves CpGs used for training)

### Gestational Age Clocks (Weeks)

Use these functions for predicting gestational age from cord blood or placenta:

*   **Knight's Clock:** `get_coefKnightGA()`
*   **Lee's Placental Clocks (RPC, CPC, Refined RPC):** `get_coefLeeGA()`
*   **Bohlin's Clock:** `get_coefBohlinGA()` (available via ExperimentHub EH6069)
*   **Mayne's Clock:** `get_coefMayneGA()`
*   **EPIC-based Gestational Clock:** `get_coefEPIC()`

### Biological Age Clocks

Use these functions for biomarkers of biological aging:

*   **Levine's Clock (PhenoAge):** `get_coefLevine()`
*   **Telomere Length (TL) Clock:** `get_coefTL()`

## Typical Workflow

1.  **Load the library:** `library(methylclockData)`
2.  **Retrieve coefficients:** Select the appropriate function based on the target tissue and clock (e.g., `coefs <- get_coefHorvath()`).
3.  **Inspect data:** Check the `CpGmarker` and `CoefficientTraining` columns to ensure they match your methylation data requirements.
4.  **Pass to methylclock:** Use these coefficients as input for the estimation functions in the `methylclock` package.

## Reference documentation

- [References for metilclock using Bioconductor's ExperimentHub](./references/methylcockData.Rmd)
- [References for metilclock using Bioconductor's ExperimentHub (Markdown)](./references/methylcockData.md)