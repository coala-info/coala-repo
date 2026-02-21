---
name: bioconductor-flowtype
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/flowType.html
---

# bioconductor-flowtype

name: bioconductor-flowtype
description: Automated phenotyping of flow cytometry assays to identify and analyze multi-dimensional cell populations. Use this skill when analyzing flow cytometry data (flowFrame or flowSet objects) to perform high-dimensional partitioning, calculate phenotype frequencies (proportions), extract Mean Fluorescence Intensity (MFI), or conduct cross-sample statistical comparisons of cell populations.

## Overview
The `flowType` package uses automated thresholding (K-means, flowMeans, or flowClust) to partition every fluorescence channel into positive and negative populations. These partitions are then combined combinatorially to generate a complete set of multi-dimensional phenotypes. This allows for the discovery of complex cell populations that might be missed by manual gating.

## Core Workflow

### 1. Data Preparation
Load the library and your flow cytometry data (typically a `flowFrame`).
```R
library(flowType)
data(DLBCLExample) # Example dataset
```

### 2. Running flowType
Identify the indices for markers used for proportions and MFIs.
```R
PropMarkers <- 3:5
MFIMarkers <- 3:5
MarkerNames <- c("CD19", "CD3", "CD5")

# Run the phenotyping
Res <- flowType(DLBCLExample, PropMarkers, MFIMarkers, 'kmeans', MarkerNames)
```

### 3. Visualizing Results
You can plot the 1D partitions or specific multi-dimensional populations.
```R
# Plot all 1D partitions
plot(Res, DLBCLExample)

# Plot a specific phenotype (e.g., CD3+CD5-CD19+)
plot(Res, "CD3+CD5-CD19+", Frame=DLBCLExample)
```

### 4. Extracting Data
Access cell frequencies and MFIs from the result object.
```R
# Get cell frequencies (proportions)
Proportions <- Res@CellFreqs / max(Res@CellFreqs)

# Decode phenotype codes into human-readable names
PhenoNames <- unlist(lapply(Res@PhenoCodes, function(x){
  return(decodePhenotype(x, Res@MarkerNames[PropMarkers], Res@PartitionsPerMarker))
}))
names(Proportions) <- PhenoNames
```

## Cross-Sample Analysis
For multiple samples, use `fsApply` to run `flowType` across a `flowSet` and then perform statistical testing.

```R
# Run on a flowSet
ResList <- fsApply(HIVData, flowType, PropMarkers, MFIMarkers, 'kmeans', MarkerNames)

# Extract proportions into a matrix
All.Proportions <- matrix(0, 3^length(PropMarkers), length(ResList))
for (i in 1:length(ResList)){
  All.Proportions[,i] = ResList[[i]]@CellFreqs / ResList[[i]]@CellFreqs[which(PhenoNames=="")]
}

# Statistical testing (e.g., t-test between groups)
# Note: Always apply p-value adjustment (e.g., Bonferroni or FDR)
pvals <- apply(All.Proportions, 1, function(x) t.test(x ~ Labels)$p.value)
adj_pvals <- p.adjust(pvals, method="fdr")
significant_phenotypes <- PhenoNames[which(adj_pvals < 0.05)]
```

## Memory Management and Optimization
For high-dimensional data (>15 markers), the number of potential phenotypes grows exponentially ($3^k$). 

- **Estimate Population Count**: Use `calcNumPops` to determine if the analysis will fit in memory.
```R
# Calculate number of populations for 34 markers with a depth cutoff of 10
calcNumPops(rep(2, 34), 10)
```
- **Set Cutoffs**: Use the `MaxMarkersPerPhenotype` parameter in `flowType()` to limit the complexity of phenotypes generated and save memory.

## Tips
- **Thresholding Methods**: While `kmeans` is fast, `flowMeans` or `flowClust` may provide better partitioning for complex distributions at the cost of computation time.
- **Normalization**: Always normalize cell frequencies by the total number of cells (the phenotype with an empty string name `""`) when comparing across samples.
- **Marker Selection**: Only include markers in `PropMarkers` that are relevant for defining cell subsets to avoid combinatorial explosion.

## Reference documentation
- [flowType Vignette](./references/flowType.md)