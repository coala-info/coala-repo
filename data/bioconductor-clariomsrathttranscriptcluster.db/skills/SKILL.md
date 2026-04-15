---
name: bioconductor-clariomsrathttranscriptcluster.db
description: This package provides Bioconductor annotation data for mapping Clariom S Rat HT transcript cluster identifiers to genomic and functional metadata. Use when user asks to map manufacturer probe IDs to Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, or chromosomal locations for Rattus norvegicus.
homepage: https://bioconductor.org/packages/release/data/annotation/html/clariomsrathttranscriptcluster.db.html
---

# bioconductor-clariomsrathttranscriptcluster.db

name: bioconductor-clariomsrathttranscriptcluster.db
description: Annotation data for the Clariom S Rat HT array (transcript cluster level). Use this skill when you need to map manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, or chromosomal locations for Rattus norvegicus.

## Overview

The `clariomsrathttranscriptcluster.db` package is a Bioconductor annotation data package for the Clariom S Rat HT platform. It provides a SQLite-based interface to map manufacturer-specific transcript cluster identifiers to various genomic and functional annotations.

## Core Usage

### Loading the Package
```R
library(clariomsrathttranscriptcluster.db)
```

### The select() Interface
The recommended way to interact with this package is via the `select()`, `keys()`, and `columns()` functions from the `AnnotationDbi` package.

```R
# List available annotation types
columns(clariomsrathttranscriptcluster.db)

# List all probe IDs (keys)
probes <- keys(clariomsrathttranscriptcluster.db)

# Map specific probes to Symbols and Entrez IDs
res <- select(clariomsrathttranscriptcluster.db, 
              keys = probes[1:10], 
              columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
              keytype = "PROBEID")
```

### Common Annotation Mappings
- **Gene Symbols**: `SYMBOL`
- **Entrez Gene Identifiers**: `ENTREZID`
- **Ensembl Gene IDs**: `ENSEMBL`
- **Gene Ontology**: `GO` (returns GO ID, Evidence code, and Ontology category)
- **KEGG Pathways**: `PATH`
- **RefSeq Accessions**: `REFSEQ`
- **Chromosomal Location**: `CHR`, `CHRLOC`, `CHRLENGTHS`

### Legacy Bimap Interface
While `select()` is preferred, you can still use the older Bimap interface for specific mappings:

```R
# Get a list of probe to Symbol mappings
x <- clariomsrathttranscriptclusterSYMBOL
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes])

# Reverse mapping (e.g., Symbol to Probe)
rev_map <- clariomsrathttranscriptclusterALIAS2PROBE
probes_for_alias <- as.list(rev_map["Tp53"])
```

## Typical Workflows

### Functional Enrichment Preparation
To prepare data for GO or KEGG enrichment analysis, map your probe list to Entrez IDs:

```R
my_probes <- c("1700001", "1700002") # Example IDs
mapping <- select(clariomsrathttranscriptcluster.db, 
                  keys = my_probes, 
                  columns = "ENTREZID", 
                  keytype = "PROBEID")
# Remove NAs before downstream analysis
entrez_ids <- mapping$ENTREZID[!is.na(mapping$ENTREZID)]
```

### Retrieving Genomic Coordinates
To find where specific transcript clusters are located on the rat genome:

```R
loc_data <- select(clariomsrathttranscriptcluster.db, 
                   keys = my_probes, 
                   columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
                   keytype = "PROBEID")
```

## Tips
- **Database Connection**: Use `clariomsrathttranscriptcluster_dbconn()` to access the underlying SQLite connection for custom SQL queries.
- **Metadata**: Use `clariomsrathttranscriptcluster_dbInfo()` to check the data source versions and build dates.
- **Multiple Mappings**: Some probes may map to multiple GO terms or Entrez IDs. `select()` will return a long-format data frame containing all matches.

## Reference documentation
- [clariomsrathttranscriptcluster.db Reference Manual](./references/reference_manual.md)