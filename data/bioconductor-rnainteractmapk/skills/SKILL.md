---
name: bioconductor-rnainteractmapk
description: This package provides data and code to analyze and reproduce a large-scale synthetic genetic interaction screen of the MAPK signaling network in Drosophila cells. Use when user asks to analyze RNAi interaction data, estimate main effects and pairwise interaction scores, perform statistical significance testing for genetic interactions, or generate specialized plots like double perturbation and ternary classification plots.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/RNAinteractMAPK.html
---

# bioconductor-rnainteractmapk

name: bioconductor-rnainteractmapk
description: Analysis and reproduction of the MAPK signaling network synthetic genetic interaction screen. Use when Claude needs to analyze RNAi interaction data, estimate main effects and pairwise interactions (PI-scores), perform classification of signaling components, or generate specific figures (heatmaps, double perturbation plots, ternary classification plots) as described in Horn et al. (2011).

# bioconductor-rnainteractmapk

## Overview

The `RNAinteractMAPK` package contains the data and code required to reproduce the analysis of a large-scale synthetic genetic interaction screen in *Drosophila* cells. It maps signaling networks by identifying interactions between components of the MAPK and JNK pathways. Most underlying analysis logic is inherited from the `RNAinteract` package, while this package provides specific datasets and specialized plotting functions for the MAPK screen.

## Core Workflow

### 1. Loading Data
The primary dataset is an `RNAinteract` object named `Dmel2PPMAPK`.

```r
library(RNAinteractMAPK)
data("Dmel2PPMAPK", package="RNAinteractMAPK")

# Extract the main interaction matrix (PI-scores)
PI <- getData(Dmel2PPMAPK, type="pi", format="targetMatrix", screen="mean", withoutgroups = c("pos", "neg"))
```

### 2. Estimating Interactions
If starting from raw data or re-calculating effects:

```r
# 1. Estimate single perturbation (main) effects
Dmel2PPMAPK <- estimateMainEffect(Dmel2PPMAPK)

# 2. Normalize main effects to remove plate/time trends
Dmel2PPMAPK <- normalizeMainEffectQuery(Dmel2PPMAPK, batch=rep(1:4,each=48))
Dmel2PPMAPK <- normalizeMainEffectTemplate(Dmel2PPMAPK, channel="intensity")

# 3. Compute pairwise interaction (PI) scores
Dmel2PPMAPK <- computePI(Dmel2PPMAPK)

# 4. Summarize replicates
Dmel2PPMAPKmean <- summarizeScreens(Dmel2PPMAPK, screens=c("1","2"))
Dmel2PPMAPK <- bindscreens(Dmel2PPMAPK, Dmel2PPMAPKmean)
```

### 3. Statistical Significance
Compute p-values using different methods (t-test, limma, or Hotelling T2 for multivariate analysis).

```r
library(qvalue)
p.adj.fct <- function(x) {
    I = which(is.finite(x))
    qjob = qvalue(x[I])
    q.value = rep(NA,length(x))
    q.value[I] = qjob$qvalues
    return(q.value)
}

# Compute p-values (default is t-test)
Dmel2PPMAPK <- computePValues(Dmel2PPMAPK, p.adjust.function = p.adj.fct)

# Multivariate Hotelling T2 test
Dmel2PPMAPKT2 <- computePValues(Dmel2PPMAPK, method="HotellingT2", p.adjust.function = p.adj.fct)
```

## Visualization and Analysis

### Double Perturbation Plots
Visualize the interaction between two specific genes compared to their single knockdown effects.

```r
plotDoublePerturbation(Dmel2PPMAPK, screen="mean", channel="nrCells", target="Gap1",
                       main="Gap1 (CG6721)", range=c(-2.3, 1.0),
                       show.labels="q.value", xlab="rel. nuclear count [log2]")
```

### Classification
The package includes functions to classify genes into signaling pathways (e.g., RasMapK vs JNK) based on their interaction profiles.

```r
# Define training groups
traingroups = list(
    RasMapK = c("csw","drk","Sos","Ras85D","phl","Dsor1","rl","pnt"),
    RasMapKInh = c("Gap1","PTP-ER","Mkp3","aop","Pten"),
    JNK = c("Gadd45","Btk29A","msn","slpr","bsk","Jra","kay")
)

# Cross-validation
sgi <- sgisubset(Dmel2PPMAPK, screen=c("1","2"))
CV <- MAPK.cv.classifier(sgi, traingroups)

# Plot ternary classification
MAPK.plot.classification(CV$CVposterior, y=CV$y,
                         classes = c("RasMapKInh", "JNK", "RasMapK"),
                         classnames = c("RasMAPK-Inhibitors","JNK","RasMAPK"))
```

### Heatmaps
Generate rasterized heatmaps of interaction scores.

```r
# Get interaction matrix
PInrcells <- getData(Dmel2PPMAPK, type="pi", format="targetMatrix", screen="mean", channel="nrCells")

# Cluster and plot
hc = hclust(dist(embedPCA(Dmel2PPMAPK, screen="mean", channel="nrCells", dim=4)))
MAPK.plot.heatmap.raster(PInrcells, hc.row = hc, hc.col = hc, pi.max = 0.05)
```

## Tips for Usage
- **Data Access**: Use `getData()` with `type="pi"`, `type="main"`, or `type="q.value"` to extract specific matrices from the `RNAinteract` object.
- **Feature Channels**: The screen contains three readout channels: `nrCells` (cell count), `area` (nuclear area), and `intensity` (staining intensity).
- **Source Code**: To extract the full reproduction script from the package, use:
  `Stangle(system.file("doc", "RNAinteractMAPK.Rnw", package="RNAinteractMAPK"))`

## Reference documentation
- [RNAinteractMAPK](./references/RNAinteractMAPK.md)