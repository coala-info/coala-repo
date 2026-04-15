---
name: bioconductor-yeastgsdata
description: This package provides access to curated gold standard protein-protein interaction datasets for Saccharomyces cerevisiae. Use when user asks to load yeast reference sets, access positive or negative gold standard interactions, or benchmark protein interaction predictions using MIPS or Bayes factor-derived data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/yeastGSData.html
---

# bioconductor-yeastgsdata

name: bioconductor-yeastgsdata
description: Access and utilize gold standard yeast (Saccharomyces cerevisiae) protein interaction datasets. Use this skill when you need to load curated reference sets for protein-protein interactions (PPI), including positive and negative gold standards, MIPS complexes, and Bayes factor-derived interaction sets for benchmarking or network analysis.

## Overview

The `yeastGSData` package is a Bioconductor experiment data package providing a collection of "gold standard" datasets for yeast. These datasets are primarily used as reference sets to evaluate the performance of high-throughput interaction assays or computational prediction methods. It includes binary interactions, protein complexes, and negative interaction sets (pairs unlikely to interact).

## Loading the Package and Data

To use the datasets, first load the library and then use the `data()` function to load specific objects into your R environment.

```r
library(yeastGSData)

# List all available datasets in the package
data(package = "yeastGSData")
```

## Key Datasets

### Positive Reference Sets (Interactions)
*   **`BinaryGS`**: 1,318 binary interactions reported by Yu et al. (2008).
*   **`PRS`**: The "Positive Reference Set" (188 binary interactions) curated by Yu et al. (2008).
*   **`POSPS`**: A "Platinum Standard" set of 1,867 well-established binary physical interactions.
*   **`MIPSGS`**: 8,617 pairwise interactions derived from MIPS protein complexes.
*   **`BayesFactorPGS`**: 10,200 binary interactions with a Bayes factor > 3.

### Negative Reference Sets (Non-interactions)
*   **`NEGGS`**: A large set (2,708,746 pairs) of negative interactions based on proteins being in different cellular locations.
*   **`BayesFactorNGS`**: 7,739 binary interactions with a Bayes factor < -3.

### Comprehensive Interaction Resources
*   **`Mpact`**: A large matrix of protein interactions from the MIPS MPACT database.
*   **`MpactEvidenceCodes`**: Descriptions for the evidence codes used in the `Mpact` dataset.

## Typical Workflows

### Benchmarking an Interaction Set
If you have a list of predicted interactions, you can calculate the overlap with a gold standard to estimate sensitivity or precision.

```r
data(BinaryGS)
# Assuming 'my_predictions' is a data frame with ORF1 and ORF2
# Find predictions that are in the Gold Standard
hits <- merge(my_predictions, BinaryGS, by = c("ORF1", "ORF2"))
```

### Filtering MPACT by Evidence
The `Mpact` dataset contains evidence codes. You can use `MpactEvidenceCodes` to understand the basis of an interaction and filter out specific experiment types (e.g., to avoid circularity if you are analyzing data from one of those experiments).

```r
data(Mpact)
data(MpactEvidenceCodes)

# View first few interactions and their evidence codes
head(Mpact)

# Example: Find the description for a specific code
MpactEvidenceCodes["901.01"]
```

## Usage Tips
*   **Identifier Consistency**: Most datasets use Systematic Names (ORFs) like `YAL001C`. Ensure your input data uses the same format before merging or comparing.
*   **Data Structures**: Most objects are `data.frame` or `matrix`. Use `str()` to check the column names (e.g., some use `ORF1/ORF2`, others use `Orf1/Orf2`).
*   **Negative Set Size**: The `NEGGS` dataset is very large (~2.7 million rows). Be mindful of memory when performing joins or heavy computations on this object.

## Reference documentation
- [Yeast Gold Standard Data Reference Manual](./references/reference_manual.md)