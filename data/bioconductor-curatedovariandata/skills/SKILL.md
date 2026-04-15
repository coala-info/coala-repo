---
name: bioconductor-curatedovariandata
description: This package provides a curated collection of gene expression datasets and clinical metadata for ovarian cancer meta-analysis. Use when user asks to load harmonized transcriptomic data, perform survival analysis across multiple studies, or apply batch correction to ovarian cancer microarray data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/curatedOvarianData.html
---

# bioconductor-curatedovariandata

name: bioconductor-curatedovariandata
description: Access and analyze a curated collection of gene expression datasets for ovarian cancer meta-analysis. Use this skill when you need to load harmonized transcriptomic data, perform survival analysis across multiple studies, or apply batch correction to ovarian cancer microarray data.

## Overview

The `curatedOvarianData` package provides a manually curated collection of gene expression data for ovarian cancer. It contains over 30 datasets (primarily microarray) provided as Bioconductor `ExpressionSet` objects. The package is designed to facilitate meta-analysis by providing uniformly prepared data and documented clinical metadata, including survival information, FIGO stage, and debulking status.

## Core Workflows

### Loading Datasets

To list all available datasets:
```r
library(curatedOvarianData)
data(package="curatedOvarianData")
```

To load a specific dataset (e.g., TCGA):
```r
data(TCGA_eset)
# Access expression data
exprs(TCGA_eset)[1:5, 1:5]
# Access clinical metadata
pData(TCGA_eset)[1:5, 1:5]
```

### Automated Patient Selection and Filtering

The package includes internal scripts to filter samples and datasets based on specific criteria (e.g., minimum sample size, presence of survival data, or tumor stage).

1. **Load Configuration**: Source the default configuration file to set filtering rules.
   ```r
   source(system.file("extdata", "patientselection.config", package="curatedOvarianData"))
   ```
2. **Customize Rules**: Modify the loaded variables (e.g., `min.sample.size`, `rule.1`). Rules use regular expressions.
   ```r
   rule.1 <- c("sample_type", "^tumor$") # Only keep tumor samples
   strict.checking <- TRUE # Remove samples missing required metadata
   ```
3. **Generate Dataset List**: Source the creation script to produce a list of filtered `ExpressionSet` objects.
   ```r
   source(system.file("extdata", "createEsetList.R", package="curatedOvarianData"))
   # The resulting list is stored in the variable 'esets'
   names(esets)
   ```

### Meta-Analysis and Survival Analysis

A common workflow involves testing gene associations with survival across multiple datasets.

1. **Extract Survival Data**: Survival objects are typically stored in the `y` label of the `phenoData` after running `createEsetList.R`.
2. **Cox Proportional Hazards**: Use the `survival` package to fit models for each dataset.
3. **Meta-Analysis**: Use the `metafor` package to combine effect sizes (Hazard Ratios) into a forest plot.

### Batch Correction

When merging datasets from different platforms, use `ComBat` from the `sva` package to remove batch effects.

```r
library(sva)
# Combine two ExpressionSets (requires matching features)
# Use a helper to intersect features and cbind expression matrices
combined_matrix <- cbind(exprs(eset1), exprs(eset2))
batch <- c(rep(1, ncol(eset1)), rep(2, ncol(eset2)))
mod <- model.matrix(~as.factor(tumorstage), data=combined_pheno)
combat_data <- ComBat(dat=combined_matrix, batch=batch, mod=mod)
```

### Handling Non-Specific Probesets

By default, the package collapses probesets to HGNC symbols. If a probeset maps to multiple genes, they are separated by `///`. To split these into individual rows:

```r
# Use the internal helper function logic
expandProbesets <- function (eset, sep = "///") {
    # Logic to split 'GENE1///GENE2' into separate rows with identical expression
    # See reference documentation for implementation details
}
```

## Tips and Best Practices

- **Clinical Variables**: Standardized variables include `vital_status`, `days_to_death`, `tumorstage`, and `debulking`. Always check `varLabels(eset)` to see available metadata.
- **Duplicate Removal**: The `patientselection.config` script automatically handles known duplicate samples across studies to prevent bias in meta-analysis.
- **Gene Symbols**: Probesets are already mapped to HGNC symbols. If you need original manufacturer IDs, use the `FULLVcuratedOvarianData` package (available via the package website).
- **Memory Management**: Loading all datasets simultaneously can be memory-intensive. Use the filtering scripts to load only what is necessary.

## Reference documentation

- [curatedOvarianData: Clinically Annotated Data for the Ovarian Cancer Transcriptome](./references/curatedOvarianData.md)