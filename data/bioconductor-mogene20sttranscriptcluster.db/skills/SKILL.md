---
name: bioconductor-mogene20sttranscriptcluster.db
description: This package provides SQLite-based genomic and functional annotations for the Affymetrix Mouse Gene 2.0 ST array. Use when user asks to map transcript cluster identifiers to gene symbols, Entrez IDs, Ensembl accessions, or Gene Ontology terms.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mogene20sttranscriptcluster.db.html
---

# bioconductor-mogene20sttranscriptcluster.db

## Overview

The `mogene20sttranscriptcluster.db` package is a Bioconductor annotation data package for the Affymetrix Mouse Gene 2.0 ST array. It provides a SQLite-based interface to map transcript cluster identifiers to various genomic and functional annotations. The primary way to interact with this data is through the `AnnotationDbi` interface (`select()`, `keys()`, `columns()`) or via the legacy Bimap interface.

## Core Workflows

### Loading the Package
```r
library(mogene20sttranscriptcluster.db)
```

### Exploring Available Data
To see what types of data can be retrieved:
```r
# List available columns (mapping targets)
columns(mogene20sttranscriptcluster.db)

# List available key types (usually PROBEID)
keytypes(mogene20sttranscriptcluster.db)

# Get a sample of probe identifiers
head(keys(mogene20sttranscriptcluster.db))
```

### Using the select() Interface
The `select()` function is the recommended method for retrieving data.
```r
# Map specific probe IDs to Gene Symbols and Entrez IDs
probes <- c("16737477", "16737481", "16737483")
results <- select(mogene20sttranscriptcluster.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mapping Targets
- **SYMBOL**: Official Gene Symbol
- **ENTREZID**: Entrez Gene Identifier
- **ENSEMBL**: Ensembl Gene Accession
- **GENENAME**: Full Gene Name
- **GO**: Gene Ontology identifiers, evidence codes, and ontologies (BP, CC, MF)
- **PATH**: KEGG Pathway identifiers
- **CHR/CHRLOC**: Chromosome and start/end positions

### Legacy Bimap Interface
While `select()` is preferred, you can use the Bimap objects for specific list-based operations.
```r
# Convert a specific map to a list
sym_map <- as.list(mogene20sttranscriptclusterSYMBOL)
# Access a specific probe
sym_map[["16737477"]]

# Reverse mapping (e.g., Symbols to Probes)
alias_to_probe <- as.list(mogene20sttranscriptclusterALIAS2PROBE)
```

### Database Connection Information
To inspect the underlying database metadata:
```r
mogene20sttranscriptcluster_dbInfo()
mogene20sttranscriptcluster_dbschema()
```

## Tips and Best Practices
- **One-to-Many Mappings**: Be aware that some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with multiple rows for these cases.
- **Filtering GO Terms**: When mapping to GO, the results include evidence codes (e.g., IDA, IEA). Filter these if you only want high-confidence experimental annotations.
- **Organism Context**: This package is specific to *Mus musculus*. For general gene-centric mouse data, it depends on the `org.Mm.eg.db` package.

## Reference documentation
- [reference_manual.md](./references/reference_manual.md)