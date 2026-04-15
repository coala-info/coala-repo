---
name: bioconductor-mammaprintdata
description: This package provides access to raw gene expression data and clinical annotations from the Glas and Buyse breast cancer cohorts used to validate the MammaPrint 70-gene signature. Use when user asks to load raw RGList objects for MammaPrint validation, retrieve clinical phenotypic information for breast cancer cohorts, or map microarray features to the 70-gene prognostic signature.
homepage: https://bioconductor.org/packages/release/data/experiment/html/mammaPrintData.html
---

# bioconductor-mammaprintdata

name: bioconductor-mammaprintdata
description: Access and process annotated gene expression data from the Glas and Buyse breast cancer cohorts used to validate the MammaPrint 70-gene signature. Use this skill to load raw RGList objects, retrieve phenotypic information, and map microarray features to the 70-gene prognostic signature.

## Overview

The `mammaPrintData` package provides gene expression data and clinical annotations for two major breast cancer cohorts:
1.  **Glas Cohort (E-TABM-115):** Training set used to implement the 70-gene signature into the MammaPrint assay.
2.  **Buyse Cohort (E-TABM-77):** Independent validation set from a European multicenter study.

The data is provided as `limma` package `RGList` objects. Because these are raw data objects, they require pre-processing and normalization (typically using `limma`) before downstream analysis.

## Loading the Data

The package contains pre-assembled `RGList` objects for both cohorts. Each cohort has two objects corresponding to the dye-swap design.

```r
library(mammaPrintData)

# Load Glas cohort data
data(glasRG)
# Available objects: glasRGcy3, glasRGcy5

# Load Buyse cohort data
data(buyseRG)
# Available objects: buyseRGcy3, buyseRGcy5
```

## Data Structure and Access

The objects are standard `limma` `RGList` instances.

### Accessing Expression and Annotation
- `obj$R`, `obj$G`: Red and Green foreground intensities.
- `obj$Rb`, `obj$Gb`: Red and Green background intensities.
- `obj$genes`: Feature annotation (1,900 features).
- `obj$targets`: Phenotypic/clinical information.

### Key Phenotypic Variables
The `targets` data frame contains curated clinical endpoints:
- `OS`: Overall survival time (years).
- `OSevent`: Binary event indicator for death (1 = event).
- `TTM`: Time to metastasis (years).
- `TTMevent`: Binary event indicator for distant metastasis.
- `FiveYearMetastasis` / `FiveYearRecurrence`: Binary indicators for "good" vs "bad" prognosis groups.

## Working with the 70-Gene Signature

The microarray used is the 1.9k MammaPrint array. The `genes` slot in the `RGList` objects includes logical columns to identify signature genes:

```r
# Identify features belonging to the 70-gene signature
sig70_indices <- which(glasRGcy5$genes$genes70)

# Identify features belonging to the 231-gene list
sig231_indices <- which(glasRGcy5$genes$genes231)

# Access correlation coefficients from the original van't Veer study
correlations <- glasRGcy5$genes$gns231Cors
```

## Typical Workflow

1.  **Load Data:** Load the desired cohort (e.g., `data(buyseRG)`).
2.  **Pre-processing:** Use `limma` functions like `backgroundCorrect` and `normalizeWithinArrays`.
3.  **Filtering:** Subset the `RGList` to include only the 70-gene signature features using the `genes70` logical column.
4.  **Analysis:** Perform survival analysis or classification based on the `targets` clinical data.

## Tips and Troubleshooting

- **Dye-Swap Design:** Remember that the data is split into two objects (`cy3` and `cy5`) based on which channel the reference RNA (MRP) was labeled with. For a complete analysis of a cohort, you must process both objects.
- **Missing Data:** In the Glas cohort, clinical information is primarily associated with the `glasRGcy5` object because of how the original SDRF files were structured in ArrayExpress.
- **Normalization:** These are raw intensities. Do not perform differential expression or prognostic scoring without first applying background correction and normalization.

## Reference documentation

- [mammaPrintData](./references/mammaPrintData.md)