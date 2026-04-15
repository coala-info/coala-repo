---
name: bioconductor-biomm
description: Bioconductor-biomm performs biologically-informed multi-stage machine learning for phenotype prediction using high-dimensional omics data. Use when user asks to map omics features to biological entities, build multi-stage predictive models, or prioritize outcome-associated functional patterns.
homepage: https://bioconductor.org/packages/3.9/bioc/html/BioMM.html
---

# bioconductor-biomm

name: bioconductor-biomm
description: Biologically-informed Multi-stage Machine learning (BioMM) for phenotype prediction using high-dimensional omics data. Use this skill to perform feature stratification (mapping SNPs/CpGs to genes, pathways, or chromosomes), build multi-stage predictive models (supervised or unsupervised), and prioritize outcome-associated functional patterns.

# bioconductor-biomm

## Overview

BioMM is a framework designed to improve phenotype prediction from omics data by incorporating prior biological knowledge. It operates in two main stages:
1. **Stage 1**: Compresses high-dimensional variables (e.g., CpGs, SNPs) into functional-level "latent variables" based on biological metadata (genes, pathways, or chromosomes).
2. **Stage 2**: Builds a supervised model using these latent variables to predict the target phenotype.

This approach handles the "p >> n" problem (more features than samples) and provides interpretable results by identifying which biological pathways or regions drive the prediction.

## Getting Started

Install the package and load necessary dependencies for parallel processing and specific classifiers:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("transbioZI/BioMM")

library(BioMM)
library(BiocParallel)
library(ranger)
library(e1071)
library(glmnet)
```

## Feature Stratification

Before running the machine learning framework, map omics features to biological entities using annotation data.

- **Chromosome-based**: `omics2chrlist(data, probeAnno)`
- **Pathway-based**: `omics2pathlist(data, pathlistDB, probeAnno, restrictUp, restrictDown, minPathSize)`
- **Gene-based**: `omics2genelist(data, probeAnno, restrictUp, restrictDown)`

## End-to-End Prediction

The `BioMM()` function handles the entire multi-stage workflow.

### Supervised Workflow (e.g., Random Forest)
Use supervised learning at Stage 1 to create latent variables based on their relationship with the outcome.

```r
# Define parameters
param1 <- MulticoreParam(workers = 1)
param2 <- MulticoreParam(workers = 4) # Adjust based on available cores

result <- BioMM(trainData = studyData, 
                stratify = "pathway", 
                pathlistDB = goDB, 
                featureAnno = cpgAnno,
                supervisedStage1 = TRUE,
                classifier1 = "randForest", 
                classifier2 = "randForest",
                predMode1 = "classification", 
                predMode2 = "classification",
                paramlist1 = list(ntree = 300), 
                paramlist2 = list(ntree = 300),
                resample1 = "BS", 
                resample2 = "CV",
                FScore = param1, 
                innerCore = param2)

# View performance metrics (AUC, ACC, R2)
print(result)
```

### Unsupervised Workflow (PCA)
Use PCA at Stage 1 to reconstruct pathway-level data without using the outcome labels initially.

```r
result <- BioMM(trainData = studyData,
                stratify = "chromosome",
                supervisedStage1 = FALSE,
                typePCA = "regular",
                classifier2 = "randForest",
                predMode2 = "classification")
```

### Supported Classifiers
- `randForest`: Random Forest (via `ranger`).
- `SVM`: Support Vector Machines (via `e1071`).
- `glmnet`: Lasso, Ridge, or Elastic Net (set `alpha` in `paramlist`).

## Stage-2 Data Exploration and Visualization

After Stage 1, you can analyze the "latent variables" (Stage-2 data) to understand biological drivers.

### Reconstructing Stage-2 Data
Use `BioMMreconData()` to generate the latent variable matrix for manual inspection or custom modeling.

### Visualization
- **Variance Explained**: Plot the proportion of variance explained by each functional feature using Nagelkerke pseudo R-squared.
  ```r
  plotVarExplained(data = stage2data, posF = TRUE, stratify = "pathway")
  ```
- **Feature Ranking**: Rank and visualize the top outcome-associated functional patterns.
  ```r
  plotRankedFeature(data = stage2data, 
                    posF = TRUE, 
                    topF = 10, 
                    blocklist = pathlist, 
                    stratify = "pathway", 
                    rankMetric = "R2")
  ```

## Computational Tips
- **Parallelization**: BioMM is computationally intensive. Always use `BiocParallel` (e.g., `MulticoreParam`) to distribute tasks.
- **Feature Selection**: Use `FSmethod1` or `FSmethod2` (e.g., "wilcox") to reduce the number of features processed at each stage.
- **Data Modalities**: While designed for DNA methylation, BioMM works for any data that can be mapped to genes or pathways (SNPs, RNA-seq, etc.).

## Reference documentation
- [BioMMtutorial](./references/BioMMtutorial.md)