---
name: bioconductor-humanaffydata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HumanAffyData.html
---

# bioconductor-humanaffydata

name: bioconductor-humanaffydata
description: Access and analyze integrated human gene expression datasets from Affymetrix HG_U133PlusV2 (EH176) and HG_U133A (EH177) platforms. Use this skill to retrieve large-scale, RMA-normalized ExpressionSet objects for gene co-expression analysis, tissue-specific expression profiling, and cross-condition comparisons in humans.

# bioconductor-humanaffydata

## Overview

The `HumanAffyData` package provides two major human gene expression compendia as `ExpressionSet` objects. These datasets represent integrated gene expression atlases across diverse biological samples and conditions, normalized using Robust Multi-array Averaging (RMA).

*   **EH176 (GSE64985):** 9,395 arrays from the HG_U133PlusV2 platform.
*   **EH177 (E-MTAB-62):** 5,372 arrays from the HG_U133A platform, featuring manually curated phenotypic information and technical bias correction.

## Data Retrieval

Datasets are hosted on `ExperimentHub`. You must use the hub interface to download the data.

```r
library(ExperimentHub)
library(HumanAffyData)

# Initialize hub and query for the package
hub <- ExperimentHub()
query_results <- query(hub, "HumanAffyData")

# Load specific datasets
# EH176: HG_U133PlusV2 compendium
# EH177: HG_U133A compendium (curated)
eset_177 <- query_results[["EH177"]]
```

## Working with ExpressionSets

Once loaded, the data follows standard `Biobase::ExpressionSet` structures.

### Extracting Expression Matrix
The rows represent genes (Entrez IDs for EH177) and columns represent samples (CEL file names).

```r
# Get expression matrix
exp_matrix <- exprs(eset_177)

# View dimensions (e.g., 12496 features x 5372 samples for EH177)
dim(exp_matrix)
```

### Accessing Phenotype Data
EH177 contains rich, curated metadata including tissue types, disease states, and "meta groups".

```r
# Get sample metadata
pheno_data <- pData(eset_177)

# Common metadata columns in EH177:
# Groups_4, Groups_15, Groups_369 (Curated tissue/cell groupings)
# DiseaseState, OrganismPart (Tissue), CellType, Sex
summary(pheno_data$OrganismPart)
```

## Data Processing Tips

### Recreating "96 Meta Groups"
The original publication for EH177 (Lukk et al.) often refers to "96 meta groups," which are categories from `Groups_369` containing at least 10 samples. You can recreate this column manually:

```r
groups_96 <- as.character(pheno_data$Groups_369)
# Filter out groups with fewer than 10 samples
small_groups <- names(which(table(groups_96) < 10))
groups_96[groups_96 %in% small_groups] <- ""
pheno_data$Groups_96 <- as.factor(groups_96)
```

### Gene Mapping
*   **EH177:** Probesets are already mapped to Entrez gene identifiers and averaged.
*   **EH176:** Contains original GEO titles and descriptions; may require additional mapping using `hgu133plus2.db` if specific gene symbols are needed.

## Reference documentation

- [HumanAffyData](./references/HumanAffyData.md)