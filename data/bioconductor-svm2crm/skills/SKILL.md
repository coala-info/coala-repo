---
name: bioconductor-svm2crm
description: SVM2CRM is a computational pipeline that uses Support Vector Machines and feature selection to identify cis-regulatory elements like enhancers and promoters from ChIP-seq data. Use when user asks to predict cis-regulatory elements, perform feature selection on histone modification data, or tune SVM parameters for genomic region classification.
homepage: https://bioconductor.org/packages/3.8/bioc/html/SVM2CRM.html
---

# bioconductor-svm2crm

## Overview

SVM2CRM is a computational pipeline designed to identify cis-regulatory elements (CREs) like enhancers and promoters using ChIP-seq data. It addresses the challenge of selecting the optimal set of histone modifications for prediction. The package utilizes Support Vector Machines (SVM) via the LibLinear library and includes a specialized feature selection step based on k-means clustering and the Index Coverage of Regulatory Regions (ICRR).

## Core Workflow

### 1. Data Pre-processing
Import signal data from BED files. The package normalizes signals into bins and windows.

```r
library(SVM2CRM)
library(SVM2CRMdata)

# Define parameters
chr <- "chr1"
bin.size <- 100
windows <- 1000

# Import signals (example using package data)
# cisREfindbed creates a data.frame with histone marks in columns
list_file <- grep(dir(), pattern=".bz2", value=TRUE)
# completeTABLE <- cisREfindbed(list_file=list_file, chr=chr, bin.size=bin.size, windows=windows)
```

### 2. Training Set Generation
Generate positive (known enhancers, e.g., p300 sites) and negative (random background) training sets.

```r
# Get signals for specific genomic coordinates
# reference: path to bed file with coordinates
train_pos <- getSignal(list_file, chr="chr1", reference="enhancers.txt", win.size=500, bin.size=100)
train_neg <- getSignal(list_file, chr="chr1", reference="random_regions.txt", win.size=500, bin.size=100)

training_set <- rbind(train_pos, train_neg)
```

### 3. Feature Selection
Reduce the number of histone marks to avoid redundancy and noise using `smoothInputFS` and `featSelectionWithKmeans`.

```r
# 1. Smooth signals
listcolnames <- c("H3K4me1", "H3K4me2", "H3K27ac")
dftotann <- smoothInputFS(train_pos[,c(6:ncol(train_pos))], listcolnames, k=20)

# 2. K-means and ICRR calculation
# nk: number of clusters
results <- featSelectionWithKmeans(dftotann, nk=5)
resultsFS <- results[[7]] # Contains ICRR values

# 3. Filter by ICRR (lower values indicate better discrimination)
resultsFSfilter <- resultsFS[which(resultsFS[,3] < 0.26), ]
listHM <- resultsFSfilter[,1]
```

### 4. SVM Parameter Tuning
Find the best combination of histone marks and SVM parameters (cost, kernel type) using `tuningParametersCombROC`.

```r
# typeSVM: 0 (L2-reg logistic regression) to 7 (L2-reg logistic regression dual)
# costV: cost of constraints violation
tuningTAB <- tuningParametersCombROC(
  training_set = training_set, 
  typeSVM = 0, 
  costV = 100, 
  different.weight = "TRUE", 
  vecS = 2, # Number of histone marks in combination
  pcClass = 100, # Positive class size
  ncClass = 400, # Negative class size
  infofile = infofile
)

# Select model with best F-score
tuningTABfilter <- tuningTAB[(tuningTAB$fscore < 0.95), ]
row_max <- which.max(tuningTABfilter[,"fscore"])
```

### 5. Genome-Wide Prediction
Apply the trained model to predict putative enhancers across the genome.

```r
predictionGW(
  training_set = training_set,
  data_enhancer_svm = data_enhancer_svm, 
  listHM = columnPR, # Selected histone marks
  pcClass.string = "enhancers",
  nClass.string = "not_enhancers",
  cost = 100,
  type = 0,
  "output_filename"
)
```

## Key Functions
- `cisREfindbed`: Imports and bins ChIP-seq signals from BED files.
- `getSignal`: Extracts signals around specific genomic features for training.
- `featSelectionWithKmeans`: Performs variable selection using k-means and ICRR.
- `tuningParametersCombROC`: Iterates through combinations of marks and SVM parameters to find optimal performance.
- `predictionGW`: Executes the final prediction and outputs a BED file of results.

## Reference documentation
- [SVM2CRM](./references/SVM2CRM.md)