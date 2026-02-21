---
name: bioconductor-gaschyhs
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/gaschYHS.html
---

# bioconductor-gaschyhs

name: bioconductor-gaschyhs
description: Access and analyze the gaschYHS yeast environmental stress response dataset. Use this skill when a user needs to work with the ExpressionSet from the Gasch et al. (2000) study, specifically for exploring transcriptional responses of Saccharomyces cerevisiae to heat shock and other stresses.

# bioconductor-gaschyhs

## Overview
The `gaschYHS` package is a Bioconductor ExperimentData package containing the landmark dataset from Gasch et al. (2000), "Exploring the Metabolic and Genetic Control of Gene Expression on a Genomic Scale." It provides an `ExpressionSet` object representing the transcriptional responses of yeast to various environmental stresses, including heat shock, osmotic shock, nutrient starvation, and more.

## Loading the Data
To use the dataset, you must load the library and use the `data()` function.

```r
library(gaschYHS)
library(Biobase)

# Load the primary ExpressionSet
data(gaschYHS)

# Load the figure 3 specific data (cdt format conversion)
data(fig3)
```

## Working with the ExpressionSet
The primary object `gaschYHS` is an `ExpressionSet`. You can use standard `Biobase` methods to interact with it.

### Inspecting Metadata
View the experimental conditions (phenotypic data) and feature information.

```r
# View sample information (stresses, time points)
pData(gaschYHS)

# View feature information (ORFs, gene names)
fData(gaschYHS)

# Summary of the object
gaschYHS
```

### Accessing Expression Values
The values are typically log2 expression ratios.

```r
# Extract the expression matrix
exp_matrix <- exprs(gaschYHS)

# Example: Accessing a specific gene across all conditions
# Replace 'ORF_NAME' with a valid yeast ORF like 'YAL001C'
gene_data <- exprs(gaschYHS)["YAL001C", ]
```

## Typical Workflows

### Filtering by Stress Type
The dataset contains 173 arrays. You can subset the data to focus on specific stress responses (e.g., Heat Shock).

```r
# Identify samples related to Heat Shock
heat_shock_samples <- grep("Heat Shock", pData(gaschYHS)$Description)
hs_subset <- gaschYHS[, heat_shock_samples]
```

### Visualizing Expression Profiles
Because this is a time-series stress dataset, plotting gene expression over time for specific conditions is a common task.

```r
# Simple plot for a single gene over the first 10 samples
plot(exprs(gaschYHS)[1, 1:10], type="b", main=fData(gaschYHS)$ID[1])
```

## Reference documentation
- [gaschYHS Reference Manual](./references/reference_manual.md)