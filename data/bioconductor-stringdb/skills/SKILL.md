---
name: bioconductor-stringdb
description: This tool provides an R interface to access and analyze protein-protein interaction networks from the STRING database. Use when user asks to map gene identifiers to STRING IDs, retrieve protein interactions, perform functional enrichment analysis, or visualize and cluster interaction networks.
homepage: https://bioconductor.org/packages/release/bioc/html/STRINGdb.html
---


# bioconductor-stringdb

name: bioconductor-stringdb
description: Access and analyze protein-protein interaction (PPI) networks from the STRING database. Use this skill to map gene/protein identifiers to STRING IDs, retrieve interactions, perform functional enrichment analysis (GO, KEGG, Reactome), and visualize networks or clusters within R.

## Overview

The `STRINGdb` package provides an R interface to the Search Tool for the Retrieval of Interacting Genes/Proteins (STRING) database. It is designed to add functional meaning to gene lists (e.g., differential expression results) by mapping them to known and predicted protein interactions. The package uses ReferenceClasses and represents networks using `igraph` objects.

## Core Workflow

### 1. Initialization
Create a STRINGdb instance by specifying the organism's NCBI taxonomy ID (e.g., 9606 for Human, 10090 for Mouse).

```R
library(STRINGdb)
string_db <- STRINGdb$new(version="12.0", species=9606, score_threshold=400, network_type="functional")
```
- `score_threshold`: Minimum confidence score (default 400).
- `network_type`: "functional" (full network) or "physical" (physical complexes only).

### 2. Mapping Identifiers
Map your gene list (HUGO, Entrez, Ensembl, etc.) to STRING identifiers.

```R
# For a dataframe with a 'gene' column
example_mapped <- string_db$map(my_dataframe, "gene", removeUnmappedRows = TRUE)

# For a simple vector of names
string_ids <- string_db$mp(c("tp53", "atm"))
```

### 3. Network Visualization
Visualize the interactions among your "hits" (mapped STRING IDs).

```R
hits <- example_mapped$STRING_id[1:200]
string_db$plot_network(hits)
```

### 4. Functional Enrichment
Compute enrichment for GO terms, KEGG/Reactome pathways, and protein domains.

```R
# Optional: Set background if using a specific gene set (e.g., all genes on a microarray)
string_db$set_background(example_mapped$STRING_id)

# Get enrichment table
enrichment <- string_db$get_enrichment(hits)
head(enrichment)
```

### 5. Clustering
Identify functional modules within your network using algorithms like "fastgreedy" or "walktrap".

```R
clustersList <- string_db$get_clusters(hits)
# Plot the largest cluster
string_db$plot_network(clustersList[[1]])
```

### 6. Payload Mechanism (Custom Coloring)
Color network nodes based on external data, such as log fold change from differential expression.

```R
# Add color column based on logFC
mapped_with_color <- string_db$add_diff_exp_color(example_mapped, logFcColStr="logFC")

# Post to server and plot
payload_id <- string_db$post_payload(mapped_with_color$STRING_id, colors=mapped_with_color$color)
string_db$plot_network(hits, payload_id=payload_id)
```

## Useful Methods
- `string_db$get_proteins()`: Returns the full protein table for the species.
- `string_db$get_neighbors(ids)`: Returns neighbors of the input proteins.
- `string_db$get_interactions(ids)`: Returns interactions between the input proteins.
- `string_db$get_subnetwork(ids)`: Returns an igraph object of the subnetwork.

## Tips
- **Taxonomy IDs**: Always verify the NCBI taxonomy ID for your organism.
- **Igraph Integration**: Use `string_db$get_graph()` to get the full network as an `igraph` object for advanced topological analysis.
- **Offline Use**: Set `input_directory` in the constructor to cache database files locally for offline access.

## Reference documentation
- [STRINGdb Package Vignette](./references/STRINGdb.md)