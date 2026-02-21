---
name: bioconductor-bcellviper
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/bcellViper.html
---

# bioconductor-bcellviper

name: bioconductor-bcellviper
description: Access and utilize the human B-cell expression dataset and transcriptional regulatory network (interactome) provided by the bcellViper package. Use this skill when performing virtual inference of protein activity (VIPER) analysis, studying B-cell phenotypes, or requiring example data for the viper package.

# bioconductor-bcellviper

## Overview

The `bcellViper` package is a data-only experiment package designed to support the `viper` (Virtual Inference of Protein-activity by Enriched Regulon analysis) package. It provides a high-quality human B-cell expression dataset and a context-specific transcriptional regulatory network (interactome) inferred using the ARACNe algorithm.

Key components include:
- **dset**: An `ExpressionSet` object containing 211 normal and tumor human B-cell samples.
- **regulon**: A `regulon` class object representing 172,240 regulatory interactions between 621 transcription factors and 6,249 target genes.
- **adj**: A subset of ARACNe results in adjacency matrix format.

## Usage and Workflows

### Loading the Data

To use the datasets, you must load the library and then call the `data()` function.

```r
library(bcellViper)
data(bcellViper)
```

### Exploring the Expression Dataset

The `dset` object contains expression profiles for 211 samples across 6,249 features (probe-clusters).

```r
# View the ExpressionSet summary
print(dset)

# Access expression values
exp_matrix <- exprs(dset)

# View phenotype metadata
pData(dset)
```

### Working with the B-cell Interactome

The `regulon` object is structured for use with the `viper` package functions. It contains the regulatory relationships, including the mode of regulation (correlation) and the confidence (likelihood) of each interaction.

```r
# Summary of the network
targets <- unlist(lapply(regulon, function(x) names(x$tfmode)), use.names = FALSE)
cat("Regulators:", length(regulon), "\n")
cat("Targets:", length(unique(targets)), "\n")
cat("Interactions:", length(targets), "\n")

# Inspect a specific regulator (e.g., the first one)
regulon[[1]]
```

### Converting ARACNe Results

If you need to process the raw adjacency matrix into a `regulon` object (typically handled by the `viper` package), use the following pattern:

```r
library(viper)
# 'adj' is the adjacency matrix provided in the package
# This converts the matrix into the S3 regulon class
new_regulon <- aracne2regulon("path_to_adj_file.txt", dset, verbose = TRUE)
```

## Tips for Analysis

- **Integration with VIPER**: This package is most commonly used as the input for the `viper()` function to transform gene expression data into protein activity scores.
- **Feature Matching**: The features in `dset` and the targets in `regulon` use the same identifiers (cleaner-generated probe-clusters), ensuring compatibility during analysis.
- **Phenotypes**: The `phenoData` in `dset` includes `description` and `detailed_description` columns, which are useful for defining "test" vs "control" groups for differential activity analysis.

## Reference documentation

- [bcellViper](./references/bcellViper.md)