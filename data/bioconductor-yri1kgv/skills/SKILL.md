---
name: bioconductor-yri1kgv
description: This package provides expression and genotype data for 79 unrelated Yoruba individuals from the 1000 Genomes Project. Use when user asks to load the yri1kgv ExpressionSet, perform eQTL analysis, or explore genomic variations in the YRI population.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/yri1kgv.html
---


# bioconductor-yri1kgv

name: bioconductor-yri1kgv
description: Access and analyze the yri1kgv dataset containing expression and genotype data for 79 unrelated Yoruba (YRI) individuals from the 1000 Genomes Project. Use this skill to load the ExpressionSet, perform eQTL analysis, or explore genomic variations in the YRI population.

# bioconductor-yri1kgv

## Overview
The `yri1kgv` package is a Bioconductor data experiment package. It provides a unified dataset (ExpressionSet) combining gene expression data from ArrayExpress (E-MTAB-264) and genotype data from the 1000 Genomes Project (Phase 1 release) for 79 unrelated individuals of Yoruba ancestry from Ibadan, Nigeria (YRI). This package is primarily used for integrative genomic analyses, such as expression quantitative trait loci (eQTL) mapping.

## Loading the Data
The primary data object in this package is an `ExpressionSet` named `ex`.

```r
# Load the package
library(yri1kgv)

# Load the provided ExpressionSet
data(eset)

# View the object summary
print(ex)
```

## Working with the ExpressionSet
The `ex` object contains both the expression matrix and the associated phenotypic/genotypic metadata.

### Accessing Expression Data
```r
# Extract expression values
exp_matrix <- exprs(ex)
dim(exp_matrix)
```

### Accessing Metadata
```r
# View sample information
pData(ex)

# View feature (gene/probe) information
fData(ex)
```

## Integration with GGBase
Since `yri1kgv` depends on `GGBase`, you can use `GGBase` functions to manage and analyze the genotype-expression relationships.

```r
library(GGBase)

# Example: Visualizing or summarizing the data structure
# Note: 'ex' is often used as a base for smlSet objects in eQTL workflows
```

## Typical Workflow: eQTL Exploration
1. **Initialization**: Load the `yri1kgv` package and the `ex` dataset.
2. **Preprocessing**: Filter genes or samples based on expression thresholds or quality control metrics.
3. **Analysis**: Use the `GGtools` or `GGBase` packages to perform SNP-gene association tests using the genotypes embedded or linked via the `ex` object.
4. **Visualization**: Plot expression levels against genotype classes for specific SNP-gene pairs.

## Tips
- The dataset uses the `Artistic-2.0` license.
- The expression data is derived from ArrayExpress E-MTAB-264.
- Genotypes are sourced from the 1000 Genomes VCF phase1_release_v3.20101123.
- Ensure `GGBase` and `Biobase` are installed, as they are required to handle the `ExpressionSet` structure.

## Reference documentation
- [yri1kgv Reference Manual](./references/reference_manual.md)