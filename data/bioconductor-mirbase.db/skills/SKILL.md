---
name: bioconductor-mirbase.db
description: This Bioconductor package provides programmatic access to miRBase microRNA metadata, including sequences, genomic coordinates, and secondary structures. Use when user asks to retrieve microRNA sequences, map identifiers to genomic locations, access hairpin structures, or identify mature miRNA information and gene families.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/mirbase.db.html
---

# bioconductor-mirbase.db

## Overview
The `mirbase.db` package is a Bioconductor annotation data package providing comprehensive information from the miRBase microRNA database (Version 19). It allows for programmatic access to microRNA metadata, including sequences, secondary structures (hairpins), genomic coordinates, and functional annotations across multiple organisms.

## Core Workflows

### Loading and Exploration
To begin using the package, load the library and list available mapping objects:
```r
library(mirbase.db)
ls("package:mirbase.db")
```

### Mapping Identifiers to Genomic Data
Retrieve chromosome assignments and base-pair locations for microRNAs:
```r
# Map to Chromosomes
chr_map <- as.list(mirbaseCHR)
chr_map["hsa-mir-21"]

# Map to Start/End Locations
start_pos <- as.list(mirbaseCHRLOC)
end_pos <- as.list(mirbaseCHRLOCEND)
```

### Sequence and Structure Analysis
Access precursor sequences, minimum fold energy (MFE), and ASCII representations of hairpin structures:
```r
# Get precursor sequence
seqs <- get("hsa-mir-21", mirbaseSEQUENCE)

# Get Minimum Fold Energy
mfe <- get("hsa-mir-21", mirbaseMFE)

# View folded hairpin structure
cat(get("hsa-mir-21", mirbaseHAIRPIN))
```

### Mature miRNA Information
Precursor microRNAs often produce one or more mature miRNAs. Use `mirbaseMATURE` to extract specific details:
```r
mature_info <- get("hsa-mir-21", mirbaseMATURE)
# Access slots: matureAccession, matureName, matureFrom, matureTo
mature_info@matureName
```

### Species and Family Lookups
Convert between microRNA IDs, species acronyms, and gene families:
```r
# Get species acronym for a miRNA
spec_acronym <- get("hsa-mir-21", mirbaseID2SPECIES)

# Get full species name and genome assembly
species_info <- toTable(mirbaseSPECIES[spec_acronym])

# Get miRNA family
family <- get("hsa-mir-21", mirbaseFAMILY)
```

### Genomic Context and Clusters
Identify overlapping transcripts or microRNAs located within a 10kb genomic window:
```r
# Genomic clusters
clusters <- get("hsa-mir-21", mirbaseCLUSTER)

# Overlapping transcripts (exons, introns, UTRs)
context <- get("hsa-mir-21", mirbaseCONTEXT)
```

## Tips and Best Practices
- **Mapping Objects**: Most objects in this package are `Bimap` objects. Use `as.list()`, `get()`, or `mget()` for retrieval.
- **Reverse Maps**: Many maps have reverse counterparts (e.g., `mirbaseACC2ID` is the reverse of `mirbaseID2ACC`).
- **Database Connection**: Use `mirbase_dbconn()` to access the underlying SQLite connection for custom SQL queries, but never call `dbDisconnect()` on it.
- **Version Check**: Use `mirbase()` to verify the current miRBase version and release date stored in the package.

## Reference documentation
- [mirbase.db Reference Manual](./references/reference_manual.md)