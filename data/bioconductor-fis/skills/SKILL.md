---
name: bioconductor-fis
description: This package provides human functional interaction datasets derived from the Reactome and BioGRID databases for network biology analysis in R. Use when user asks to load human protein-protein interaction networks, access Reactome or BioGRID functional interactions, or prepare interaction data for the splineTimeR package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/FIs.html
---


# bioconductor-fis

name: bioconductor-fis
description: Access and utilize human functional interaction (FI) datasets from Reactome and BioGRID. Use this skill when a user needs to load, explore, or integrate human protein-protein or functional interaction networks for bioinformatics analysis, specifically for use with the splineTimeR package or general network analysis in R.

# bioconductor-fis

## Overview
The `FIs` package is a Bioconductor data experiment package providing two comprehensive sets of human functional interactions. These interactions are derived from the Reactome and BioGRID databases. The data is primarily intended to support the `splineTimeR` package for pathway analysis but can be used for any R-based network biology workflow requiring high-quality human interaction pairs.

## Loading the Data
To use the datasets, you must first load the package and then use the `data()` function to bring the `FIs` object into your environment.

```r
# Load the package
library(FIs)

# Load the interaction datasets
data(FIs)
```

## Data Structure
The `FIs` object is a list containing two data frames. Each data frame consists of two columns representing pairs of interacting genes/proteins.

- `FIs$FIs_Reactome`: Functional interactions derived from the Reactome database.
- `FIs$FIs_BioGRID`: Functional interactions derived from the BioGRID database.

The interactions are unique pairs, and self-loops (a protein interacting with itself) have been removed.

## Typical Workflows

### 1. Basic Exploration
You can inspect the dimensions and the first few rows of each dataset to understand the scale of the network.

```r
# Check the names of the list elements
names(FIs)

# View the first few interactions from Reactome
head(FIs$FIs_Reactome)

# View the first few interactions from BioGRID
head(FIs$FIs_BioGRID)

# Count the number of interactions in each set
nrow(FIs$FIs_Reactome)
nrow(FIs$FIs_BioGRID)
```

### 2. Converting to Network Objects
For graph-based analysis, you can convert these data frames into `igraph` objects.

```r
library(igraph)

# Create a graph from the Reactome interactions
reactome_graph <- graph_from_data_frame(FIs$FIs_Reactome, directed = FALSE)

# Summary of the graph
print(reactome_graph)
```

### 3. Filtering for Specific Genes
If you have a list of genes of interest (e.g., differentially expressed genes), you can subset the interaction list to find partners within your set.

```r
my_genes <- c("TP53", "BRCA1", "EGFR")

# Find interactions where at least one partner is in your list
subset_fis <- FIs$FIs_Reactome[FIs$FIs_Reactome[,1] %in% my_genes | 
                                 FIs$FIs_Reactome[,2] %in% my_genes, ]
```

## Usage Tips
- **Gene Symbols**: The data typically uses gene symbols. Ensure your input data matches this nomenclature or use packages like `org.Hs.eg.db` for conversion.
- **Database Choice**: Reactome FIs are often more focused on functional pathways and curated interactions, while BioGRID is a broader repository of physical and genetic interactions.
- **Integration with splineTimeR**: This package is a dependency for `splineTimeR`. If you are performing time-course expression analysis with that package, these datasets are used internally for network reconstruction.

## Reference documentation
- [Human Functional Interactions (FIs) for splineTimeR package](./references/reference_manual.md)