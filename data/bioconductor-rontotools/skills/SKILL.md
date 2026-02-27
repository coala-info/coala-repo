---
name: bioconductor-rontotools
description: This tool performs pathway enrichment and impact analysis by incorporating gene significance and fold changes into signaling network topologies. Use when user asks to download KEGG pathway graphs, execute Pathway-Express or Primary Dis-regulation algorithms, and identify significantly impacted biological pathways.
homepage: https://bioconductor.org/packages/release/bioc/html/ROntoTools.html
---


# bioconductor-rontotools

name: bioconductor-rontotools
description: Perform pathway enrichment and impact analysis using the ROntoTools package. Use this skill to download KEGG pathway graphs, incorporate gene significance (p-values) and fold changes into signaling network analysis, and execute Pathway-Express (PE) or Primary Dis-regulation (pDis) algorithms to identify significantly impacted biological pathways.

## Overview
ROntoTools is an R package for functional profiling of high-throughput data. Its flagship tool, Pathway-Express, goes beyond simple Over-Representation Analysis (ORA) by considering the topology of signaling pathways, including the type, position, and magnitude of gene interactions. It also supports Primary Dis-regulation analysis to account for upstream signaling effects.

## Core Workflow

### 1. Prepare Pathway Graphs
Download and weight KEGG pathways for a specific organism (e.g., "hsa" for human).

```r
library(ROntoTools)
library(graph)

# Download KEGG pathways (use updateCache = TRUE for latest data)
kpg <- keggPathwayGraphs("hsa", verbose = FALSE)

# Get pathway names for better reporting
kpn <- keggPathwayNames("hsa")

# Set edge weights based on interaction type (e.g., activation vs inhibition)
kpg <- setEdgeWeights(kpg, edgeTypeAttr = "subtype", 
                      edgeWeightByType = list(activation = 1, inhibition = -1, 
                                              expression = 1, repression = -1),
                      defaultWeight = 0)
```

### 2. Prepare Experimental Data
Input data should be named vectors where names are Entrez IDs.

```r
# fc: named vector of log fold changes
# pv: named vector of p-values
# ref: character vector of all genes measured in the experiment (background)

# Filter for differentially expressed genes (DEGs)
deg_fc <- fc[pv <= 0.05]
deg_pv <- pv[pv <= 0.05]
```

### 3. Set Node Weights
Incorporate gene significance into the pathway graphs using `alphaMLG` (log-based) or `alpha1MR` (linear-based).

```r
# Apply significance weights to the pathway list
kpg <- setNodeWeights(kpg, weights = alphaMLG(deg_pv), defaultWeight = 1)
```

### 4. Run Pathway Analysis
Execute Pathway-Express (PE) or Primary Dis-regulation (pDis).

```r
# Pathway-Express
peRes <- pe(x = deg_fc, graphs = kpg, ref = ref, nboot = 200)

# Primary Dis-regulation
pDisRes <- pDis(x = deg_fc, graphs = kpg, ref = ref, nboot = 200)
```

### 5. Summarize and Visualize Results
Extract a ranked table of pathways and visualize the impact.

```r
# Generate summary table
resTable <- Summary(peRes, pathNames = kpn, order.by = "pComb")
head(resTable)

# Global plot (pAcc vs pORA)
plot(peRes)

# Visualize a specific pathway's perturbation propagation
# Requires Rgraphviz
p <- peRes@pathways[["path:hsa04110"]] # Example: Cell Cycle
g <- layoutGraph(p@map, layoutType = "dot")
edgeRenderInfo(g) <- peEdgeRenderInfo(p)
nodeRenderInfo(g) <- peNodeRenderInfo(p)
renderGraph(g)
```

## Tips for Success
- **Entrez IDs**: Ensure your gene identifiers are Entrez IDs (e.g., "hsa:1029"), as KEGG pathways use this format.
- **Bootstrapping**: The `nboot` parameter affects p-value precision. Use a low value (200) for testing and a higher value (1000+) for publication-quality results.
- **Edge Weights**: Customizing `edgeWeightByType` allows you to model specific biological assumptions about how signals propagate (e.g., treating "phosphorylation" as an activation).
- **Missing Genes**: Genes in your `fc` vector that are not in the pathway graph are ignored; genes in the graph not in your `fc` vector are treated as having zero change.

## Reference documentation
- [ROntoTools: The R Onto-Tools suite](./references/rontotools.md)