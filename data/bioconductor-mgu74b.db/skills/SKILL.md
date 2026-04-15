---
name: bioconductor-mgu74b.db
description: This package provides annotation data for the Affymetrix Murine Genome U74v2 Chip B platform. Use when user asks to map manufacturer probe identifiers to biological metadata, retrieve Gene Symbols or Entrez IDs for mouse genomic data, or access Gene Ontology and KEGG pathway information for this specific chip.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74b.db.html
---

# bioconductor-mgu74b.db

name: bioconductor-mgu74b.db
description: Provides annotation data for the Affymetrix Murine Genome U74v2 Chip B (mgu74b) platform. Use this skill when you need to map manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, or chromosomal locations for mouse genomic data.

## Overview

The mgu74b.db package is a Bioconductor annotation data package for the Affymetrix Murine Genome U74v2 Chip B. It provides a stable SQLite-based interface to map probe set IDs to various biological identifiers. The primary way to interact with this data is through the standard AnnotationDbi interface (select, columns, keys, and mapIds).

## Core Workflows

### Loading the Package

library(mgu74b.db)

### Exploring Available Data

To see which types of data can be retrieved from the database:
columns(mgu74b.db)

To see the primary keys (manufacturer probe IDs):
keys(mgu74b.db)

### Using the select() Interface

The select() function is the recommended way to retrieve data. It requires the database object, the keys you are searching for, the columns you want to retrieve, and the type of key you are providing.

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("92201_at", "92202_at", "92203_at")
select(mgu74b.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")

### Using mapIds() for Simple Mappings

If you only need a 1-to-1 mapping (e.g., probe to symbol), mapIds is more convenient as it returns a named vector.

# Example: Get symbols for a list of probes
symbols <- mapIds(mgu74b.db, 
                  keys = probes, 
                  column = "SYMBOL", 
                  keytype = "PROBEID", 
                  multiVals = "first")

### Accessing Specific Mappings (Bimap Interface)

While select() is preferred, you can still use the older Bimap interface for specific tasks.

# Get all mapped probe IDs for Gene Symbols
x <- mgu74bSYMBOL
mapped_probes <- mappedkeys(x)
# Convert to a list to see probe-to-symbol mappings
as.list(x[mapped_probes][1:5])

## Common Mapping Types

- SYMBOL: Official Gene Symbol
- ENTREZID: Entrez Gene Identifier
- ENSEMBL: Ensembl Gene Accession
- GENENAME: Full Gene Name
- GO: Gene Ontology identifiers and evidence codes
- PATH: KEGG Pathway identifiers
- MGI: Mouse Genome Informatics accession numbers
- CHR: Chromosome location

## Database Metadata

To get information about the data sources and versioning:
mgu74b_dbInfo()

To get the organism for which this package was built:
mgu74bORGANISM

## Tips for Efficient Usage

1. multiVals Argument: When using mapIds, decide how to handle probes that map to multiple genes using the multiVals argument ("first", "list", "CharacterList", "filter", or "asNA").
2. Filtering: Use the keys() function to check if your identifiers exist in the database before attempting a large select() operation to avoid empty results.
3. Reverse Mappings: Most Bimap objects have a reverse map available (e.g., mgu74bSYMBOL2PROBE) if you need to find probes associated with a specific gene symbol.

## Reference documentation

- [mgu74b.db Reference Manual](./references/reference_manual.md)