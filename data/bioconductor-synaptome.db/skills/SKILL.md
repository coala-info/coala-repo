---
name: bioconductor-synaptome.db
description: This tool queries and analyzes a comprehensive database of the synaptic proteome to extract information on genes, compartments, brain regions, and disease associations. Use when user asks to retrieve synaptic gene metadata, identify proteins by subcellular localization or brain region, construct protein-protein interaction networks, or find disease-linked synaptic proteins.
homepage: https://bioconductor.org/packages/release/data/annotation/html/synaptome.db.html
---


# bioconductor-synaptome.db

name: bioconductor-synaptome.db
description: Query and analyze the Synaptic proteome database. Use this skill to extract information about synaptic genes, compartments (pre/postsynaptic), brain regions, and disease associations. It supports building protein-protein interaction (PPI) graphs and identifying frequently reported synaptic proteins across multiple studies.

# bioconductor-synaptome.db

## Overview

The `synaptome.db` package provides access to a comprehensive database of the synaptic proteome, integrating over 50 published datasets. It allows researchers to query specific genes, identify their localization within synaptic compartments (Presynaptic, Postsynaptic, Synaptosome, Synaptic Vesicle), and explore their distribution across various brain regions. The package also facilitates the construction of protein-protein interaction (PPI) networks and links synaptic proteins to human diseases via the Human Disease Ontology (HDO).

## Core Workflows

### 1. Gene Information and Identification
Retrieve metadata for specific genes using Entrez IDs or Gene Names. Internal `GeneID`s are species-neutral and recommended for complex queries.

```r
library(synaptome.db)

# Get info by Entrez ID or Name
info <- getGeneInfoByEntrez(1742)
info_name <- getGeneInfoByName(c("CASK", "DLG2"))

# Find internal GeneIDs
ids <- findGenesByName(c("SRC", "FYN"))
```

### 2. Compartment and Brain Region Queries
Filter the synaptic proteome by subcellular localization or anatomical region.

```r
# List available compartments and regions
comps <- getCompartments()
regions <- getBrainRegions()

# Get all genes in a compartment (e.g., Postsynaptic = 1)
post_genes <- getAllGenes4Compartment(compartmentID = 1)

# Get genes in a specific brain region for a species (e.g., Striatum in Mouse)
striatum_genes <- getAllGenes4BrainRegion(brainRegion = "Striatum", taxID = 10090)
```

### 3. Protein-Protein Interactions (PPI)
Extract interactions between genes. Use `type = "limited"` for interactions only among the provided list, or `type = "induced"` to find all interactors within the database.

```r
# Get PPIs for a gene list
ppi_list <- getPPIbyName(c("CASK", "DLG4", "GRIN2A"), type = "limited")

# Convert PPI data to igraph for visualization
library(igraph)
g <- getIGraphFromPPI(ppi_list)
plot(g, vertex.label = V(g)$HumanName)

# Export PPI as a readable table
ppi_table <- getTableFromPPI(ppi_list)
```

### 4. Disease Annotation
Query synaptic genes for associations with neurological and other diseases.

```r
# Get disease info by gene name
disease_info <- getGeneDiseaseByName(c("CASK", "DLG2"))
```

### 5. Study-Based Filtering
Identify proteins based on how frequently they appear across different proteomic studies.

```r
# Find proteins identified in at least 2 different studies
frequent_genes <- findGeneByPaperCnt(cnt = 2)

# Find proteins in specific studies by PMID
study_genes <- findGeneByPapers(c("10818142", "10862698"), cnt = 1)
```

## Usage Tips
- **Species Neutrality**: Use `GeneID` for internal processing to avoid issues with ortholog mapping between Human, Mouse, and Rat.
- **TaxID**: When querying brain regions, always specify the `taxID` (e.g., 10090 for Mouse, 10116 for Rat, 9606 for Human) as region definitions vary by species.
- **Data Cleaning**: Use `findGeneByCompartmentPaperCnt` with `cnt >= 2` to filter for high-confidence resident proteins and reduce noise from potential contaminants in single studies.

## Reference documentation
- [SynaptomeDB: database for Synaptic proteome](./references/synaptome_db_query.md)
- [Manual for querying SynaptomeDB](./references/synaptome_db_query.Rmd)