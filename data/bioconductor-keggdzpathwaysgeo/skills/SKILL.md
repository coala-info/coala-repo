---
name: bioconductor-keggdzpathwaysgeo
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/KEGGdzPathwaysGEO.html
---

# bioconductor-keggdzpathwaysgeo

## Overview
The `KEGGdzPathwaysGEO` package is a data-only Bioconductor experiment data package. It contains 24 human datasets from the Gene Expression Omnibus (GEO) where the phenotype is a specific disease (e.g., Alzheimer's, Colorectal Cancer, Glioma). Each dataset is linked to a "target" KEGG pathway that is known to be relevant to the disease. This collection is primarily used to validate or compare the sensitivity of gene set analysis (GSA) methods by checking if the method can correctly identify the target pathway as significantly enriched.

## Loading and Exploring Datasets

All datasets are stored as `ExpressionSet` objects.

### List Available Datasets
To see the list of all 24 dataset names available in the package:
```R
library(KEGGdzPathwaysGEO)
data(package="KEGGdzPathwaysGEO")$results[,"Item"]
```

### Load a Specific Dataset
Load a dataset by its GEO ID (or specific subset ID):
```R
# Example: Load Colorectal Cancer dataset
data(GSE8671)

# View the ExpressionSet object
GSE8671
```

### Accessing Metadata and Target Pathways
Each `ExpressionSet` contains specific metadata in the `@other` slot of the `experimentData` that identifies the "gold standard" target pathway.

```R
# Extract the target KEGG ID and Disease name
target_id <- GSE8671@experimentData@other$targetGeneSets
disease_name <- GSE8671@experimentData@other$disease

print(paste("Disease:", disease_name))
print(paste("Target KEGG Pathway ID:", target_id))
```

## Data Structure for Analysis

### Expression Data and Phenotypes
Standard `Biobase` methods are used to extract the expression matrix and group labels (Control vs. Disease).

```R
# Get expression matrix
exp_matrix <- exprs(GSE8671)

# Get group labels (usually 'c' for control, 'd' for disease)
group_labels <- pData(GSE8671)$Group

# Check experimental design (Paired vs Not Paired)
design_type <- GSE8671@experimentData@other$design
```

### Dataset Mapping Table
The following table summarizes the key datasets and their target pathways:

| GEO ID | Disease | KEGG ID | Tissue |
| :--- | :--- | :--- | :--- |
| GSE1297 | Alzheimer's Disease | hsa05010 | Hippocampal CA1 |
| GSE5281_EC | Alzheimer's Disease | hsa05010 | Entorhinal Cortex |
| GSE20153 | Parkinson's disease | hsa05012 | Lymphoblasts |
| GSE8762 | Huntington's disease | hsa05016 | Lymphocytes |
| GSE8671 | Colorectal Cancer | hsa05210 | Colon |
| GSE14762 | Renal Cancer | hsa05211 | Kidney |
| GSE15471 | Pancreatic Cancer | hsa05212 | Pancreas |
| GSE19728 | Glioma | hsa05214 | Brain |
| GSE6956AA | Prostate Cancer | hsa05215 | Prostate |
| GSE3467 | Thyroid Cancer | hsa05216 | Thyroid |
| GSE9476 | Acute myeloid leukemia | hsa05221 | Bone marrow |
| GSE18842 | Non-Small Cell Lung Cancer | hsa05223 | Lung |

## Typical Workflow: Benchmarking GSA
1. **Load Dataset**: Select a dataset from the package.
2. **Identify Target**: Retrieve the `targetGeneSets` ID from the metadata.
3. **Run GSA**: Apply your gene set analysis method (e.g., PADOG, GSEA, ORA) to the expression data.
4. **Evaluate**: Check the rank or p-value of the `targetGeneSets` ID. A better method should rank the target pathway closer to the top.

## Reference documentation
- [KEGGdzPathwaysGEO Reference Manual](./references/reference_manual.md)