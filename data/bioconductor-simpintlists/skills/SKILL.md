---
name: bioconductor-simpintlists
description: This tool retrieves and queries BioGRID protein-protein interaction data for seven major model organisms using various gene identifier types. Use when user asks to access interaction lists, retrieve protein interactors by Entrez ID or gene name, or build biological network adjacency lists.
homepage: https://bioconductor.org/packages/release/data/experiment/html/simpIntLists.html
---


# bioconductor-simpintlists

name: bioconductor-simpintlists
description: Access and query BioGRID protein-protein interaction data for Arabidopsis, C. elegans, Fruit Fly, Human, Mouse, Yeast, and S. pombe. Use this skill to retrieve interaction lists using Entrez IDs, Official Gene Names, or Unique IDs (Systematic Names) for biological network analysis.

## Overview

The `simpIntLists` package provides a simplified interface to BioGRID interaction data for seven major model organisms. The data is structured as R lists where each entry represents a protein/gene ("name") and its associated "interactors". This format is particularly useful for building adjacency lists or network graphs in R.

## Core Workflows

### 1. Finding Interaction Lists
The primary function is `findInteractionList()`, which dynamically retrieves the dataset based on the organism and identifier type.

```R
library(simpIntLists)

# Arguments:
# organism: 'arabidopsis', 'c.elegans', 'fruitFly', 'human', 'mouse', 'yeast', 's.pombe'
# idType: 'EntrezId', 'Official', 'UniqueId'

human_interactions <- findInteractionList(organism = "human", idType = "Official")
```

### 2. Loading Specific Datasets
Alternatively, you can load datasets directly using the `data()` function. The naming convention is `[Organism]BioGRIDInteraction[IdType]`.

```R
# Load Human Entrez ID interactions
data(HumanBioGRIDInteractionEntrezId)

# Load Yeast Unique ID (Systematic Name) interactions
data(YeastBioGRIDInteractionUniqueId)
```

### 3. Accessing Interaction Data
The returned object is a list of lists. Each sub-list contains:
- `$name`: The identifier of the query protein.
- `$interactors`: A vector of identifiers for proteins that interact with the query protein.

```R
# View the first interaction entry
human_interactions[[1]]

# Access the name and interactors of the 10th entry
gene_name <- human_interactions[[10]]$name
interactors <- human_interactions[[10]]$interactors
```

### 4. Searching for a Specific Gene
Since the data is a standard R list, you can use `sapply` or `Lapply` to find interactions for a specific gene of interest.

```R
# Find interactors for "MAP2K4" in a list using Official names
target <- "MAP2K4"
idx <- which(sapply(human_interactions, function(x) x$name == target))
if(length(idx) > 0) {
    print(human_interactions[[idx]]$interactors)
}
```

## Identifier Types
- **EntrezId**: NCBI Entrez Gene identifiers (integers).
- **Official**: Official gene symbols (e.g., "TP53", "ACT1").
- **UniqueId**: Systematic names or locus tags (e.g., "At4g00020" for Arabidopsis, "YFL039C" for Yeast).

## Usage Tips
- **Data Version**: The package contains a snapshot of BioGRID (version 3.1.72). For the most recent data, check the BioGRID website, but use this package for stable, reproducible analysis.
- **Memory**: Some lists (like Human or Yeast) are large. Use `head()` or indexing (e.g., `my_list[1:5]`) to inspect data without flooding the console.
- **Network Analysis**: To convert these lists into an `igraph` object, you can iterate through the list to create an edge list (from-to pairs).

## Reference documentation
- [simpIntLists](./references/simpIntLists.md)