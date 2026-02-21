---
name: bioconductor-hugene10stprobeset.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hugene10stprobeset.db.html
---

# bioconductor-hugene10stprobeset.db

name: bioconductor-hugene10stprobeset.db
description: A specialized skill for using the Bioconductor R package 'hugene10stprobeset.db'. Use this skill when you need to map Affymetrix Human Gene 1.0 ST probeset identifiers to various biological annotations such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations.

## Overview

The `hugene10stprobeset.db` package is an annotation data package for the Affymetrix Human Gene 1.0 ST array (probeset level). It provides a comprehensive set of SQLite-based mappings between manufacturer probe identifiers and various public identifiers. While it supports the older "Bimap" interface, the modern and preferred way to interact with this data is through the `select()` interface provided by the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```R
library(hugene10stprobeset.db)
```

### Exploring Available Annotations
To see what types of data (columns) can be retrieved:
```R
columns(hugene10stprobeset.db)
```

To see the types of identifiers you can use as input (keys):
```R
keytypes(hugene10stprobeset.db)
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. It requires the database object, the keys (input IDs), the columns (desired data), and the keytype (type of input IDs).

```R
# Example: Map probeset IDs to Gene Symbols and Entrez IDs
probes <- c("7896736", "7896744", "7896752")
results <- select(hugene10stprobeset.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols and Aliases**: Use `SYMBOL` for official symbols and `ALIAS` for common synonyms.
*   **Gene Ontology (GO)**: Use `GO` to get GO identifiers, evidence codes, and ontologies (BP, CC, MF).
*   **Pathways**: Use `PATH` to retrieve KEGG pathway identifiers.
*   **Chromosomal Location**: Use `CHR` (chromosome), `CHRLOC` (start position), and `CHRLOCEND` (end position).
*   **External IDs**: Map to `ENSEMBL`, `UNIPROT`, `REFSEQ`, or `ACCNUM` (GenBank accession).

### Reverse Mappings
If you have a Gene Symbol and want to find the corresponding probesets:
```R
select(hugene10stprobeset.db, 
       keys = "TP53", 
       columns = "PROBEID", 
       keytype = "SYMBOL")
```

### Database Metadata
To inspect the database schema or connection information:
```R
hugene10stprobeset_dbschema()
hugene10stprobeset_dbInfo()
```

## Tips and Best Practices
*   **One-to-Many Mappings**: Be aware that a single probeset ID can sometimes map to multiple Entrez IDs or GO terms. The `select()` function will return a data.frame with all possible combinations.
*   **Bimap Interface**: While `as.list(hugene10stprobesetSYMBOL)` still works, it is considered legacy. Stick to `select()` for better integration with modern Bioconductor workflows.
*   **Filtering**: Use standard R data.frame operations to filter results, especially when dealing with large sets of GO terms or pathways.

## Reference documentation
- [reference_manual.md](./references/reference_manual.md)