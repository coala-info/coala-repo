---
name: bioconductor-uniprot.ws
description: The UniProt.ws package provides a Bioconductor-standard interface to query and retrieve protein sequences, cross-references, and functional metadata from the UniProt REST API. Use when user asks to query UniProt data, retrieve protein sequences, map biological identifiers, or search for species taxonomy IDs.
homepage: https://bioconductor.org/packages/release/bioc/html/UniProt.ws.html
---

# bioconductor-uniprot.ws

## Overview

The `UniProt.ws` package provides a Bioconductor-standard `select` interface to the modernized UniProt REST API. It allows users to query UniProt data by specifying a taxonomy ID and using familiar methods like `columns()`, `keytypes()`, and `select()` to retrieve protein sequences, cross-references, and functional metadata.

## Core Workflow

### 1. Initialization and Species Selection
To use the service, you must create a `UniProt.ws` object for a specific species using its Taxonomy ID.

```r
library(UniProt.ws)

# Default is usually Homo sapiens (9606)
up <- UniProt.ws(taxId = 9606)

# Search for a taxonomy ID by species name
availableUniprotSpecies(pattern = "musculus")

# Set to a different species (e.g., Mouse)
mouseUp <- UniProt.ws(10090)
```

### 2. Exploring Available Data
Use the standard AnnotationDbi-style discovery functions to see what data can be queried.

*   `keytypes(up)`: Lists the types of identifiers you can use as input (e.g., "GeneID", "UniProtKB", "HGNC").
*   `columns(up)`: Lists the data fields you can retrieve (e.g., "sequence", "xref_pdb", "cc_allergen").
*   `keys(up, keytype = "GeneID")`: Retrieves all available keys for a specific type (Note: this can be slow as it queries the web service).

### 3. Retrieving Data with select()
The `select()` function is the primary tool for data retrieval. It requires the `UniProt.ws` object, the input keys, the desired columns, and the input keytype.

```r
# Example: Map Entrez Gene IDs to PDB cross-references and Sequences
keys <- c("1", "2")
cols <- c("xref_pdb", "xref_hgnc", "sequence")
kt <- "GeneID"

res <- select(up, keys, cols, kt)
```

## Key Tips
*   **Identifier Changes**: Note that 'ENTREZ_GENE' has been renamed to 'GeneID' in newer versions of the package.
*   **Performance**: Since `UniProt.ws` communicates with a remote REST API, large queries or calls to `keys()` may be slow. It is recommended to save results locally if they will be reused frequently.
*   **Taxonomy IDs**: Always verify the Taxonomy ID using `availableUniprotSpecies()` if you are unsure of the exact numeric code for your organism.

## Reference documentation
- [UniProt.ws: A package for retrieving data from the UniProt web service](./references/UniProt.ws.md)