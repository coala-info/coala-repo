---
name: bioconductor-mta10probeset.db
description: This package provides annotation data for the Affymetrix Mouse Transcriptome Array 1.0 to map probeset identifiers to biological metadata. Use when user asks to map mouse probeset IDs to gene symbols, Entrez IDs, Ensembl accessions, genomic locations, or functional annotations like GO and KEGG terms.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mta10probeset.db.html
---


# bioconductor-mta10probeset.db

name: bioconductor-mta10probeset.db
description: Annotation data for the Mouse Transcriptome Array 1.0 (MTA 1.0) probesets. Use this skill to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Ensembl, SYMBOL, GO, KEGG) and genomic locations for mouse transcriptomics data analysis.

## Overview

The `mta10probeset.db` package is a Bioconductor annotation data package for the Affymetrix Mouse Transcriptome Array 1.0. It provides a SQLite-based interface to map probeset IDs to gene-centric information. While it supports the older "Bimap" interface, the modern `select()` interface from the `AnnotationDbi` package is the preferred method for querying this data.

## Core Workflows

### Loading the Package
```r
library(mta10probeset.db)
```

### Using the select() Interface
The `select()` function is the primary way to retrieve data. You need to specify the keys (probe IDs), the columns you want to retrieve, and the keytype (usually "PROBEID").

```r
# View available columns
columns(mta10probeset.db)

# View available keytypes
keytypes(mta10probeset.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("17210896", "17210899", "17210903")
select(mta10probeset.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

#### Mapping to Gene Symbols and Names
Use the `SYMBOL` and `GENENAME` columns to get human-readable identifiers.
```r
select(mta10probeset.db, keys = probes, columns = "SYMBOL", keytype = "PROBEID")
```

#### Mapping to Genomic Locations
Retrieve chromosome (`CHR`), start position (`CHRLOC`), and end position (`CHRLOCEND`). Note that antisense strand locations are represented by negative values.
```r
select(mta10probeset.db, keys = probes, columns = c("CHR", "CHRLOC"), keytype = "PROBEID")
```

#### Mapping to Functional Annotations
- **GO**: Gene Ontology terms (includes `GOID`, `ONTOLOGY`, and `EVIDENCE`).
- **PATH**: KEGG pathway identifiers.
- **ENSEMBL**: Ensembl gene accession numbers.

```r
# Get GO terms for specific probes
select(mta10probeset.db, keys = probes, columns = "GO", keytype = "PROBEID")
```

### Using the Bimap Interface (Legacy)
For specific tasks, you might use the older Bimap objects directly.
```r
# Get all mapped probe IDs for Accession Numbers
x <- mta10probesetACCNUM
mapped_probes <- mappedkeys(x)
as.list(x[mapped_probes][1:5])
```

### Database Metadata
To get information about the underlying database schema or connection:
```r
mta10probeset_dbconn()    # Get the DBI connection object
mta10probeset_dbschema()  # Print the database schema
mta10probeset_dbInfo()    # Print package metadata
```

## Tips and Best Practices
- **One-to-Many Mappings**: Be aware that a single probeset ID can sometimes map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
- **Filtering GO Terms**: When querying GO terms, you may want to filter by the `EVIDENCE` column to exclude electronic annotations (IEA) if high-confidence mappings are required.
- **Organism Context**: This package is specifically for *Mus musculus*. You can verify this programmatically using `mta10probesetORGANISM`.

## Reference documentation
- [mta10probeset.db](./references/reference_manual.md)