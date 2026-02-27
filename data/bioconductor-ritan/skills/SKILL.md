---
name: bioconductor-ritan
description: RITAN integrates multiple annotation resources and network interaction data to perform functional enrichment and network analysis on gene lists. Use when user asks to perform term enrichment analysis, compare enrichment across multiple gene subsets, or identify induced interaction subnetworks from gene sets.
homepage: https://bioconductor.org/packages/release/bioc/html/RITAN.html
---


# bioconductor-ritan

## Overview
RITAN (Rapid Integration of Term Annotation and Network resources) is a Bioconductor package designed to simplify the functional annotation of gene lists. It consolidates multiple resources (GO, Reactome, MSigDB, KEGG, etc.) and network interaction data (STRING, PID, BioGRID, etc.) into a unified framework. It is particularly useful for identifying biological pathways and physical interaction networks within a set of differentially expressed genes.

## Core Workflows

### 1. Term Enrichment Analysis
The primary function for identifying overrepresented biological terms in a gene list.

```r
library(RITAN)
library(RITANdata)

# Basic enrichment using default resources
my_genes <- c('ABCA2','ACAT2','ACSS2','CD9','FASN','LDLR','LPL')
e <- term_enrichment(my_genes, all_symbols = cached_coding_genes)

# Enrichment across specific resources
# Available: "GO", "ReactomePathways", "MSigDB_Hallmarks", "KEGG_filtered_canonical_pathways", etc.
e_specific <- term_enrichment(my_genes, resources = c("ReactomePathways", "MSigDB_Hallmarks"))

# View top results
summary(e_specific)
```

### 2. Multi-Subset Enrichment
Use `term_enrichment_by_subset` to compare enrichment across multiple gene lists (e.g., different experimental conditions) and visualize with a heatmap.

```r
# study_set is a list of gene vectors
e_subset <- term_enrichment_by_subset(study_set, resources = c("MSigDB_Hallmarks"))

# Plot heatmap of -log10(q-value)
# Use 'cap' to prevent one highly significant term from dominating the color scale
plot(e_subset, cap = 10, show_values = TRUE)
```

### 3. Network Analysis (Induced Subnetworks)
Identify how genes in your list interact with each other or their neighbors using various interaction databases.

```r
# Find interactions within the gene list (Induced Subnetwork)
net <- network_overlap(my_genes, resources = c('CCSB', 'PID', 'dPPI'))

# Include first-degree neighbors to expand the network
net_neighbors <- network_overlap(my_genes, resources = 'PID', include_neighbors = TRUE)

# Filter STRING interactions by confidence score (0-1000)
net_string <- network_overlap(my_genes, resources = 'STRING', minStringScore = 700)

# Convert to igraph object for visualization
library(igraph)
g <- as.graph(net)
plot(g)
```

### 4. Resource Management and Custom Data
RITAN allows merging redundant terms and loading custom GMT files.

```r
# Load a custom GMT file
my_resource <- readGMT("path/to/file.gmt")
e_custom <- term_enrichment(my_genes, resources = my_resource)

# Reduce redundancy by merging terms with high overlap (>80%)
unique_terms <- resource_reduce(geneset_list$DisGeNet, min_overlap = 0.8)
```

## Tips for Effective Use
- **Gene Symbols**: RITAN uses HGNC gene symbols. Ensure your input list matches this format. Use `check_any_net_input(my_genes)` to verify if your symbols exist in the network resources.
- **Background Genes**: Always provide `all_symbols = cached_coding_genes` (or a study-specific background) to `term_enrichment` for accurate hypergeometric testing.
- **Multiple Testing**: RITAN performs FDR adjustment (q-values) across all resources requested. Be selective with resources to avoid overly conservative adjustments.
- **Resource Selection**: 
  - Use `CCSB` or `dPPI` for physical protein-protein interactions.
  - Use `TFe` or `ChEA` for transcription factor targets.
  - Use `HumanNet` or `STRING` for broad, integrated functional associations.

## Reference documentation
- [Choosing Resources](./references/choosing_resources.md)
- [Enrichment Analysis](./references/enrichment.md)
- [Multi-Tissue Analysis](./references/multi_tissue_analysis.md)
- [Resource Relationships](./references/resource_relationships.md)
- [Subnetworks and Network Biology](./references/subnetworks.md)