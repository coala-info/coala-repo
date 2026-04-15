---
name: bioconductor-statial
description: Statial performs context-aware statistical analysis of spatial relationships in high-dimensional multiplexed imaging data. Use when user asks to evaluate spatial relationships relative to a specific context, identify marker expression changes based on distance to other cell types, or correct for lateral marker spillover.
homepage: https://bioconductor.org/packages/release/bioc/html/Statial.html
---

# bioconductor-statial

## Overview

Statial is a Bioconductor package designed for the statistical analysis of spatial relationships in high-dimensional multiplexed imaging data (e.g., MIBI-TOF, IMC). It provides a suite of tools to move beyond simple proximity metrics by incorporating "context"—such as tissue structures or parent cell populations—into spatial quantifications.

Key capabilities include:
- **Kontextual**: Evaluates spatial relationships relative to a specific context (e.g., is cell type A closer to B than expected given the distribution of parent population C?).
- **SpatioMark**: Identifies how marker expression within a cell changes as a function of distance to other cell types.
- **Contamination Correction**: Accounts for lateral marker spillover (segmentation artifacts) in spatial modeling.
- **Integration**: Works seamlessly with `SingleCellExperiment`, `spicyR`, and `lisaClust`.

## Typical Workflow

### 1. Data Preparation
Statial expects a `SingleCellExperiment` (SCE) object with `x` and `y` coordinates in `colData`.

```r
library(Statial)
library(SingleCellExperiment)

# Load example data
data("kerenSCE")
```

### 2. Context-Aware Relationships (Kontextual)
To use `Kontextual`, you must define a parent population or a hierarchy.

**Defining a Hierarchy:**
```r
# Manual list: Parent = vector of children
biologicalHierarchy = list(
  "tumour" = c("Keratin_Tumour", "Tumour"),
  "tcells" = c("CD3_Cell", "CD4_Cell", "CD8_Cell", "Tregs")
)

# Or use treekoR for data-driven hierarchies
# kerenTree <- treekoR::getClusterTree(...)
# treekorParents = getParentPhylo(kerenTree)
```

**Running Kontextual:**
```r
# Calculate for specific pair
p53_Kontextual <- Kontextual(
  cells = kerenSCE,
  r = 100,
  from = "Immune",
  to = "p53_Tumour",
  parent = c("p53_Tumour", "Tumour"),
  cellType = "cellTypeNew"
)

# Calculate for all pairwise combinations
parentDf <- parentCombinations(all = unique(kerenSCE$cellType), parentList = biologicalHierarchy)
allKontextual <- Kontextual(cells = kerenSCE, parentDf = parentDf, r = 100)
```

### 3. Continuous State Changes (SpatioMark)
This workflow identifies if a marker's intensity in one cell type is influenced by proximity to another cell type.

**Step A: Calculate Proximity and Abundance**
```r
kerenSCE <- getDistances(kerenSCE, maxDist = 200)
kerenSCE <- getAbundances(kerenSCE, r = 200)
```

**Step B: Model State Changes**
```r
# Test specific interaction
stateChanges <- calcStateChanges(
  cells = kerenSCE,
  type = "distances",
  image = "6",
  from = "Keratin_Tumour",
  to = "Macrophages",
  marker = "p53"
)

# Visualize the relationship
plotStateChanges(cells = kerenSCE, type = "distances", image = "6", 
                 from = "Keratin_Tumour", to = "Macrophages", marker = "p53")
```

### 4. Handling Contamination
Lateral spillover can cause false positives (e.g., T-cells appearing to express B-cell markers).

```r
# Calculate contamination probabilities
kerenSCE <- calcContamination(kerenSCE)

# Include contamination as a covariate in the model
stateChangesCorrected <- calcStateChanges(
  cells = kerenSCE,
  type = "distances",
  contamination = TRUE
)
```

### 5. Downstream Analysis (Survival & Classification)
Statial features can be converted to matrices for survival modeling using `spicyR` or `ClassifyR`.

```r
# Convert to wide matrix
kontextMat <- prepMatrix(allKontextual)

# Survival analysis with spicyR
library(spicyR)
survivalResults <- spicy(cells = kerenSCE, alternateResult = kontextMat, condition = "survival")
signifPlot(survivalResults)
```

## Tips for Success
- **Radius Selection**: Use `kontextCurve` to evaluate how spatial relationships change across multiple radii (`rs`). Small radii capture local interactions; large radii capture global tissue structure.
- **Parallelization**: Most functions support a `cores` argument. Use `nCores > 1` for large datasets or pairwise calculations.
- **Missing Values**: `prepMatrix` may produce `NA` values if certain cell types are absent in specific images. Replace these with 0 or use appropriate imputation before classification.
- **Region Analysis**: Use `lisaClust` to identify spatial domains before running `getMarkerMeans` to see how marker expression varies by tissue region.

## Reference documentation
- [Statial](./references/Statial.md)