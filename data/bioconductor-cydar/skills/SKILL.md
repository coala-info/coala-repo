---
name: bioconductor-cydar
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/cydar.html
---

# bioconductor-cydar

name: bioconductor-cydar
description: Differential abundance analysis for mass cytometry (CyTOF) data using hypersphere-based counting. Use this skill when you need to identify cell subpopulations that change in frequency between experimental conditions, perform spatial FDR control, or visualize high-dimensional cytometry results.

# bioconductor-cydar

## Overview

The `cydar` package implements a method for detecting differentially abundant (DA) subpopulations in mass cytometry data. Unlike traditional clustering, it uses a hypersphere-based approach to count cells in high-dimensional marker space. This avoids the stochasticity and potential biases of clustering while providing higher resolution for detecting small changes in specific cell states.

## Core Workflow

### 1. Data Preparation and Pre-processing
The analysis typically starts with FCS files loaded into a `ncdfFlowSet` or a list of intensity matrices.

```r
library(cydar)
library(ncdfFlow)
library(flowCore)

# Load data (example using ncdfFlowSet)
# fs <- read.ncdfFlowSet(fcs_files)

# 1. Pool cells for parameter estimation
pool.ff <- poolCells(fs)

# 2. Transform intensities (Logicle is standard for CyTOF)
trans <- estimateLogicle(pool.ff, colnames(pool.ff))
fs.proc <- transform(fs, trans)

# 3. Gating (e.g., removing outliers or dead cells)
gate.out <- outlierGate(poolCells(fs.proc), "MarkerName", type="upper")
fs.proc <- Subset(fs.proc, gate.out)
```

### 2. Counting Cells in Hyperspheres
Cells are assigned to hyperspheres centered at individual cells. The radius (`tol`) is a critical parameter.

```r
# Prepare data for counting
cd <- prepareCellData(fs.proc)

# Count cells in hyperspheres
# tol=0.5 is a common default (0.5 * sqrt(number of markers))
cd <- countCells(cd, tol=0.5)

# Access counts and intensities
counts <- assay(cd)
mids <- intensities(cd)
```

### 3. Differential Abundance Testing
`cydar` integrates with `edgeR` to perform statistical testing using a quasi-likelihood (QL) framework.

```r
library(edgeR)

# Create DGEList
y <- DGEList(assay(cd), lib.size=cd$totals)

# Filter low-abundance hyperspheres (average count < 5)
keep <- aveLogCPM(y) >= aveLogCPM(5, mean(cd$totals))
cd.filt <- cd[keep,]
y <- y[keep,]

# Statistical testing
design <- model.matrix(~factor(conditions))
y <- estimateDisp(y, design)
fit <- glmQLFit(y, design, robust=TRUE)
res <- glmQLFTest(fit, coef=2)
```

### 4. Spatial FDR Control
Because hyperspheres overlap, standard BH corrections are insufficient. `spatialFDR` accounts for the density of hyperspheres in high-dimensional space.

```r
# Calculate spatial FDR
qvals <- spatialFDR(intensities(cd.filt), res$table$PValue)
is.sig <- qvals <= 0.05
```

### 5. Interpretation and Visualization
Significant hyperspheres are visualized using dimensionality reduction (PCA/t-SNE) and colored by Log-Fold Change or marker intensity.

```r
# PCA on significant hyperspheres
sig.coords <- intensities(cd.filt)[is.sig,]
coords <- prcomp(sig.coords)

# Plot Log-Fold Change
plotSphereLogFC(coords$x[,1], coords$x[,2], res$table$logFC[is.sig])

# Plot Marker Intensities to identify the subpopulation
limits <- intensityRanges(cd.filt, p=0.05)
plotSphereIntensity(coords$x[,1], coords$x[,2], sig.coords[,"CD3"], irange=limits[,"CD3"])
```

## Key Functions and Tips

- **`prepareCellData()`**: Converts input into a `CyData` object. It handles the underlying neighbor search structures.
- **`countCells()`**: The `tol` argument defines the hypersphere radius. Larger values "smooth" over batch effects but reduce resolution.
- **`spatialFDR()`**: Always use this instead of `p.adjust()` to account for the spatial correlation of overlapping hyperspheres.
- **`findFirstSphere()`**: Useful for reducing redundancy by selecting the "peak" hypersphere (lowest p-value) in a local area of significant results.
- **`interpretSpheres()`**: Launches a Shiny app for interactive exploration of DA results.
- **Batch Correction**: If samples were not barcoded/multiplexed, use `normalizeBatch` or `expandRadius` to mitigate technical shifts.

## Reference documentation
- [Detecting differentially abundant subpopulations in mass cytometry data](./references/cydar.md)