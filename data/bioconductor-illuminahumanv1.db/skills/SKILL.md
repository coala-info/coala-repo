---
name: bioconductor-illuminahumanv1.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/illuminaHumanv1.db.html
---

# bioconductor-illuminahumanv1.db

name: bioconductor-illuminahumanv1.db
description: Provides annotation data for the Illumina Humanv1 BeadChip platform. Use this skill when you need to map Illumina manufacturer identifiers (probes) to various biological identifiers like Entrez Gene IDs, Gene Symbols, RefSeq accessions, GO terms, and KEGG pathways, or when performing re-annotation tasks using the Barbosa-Morais pipeline data.

## Overview

The `illuminaHumanv1.db` package is a Bioconductor annotation data package for the Illumina Humanv1 platform. It provides SQLite-based mappings between manufacturer probe IDs and various genomic, transcriptomic, and functional annotations. A key feature of this specific package is the inclusion of "re-annotation" data, which provides quality grades for probes (Perfect, Good, Bad, No match) and updated genomic coordinates.

## Core Workflows

### Loading the Package and Exploring Maps
```R
library(illuminaHumanv1.db)

# List all available mapping objects
ls("package:illuminaHumanv1.db")

# Get summary information about the database
illuminaHumanv1_dbInfo()
```

### Basic Identifier Mapping
To map Illumina IDs to other identifiers, use the `as.list()` or `select()` functions (from AnnotationDbi).

```R
# Map Probes to Gene Symbols
probes <- c("unassigned", "10011") # Example IDs
symbols <- as.list(illuminaHumanv1SYMBOL[probes])

# Map Probes to Entrez IDs
entrez_ids <- as.list(illuminaHumanv1ENTREZID[probes])

# Reverse mapping: Gene Symbol to Probes
probe_list <- as.list(illuminaHumanv1ALIAS2PROBE["TP53"])
```

### Using Re-annotation Data
This package contains custom mappings derived from a re-annotation pipeline. It is highly recommended to filter probes based on `PROBEQUALITY`.

```R
# Check probe quality
qual <- as.list(illuminaHumanv1PROBEQUALITY)
# Qualities: "Perfect", "Good", "Bad", "No match"

# Get all re-annotation info as a matrix
reannot <- illuminaHumanv1fullReannotation()

# List all custom mapping functions
illuminaHumanv1listNewMappings()
```

### Functional Annotation (GO and KEGG)
```R
# Map probes to Gene Ontology (GO)
go_mapping <- as.list(illuminaHumanv1GO["10011"])

# Map probes to KEGG Pathways
path_mapping <- as.list(illuminaHumanv1PATH["10011"])
```

### Physical Location and Chromosomes
```R
# Get chromosome for probes
chroms <- as.list(illuminaHumanv1CHR["10011"])

# Get chromosomal start positions
locs <- as.list(illuminaHumanv1CHRLOC["10011"])
```

## Tips and Best Practices
- **Probe Quality Filtering**: Use `illuminaHumanv1PROBEQUALITY` to retain only "Perfect" or "Good" probes to improve the reliability of differential expression analysis.
- **Mapping Counts**: Use `illuminaHumanv1MAPCOUNTS` to verify the number of mapped keys for any specific annotation object.
- **Database Connection**: If you need to perform custom SQL queries, use `illuminaHumanv1_dbconn()` to get the DBI connection object, but never call `dbDisconnect()` on it.
- **nuID**: The package supports `illuminaHumanv1NUID`, which is a universal naming scheme for oligonucleotides useful for cross-platform comparisons.

## Reference documentation
- [illuminaHumanv1.db Reference Manual](./references/reference_manual.md)