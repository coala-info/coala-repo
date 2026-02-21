---
name: bioconductor-gatom
description: The package further provides functions for module post-processing, annotation and visualization.
homepage: https://bioconductor.org/packages/release/bioc/html/gatom.html
---

# bioconductor-gatom

name: bioconductor-gatom
description: Finding active metabolic modules from transcriptional and metabolic data using the gatom R package. Use this skill when you need to identify highly regulated metabolic subnetworks (modules) by integrating gene expression (differential expression) and metabolite abundance data. It supports KEGG, Rhea, and combined networks, and provides tools for scoring, solving (SGMWCS problem), and visualizing metabolic modules.

## Overview

The `gatom` package identifies "active modules"—subnetworks of a metabolic graph that show significant coordinated changes across experimental conditions. It integrates transcriptomic and metabolomic data by mapping them onto a metabolic reaction network (atom-level or metabolite-level). The core workflow involves building a metabolic graph, scoring nodes and edges based on p-values, and solving the Maximum Weight Connected Subgraph (MWCS) problem to extract the most regulated module.

## Core Workflow

### 1. Load Data and Annotations
The package requires differential expression (DE) tables for genes and/or metabolites, a reaction network, and organism-specific annotations.

```R
library(gatom)
library(data.table)
library(igraph)
library(mwcsr)

# Load input DE data (columns: ID, pval, log2FC)
data("gene.de.rawEx")
data("met.de.rawEx")

# Load network and annotations
data("networkEx")
data("met.kegg.dbEx")
data("org.Mm.eg.gatom.annoEx")
```

### 2. Create the Metabolic Graph
Use `makeMetabolicGraph` to build the network. The `topology` parameter is crucial: `"atoms"` (default, more structured) or `"metabolites"`.

```R
g <- makeMetabolicGraph(network=networkEx, 
                        topology="atoms",
                        org.gatom.anno=org.Mm.eg.gatom.annoEx, 
                        gene.de=gene.de.rawEx,
                        met.db=met.kegg.dbEx, 
                        met.de=met.de.rawEx)
```

### 3. Scoring the Graph
Scores are assigned to nodes and edges based on p-values. Adjust `k.gene` and `k.met` to control module size (higher values = larger modules).

```R
# Score the graph (set k to NULL if data for that type is missing)
gs <- scoreGraph(g, k.gene = 25, k.met = 25)
```

### 4. Solve for the Active Module
Use the `mwcsr` package solvers. `rnc_solver()` is a fast heuristic; `virgo_solver()` is exact but requires Java and CPLEX.

```R
solver <- rnc_solver()
set.seed(42)
res <- solve_mwcsp(solver, gs)
m <- res$graph # This is the resulting active module (igraph object)
```

## Visualization and Export

### Interactive Visualization
```R
# Create an interactive Shiny/Cytoscape widget
createShinyCyJSWidget(m)

# Save to HTML
saveModuleToHtml(m, file = "module.html", name = "ActiveModule")
```

### Static Export
```R
# Save as PDF with nice layout
saveModuleToPdf(m, file = "module.pdf", name = "ActiveModule")

# Save as GraphML for Cytoscape desktop
write_graph(m, file = "module.graphml", format = "graphml")
```

## Advanced Usage

### Network Types
- **KEGG**: Standard metabolic IDs.
- **Rhea**: Uses ChEBI IDs for metabolites; often requires `gene2reaction.extra` files for better gene mapping.
- **Combined**: Integrates KEGG, Rhea, and BiGG transport reactions.
- **Lipid Subnetwork**: Specialized for lipidomics; recommended to use `topology="metabolites"`.

### Pathway Enrichment
Annotate the resulting module using `fgsea`:
```R
foraRes <- fgsea::fora(pathways = org.Mm.eg.gatom.anno$pathways,
                       genes = E(m)$gene,
                       universe = unique(E(g)$gene))
```

## Tips for Success
- **Missing Data**: If you only have gene data, set `met.de = NULL` in `makeMetabolicGraph` and `k.met = NULL` in `scoreGraph`.
- **ID Mapping**: Ensure gene IDs match the `org.gatom.anno` (e.g., Entrez, Symbol, or RefSeq) and metabolite IDs match the `met.db` (e.g., HMDB, ChEBI, or KEGG).
- **Solver Choice**: For publication-quality results, use `virgo_solver()` if CPLEX is available to ensure an exact solution.

## Reference documentation
- [Using gatom package](./references/gatom-tutorial.md)
- [Using gatom package (RMarkdown)](./references/gatom-tutorial.Rmd)