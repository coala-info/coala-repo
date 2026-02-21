---
name: bioconductor-diggitdata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/diggitdata.html
---

# bioconductor-diggitdata

name: bioconductor-diggitdata
description: Access and use example datasets for the diggit package, including glioblastoma (GBM) mRNA expression, copy number variation (CNV) profiles, and regulatory networks (ARACNe and MINDy). Use when performing driver gene inference, testing diggit workflows, or practicing with regulon-class objects in R.

# bioconductor-diggitdata

## Overview

The `diggitdata` package is a specialized data experiment package for Bioconductor. It provides the necessary data structures to run the examples and vignettes of the `diggit` package, which is used for identifying drivers of disease phenotypes. The package includes human glioblastoma (GBM) multi-omics data and context-specific regulatory networks.

## Loading Data

To use the datasets, first load the library and then use the `data()` function to load specific objects into your R environment.

```r
library(diggitdata)

# Load mRNA expression
data(gbm.expression)

# Load CNV data
data(gbm.cnv)
data(gbm.cnv.normal)

# Load regulatory networks
data(gbm.aracne)
data(gbm.mindy)
```

## Available Data Objects

### mRNA Expression (`gbmExprs`)
An `ExpressionSet` object containing 245 human glioblastoma samples profiled on Affymetrix HT-HGU133A arrays.
- **Features**: ~9,215 genes.
- **Phenotype Data**: Includes sample subtypes.
- **Access**: Use `exprs(gbmExprs)` to get the expression matrix.

### Copy Number Variation (`gbmCNV` and `gbmCNVnormal`)
Numerical matrices containing gene-level summarized CNV data.
- **gbmCNV**: 230 GBM samples.
- **gbmCNVnormal**: 33 normal blood samples (used as a baseline).
- **Format**: Genes in rows, samples in columns.

### Regulatory Networks (Regulon Objects)
These objects are compatible with the `viper` and `diggit` packages.
- **gbmTFregulon**: A transcriptional interactome (ARACNe) with 835 transcription factors and 183,774 interactions.
- **gbmMindy**: A post-translational interactome (MINDy) representing modulatory interactions for CEBPB, CEBPD, and STAT3.

## Typical Workflow Integration

These datasets are typically used as inputs for the `diggit` pipeline:

1. **Correlation Analysis**: Use `gbmExprs` and `gbmCNV` to find genomic alterations associated with expression changes.
2. **Master Regulator Analysis**: Use `gbmTFregulon` with `viper` to transform the expression matrix into a protein activity matrix.
3. **Driver Inference**: Combine the CNV data and the regulons within the `diggit` framework to identify functional drivers of the GBM phenotype.

## Reference documentation

- [diggitdata](./references/diggitdata.md)