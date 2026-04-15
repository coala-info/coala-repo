---
name: bioconductor-clariomsrattranscriptcluster.db
description: This Bioconductor package provides SQLite-based annotation data for mapping Clariom S Rat Transcript Cluster probe set identifiers to biological metadata. Use when user asks to map probe IDs to gene symbols, retrieve Entrez or Ensembl identifiers, perform functional annotation with Gene Ontology terms, or identify KEGG pathways for rat transcriptomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/clariomsrattranscriptcluster.db.html
---

# bioconductor-clariomsrattranscriptcluster.db

## Overview

The `clariomsrattranscriptcluster.db` package is a Bioconductor annotation data package for the Clariom S Rat Transcript Cluster platform. It provides an SQLite-based interface to map manufacturer identifiers (probe set IDs) to various biological annotations. The primary method for interacting with this data is the `select()` interface from the `AnnotationDbi` package, though legacy "Bimap" objects are also available.

## Core Workflows

### Loading the Package and Exploring Columns

To begin, load the package and check the available annotation types (columns).

```r
library(clariomsrattranscriptcluster.db)

# List available annotation types
columns(clariomsrattranscriptcluster.db)

# List available key types (usually PROBEID)
keytypes(clariomsrattranscriptcluster.db)
```

### Using the select() Interface

The `select()` function is the recommended way to retrieve data. It requires the database object, the keys (probe IDs), the columns you want to retrieve, and the keytype.

```r
# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("17000001", "17000005", "17000009") # Example IDs
results <- select(clariomsrattranscriptcluster.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mappings

- **Gene Symbols**: Use `SYMBOL` to get official gene abbreviations.
- **Entrez Gene IDs**: Use `ENTREZID` for NCBI Gene identifiers.
- **Ensembl Accessions**: Use `ENSEMBL` for Ensembl gene IDs.
- **RefSeq**: Use `REFSEQ` for RefSeq mRNA or protein accessions.
- **Gene Ontology**: Use `GO` for functional annotations (includes Evidence and Ontology codes).
- **KEGG Pathways**: Use `PATH` for pathway identifiers.

### Reverse Mappings (Finding Probes for a Gene)

To find which probes correspond to a specific gene symbol:

```r
# Find probes for a specific gene symbol
gene_probes <- select(clariomsrattranscriptcluster.db, 
                      keys = "Tp53", 
                      columns = "PROBEID", 
                      keytype = "SYMBOL")
```

### Legacy Bimap Interface

While `select()` is preferred, you can use the older Bimap interface for specific tasks like getting all mapped keys.

```r
# Get all probe IDs that have an associated Gene Symbol
x <- clariomsrattranscriptclusterSYMBOL
mapped_probes <- mappedkeys(x)

# Convert to a list for inspection
as.list(x[mapped_probes][1:5])
```

## Tips and Best Practices

- **One-to-Many Mappings**: Be aware that some probes may map to multiple genes or GO terms. The `select()` function will return a data frame with multiple rows for these cases.
- **Organism Info**: You can programmatically check the organism using `clariomsrattranscriptclusterORGANISM`.
- **Database Connection**: If you need to perform direct SQL queries, use `clariomsrattranscriptcluster_dbconn()`.
- **Package Updates**: This package is updated biannually by Bioconductor; ensure your Bioconductor version matches your data requirements.

## Reference documentation

- [reference_manual.md](./references/reference_manual.md)