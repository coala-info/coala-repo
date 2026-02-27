---
name: bioconductor-phyloprofile
description: PhyloProfile is an R package for visualizing and exploring multi-layered phylogenetic profiles by integrating sequence similarity and domain conservation. Use when user asks to estimate gene ages, identify core genes, visualize protein domain architectures, or perform taxonomic collapsing of phylogenetic profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/PhyloProfile.html
---


# bioconductor-phyloprofile

name: bioconductor-phyloprofile
description: Expert guidance for using the Bioconductor R package PhyloProfile to visualize and explore multi-layered phylogenetic profiles. Use this skill when you need to perform gene age estimation, core gene identification, profile clustering, or visualize protein domain architectures across different taxonomic ranks.

# bioconductor-phyloprofile

## Overview

PhyloProfile is an R package designed for the analysis of multi-layered phylogenetic profiles. It goes beyond simple presence/absence patterns by integrating additional information layers such as sequence similarity or domain conservation. Key capabilities include dynamic taxonomic collapsing (from species to phyla), evolutionary gene age estimation using Last Common Ancestor (LCA) algorithms, and identification of core genes within specific taxonomic groups.

## Core Workflows

### 1. Data Input and Processing
PhyloProfile requires a specific long-format data frame. You can convert various formats (fasta, OrthoXML, wide matrix) using `createLongMatrix()` or process raw tab-delimited files directly.

```r
library(PhyloProfile)

# Process raw input into a profile data frame
rawInput <- system.file("extdata", "test.main.long", package = "PhyloProfile")
profileData <- fromInputToProfile(
    rawInput,
    rankName = "class",
    refTaxon = "Mammalia",
    var1AggregateBy = "max",
    var2AggregateBy = "mean",
    percentCutoff = c(0.0, 1.0),
    var1Cutoff = c(0.75, 1.0),
    var2Cutoff = c(0.5, 1.0),
    var1Relation = "protein",
    var2Relation = "species"
)
```

### 2. Phylogenetic Profile Visualization
The package uses `ggplot2` for heatmaps. You must first prepare the plotting data frame.

```r
# Prepare data for plotting
plotDf <- dataMainPlot(finalProcessedProfile)

# Define plot parameters
plotParameter <- list(
    "xAxis" = "taxa",
    "var1ID" = "FAS_FW",
    "var2ID"  = "FAS_BW",
    "lowColorVar1" = "#FF8C00",
    "highColorVar1" = "#4682B4",
    "xSize" = 8, "ySize" = 8
)

# Generate plot
p <- heatmapPlotting(plotDf, plotParameter)
```

### 3. Gene Age Estimation
Estimates the minimal age of a gene based on the LCA of the most distantly related species containing the ortholog.

```r
# Requires taxaCount (from sortInputTaxa)
geneAge <- estimateGeneAge(
    fullProcessedProfile, 
    taxaCount, 
    rankName = "class", 
    refTaxon = "Mammalia",
    var1Cutoff = c(0,1), 
    var2Cutoff = c(0,1), 
    percentCutoff = c(0,1)
)
```

### 4. Core Gene Identification
Finds genes shared across a specific set of taxa given coverage and attribute thresholds.

```r
coreGenes <- getCoreGene(
    rankName = "class",
    taxaCore = c("Mammalia", "Insecta"),
    fullProcessedProfile,
    taxaCount,
    var1Cutoff = c(0.75, 1.0),
    coreCoverage = 1
)
```

### 5. Domain Architecture Plotting
Visualize the arrangement of protein domains for a specific gene and its orthologs.

```r
domainDf <- parseDomainInput(seedID = "gene123", domainFile = "path/to/file", type = "file")
archiPlot <- createArchiPlot(info = c("seedID", "orthoID"), domainDf, 9, 9)
grid::grid.draw(archiPlot)
```

## Key Functions Reference

- `fromInputToProfile()`: Main wrapper to transform raw data into a processed profile.
- `sortInputTaxa()`: Orders taxa based on distance to a reference and handles taxonomic rank collapsing.
- `getDataClustering()` / `getDistanceMatrix()`: Used for grouping genes with similar phylogenetic profiles.
- `compareTaxonGroups()`: Statistical comparison (Wilcoxon/KS tests) of annotation layers between in-groups and out-groups.
- `createVarDistPlot()`: Visualizes the distribution of additional variables to help determine filtering cutoffs.

## Tips for Success

- **Taxonomy IDs**: Ensure your input uses NCBI Taxonomy IDs (e.g., `ncbi9606`) for automatic lineage resolution.
- **Aggregation**: When collapsing species into higher ranks (e.g., Phylum), choose `var1AggregateBy` (max, mean, or median) carefully based on whether you want to represent the "best" hit or the "average" conservation.
- **Reference Taxon**: The choice of `refTaxon` determines the "distance" and ordering of the X-axis in plots.

## Reference documentation
- [PhyloProfile Vignette](./references/PhyloProfile-vignette.md)