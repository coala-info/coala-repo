---
name: bioconductor-fem
description: This tool identifies functional epigenetic modules by integrating DNA methylation and gene expression data with protein-protein interaction networks. Use when user asks to identify interactome hotspots, find subnetworks associated with a phenotype, or integrate multi-omic data to detect differentially methylated and expressed gene modules.
homepage: https://bioconductor.org/packages/3.8/bioc/html/FEM.html
---


# bioconductor-fem

name: bioconductor-fem
description: Identification of Functional Epigenetic Modules (FEM) by integrating DNA methylation and gene expression data with protein-protein interaction (PPI) networks. Use this skill when analyzing Illumina (450k/EPIC) methylation data alongside matched transcriptomic data to find subnetworks (hotspots) associated with a phenotype of interest.

## Overview

The `FEM` package identifies "interactome hotspots"—connected subnetworks of a protein interaction network (PIN) that show significant differential promoter methylation and differential expression. It specifically looks for functional modules where an inverse association (anticorrelation) between methylation and expression is present. The core algorithm utilizes a spin-glass community detection approach to find these modules.

## Core Workflow

### 1. Data Preparation
The package requires three main inputs: differential methylation statistics, differential expression statistics, and an adjacency matrix representing the interaction network.

```r
library(FEM)

# Generate statistics from raw/normalized data
# For DNA Methylation (Illumina 450k or EPIC)
statM.o <- GenStatM(dnaM.m, pheno.v, chiptype = "450k")

# For Gene Expression (Entrez ID annotated)
statR.o <- GenStatR(exp.m, pheno.v)
```

### 2. Network Integration
Integrate the statistics with a PPI adjacency matrix (where rows/cols are Entrez IDs).

```r
# cM and cR select the specific contrast/comparison index
intFEM.o <- DoIntFEM450k(statM.o, statR.o, adj.m, cM = 1, cR = 1)
```

### 3. Module Identification
Run the spin-glass algorithm to identify hotspots.

```r
# nseeds: number of seeds to search
# gamma: tuning parameter (0.5 is default, controls module size)
# nMC: Monte Carlo runs for significance
DoFEM.o <- DoFEMbi(intFEM.o, nseeds = 100, gamma = 0.5, nMC = 1000,
                   sizeR.v = c(1, 100), minsizeOUT = 10, writeOUT = TRUE)
```

### 4. Visualization and Results
Extract identified modules and generate network plots.

```r
# View summary table of selected modules
print(DoFEM.o$fem)

# Show a specific module (e.g., centered on gene "HAND2")
# This generates a PDF and returns a graphNEL object
HAND2.graph <- FemModShow(DoFEM.o$topmod$HAND2, name = "HAND2", DoFEM.o)
```

## Specialized Modes

If only one data type is available, use the specific "Mod" functions:

*   **EpiMod**: For methylation hotspots only.
    *   Workflow: `GenStatM` -> `DoIntEpi450k` -> `DoEpiMod`.
    *   Visualization: `FemModShow(..., mode = "Epi")`.
*   **ExpMod**: For expression hotspots only.
    *   Workflow: `GenStatR` -> `DoIntExp` -> `DoExpMod`.

## Key Parameters & Tips

*   **Gamma**: The most critical parameter. Increasing `gamma` results in smaller, more cohesive modules; decreasing it results in larger modules.
*   **Gene Mapping**: For 450k data, `FEM` averages probes within 200bp of the TSS by default. If unavailable, it checks the 1st exon, then within 1500bp of the TSS.
*   **Network Choice**: While the package provides toy data, real-world analysis typically requires a high-quality PPI network (e.g., from Pathway Commons) annotated with Entrez IDs.
*   **Performance**: `DoFEMbi` is computationally intensive. For large networks and many seeds, consider running on a high-performance cluster or reducing `nMC` for initial exploratory runs.

## Reference documentation

- [The FEM R package: Identification of Functional Epigenetic Modules](./references/IntroDoFEM.md)