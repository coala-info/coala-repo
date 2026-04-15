---
name: bioconductor-metabosignal
description: MetaboSignal integrates metabolic and signaling pathways to perform topological analysis of gene-metabolite relationships within directed networks. Use when user asks to build organism-specific networks from KEGG or OmniPath, calculate shortest path distances between genes and metabolites, or identify mechanistic links in mQTL studies.
homepage: https://bioconductor.org/packages/release/bioc/html/MetaboSignal.html
---

# bioconductor-metabosignal

name: bioconductor-metabosignal
description: A network-based approach for topological analysis of metabotype regulation. Use this skill to integrate metabolic and signaling pathways from KEGG, OmniPath, and TRRUST. It is ideal for identifying candidate genes in mQTL studies, exploring trans-acting associations, and finding mechanistic links between genes and metabolites.

## Overview
MetaboSignal is an R package that overlays metabolic and signaling pathways to explore the topological relationships between genes and metabolites. It allows for the construction of organism-specific (and tissue-specific for humans) directed networks. Users can calculate shortest path distances between genes and metabolites and generate subnetworks for visualization in tools like Cytoscape or via igraph in R.

## Core Workflow

### 1. Finding KEGG IDs
Use `MS_keggFinder()` to locate organism codes and pathway IDs.
```r
# Find organism code for rat
MS_keggFinder(KEGG_database = "organism", match = "rattus")

# Find specific pathway IDs
MS_keggFinder(KEGG_database = "pathway", match = c("glycol", "insulin signal"), organism_code = "rno")
```

### 2. Building the Network
Construct the base network by merging metabolic and signaling pathways.
```r
# Define pathways
metabo_paths <- c("rno00010", "rno00562")
signaling_paths <- c("rno04910", "rno04151")

# Build network table
MetaboSignal_table <- MS_keggNetwork(metabo_paths = metabo_paths, 
                                     signaling_paths = signaling_paths,
                                     expand_genes = TRUE)
```

### 3. Network Customization
Refine the network by grouping isomers or removing irrelevant interaction types.
```r
# Group glucose isomers into a single node
MetaboSignal_table <- MS_replaceNode(node1 = c("cpd:C00267", "cpd:C00221"), 
                                     node2 = "cpd:C00031", 
                                     MetaboSignal_table)

# Filter for specific interaction types (e.g., removing 'unknown' or 'binding')
wanted_types <- "activation|phosphorylation|inhibition|compound"
keggNet_clean <- MetaboSignal_table[grep(wanted_types, MetaboSignal_table[, 3]), ]
```

### 4. Integrating Regulatory Resources (Human Only)
For human data, you can merge KEGG with OmniPath (signaling) and TRRUST (transcription factors).
```r
# Build regulatory network
ppiNet <- MS2_ppiNetwork(datasets = "all") # options: "omnipath", "trrust", "all"

# Merge with KEGG network
mergedNet <- MS2_mergeNetworks(keggNet_clean, ppiNet)
```

### 5. Topological Analysis
Calculate distances and generate subnetworks to identify biological links.
```r
# Convert Entrez IDs to KEGG IDs if necessary
genes <- MS_convertGene(genes = c("303565", "65038"), organism_code = "rno")

# Calculate shortest path distances
distances <- MS_distances(MetaboSignal_table, 
                          organism_code = "rno",
                          source_genes = genes$KEGG_ID,
                          target_metabolites = "cpd:C00031")

# Build and export a shortest-path subnetwork for Cytoscape
MS_shortestPathsNetwork(MetaboSignal_table, 
                        organism_code = "rno",
                        source_nodes = genes$KEGG_ID,
                        target_nodes = "cpd:C00031", 
                        type = "bw", 
                        file_name = "MySubnetwork")
```

## Tips and Best Practices
- **Gene IDs**: By default, `MS_keggNetwork` uses Orthology IDs to reduce dimensionality. Set `expand_genes = TRUE` to use specific gene IDs (e.g., Entrez).
- **Distance Mode**: The default `mode = "SP"` in `MS_distances` treats the network as directed except for edges linked to the target metabolite, which are treated as undirected to ensure reachability of substrates in irreversible reactions.
- **Tissue Specificity**: For human networks, use the `hpar` package integration (via `MS_keggNetwork` parameters) to filter for genes expressed in specific tissues.
- **Visualization**: The package exports `.txt` files (Network, NodesType, TargetNodes) specifically formatted for easy import into Cytoscape.

## Reference documentation
- [MetaboSignal: Network-based analysis of metabolic and signaling pathways](./references/MetaboSignal.md)
- [MetaboSignal 2: Merging KEGG with OmniPath and TRRUST](./references/MetaboSignal2.md)