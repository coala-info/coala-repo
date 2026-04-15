---
name: bioconductor-desousa2013
description: This package provides a pipeline for the molecular classification of colon cancer into three distinct subtypes using microarray data. Use when user asks to identify colon cancer subtypes, perform consensus clustering, build a PAM classifier, or conduct survival analysis on colorectal cancer datasets.
homepage: https://bioconductor.org/packages/release/data/experiment/html/DeSousa2013.html
---

# bioconductor-desousa2013

name: bioconductor-desousa2013
description: Molecular classification of colon cancer using the DeSousa2013 Bioconductor package. Use this skill to reproduce the identification of three distinct colon cancer subtypes (CCS1, CCS2, CCS3) from microarray data, perform GAP statistic calculations, consensus clustering, PAM classifier construction, and survival analysis.

## Overview

The DeSousa2013 package provides the data and pipeline used to identify three molecularly distinct subtypes of colon cancer. It is primarily built around the AMC-AJCCII-90 dataset (90 stage II colon cancer patients). The package allows users to perform the entire bioinformatic workflow from raw microarray preprocessing to clinical characterization via survival analysis.

## Core Workflow

### 1. Loading Data and Pipeline Execution
The simplest way to run the entire analysis is using the `CRCPipeLine` function.

```r
library(DeSousa2013)
data(AMC)

# Run the full pipeline (skipping preprocessing by default for speed)
CRCPipeLine(celpath=".", 
            AMC_sample_head, 
            AMC_CRC_clinical, 
            preprocess=FALSE, 
            savepath=".")
```

### 2. Subtype Identification Steps

If running steps manually for finer control:

**Preprocessing and GAP Statistic:**
Determine the optimal number of clusters (k) using the GAP statistic.
```r
# Load preprocessed data if not running geneExpPre
data(AMC)
# ge.CRC is the expression matrix
gaps <- compGapStats(ge.CRC, ntops=c(2, 4, 8, 12, 16, 20)*1000, K.max=6, nboot=100)
figGAP(gaps[["gapsmat"]], gaps[["gapsSE"]])
```

**Consensus Clustering:**
Identify stable clusters using the most variable probesets.
```r
# Select top variable genes (MAD > 0.5)
sdat <- selTopVarGenes(ge.CRC, MADth=0.5)

# Perform consensus clustering
clus <- conClust(sdat, maxK=12, reps=1000)
```

**Feature Selection:**
Filter for the most predictive genes using SAM (Significance Analysis of Microarrays) and AUC (Area Under Curve).
```r
# Collapse probesets to unique genes
uniGenes <- pbs2unigenes(ge.CRC, sdat)

# Filter samples with positive silhouette width
samp.f <- filterSamples(sdat, uniGenes, clus)
sdat.f <- samp.f[["sdat.f"]]
clus.f <- samp.f[["clus.f"]]

# Find differential genes (SAM)
diffGenes <- findDiffGenes(sdat.f, clus.f, pvalth=0.01)

# Filter by AUC (> 0.9)
diffGenes.f <- filterDiffGenes(sdat.f, clus.f, diffGenes, aucth=0.9)
```

### 3. Building and Applying the Classifier
Train a PAM (Prediction Analysis for Microarrays) classifier to categorize samples.
```r
sigMat <- sdat.f[diffGenes.f, names(clus.f)]
classifier <- buildClassifier(sigMat, clus.f, nfold=10, nboot=100)

# Classify samples
pamcl <- pamClassify(datsel, classifier[["signature"]], classifier[["pam.rslt"]], classifier[["thresh"]])
```

### 4. Survival Analysis
Characterize the prognosis of the identified subtypes. CCS3 typically shows significantly poorer disease-free survival (DFS).
```r
# Perform survival analysis
prog <- progAMC(AMC_CRC_clinical, AMC_sample_head, pamcl[["clu.pred"]])

# Plot Kaplan-Meier curves
figKM(prog[["surv"]], prog[["survstats"]])
```

## Key Functions
- `CRCPipeLine()`: Wrapper for the entire analysis.
- `geneExpPre()`: Preprocesses .CEL files using fRMA and ComBat.
- `compGapStats()`: Calculates GAP statistics to find the optimal number of clusters.
- `conClust()`: Performs consensus clustering.
- `buildClassifier()`: Trains the PAM classifier.
- `progAMC()`: Performs disease-free survival analysis on the AMC dataset.

## Reference documentation
- [DeSousa2013-Vignette](./references/DeSousa2013-Vignette.md)