---
name: bioconductor-biodbkegg
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.14/bioc/html/biodbKegg.html
---

# bioconductor-biodbkegg

name: bioconductor-biodbkegg
description: Access and analyze KEGG Compound and Pathway data using the biodbKegg R package. Use this skill to retrieve chemical entries, search by mass, map compounds to pathways/enzymes, and generate pathway graphs or decorated images for specific organisms.

# bioconductor-biodbkegg

## Overview
The `biodbKegg` package is a Bioconductor extension for the `biodb` framework, providing a specialized connector to the Kyoto Encyclopedia of Genes and Genomes (KEGG). It allows users to programmatically retrieve KEGG Compound entries, search for metabolites by mass, and explore biological context by linking compounds to enzymes, modules, and pathways.

## Initialization and Connection
To use the package, you must first initialize a `biodb` instance and create a connector to the KEGG database.

```r
# Load libraries
library(biodb)
library(biodbKegg)

# Initialize biodb instance
mybiodb <- biodb::newInst()

# Create a connector to KEGG Compound
kegg.comp.conn <- mybiodb$getFactory()$createConn('kegg.compound')

# Create a connector to KEGG Pathway (for graph operations)
kegg.path.conn <- mybiodb$getFactory()$getConn('kegg.pathway')
```

## Accessing and Searching Entries
Retrieve specific compound data using KEGG IDs or search by physical properties.

```r
# Retrieve specific entries
entries <- kegg.comp.conn$getEntry(c('C00133', 'C00751'))

# Convert entries to a data frame for analysis
df_entries <- mybiodb$entriesToDataframe(entries)

# Search for compounds by monoisotopic mass (with a delta/tolerance)
ids <- kegg.comp.conn$searchForEntries(list(monoisotopic.mass=list(value=64, delta=2.0)), max.results=10)
```

## Annotating Data Frames
If you have a list of KEGG IDs in an existing data frame, you can enrich it with biological metadata (enzymes, pathways, modules) for a specific organism (e.g., 'mmu' for mouse, 'hsa' for human).

```r
mydf <- data.frame(kegg.ids=c('C06144', 'C06178', 'C02659'))

# Add info (pathways, enzymes, modules)
# Note: org parameter uses KEGG organism codes
kegg.comp.conn$addInfo(mydf, id.col='kegg.ids', org='mmu')
```

## Pathway Analysis and Visualization
Map compounds to pathways and generate visualizations.

```r
# Get pathway IDs related to a list of compounds
kegg.comp.ids <- c('C06144', 'C06178', 'C02659')
pathways <- kegg.comp.conn$getPathwayIds(kegg.comp.ids, 'mmu')

# Build an igraph object for a pathway
ig <- kegg.path.conn$getPathwayIgraph(pathways[1])
plot(ig)

# Create a decorated pathway image (highlights specific IDs)
# color2ids is a list where names are colors and values are vectors of IDs
kegg.enz.ids <- mybiodb$entryIdsToSingleFieldValues(kegg.comp.ids, db='kegg.compound', field='kegg.enzyme.id')
color2ids <- list(yellow=kegg.enz.ids, red=kegg.comp.ids)

kegg.path.conn$getDecoratedGraphPicture(pathways[1], color2ids=color2ids)
```

## Resource Management
Always terminate the `biodb` instance to release system resources and close connections.

```r
mybiodb$terminate()
```

## Tips and Best Practices
- **Organism Codes**: Ensure you use the correct 3 or 4-letter KEGG organism code (e.g., 'hsa', 'mmu', 'dme').
- **Field Limits**: By default, `addInfo()` limits the number of values per field to 3. Check the `KeggCompoundConn` help page to adjust parameters.
- **Caching**: `biodb` uses a local cache to speed up repeated queries; ensure your environment has write permissions for the cache directory.

## Reference documentation
- [An introduction to biodbKegg](./references/biodbKegg.md)
- [An introduction to biodbKegg (Rmd)](./references/biodbKegg.Rmd)