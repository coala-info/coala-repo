---
name: bioconductor-vsclust
description: This tool performs variance-sensitive fuzzy c-means clustering on quantitative omics data to identify patterns while accounting for measurement uncertainty. Use when user asks to perform variance-sensitive clustering, estimate the optimal number of clusters, or identify common patterns in replicated omics data.
homepage: https://bioconductor.org/packages/release/bioc/html/vsclust.html
---

# bioconductor-vsclust

name: bioconductor-vsclust
description: Variance-sensitive clustering (VSClust) for quantitative omics data. Use this skill to perform fuzzy c-means clustering that accounts for feature variance (uncertainty) from replicated measurements. Ideal for analyzing patterns in RNA-seq, proteomics, or metabolomics data stored in standard R matrices or Bioconductor objects like SummarizedExperiment, QFeatures, and MultiAssayExperiment.

# bioconductor-vsclust

## Overview
`vsclust` is an R package designed to identify common patterns in high-dimensional data while accounting for measurement uncertainty. Unlike standard clustering algorithms, VSClust uses replicated measurements to estimate feature-specific variance, allowing it to down-weight or filter out highly variable features that do not reliably fit a cluster profile.

## Core Workflow

### 1. Data Preparation
The package requires quantitative data where replicates are organized consecutively (e.g., A1, A2, B1, B2...).

```r
library(vsclust)

# For standard data frames/matrices
# statOut contains $dat (means + SD column) and $statFileOut (LIMMA results)
statOut <- PrepareForVSClust(data_matrix, 
                             NumReps = 3, 
                             NumCond = 4, 
                             isPaired = FALSE, 
                             isStat = TRUE)

# For Bioconductor objects (SummarizedExperiment/MultiAssayExperiment)
statOut <- PrepareSEForVSClust(se_object, 
                               assayname = "logcounts", 
                               coldatname = "Condition", 
                               isPaired = FALSE, 
                               isStat = TRUE)
```

### 2. Estimating Cluster Number
VSClust uses validity indices (Maximum Centroid Distance and Xie Beni index) to suggest the optimal number of clusters.

```r
# Run estimation across a range (e.g., up to 10 clusters)
ClustInd <- estimClustNum(statOut$dat, maxClust = 10, cores = 1)

# Retrieve suggested numbers
k_vsclust <- optimalClustNum(ClustInd)
k_standard <- optimalClustNum(ClustInd, method = "FCM")

# Visualize indices
estimClust.plot(ClustInd)
```

### 3. Running the Clustering
Execute the final clustering using the variance-sensitive algorithm.

```r
ClustOut <- runClustWrapper(statOut$dat, 
                            PreSetNumClust = k_vsclust, 
                            VSClust = TRUE, 
                            scaling = "standardize")

# Access results
best_cluster_assignment <- ClustOut$Bestcl$cluster
membership_scores <- ClustOut$Bestcl$membership
centroids <- ClustOut$Bestcl$centers
```

### 4. Functional Enrichment
Integrate with STRINGdb and clusterProfiler for biological interpretation.

```r
# Retrieve KEGG/GO enrichment via STRING API
ClustEnriched <- runFuncEnrich(ClustOut$Bestcl, infosource = "KEGG")

# Plot results using clusterProfiler
library(clusterProfiler)
dotplot(ClustEnriched$redFuncs, showCategory = 10)
```

## Key Parameters & Tips
- **Variance Column**: If you have pre-calculated standard deviations, append them as the last column of your data matrix and set `isStat = FALSE` in preparation functions.
- **Scaling**: Use `scaling = "standardize"` in `runClustWrapper` to focus on profile shapes rather than absolute magnitude.
- **Membership Threshold**: A common practice is to consider a feature a "solid" member of a cluster if its membership score is > 0.5.
- **Missing Values**: Ensure data is log-transformed and handle infinite values (e.g., `logminiACC[!is.finite(logminiACC)] <- NA`) before processing.

## Reference documentation
- [Integrate With Bioconductor Objects](./references/Integrate_With_Bioconductor_Objects.md)
- [Run VSClust Workflow](./references/Run_VSClust_Workflow.md)