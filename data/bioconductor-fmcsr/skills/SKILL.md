---
name: bioconductor-fmcsr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/fmcsR.html
---

# bioconductor-fmcsr

name: bioconductor-fmcsr
description: Use for mismatch-tolerant Maximum Common Substructure (MCS) searching and structural similarity analysis of small molecules in R. Trigger this skill when users need to compare chemical structures, find common subgraphs with atom/bond mismatches, perform MCS-based clustering, or visualize shared substructures between compounds using the fmcsR package.

# bioconductor-fmcsr

## Overview
The `fmcsR` package implements an efficient backtracking algorithm for identifying the Maximum Common Substructure (MCS) between two small molecules. Its unique feature is the **Flexible MCS (FMCS)** matching strategy, which allows for a user-defined number of atom and/or bond mismatches. This makes it more sensitive for structural similarity searching than exact MCS algorithms or fingerprint-based methods. It integrates closely with `ChemmineR` for data handling and visualization.

## Core Functions and Workflows

### 1. Data Preparation
`fmcsR` operates on `SDFset` or `SDF` objects from the `ChemmineR` package.

```r
library(fmcsR)
library(ChemmineR)

# Load sample data
data(fmcstest)
# fmcstest is an SDFset containing 3 molecules
```

### 2. Pairwise MCS/FMCS Calculation
The `fmcs` function is the primary tool for comparing two molecules.

```r
# Exact MCS (default: au=0, bu=0)
res <- fmcs(fmcstest[1], fmcstest[2])

# Flexible MCS (FMCS) with 1 atom mismatch and 1 bond mismatch
res_flex <- fmcs(fmcstest[1], fmcstest[2], au=1, bu=1)

# Fast mode (returns a numeric vector instead of an MCS object)
stats_vec <- fmcs(fmcstest[1], fmcstest[2], fast=TRUE)
```

**Key Parameters:**
* `au`: Upper bound for atom mismatches.
* `bu`: Upper bound for bond mismatches.
* `matching.mode`: Set to "aromatic" to treat aromatic bonds specifically.

### 3. Interpreting Results
The `fmcs` function returns an S4 object of class `MCS`.

```r
# View summary statistics (Tanimoto and Overlap coefficients)
stats(res)

# Access substructure indices
mcs1(res) # Indices for query
mcs2(res) # Indices for target

# Convert MCS to SDFset for export or further analysis
substructure_sdf <- mcs2sdfset(res, type="new")
```

### 4. Batch Searching
Use `fmcsBatch` to search a query against a library of compounds.

```r
data(sdfsample)
# Search first compound against the first 30 in the sample
batch_results <- fmcsBatch(sdfsample[1], sdfsample[1:30], au=0, bu=0)

# Results include Tanimoto_Coefficient and Overlap_Coefficient
```

### 5. Visualization
The `plotMCS` function highlights the common substructure within the source molecules.

```r
# Visualize the MCS between two compounds
plotMCS(res, regenCoords=TRUE)
```

### 6. Clustering
You can generate a similarity matrix using `fmcsBatch` for hierarchical clustering.

```r
# Create similarity matrix (Overlap Coefficient)
sdf <- sdfsample[1:7]
d <- sapply(cid(sdf), function(x) {
  fmcsBatch(sdf[x], sdf, au=0, bu=0)[,"Overlap_Coefficient"]
})

# Cluster and plot
hc <- hclust(as.dist(1-d), method="complete")
plot(as.dendrogram(hc), horiz=TRUE)
```

## Tips for Performance
* **NP-Completeness**: MCS detection is computationally expensive. For large-scale screens, use `fast=TRUE` in `fmcs` or use `fmcsBatch`.
* **Mismatch Limits**: Keep `au` and `bu` low (e.g., 0-3) to maintain chemical relevance and prevent excessive computation times.
* **Overlap vs Tanimoto**: Use the *Overlap Coefficient* ($c/min(a,b)$) when comparing molecules of significantly different sizes to detect if one is a substructure of the other.

## Reference documentation
- [_fmcsR_: Mismatch Tolerant Maximum Common Substructure Detection for Advanced Compound Similarity Searching](./references/fmcsR.md)
- [fmcsR Vignette Source](./references/fmcsR.Rmd)