---
name: bioconductor-huo22.db
description: This package provides comprehensive annotation data for mapping HuO22 platform probe identifiers to biological metadata. Use when user asks to map manufacturer probes to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/HuO22.db.html
---

# bioconductor-huo22.db

name: bioconductor-huo22.db
description: Comprehensive annotation data for the HuO22 platform. Use when mapping manufacturer probe identifiers to biological metadata such as gene symbols, Entrez IDs, GO terms, KEGG pathways, and chromosomal locations.

# bioconductor-huo22.db

## Overview

HuO22.db is a Bioconductor annotation package providing detailed mapping for the HuO22 platform. It serves as an SQLite-based interface to translate manufacturer-specific identifiers (probes) into various biological identifiers and functional annotations. The package primarily utilizes the AnnotationDbi framework for data retrieval.

## Core Workflows

### Loading the Package

Load the library to access the annotation objects:

library(HuO22.db)

### Querying with the select() Interface

The preferred method for interacting with HuO22.db is the select() function from the AnnotationDbi package.

1. Discover available keys (identifiers):
   keys(HuO22.db)

2. List available annotation columns:
   columns(HuO22.db)

3. Retrieve specific mappings:
   select(HuO22.db, keys = c("probe_id1", "probe_id2"), columns = c("SYMBOL", "ENTREZID", "GENENAME"), keytype = "PROBEID")

### Using mapIds() for 1-to-1 Mappings

When a simple vector mapping is required (e.g., mapping probes to symbols), use mapIds():

gene_symbols <- mapIds(HuO22.db, keys = my_probes, column = "SYMBOL", keytype = "PROBEID", multiVals = "first")

### Legacy Bimap Interface

While select() is recommended, specific Bimap objects are available for direct access:

- HuO22SYMBOL: Map manufacturer IDs to Gene Symbols.
- HuO22ENTREZID: Map manufacturer IDs to Entrez Gene identifiers.
- HuO22GO: Map manufacturer IDs to Gene Ontology (GO) terms.
- HuO22PATH: Map manufacturer IDs to KEGG pathway identifiers.
- HuO22CHR: Map manufacturer IDs to Chromosomes.

Example of Bimap usage:
x <- HuO22SYMBOL
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes])

## Common Annotation Columns

- ACCNUM: GenBank Accession Number
- ALIAS: Common Gene Symbols/Aliases
- ENSEMBL: Ensembl Gene Accession
- ENTREZID: Entrez Gene Identifier
- GENENAME: Full Gene Name
- GO: Gene Ontology (includes ID, Ontology, and Evidence)
- PATH: KEGG Pathway ID
- REFSEQ: RefSeq Identifier
- SYMBOL: Official Gene Symbol
- UNIPROT: Uniprot Accession Number

## Database Information

To inspect the underlying database schema or connection details:

- HuO22_dbconn(): Returns the DBI connection object.
- HuO22_dbfile(): Returns the path to the SQLite database file.
- HuO22_dbschema(): Prints the database schema.
- HuO22_dbInfo(): Displays package metadata.

## Reference documentation

- [HuO22.db Reference Manual](./references/reference_manual.md)