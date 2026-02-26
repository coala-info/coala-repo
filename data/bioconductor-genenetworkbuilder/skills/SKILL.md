---
name: bioconductor-genenetworkbuilder
description: GeneNetworkBuilder integrates transcription factor binding data with expression profiles to construct and visualize regulatory networks. Use when user asks to build gene regulatory networks, integrate ChIP-seq with RNA-seq data, identify direct and indirect targets, or visualize TF-miRNA interactions.
homepage: https://bioconductor.org/packages/release/bioc/html/GeneNetworkBuilder.html
---


# bioconductor-genenetworkbuilder

name: bioconductor-genenetworkbuilder
description: Expert guidance for using the GeneNetworkBuilder R package to construct and visualize regulatory networks. Use this skill when you need to integrate transcription factor (TF) binding data (ChIP-seq/ChIP-chip) with gene and miRNA expression data (RNA-seq/microarray) to identify direct and indirect targets.

## Overview

GeneNetworkBuilder (GNB) is designed to discover regulatory relationships by combining physical binding evidence with functional expression data. It generates directed acyclic graphs representing TF -> gene, TF -> miRNA, or miRNA -> gene interactions. It is particularly useful for identifying "master regulator" networks where a TF regulates other TFs or miRNAs, leading to downstream indirect effects.

## Core Workflow

The standard workflow consists of four primary steps:

1.  **Build**: Create an initial network based on TF binding sites and known interaction maps.
2.  **Filter**: Refine the network using differential expression data (fold changes and p-values).
3.  **Polish**: Format the network into a `graphNEL` object with visual styles (colors, sizes).
4.  **Visualize/Export**: View the network in a browser or export to formats like XGMML (Cytoscape).

## Key Functions and Usage

### 1. Building the Network
Use `buildNetwork` to create the scaffold. You need a binding table and an interaction map (GNB provides maps for *C. elegans* and *H. sapiens*).

```r
library(GeneNetworkBuilder)
data("ce.interactionmap") # or hs.interactionmap
# TFbindingTable: 2 columns (from, to)
sifNetwork <- buildNetwork(TFbindingTable = my_binding_data, 
                           interactionmap = ce.interactionmap, 
                           level = 2)
```

### 2. Filtering by Expression
Use `filterNetwork` to keep only interactions supported by expression changes.

```r
# Ensure expression data is unique per gene
exprData <- uniqueExprsData(my_raw_expr, method = "Max", condenseName = "logFC")

cifNetwork <- filterNetwork(rootgene = "Target_TF_ID", 
                            sifNetwork = sifNetwork,
                            exprsData = exprData, 
                            mergeBy = "symbols",
                            miRNAlist = as.character(ce.miRNA.map[, 1]),
                            tolerance = 1)
```

### 3. Polishing and Visualization
Convert the filtered network into a visualizable object.

```r
# Generate graphNEL object
gR <- polishNetwork(cifNetwork, 
                    nodecolor = colorRampPalette(c("green", "yellow", "red"))(5))

# Interactive browser visualization
browseNetwork(gR)

# Export for Cytoscape
exportNetwork(browseNetwork(gR), file = "network.xgmml", format = "XGMML")
```

## Advanced Features

### Network from Gene Lists (STRING Integration)
If you lack specific TF binding data but have a list of differentially expressed genes, use `networkFromGenes` to infer connections via the STRING database.

```r
# After mapping genes to STRING IDs
x <- networkFromGenes(genes = sig_genes, interactionmap = string_interactions, level = 3)
```

### ID Conversion
GNB requires consistent IDs. Use `convertID` to switch between symbols and database-specific IDs (e.g., WormBase IDs or Entrez IDs).

```r
data("ce.IDsMap")
bind <- convertID(toupper(bind), IDsMap = ce.IDsMap, ByName = c("from", "to"))
```

### Subsetting
Focus on specific biological processes by subsetting the graph using a gene list (e.g., from a GO term).

```r
gRs <- subsetNetwork(gR, go_gene_list)
```

## Tips for Success
- **Data Consistency**: Ensure the tissue type and developmental stage of the ChIP data match the expression data for biological relevance.
- **miRNA Integration**: When using miRNA expression data, set `miRNAtol = TRUE` in `filterNetwork`.
- **Root Selection**: The `rootgene` in `filterNetwork` should be the primary TF you are investigating.
- **Graph Analysis**: Since the output is a `graphNEL` object, you can use the `RBGL` package to calculate shortest paths or `Rgraphviz` for custom static plots.

## Reference documentation
- [GeneNetworkBuilder Guide](./references/GeneNetworkBuilder_vignettes.md)
- [Generating Networks from Gene Lists](./references/GeneNetworkFromGenes.md)