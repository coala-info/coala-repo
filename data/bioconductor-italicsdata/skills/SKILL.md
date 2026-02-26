---
name: bioconductor-italicsdata
description: This package provides pre-computed quartet effects and genomic annotation data for the normalization of Affymetrix GeneChip Mapping 100K and 500K sets. Use when user asks to load quartet effects for SNP array normalization, access genomic annotations for Affymetrix arrays, or provide example data for the ITALICS workflow.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ITALICSData.html
---


# bioconductor-italicsdata

## Overview
The `ITALICSData` package is a specialized Bioconductor ExperimentData package. It contains pre-computed quartet effects and genomic annotation data necessary for the normalization of Affymetrix GeneChip Mapping 100K and 500K sets. These data objects are specifically designed to be used with the `ITALICS` package to correct for biological and technical artifacts in SNP array data.

## Data Loading and Usage
The package primarily consists of datasets that are loaded into the R environment using the `data()` function. These objects are required by the `ITALICS` function to perform its normalization steps.

### Loading Quartet Effects
Quartet effects are pre-computed on normal samples from the HapMap dataset for different Affymetrix array types.

```r
library(ITALICSData)

# Load effects for the 100K set
data(Xba.QuartetEffect)
data(Hind.QuartetEffect)

# Load effects for the 500K set
data(Nsp.QuartetEffect)
data(Sty.QuartetEffect)
```

### Loading Vignette and Example Data
The package provides small example datasets used for demonstrating the ITALICS workflow in its documentation.

```r
# Load example SNP information
data(snpInfo)

# Load example quartet information
data(quartetInfo)
```

## Typical Workflow Integration
In a standard analysis, you do not manually manipulate these objects. Instead, you ensure `ITALICSData` is installed so that the `ITALICS` package can access these resources during the normalization of `.CEL` files.

1. **Installation**: Ensure the data package is available.
   `BiocManager::install("ITALICSData")`
2. **Normalization**: When calling the main `ITALICS` function from the `ITALICS` library, these data objects are used internally to adjust signal intensities based on the specific array type (e.g., "Xba", "Hind", "Nsp", or "Sty").

## Reference documentation
- [ITALICSData Reference Manual](./references/reference_manual.md)