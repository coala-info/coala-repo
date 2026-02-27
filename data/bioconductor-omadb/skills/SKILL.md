---
name: bioconductor-omadb
description: The OmaDB package provides an R interface to the Orthologous MAtrix database for retrieving evolutionary relationships and orthology data among genomes. Use when user asks to search for proteins, identify orthologs between genomes, explore hierarchical orthologous groups, or map sequences to OMA entries.
homepage: https://bioconductor.org/packages/release/bioc/html/OmaDB.html
---


# bioconductor-omadb

## Overview
The `OmaDB` package is an R wrapper for the OMA (Orthologous MAtrix) project REST API. It allows for the retrieval of evolutionary relationships among complete genomes. Key features include searching for proteins, identifying orthologs between genomes, exploring Hierarchical Orthologous Groups (HOGs), and mapping sequences to OMA entries.

## Core Functions

### Protein and Genome Search
* `searchProtein(pattern)`: Search for protein entries containing a specific pattern (e.g., 'MAL'). Returns a dataframe of cross-references.
* `getProtein(id)`: Retrieve detailed information for one or more protein entries.
* `getGenome(id)`: Retrieve information about a specific genome.
* `getGenomePairs(genome1, genome2)`: Obtain orthologs between two whole genomes (e.g., 'YEAST' and 'ASHGO').

### Orthologous Groups
* `getOMAGroup(id)`: Retrieve members and metadata for a specific OMA group.
* `getHOG(id)`: Retrieve Hierarchical Orthologous Groups by HOG ID or member. HOGs represent genes descended from a single common ancestral gene at a specific taxonomic range.

### Sequence Analysis
* `mapSequence(sequence)`: Perform exact or partial sequence matching against the OMA database.
* `getAttribute(object, 'targets')`: Extract target proteins from a sequence map result.

### Taxonomy and Trees
* `getTaxonomy(root = 'TaxonName')`: Retrieve a taxonomic tree in Newick format for a specific root.
* `getTree(object)`: Helper to facilitate tree visualization (often used with `ape` or `ggtree`).

## Typical Workflow

### 1. Exploring Object Attributes
Single entries are returned as S3 objects. Use `getObjectAttributes()` to see available fields:
```r
library(OmaDB)
group <- getOMAGroup('737636')
getObjectAttributes(group)
```

### 2. Accessing Data (Lazy Loading)
Attributes can be accessed using the `$` operator or `getAttribute()`. Note that `OmaDB` uses lazy loading; additional data is fetched from the API only when the attribute is accessed.
```r
# Accessing a specific attribute
group$fingerprint
# OR
getAttribute(group, 'members')
```

### 3. Navigating HOG Hierarchies
HOGs contain parent and children relationships representing gene duplications:
```r
hog <- getHOG("HOG:0273533.1b")
parent_hogs <- getAttribute(hog, 'parent_hogs')
children_hogs <- getAttribute(hog, 'children_hogs')
```

## Tips
* **Documentation**: Use `?functionName` in R to access specific help pages for any function.
* **Identifiers**: OMA IDs, UniProt IDs, or RefSeq IDs are generally supported for protein queries.
* **Visualization**: For taxonomic trees, the Newick string returned by `getTaxonomy` can be parsed by the `ape` package for plotting.

## Reference documentation
- [Get started with OmaDB](./references/OmaDB.md)
- [Exploring Hierarchical orthologous groups](./references/exploring_hogs.md)
- [Sequence Analysis with OmaDB](./references/sequence_mapping.md)
- [Exploring Taxonomic trees with OmaDB](./references/tree_visualisation.md)