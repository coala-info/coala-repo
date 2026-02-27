---
name: bioconductor-phenodist
description: This package calculates phenotypic distances and performs functional clustering for image-based high-throughput screening data. Use when user asks to measure phenotypic similarity between treatments, identify phenotypes relative to negative controls, assess replicate reproducibility, or perform gene enrichment analysis on phenotypic clusters.
homepage: https://bioconductor.org/packages/3.6/bioc/html/phenoDist.html
---


# bioconductor-phenodist

name: bioconductor-phenodist
description: Analysis of phenotypic distance in image-based high-throughput screening (HTS). Use this skill to calculate distances between treatments (RNAi, small molecules), identify phenotypes relative to negative controls, and perform functional clustering of genes based on image features.

## Overview

The `phenoDist` package provides tools for measuring phenotypic similarity in high-content screening data. It bridges the gap between image quantification (via `imageHTS`) and biological interpretation. Key capabilities include calculating distance matrices using various methods (PCA, SVM accuracy, Factor Analysis), assessing replicate reproducibility, and performing gene enrichment analysis on phenotypic clusters.

## Core Workflow

### 1. Data Preparation
`phenoDist` typically operates on `imageHTS` objects. Ensure the screen is configured and features are extracted before starting.

```R
library(phenoDist)
library(imageHTS)

# Assuming 'x' is a configured imageHTS object and 'unames' are well identifiers
profiles <- summarizeWells(x, unames, "conf/featurepar.txt")
```

### 2. Calculating Phenotypic Distance
Distance measures quantify how similar two treatments are. Two primary methods are Euclidean distance (on PCA-transformed data) and SVM classification accuracy.

**PCA and Euclidean Distance:**
```R
# selectedWellFtrs is a vector of feature names
pcaPDM <- PDMByWellAvg(profiles, 
                       selectedWellFtrs = selectedWellFtrs, 
                       transformMethod = "PCA", 
                       distMethod = "euclidean", 
                       nPCA = 30)
```

**SVM Classification Accuracy:**
This method measures how well a classifier can distinguish between two cell populations.
```R
svmAccPDM <- PDMBySvmAccuracy(x, unames, 
                              selectedCellFtrs = selectedCellFtrs, 
                              cross = 5, cost = 1, 
                              gamma = 2^-5, kernel = "radial")
```

### 3. Quality Control and Reproducibility
Assess the reliability of the screen by checking if technical replicates are more similar to each other than to other wells.

```R
# Rank 1 indicates perfect reproducibility
ranking <- repDistRank(x, distMatrix = svmAccPDM)
summary(ranking)
```

### 4. Phenotype Identification
Calculate the distance of each treatment from the negative control (e.g., 'rluc') to determine the strength of the phenotype.

```R
# Calculate distance to negative control
pheno <- distToNeg(x, distMatrix = svmAccPDM, neg = "rluc")

# Calculate Z'-factor for separation between positive and negative controls
zFactor <- ctlSeparatn(x, pheno, neg = "rluc", pos = "ubc", method = "robust")

# Calculate replicate correlation
correlation <- repCorr(x, pheno)
```

### 5. Clustering and Enrichment
Group treatments with similar phenotypes to identify functional relationships.

```R
# Hierarchical clustering
phenoCluster <- clusterDist(x, distMatrix = svmAccPDM, 
                            clusterFun = "hclust", 
                            method = "ward")

# GO Enrichment on clusters (requires GOstats)
library(GOstats)
GOEnrich <- enrichAnalysis(x, cl = cutree(phenoCluster, k = 5), 
                           ontology = "BP", 
                           annotation = "org.Hs.eg.db")
```

## Tips for Success
- **Feature Selection**: The choice of `selectedWellFtrs` or `selectedCellFtrs` significantly impacts distance calculations. Use pre-validated feature sets when available.
- **SVM Performance**: `PDMBySvmAccuracy` is computationally intensive. For large screens, consider running on a subset or using PCA-based methods for initial exploration.
- **Symmetry**: SVM-based distance matrices may not be perfectly symmetric due to random sampling in cross-validation; this is normal and usually negligible.

## Reference documentation
- [phenoDist](./references/phenoDist.md)