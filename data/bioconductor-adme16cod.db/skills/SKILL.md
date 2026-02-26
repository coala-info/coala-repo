---
name: bioconductor-adme16cod.db
description: This package provides comprehensive SQLite-based annotation mappings for the adme16cod platform used in rat ADME studies. Use when user asks to map manufacturer probe identifiers to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/adme16cod.db.html
---


# bioconductor-adme16cod.db

name: bioconductor-adme16cod.db
description: Comprehensive annotation data for the adme16cod platform. Use when mapping manufacturer probe identifiers to biological metadata such as gene symbols, Entrez IDs, GO terms, KEGG pathways, and chromosomal locations for rat ADME studies.

## Overview

The `adme16cod.db` package is a Bioconductor annotation data package for the adme16cod platform (typically used in ADME - Absorption, Distribution, Metabolism, and Excretion studies). It provides SQLite-based mappings between manufacturer probe identifiers and various gene-centric identifiers.

## Core Workflows

### Loading and Discovery
To use the package, load the library and list available mapping objects:

```r
library(adme16cod.db)
# List all available mapping objects
ls("package:adme16cod.db")
```

### Basic Identifier Mapping
Most objects map manufacturer IDs (keys) to specific biological attributes. Use `as.list()` to convert the mapping object for easy access.

```r
# Map probes to Gene Symbols
probes <- c("1", "2", "3") # Replace with actual probe IDs
symbols <- as.list(adme16codSYMBOL[probes])

# Map probes to Entrez Gene IDs
entrez_ids <- as.list(adme16codENTREZID[probes])

# Map probes to RefSeq Accessions
refseq_ids <- as.list(adme16codREFSEQ[probes])
```

### Reverse Mapping (Gene to Probe)
To find which probes correspond to a specific gene symbol or alias, use the ALIAS2PROBE object:

```r
# Map Gene Aliases/Symbols back to Probe IDs
gene_symbols <- c("Cyp3a1", "Abcb1")
probes_for_genes <- as.list(adme16codALIAS2PROBE[gene_symbols])
```

### Functional and Pathway Annotation
The package provides links to Gene Ontology (GO) and KEGG pathways.

```r
# Get GO annotations for specific probes
go_annots <- as.list(adme16codGO[probes])

# Get KEGG pathway IDs
pathways <- as.list(adme16codPATH[probes])

# Reverse map: Find all probes in a specific KEGG pathway
pathway_probes <- as.list(adme16codPATH2PROBE[["rno00010"]])
```

### Chromosomal Information
Retrieve chromosomal locations and lengths:

```r
# Map probes to chromosomes
chroms <- as.list(adme16codCHR[probes])

# Map probes to start positions (base pairs)
starts <- as.list(adme16codCHRLOC[probes])

# Get lengths of all chromosomes
chrom_lengths <- adme16codCHRLENGTHS
```

## Database Utilities
For advanced users, you can access the underlying SQLite database directly:

```r
# Get a DBI connection object
conn <- adme16cod_dbconn()

# Show database schema
adme16cod_dbschema()

# Execute a custom SQL query
dbGetQuery(conn, "SELECT * FROM probes LIMIT 5")
```

## Tips
- Use `mappedkeys(x)` to get only the keys that have a valid mapping in object `x`.
- The `adme16codGO2ALLPROBES` object is often more useful than `adme16codGO2PROBE` for functional analysis as it includes child terms in the GO hierarchy.
- Mappings are updated biannually; always check `adme16cod_dbInfo()` for the data source date stamps.

## Reference documentation
- [adme16cod.db Reference Manual](./references/reference_manual.md)