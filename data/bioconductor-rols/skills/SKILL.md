---
name: bioconductor-rols
description: This tool provides an R interface to the EMBL-EBI Ontology Lookup Service for querying and navigating biological ontologies. Use when user asks to search for ontology terms, retrieve term metadata, explore hierarchy relationships like parents or children, or create controlled vocabulary parameters.
homepage: https://bioconductor.org/packages/release/bioc/html/rols.html
---


# bioconductor-rols

name: bioconductor-rols
description: Interface to the EMBL-EBI Ontology Lookup Service (OLS). Use when the user needs to query, search, or navigate biological ontologies (like GO, Uberon, ChEBI) directly from R. Supports searching for terms, retrieving term metadata, exploring ontology hierarchies (parents/children/ancestors), and creating controlled vocabulary parameters (CVParam).

# bioconductor-rols

## Overview
The `rols` package provides a seamless R interface to the Ontology Lookup Service (OLS) hosted at EMBL-EBI. It allows users to programmatically query hundreds of ontologies using a unified REST API. The package is built around S4 classes representing ontologies, terms, and search results.

## Installation
Install the package using `BiocManager`:
```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rols")
```

## Working with Ontologies
Use `olsOntologies()` to list all available ontologies or `olsOntology()` to focus on a specific one.

```r
library(rols)

# List all ontologies
all_onts <- olsOntologies()
head(olsNamespace(all_onts))

# Get a specific ontology (e.g., Biological Spatial Ontology)
bspo <- olsOntology("bspo")
bspo
```

## Working with Terms
Terms are the core units of ontologies. You can retrieve all terms for an ontology or look up specific terms by their ID.

```r
# Get all terms for an ontology (can be slow for large ontologies)
trms <- olsTerms("bspo")

# Get a specific term
trm <- olsTerm("uberon", "UBERON:0002107") # Liver
termLabel(trm)
termId(trm)

# Coerce to data.frame for easier viewing
df_trm <- as(trm, "data.frame")
```

## Navigating Hierarchy
Once a term is instantiated, use these functions to explore its relationships:
- `parents(trm)`: Direct parents.
- `children(trm)`: Direct children.
- `ancestors(trm)`: All nodes above in the hierarchy.
- `descendants(trm)`: All nodes below in the hierarchy.

All these functions return an `olsTerms` object.

## Searching the OLS
Searching is a two-step process: define the query with `OlsSearch()` and execute it with `olsSearch()`.

```r
# 1. Define the search
# Parameters: q (query), ontology (optional), exact (logical), rows (number of results)
query_def <- OlsSearch(q = "trans-golgi network", ontology = "GO", exact = TRUE)

# 2. Execute the search
res <- olsSearch(query_def)

# 3. Convert results to terms or data.frame
res_trms <- as(res, "olsTerms")
res_df <- as(res, "data.frame")
```

## Controlled Vocabulary (CVParam)
The `CVParam` class is used to handle controlled vocabulary parameters, often used in proteomics or other high-throughput data standards.

```r
# User-defined parameter
p1 <- CVParam(name = "Analysis version", value = "1.2.3")

# Official CV term (triggers OLS query to validate)
p2 <- CVParam(label = "GO", accession = "GO:0035145")
```

## Tips and Best Practices
- **Exact Matching**: When searching for specific biological entities, set `exact = TRUE` in `OlsSearch` to reduce noise.
- **Row Limits**: The default number of search results is 20. Increase this using the `rows` argument in `OlsSearch()` if needed.
- **Namespace Clashes**: `rols` uses class names like `olsOntology` and `olsTerm` to avoid conflicts with `AnnotationDbi`. Always use the `ols` prefixed versions of constructors.
- **Online Dependency**: `rols` requires an active internet connection as it queries the EBI REST API in real-time.

## Reference documentation
- [An R interface to the Ontology Lookup Service](./references/rols.Rmd)
- [An R interface to the Ontology Lookup Service (Markdown)](./references/rols.md)