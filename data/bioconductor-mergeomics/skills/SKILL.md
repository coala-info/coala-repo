---
name: bioconductor-mergeomics
description: "Mergeomics integrates summary-level association data with biological pathways and gene regulatory networks to identify causal mechanisms and key driver genes. Use when user asks to perform marker set enrichment analysis, identify key driver genes within a network context, integrate GWAS or EWAS results with functional genomics, or conduct meta-analysis across independent omics studies."
homepage: https://bioconductor.org/packages/release/bioc/html/Mergeomics.html
---


# bioconductor-mergeomics

## Overview
Mergeomics is a computational pipeline designed to integrate summary-level association data (e.g., P-values from GWAS/EWAS) with functional genomics (e.g., eQTLs), biological pathways, and gene regulatory networks. It identifies causal biological pathways (MSEA) and the specific "key driver" genes (wKDA) that regulate those pathways within a network context.

## Typical Workflow

### 1. Data Preparation
Mergeomics requires specific input formats (tab-delimited):
*   **Marker-Disease Association**: Columns `MARKER` (ID) and `VALUE` (-log10 P-value).
*   **Gene-Marker Mapping**: Columns `GENE` and `MARKER`.
*   **Gene-Sets (Modules)**: Columns `MODULE` and `GENE`.
*   **Regulatory Network**: Columns `HEAD`, `TAIL`, and `WEIGHT`.

### 2. One-Step Analysis
The simplest way to run the full pipeline (MSEA followed by wKDA) is using `MSEA.KDA.onestep`.

```r
library(Mergeomics)

plan <- list()
plan$label <- "study_label"
plan$folder <- "Results"
plan$genfile <- "path/to/gene_marker_map.txt"
plan$marfile <- "path/to/marker_association.txt"
plan$modfile <- "path/to/modules.txt"
plan$inffile <- "path/to/module_info.txt"
plan$netfile <- "path/to/network.txt"

# Parameters
plan$permtype <- "gene" # Recommended
plan$nperm <- 20000    # Recommended for publication
plan$mingenes <- 10
plan$maxgenes <- 500

results <- MSEA.KDA.onestep(plan, apply.MSEA=TRUE, apply.KDA=TRUE, 
                            maxoverlap.genesets=0.33, symbol.transfer.needed=FALSE)
```

### 3. Step-by-Step Marker Set Enrichment Analysis (MSEA)
Use this to identify enriched pathways before moving to driver analysis.

```r
job.msea <- list(label="HDLC", folder="./Results", nperm=100)
job.msea$genfile <- "genes.txt"
job.msea$marfile <- "markers.txt"
job.msea$modfile <- "modules.txt"
job.msea$inffile <- "info.txt"

job.msea <- ssea.start(job.msea)
job.msea <- ssea.prepare(job.msea)
job.msea <- ssea.control(job.msea)
job.msea <- ssea.analyze(job.msea)
job.msea <- ssea.finish(job.msea)
```

### 4. Weighted Key Driver Analysis (wKDA)
Identifies central regulators of the modules identified in MSEA.

```r
# Convert MSEA results to KDA input
# rmax: overlap threshold to merge redundant modules
job.kda <- ssea2kda(job.msea, rmax=0.33)

job.kda$netfile <- "network.txt"
job.kda <- kda.configure(job.kda)
job.kda <- kda.start(job.kda)
job.kda <- kda.prepare(job.kda)
job.kda <- kda.analyze(job.kda)
job.kda <- kda.finish(job.kda)

# Export for Cytoscape visualization
job.kda <- kda2cytoscape(job.kda)
```

## Key Functions and Parameters
*   `ssea.meta()`: Performs Meta-MSEA to combine results from multiple independent studies (e.g., different ethnicities or species).
*   `tool.translate()`: Useful for converting gene symbols between species (e.g., Human to Mouse) during integration.
*   `permtype`: Set to `"gene"` for gene-level permutation (robust) or `"locus"` for marker-level.
*   `edgefactor`: In wKDA, determines how much edge weight influences the analysis (0 to 1).
*   `depth`: In wKDA, defines the search distance in the network (default is 1, meaning immediate neighbors).

## Tips for Success
1.  **Pruning**: Use the external `MDPrune` tool (C++) if markers have high Linkage Disequilibrium (LD), as dependency can bias enrichment scores.
2.  **Module Merging**: Pathways from different databases often overlap. Use `ssea2kda` with an `rmax` (e.g., 0.33) to merge redundant modules into independent clusters before KDA.
3.  **Permutations**: While 100-1000 permutations are fine for testing, use 20,000 for final results to ensure stable FDR estimates.

## Reference documentation
- [Mergeomics: Integrative Network Analysis of Omics Data](./references/Mergeomics.md)