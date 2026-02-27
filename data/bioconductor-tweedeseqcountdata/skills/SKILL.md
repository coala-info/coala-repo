---
name: bioconductor-tweedeseqcountdata
description: This package provides RNA-seq count data from the Pickrell et al. (2010) study for use in R. Use when user asks to load the Pickrell dataset, access Nigerian population RNA-seq counts, or provide example data for Poisson-Tweedie differential expression analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/tweeDEseqCountData.html
---


# bioconductor-tweedeseqcountdata

name: bioconductor-tweedeseqcountdata
description: Access and use the tweeDEseqCountData R package, which provides RNA-seq count data from Pickrell et al. (2010). Use this skill when a user needs to load, explore, or utilize the Pickrell dataset for demonstrating the Poisson-Tweedie family of distributions or for testing differential expression analysis workflows in R.

# bioconductor-tweedeseqcountdata

## Overview

The `tweeDEseqCountData` package is a Bioconductor data experiment package. It contains RNA-seq expression counts from 69 unrelated Nigerian individuals (Yoruba in Ibadan, Nigeria) as reported by Pickrell et al. (2010). This dataset is primarily used as a benchmark or example dataset for the `tweeDEseq` package to illustrate the application of Poisson-Tweedie distributions in differential expression analysis.

## Data Loading and Exploration

To use this package, you must first load it into your R session. The primary data object is typically accessed via the `data()` function.

### Loading the Dataset
```r
library(tweeDEseqCountData)

# Load the Pickrell dataset
data(pickrell)
```

### Understanding the Data Objects
The package typically provides the following objects:
- `pickrell.counts`: A matrix of raw RNA-seq read counts. Rows represent genes (Ensembl IDs) and columns represent samples.
- `pickrell.eset`: An `ExpressionSet` object containing the count data along with phenotype information (metadata).

### Basic Inspection
```r
# Check the dimensions of the count matrix
dim(pickrell.counts)

# View sample metadata
pData(pickrell.eset)

# View gene annotation (if available)
fData(pickrell.eset)
```

## Typical Workflow

1. **Initialization**: Load the library and the data.
2. **Preprocessing**: Filter out lowly expressed genes to improve statistical power.
3. **Integration with tweeDEseq**: Use the counts as input for the `tweeDEseq` function to perform differential expression analysis using the Poisson-Tweedie family.
4. **Comparison**: Compare results with other methods like `edgeR` or `DESeq2`.

### Example: Filtering Genes
```r
# Example: Keep genes with at least 0.5 counts per million (CPM) in at least 20 samples
library(edgeR)
cpms <- cpm(pickrell.counts)
keep <- rowSums(cpms > 0.5) >= 20
countsFiltered <- pickrell.counts[keep, ]
```

## Tips
- The data is provided as raw counts. Do not use log-transformed or normalized data if you intend to use the `tweeDEseq` analysis pipeline, as it expects discrete count values.
- Ensure the `Biobase` package is loaded if you need to manipulate the `ExpressionSet` object directly.

## Reference documentation
- [tweeDEseqCountData](./references/tweeDEseqCountData.md)