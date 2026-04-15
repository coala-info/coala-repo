---
name: bioconductor-curatedadipoarray
description: This package provides access to curated microarray datasets of MDI-induced differentiated 3T3-L1 adipocytes under genetic and pharmacological perturbations. Use when user asks to retrieve SummarizedExperiment objects from ExperimentHub, explore gene expression matrices, or access harmonized sample metadata for adipocyte differentiation studies.
homepage: https://bioconductor.org/packages/release/data/experiment/html/curatedAdipoArray.html
---

# bioconductor-curatedadipoarray

name: bioconductor-curatedadipoarray
description: Access and analyze curated microarray datasets of MDI-induced differentiated adipocytes (3T3-L1) under genetic and pharmacological perturbations. Use this skill to retrieve SummarizedExperiment objects from ExperimentHub, explore gene expression matrices, and access harmonized sample metadata for adipocyte differentiation studies.

# bioconductor-curatedadipoarray

## Overview
The `curatedAdipoArray` package provides a curated collection of microarray data from 3T3-L1 pre-adipocytes. It includes samples at various stages of differentiation (MDI-induced) subjected to genetic (knockdown/overexpression) or pharmacological (drug treatment) perturbations. Data is delivered as `SummarizedExperiment` objects via `ExperimentHub`, featuring manually curated metadata with controlled vocabularies for cross-study comparison.

## Installation
Install the package using `BiocManager`:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("curatedAdipoArray")
```

## Data Retrieval Workflow
Data is hosted on `ExperimentHub`. You must query the hub to find specific datasets.

1. **Load libraries and initialize ExperimentHub**:
   ```r
   library(ExperimentHub)
   library(SummarizedExperiment)
   eh <- ExperimentHub()
   ```

2. **Query for curatedAdipoArray resources**:
   ```r
   query(eh, "curatedAdipoArray")
   ```

3. **Select and load a specific dataset**:
   Datasets include individual GEO series or merged/processed sets (e.g., genetic vs. pharmacological).
   ```r
   # Example: Loading the processed genetic perturbation dataset (Resource EH3287)
   genetic_data <- eh[["EH3287"]]
   ```

## Working with the Data
The datasets are `SummarizedExperiment` objects.

### Accessing Expression Data
The `assay()` function retrieves the log-transformed, normalized, and batch-corrected (for merged sets) gene expression matrix.
```r
exp_matrix <- assay(genetic_data)
head(exp_matrix[, 1:5])
```

### Accessing Metadata
The `colData()` function provides curated sample information.
```r
metadata <- colData(genetic_data)
head(metadata)
```

**Key Metadata Columns:**
- `time`: Hours from start of differentiation.
- `media`: Differentiation media (MDI or none).
- `treatment`: Status (none, drug, knockdown, overexpression).
- `treatment_target`: Gene or pathway targeted.
- `perturbation_type`: "genetic" or "pharmacological".

## Typical Analysis Tasks
- **Differential Expression**: Use `limma` on the retrieved `SummarizedExperiment` to compare treatment vs. control or different time points.
- **Time-course Analysis**: Utilize the `time` column to model expression changes during adipogenesis.
- **Cross-study Comparison**: Since metadata is homogenized, you can combine multiple series for meta-analysis.

## Reference documentation
- [Using curatedAdipoArray](./references/curatedAdipoArray.Rmd)
- [curatedAdipoArray Guide](./references/curatedAdipoArray.md)