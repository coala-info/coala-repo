---
name: bioconductor-huex10sttranscriptcluster.db
description: This package provides Bioconductor annotation data for the Affymetrix Human Exon 1.0 ST GeneChip at the transcript cluster level. Use when user asks to map manufacturer probe identifiers to biological annotations, retrieve gene symbols, or find functional data like GO terms and KEGG pathways for this specific array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/huex10sttranscriptcluster.db.html
---


# bioconductor-huex10sttranscriptcluster.db

name: bioconductor-huex10sttranscriptcluster.db
description: Bioconductor annotation data for the Affymetrix Human Exon 1.0 ST GeneChip (transcript cluster level). Use this skill to map manufacturer probe identifiers to various biological annotations such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations.

## Overview

The `huex10sttranscriptcluster.db` package is a Bioconductor annotation data package for the Affymetrix Human Exon 1.0 ST array, specifically for transcript cluster identifiers. It provides an SQLite-based interface to map these identifiers to genomic, functional, and bibliographic data.

## Core Workflows

### Loading the Package
```r
library(huex10sttranscriptcluster.db)
```

### Using the select() Interface
The recommended way to interact with this package is via the `select()`, `keys()`, and `columns()` functions from the `AnnotationDbi` package.

```r
# List available columns for mapping
columns(huex10sttranscriptcluster.db)

# List available key types (usually PROBEID)
keytypes(huex10sttranscriptcluster.db)

# Retrieve specific annotations for a set of probe IDs
probes <- c("2315100", "2315106", "2315113")
select(huex10sttranscriptcluster.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mappings

- **Gene Symbols and Names**: Map probe IDs to official gene symbols (`SYMBOL`) or full names (`GENENAME`).
- **External Database IDs**: Map to `ENTREZID`, `ENSEMBL`, `REFSEQ`, `UNIPROT`, or `OMIM`.
- **Functional Annotation**: Map to Gene Ontology (`GO`) or KEGG pathways (`PATH`).
- **Genomic Location**: Map to chromosomes (`CHR`), cytobands (`MAP`), or specific base-pair starts (`CHRLOC`) and ends (`CHRLOCEND`).

### Using the Bimap Interface (Legacy)
While `select()` is preferred, you can use the legacy Bimap objects for specific list-based operations.

```r
# Map probes to Gene Symbols
x <- huex10sttranscriptclusterSYMBOL
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes])

# Access first few mappings
xx[1:5]
```

### Reverse Mappings
Many maps have reverse counterparts (e.g., mapping Gene Symbols back to Probes).

```r
# Map Symbols to Probes
ann_map <- as.list(huex10sttranscriptclusterALIAS2PROBE)
ann_map["TP53"]
```

## Database Connection Information
To query the underlying SQLite database directly or check metadata:

```r
# Get database connection
conn <- huex10sttranscriptcluster_dbconn()

# Show database schema
huex10sttranscriptcluster_dbschema()

# Get number of rows in the probes table
library(DBI)
dbGetQuery(conn, "SELECT COUNT(*) FROM probes")
```

## Tips
- **Transcript vs. Probeset**: This package is specifically for "transcript cluster" level identifiers. Ensure your data matches this level of summarization.
- **Evidence Codes**: When mapping to GO terms, the `EVIDENCE` column indicates the type of support (e.g., IDA, IEA, TAS).
- **Multiple Mappings**: Some probes may map to multiple genes or locations. `select()` will return a data frame with all possible combinations.

## Reference documentation

- [huex10sttranscriptcluster.db Reference Manual](./references/reference_manual.md)