---
name: bioconductor-arraytools
description: This tool performs comprehensive analysis of Affymetrix GeneChip data including quality assessment, preprocessing, and differential expression analysis. Use when user asks to analyze Affymetrix 3' or Gene 1.0-ST arrays, perform gene filtering, run linear modeling for differential expression, or generate automated HTML reports.
homepage: https://bioconductor.org/packages/3.5/bioc/html/ArrayTools.html
---

# bioconductor-arraytools

name: bioconductor-arraytools
description: Comprehensive analysis of Affymetrix GeneChip data (3' arrays and Gene 1.0-ST arrays). Use this skill to perform quality assessment, data preprocessing, filtering, and differential expression analysis with automated HTML report generation.

# bioconductor-arraytools

## Overview

The `ArrayTools` package provides a streamlined workflow for analyzing Affymetrix gene expression data. It is specifically designed to handle both traditional 3' arrays and the newer Gene 1.0-ST arrays. The package automates complex statistical tasks—including design matrix construction, regression, and interaction testing—and outputs results as interactive HTML reports with links to biological databases.

## Core Workflow

### 1. Data Initialization
Create an `ExpressionSet` from your expression matrix and phenotype data. For Gene 1.0-ST arrays, specify the correct annotation.

```R
library(ArrayTools)
# Load your data (exprsExample and pDataExample are provided as examples)
rownames(exprsExample) <- exprsExample$probeset_id
eSet <- createExpressionSet(pData=pDataExample, 
                            exprs=exprsExample, 
                            annotation="hugene10sttranscriptcluster")
```

### 2. Preprocessing and Quality Assessment
Preprocessing handles log2 transformation and control gene removal. Quality assessment requires a QC metric file (generated via Affymetrix Expression Console).

*   **For Gene 1.0-ST Arrays:**
    ```R
    normal <- preProcessGeneST(eSet, output=TRUE)
    qaGeneST(normal, c("Treatment", "Group"), QC)
    ```
*   **For 3' Arrays:**
    Use `preProcess3prime(affyBatch, method="rma")` and `qa3prime(affyBatch)`.

### 3. Filtering
Remove uninformative genes based on inter-quartile range (IQR) and background intensity.
```R
filtered <- geneFilter(normal, numChip = 2, bg = 4, iqrPct=0.1, output=TRUE)
```

### 4. Differential Expression Analysis
Analysis follows a linear modeling approach: Design -> Contrast -> Regress -> Select.

*   **Define Design and Contrast:**
    ```R
    # One-way ANOVA
    design1 <- new("designMatrix", target=pData(filtered), covariates = "Treatment")
    contrast1 <- new("contrastMatrix", design.matrix = design1, compare1 = "Treated", compare2 = "Control")

    # Randomized Block Design (controlling for Group)
    design2 <- new("designMatrix", target=pData(filtered), covariates = c("Treatment", "Group"))
    contrast2 <- new("contrastMatrix", design.matrix = design2, compare1 = "Treated", compare2 = "Control")
    ```

*   **Run Regression and Selection:**
    ```R
    result1 <- regress(filtered, contrast1)
    sigResult1 <- selectSigGene(result1, p.value=0.05, fc.value=log2(1.5))
    
    # Sort results
    Sort(sigResult1, sorted.by = "pValue")
    ```

### 5. Detecting Interaction Effects
Use this when the treatment effect might differ across levels of another variable (e.g., Group).
```R
designInt <- new("designMatrix", target=pData(filtered), covariates = c("Treatment", "Group"), intIndex=c(1,2))
contrastInt <- new("contrastMatrix", design.matrix = designInt, interaction = TRUE)
resultInt <- regress(filtered, contrastInt)
sigResultInt <- selectSigGene(resultInt, p.value=0.05, fc.value=log2(1.5))

# Post-interaction analysis to separate genes with/without interaction
intResult <- postInteraction(filtered, sigResultInt, mainVar ="Treatment", compare1 = "Treated", compare2 = "Control")
sigResultIntFinal <- selectSigGeneInt(intResult, pGroup = 0.05, pMain = 0.05)
```

### 6. Generating Reports
The package generates HTML tables and an index file to navigate all results.
```R
Output2HTML(sigResult1)
createIndex(sigResult1, sigResult2, intResult)
```

## Tips and Constraints
*   **Annotations:** For Gene 1.0-ST, only `hugene10sttranscriptcluster` and `mogene10sttranscriptcluster` are supported.
*   **Log Transformation:** `preProcessGeneST` adds an offset of 1 before log2 transformation by default.
*   **Output:** Many functions have an `output = TRUE` argument to save intermediate processed data to the local directory.

## Reference documentation
- [ArrayTools](./references/ArrayTools.md)