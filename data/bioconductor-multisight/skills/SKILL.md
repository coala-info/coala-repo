---
name: bioconductor-multisight
description: The multiSight package integrates and analyzes multi-omics datasets through differential expression analysis, feature selection, and enrichment mapping. Use when user asks to identify predictive biosignatures, perform multi-block sPLS-DA, run multi-omics over-representation analysis, or infer feature networks.
homepage: https://bioconductor.org/packages/3.13/bioc/html/multiSight.html
---

# bioconductor-multisight

## Overview
The `multiSight` package facilitates the integration and analysis of multiple omics datasets. It provides tools for both single-omic Differential Expression Analysis (DEA) and multi-omic feature selection using sPLS-DA (DIABLO). Key capabilities include identifying "biosignatures" (small subsets of predictive features), performing Over Representation Analysis (ORA) across 19 organisms, and generating multi-omics enrichment maps that pool p-values using Stouffer's method.

## Core Workflow

### 1. Data Preparation
Input data must consist of numerical matrices (features as columns, samples as rows) and a classes vector.
```r
library(multiSight)
data("omic2", package = "multiSight")

# Split data into training and testing sets
splitData <- splitDatatoTrainTest(omic2, freq = 0.8)
data.train <- splitData$data.train
data.test <- splitData$data.test
```

### 2. Classification and Feature Selection
`multiSight` supports two primary methods for selecting relevant biological features:

**Single-Omic (biosigner):**
Uses SVM and Random Forest to find small biosignatures for each dataset independently.
```r
biosignerRes <- runSVMRFmodels_Biosigner(data.train)
biosignerFeats <- biosignerRes$biosignature
# Assess performance
perf <- assessPerformance_Biosigner(biosignerRes$model, data.test)
```

**Multi-Omic (sPLS-DA/DIABLO):**
Uses a multi-block approach to select features that explain the biological outcome across all omics.
```r
# diabloRes <- runSPLSDA(data.train)
data("diabloRes", package = "multiSight") # Example pre-computed
diabloFeats <- diabloRes$biosignature
```

### 3. Biological Insights (Enrichment)
Enrichment requires converting feature IDs to Entrez IDs and selecting an organism database (e.g., `org.Mm.eg.db`).

**Conversion and Enrichment:**
```r
# Define source ID types for each block
dbList <- list(rnaRead = "ENSEMBL", dnaRead = "ENSEMBL")

# Convert to Entrez
convFeat <- convertToEntrezid(diabloFeats, dbList, "org.Mm.eg.db")

# Run Multi-Omics Enrichment
multiOmicRes <- runMultiEnrichment(
    omicSignature = convFeat,
    databasesChosen = c("reactome", "kegg", "BP"),
    organismDb = "org.Mm.eg.db"
)

# Access results (includes Stouffer pooled p-values)
reacRes <- multiOmicRes$pathways$reactome
# reacRes$result$multi contains the multi-omics table
```

### 4. Network Inference
Build networks to visualize relationships between selected features using correlation, partial correlation, or mutual information.
```r
# Extract data for selected features
concatMat <- getDataSelectedFeatures(omic2, diabloFeats)

# Inference methods
corrNet <- correlationNetworkInference(concatMat, threshold = 0.85)
pcorNet <- partialCorrelationNI(concatMat, threshold = 0.4)
miNet   <- mutualInformationNI(concatMat, threshold = 0.2)

# Plot graph
plot(corrNet$graph)
```

## Supported Organisms
The package supports 19 `orgDb` packages, including:
- Human (`org.Hs.eg.db`)
- Mouse (`org.Mm.eg.db`)
- Rat (`org.Rn.eg.db`)
- Zebrafish (`org.Dr.eg.db`)
- Yeast (`org.Sc.sgd.db`)

## Tips for Success
- **Feature Names**: Ensure feature names in your matrices match the ID type specified in `dbList` (e.g., SYMBOL, ENSEMBL).
- **Stouffer's Method**: This is used to merge p-values for biological processes shared between different omics, highlighting pathways that are consistently altered across layers.
- **Enrichment Map**: Use the `enrichMap` element in the enrichment results to visualize pathway clusters.

## Reference documentation
- [multiSight quick start guide](./references/multiSight.md)
- [multiSight RMarkdown Source](./references/multiSight.Rmd)