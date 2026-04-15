---
name: bioconductor-envisionquery
description: This tool retrieves biological data and performs ID mapping through the Enfin-Encore annotation portal. Use when user asks to map protein identifiers to microarray probe-sets, find protein-protein interactions, map protein IDs across databases, or find biological pathways.
homepage: https://bioconductor.org/packages/3.8/bioc/html/ENVISIONQuery.html
---

# bioconductor-envisionquery

name: bioconductor-envisionquery
description: Retrieve biological data and perform ID mapping through the Enfin-Encore annotation portal. Use this skill when you need to map protein identifiers (UNIPROT) to microarray probe-sets (Affymetrix), find protein-protein interactions (IntAct), map protein IDs across various databases (PICR), or find biological pathways (Reactome) using R.

## Overview

The `ENVISIONQuery` package provides programmatic access to the Enfin-Encore integration platform. It is particularly useful for systems biology workflows that require integrating transcriptomic and proteomic data. The package communicates with Java-based web services to query multiple databases and returns results as R data frames or EnXML.

**Key Requirements:**
- Java 1.6 or higher must be installed.
- The `rJava` and `XML` packages are required dependencies.

## Core Functions

### Discovery Functions
Use these to explore available services and valid parameters:
- `getServiceNames()`: Lists available services (e.g., "ID Conversion", "Reactome", "Intact", "Picr").
- `getService(serviceName)`: Retrieves a specific service object.
- `getToolNames(service)`: Lists tools available for a specific service.
- `getInputTypes(tool)`: Lists valid input formats for a tool.
- `getServiceOptions(serviceName)`: Lists configurable options for the service.

### The Main Query Function
The primary interface is the `ENVISIONQuery` function:
```R
res <- ENVISIONQuery(ids, serviceName, toolName, typeName, options, filter, verbose)
```

## Common Workflows

### ID Mapping (Affymetrix to Uniprot)
```R
# Convert Affy probeset IDs to Uniprot IDs
res <- ENVISIONQuery(
  ids = c("1553619_a_at", "1552276_a_at"),
  serviceName = "ID Conversion",
  toolName = "Affy2Uniprot",
  typeName = "Affymetrix ID"
)
```

### Pathway Retrieval (Reactome)
```R
# Find pathways for a specific Uniprot ID
res <- ENVISIONQuery(
  ids = "P38398",
  serviceName = "Reactome",
  typeName = "Uniprot ID"
)
```

### Protein-Protein Interactions (IntAct)
```R
# Find interaction partners
res <- ENVISIONQuery(
  ids = "P38398",
  serviceName = "Intact",
  typeName = "Uniprot ID"
)
```

### Using Filters and Options
Refine queries by specifying species or additional data columns:
```R
# Filter by organism and platform
my_filter <- list(
  Microarray.Platform = "affy_hg_u133_plus_2",
  organism.species = "Homo sapiens"
)

# Set service-specific options
my_options <- list("enfin-reactome-add-coverage" = "true")

res <- ENVISIONQuery(
  ids = "P38398",
  serviceName = "Reactome",
  typeName = "Uniprot ID",
  filter = my_filter,
  options = my_options
)
```

## Advanced Usage

### Cascading Queries
You can pipe the output of one service into another by providing a vector of service names. This returns raw EnXML:
```R
# Combined Intact and Reactome request
xml_res <- ENVISIONQuery(
  ids = "P38398",
  serviceName = c("Intact", "Reactome"),
  typeName = "Uniprot ID"
)
```

### Handling Large Queries
The package automatically chunks large ID lists (default chunk size is 1000). If you encounter stability issues or timeouts, you can manually adjust the chunking behavior using internal functions `ENVISIONQuery.chunks`, though standard calls to `ENVISIONQuery` handle this for most users.

### Interactive Selection
If you are unsure of the exact tool or type names, use `"menu"` to trigger an interactive selection:
```R
res <- ENVISIONQuery(ids = my_ids, serviceName = "menu", toolName = "menu")
```

## Reference documentation
- [ENVISIONQuery](./references/ENVISIONQuery.md)