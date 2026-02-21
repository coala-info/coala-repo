---
name: bioconductor-clariomsmousetranscriptcluster.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/clariomsmousetranscriptcluster.db.html
---

# bioconductor-clariomsmousetranscriptcluster.db

name: bioconductor-clariomsmousetranscriptcluster.db
description: Annotation data for the Clariom S Mouse Transcript Cluster platform. Use this skill to map manufacturer probe identifiers to various biological annotations (Entrez Gene IDs, Symbols, GO terms, KEGG pathways, etc.) for mouse transcriptomic data analysis.

# bioconductor-clariomsmousetranscriptcluster.db

## Overview

The `clariomsmousetranscriptcluster.db` package is a Bioconductor annotation data package for the Clariom S Mouse Transcript Cluster array. It provides a SQLite-based interface to map manufacturer-specific probe identifiers to genomic, functional, and bibliographic data.

## Core Workflows

### Loading the Package
```R
library(clariomsmousetranscriptcluster.db)
```

### Using the select() Interface
The recommended way to interact with this package is via the `select()`, `keys()`, and `columns()` functions from the `AnnotationDbi` framework.

```R
# List available annotation types
columns(clariomsmousetranscriptcluster.db)

# List all probe IDs (keys)
probes <- keys(clariomsmousetranscriptcluster.db)

# Map specific probes to Gene Symbols and Entrez IDs
mapping <- select(clariomsmousetranscriptcluster.db, 
                  keys = probes[1:10], 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols and Names**: Map probes to official gene symbols (`SYMBOL`) or full names (`GENENAME`).
*   **External IDs**: Map to `ENTREZID`, `ENSEMBL`, `MGI` (Mouse Genome Informatics), or `REFSEQ`.
*   **Functional Annotation**: Map to `GO` (Gene Ontology) terms or `PATH` (KEGG pathways).
*   **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLENGTHS` to find genomic coordinates.

### Using the Bimap Interface (Legacy)
While `select()` is preferred, specific mappings can be accessed via "Bimaps" for list-based operations.

```R
# Map probes to Entrez IDs
x <- clariomsmousetranscriptclusterENTREZID
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes])

# Map Gene Symbols to Probes (Reverse Map)
y <- clariomsmousetranscriptclusterALIAS2PROBE
probes_for_alias <- as.list(y)
```

## Tips and Best Practices
*   **Keytypes**: The default keytype is `PROBEID`. If you are starting with a different ID (e.g., an Entrez ID) to find probes, specify `keytype = "ENTREZID"` in `select()`.
*   **One-to-Many Mappings**: Be aware that some probes may map to multiple genes or GO terms. `select()` will return a data frame with one row per mapping, which may result in more rows than input keys.
*   **Database Connection**: Use `clariomsmousetranscriptcluster_dbconn()` to access the underlying SQLite connection for custom SQL queries if needed.
*   **Organism Info**: Confirm the target organism using `clariomsmousetranscriptclusterORGANISM`.

## Reference documentation

- [clariomsmousetranscriptcluster.db](./references/reference_manual.md)