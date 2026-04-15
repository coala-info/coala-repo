---
name: bioconductor-reactomecontentservice4r
description: This tool queries and retrieves biological pathway data from the Reactome knowledgebase. Use when user asks to fetch Reactome instances, search for pathways or proteins by name, map external identifiers to Reactome events, retrieve reaction participants, or explore orthologous events across species.
homepage: https://bioconductor.org/packages/3.13/bioc/html/ReactomeContentService4R.html
---

# bioconductor-reactomecontentservice4r

name: bioconductor-reactomecontentservice4r
description: Query and retrieve biological pathway data from the Reactome knowledgebase. Use this skill when you need to: (1) Fetch Reactome instances by class or identifier, (2) Search for pathways, reactions, or proteins by name/term, (3) Map non-Reactome identifiers (UniProt, HGNC, etc.) to Reactome events, (4) Retrieve participants of a reaction or sub-events of a pathway, (5) Export pathway diagrams or event files (SBGN/SBML), or (6) Explore orthologous events across species.

# bioconductor-reactomecontentservice4r

## Overview
The `ReactomeContentService4R` package provides an R interface to the Reactome Content Service API. It allows for programmatic access to Reactome's curated knowledgebase of biomolecular pathways. Data is returned as R Data Frames, facilitating the integration of pathway information into bioinformatics pipelines. The data model is hierarchical: Pathways contain Reactions (ReactionLikeEvents), which contain PhysicalEntities (proteins, small molecules, complexes).

## Core Workflows

### 1. Fetching Instances
Retrieve instances of a specific Reactome class (e.g., Pathway, Reaction, Complex).

```r
library(ReactomeContentService4R)

# Fetch all human pathways
pathways <- getSchemaClass(class = "Pathway", species = "human", all = TRUE)

# Fetch a specific instance with all attributes by ID
# Supports both dbId and stable identifier (stId)
event_info <- query(id = "R-HSA-2033519")
```

### 2. Searching by Term
Search for instances associated with a specific keyword or disease name.

```r
# Search for a term in a specific species
search_results <- searchQuery(query = "bone development disease", species = "human")

# Access the results dataframe
results_df <- search_results$results[[1]][[1]]

# List available filters for searchQuery
listSearchItems()
```

### 3. Retrieving Participants and Sub-events
Explore the components of a Pathway or Reaction.

```r
# Get sub-events (reactions and sub-pathways) within a pathway
sub_events <- getParticipants("R-HSA-5655302", retrieval = "EventsInPathways")

# Get all physical entities (inputs, outputs, catalysts) in a reaction
participants <- getParticipants("R-HSA-1839098", retrieval = "AllInstances")
```

### 4. Mapping Identifiers
Map external identifiers (e.g., UniProt, HGNC, ChEBI) to Reactome entities and events.

```r
# Map Gene Symbol to Reactome ReferenceEntities
tp53_ref <- map2RefEntities("TP53")

# Map Gene Symbol to Reactome Pathways
tp53_pathways <- map2Events("TP53", resource = "HGNC", species = "human", mapTo = "pathways")

# Extract non-Reactome IDs from a Reactome Event
external_ids <- event2Ids("R-HSA-176942")
```

### 5. Cross-Species Orthology
Find human orthologs for events curated in other species or vice versa.

```r
# Fetch the human orthologous instance for a pig (SSC) event
human_ortholog <- getOrthology("R-SSC-69541", species = "human")
```

### 6. Exporting Diagrams and Files
Visualize pathways or export data in standard formats.

```r
# Export a pathway diagram as a PNG or JPG
exportImage(id = "R-HSA-1839098", output = "reaction", format = "jpg", quality = 10)

# Export an event in SBGN or SBML format
sbgn_content <- exportEventFile("R-HSA-432047", format = "sbgn", writeToFile = FALSE)
```

## Tips and Best Practices
- **Identifier Types**: Reactome uses Stable Identifiers (stId, e.g., "R-HSA-123456") and Database Identifiers (dbId, e.g., 123456). Most functions accept both.
- **Species Specification**: Use `getSpecies(main = TRUE)` to see the list of species with curated or inferred pathways.
- **Data Structure**: The `query()` function returns a deeply nested list. Use `str(obj, max.level = 1)` to inspect the top-level slots like `disease`, `hasEvent`, or `summation`.
- **Analysis Integration**: For overlaying expression data on diagrams, use the `token` argument in `exportImage()`, which is typically obtained from the Reactome Analysis Service (often via the `ReactomeGSA` package).

## Reference documentation
- [ReactomeContentService4R: an R Interface for the Reactome Content Service](./references/ReactomeContentService4R.Rmd)
- [ReactomeContentService4R: an R Interface for the Reactome Content Service](./references/ReactomeContentService4R.md)