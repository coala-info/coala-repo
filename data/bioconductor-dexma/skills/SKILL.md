---
name: bioconductor-dexma
description: The DExMA package performs gene expression meta-analysis by integrating multiple datasets while addressing the missing gene problem through imputation or filtering. Use when user asks to perform effect size or p-value combination meta-analysis, handle missing genes across different expression platforms, or test for study heterogeneity.
homepage: https://bioconductor.org/packages/release/bioc/html/DExMA.html
---


# bioconductor-dexma

## Overview
The `DExMA` package provides a robust framework for performing gene expression meta-analysis. It is particularly effective at handling the "missing gene" problem—where different studies use different platforms or annotations—by either imputing missing values using the K-Nearest Neighbors (KNN) algorithm or filtering genes based on their frequency across datasets. It supports the three main types of meta-analysis: effect size combination, p-value combination, and heterogeneity analysis.

## Core Workflow

### 1. Data Preparation and Object Creation
DExMA requires a specific `objectMA` (a list of nested lists). Each study must contain an expression matrix and a group vector (0 for control, 1 for case).

```r
library(DExMA)
library(Biobase)

# Create the meta-analysis object from lists of matrices and phenodata
# namePheno: column name in phenodata identifying groups
# expGroups/refGroups: labels for cases and controls
phenoGroups <- c("condition", "condition")
phenoCases <- list(Study1 = "Diseased", Study2 = "ill")
phenoControls <- list(Study1 = "Healthy", Study2 = "control")

maObject <- createObjectMA(listEX = listMatrixEX, 
                           listPheno = listPhenodatas, 
                           namePheno = phenoGroups, 
                           expGroups = phenoCases, 
                           refGroups = phenoControls)

# To add a single new dataset later:
newElem <- elementObjectMA(expressionMatrix = ExpressionSetStudy5, 
                           groupPheno = "condition", 
                           expGroup = "Diseased", 
                           refGroup = "Healthy")
maObject[[5]] <- newElem
```

### 2. Pre-processing and Quality Control
Before analysis, ensure all datasets use the same gene identifiers and are on a log2 scale.

```r
# Standardize IDs (options: "Entrez", "Ensembl", "GeneSymbol")
maObject <- allSameID(maObject, finalID = "GeneSymbol", organism = "Homo sapiens")

# Ensure log2 transformation
maObject <- dataLog(maObject)

# Study heterogeneity to choose between Fixed (FEM) and Random (REM) effects
heterogeneityTest(maObject)
```

### 3. Handling Missing Genes
You can either impute missing values or set a threshold for gene inclusion during the meta-analysis step.

```r
# Optional: Impute missing genes using KNN
imputation <- missGenesImput(maObject, k = 7)
maObject_imputed <- imputation$objectMA
```

### 4. Performing Meta-Analysis
The `metaAnalysisDE()` function is the primary interface for all combination methods.

```r
# Effect Size Methods: "FEM" or "REM"
resultsREM <- metaAnalysisDE(maObject, typeMethod = "REM", proportionData = 0.5)

# P-value Methods: "Fisher", "Stouffer", "maxP", "minP", "ACAT"
resultsFisher <- metaAnalysisDE(maObject, typeMethod = "Fisher", proportionData = 0.8)
```

**Key Output Columns:**
- `Com.ES`: Combined Effect Size.
- `Zval`: Z-score (positive = overexpressed in cases).
- `Pval` / `FDR`: Significance and adjusted p-value.
- `AveFC`: Weighted average log Fold-Change.
- `Qpval`: P-value for heterogeneity (low values suggest REM is more appropriate than FEM).

### 5. Visualization
Visualize significant genes across all studies.

```r
makeHeatmap(objectMA = maObject, 
            resMA = resultsREM, 
            scaling = "zscor", 
            regulation = "all", 
            numSig = 40, 
            fdrSig = 0.05, 
            logFCSig = 1.5)
```

## Advanced Features

### Batch Effect Removal
If studies have internal batch effects (e.g., gender, race), correct them before creating the `objectMA`.

```r
listMatrixEX$Study2 <- batchRemove(listMatrixEX$Study2, 
                                   listPhenodatas$Study2, 
                                   formula = ~gender + race, 
                                   mainCov = "race", 
                                   nameGroup = "condition")
```

### Downloading Public Data
Directly fetch datasets from NCBI GEO.

```r
GEOobjects <- c("GSE4588", "GSE10325")
dataGEO <- downloadGEOData(GEOobjects)
# Returns a list of ExpressionSets ready for createObjectMA()
```

## Reference documentation
- [Differential Expression Meta-Analysis with DExMA package](./references/DExMA.md)