---
name: bioconductor-mogene10stprobeset.db
description: This Bioconductor package provides annotation data for mapping Affymetrix Mouse Gene 1.0 ST Probeset identifiers to biological metadata. Use when user asks to map mouse probe IDs to gene symbols, retrieve Entrez IDs, find chromosomal locations, or look up GO terms and KEGG pathways for Mouse Gene 1.0 ST arrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mogene10stprobeset.db.html
---


# bioconductor-mogene10stprobeset.db

name: bioconductor-mogene10stprobeset.db
description: An annotation data package for the Affymetrix Mouse Gene 1.0 ST Probeset platform. Use this skill to map manufacturer probe identifiers to various biological annotations such as Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, and KEGG pathways for mouse genomic data.

## Overview

The `mogene10stprobeset.db` package is a Bioconductor annotation hub for the Mouse Gene 1.0 ST array. It provides a SQLite-based interface to map probe set identifiers to genomic, functional, and bibliographic data. The primary method for interaction is the `select()` interface from the `AnnotationDbi` package, though legacy "Bimap" objects are also available.

## Core Workflows

### Loading the Package
```r
library(mogene10stprobeset.db)
```

### Exploring Available Annotations
To see which types of data (columns) can be retrieved and which keys can be used:
```r
# List available columns
columns(mogene10stprobeset.db)

# List available key types (usually PROBEID)
keytypes(mogene10stprobeset.db)

# Get a sample of keys
head(keys(mogene10stprobeset.db, keytype="PROBEID"))
```

### Using the select() Interface
The `select()` function is the recommended way to extract data. It requires the database object, the keys to look up, the columns to return, and the keytype of the input.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("10341561", "10341565", "10341574")
results <- select(mogene10stprobeset.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mapping Tasks

#### Mapping to Gene Ontology (GO)
```r
# Get GO terms and evidence codes for specific probes
go_mappings <- select(mogene10stprobeset.db, 
                      keys = probes, 
                      columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                      keytype = "PROBEID")
```

#### Mapping to KEGG Pathways
```r
path_mappings <- select(mogene10stprobeset.db, 
                        keys = probes, 
                        columns = "PATH", 
                        keytype = "PROBEID")
```

#### Mapping to Chromosomal Location
```r
loc_mappings <- select(mogene10stprobeset.db, 
                        keys = probes, 
                        columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
                        keytype = "PROBEID")
```

### Legacy Bimap Interface
While `select()` is preferred, you can use the older Bimap objects for quick lookups or list conversions:
```r
# Convert a specific map to a list
sym_list <- as.list(mogene10stprobesetSYMBOL)

# Get symbols for the first 5 probes
sym_list[1:5]

# Reverse mapping (e.g., Symbols to Probes)
# Note: Use the specific ALIAS2PROBE object for non-official symbols
alias_map <- as.list(mogene10stprobesetALIAS2PROBE)
```

## Database Connection Information
To inspect the underlying SQLite database or check metadata:
```r
# Get database metadata
mogene10stprobeset_dbInfo()

# Get the database schema
mogene10stprobeset_dbschema()

# Get the organism for which this package was built
mogene10stprobesetORGANISM
```

## Tips
- **Many-to-One Mappings**: Be aware that one probe ID may map to multiple GO terms or pathways; `select()` will return a data.frame with multiple rows for that probe.
- **Official vs. Alias**: Use `SYMBOL` for official gene symbols and `ALIAS` (via `mogene10stprobesetALIAS2PROBE`) if you are searching using common names or synonyms.
- **Package Updates**: This package is updated biannually by Bioconductor; ensure your version matches your experimental data's annotation vintage.

## Reference documentation
- [mogene10stprobeset.db](./references/reference_manual.md)