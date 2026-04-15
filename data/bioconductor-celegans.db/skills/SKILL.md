---
name: bioconductor-celegans.db
description: This package provides a comprehensive annotation database for C. elegans to map between various biological identifiers and functional information. Use when user asks to translate gene IDs, retrieve Gene Ontology terms, map KEGG pathways, or find genomic locations for C. elegans data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/celegans.db.html
---

# bioconductor-celegans.db

## Overview

The `celegans.db` package is a comprehensive annotation database for C. elegans. It is primarily used to translate between different biological identifiers and to annotate experimental results (like RNA-seq or microarray data) with functional information. It utilizes the `AnnotationDbi` interface, allowing for efficient querying via the `select()` function.

## Core Workflows

### Loading the Package
```r
library(celegans.db)
```

### Exploring Available Data
To see which types of identifiers and annotations can be retrieved:
```r
columns(celegans.db)
# Common columns: ENSEMBL, ENTREZID, SYMBOL, GENENAME, GO, PATH, WORMBASE
```

To see the types of input keys you can use:
```r
keytypes(celegans.db)
```

### Querying the Database (Recommended)
The `select()` function is the standard way to extract data. It requires the database object, the keys (input IDs), the columns (desired information), and the keytype (type of input IDs).

```r
# Example: Map Gene Symbols to Ensembl IDs and Chromosomes
genes <- c("lin-35", "daf-16", "let-60")
select(celegans.db, 
       keys = genes, 
       columns = c("ENSEMBL", "CHR", "GENENAME"), 
       keytype = "SYMBOL")
```

### Mapping Identifiers
The package supports various mapping directions:
- **Accession Numbers**: `celegansACCNUM`
- **Ensembl**: `celegansENSEMBL`
- **Entrez ID**: `celegansENTREZID`
- **RefSeq**: `celegansREFSEQ`
- **UniProt**: `celegansUNIPROT`
- **Wormbase**: `celegansWORMBASE`

### Functional Annotation
- **Gene Ontology (GO)**: Retrieve GO IDs, Evidence codes, and Ontologies (BP, CC, MF).
  ```r
  select(celegans.db, keys = "daf-16", columns = "GO", keytype = "SYMBOL")
  ```
- **KEGG Pathways**: Map genes to metabolic or signaling pathways.
  ```r
  select(celegans.db, keys = "175410", columns = "PATH", keytype = "ENTREZID")
  ```

### Genomic Location
- **Chromosomes**: `celegansCHR`
- **Chromosomal Location**: `celegansCHRLOC` (start) and `celegansCHRLOCEND` (end). Negative values indicate the antisense strand.
- **Chromosome Lengths**: `celegansCHRLENGTHS`

## Legacy Bimap Interface
While `select()` is preferred, you can access specific maps directly using the "Bimap" interface for quick lookups or list conversions.

```r
# Convert a map to a list
sym_list <- as.list(celegansSYMBOL)
# Get symbols for specific probe IDs
sym_list[c("175410_at", "175411_at")]
```

## Database Connection Info
To inspect the underlying SQLite database metadata:
```r
celegans_dbconn()   # Get DB connection
celegans_dbschema() # View table schemas
celegans_dbInfo()   # View data source and date stamps
```

## Reference documentation
- [celegans.db Reference Manual](./references/reference_manual.md)