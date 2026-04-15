---
name: bioconductor-illuminahumanv3.db
description: This package provides annotation data for mapping Illumina Humanv3 expression microarray probe identifiers to biological metadata like Gene Symbols, Entrez IDs, and GO terms. Use when user asks to map Illumina Humanv3 probes to gene identifiers, retrieve probe sequences, assess probe quality, or perform functional annotation using KEGG and GO pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/illuminaHumanv3.db.html
---

# bioconductor-illuminahumanv3.db

name: bioconductor-illuminahumanv3.db
description: Use this skill when working with the Bioconductor annotation package illuminaHumanv3.db. This is essential for mapping Illumina Humanv3 expression microarray probe identifiers to various biological annotations such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and genomic locations. Use this skill to perform identifier conversions, retrieve probe sequences, or assess probe quality based on re-annotation data.

## Overview

The `illuminaHumanv3.db` package is a Bioconductor annotation data package for the Illumina Humanv3 platform. It provides SQLite-based mappings between manufacturer probe identifiers and various public identifiers. A unique feature of this package is the inclusion of "New Mappings" based on a re-annotation pipeline that provides probe-specific quality grades and genomic coordinates.

## Core Workflows

### Loading the Package and Exploring Objects
To begin, load the library and list available mapping objects:
```R
library(illuminaHumanv3.db)
# List all available mapping objects
ls("package:illuminaHumanv3.db")
```

### Basic Identifier Mapping
Mappings are typically used by converting the map object to a list or using the `select()` function from `AnnotationDbi`.

**Using `as.list()`:**
```R
# Map probes to Gene Symbols
probes <- c("ILMN_1720131", "ILMN_1804541")
symbols <- as.list(illuminaHumanv3SYMBOL[probes])

# Map probes to Entrez IDs
entrez_ids <- as.list(illuminaHumanv3ENTREZID[probes])
```

**Using `mappedkeys()` to find annotated probes:**
```R
x <- illuminaHumanv3SYMBOL
mapped_probes <- mappedkeys(x)
# Get first 5 mappings
as.list(x[mapped_probes[1:5]])
```

### Using Re-annotation Data (Custom Mappings)
This package provides enhanced probe information not found in standard chip packages.

**Checking Probe Quality:**
It is recommended to filter for "Perfect" or "Good" probes.
```R
# View available custom mappings
illuminaHumanv3listNewMappings()

# Get probe quality grades
qual <- as.list(illuminaHumanv3PROBEQUALITY)
table(unlist(qual)) # Summary of quality across the chip
```

**Retrieving Probe Sequences and Genomic Locations:**
```R
# Get 50-mer probe sequences
seqs <- as.list(illuminaHumanv3PROBESEQUENCE[probes])

# Get genomic coordinates (hg19)
locs <- as.list(illuminaHumanv3GENOMICLOCATION[probes])
```

### Functional Annotation (GO and KEGG)
**Gene Ontology (GO):**
`illuminaHumanv3GO` provides direct associations. For all associations (including child terms), use `illuminaHumanv3GO2ALLPROBES`.
```R
# Get GO terms for a probe
probe_go <- as.list(illuminaHumanv3GO[["ILMN_1720131"]])
# Access specific elements: GOID, Ontology (BP, CC, MF), Evidence
probe_go[[1]][["Ontology"]]
```

**KEGG Pathways:**
```R
# Map probes to KEGG pathway IDs
pathways <- as.list(illuminaHumanv3PATH[["ILMN_1720131"]])
```

### Reverse Mappings
To map from a biological identifier back to Illumina probes, use `revmap()`:
```R
# Map Gene Symbols back to Probes
sym_to_probe <- revmap(illuminaHumanv3SYMBOL)
probes_for_gene <- sym_to_probe[["TP53"]]
```

## Database Connection and Metadata
To query the underlying SQLite database directly or check metadata:
```R
# Get database metadata
illuminaHumanv3_dbInfo()

# Get number of mapped keys for all maps
illuminaHumanv3MAPCOUNTS

# Direct SQL query example
conn <- illuminaHumanv3_dbconn()
dbGetQuery(conn, "SELECT COUNT(*) FROM probes")
```

## Tips
- **Probe Quality:** Always check `illuminaHumanv3PROBEQUALITY`. Probes marked as "Bad" or "No match" should generally be excluded from downstream analysis.
- **Consensus IDs:** For `ENTREZID` mappings, if multiple IDs exist, the package attempts to select a consensus or the smallest identifier.
- **Version Info:** Use `illuminaHumanv3ORGANISM` and `illuminaHumanv3ORGPKG` to programmatically confirm the target species (Homo sapiens) and the underlying organism package (org.Hs.eg.db).

## Reference documentation
- [illuminaHumanv3.db Reference Manual](./references/reference_manual.md)