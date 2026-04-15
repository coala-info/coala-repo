---
name: bioconductor-m10kcod.db
description: This package provides biological annotation and identifier mapping for the m10kcod platform for Mus musculus. Use when user asks to map manufacturer probe IDs to Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, Ensembl accessions, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/m10kcod.db.html
---

# bioconductor-m10kcod.db

name: bioconductor-m10kcod.db
description: Use this skill to perform biological annotation and identifier mapping for the m10kcod platform (Mus musculus). This includes mapping manufacturer probe IDs to Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, Ensembl accessions, and chromosomal locations.

# bioconductor-m10kcod.db

## Overview

The `m10kcod.db` package is a Bioconductor annotation data package for the m10kcod platform. It provides comprehensive mappings between manufacturer-specific identifiers and various biological databases, primarily focused on the mouse (*Mus musculus*) genome. It is built using the AnnotationDbi framework, allowing for efficient querying of genomic metadata.

## Core Workflows

### Loading and Exploration
To begin, load the library and list all available mapping objects:
```r
library(m10kcod.db)
# List all available maps in the package
ls("package:m10kcod.db")
```

### Basic Identifier Mapping
Most objects in this package map manufacturer IDs (probes) to specific attributes. Use `as.list()` to convert a map to a searchable R list.

```r
# Map probes to Gene Symbols
probes_to_symbol <- as.list(m10kcodSYMBOL)

# Map probes to Entrez Gene IDs
probes_to_entrez <- as.list(m10kcodENTREZID)

# Access specific probes
probes_to_symbol[1:5]
```

### Functional Annotation (GO and KEGG)
Retrieve Gene Ontology (GO) terms or KEGG pathway identifiers associated with probes.

```r
# Get GO annotations for specific probes
go_data <- as.list(m10kcodGO)

# Get KEGG pathway IDs
pathway_data <- as.list(m10kcodPATH)

# Reverse map: Find probes associated with a specific KEGG pathway
path_to_probes <- as.list(m10kcodPATH2PROBE)
```

### Chromosomal Location
Find the physical location of genes represented by the probes.

```r
# Get chromosome names
chr_map <- as.list(m10kcodCHR)

# Get start positions (base pairs)
start_pos <- as.list(m10kcodCHRLOC)

# Get chromosome lengths
m10kcodCHRLENGTHS
```

### Cross-Referencing External Databases
Map manufacturer IDs to other major database accessions:
- **Ensembl**: `m10kcodENSEMBL`
- **RefSeq**: `m10kcodREFSEQ`
- **Uniprot**: `m10kcodUNIPROT`
- **MGI (Mouse Genome Informatics)**: `m10kcodMGI`
- **PubMed**: `m10kcodPMID`

## Usage Tips
- **Mapped Keys**: Use `mappedkeys(x)` to get only the identifiers that have a valid mapping in the database, filtering out NAs.
- **Reverse Maps**: Many objects have a suffix `2PROBE` (e.g., `m10kcodSYMBOL2PROBE`) which allows you to search for manufacturer IDs using external identifiers like Gene Symbols or GO IDs.
- **Database Connection**: Use `m10kcod_dbconn()` to get a DBI connection to the underlying SQLite database for advanced SQL queries. Do not call `dbDisconnect()` on this object.
- **Metadata**: Check `m10kcodMAPCOUNTS` to see the total number of mapped keys for every object in the package.

## Reference documentation
- [m10kcod.db Reference Manual](./references/reference_manual.md)