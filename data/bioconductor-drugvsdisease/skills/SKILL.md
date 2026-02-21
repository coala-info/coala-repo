---
name: bioconductor-drugvsdisease
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DrugVsDisease.html
---

# bioconductor-drugvsdisease

name: bioconductor-drugvsdisease
description: Use this skill to compare drug and disease gene expression profiles using the DrugVsDisease R package. It is used for drug repurposing (identifying negatively correlated profiles) and inferring side-effects (identifying positively correlated profiles). Use this skill when you need to: (1) Download and process microarray data from ArrayExpress or GEO, (2) Generate ranked differential expression profiles, (3) Perform Gene Set Enrichment Analysis (GSEA) against reference drug/disease datasets, and (4) Cluster profiles to identify functional similarities.

## Overview

The `DrugVsDisease` package provides a pipeline for comparing gene expression signatures between diseases and drugs. It automates the process of converting probe-level data to gene-level rankings and uses GSEA to find significant correlations. Negatively correlated profiles suggest potential therapeutic candidates (drug reverses disease signature), while positively correlated profiles suggest potential side effects or shared mechanisms.

## Typical Workflow

### 1. Data Import and Profile Generation
The `generateprofiles` function is the primary entry point. It handles normalization (RMA or MAS5) and calculates differential expression using `limma`.

```R
library(DrugVsDisease)

# From ArrayExpress (AE)
profileAE <- generateprofiles(input="AE", accession="E-GEOD-22528")

# From Gene Expression Omnibus (GEO)
# Note: 'case' defaults to "disease"; use "compound" for drug studies
profileGEO <- generateprofiles(input="GEO", accession="GDS1479", annotation="hgu133a")

# From Local Files
# Requires a 'customfile' mapping CEL names to 'disease' or 'compound' columns
profileLocal <- generateprofiles(input="local", celfilepath="./data/", customfile="mapping.txt")
```

### 2. Selecting Relevant Contrasts
`generateprofiles` fits all possible pairwise contrasts. You must select the specific comparison (e.g., Disease vs. Control) for downstream analysis.

```R
# View available contrasts
colnames(profileAE$ranklist)

# Select the first contrast
selprofiles <- selectrankedlists(profileAE, 1)
```

### 3. Classifying Profiles (Enrichment Analysis)
The `classifyprofile` function compares your ranked list against reference datasets (defaulting to Connectivity Map data).

```R
# Basic classification with default drug clusters
# signif.fdr: FDR threshold for significant matches
results <- classifyprofile(data=selprofiles$ranklist, signif.fdr=0.05)

# Using different gene set selection methods:
# 'fixed': top N genes (default 100)
# 'range': test multiple set sizes
# 'dynamic': use p-values to determine set size
c_dynamic <- classifyprofile(data=selprofiles$ranklist, 
                             pvalues=selprofiles$pvalues, 
                             type="dynamic", 
                             dynamic.fdr=0.05)
```

### 4. Clustering and Visualization
Profiles can be assigned to clusters using single linkage (default) or average linkage.

```R
# Average linkage clustering using median statistic
clustered <- classifyprofile(data=selprofiles$ranklist, 
                             clustermethod="average", 
                             avgstat="median")

# Generate Cytoscape compatible files (.sif and edge attributes)
classifyprofile(data=selprofiles$ranklist, 
                cytoout=TRUE, 
                cytofile="MyAnalysis")
```

## Key Parameters and Tips

- **Statistic**: In `generateprofiles`, use `statistic="t"` to use t-statistics instead of the default log fold change.
- **Normalization**: Choose between `normalisation="rma"` (default) or `"mas5"`.
- **Custom References**: You can provide your own reference database using `customRefDB` and `customClusters` arguments in `classifyprofile`.
- **RPS Sign**: In the output, a Running Sum Peak Sign (RPS) of `-1` indicates negative correlation (potential drug for the disease), while `1` indicates positive correlation.
- **Data Dependencies**: This package requires the `DvDdata` package for default reference profiles and clusters.

## Reference documentation

- [DrugVsDisease](./references/DrugVsDisease.md)