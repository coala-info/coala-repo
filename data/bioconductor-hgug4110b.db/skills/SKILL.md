---
name: bioconductor-hgug4110b.db
description: This package provides annotation data for the Agilent Human Genome G4110B Microarray. Use when user asks to map manufacturer probe identifiers to biological metadata, retrieve gene symbols, or link probes to functional annotations like GO terms and KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgug4110b.db.html
---


# bioconductor-hgug4110b.db

name: bioconductor-hgug4110b.db
description: Annotation data for the Agilent Human Genome G4110B Microarray. Use when mapping manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, RefSeq accessions, GO terms, and KEGG pathways in R.

## Overview

The hgug4110b.db package is a Bioconductor annotation data package for the Agilent Human Genome G4110B platform. It provides a stable environment for mapping manufacturer-specific probe identifiers to various public database identifiers and functional annotations.

## Core Workflows

### Loading the Package

To begin using the annotation data, load the library in your R session:

library(hgug4110b.db)

### Using the select() Interface

The preferred method for interacting with this package is through the AnnotationDbi select() interface. This allows for tabular retrieval of multiple annotation types simultaneously.

# List available columns for mapping
columns(hgug4110b.db)

# List available key types (usually PROBEID)
keytypes(hgug4110b.db)

# Retrieve specific annotations for a set of probes
probes <- c("1", "10", "100") # Example probe IDs
select(hgug4110b.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")

### Using the Bimap Interface

While select() is preferred, you can also interact with specific mapping objects (Bimaps) directly.

# Map probes to Gene Symbols
x <- hgug4110bSYMBOL
mapped_probes <- mappedkeys(x)
symbol_list <- as.list(x[mapped_probes])

# Access the first few mappings
symbol_list[1:5]

### Common Annotation Mappings

- **Gene Identification**: Use `hgug4110bSYMBOL` (Official Symbols), `hgug4110bENTREZID` (Entrez Gene IDs), or `hgug4110bGENENAME` (Full Names).
- **Functional Annotation**: Use `hgug4110bGO` for Gene Ontology terms or `hgug4110bPATH` for KEGG pathway identifiers.
- **Cross-References**: Use `hgug4110bENSEMBL`, `hgug4110bUNIPROT`, or `hgug4110bREFSEQ` to link to other major databases.
- **Chromosomal Location**: Use `hgug4110bCHR` (Chromosome), `hgug4110bMAP` (Cytoband), or `hgug4110bCHRLOC` (Start position).

### Reverse Mappings

Many objects have reverse maps to find probes associated with a specific biological identifier:

# Find probes associated with a specific GO ID
go_to_probe <- as.list(hgug4110bGO2PROBE)
probes_for_go <- go_to_probe[["GO:0000018"]]

## Database Information

To inspect the underlying SQLite database metadata or connection:

# Get database schema
hgug4110b_dbschema()

# Get database connection info
hgug4110b_dbInfo()

## Reference documentation

- [hgug4110b.db Reference Manual](./references/reference_manual.md)