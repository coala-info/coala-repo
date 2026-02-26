---
name: bioconductor-hgu133a2.db
description: This package provides annotation data for the Affymetrix Human Genome U133A 2.0 Array. Use when user asks to map probe identifiers to gene symbols, Entrez IDs, GO terms, or other genomic metadata.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133a2.db.html
---


# bioconductor-hgu133a2.db

name: bioconductor-hgu133a2.db
description: Annotation data for the Affymetrix Human Genome U133A 2.0 Array. Use when needing to map manufacturer probe identifiers to biological identifiers like Entrez Gene IDs, Gene Symbols, GO terms, or KEGG pathways in R.

# bioconductor-hgu133a2.db

## Overview
The `hgu133a2.db` package is a Bioconductor annotation hub for the Affymetrix Human Genome U133A 2.0 Array. It provides a SQLite-based interface to map probe set IDs to various genomic metadata. It is primarily used in transcriptomics workflows to annotate differential expression results.

## Core Workflow

### 1. Installation and Loading
Install the package using `BiocManager` and load it into the R session.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("hgu133a2.db")

library(hgu133a2.db)
```

### 2. Discovering Available Data
Use the `AnnotationDbi` interface to explore the types of data available within the package.

```r
# View available columns (data types)
columns(hgu133a2.db)

# View available keytypes (usually PROBEID)
keytypes(hgu133a2.db)

# Get a sample of keys (probe IDs)
head(keys(hgu133a2.db, keytype="PROBEID"))
```

### 3. Mapping Identifiers
The `select()` function is the standard way to retrieve data in a tabular format.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("200000_s_at", "200001_at", "200002_at")
res <- select(hgu133a2.db, 
              keys = probes, 
              columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
              keytype = "PROBEID")
```

For a simple 1-to-1 mapping returned as a named vector, use `mapIds()`:

```r
# Get Gene Symbols for probes
symbols <- mapIds(hgu133a2.db, 
                  keys = probes, 
                  column = "SYMBOL", 
                  keytype = "PROBEID", 
                  multiVals = "first")
```

## Common Annotation Mappings
- **SYMBOL**: Official Gene Symbol.
- **ENTREZID**: Entrez Gene Identifier.
- **GENENAME**: Full Gene Name.
- **ENSEMBL**: Ensembl Gene Accession.
- **GO**: Gene Ontology identifiers and evidence codes.
- **PATH**: KEGG Pathway identifiers.
- **REFSEQ**: RefSeq identifiers.
- **MAP**: Cytogenetic band location.

## Legacy Bimap Interface
While `select()` is preferred, you can still use the Bimap interface for specific mappings or to convert the entire map to a list.

```r
# Convert Symbol map to a list
sym_list <- as.list(hgu133a2SYMBOL)

# Get probes mapped to a specific chromosome
chr1_probes <- as.list(hgu133a2CHR[["1"]])
```

## Database Information
To inspect the underlying SQLite database or schema:

```r
# Get database connection
conn <- hgu133a2_dbconn()

# Show database schema
hgu133a2_dbschema()

# Get summary info
hgu133a2_dbInfo()
```

## Reference documentation
- [hgu133a2.db Reference Manual](./references/reference_manual.md)