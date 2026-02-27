---
name: bioconductor-sampleclassifierdata
description: This package provides curated, pre-processed microarray and RNA-seq gene expression datasets formatted as SummarizedExperiment objects for tissue classification. Use when user asks to access reference gene expression matrices, load test datasets for classification validation, or retrieve curated human tissue data for use with the sampleClassifier package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/sampleClassifierData.html
---


# bioconductor-sampleclassifierdata

name: bioconductor-sampleclassifierdata
description: Access and use pre-processed microarray and RNA-seq datasets from the sampleClassifierData package. Use this skill when a user needs reference gene expression matrices or test datasets for tissue classification, specifically for use with the sampleClassifier package.

# bioconductor-sampleclassifierdata

## Overview

The `sampleClassifierData` package provides a collection of curated, pre-processed gene expression datasets. These datasets are specifically formatted as `SummarizedExperiment` objects to serve as either reference matrices (for training/building classifiers) or test matrices (for validating classification) within the `sampleClassifier` workflow. It includes both RNA-seq (FPKM) and microarray (YuGene normalized) data across various human tissue types.

## Data Access and Usage

To use these datasets, you must load the package and then use the `data()` function to load specific objects into your R environment. Since the data is stored in `SummarizedExperiment` objects, use the `assay()` function from the `SummarizedExperiment` package to extract the numeric expression matrices.

### Available Datasets

| Object Name | Data Type | Source | Description |
| :--- | :--- | :--- | :--- |
| `se_rnaseq_refmat` | RNA-seq | E-MTAB-1733 | Reference: 24 tissues, ~3 replicates each. |
| `se_micro_refmat` | Microarray | GSE3526 | Reference: 26 tissues, 3 replicates each. |
| `se_rnaseq_testmat` | RNA-seq | E-MTAB-513 | Test: 12 tissues. |
| `se_micro_testmat` | Microarray | GSE2361 | Test: 16 tissues. |

### Typical Workflow

1. **Load the library and data:**
   ```r
   library(sampleClassifierData)
   library(SummarizedExperiment)

   # Load a reference RNA-seq dataset
   data("se_rnaseq_refmat")
   ```

2. **Extract the expression matrix:**
   ```r
   # Extract numeric matrix for sampleClassifier
   rnaseq_refmat <- assay(se_rnaseq_refmat)
   
   # Check dimensions (Rows = Genes, Cols = Samples)
   dim(rnaseq_refmat)
   ```

3. **Integration with sampleClassifier:**
   These matrices are designed to be passed directly into `sampleClassifier` functions. For example, `se_rnaseq_refmat` is typically used to identify marker genes or as a reference for classifying unknown samples.

## Tips for Success

- **Gene Identifiers:** Ensure your query data uses the same gene identifier format (e.g., Ensembl IDs or Gene Symbols) as the reference matrix you select.
- **Normalization:** The RNA-seq data is provided as FPKM values. The microarray data is normalized using the YuGene method. When using your own data with these references, ensure your data is processed in a compatible manner.
- **Memory Management:** These objects can be large. If you only need the matrix, you can extract the `assay()` and then remove the `SummarizedExperiment` object to save memory.

## Reference documentation

- [Introduction to the sampleClassifierData Package](./references/sampleClassifierData.md)