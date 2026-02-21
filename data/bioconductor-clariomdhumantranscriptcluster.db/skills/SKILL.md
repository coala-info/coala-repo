---
name: bioconductor-clariomdhumantranscriptcluster.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/clariomdhumantranscriptcluster.db.html
---

# bioconductor-clariomdhumantranscriptcluster.db

name: bioconductor-clariomdhumantranscriptcluster.db
description: Use this skill when working with the Bioconductor annotation package clariomdhumantranscriptcluster.db. This is essential for mapping manufacturer probe identifiers from the Affymetrix Clariom D Human Transcript Cluster array to biological metadata such as Entrez Gene IDs, Gene Symbols, Ensembl IDs, GO terms, and KEGG pathways.

## Overview

The `clariomdhumantranscriptcluster.db` package is a genome-wide annotation interface for the Clariom D Human platform. It uses an SQLite database to provide mappings between manufacturer-specific identifiers and various public identifiers. While it supports older "Bimap" interfaces, the modern recommended approach is using the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Database
To begin, load the package. The database object itself shares the package name.

```r
library(clariomdhumantranscriptcluster.db)
# View available annotation types
columns(clariomdhumantranscriptcluster.db)
# View available key types (usually PROBEID)
keytypes(clariomdhumantranscriptcluster.db)
```

### Using the select() Interface
The `select()` function is the primary way to retrieve data. It requires the database object, the input keys, the columns you want to retrieve, and the keytype of the input.

```r
# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("16650001", "16650007", "16650011")
results <- select(clariomdhumantranscriptcluster.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Mapping Gene Aliases to Probes
If you have gene symbols or aliases and need to find the corresponding probes on the Clariom D array:

```r
# Map gene symbols back to probe identifiers
gene_symbols <- c("TP53", "BRCA1")
probe_mappings <- select(clariomdhumantranscriptcluster.db, 
                         keys = gene_symbols, 
                         columns = "PROBEID", 
                         keytype = "SYMBOL")
```

### Accessing Specific Annotations
The package contains several specific mapping objects (Bimaps). Common ones include:

*   `clariomdhumantranscriptclusterENTREZID`: Map to Entrez Gene identifiers.
*   `clariomdhumantranscriptclusterSYMBOL`: Map to official Gene Symbols.
*   `clariomdhumantranscriptclusterENSEMBL`: Map to Ensembl Gene accessions.
*   `clariomdhumantranscriptclusterGO`: Map to Gene Ontology (GO) identifiers (includes Evidence and Ontology category).
*   `clariomdhumantranscriptclusterPATH`: Map to KEGG Pathway identifiers.
*   `clariomdhumantranscriptclusterCHR`: Map to Chromosomes.

### Database Metadata
To check versioning or source data information:

```r
clariomdhumantranscriptcluster_dbInfo()
# Or get the underlying SQLite connection
conn <- clariomdhumantranscriptcluster_dbconn()
```

## Tips
*   **Multiple Mappings**: Some probes may map to multiple genes, and some genes may map to multiple GO terms. The `select()` function returns a data.frame that may have more rows than the input key vector to account for these 1-to-many relationships.
*   **Defunct Interfaces**: The Bimap interface for PFAM and PROSITE is defunct; always use `select()` for these specific identifiers.
*   **Filtering GO Terms**: When retrieving GO terms, you can filter the results in R based on the `ONTOLOGY` (BP, CC, MF) or `EVIDENCE` codes (e.g., IDA, TAS, IEA).

## Reference documentation
- [clariomdhumantranscriptcluster.db Reference Manual](./references/reference_manual.md)