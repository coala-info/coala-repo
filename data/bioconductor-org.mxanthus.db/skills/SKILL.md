---
name: bioconductor-org.mxanthus.db
description: This package provides genome-wide functional annotations and identifier mapping for the bacterium *Myxococcus xanthus* DK 1622. Use when user asks to map gene identifiers, retrieve functional annotations, translate historical locus tags to current RefSeq IDs, or perform GO enrichment analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Mxanthus.db.html
---

# bioconductor-org.mxanthus.db

## Overview

The `org.Mxanthus.db` package is a Bioconductor OrgDb annotation package for the bacterium *Myxococcus xanthus* DK 1622. It provides a comprehensive mapping between various gene identifiers and functional annotations. A key feature of this package is its ability to map "Old Locus Tags" (MXAN prefix) used in historical research to the current NCBI/RefSeq identifiers (MXAN_RS prefix).

## Core Workflows

### Loading the Database
```r
library(org.Mxanthus.db)
# View available fields/columns
columns(org.Mxanthus.db)
# View available key types for searching
keytypes(org.Mxanthus.db)
```

### Identifier Mapping and Data Retrieval
Use the `select()` function to translate between different ID types. Supported keys include `SYMBOL`, `UNIPROT`, `LOCUS_TAG`, `OLD_MXAN`, and `GO`.

```r
# Map a GID to Symbol, Uniprot, and Name
select(org.Mxanthus.db, 
       keys = "7179", 
       columns = c("SYMBOL", "UNIPROT", "NAME"), 
       keytype = "GID")

# Map current Symbols to Old Locus Tags (MXAN IDs)
select(org.Mxanthus.db, 
       keys = "MXAN_RS14035", 
       columns = "OLD_MXAN", 
       keytype = "SYMBOL")
```

### SQL-Based Queries
For complex filtering or bulk data extraction, use the underlying SQLite connection.

```r
library(DBI)
conn <- dbconn(org.Mxanthus.db)

# List all genes and their descriptions
gene_info <- dbGetQuery(conn, "SELECT SYMBOL, NAME, OLD_MXAN FROM gene_info")

# Filter GO terms by ontology (e.g., Biological Process 'BP')
bp_go <- dbGetQuery(conn, "SELECT * FROM go WHERE ONTOLOGY = 'BP'")
```

### Integration with clusterProfiler
The package is designed to work seamlessly with `clusterProfiler` for functional analysis.

```r
library(clusterProfiler)

# Convert a list of symbols to Old Locus Tags
mapped_ids <- bitr(my_gene_list, 
                   fromType = "SYMBOL", 
                   toType = "OLD_MXAN", 
                   OrgDb = org.Mxanthus.db)

# Perform GO Enrichment Analysis (BP = Biological Process)
ego <- enrichGO(gene          = my_gene_list,
                universe      = all_symbols_in_genome,
                keyType       = "SYMBOL",
                OrgDb         = org.Mxanthus.db,
                ont           = "BP",
                pAdjustMethod = "BH",
                pvalueCutoff  = 0.05)
```

## Key Columns and Identifiers
- **GID**: Internal Entrez-like Gene ID (Primary Key).
- **SYMBOL**: Current NCBI Locus Tag (e.g., MXAN_RS14035).
- **OLD_MXAN**: Historical Locus Tag (e.g., MXAN_2898).
- **NAME**: Functional description of the gene product.
- **GO/ONTOLOGY**: Gene Ontology terms and categories (BP, MF, CC).

## Reference documentation
- [Genome wide annotation for Myxococcus xanthus DK 1622](./references/org.Mxanthus.db.md)