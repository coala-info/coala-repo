---
name: bioconductor-mgu74cv2.db
description: This package provides annotation data for the Affymetrix Mouse Genome U74Cv2 chip. Use when user asks to map manufacturer probe IDs to biological identifiers like Entrez, Symbol, GO, or Ensembl for mouse microarray data analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74cv2.db.html
---

# bioconductor-mgu74cv2.db

name: bioconductor-mgu74cv2.db
description: Annotation data for the Affymetrix Mouse Genome U74Cv2 chip. Use when mapping manufacturer probe IDs to biological identifiers (Entrez, Symbol, GO, KEGG, Ensembl, MGI, etc.) or vice versa for mouse microarray data analysis.

# bioconductor-mgu74cv2.db

## Overview

The `mgu74cv2.db` package is a Bioconductor annotation data package for the Affymetrix Mouse Genome U74Cv2 chip. It provides a comprehensive set of mappings between manufacturer probe identifiers and various gene-centric identifiers. The package uses an SQLite database backend and is primarily accessed via the `AnnotationDbi` interface.

## Core Workflows

### Loading the Package

To begin using the annotation data, load the library:

library(mgu74cv2.db)

### Using the select() Interface

The `select()` function is the recommended modern interface for querying annotations. It requires the database object, the keys (input IDs), the columns (desired information), and the keytype (type of input IDs).

# List available columns
columns(mgu74cv2.db)

# List available keytypes
keytypes(mgu74cv2.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("92201_at", "92202_at", "92203_at")
select(mgu74cv2.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")

### Mapping Identifiers with mapIds()

For a simpler interface that returns a named vector (1:1 mapping), use `mapIds()`.

# Map probes to Symbols, taking the first match if multiple exist
symbols <- mapIds(mgu74cv2.db, 
                  keys = probes, 
                  column = "SYMBOL", 
                  keytype = "PROBEID", 
                  multiVals = "first")

### Using Legacy Bimap Objects

While `select()` is preferred, the package provides specific Bimap objects for direct access to mappings.

# Get probe to Symbol mapping
x <- mgu74cv2SYMBOL
mapped_probes <- mappedkeys(x)
# Convert to a list
symbol_list <- as.list(x[mapped_probes][1:5])

## Common Annotation Mappings

- **mgu74cv2ENTREZID**: Maps manufacturer IDs to Entrez Gene identifiers.
- **mgu74cv2SYMBOL**: Maps manufacturer IDs to official gene symbols.
- **mgu74cv2MGI**: Maps manufacturer IDs to Mouse Genome Informatics (MGI) accession numbers.
- **mgu74cv2GENENAME**: Maps manufacturer IDs to full gene names.
- **mgu74cv2GO**: Maps manufacturer IDs to Gene Ontology (GO) identifiers (includes Evidence and Ontology codes).
- **mgu74cv2PATH**: Maps manufacturer IDs to KEGG pathway identifiers.
- **mgu74cv2ENSEMBL**: Maps manufacturer IDs to Ensembl gene accession numbers.
- **mgu74cv2REFSEQ**: Maps manufacturer IDs to RefSeq identifiers.

## Chromosomal Information

You can retrieve chromosomal locations and lengths:

# Get chromosome for probes
select(mgu74cv2.db, keys = probes, columns = "CHR", keytype = "PROBEID")

# Get chromosome lengths
mgu74cv2CHRLENGTHS

# Get start positions (CHRLOC) and end positions (CHRLOCEND)
select(mgu74cv2.db, keys = probes, columns = "CHRLOC", keytype = "PROBEID")

## Database Metadata and Connection

To inspect the underlying database or connection:

# Get database schema
mgu74cv2_dbschema()

# Get database metadata
mgu74cv2_dbInfo()

# Get a connection object (do not disconnect manually)
conn <- mgu74cv2_dbconn()

## Tips for Effective Use

- **Multi-mapping**: Some probes may map to multiple Entrez IDs or Symbols. Use the `multiVals` argument in `mapIds()` to handle these (e.g., "first", "list", "CharacterList", or "filter").
- **GO Annotations**: The `mgu74cv2GO` mapping only provides directly evidenced terms. To include child terms in the GO hierarchy, use `mgu74cv2GO2ALLPROBES`.
- **Reverse Mappings**: Most Bimap objects have a reverse map available (e.g., `mgu74cv2SYMBOL2PROBE` or `revmap(mgu74cv2SYMBOL)`).

## Reference documentation

- [mgu74cv2.db Reference Manual](./references/reference_manual.md)