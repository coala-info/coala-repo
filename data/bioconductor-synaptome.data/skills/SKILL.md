---
name: bioconductor-synaptome.data
description: This tool provides access to the Synaptic Proteome Database for retrieving synaptic gene metadata, disease associations, and brain region localizations. Use when user asks to retrieve synaptic gene information, identify proteins by brain region or compartment, or build protein-protein interaction networks.
homepage: https://bioconductor.org/packages/release/data/annotation/html/synaptome.data.html
---


# bioconductor-synaptome.data

name: bioconductor-synaptome.data
description: Access and analyze the Synaptic Proteome Database (Synaptome.DB). Use this skill to retrieve information on synaptic genes, compartments (pre/post-synaptic, synaptic vesicle), brain regions, and disease associations (ASD, Epilepsy). It supports building protein-protein interaction (PPI) networks and mapping genes across human, mouse, and rat species.

# bioconductor-synaptome.data

## Overview
The `synaptome.data` package provides access to a comprehensive database of over 8,000 synaptic proteins integrated from 64 proteomic studies. It allows researchers to query synaptic gene metadata, identify proteins specific to brain regions or compartments, and generate protein-protein interaction (PPI) graphs. It is designed to work in tandem with the `synaptome.db` package.

## Installation
```R
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("synaptome.data")
library(synaptome.data)
library(synaptome.db) # Required for most query functions
```

## Core Workflows

### 1. Gene Information Retrieval
Query genes using Entrez IDs or Gene Names to get synaptic metadata.
```R
# By Entrez ID
gene_info <- getGeneInfoByEntrez(1742)

# By Gene Name
gene_info <- getGeneInfoByName(c("CASK", "DLG2"))

# Find internal database GeneIDs (species-neutral)
internal_ids <- findGenesByName(c("SRC", "FYN"))
```

### 2. Disease and Study Metadata
Retrieve associations with Human Disease Ontology (HDO) and details of the source publications.
```R
# Get disease info
diseases <- getGeneDiseaseByName(c("CASK", "DLG4"))

# List all proteomic studies in the database
studies <- getPapers()

# Find proteins identified in at least 2 studies
frequent_proteins <- findGeneByPaperCnt(cnt = 2)
```

### 3. Compartment and Brain Region Analysis
Filter the synaptome by localization (Presynaptic, Postsynaptic, Synaptosome, Synaptic Vesicle) or brain region.
```R
# List available compartments
comps <- getCompartments()

# Get all genes for the Postsynaptic compartment (ID 1)
post_genes <- getAllGenes4Compartment(compartmentID = 1)

# Get genes for a specific brain region and species (e.g., Mouse Striatum)
striatum_genes <- getAllGenes4BrainRegion(brainRegion = "Striatum", taxID = 10090)
```

### 4. Protein-Protein Interaction (PPI) Networks
Build networks based on gene lists. Use `type = "limited"` for interactions only between your genes, or `type = "induced"` to include all known interactors.
```R
# Get PPI pairs
ppi_pairs <- getPPIbyName(c("CASK", "DLG4", "GRIN2A"), type = "limited")

# Convert PPI data to an igraph object for visualization
library(igraph)
g <- getIGraphFromPPI(ppi_pairs)
plot(g, vertex.label = V(g)$HumanName)

# Export PPI as a table for Cytoscape
ppi_table <- getTableFromPPI(ppi_pairs)
```

## Tips and Best Practices
- **Internal GeneIDs**: Use `findGenesByEntrez` or `findGenesByName` to get internal IDs. These are species-neutral and prevent errors caused by redundant gene naming across human, mouse, and rat.
- **Filtering Contaminants**: Use `findGeneByCompartmentPaperCnt(cnt = 2)` to focus on proteins found in multiple studies, which increases confidence that the protein is a resident of that compartment rather than a contaminant.
- **Species Specificity**: Brain region data varies by species. Always specify the `taxID` (e.g., 10090 for mouse, 9606 for human, 10116 for rat) when querying regions.

## Reference documentation
- [synaptome.data database for synaptome.db](./references/data_vignette.md)
- [SynaptomeDB: Manual for querying SynaptomeDB](./references/synaptome_db_query.Rmd)