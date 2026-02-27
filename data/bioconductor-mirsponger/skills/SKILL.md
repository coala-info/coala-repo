---
name: bioconductor-mirsponger
description: This tool identifies and analyzes miRNA sponge (ceRNA) interaction networks from transcriptomics data. Use when user asks to identify miRNA sponge interactions, validate ceRNA networks, detect functional modules, or perform enrichment and survival analysis on sponge networks.
homepage: https://bioconductor.org/packages/release/bioc/html/miRspongeR.html
---


# bioconductor-mirsponger

name: bioconductor-mirsponger
description: Identification and analysis of miRNA sponge (ceRNA) regulation. Use this skill to identify miRNA sponge interactions from transcriptomics data, validate interactions, identify modules, and perform disease/functional enrichment or survival analysis on miRNA sponge networks.

# bioconductor-mirsponger

## Overview
The `miRspongeR` package provides a comprehensive pipeline for studying competing endogenous RNA (ceRNA) networks, also known as miRNA sponges. It implements eight distinct computational methods to identify RNA-RNA interactions mediated by shared miRNAs. Beyond identification, the package supports sample-specific network inference, module detection, and downstream biological interpretation through enrichment and survival analysis.

## Core Workflow

### 1. Identification of miRNA Sponge Interactions
The primary function is `spongeMethod`. It requires a miRNA-target interaction data frame and, for most methods, an expression matrix.

**Methods available:** `miRHomology`, `pc`, `sppc`, `hermes`, `ppc`, `muTaME`, `cernia`, and `SPONGE`.

```r
library(miRspongeR)

# Load putative miRNA-target interactions (columns: miRNA, target)
miRTarget <- read.csv("miR2Target.csv")

# Load expression data (rows: genes/RNAs, columns: samples)
ExpData <- read.csv("ExpData.csv")

# Identify interactions using Sensitivity Partial Pearson Correlation (sppc)
# Use the "_parallel" suffix for faster computation
ceRInt <- spongeMethod(miRTarget, ExpData, method = "sppc_parallel", senscorcutoff = 0.1)
```

### 2. Integrating Multiple Methods
To increase confidence, you can integrate results from multiple identification methods using `integrateMethod`.

```r
# Create a list of the first two columns (sponge_1, sponge_2) from different results
Interlist <- list(method1_res[, 1:2], method2_res[, 1:2], method3_res[, 1:2])

# Keep interactions predicted by at least 2 methods
IntegrateceRInt <- integrateMethod(Interlist, Intersect_num = 2)
```

### 3. Sample-Specific Networks
Use `sponge_sample_specific` to infer networks for individual samples using a sample control variable strategy.

```r
ss_net <- sponge_sample_specific(miRTarget, ExpData, method = "sppc", senscorcutoff = 0.1)
# Returns a list of networks, one for each sample
```

### 4. Validation and Module Identification
Validate predicted interactions against experimental ground truth and group interactions into functional modules.

```r
# Validation
Groundtruth <- read.csv("Groundtruth.csv")
validated <- spongeValidate(ceRInt[, 1:2], Groundtruth)

# Module Identification (e.g., using Walktrap or Louvain)
# Methods: "fn", "mcl", "linkcomm", "mcode", "betweenness", "infomap", "prop", "eigen", "louvain", "walktrap"
modules <- netModule(ceRInt[, 1:2], modulesize = 2)
```

### 5. Downstream Analysis
Perform enrichment and survival analysis on the identified modules.

```r
# Disease Enrichment (DO, DGN, NCG)
disease_res <- moduleDEA(modules)

# Functional Enrichment (GO, KEGG, Reactome)
func_res <- moduleFEA(modules)

# Survival Analysis
# SurvData: columns for "time" and "status"
survival_res <- moduleSurvival(modules, ExpData, SurvData, devidePercentage = 0.5)
```

## Tips and Best Practices
- **Parallel Processing**: Always prefer the `_parallel` version of methods (e.g., `method = "hermes_parallel"`) for large datasets to significantly reduce computation time.
- **Data Preparation**: Ensure that gene/RNA symbols in your `miRTarget` file match the row names in your `ExpData`.
- **SPONGE Method**: This method requires a precomputed null model. If not provided, it may be computationally expensive to generate on the fly.
- **Module Size**: Use the `modulesize` parameter in `netModule` to filter out very small, potentially non-informative clusters.

## Reference documentation
- [miRspongeR](./references/miRspongeR.md)