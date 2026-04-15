---
name: bioconductor-illuminaratv1.db
description: This package provides annotation data for the Illumina Ratv1 microarray platform to map probe identifiers to biological metadata and quality metrics. Use when user asks to map Illumina Ratv1 probes to gene symbols, Entrez IDs, or GO terms, filter probes by quality, or retrieve genomic locations for Rattus norvegicus.
homepage: https://bioconductor.org/packages/release/data/annotation/html/illuminaRatv1.db.html
---

# bioconductor-illuminaratv1.db

name: bioconductor-illuminaratv1.db
description: Annotation data for the Illumina Ratv1 platform. Use this skill when you need to map Illumina manufacturer identifiers (probes) to various biological identifiers (Entrez Gene, Ensembl, RefSeq, Gene Symbols), chromosomal locations, Gene Ontology (GO) terms, or KEGG pathways for Rattus norvegicus. It also includes custom re-annotation data such as probe quality and genomic match similarity.

## Overview

The `illuminaRatv1.db` package is a Bioconductor annotation data package for the Illumina Ratv1 microarray platform. It provides a set of SQLite-based R objects that map manufacturer probe IDs to biological metadata. A unique feature of this package is the inclusion of "New Mappings" based on extensive re-annotation of probe sequences, allowing for filtering based on probe quality (e.g., "Perfect", "Good", "Bad").

## Core Workflows

### Loading the Package and Exploring Objects
To begin, load the library and list all available mapping objects:
```R
library(illuminaRatv1.db)
ls("package:illuminaRatv1.db")
```

### Basic ID Mapping
Most objects in this package are used by converting them to a list or using the `select()` interface from `AnnotationDbi`.

**Example: Mapping Probes to Gene Symbols**
```R
# Get probe IDs mapped to symbols
x <- illuminaRatv1SYMBOL
mapped_probes <- mappedkeys(x)
# Convert to list for specific probes
probe_to_symbol <- as.list(x[mapped_probes[1:5]])
```

**Example: Mapping Probes to Entrez IDs**
```R
entrez_ids <- as.list(illuminaRatv1ENTREZID)
```

### Using Custom Re-annotation Data
This package provides specific probe-level quality metrics that are not found in standard Bioconductor annotation packages.

**Filtering by Probe Quality**
It is recommended to retain only "Perfect" or "Good" probes for analysis.
```R
# List all custom mappings
illuminaRatv1listNewMappings()

# Check probe quality
qual <- as.list(illuminaRatv1PROBEQUALITY)
# Example: Get quality for a specific probe
qual[["ILMN_12345"]] 

# Summary of all probe qualities
table(unlist(qual))
```

**Accessing Probe Sequences and Genomic Locations**
```R
# Get 50-base probe sequences
sequences <- as.list(illuminaRatv1PROBESEQUENCE)

# Get genomic coordinates (rn4 for Rat)
locations <- as.list(illuminaRatv1GENOMICLOCATION)
```

### Functional Annotation (GO and KEGG)
**Gene Ontology (GO)**
```R
# Direct associations
go_mapping <- as.list(illuminaRatv1GO)

# Reverse mapping: GO ID to Probes (including child nodes)
go_to_probes <- as.list(illuminaRatv1GO2ALLPROBES)
```

**KEGG Pathways**
```R
# Probes to Pathway IDs
pathways <- as.list(illuminaRatv1PATH)

# Pathway IDs to Probes
pathway_to_probes <- as.list(illuminaRatv1PATH2PROBE)
```

### Database Connection and Metadata
To query the underlying SQLite database directly or check versioning:
```R
# Get DB connection
conn <- illuminaRatv1_dbconn()
dbGetQuery(conn, "SELECT COUNT(*) FROM probes")

# Get organism info
illuminaRatv1ORGANISM
```

## Tips
- **Reverse Mappings**: Many objects have a reverse map (e.g., `illuminaRatv1PMID2PROBE`). You can also use the `revmap()` function on a mapping object.
- **Probe Quality**: Always check `illuminaRatv1PROBEQUALITY`. Probes marked as "Bad" or "No match" should generally be excluded from downstream differential expression analysis.
- **Map Counts**: Use `illuminaRatv1MAPCOUNTS` to quickly see how many keys are successfully mapped in any given object.

## Reference documentation
- [illuminaRatv1.db](./references/reference_manual.md)