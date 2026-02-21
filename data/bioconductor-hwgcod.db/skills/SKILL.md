---
name: bioconductor-hwgcod.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hwgcod.db.html
---

# bioconductor-hwgcod.db

## Overview

The `hwgcod.db` package is a Bioconductor annotation data package for the hwgcod platform. It provides SQLite-based mappings between manufacturer identifiers (probes) and various biological databases. This package is essential for downstream bioinformatics analysis where probe-level data must be interpreted in the context of genes, pathways, and functional ontologies.

## Core Workflows

### Loading the Package and Exploring Objects
To begin, load the library and list the available mapping objects:
```R
library(hwgcod.db)
ls("package:hwgcod.db")
```

### Basic Identifier Mapping
Most objects in `hwgcod.db` map manufacturer IDs to a specific attribute. Use `as.list()` to convert the mapping object for easy access.

```R
# Map probes to Gene Symbols
probes_to_symbol <- as.list(hwgcodSYMBOL)

# Map probes to Entrez Gene IDs
probes_to_entrez <- as.list(hwgcodENTREZID)

# Access specific probes
probes_to_symbol[1:5]
```

### Functional Annotation (GO and KEGG)
Map probes to Gene Ontology (GO) terms or KEGG pathways for functional analysis.

```R
# Get GO annotations for specific probes
go_mapping <- as.list(hwgcodGO)
# Each entry contains GOID, Ontology (BP, CC, MF), and Evidence code

# Get KEGG pathway IDs
pathway_mapping <- as.list(hwgcodPATH)
```

### Reverse Mappings
Many objects have reverse mappings (e.g., finding all probes associated with a specific Gene Symbol or GO term).

```R
# Find probes for a specific Alias
alias_to_probes <- as.list(hwgcodALIAS2PROBE)

# Find all probes associated with a GO ID (including child terms)
go_to_probes <- as.list(hwgcodGO2ALLPROBES)
```

### Chromosomal Location and Metadata
Retrieve physical mapping information such as chromosome, cytoband, and sequence length.

```R
# Chromosome mapping
chr_map <- as.list(hwgcodCHR)

# Cytogenetic band
band_map <- as.list(hwgcodMAP)

# Chromosomal start/end positions
start_pos <- as.list(hwgcodCHRLOC)
end_pos <- as.list(hwgcodCHRLOCEND)
```

## Usage Tips

- **Filtering Mapped Keys**: Use `mappedkeys(x)` to retrieve only the identifiers that have a valid mapping in the database, avoiding `NA` values.
- **Database Connection**: For advanced SQL queries, use `hwgcod_dbconn()` to get the underlying DBI connection. Use `hwgcod_dbschema()` to inspect the table structures.
- **Memory Management**: Converting large mapping objects to lists (`as.list()`) can be memory-intensive. For large-scale lookups, consider using the `AnnotationDbi::select()` interface if available.
- **Evidence Codes**: When working with `hwgcodGO`, pay attention to the `Evidence` element (e.g., TAS, IDA, IEA) to understand the reliability of the functional annotation.

## Reference documentation

- [hwgcod.db Reference Manual](./references/reference_manual.md)