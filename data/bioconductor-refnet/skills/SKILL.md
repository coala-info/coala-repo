---
name: bioconductor-refnet
description: Bioconductor-refnet queries and curates molecular interaction data from PSICQUIC and native datasets to build annotated biological networks. Use when user asks to retrieve protein-protein or transcription factor interactions, filter molecular data by species or provider, and remove duplicate interaction records based on evidence quality.
homepage: https://bioconductor.org/packages/3.5/bioc/html/RefNet.html
---

# bioconductor-refnet

name: bioconductor-refnet
description: Query and curate molecular interaction data from multiple sources including PSICQUIC and native datasets. Use this skill when you need to retrieve annotated interactions (protein-protein, transcription factor-target, metabolic) for specific genes, proteins, or species, and perform data curation like duplicate removal and evidence filtering.

## Overview

RefNet is a query-based tool for retrieving molecular interactions from a variety of providers. It aggregates data from PSICQUIC (e.g., BioGrid, IntAct, MINT) and native "curated" sources (e.g., Gerstein-2012, Recon2). Unlike simple download tools, RefNet provides rich annotations including detection methods, interaction types, and publication IDs to facilitate the construction of context-specific biological networks.

## Core Workflow

### 1. Initialization and Provider Discovery
Initialize the RefNet object to load available data sources.

```r
library(RefNet)
refnet <- RefNet()

# List available providers (native and PSICQUIC)
provs <- providers(refnet)
print(provs$native)
print(provs$PSICQUIC)
```

### 2. Querying Interactions
Use the `interactions()` function to retrieve data. It is highly recommended to filter by species (NCBI taxonomy ID) and specific providers to manage data volume.

```r
# Query E2F3 interactions in humans (9606) from specific sources
tbl <- interactions(refnet, 
                    id="E2F3", 
                    species="9606", 
                    provider=c("gerstein-2012", "BioGrid"))
```

**Key Arguments:**
- `id`: One or more identifiers (Gene symbols, Entrez IDs, etc.).
- `species`: NCBI taxonomy code (e.g., "9606" for human).
- `speciesExclusive`: Logical; if TRUE, both interactors must be from the specified species.
- `type`: Limit by interaction type (e.g., "direct interaction").
- `provider`: Limit by specific data sources.

### 3. Mapping Standard Names
PSICQUIC results often use varied naming schemes (UniProt, RefSeq). Use the `PSICQUIC` package's `IDMapper` to add common gene symbols and canonical IDs.

```r
library(PSICQUIC)
idMapper <- IDMapper("9606")
tbl.named <- addStandardNames(idMapper, tbl)
# Adds columns: A.common, B.common, A.canonical, B.canonical
```

### 4. Curation and Duplicate Removal
Queries often return redundant reports of the same interaction. RefNet provides tools to identify and select the "best" evidence based on preferred interaction types.

```r
# 1. Detect duplicates (adds a 'dupGroup' column)
tbl.dups <- detectDuplicateInteractions(tbl.named)

# 2. Define preferred interaction types (highest to lowest priority)
preferred.types <- c("direct interaction", 
                     "physical association", 
                     "transcription factor binding")

# 3. Pick the best record from each duplicate group
dupGroups <- sort(unique(tbl.dups$dupGroup))
bestIndices <- unlist(lapply(dupGroups, function(g) {
    pickBestFromDupGroup(g, tbl.dups, preferred.types)
}))

# 4. Filter the table
tbl.final <- tbl.dups[bestIndices, ]
```

## Tips for Effective Use
- **Iterative Refinement**: Start with a broad query and use `table(tbl$detectionMethod)` or `table(tbl$type)` to understand the evidence quality before filtering.
- **Native Sources**: Native providers like `recon202` (metabolic) or `gerstein-2012` (TF-target) often contain specialized data not found in standard PPI databases.
- **Identifier Handling**: If `addStandardNames` fails to map an ID, it may be a non-standard identifier that requires manual inspection or `org.Hs.eg.db` lookup.
- **Abstract Verification**: Use `pubmedAbstract("PMID")` to programmatically fetch publication abstracts to verify the context of a specific interaction.

## Reference documentation
- [RefNet](./references/RefNet.md)