---
name: bioconductor-knowseq
description: KnowSeq provides a comprehensive pipeline for processing and analyzing transcriptomic gene expression data from raw sequences to biological insights. Use when user asks to retrieve data from public repositories like GEO or GDC, perform differential expression analysis, remove batch effects, or identify biomarkers using machine learning models.
homepage: https://bioconductor.org/packages/release/bioc/html/KnowSeq.html
---


# bioconductor-knowseq

name: bioconductor-knowseq
description: Comprehensive transcriptomic analysis pipeline for gene expression data. Use when Claude needs to perform end-to-end RNA-seq or microarray analysis, including data retrieval from GEO/ArrayExpress/GDC, raw data alignment, batch effect removal, differential expression analysis (DEGs), machine learning-based biomarker assessment (k-NN, SVM, Random Forest), and biological enrichment (Gene Ontology, KEGG pathways, and disease association).

# bioconductor-knowseq

## Overview

KnowSeq is a modular and flexible R/Bioconductor package designed for transcriptomic gene expression analysis. It covers the entire pipeline from raw data processing to biological knowledge extraction. Its primary strength is the "Intelligent Automatic Report," which can execute and document the full workflow in a single HTML file. The pipeline is modular, allowing users to start at any step (e.g., starting with a count matrix or a pre-processed expression matrix).

## Installation

```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("KnowSeq")
library(KnowSeq)
```

## Core Workflow

### 1. Data Retrieval and Alignment
KnowSeq can download series from NCBI/GEO, ArrayExpress, or GDC Portal.

```R
# Download metadata and series
downloadPublicSeries(c("GSE74251"))
gse_csv <- read.csv("ReferenceFiles/GSE74251.csv")

# Raw alignment (requires 'utils' folder with hisat2/htseq-count)
rawAlignment(gse_csv, referenceGenome = 38, countFiles = TRUE)
```

### 2. Processing Count Files
Convert raw counts into a merged matrix and then into normalized gene expression values.

```R
# Merge count files into a matrix
countsInfo <- countsToMatrix("mergedCountsInfo.csv", extension = "count")
countsMatrix <- countsInfo$countsMatrix
labels <- countsInfo$labels

# Get gene annotations (Ensembl to Gene Symbol)
myAnnotation <- getGenesAnnotation(rownames(countsMatrix))

# Calculate normalized expression (CQN method)
expressionMatrix <- calculateGeneExpressionValues(countsMatrix, myAnnotation, genesNames = TRUE)
```

### 3. Batch Effect Removal
Essential when combining data from different series or platforms.

```R
# Using ComBat
expressionMatrixCorrected <- batchEffectRemoval(expressionMatrix, labels, 
                                               batchGroups = batchGroups, 
                                               method = "combat")

# Using SVA
expressionMatrixCorrected <- batchEffectRemoval(expressionMatrix, labels, method = "sva")
```

### 4. Differential Expressed Genes (DEGs) Extraction
Extract DEGs using limma with an optional "coverage" parameter for multiclass studies.

```R
DEGsInformation <- DEGsExtraction(expressionMatrixCorrected, labels, 
                                  lfc = 1.0, pvalue = 0.01, cov = 1)
topTable <- DEGsInformation$DEG_Results$DEGs_Table
DEGsMatrix <- DEGsInformation$DEG_Results$DEGs_Matrix
```

### 5. Machine Learning Assessment
Assess the robustness of DEGs as biomarkers using feature selection and classification.

```R
# Feature Selection (mRMR, Random Forest, or Disease Association 'da')
ranking <- featureSelection(t(DEGsMatrix), labels, colnames(t(DEGsMatrix)), mode = "mrmr")

# Cross-validation (k-NN, SVM, or RF)
results_cv <- knn_trn(t(DEGsMatrix), labels, names(ranking)[1:10], folds = 5)
```

### 6. Biological Enrichment
Retrieve functional information for the identified DEGs.

```R
# Gene Ontology (BP, MF, CC)
GOs <- geneOntologyEnrichment(names(ranking)[1:10], pvalCutOff = 0.1)

# KEGG Pathways
paths <- DEGsToPathways(names(ranking)[1:10])

# Disease Associations (via Open Targets/targetValidation)
diseases <- DEGsToDiseases(rownames(DEGsMatrix)[1:5], getEvidences = FALSE)
```

### 7. Automated Reporting
The fastest way to run the full pipeline and generate an HTML summary.

```R
knowseqReport(expressionMatrix, labels, 'my-study-report', 
              clasifAlgs = c('knn', 'rf'), 
              disease = 'breast-cancer', 
              lfc = 2, pvalue = 0.001, 
              geneOntology = TRUE, getPathways = TRUE)
```

## Data Visualization
The `dataPlot` function is a multipurpose tool for various pipeline stages:
- `mode = "boxplot"`: View sample normalization.
- `mode = "orderedBoxplot"`: View top DEGs expression across classes.
- `mode = "heatmap"`: Standard expression heatmap.
- `mode = "classResults"`: Plot ML metrics (Accuracy, Sensitivity, Specificity).
- `mode = "confusionMatrix"`: Visualize classification performance.

## Reference documentation
- [Transcriptomic Intelligent Pipeline: The KnowSeq user guide](./references/KnowSeq.md)