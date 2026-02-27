---
name: bioconductor-rnagilentdesign028282.db
description: This package provides annotation mappings between Agilent Design 028282 microarray probe IDs and biological identifiers for *Rattus norvegicus*. Use when user asks to map rat microarray probes to gene symbols, retrieve Entrez or Ensembl IDs, or access functional annotations like GO terms and KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/RnAgilentDesign028282.db.html
---


# bioconductor-rnagilentdesign028282.db

## Overview

The `RnAgilentDesign028282.db` package is a Bioconductor annotation data package for the Agilent Design 028282 microarray platform. It provides a comprehensive set of mappings between manufacturer probe IDs and standard biological identifiers for *Rattus norvegicus* (Rat).

## Core Workflows

### Loading the Package
```r
library(RnAgilentDesign028282.db)
```

### Using the select() Interface
The recommended way to interact with this package is via the `AnnotationDbi` interface (`select`, `keys`, `columns`, and `keytypes`).

```r
# List available columns (types of data you can retrieve)
columns(RnAgilentDesign028282.db)

# List available keytypes (types of data you can use as input)
keytypes(RnAgilentDesign028282.db)

# Retrieve specific annotations for a set of probe IDs
probes <- c("12345", "67890") # Replace with actual Agilent IDs
select(RnAgilentDesign028282.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Mapping Probes to Biological Identifiers
The package contains several specific mapping objects (Bimaps). Common mappings include:

*   **Gene Symbols**: `RnAgilentDesign028282SYMBOL`
*   **Entrez Gene IDs**: `RnAgilentDesign028282ENTREZID`
*   **Ensembl IDs**: `RnAgilentDesign028282ENSEMBL`
*   **RefSeq IDs**: `RnAgilentDesign028282REFSEQ`
*   **Gene Names**: `RnAgilentDesign028282GENENAME`

Example using the Bimap interface:
```r
# Convert a mapping to a list
sym_list <- as.list(RnAgilentDesign028282SYMBOL)
# Access a specific probe
sym_list[["your_probe_id"]]
```

### Functional and Pathway Annotation
*   **Gene Ontology (GO)**: `RnAgilentDesign028282GO` (direct) or `RnAgilentDesign028282GO2ALLPROBES` (including children).
*   **KEGG Pathways**: `RnAgilentDesign028282PATH` maps probes to pathway IDs.
*   **Enzyme Commission (EC)**: `RnAgilentDesign028282ENZYME`.

### Chromosomal Information
*   **Chromosome**: `RnAgilentDesign028282CHR`
*   **Location**: `RnAgilentDesign028282CHRLOC` (start) and `RnAgilentDesign028282CHRLOCEND` (stop).
*   **Lengths**: `RnAgilentDesign028282CHRLENGTHS` provides chromosome lengths in base pairs.

## Tips and Best Practices
*   **Reverse Mappings**: Many objects have reverse maps (e.g., `RnAgilentDesign028282SYMBOL2PROBE`) to find probes associated with a specific gene symbol.
*   **Database Connection**: Use `RnAgilentDesign028282_dbconn()` to get a connection object if you need to perform direct SQL queries via `DBI`.
*   **Data Currency**: Mappings are based on snapshots from sources like Entrez Gene and Ensembl. Check the package metadata for specific version dates.
*   **Handling NAs**: Not all probes map to all identifier types; `select()` will return `NA` for missing mappings.

## Reference documentation
- [RnAgilentDesign028282.db Reference Manual](./references/reference_manual.md)