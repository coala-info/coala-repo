---
name: bioconductor-raex10stprobeset.db
description: This package provides annotation data for the Affymetrix Rat Exon 1.0 ST Probeset platform. Use when user asks to map manufacturer probe identifiers to biological identifiers, retrieve functional annotations like GO or KEGG terms, or access genomic metadata for Rattus norvegicus data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/raex10stprobeset.db.html
---


# bioconductor-raex10stprobeset.db

name: bioconductor-raex10stprobeset.db
description: Annotation data for the Affymetrix raex10stprobeset platform. Use this skill when you need to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbol, GO, KEGG, etc.) for Rattus norvegicus (Rat) data.

# bioconductor-raex10stprobeset.db

## Overview

The `raex10stprobeset.db` package is a Bioconductor annotation data package for the Affymetrix Rat Exon 1.0 ST Probeset platform. It provides a SQLite-based interface to map manufacturer probe IDs to genomic, functional, and publication-related metadata.

## Core Workflows

### Loading the Package
```R
library(raex10stprobeset.db)
```

### Using the select() Interface
The recommended way to interact with this package is via the `select()` function from `AnnotationDbi`.

```R
# View available columns
columns(raex10stprobeset.db)

# View available key types
keytypes(raex10stprobeset.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("6030001", "6030003", "6030005")
select(raex10stprobeset.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Using Legacy Bimap Objects
While `select()` is preferred, you can use the legacy Bimap interface for specific mappings.

```R
# Map Probes to Gene Symbols
x <- raex10stprobesetSYMBOL
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes])

# Map Probes to Chromosomes
chr_map <- as.list(raex10stprobesetCHR)

# Map Probes to KEGG Pathways
path_map <- as.list(raex10stprobesetPATH)
```

### Functional Annotation (GO/KEGG)
- `raex10stprobesetGO`: Maps probes to Gene Ontology (GO) terms (direct evidence).
- `raex10stprobesetGO2ALLPROBES`: Maps GO terms to all associated probes (including child nodes).
- `raex10stprobesetPATH`: Maps probes to KEGG pathway identifiers.

### Database Connection Information
To inspect the underlying database or schema:
```R
raex10stprobeset_dbconn()   # Get DB connection
raex10stprobeset_dbschema() # View schema
raex10stprobeset_dbInfo()   # View package metadata
```

## Tips and Best Practices
- **Multiple Mappings**: Some probes may map to multiple Entrez IDs or GO terms. `select()` will return a data frame with one row per mapping, which may result in more rows than input keys.
- **Organism Info**: This package is specifically for *Rattus norvegicus*. You can verify this using `raex10stprobesetORGANISM`.
- **Accession Numbers**: Use `raex10stprobesetACCNUM` to find GenBank accession numbers for specific probes.
- **Alias Mapping**: Use `raex10stprobesetALIAS2PROBE` to find probes associated with common gene symbols that might not be the "official" symbol.

## Reference documentation
- [raex10stprobeset.db](./references/reference_manual.md)