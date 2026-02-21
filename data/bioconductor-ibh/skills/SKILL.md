---
name: bioconductor-ibh
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ibh.html
---

# bioconductor-ibh

name: bioconductor-ibh
description: Calculate Interaction Based Homogeneity (IBH) to evaluate the fitness of gene lists or clustering results against biological interaction networks. Use this skill when you need to assess gene list quality using BioGRID data or custom adjacency matrices, or when evaluating the homogeneity of R-based clustering outputs (e.g., kmeans, hclust) in a biological context.

# bioconductor-ibh

## Overview
The `ibh` package provides a quantitative metric to measure the quality of gene lists by calculating their Interaction Based Homogeneity. IBH measures how well a set of genes fits into a known interaction network (like BioGRID). A score of 1 indicates a perfectly connected clique, while 0 indicates no interactions among the genes in the list. This is particularly useful for validating clustering results or comparing different genomic algorithms.

## Core Workflows

### 1. Calculating IBH for a Single Gene List
Use `ibhBioGRID` for quick assessment using built-in BioGRID data, or `ibh` if you have a custom interaction list.

```r
library(ibh)

# Using BioGRID data (requires organism and idType)
# Supported organisms: "arabidopsis", "celegans", "fly", "human", "mouse", "yeast", "pombe"
# Supported idTypes: "EntrezId", "OfficialSymbol", "UniqueId"
gene_list <- c("YJR151C", "YBL032W", "YAL040C", "YBL072C")
score <- ibhBioGRID(gene_list, organism = "yeast", idType = "UniqueId")

# Using custom interactions (requires an adjacency list/matrix)
# data(ArabidopsisBioGRIDInteractionEntrezId)
# custom_score <- ibh(my_interaction_data, gene_list)
```

### 2. Evaluating Multiple Gene Lists
To compare multiple clusters or gene sets simultaneously, use the "Multiple" variants which return a vector of scores.

```r
list_of_lists <- list(
  cluster1 = c(839226, 817241, 824340),
  cluster2 = c(832018, 839226, 838824)
)

# Returns a vector of IBH values
scores <- ibhForMultipleGeneListsBioGRID(list_of_lists, organism = "arabidopsis", idType = "EntrezId")
```

### 3. Evaluating Clustering Results
The `ibhClusterEval` functions are designed to work directly with R clustering objects (like those from `kmeans`).

```r
# Example: Evaluating kmeans clusters
# k$cluster is the vector of cluster assignments
# rownames(data) contains the gene identifiers
results <- ibhClusterEvalBioGRID(
  cluster_assignments = k$cluster, 
  gene_names = rownames(subset_data), 
  organism = "human", 
  idType = "OfficialSymbol"
)
```

### 4. Importing Custom Networks
If not using BioGRID, you can import interaction data from CSV files.

```r
# For undirected networks (A-B is the same as B-A)
my_network <- readUndirectedInteractionsFromCsv("path/to/interactions.csv")

# For directed networks
my_directed_network <- readDirectedInteractionsFromCsv("path/to/interactions.csv")
```

## Tips and Best Practices
- **Identifier Consistency**: Ensure the `idType` matches the format of your gene list (e.g., don't pass Entrez IDs if `idType` is set to "OfficialSymbol").
- **Handling NaN**: If a cluster has no genes present in the interaction network, the function may return `NaN`.
- **Data Availability**: Predefined interactions are available for 7 model organisms: Arabidopsis, C. elegans, D. melanogaster, H. sapiens, M. musculus, S. cerevisiae, and S. pombe.
- **Search**: Use `findEntry(interaction_list, "gene_id")` to check if a specific gene exists within your interaction network object.

## Reference documentation
- [Interaction Based Homogeneity](./references/ibh.md)