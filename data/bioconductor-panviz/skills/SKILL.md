---
name: bioconductor-panviz
description: PanViz integrates summary-level GWAS data with KEGG biochemical reaction networks to create and visualize integrated multi-omic networks. Use when user asks to map SNPs to metabolic pathways, construct integrated multi-omic networks, or visualize the functional context of genetic variants within the metabolome.
homepage: https://bioconductor.org/packages/3.16/bioc/html/PanViz.html
---


# bioconductor-panviz

## Overview
PanViz is a bioinformatics framework that bridges the gap between statistical SNP associations and biological mechanisms. It integrates summary-level GWAS data with biochemical reaction networks from KEGG to produce "Integrated Multi-Omic Networks" (IMONs). These networks map SNPs to genes, enzymes, reactions, and finally metabolites, allowing researchers to visualize and analyze the functional context of genetic variants within the metabolome.

## Core Workflow

### 1. Data Preparation
PanViz can parse summary-level data from the GWAS Catalog, GWAS Central, or custom user-defined files.

```r
library(PanViz)

# Parse a GWAS Catalog .tsv file
path <- "path/to/gwas_data.tsv"
snp_df <- GWAS_data_reader(
  file = path, 
  snp_col = "SNPS", 
  study_col = "STUDY", 
  trait_col = "DISEASE/TRAIT"
)
```

### 2. Constructing an IMON
The package provides two primary functions for network construction. The `ego` parameter is critical: an ego of 5 represents the path from SNP -> Gene -> Enzyme -> Reaction -> Reaction Pair -> Metabolite (the first layer of the metabolome).

**For a single vector of SNPs:**
```r
data(er_snp_vector)
IMON <- get_IMON(snp_list = er_snp_vector, ego = 5)
```

**For grouped data (e.g., by study or trait):**
```r
# Grouping by study and coloring the network
IMON <- get_grouped_IMON(
  dataframe = snp_df, 
  groupby = "studies", 
  ego = 5, 
  colour_groups = TRUE
)
```

### 3. Visualization and Analysis
The resulting IMON is an `igraph` object, compatible with standard R network analysis tools.

**Static Plotting (Tree Layout):**
```r
library(igraph)
# Layout from SNP (root) down to metabolites
layout <- layout.reingold.tilford(IMON, root = V(IMON)[grepl("SNP", V(IMON)$type)])
plot(IMON, layout = layout, vertex.size = 5, vertex.label = NA)
```

**Interactive Visualization:**
```r
library(networkD3)
IMON_D3 <- igraph_to_networkD3(IMON, group = V(IMON)$color)
forceNetwork(Links = IMON_D3$links, Nodes = IMON_D3$nodes, 
             Source = 'source', Target = 'target', 
             NodeID = 'name', Group = 'group')
```

### 4. Exporting Results
IMONs can be exported for use in external software like Gephi or Python (NetworkX).

```r
get_IMON(snp_list = snps, ego = 5, save_file = TRUE, export_type = "graphml")
```

## Key Parameters and Tips
- **ego**: Controls the depth into the metabolome. `ego = 5` is the minimum to reach metabolites. Increasing this value adds further layers of metabolic reactions.
- **SNP Mapping**: SNPs are mapped to KEGG genes if they fall within a 1Mb range (upstream or downstream) of the gene location.
- **Local Database**: PanViz uses a local capture of KEGG and NCBI data. Use `get_kegg_data()` to update the local cache to the latest versions.
- **Grouping Limit**: `get_grouped_IMON` supports a maximum of 50 total grouping variables.

## Reference documentation
- [PanViz Vignette](./references/my-vignette.md)