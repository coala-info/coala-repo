---
name: bioconductor-lumimouseall.db
description: This package provides SQLite-based annotation mappings for the Illumina Mouse All-Star microarray platform. Use when user asks to map Illumina mouse probe identifiers to gene symbols, Entrez IDs, Gene Ontology terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/lumiMouseAll.db.html
---

# bioconductor-lumimouseall.db

## Overview

The `lumiMouseAll.db` package is a Bioconductor annotation data package for the Illumina Mouse All-Star platform. It provides a comprehensive set of SQLite-based mappings between manufacturer probe identifiers and various biological databases. This package is essential for downstream analysis of Illumina mouse microarray data, allowing researchers to annotate probe-level results with functional and genomic information.

## Core Usage

### Loading the Package
```R
library(lumiMouseAll.db)
# List all available mapping objects
ls("package:lumiMouseAll.db")
```

### Basic Mapping Workflow
Most objects in this package are used by converting them to a list or using the `select()` function from `AnnotationDbi`.

```R
# Example: Mapping probes to Gene Symbols
x <- lumiMouseAllSYMBOL
mapped_probes <- mappedkeys(x)
# Convert to a list for specific probes
symbol_list <- as.list(x[mapped_probes[1:5]])

# Example: Mapping probes to Entrez Gene IDs
entrez_ids <- as.list(lumiMouseAllENTREZID)
```

### Common Annotation Mappings
- **Gene Identification**: `lumiMouseAllSYMBOL` (Official Symbols), `lumiMouseAllGENENAME` (Full Names), `lumiMouseAllENTREZID` (Entrez IDs), `lumiMouseAllENSEMBL` (Ensembl IDs).
- **Functional Annotation**: `lumiMouseAllGO` (Gene Ontology), `lumiMouseAllPATH` (KEGG Pathways), `lumiMouseAllENZYME` (EC Numbers).
- **Genomic Location**: `lumiMouseAllCHR` (Chromosomes), `lumiMouseAllCHRLOC` (Start positions), `lumiMouseAllCHRLENGTHS` (Chromosome lengths).
- **Cross-References**: `lumiMouseAllACCNUM` (GenBank Accessions), `lumiMouseAllUNIPROT` (UniProt IDs), `lumiMouseAllMGI` (MGI Accessions).

### Working with Gene Ontology (GO)
The GO mapping returns a list of lists containing the GO ID, Ontology (BP, CC, MF), and Evidence code.

```R
# Get GO annotations for a probe
probe_go <- as.list(lumiMouseAllGO[["your_probe_id"]])
# Access details
probe_go[[1]][["GOID"]]
probe_go[[1]][["Evidence"]]
```

### Reverse Mappings
Many objects have reverse maps (e.g., mapping from a Symbol back to Probes).
```R
# Map Gene Symbols to Probes
symbol_to_probe <- as.list(lumiMouseAllALIAS2PROBE)

# Map KEGG Pathways to Probes
path_to_probe <- as.list(lumiMouseAllPATH2PROBE)
```

## Database Connection and Metadata
You can query the underlying SQLite database directly for complex joins or to check versioning.

```R
# Get database metadata
lumiMouseAll_dbInfo()

# Get the database schema
lumiMouseAll_dbschema()

# Get a raw connection for SQL queries
conn <- lumiMouseAll_dbconn()
dbGetQuery(conn, "SELECT COUNT(*) FROM probes")
```

## Tips for Efficiency
- Use `mappedkeys(x)` to identify which probes actually have valid mappings before attempting to extract data.
- For large-scale mapping, the `AnnotationDbi::select()` function is often more efficient than converting the entire object to a list.
- `lumiMouseAllMAPCOUNTS` provides a quick way to see the number of mapped keys for every object in the package.

## Reference documentation
- [lumiMouseAll.db Reference Manual](./references/reference_manual.md)