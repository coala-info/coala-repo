---
name: bioconductor-lumiratall.db
description: This package provides SQLite-based annotation mappings between Illumina Rat expression platform probe identifiers and various public gene identifiers. Use when user asks to map Illumina Rat probes to gene symbols, Entrez IDs, Gene Ontology terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/lumiRatAll.db.html
---

# bioconductor-lumiratall.db

## Overview

The `lumiRatAll.db` package is a Bioconductor annotation data package specifically for the Illumina Rat expression platform. It functions as an SQLite-based environment providing mappings between manufacturer probe IDs and various public identifiers. This is essential for downstream bioinformatics analysis, such as functional enrichment or genomic localization of differentially expressed genes.

## Core Usage

### Loading the Package
```R
library(lumiRatAll.db)
# List all available mapping objects in the package
ls("package:lumiRatAll.db")
```

### Basic Mapping Workflow
Most objects in this package are used by converting them to a list or using the `select()` interface from `AnnotationDbi`.

**Example: Mapping Probes to Gene Symbols**
```R
# Get the mapping object
x <- lumiRatAllSYMBOL
# Get probe IDs that have a mapping
mapped_probes <- mappedkeys(x)
# Convert to a list for lookup
probe_to_symbol <- as.list(x[mapped_probes])

# Access specific probe
probe_to_symbol[["10001"]] 
```

### Common Annotation Objects
- `lumiRatAllENTREZID`: Maps probes to Entrez Gene identifiers.
- `lumiRatAllSYMBOL`: Maps probes to official Gene Symbols.
- `lumiRatAllGENENAME`: Maps probes to full Gene Names.
- `lumiRatAllGO`: Maps probes to Gene Ontology (GO) terms (includes Evidence and Ontology codes).
- `lumiRatAllPATH`: Maps probes to KEGG pathway identifiers.
- `lumiRatAllACCNUM`: Maps probes to GenBank accession numbers.

### Reverse Mappings
Many objects have a reverse mapping (e.g., finding probes associated with a specific GO term or Gene Symbol).
```R
# Find probes associated with a specific Gene Alias
alias_map <- as.list(lumiRatAllALIAS2PROBE)
probes_for_alias <- alias_map[["MyGeneAlias"]]
```

### Genomic Location and Chromosomes
- `lumiRatAllCHR`: Identifies the chromosome.
- `lumiRatAllCHRLOC`: Identifies the starting base pair (negative values indicate the antisense strand).
- `lumiRatAllCHRLENGTHS`: Provides the total length of each chromosome.

## Advanced Queries

### Using AnnotationDbi Select
For a more modern approach, use the `select` function:
```R
columns(lumiRatAll.db) # See available fields
keys <- head(keys(lumiRatAll.db)) # Get sample probe IDs
select(lumiRatAll.db, keys = keys, columns = c("SYMBOL", "ENTREZID", "PATH"), keytype = "PROBEID")
```

### Database Connection Info
To inspect the underlying SQLite database metadata:
```R
lumiRatAll_dbconn()   # Get the DB connection object
lumiRatAll_dbInfo()   # Display package metadata (source dates, etc.)
lumiRatAll_dbschema() # View the SQL schema
```

## Tips
- **Map Counts**: Use `lumiRatAllMAPCOUNTS` to verify the number of probes mapped for each attribute.
- **Evidence Codes**: When working with `lumiRatAllGO`, remember that results include evidence codes (e.g., TAS, IDA, IEA). Filter these if you require high-confidence experimental annotations only.
- **Biannual Updates**: This package is updated twice a year; always check `lumiRatAll_dbInfo()` to ensure the source data (NCBI, UniProt, etc.) is appropriate for your analysis.

## Reference documentation
- [lumiRatAll.db Reference Manual](./references/reference_manual.md)