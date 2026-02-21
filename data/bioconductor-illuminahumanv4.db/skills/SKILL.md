---
name: bioconductor-illuminahumanv4.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/illuminaHumanv4.db.html
---

# bioconductor-illuminahumanv4.db

name: bioconductor-illuminahumanv4.db
description: Provides annotation data for the Illumina Humanv4 expression microarray platform. Use this skill when you need to map Illumina manufacturer probe identifiers to various biological annotations such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, or genomic locations. It is also essential for accessing custom re-annotation data (probe quality, sequences, and genomic matches) specific to the Humanv4 chip.

# bioconductor-illuminahumanv4.db

## Overview

The `illuminaHumanv4.db` package is a Bioconductor annotation data package for the Illumina Humanv4 platform. It provides a comprehensive set of mappings between manufacturer probe IDs and various biological databases. A unique feature of this package is the inclusion of custom re-annotation data (via the `illuminaHumanv4listNewMappings` suite) which allows for probe-level quality filtering and updated genomic coordinates.

## Core Workflows

### Loading the Package and Exploring Maps
To begin, load the library and list all available mapping objects:
```R
library(illuminaHumanv4.db)
ls("package:illuminaHumanv4.db")
```

### Basic ID Mapping
Most mappings follow a standard pattern: convert the mapping object to a list or use `mget` for specific keys.

```R
# Map Probe IDs to Gene Symbols
probes <- c("ILMN_1720131", "ILMN_1802380")
symbols <- mget(probes, illuminaHumanv4SYMBOL, ifnotfound=NA)

# Map Probe IDs to Entrez Gene IDs
entrez_ids <- mget(probes, illuminaHumanv4ENTREZID, ifnotfound=NA)
```

### Using Custom Re-annotations
The package provides enhanced annotations that go beyond standard RefSeq-based mappings. It is highly recommended to filter probes by quality.

```R
# Check available custom mappings
illuminaHumanv4listNewMappings()

# Filter for "Perfect" or "Good" probes
qual <- as.list(illuminaHumanv4PROBEQUALITY)
perfect_probes <- names(qual)[qual == "Perfect"]

# Get probe sequences
seqs <- mget(probes, illuminaHumanv4PROBESEQUENCE)
```

### Functional and Pathway Annotation
Map probes to Gene Ontology (GO) or KEGG pathways:

```R
# Map to GO terms (returns list of lists with Evidence and Ontology)
go_terms <- mget(probes, illuminaHumanv4GO)

# Map to KEGG Pathways
pathways <- mget(probes, illuminaHumanv4PATH)
```

### Reverse Mappings
To find which probes correspond to a specific gene or pathway, use `revmap()` or the specific reverse mapping objects:

```R
# Find probes for a specific Gene Symbol
symbol_to_probe <- as.list(illuminaHumanv4ALIAS2PROBE)
my_probes <- symbol_to_probe[["GAPDH"]]

# Find probes for a specific KEGG pathway
path_to_probe <- as.list(illuminaHumanv4PATH2PROBE)
probes_in_path <- path_to_probe[["04110"]]
```

## Database Information
To inspect the underlying SQLite database:
```R
# Get database connection and schema
conn <- illuminaHumanv4_dbconn()
illuminaHumanv4_dbschema()

# Get total counts for all maps
illuminaHumanv4MAPCOUNTS
```

## Tips
- **Probe Quality**: Always check `illuminaHumanv4PROBEQUALITY`. Probes marked as "Bad" or "No match" should generally be excluded from downstream analysis to reduce noise.
- **Biannual Updates**: This package is updated twice a year; ensure you are using the version corresponding to your Bioconductor release for the most current mappings.
- **Memory Efficiency**: For large-scale lookups, `as.list(mapping_object)` is useful for bulk access, but `mget()` is more efficient for specific subsets.

## Reference documentation
- [illuminaHumanv4.db Reference Manual](./references/reference_manual.md)