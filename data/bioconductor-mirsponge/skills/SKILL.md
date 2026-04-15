---
name: bioconductor-mirsponge
description: This tool identifies and analyzes miRNA sponge interaction networks and modules using various computational methods and enrichment analyses. Use when user asks to identify miRNA sponge interactions, integrate multiple identification methods, validate interactions against ground truth, identify network modules, or perform functional and survival analysis on those modules.
homepage: https://bioconductor.org/packages/3.8/bioc/html/miRsponge.html
---

# bioconductor-mirsponge

name: bioconductor-mirsponge
description: Identification and analysis of miRNA sponge (ceRNA) interaction networks and modules. Use this skill when analyzing biological data to identify miRNA sponge interactions, validate them against ground truth, identify network modules, and perform enrichment or survival analysis on those modules.

## Overview
The `miRsponge` package provides a comprehensive pipeline for studying miRNA sponges (also known as competing endogenous RNAs or ceRNAs). It implements seven distinct computational methods for identifying sponge interactions, allows for the integration of multiple methods to improve confidence, and supports downstream analysis including module identification, functional enrichment (GO, KEGG, Reactome), disease enrichment (DO, DGN, NCG), and survival analysis.

## Core Workflow

### 1. Identification of miRNA Sponge Interactions
The primary function is `spongeMethod()`. It requires a miRNA-target interaction data frame and, depending on the method, expression data or MRE (miRNA Response Element) information.

Methods available:
- `miRHomology`: Based on sharing miRNAs.
- `pc`: Pearson correlation (requires expression data).
- `sppc`: Sensitivity partial pearson correlation (requires expression data).
- `hermes`: Conditional mutual information (requires expression data).
- `ppc`: Partial Pearson Correlation (requires expression data).
- `muTaME`: Combined score of four indicators (requires MRE data).
- `cernia`: Combined score of seven indicators (requires expression and MRE data).

```r
# Example: Identification using the pc method
miRTarget <- read.csv("miR2Target.csv")
ExpData <- read.csv("ExpData.csv", header=FALSE)
pc_results <- spongeMethod(miRTarget, ExpData, method = "pc")
```

### 2. Integrating Multiple Methods
To increase reliability, use `integrateMethod()` to find interactions identified by a minimum number of methods.

```r
# Combine results from different methods into a list of 2-column matrices (sponge_1, sponge_2)
Interlist <- list(miRHomology_res[, 1:2], pc_res[, 1:2], sppc_res[, 1:2])
Integrate_res <- integrateMethod(Interlist, Intersect_num = 2)
```

### 3. Validation
Validate predicted interactions against experimental ground truth using `spongeValidate()`.

```r
Groundtruth <- read.csv("Groundtruth.csv")
validated_network <- spongeValidate(Integrate_res, directed = FALSE, Groundtruth)
```

### 4. Module Identification
Identify clusters or modules within the sponge interaction network using `netModule()`. Supported algorithms include FN, MCL, LINKCOMM, and MCODE.

```r
# Identify modules with a minimum size of 2
modules <- netModule(Integrate_res, modulesize = 2)
```

### 5. Functional and Disease Enrichment
Analyze the biological significance of identified modules.
- `moduleDEA()`: Disease Enrichment Analysis (DO, DGN, NCG).
- `moduleFEA()`: Functional Enrichment Analysis (GO, KEGG, Reactome).

```r
disease_enrich <- moduleDEA(modules)
functional_enrich <- moduleFEA(modules)
```

### 6. Survival Analysis
Evaluate the prognostic value of miRNA sponge modules using `moduleSurvival()`. This requires expression data and survival data (time and status).

```r
# devidePercentage = 0.5 splits samples into high/low risk at the median
survival_res <- moduleSurvival(modules, ExpData, SurvData, devidePercentage = 0.5)
```

## Tips and Best Practices
- **Data Preparation**: Ensure gene/RNA symbols are consistent across the miRNA-target mapping, expression data, and MRE data.
- **Computational Cost**: Methods like `hermes` and `ppc` use permutations (`num_perm`). Start with a low number (e.g., 10) for testing before running a full analysis.
- **Input Format**: `spongeMethod` typically expects the first two columns of the interaction data to be the potential sponge regulators.
- **Module Size**: Adjust the `modulesize` parameter in `netModule()` based on the density of your network; very small modules may lack statistical power for enrichment analysis.

## Reference documentation
- [miRsponge: identification and analysis of miRNA sponge interaction networks and modules](./references/miRsponge.md)