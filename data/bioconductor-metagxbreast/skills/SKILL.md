---
name: bioconductor-metagxbreast
description: MetaGxBreast provides a standardized compendium of breast cancer gene expression datasets with consistent clinical annotations for meta-analysis. Use when user asks to load breast cancer transcriptomic data, access TCGA or METABRIC datasets, or perform cross-study comparisons using standardized phenotype information.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MetaGxBreast.html
---

# bioconductor-metagxbreast

## Overview
MetaGxBreast is a comprehensive compendium of breast cancer gene expression datasets. It provides a standardized interface to access over 30 datasets, including large-scale studies like TCGA and METABRIC. The package facilitates meta-analysis by providing consistent clinical annotation (phenotype data) and expression matrices across different platforms.

## Loading Datasets
The primary function for data retrieval is `loadBreastEsets()`. It returns a list containing a list of `ExpressionSet` objects.

```r
library(MetaGxBreast)

# Load specific small datasets
esets_list <- MetaGxBreast::loadBreastEsets(loadString = c("CAL", "DFHCC", "DUKE"))
esets <- esets_list[[1]]

# Load the majority of datasets (37 of 39)
# Note: This requires significant memory
esets_all <- MetaGxBreast::loadBreastEsets(loadString = "majority")[[1]]

# Load large studies separately
metabric <- MetaGxBreast::loadBreastEsets(loadString = "metabric")[[1]]
tcga <- MetaGxBreast::loadBreastEsets(loadString = "tcga")[[1]]
```

### Filtering Parameters
You can refine the data loading process using the following arguments in `loadBreastEsets()`:
- `removeDuplicateSamples`: Logical (default TRUE). Removes samples present in multiple studies.
- `commonGenes`: Logical (default FALSE). If TRUE, retains only genes present across all loaded platforms.
- `minSampleSize`: Integer (default 0). Minimum number of samples required to load a study.
- `minNumGenes`: Integer (default 0). Minimum number of genes required.
- `minNumEvents`: Integer (default 0). Minimum number of survival events required.

## Working with ExpressionSets
Once loaded, use standard `Biobase` methods to interact with the data.

```r
library(Biobase)

# Get sample names for the first dataset
sample_names <- sampleNames(esets[[1]])

# Get gene/feature names
gene_names <- featureNames(esets[[1]])

# Access expression matrix
exp_matrix <- exprs(esets[[1]])

# Access clinical metadata
clinical_data <- pData(esets[[1]])
```

## Analyzing Phenotype Data
The package standardizes several key clinical variables across datasets. Common variables include:
- `er`: Estrogen receptor status
- `pgr`: Progesterone receptor status
- `her2`: HER2 status
- `grade`: Tumor grade
- `dmfs_days` / `dmfs_status`: Distant metastasis-free survival
- `days_to_death` / `vital_status`: Overall survival
- `treatment`: Treatment received

### Example: Summarizing Data Availability
To check how many samples have specific clinical annotations across your loaded datasets:

```r
# Define variables of interest
vars <- c("er", "her2", "grade", "dmfs_status")

# Calculate percentage of non-NA values per dataset
availability <- lapply(esets, function(x) {
  vapply(vars, function(y) sum(!is.na(pData(x)[,y])) / nrow(pData(x)) * 100, numeric(1))
})
availability_table <- do.call(rbind, availability)
```

## Workflow Tips
1. **Memory Management**: Loading "majority" or large datasets like METABRIC/TCGA can consume several gigabytes of RAM. Load only the studies necessary for your specific analysis.
2. **Gene Mapping**: While the package standardizes many aspects, ensure you check if you need to map probe IDs to Gene Symbols or Entrez IDs depending on your downstream meta-analysis requirements.
3. **Duplicate Removal**: Always keep `removeDuplicateSamples = TRUE` unless you have a specific reason to include technical replicates across different study publications.

## Reference documentation
- [MetaGxBreast](./references/MetaGxBreast.md)