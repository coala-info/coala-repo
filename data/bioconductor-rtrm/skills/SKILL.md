---
name: bioconductor-rtrm
description: This tool identifies Transcriptional Regulatory Modules by integrating protein-protein interaction networks, transcription factor binding motifs, and gene expression data. Use when user asks to identify transcriptional regulatory modules, find transcription factors that cooperate with a target protein, or visualize regulatory networks using specialized layouts.
homepage: https://bioconductor.org/packages/release/bioc/html/rTRM.html
---

# bioconductor-rtrm

name: bioconductor-rtrm
description: Identification of Transcriptional Regulatory Modules (TRMs) by integrating ChIP-seq data, transcription factor (TF) binding motifs, protein-protein interaction (PPI) networks, and gene expression. Use this skill to find TFs that cooperate with a target TF (e.g., from ChIP-seq) either through direct interaction or via bridge proteins.

## Overview

The `rTRM` package identifies Transcriptional Regulatory Modules (TRMs) by finding paths in a protein-protein interaction (PPI) network between a "target" TF (experimentally verified, e.g., via ChIP-seq) and "query" TFs (identified via motif enrichment in the target's binding regions). It supports the inclusion of "bridge" proteins to connect TFs that do not interact directly and allows filtering by cell-type-specific gene expression.

## Core Workflow

### 1. Data Preparation
TRM identification requires a PPI network (igraph object), a target TF, and a list of query TFs (usually Entrez Gene IDs).

```R
library(rTRM)
library(igraph)
library(org.Mm.eg.db) # Or org.Hs.eg.db for human

# Load default BioGRID mouse PPI network
data(biogrid_mm)
ppi <- biogrid_mm

# Define target (e.g., Sox2)
target_id <- select(org.Mm.eg.db, keys="Sox2", columns="ENTREZID", keytype="SYMBOL")$ENTREZID

# Define query TFs (e.g., from motif enrichment)
query_ids <- c("18999", "20674", "16600") 
```

### 2. Network Pre-processing
It is recommended to remove high-degree ubiquitin/sumo outliers and filter the network for genes expressed in your specific biological context.

```R
# Remove common outliers
outliers <- c("22190", "22218", "170930", "20610") # Ubc, Sumo1, Sumo2, Sumo3
ppi <- delete_vertices(ppi, V(ppi)[name %in% outliers])

# Filter by expression (eg_esc is a vector of expressed Entrez IDs)
ppi_filtered <- induced_subgraph(ppi, V(ppi)[name %in% eg_esc])

# Keep only the largest connected component
ppi_filtered <- getLargestComp(ppi_filtered)
```

### 3. Identifying the TRM
Use `findTRM` to extract the sub-network connecting the target and query nodes.

```R
# max.bridge = 1 allows one intermediate protein between target and query
trm_graph <- findTRM(ppi_filtered, target = target_id, query = query_ids, 
                     method = "nsa", max.bridge = 1)
```

### 4. Visualization
`rTRM` provides specialized layouts to represent the hierarchical nature of the module.

```R
# Concentric layout: Target in center, bridges in middle, queries in outer ring
cl <- getConcentricList(trm_graph, target = target_id, query = query_ids)
l_concentric <- layout.concentric(trm_graph, cl, order = "label")

# Plotting
plotTRM(trm_graph, layout = l_concentric, vertex.cex = 15, label.cex = 0.8)
plotTRMlegend(trm_graph, title = "My TRM", cex = 0.8)

# Alternative: Linear arc layout
l_arc <- layout.arc(trm_graph, target = target_id, query = query_ids)
plotTRM(trm_graph, layout = l_arc)
```

## Database Utilities

The package includes a built-in SQLite database for TF annotations and PWMs.

- `getMatrices()`: Retrieve Position Specific Weight Matrices.
- `getAnnotations()`: Get TF family and domain information.
- `getMaps()`: Map PWM IDs to Entrez Gene IDs.
- `getOrthologFromMatrix(ids, organism)`: Convert motif IDs to Entrez IDs for a specific organism (human/mouse).
- `getBiogridData()` / `processBiogrid()`: Download and process the latest PPI data from BioGRID.

## Tips for Success
- **ID Mapping**: Ensure all node names in your igraph object are Entrez Gene IDs (character strings), as this is the standard for `rTRM`'s internal mapping.
- **Bridge Nodes**: Setting `max.bridge = 0` finds only direct interactors. `max.bridge = 1` is usually sufficient for biological relevance without creating "hairball" networks.
- **External Enrichment**: While `rTRM` provides some motif tools, you can use `PWMEnrich` or `MotifDb` to generate the initial `query` list from ChIP-seq peaks.

## Reference documentation
- [Introduction](./references/Introduction.md)