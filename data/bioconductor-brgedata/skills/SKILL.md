---
name: bioconductor-brgedata
description: This package provides multi-omic and exposome datasets from a Spanish cohort for testing integration methods. Use when user asks to load example data for exposomics, transcriptomics, methylomics, or proteomics, or perform multi-omic data integration.
homepage: https://bioconductor.org/packages/release/data/experiment/html/brgedata.html
---

# bioconductor-brgedata

name: bioconductor-brgedata
description: Access and utilize multi-omic and exposome datasets from the BRGE cohort. Use when Claude needs to load example data for exposomics, transcriptomics, methylomics, or proteomics, particularly for multi-omic integration or Spanish population studies.

## Overview

The `brgedata` package provides a collection of multi-omic datasets (exposome, transcriptome, methylome, and proteome) derived from the same Spanish cohort. These datasets are designed to facilitate the development and testing of multi-omic integration methods. All datasets include common phenotypic variables such as `age` and `sex`.

## Data Resources

The package contains four primary data objects, each representing a different omic layer:

| Data Type | Object Name | Class | Features | Samples | Technology |
|-----------|-------------|-------|----------|---------|------------|
| Exposome | `brge_expo` | `ExposomeSet` | 15 | 110 | Various |
| Transcriptome | `brge_gexp` | `ExpressionSet` | 67,528 | 75 | Affymetrix HTA 2.0 |
| Methylome | `brge_methy` | `GenomicRatioSet` | 392,277 | 20 | Illumina 450K |
| Proteome | `brge_prot` | `ExpressionSet` | 47 | 90 | Various |

## Typical Workflow

### 1. Load the Package and Data
To use the datasets, load the library and use the `data()` function for the specific object required.

```r
library(brgedata)

# Load exposome data
data("brge_expo")

# Load transcriptome data
data("brge_gexp")

# Load methylome data
data("brge_methy")

# Load proteome data
data("brge_prot")
```

### 2. Inspect Phenotypic Data
All objects contain `age` and `sex`. The `ExposomeSet` (`brge_expo`) additionally includes `Asthma` and `Rhinitis` status.

```r
# For ExpressionSet or ExposomeSet
Biobase::pData(brge_expo)
Biobase::pData(brge_gexp)

# For GenomicRatioSet (Methylome)
SummarizedExperiment::colData(brge_methy)
```

### 3. Access Assay Data
Access the underlying measurements for each omic layer.

```r
# Exposome exposures
rexposome::expos(brge_expo)

# Gene expression values
Biobase::exprs(brge_gexp)

# Methylation Beta values
minfi::getBeta(brge_methy)

# Protein levels
Biobase::exprs(brge_prot)
```

## Integration Tips

- **Sample Overlap**: The datasets are designed with a minimum number of samples in common across all sets to allow for multi-omic analysis.
- **Feature Metadata**: Use `fData()` or `rowData()` to access information about the features (e.g., genomic coordinates for methylation or transcript IDs for gene expression).
- **Class Compatibility**: 
    - `brge_expo` requires the `rexposome` package.
    - `brge_gexp` and `brge_prot` use standard `Biobase` structures.
    - `brge_methy` requires the `minfi` package.

## Reference documentation

- [brgedata – data R package with three omic data-set and exposome data-set](./references/general_description.md)