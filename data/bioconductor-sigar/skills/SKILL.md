---
name: bioconductor-sigar
description: This tool performs integrative statistical analysis of multi-platform genomic data, specifically focusing on the relationship between DNA copy number alterations and gene expression levels. Use when user asks to match features across genomic platforms, visualize joint copy number and expression profiles, perform gene-wise cis-effect testing, or model regional co-expression using random coefficients.
homepage: https://bioconductor.org/packages/3.6/bioc/html/sigaR.html
---


# bioconductor-sigar

name: bioconductor-sigar
description: Statistical analysis for integrative genomics in R. Use this skill to integrate DNA copy number (aCGH) and gene expression data, including feature matching, joint visualization, gene-wise cis-effect testing, regional random coefficients modeling, and pathway-level mutual information analysis.

## Overview
The `sigaR` package provides tools for the integrative analysis of multi-platform genomic data. It specifically focuses on the relationship between DNA copy number alterations (CNA) and mRNA expression levels. Key capabilities include matching features across platforms, detecting cis-effects (where copy number changes drive expression), modeling regional co-expression using random coefficients, and assessing pathway-level associations using information-theoretic measures like entropy and mutual information.

## Core Workflows

### 1. Data Preparation and Matching
Integrative analysis requires aligning features (genes/clones) from different platforms based on genomic coordinates.

```R
library(sigaR)
data(pollackCN16) # cghCall object
data(pollackGE16) # ExpressionSet object

# Order objects genomically
pollackCN16 <- cghCall2order(pollackCN16, chr=1, bpstart=2)
pollackGE16 <- ExpressionSet2order(pollackGE16, chr=1, bpstart=2)

# Match features based on distance
matchIDs <- matchCGHcall2ExpressionSet(pollackCN16, pollackGE16, 
                                        CNchr=1, CNbpstart=2, CNbpend=3, 
                                        GEchr=1, GEbpstart=2, GEbpend=3, 
                                        method = "distance")

# Subset to matched features
pollackCN16 <- cghCall2subset(pollackCN16, matchIDs[,1])
pollackGE16 <- ExpressionSet2subset(pollackGE16, matchIDs[,2])
```

### 2. Joint Visualization
Visualize the relationship between copy number and expression across samples or within individual profiles.

```R
# Simultaneous heatmaps
CNGEheatmaps(pollackCN16, pollackGE16, location = "mode", colorbreaks = "equiquantiles")

# Overlaid profiles for a specific sample (e.g., sample index 23)
profilesPlot(pollackCN16, pollackGE16, 23)
```

### 3. Gene-wise Cis-effect Analysis
Identify individual genes where DNA copy number changes significantly influence expression levels.

```R
# 1. Pre-test and tune to select informative genes
genes2test <- cisEffectTune(pollackCN16, pollackGE16, "wmw", 
                            nGenes = 100, nPerm = 250, minCallProbMass = 0.10)

# 2. Perform the test (univariate Wilcoxon-Mann-Whitney)
cisTestResults <- cisEffectTest(pollackCN16, pollackGE16, genes2test, 1,
                                "univariate", "wmw", nPerm = 10000)

# 3. View results
cisEffectTable(cisTestResults, number=10, sort.by="p.value")
```

### 4. Regional Random Coefficients Model
Model regional co-expression where a set of contiguous genes share a DNA copy number signature.

```R
# Identify features in a region
featureNo <- 240
ids <- getSegFeatures(featureNo, pollackCN16)

# Prepare data
Y <- t(exprs(pollackGE16)[ids,]) # Expression (centered)
Y <- sweep(Y, 2, apply(Y, 2, mean))
X <- matrix(as.numeric(segmented(pollackCN16)[featureNo,]), ncol=1) # Segmented CN
R <- matrix(1, ncol=1) # Constraints

# Estimate model
RCMresult <- RCMestimation(Y, X, R)
summary(RCMresult)

# Test for shared effect
RCMtestResult <- RCMtest(Y, X, R, testType="II")
summary(RCMtestResult)
```

### 5. Pathway and Entropy Analysis
Assess associations within gene sets (pathways) using Mutual Information (MI).

```R
X <- t(copynumber(pollackCN16))
Y <- t(exprs(pollackGE16))

# Calculate Mutual Information
mi_val <- hdMI(Y, X, method="knn")

# Test significance of association
MItestResults <- mutInfTest(Y, X, nPerm=100, method="knn")
summary(MItestResults)
```

## Tips and Best Practices
- **Statistical Units**: Choose the appropriate unit (Gene, Region, or Pathway) based on the biological question.
- **Data Types**: `sigaR` functions handle different types of CN data (normalized, segmented, or called). Ensure the `method` parameter in tests matches the data type (e.g., "wmw" for call probabilities).
- **Filtering**: Use `cisEffectTune` to remove genes with low variation or unbalanced call probabilities to increase statistical power and reduce FDR.
- **Directionality**: The package assumes a concordant relationship (CN gain leads to expression increase) and allows incorporating these constraints in the Random Coefficients Model.

## Reference documentation
- [sigaR](./references/sigaR.md)