---
name: bioconductor-hi16cod.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hi16cod.db.html
---

# bioconductor-hi16cod.db

name: bioconductor-hi16cod.db
description: Annotation data for the hi16cod platform. Use when mapping manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, and KEGG pathways in R.

# bioconductor-hi16cod.db

## Overview
The `hi16cod.db` package is a Bioconductor annotation data package that provides detailed mappings for the hi16cod platform. It uses an SQLite database to store relationships between manufacturer-specific probe identifiers and various public identifiers (GenBank, Ensembl, Entrez, etc.) and functional annotations (GO, KEGG).

## Core Workflows

### Loading and Discovery
Load the package and list all available mapping objects:
```R
library(hi16cod.db)
# List all available maps
ls("package:hi16cod.db")
```

### Basic Identifier Mapping
To map manufacturer probes to common identifiers like Gene Symbols or Entrez IDs, use the `as.list()` function or the `select()` interface from `AnnotationDbi`.

```R
# Map probes to Gene Symbols
probes <- c("1", "2", "3") # Replace with actual probe IDs
symbols <- as.list(hi16codSYMBOL[probes])

# Map probes to Entrez Gene IDs
entrez_ids <- as.list(hi16codENTREZID[probes])
```

### Reverse Mappings
Many objects have a reverse map (e.g., finding probes associated with a specific Gene Symbol or GO term).

```R
# Find probes for a specific Alias
probes_by_alias <- as.list(hi16codALIAS2PROBE["GAPDH"])

# Find probes for a specific KEGG pathway
probes_by_pathway <- as.list(hi16codPATH2PROBE["04110"])
```

### Functional Annotation (GO and KEGG)
Mappings to Gene Ontology (GO) and KEGG pathways provide insights into biological processes.

```R
# Get GO annotations for specific probes
go_annotations <- as.list(hi16codGO[probes])

# Access specific GO details (Evidence, Ontology, ID)
if(length(go_annotations) > 0) {
  first_probe_go <- go_annotations[[1]]
  # Access the first GO term's ontology category (BP, CC, or MF)
  print(first_probe_go[[1]][["Ontology"]])
}

# Get KEGG pathway IDs
kegg_ids <- as.list(hi16codPATH[probes])
```

### Genomic Location
Retrieve chromosomal positions and cytobands.

```R
# Get chromosome names
chromosomes <- as.list(hi16codCHR[probes])

# Get chromosomal start positions
start_positions <- as.list(hi16codCHRLOC[probes])

# Get cytogenetic bands
cytobands <- as.list(hi16codMAP[probes])
```

## Usage Tips
- **Mapped Keys**: Use `mappedkeys(x)` to identify which probes actually have a mapping in a specific object to avoid `NA` results.
- **Data Frames**: For tabular output, you can convert maps to data frames: `toTable(hi16codSYMBOL[probes])`.
- **Database Access**: For advanced SQL queries, use `hi16cod_dbconn()` to get the underlying DBI connection. Do not call `dbDisconnect()` on this object.
- **Map Counts**: Use `hi16codMAPCOUNTS` to see the total number of mapped keys for every object in the package.

## Reference documentation
- [hi16cod.db Reference Manual](./references/reference_manual.md)