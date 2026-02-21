---
name: bioconductor-chrogps
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/chroGPS.html
---

# bioconductor-chrogps

name: bioconductor-chrogps
description: Visualization and functional analysis of epigenome maps using Multi-Dimensional Scaling (MDS) and Procrustes analysis. Use this skill to generate 2D/3D maps of epigenetic factors (chroGPSfactors) or genes (chroGPSgenes), integrate data from different sources (ChIP-seq vs. ChIP-chip), and perform cluster analysis on genomic intervals.

# bioconductor-chrogps

## Overview

The `chroGPS` package provides a "Global Positioning System" for the epigenome. It uses Multi-Dimensional Scaling (MDS) to translate similarities between epigenetic marks or genomic elements into spatial distances on a map. It is particularly useful for visualizing the relationship between different chromatin modifications, comparing datasets across different technologies or cell lines, and identifying functional gene clusters based on their epigenetic profiles.

## Core Workflows

### 1. chroGPSfactors: Mapping Epigenetic Elements
This workflow visualizes the association between different proteins or histone marks.

```R
library(chroGPS)
# 1. Prepare data (GRangesList of binding sites)
data(s2) 

# 2. Compute pairwise distances (avgdist is standard for factors)
d <- distGPS(s2, metric='avgdist')

# 3. Generate MDS representation (2D or 3D)
mds1 <- mds(d, k=2, type='isoMDS')

# 4. Plot the map
plot(mds1, drawlabels=TRUE, point.pch=20)
```

### 2. Integrating and Adjusting Data Sources
When merging data from different technologies (e.g., ChIP-chip and ChIP-seq), use Procrustes or Peak Width adjustment to remove systematic biases.

```R
# Procrustes adjustment (requires common points/factors)
# mds_joint is an MDS object of the combined datasets
# adjust is a vector indicating the source (e.g., 'chip', 'seq')
mds_adj <- procrustesAdj(mds_joint, dist_joint, adjust=adjust, sampleid=sampleid)

# Peak Width Adjustment (useful for resolution differences)
s2_pAdj <- adjustPeaks(gr_list, adjust=adjust, sampleid=sampleid, logscale=TRUE)
```

### 3. chroGPSgenes: Mapping Genes by Epigenetic Profile
This workflow groups genes based on the similarity of their epigenetic marks.

```R
# 1. Prepare a binary matrix (Genes x Factors)
# 1 if mark is present, 0 otherwise
d_genes <- distGPS(s2.tab, metric='tanimoto', uniqueRows=TRUE)

# 2. MDS with BoostMDS for large datasets (genome-wide)
# splitMDS handles high computational load
mds_genes <- mds(d_genes, type='isoMDS', splitMDS=TRUE, split=.5)
mds_boost <- mds(d_genes, mds_genes, type='boostMDS')

# 3. Clustering and Density Estimation
h <- hclust(as.dist(as.matrix(d_genes)), method='average')
clus <- clusGPS(d_genes, mds_boost, h, preMerge=TRUE, minpoints=20)

# 4. Merge overlapping clusters for better interpretation
clus_merged <- mergeClusters(clus, brake=0)
plot(mds_boost, point.col=clusterID(clus_merged))
```

### 4. Differential Analysis
Compare epigenome maps across different conditions (e.g., cell lines or time points).

```R
# For factors: Compare two MDS objects
df_factors <- diffFactors(mds_cond1, mds_cond2)
plot(df_factors$mds3) # Shows shifts between conditions

# For genes: Identify genes changing epigenetic identity
# x is the combined genes matrix
diff_genes <- diffGenes(x, mds_obj, clus_obj, label.x='Cond1', label.y='Cond2')
```

## Key Functions and Parameters

- `distGPS`: Computes distance matrices. Use `metric='avgdist'` for factors and `metric='tanimoto'` for binary gene matrices.
- `mds`: Performs MDS. `type='isoMDS'` is standard; `type='boostMDS'` is recommended for large gene maps to improve R-squared and speed.
- `clusGPS`: Performs clustering and computes Correct Classification Rates (CCR) to assess cluster robustness.
- `procrustesAdj`: Optimal superimposition of maps by altering location, scale, and orientation while maintaining relative distances.
- `domainDist`: Evaluates conservation of chromatin domains between datasets.
- `rankFactorsbyDomain`: Identifies which factors are most critical for defining a specific chromatin domain.

## Tips for Effective Mapping

- **Dimensionality**: Check the R-squared and Stress values. An R-squared > 0.6 and Stress < 0.1 usually indicate a reliable 2D representation. If values are poor, try `k=3`.
- **Parallelization**: Many functions support `mc.cores` for parallel processing on Linux/Mac.
- **Visualization**: Use `densCols` for gene maps to visualize point density, or `probContour=p` in cluster plots to show high-probability regions.
- **Export**: Use `gps2xgmml(mds_obj, ...)` to export maps to Cytoscape for interactive network exploration.

## Reference documentation
- [chroGPS](./references/chroGPS.md)