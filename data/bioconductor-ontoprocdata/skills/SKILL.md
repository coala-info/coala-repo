---
name: bioconductor-ontoprocdata
description: This tool provides access to pre-processed biological and chemical ontology resources through Bioconductor's AnnotationHub. Use when user asks to retrieve standardized ontology data, load Cell Ontology or Uberon resources into R, or manage RDA objects for bioinformatic workflows.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ontoProcData.html
---

# bioconductor-ontoprocdata

name: bioconductor-ontoprocdata
description: Access and manage ontology resources for the ontoProc package via AnnotationHub. Use this skill when you need to retrieve standardized ontology data (RDA objects) such as Cell Ontology (CL), Uberon, ChEBI, or Mondo for use in Bioconductor-based bioinformatic workflows.

# bioconductor-ontoprocdata

## Overview

The `ontoProcData` package serves as a data repository for the `ontoProc` ecosystem. It provides a collection of biological and chemical ontologies pre-processed into R-friendly formats (RDA). These resources are distributed through Bioconductor's `AnnotationHub`, allowing for versioned and efficient retrieval of ontology structures for cell type mapping, disease annotation, and anatomical classification.

## Core Workflow: Retrieving Ontologies

The primary way to interact with `ontoProcData` is through the `AnnotationHub` interface.

### 1. Initialize AnnotationHub
First, load the library and create an AnnotationHub instance to browse available resources.

```r
library(AnnotationHub)
ahub <- AnnotationHub()
```

### 2. Query for ontoProcData Resources
Search the hub specifically for records associated with this package.

```r
# Search for all ontoProcData records
mymeta <- query(ahub, "ontoProcData")

# View the available ontologies (e.g., cellOnto, uberon, mondo)
mymeta
```

### 3. Load a Specific Ontology
Once you identify a resource by its title or AH ID (e.g., "AH97936" for cellOnto), you can load it directly into your R session.

```r
# Retrieve by ID
cellOnto <- ahub[["AH97936"]]

# The resulting object is typically an ontology structure 
# ready for use with ontoProc functions.
```

## Available Ontology Examples
Common resources available through this package include:
- **cellOnto**: The Cell Ontology (CL)
- **uberon**: The multi-species anatomy ontology
- **mondo**: Unified disease ontology
- **chebi_full**: Chemical Entities of Biological Interest
- **cellosaurusOnto**: Cell line relationships

## Advanced: Creating Custom RDA Objects
If you need to process a new ontology version into the format used by this package, use the `get_OBO` function (typically from the `ontologyIndex` or `ontoProc` dependencies) to convert `.obo` files.

```r
# Example conversion logic
# library(ontoProc)
# my_obj <- get_OBO("path/to/file.obo", extract_tags = "everything")
# save(my_obj, file = "my_obj.rda", compress = "xz")
```

## Tips for Success
- **Snapshot Dates**: Use `snapshotDate(ahub)` to check the currency of the data.
- **Caching**: `AnnotationHub` caches files locally after the first download, making subsequent loads nearly instantaneous.
- **Integration**: These data objects are designed to be passed into `ontoProc` functions like `ct_mapping` or `onto_plot`.

## Reference documentation
- [Creating RDA objects](./references/creatingRDAObjects.md)
- [ontoProcData Overview](./references/ontoProcData.md)