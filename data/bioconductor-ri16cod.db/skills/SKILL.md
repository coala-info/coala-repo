---
name: bioconductor-ri16cod.db
description: This package provides annotation data for the ri16cod platform to map Rattus norvegicus manufacturer identifiers to biological metadata. Use when user asks to map probe IDs to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ri16cod.db.html
---


# bioconductor-ri16cod.db

name: bioconductor-ri16cod.db
description: Provides annotation data for the ri16cod platform (Rattus norvegicus). Use this skill to map manufacturer identifiers (probes) to various biological annotations including Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, Ensembl IDs, and chromosomal locations.

# bioconductor-ri16cod.db

## Overview

The `ri16cod.db` package is a Bioconductor annotation data package for the ri16cod platform. It provides SQLite-based mappings between manufacturer probe identifiers and various genomic databases. This skill guides you through querying these mappings to annotate experimental results.

## Core Workflows

### Loading the Package and Exploring Maps
To begin, load the library and list all available mapping objects:
```R
library(ri16cod.db)
# List all available mapping objects
ls("package:ri16cod.db")
```

### Basic Mapping Pattern
Most objects in this package are used with the `as.list()` or `get()` functions. To map a set of probe IDs to another identifier (e.g., Gene Symbols):
```R
# Get the mapping object
x <- ri16codSYMBOL
# Get probe IDs that have a mapping
mapped_probes <- mappedkeys(x)
# Convert to a list for easy lookup
symbol_list <- as.list(x[mapped_probes])

# Access specific probes
symbol_list[1:5]
```

### Common Annotation Tasks

#### Mapping to Gene Identifiers
- **Entrez Gene IDs**: Use `ri16codENTREZID`
- **Gene Symbols**: Use `ri16codSYMBOL`
- **Gene Names**: Use `ri16codGENENAME`
- **Ensembl IDs**: Use `ri16codENSEMBL`
- **RefSeq IDs**: Use `ri16codREFSEQ`

#### Functional Annotation
- **Gene Ontology (GO)**: `ri16codGO` provides direct associations. For all associations including child terms, use `ri16codGO2ALLPROBES`.
- **KEGG Pathways**: Use `ri16codPATH` to find pathway IDs for probes.
- **Enzyme Commission (EC) Numbers**: Use `ri16codENZYME`.

#### Genomic Location
- **Chromosomes**: Use `ri16codCHR`.
- **Chromosomal Location**: Use `ri16codCHRLOC` (start) and `ri16codCHRLOCEND` (end).
- **Chromosome Lengths**: Use `ri16codCHRLENGTHS`.

### Reverse Mappings
Many objects have a reverse map (e.g., mapping from a Gene Symbol back to Probes). These are typically named with a `2PROBE` suffix:
```R
# Map Gene Symbols to Probes
alias_to_probe <- as.list(ri16codALIAS2PROBE)
# Map GO IDs to Probes
go_to_probe <- as.list(ri16codGO2PROBE)
```

### Database Connection and Metadata
To inspect the underlying database or check version information:
```R
# Get database metadata
ri16cod_dbInfo()
# Get the organism name
ri16codORGANISM
# Check map counts for quality control
ri16codMAPCOUNTS
```

## Tips
- Use `mappedkeys(x)` to filter out probes that do not have an annotation in a specific map to avoid `NA` values.
- For large-scale lookups, `AnnotationDbi::select()` is often more efficient than `as.list()`.
- The `ri16codALIAS2PROBE` map includes both official symbols and common aliases, making it useful for searching with non-standard gene names.

## Reference documentation
- [ri16cod.db Reference Manual](./references/reference_manual.md)