---
name: bioconductor-graphite
description: This tool retrieves biological pathways from multiple databases and performs topological pathway analyses on transcriptomic and metabolomic data. Use when user asks to retrieve pathways, convert node identifiers, or perform topological analyses like SPIA, clipper, and topologyGSA.
homepage: https://bioconductor.org/packages/release/bioc/html/graphite.html
---

# bioconductor-graphite

name: bioconductor-graphite
description: Expert guidance for the Bioconductor R package 'graphite' (GRAPH Interaction from pathway Topological Environment). Use this skill to retrieve biological pathways from multiple databases (KEGG, Reactome, Panther, etc.), convert node identifiers (Entrez, Symbol, Uniprot, CAS), and perform topological pathway analyses (SPIA, topologyGSA, clipper) on transcriptomic and metabolomic data.

## Overview

The `graphite` package is a comprehensive tool for pathway analysis that bridges the gap between raw pathway databases and topological statistical methods. It provides access to curated networks from eight major databases and supports three distinct views for every pathway: gene-only, metabolite-only, and mixed (genes + metabolites). This makes it particularly powerful for integrated multi-omics studies.

## Core Workflow

### 1. Loading Pathways
Pathways are organized by species and database. Use `pathwayDatabases()` to see available combinations.

```R
library(graphite)

# Load human Reactome pathways
humanReactome <- pathways("hsapiens", "reactome")

# Access a specific pathway by name or index
p <- humanReactome[["Apoptosis"]]
```

### 2. Identifier Conversion
Pathway nodes often use database-specific IDs (e.g., Uniprot). Use `convertIdentifiers` to match your experimental data (e.g., Symbol, Entrez, Ensembl, or CAS for metabolites).

```R
# Convert gene IDs to Symbols
pSymbol <- convertIdentifiers(p, "SYMBOL")

# Convert a whole list of pathways (supports parallelism)
options(Ncpus = 4)
reactomeSymbol <- convertIdentifiers(humanReactome, "SYMBOL")
```

### 3. Accessing Network Topology
You can extract nodes and edges or convert the pathway into a `graphNEL` object for use with other R graph packages.

```R
# Get edges with specific view: "genes" (default), "metabolites", or "mixed"
edge_list <- edges(p, which = "mixed")

# Convert to graphNEL
g <- pathwayGraph(p, which = "mixed")
```

### 4. Topological Pathway Analysis
`graphite` provides wrappers for three major algorithms. Note that input data IDs must match the pathway IDs (including the prefix, e.g., "SYMBOL:TP53").

#### SPIA (Signaling Pathway Impact Analysis)
Requires a named vector of log fold changes and a vector of all genes in the platform.
```R
# Prepare SPIA data in the current directory
prepareSPIA(kegg_pathways, "kegg_data")
res <- runSPIA(de_genes, all_genes, "kegg_data")
```

#### clipper
Best suited for metabolomics or mixed data. It tests for differences in means and concentration matrices.
```R
# Run clipper on a pathway list
# classes: vector of 1s and 2s indicating groups
clipped <- runClipper(pathway_list, expr_matrix, classes, "mean", which = "mixed")
```

#### topologyGSA
Uses graphical models to test pathway deregulation.
```R
# Run on a single pathway
res <- runTopologyGSA(p, "var", group1_matrix, group2_matrix, 0.05)
```

## Working with Metabolites
Since version 1.24, `graphite` supports metabolomics.
- **Mixed Networks**: Use `which = "mixed"` in `nodes`, `edges`, `pathwayGraph`, and `runClipper`.
- **Metabolite IDs**: Commonly uses `CAS` or `KEGGCOMP` (KEGG Compound).
- **Propagation**: In "gene-only" views, edges are propagated through metabolites to maintain signal flow. In "metabolite-only" views, edges are propagated through proteins.

## Tips for Success
- **ID Prefixes**: Always check if your data rownames have the required prefix (e.g., `ENTREZID:`, `SYMBOL:`, `CAS:`). `graphite` uses these to distinguish node types in mixed networks.
- **Parallelism**: Functions like `convertIdentifiers`, `runClipper`, and `runTopologyGSA` respect `options(Ncpus = X)`. Always pass the entire list of pathways to the function rather than using `lapply` to trigger parallel execution.
- **Filtering**: Before running `clipper` or `SPIA`, filter pathways to ensure they have a minimum number of measured nodes (e.g., at least 10 edges present in your data) to avoid statistical artifacts.

## Reference documentation
- [graphite](./references/graphite.md)
- [Pathway Analysis of Metabolic Activities (Rmd)](./references/metabolites.Rmd)
- [Pathway Analysis of Metabolic Activities (HTML)](./references/metabolites.md)