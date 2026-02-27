---
name: bioconductor-rgu34b.db
description: This package provides annotation data for the Affymetrix Rat Genome U34B array. Use when user asks to map probe identifiers to gene symbols, Entrez IDs, GO terms, or KEGG pathways for rat genomic studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rgu34b.db.html
---


# bioconductor-rgu34b.db

name: bioconductor-rgu34b.db
description: Annotation data for the Affymetrix Rat Genome U34B array. Use when mapping manufacturer probe identifiers to biological metadata like Entrez IDs, Gene Symbols, GO terms, or KEGG pathways for rat genomic studies.

# bioconductor-rgu34b.db

## Overview

The rgu34b.db package is a Bioconductor annotation data package for the Affymetrix Rat Genome U34B array. It provides a comprehensive set of mappings between manufacturer probe identifiers and various gene-centric identifiers (Entrez, Symbol, Ensembl, RefSeq) and functional annotations (GO, KEGG, Enzyme Commission).

## Core Workflows

### 1. Using the select() Interface
The recommended way to interact with this package is through the AnnotationDbi select() interface.

To see available columns:
library(rgu34b.db)
columns(rgu34b.db)

To retrieve specific annotations for a set of probe IDs:
probes <- c("1367452_at", "1367453_at")
select(rgu34b.db, keys = probes, columns = c("SYMBOL", "ENTREZID", "GENENAME"), keytype = "PROBEID")

### 2. Mapping Gene Symbols to Probes
To find which probes correspond to specific gene symbols:
select(rgu34b.db, keys = c("Stat3", "Gapdh"), columns = "PROBEID", keytype = "SYMBOL")

### 3. Functional Annotation (GO and KEGG)
To map probes to Gene Ontology (GO) terms:
select(rgu34b.db, keys = "1367452_at", columns = c("GO", "ONTOLOGY", "EVIDENCE"), keytype = "PROBEID")

To map probes to KEGG pathways:
select(rgu34b.db, keys = "1367452_at", columns = "PATH", keytype = "PROBEID")

### 4. Accessing Chromosomal Information
To get chromosome locations and lengths:
# Get chromosome for probes
select(rgu34b.db, keys = probes, columns = "CHR", keytype = "PROBEID")

# Get chromosome lengths
rgu34bCHRLENGTHS

## Legacy Bimap Interface
While select() is preferred, you can still use the older Bimap interface for specific list-based operations.

# Convert a mapping to a list
symbol_list <- as.list(rgu34bSYMBOL)

# Get mapped keys only
mapped_probes <- mappedkeys(rgu34bSYMBOL)

## Database Connection Information
For advanced users needing direct SQL access:
# Get the SQLite database file path
rgu34b_dbfile()

# Get the database schema
rgu34b_dbschema()

## Tips and Best Practices
- Use `rgu34bALIAS2PROBE` if you are searching for genes using common aliases rather than official symbols.
- The `rgu34bGO2ALLPROBES` mapping is more inclusive than `rgu34bGO2PROBE` because it includes annotations to child terms in the GO hierarchy.
- Always check for NAs in the output, as not every probe identifier is mapped to every type of metadata.
- Use `keys(rgu34b.db, keytype="PROBEID")` to get a full list of probe identifiers supported by the package.

## Reference documentation
- [rgu34b.db Reference Manual](./references/reference_manual.md)