---
name: bioconductor-fibroeset
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/fibroEset.html
---

# bioconductor-fibroeset

name: bioconductor-fibroeset
description: Access and utilize the Karaman et al. (2003) fibroblast gene expression dataset. Use this skill when a user needs to analyze comparative microarray data from human, bonobo, and gorilla cell lines, or requires an example ExpressionSet for Bioconductor workflow demonstrations.

## Overview

The `fibroEset` package provides a specialized `ExpressionSet` object containing gene expression data from primary fibroblast cell lines of 18 humans, 10 bonobos, and 11 gorillas. The data was generated using Affymetrix U95Av2 microarrays. This dataset is primarily used for evolutionary genetics studies and demonstrating Bioconductor tools for handling microarray data.

## Loading the Data

To use the dataset, you must load the library and call the `data()` function:

```r
library(Biobase)
library(fibroEset)

# Load the ExpressionSet object
data(fibroEset)
```

## Data Structure

The `fibroEset` object contains:
- **Assay Data**: 12,625 genes (features) across 46 samples.
- **Pheno Data**: Two main covariates:
  - `samp`: The specific sample code.
  - `species`: The origin species (h: human, b: bonobo, g: gorilla).

## Common Workflows

### Accessing Expression Values
Extract the normalized expression matrix:
```r
exp_matrix <- exprs(fibroEset)
# View first few rows and columns
exp_matrix[1:5, 1:5]
```

### Accessing Sample Metadata
Retrieve the species information for all samples:
```r
sample_species <- fibroEset$species
table(sample_species)
```

### Filtering and Subsetting
Subset the data to focus on a specific species (e.g., humans):
```r
human_only <- fibroEset[, fibroEset$species == "h"]
```

### Feature Exploration
Retrieve the Affymetrix probe IDs:
```r
probes <- featureNames(fibroEset)
head(probes, 20)
```

## Technical Notes
- **Normalization**: The data was normalized using multiplicative scaling factors based on the median intensity of the 60th to 95th percentile.
- **Noise Floor**: All expression scores below 100 were thresholded to 100 to minimize noise.
- **Cross-Species Hybridization**: While a human chip (U95Av2) was used for all species, the original study suggests that the 16 perfect match probes per gene minimize the impact of sequence mismatches in apes.

## Reference documentation

- [fibroEset Reference Manual](./references/reference_manual.md)