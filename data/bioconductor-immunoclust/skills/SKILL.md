---
name: bioconductor-immunoclust
description: immunoClust provides an automated pipeline for clustering and meta-clustering high-dimensional flow and mass cytometry data. Use when user asks to cluster cell events within individual samples, perform meta-clustering across multiple samples, or create hierarchical annotations of cell populations.
homepage: https://bioconductor.org/packages/release/bioc/html/immunoClust.html
---


# bioconductor-immunoclust

## Overview

The `immunoClust` package provides an automated analysis pipeline for high-dimensional cytometric data (uncompensated fluorescence or mass cytometry). It operates in two primary stages:
1.  **Cell-Clustering**: Groups cell events within individual samples using model-based clustering with t-distributions and integrated asinh-transformation optimization.
2.  **Meta-Clustering**: Assorts clusters from different samples into comparable populations using a Gaussian mixture model and Bhattacharyya-Coefficients.

The package is designed to be sensitive enough to identify rare cell types even when adjacent to large populations.

## Workflow and Core Functions

### 1. Data Preparation
`immunoClust` utilizes `flowFrame` objects from the `flowCore` package.

```r
library(immunoClust)
library(flowCore)

# Load a flowFrame
data(dat.fcs) 

# Define parameters for clustering (e.g., FSC, SSC, and fluorescence channels)
pars <- c("FSC-A", "SSC-A", "FITC-A", "PE-A", "APC-A", "APC-Cy7-A", "Pacific Blue-A")
```

### 2. Cell Event Clustering
Use `cell.process` to cluster events within a single sample.

```r
# Perform clustering
# bias: controls the number of clusters (typically 0.2 to 0.3)
res.fcs <- cell.process(dat.fcs, parameters=pars, bias=0.3)

# View summary
summary(res.fcs)

# Apply optimized transformation to data for visualization
dat.transformed <- trans.ApplyToData(res.fcs, dat.fcs)

# Visualization
splom(res.fcs, dat.transformed, N=1000) # Scatter plot matrix
plot(res.fcs, data=dat.transformed, subset=c(1,2)) # 2D plot
```

### 3. Meta-Clustering
To compare populations across samples, collect `immunoClust` objects into a list/vector and use `meta.process`.

```r
# dat.exp is a list of immunoClust objects from multiple samples
meta <- meta.process(dat.exp, meta.bias=0.3)

# Plot meta-clustering results
plot(meta, c(), plot.subset=c(1,2))
```

### 4. Meta-Annotation and Hierarchy
You can manually structure clusters into a hierarchical tree (e.g., Leucocytes -> Lymphocytes -> T-cells).

```r
# Get clusters at a specific level
cls <- clusters(meta, c())

# Identify clusters based on parameter means (mu)
# Example: Filter for leucocytes based on FSC-A (parameter 1)
inc <- mu(meta, cls, 1) > 20000 & mu(meta, cls, 1) < 150000
addLevel(meta, c(1), "leucocytes") <- cls[inc]

# Further refine: Lymphocytes based on SSC-A (parameter 2)
cls_leu <- clusters(meta, c(1))
inc_ly <- mu(meta, cls_leu, 2) < 40000
addLevel(meta, c(1,1), "ly") <- cls_leu[inc_ly]
```

### 5. Data Extraction
Extract event counts or frequencies for statistical analysis.

```r
# Extract event numbers for all samples and annotated levels
tbl <- meta.numEvents(meta, out.unclassified=FALSE)

# Extract relative frequencies
# meta.relEvents(meta)
```

## Tips for Effective Usage
*   **ICL Bias**: The `bias` parameter is critical. A bias of 0.2–0.3 is generally recommended for fluorescence data. Lower values increase the number of clusters significantly.
*   **Uncompensated Data**: The pipeline is designed for uncompensated data; it handles spillover effects through its model-based approach, though high spillover (e.g., FITC into PE) will be reflected in the cluster means.
*   **Transformation**: Always use `trans.ApplyToData` before plotting raw FCS data to ensure the visualization matches the clustering logic.

## Reference documentation
- [immunoClust](./references/immunoClust.md)