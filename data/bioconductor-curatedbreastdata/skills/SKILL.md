---
name: bioconductor-curatedbreastdata
description: This tool provides access to 34 curated and harmonized breast cancer gene expression datasets with standardized clinical metadata. Use when user asks to load normalized ExpressionSet objects, access harmonized clinical data for meta-analysis, or perform post-processing steps like gene filtering and missing value imputation.
homepage: https://bioconductor.org/packages/release/data/experiment/html/curatedBreastData.html
---


# bioconductor-curatedbreastdata

name: bioconductor-curatedbreastdata
description: Access and process 34 high-quality curated breast cancer gene expression datasets from GEO. Use this skill to load normalized ExpressionSet objects, access semantically harmonized clinical data (ER/HER2 status, treatment response, survival), and perform post-processing steps like gene filtering and missing value imputation for meta-analyses.

# bioconductor-curatedbreastdata

## Overview
The `curatedBreastData` package provides a curated collection of 34 gene expression microarray datasets for breast cancer, specifically focused on advanced disease. All datasets are represented as S4 `ExpressionSet` objects. The package's primary value lies in its semantically normalized clinical metadata, allowing for powerful meta-analyses across different studies regarding treatment response (e.g., pathological complete response), pathology (ER/HER2 status), and survival outcomes.

## Getting Started
Load the package and the primary data objects:

```r
library(curatedBreastData)

# Load the list of 34 ExpressionSet objects
data(curatedBreastDataExprSetList)

# Load the master clinical data table
data(clinicalData)
```

## Data Structures
- **curatedBreastDataExprSetList**: A list of `ExpressionSet` objects. Each object contains normalized expression data and study-specific clinical data in the `phenoData` slot.
- **clinicalData**: A list containing:
  - `clinicalTable`: A master data frame combining clinical data for all 2,719 patients across all datasets.
  - `clinicalVarDef`: Definitions for the clinical variables used in the table.

## Common Workflows

### Accessing Clinical Metadata
Clinical variables are standardized across all datasets. You can access them via the master table or individual sets:

```r
# Access master table
master_clin <- clinicalData$clinicalTable

# Access metadata for a specific study (e.g., the 3rd study)
study_clin <- pData(curatedBreastDataExprSetList[[3]])

# Example: Find patients who received taxane chemotherapy
taxane_patients <- master_clin[master_clin$taxane == 1, ]
```

### Post-Processing Expression Sets
The package provides a wrapper function `processExpressionSetList()` to handle common microarray cleaning tasks:
- Removing samples/genes with high NA rates.
- Imputing missing values (using KNN).
- Collapsing duplicated probes/genes.
- Filtering genes by variance.

```r
# Process the first two datasets, keeping the top 5000 genes by variance
proc_list <- processExpressionSetList(
  exprSetList = curatedBreastDataExprSetList[1:2], 
  outputFileDirectory = "./", 
  numTopVarGenes = 5000
)
```

### Analyzing Outcomes and Treatments
The package includes curated variables for survival and treatment:
- **Survival**: `OS` (Overall Survival binary), `OS_months_or_MIN_months_of_OS`, `RFS` (Relapse Free Survival).
- **Treatment**: `chemotherapy`, `taxane`, `hormone_therapy`, `trastuzumab`, `neoadjuvant_or_adjuvant`.

```r
# Count patients with documented Overall Survival data
sum(!is.na(clinicalData$clinicalTable$OS))

# Filter for neoadjuvant studies
neo_patients <- clinicalData$clinicalTable[clinicalData$clinicalTable$neoadjuvant_or_adjuvant == "neo", ]
```

## Tips
- **Batch Effects**: Some GEO studies contain internal batches (e.g., different platforms or collection sites). These have been separated into distinct entries in the `curatedBreastDataExprSetList` to prevent batch-induced bias in meta-analyses.
- **Missing Data**: In the clinical table, `NA` typically means the information was not recorded in the original study.
- **Semantic Normalization**: Use `clinicalData$clinicalVarDef` to understand the standardized naming convention if a variable name is ambiguous.

## Reference documentation
- [curatedBreastData Manual](./references/curatedBreastData-manual.md)