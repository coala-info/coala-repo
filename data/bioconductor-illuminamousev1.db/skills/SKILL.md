---
name: bioconductor-illuminamousev1.db
description: This package provides annotation data and identifier mappings for the Illumina Mousev1 microarray platform. Use when user asks to map Illumina probe identifiers to Gene Symbols, Entrez IDs, GO terms, or KEGG pathways, and when filtering probes by quality or genomic location for Mus musculus.
homepage: https://bioconductor.org/packages/release/data/annotation/html/illuminaMousev1.db.html
---


# bioconductor-illuminamousev1.db

name: bioconductor-illuminamousev1.db
description: Annotation data for the Illumina Mousev1 platform. Use this skill when you need to map Illumina manufacturer identifiers (probes) to biological metadata such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, or custom re-annotation data (probe quality, genomic location) for Mus musculus.

## Overview

The `illuminaMousev1.db` package is a Bioconductor annotation hub for the Illumina Mousev1 microarray. It provides SQLite-based mappings between manufacturer probe IDs and various public identifiers. A unique feature of this package is the inclusion of custom re-annotation mappings (e.g., `PROBEQUALITY`, `NUID`) that offer more precise probe-level information than standard RefSeq-based mappings.

## Core Workflows

### Loading the Package
```r
library(illuminaMousev1.db)
# List all available mapping objects
ls("package:illuminaMousev1.db")
```

### Basic Identifier Mapping
To map Illumina IDs to other identifiers, use the specific map objects. The standard pattern is to convert the map to a list or use `AnnotationDbi::select`.

```r
# Map probes to Gene Symbols
probes <- c("ILMN_1212", "ILMN_1213") # Example IDs
symbols <- as.list(illuminaMousev1SYMBOL[probes])

# Map probes to Entrez IDs
entrez_ids <- as.list(illuminaMousev1ENTREZID[probes])
```

### Using Custom Re-annotations
This package provides enhanced probe-specific data. It is highly recommended to filter probes by quality.

```r
# Check probe quality (Perfect, Good, Bad, No match)
qual <- as.list(illuminaMousev1PROBEQUALITY[probes])

# List all custom mapping types available
illuminaMousev1listNewMappings()

# Get full re-annotation matrix
# Note: This can be large; use with caution
# full_data <- illuminaMousev1fullReannotation()
```

### Functional Annotation (GO and KEGG)
```r
# Map to Gene Ontology (GO)
go_terms <- as.list(illuminaMousev1GO[probes])

# Map to KEGG Pathways
pathways <- as.list(illuminaMousev1PATH[probes])
```

### Reverse Mappings
Most objects have a reverse map (e.g., finding probes for a specific Gene Symbol).

```r
# Find probes for a specific symbol
symbol_to_probe <- as.list(illuminaMousev1ALIAS2PROBE[["Gfi1"]])

# Reverse map for Array Address
probe_from_address <- revmap(illuminaMousev1ARRAYADDRESS)
```

## Database Utilities
Access the underlying SQLite connection for complex queries:
```r
# Get DB connection
conn <- illuminaMousev1_dbconn()
# Query row count of probes table
dbGetQuery(conn, "SELECT COUNT(*) FROM probes")
```

## Tips
- **Probe Quality**: Always check `illuminaMousev1PROBEQUALITY`. "Perfect" or "Good" probes are recommended for reliable analysis.
- **Map Counts**: Use `illuminaMousev1MAPCOUNTS` to see the number of mapped keys for every object in the package.
- **NUIDs**: Use `illuminaMousev1NUID` for universal naming scheme compatibility with the `lumi` package.

## Reference documentation
- [illuminaMousev1.db Reference Manual](./references/reference_manual.md)