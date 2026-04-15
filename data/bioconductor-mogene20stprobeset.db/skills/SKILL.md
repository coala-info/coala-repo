---
name: bioconductor-mogene20stprobeset.db
description: This package provides biological annotations for the Affymetrix Mouse Gene 2.0 ST array probeset identifiers. Use when user asks to map probeset IDs to gene symbols, retrieve Entrez or Ensembl identifiers, or annotate differential expression results with GO terms and KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mogene20stprobeset.db.html
---

# bioconductor-mogene20stprobeset.db

name: bioconductor-mogene20stprobeset.db
description: Use this skill when working with the Bioconductor annotation package mogene20stprobeset.db. This is essential for mapping Affymetrix Mouse Gene 2.0 ST array probeset identifiers to various biological annotations such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and Ensembl identifiers. Use this skill to perform identifier conversions, retrieve gene metadata, and annotate differential expression results for this specific microarray platform.

# bioconductor-mogene20stprobeset.db

## Overview

The `mogene20stprobeset.db` package is a Bioconductor annotation data package for the Affymetrix Mouse Gene 2.0 ST array (probeset level). It provides a comprehensive set of mappings between manufacturer probeset IDs and various biological databases. The package uses an SQLite database backend and is primarily accessed via the `AnnotationDbi` interface.

## Core Workflows

### Loading the Package
```R
library(mogene20stprobeset.db)
```

### Using the select() Interface
The preferred method for retrieving data is the `select()` function. You can query the database using specific keys (probeset IDs) to get desired columns.

```R
# View available columns
columns(mogene20stprobeset.db)

# View available key types
keytypes(mogene20stprobeset.db)

# Example: Map probeset IDs to Gene Symbols and Entrez IDs
probes <- c("17210850", "17210852", "17210855")
select(mogene20stprobeset.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

- **Gene Symbols**: Use `SYMBOL` to get official gene abbreviations.
- **Entrez IDs**: Use `ENTREZID` for NCBI Gene identifiers.
- **Ensembl**: Use `ENSEMBL` for Ensembl gene accession numbers.
- **Gene Ontology**: Use `GO` for GO identifiers, evidence codes, and ontologies (BP, CC, MF).
- **Pathways**: Use `PATH` for KEGG pathway identifiers.
- **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLENGTHS`.

### Reverse Mappings (Alias to Probe)
To find which probesets correspond to a specific gene symbol or alias:

```R
# Using select
select(mogene20stprobeset.db, 
       keys = "Tp53", 
       columns = "PROBEID", 
       keytype = "SYMBOL")

# Using ALIAS2PROBE for common/historical symbols
select(mogene20stprobeset.db, 
       keys = "p53", 
       columns = "PROBEID", 
       keytype = "ALIAS")
```

### Database Connection and Metadata
For advanced users needing direct SQL access or package information:

```R
# Get the SQLite connection
conn <- mogene20stprobeset_dbconn()

# Get database metadata
mogene20stprobeset_dbInfo()

# Get the organism for which this package was built
mogene20stprobesetORGANISM
```

## Tips and Best Practices

- **Vectorized Queries**: Always pass a vector of IDs to `select()` rather than looping for better performance.
- **Handling 1-to-Many Mappings**: Be aware that one probeset ID may map to multiple GO terms or pathways. `select()` will return a long-format data frame with multiple rows for such probesets.
- **Bimap Interface**: While the "Bimap" interface (e.g., `as.list(mogene20stprobesetSYMBOL)`) is still available, the `select()` interface is the modern standard and is generally more flexible.
- **Defunct Maps**: Note that `PFAM` and `PROSITE` mappings are defunct in the Bimap interface; use `select()` to access these identifiers.

## Reference documentation

- [mogene20stprobeset.db Reference Manual](./references/reference_manual.md)