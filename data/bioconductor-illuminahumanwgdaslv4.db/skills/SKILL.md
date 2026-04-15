---
name: bioconductor-illuminahumanwgdaslv4.db
description: This package provides comprehensive annotation data for the Illumina Human Whole-Genome DASL v4 platform. Use when user asks to map Illumina probe identifiers to biological metadata, perform functional annotation with GO or KEGG terms, or filter probes based on quality grades and re-annotation data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/illuminaHumanWGDASLv4.db.html
---

# bioconductor-illuminahumanwgdaslv4.db

name: bioconductor-illuminahumanwgdaslv4.db
description: Comprehensive annotation data for the Illumina Human Whole-Genome DASL v4 platform. Use this skill when mapping Illumina probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, and KEGG pathways, or when performing probe-level quality filtering using custom re-annotations.

# bioconductor-illuminahumanwgdaslv4.db

## Overview

The `illuminaHumanWGDASLv4.db` package is a Bioconductor annotation data package providing detailed mappings for the Illumina Human Whole-Genome DASL v4 platform. It uses an SQLite database to store relationships between manufacturer probe identifiers and various public database accessions (Entrez, Ensembl, RefSeq, etc.), as well as functional annotations (GO, KEGG).

## Core Usage

### Loading and Exploration

To use the package, load the library and list available mapping objects:

library(illuminaHumanWGDASLv4.db)
ls("package:illuminaHumanWGDASLv4.db")

### Basic Mapping Workflow

Most objects in this package are used to map probe IDs to specific metadata. The standard pattern involves identifying mapped keys and converting the object to a list:

# Example: Mapping Probes to Gene Symbols
x <- illuminaHumanWGDASLv4SYMBOL
mapped_probes <- mappedkeys(x)
probe_to_symbol <- as.list(x[mapped_probes])

# Access specific probe
probe_to_symbol[["illumina_id"]]

### Common Annotation Objects

- **illuminaHumanWGDASLv4ENTREZID**: Maps probes to Entrez Gene identifiers.
- **illuminaHumanWGDASLv4SYMBOL**: Maps probes to official Gene Symbols.
- **illuminaHumanWGDASLv4GENENAME**: Maps probes to full Gene Names.
- **illuminaHumanWGDASLv4CHR**: Maps probes to Chromosomes.
- **illuminaHumanWGDASLv4GO**: Maps probes to Gene Ontology (GO) terms (includes Evidence and Ontology codes).
- **illuminaHumanWGDASLv4PATH**: Maps probes to KEGG Pathway identifiers.

### Reverse Mapping

To find which probes correspond to a specific biological identifier (e.g., which probes target a specific Gene Symbol), use `revmap()`:

# Map Symbols back to Probes
symbol_to_probe <- as.list(revmap(illuminaHumanWGDASLv4SYMBOL))

## Custom Re-annotation Features

This package includes specialized re-annotation data that provides higher-quality filtering than standard manufacturer mappings.

### Quality Filtering

It is highly recommended to filter probes based on their quality grade:

# Get probe quality grades
qual <- as.list(illuminaHumanWGDASLv4PROBEQUALITY)

# Grades include: "Perfect", "Good", "Bad", "No match"
# Recommendation: Retain only "Perfect" or "Good" probes for analysis.
perfect_probes <- names(qual)[qual == "Perfect"]

### Accessing Re-annotation Metadata

Use `illuminaHumanWGDASLv4listNewMappings()` to see all custom fields:

- **illuminaHumanWGDASLv4PROBESEQUENCE**: The 50bp probe sequence.
- **illuminaHumanWGDASLv4CODINGZONE**: Coding status (intergenic/intronic/transcriptomic).
- **illuminaHumanWGDASLv4ARRAYADDRESS**: Bead-level identification code.
- **illuminaHumanWGDASLv4NUID**: Lumi's universal naming scheme (nuID).

## Database Connection Utilities

For advanced users needing direct SQL access:

- `illuminaHumanWGDASLv4_dbconn()`: Returns the DBIConnection object.
- `illuminaHumanWGDASLv4_dbfile()`: Returns the path to the SQLite database file.
- `illuminaHumanWGDASLv4_dbschema()`: Prints the database schema.

## Tips

- **Memory Efficiency**: Converting large maps to lists with `as.list()` can be memory-intensive. For single lookups, use `get("probe_id", illuminaHumanWGDASLv4SYMBOL)`.
- **Consistency**: Mappings are updated biannually. Always check the source date using `illuminaHumanWGDASLv4_dbInfo()`.
- **Multiple Mappings**: Some probes may map to multiple Entrez IDs or GO terms. `as.list()` will return a vector for these entries.

## Reference documentation

- [illuminaHumanWGDASLv4.db](./references/reference_manual.md)