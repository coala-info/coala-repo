---
name: bioconductor-dmelsgi
description: This package provides experimental data and analysis tools for studying directional genetic interactions and multi-phenotype epistatic relationships in Drosophila melanogaster. Use when user asks to access pi-scores from the Fischer et al. (2015) study, analyze phenotypic features from genetic screens, or infer directional pathways between genes.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/DmelSGI.html
---

# bioconductor-dmelsgi

name: bioconductor-dmelsgi
description: Analysis of directional genetic interactions in Drosophila melanogaster using the DmelSGI package. Use this skill to access experimental data from Fischer et al. (2015), including pi-scores, phenotypic features, and directional epistatic interaction networks.

## Overview

The `DmelSGI` package provides the data and source code for the manuscript "A Map of Directional Genetic Interactions in a Metazoan Cell" (eLife, 2015). It contains a multi-phenotype genetic interaction cube consisting of 1367 target genes and 72 query genes across 21 stable phenotypic features. The package is primarily used for studying epistatic relationships and inferring directional pathways in metazoan cells.

## Data Access

The package provides several pre-computed data objects. Load the library and use the `data()` function to access them.

```R
library("DmelSGI")

# Main interaction scores (pi-scores) and p-values
data("Interactions", package="DmelSGI")
# Interactions$piscore: 3D array [target, query, phenotype]
# Interactions$padj: 3D array of adjusted p-values
# Interactions$Anno: Annotation for genes and phenotypes

# Single knockdown effects (main effects)
data("mainEffects", package="DmelSGI")

# Raw data matrix before interaction calculation
data("datamatrix", package="DmelSGI")

# Directional epistatic interaction results
data("fitepistasis", package="DmelSGI")
```

## Typical Workflows

### 1. Extracting Specific Interactions
To look at the interaction between a specific target and query gene for a given phenotype (e.g., cell number):

```R
data("Interactions", package="DmelSGI")
# Get pi-score for 'mor' (target) and 'RasGAP1' (query) for '4x.count'
val <- Interactions$piscore["mor", "RasGAP1", "4x.count"]
```

### 2. Visualizing Phenotypes
The package includes functions to visualize the interaction data, specifically for comparing expected vs. observed phenotypes in double knockdowns.

```R
# Plotting two phenotypes to show directional epistasis
# data: object containing xt, xq, and pi vectors
plot2Phenotypes(data, "sti", "Cdc23", 1, 5)

# Plotting pi-score data across all phenotypes for a gene pair
plotPIdata(data, "sti", "Cdc23")
```

### 3. Working with Phenotypic Features
The package uses a generalized logarithm transform (`glog`) for scaling features. 21 features were selected based on stability:
- `4x.count` (cell number)
- `4x.ratioMitotic` (mitotic index)
- `10x.meanNonmitotic.cell.0.s.area` (cell area)
- `4x.countpH3` (number of mitotic objects)

### 4. Inferring Directional Interactions
Directional interactions are inferred by fitting a linear model where the interaction vector $\pi$ is modeled as a function of the main effects of the target ($x_t$) and query ($x_q$):
$\pi \approx \alpha + \beta_1 x_t + \beta_2 x_q$

A high $\beta_1$ relative to $\beta_2$ suggests the query is epistatic to the target (direction: Query -> Target).

## Tips and Best Practices
- **Normalization**: When comparing across phenotypes, divide pi-scores by their median absolute deviation (MAD) to make them comparable to z-scores.
- **Gene Identifiers**: The package uses FlyBase identifiers (FBgn) for indexing. Use `Interactions$Anno$target` to map between Symbols and TIDs.
- **Batch Effects**: Main effects were estimated per batch; when performing custom analyses, ensure you account for the `Batch` and `TargetPlate` variables found in the annotation objects.

## Reference documentation

- [A Map of Directional Genetic Interactions in a Metazoan Cell](./references/DmelSGI.md)