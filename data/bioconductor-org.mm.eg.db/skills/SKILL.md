---
name: bioconductor-org.mm.eg.db
description: This package provides genome-wide annotations and identifier mappings for Mouse (Mus musculus) in R. Use when user asks to map between mouse gene identifiers like Entrez, Symbol, and Ensembl, or retrieve Gene Ontology terms, KEGG pathways, and chromosomal locations for mouse genes.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Mm.eg.db.html
---

# bioconductor-org.mm.eg.db

name: bioconductor-org.mm.eg.db
description: Genome-wide annotation for Mouse (Mus musculus) using Entrez Gene identifiers. Use this skill when you need to map between different mouse gene identifiers (Entrez, Symbol, Ensembl, RefSeq, Uniprot), retrieve Gene Ontology (GO) terms, KEGG pathways, or chromosomal locations for mouse genes in R.

# bioconductor-org.mm.eg.db

## Overview
The `org.Mm.eg.db` package is a Bioconductor "org" (organism) package that provides comprehensive mapping data for Mouse (Mus musculus). It is primarily centered around Entrez Gene identifiers (EG), serving as a central hub to link various database identifiers and biological metadata.

## Core Workflows

### Loading the Package
```R
library(org.Mm.eg.db)
```

### Using the select() Interface
The modern and recommended way to interact with the database is using the `select()` function from the `AnnotationDbi` package.

1.  **Check available keys and columns:**
    ```R
    # See what types of IDs you can use as input
    keytypes(org.Mm.eg.db)

    # See what data types you can retrieve
    columns(org.Mm.eg.db)
    ```

2.  **Perform a mapping:**
    ```R
    # Map Gene Symbols to Entrez IDs and Ensembl IDs
    genes <- c("Sox2", "Pax6", "Nanog")
    select(org.Mm.eg.db, 
           keys = genes, 
           columns = c("ENTREZID", "ENSEMBL", "GENENAME"), 
           keytype = "SYMBOL")
    ```

### Common Identifier Mappings
- **SYMBOL**: Official gene symbols (e.g., "Sox2").
- **ALIAS**: Common aliases or synonyms.
- **ENSEMBL**: Ensembl gene accession numbers.
- **UNIPROT**: UniProt protein identifiers.
- **REFSEQ**: RefSeq identifiers.
- **MGI**: Mouse Genome Informatics accession numbers.

### Retrieving Biological Metadata
- **GO**: Gene Ontology terms (includes Evidence codes and Ontology branch: BP, CC, MF).
- **PATH**: KEGG pathway identifiers.
- **CHR**: Chromosome assignment.
- **CHRLOC/CHRLOCEND**: Chromosomal start and end positions.

### Legacy Bimap Interface
While `select()` is preferred, you can access specific maps directly for list-based operations:
```R
# Get all Entrez IDs mapped to Symbols
x <- org.Mm.egSYMBOL
mapped_genes <- mappedkeys(x)
xx <- as.list(x[mapped_genes])

# Reverse mapping (e.g., Symbol to Entrez)
rev_map <- as.list(org.Mm.egSYMBOL2EG)
```

## Tips and Best Practices
- **Redundancy**: Gene symbols can be redundant. When mapping from `ALIAS`, one symbol may return multiple Entrez IDs. Always verify results.
- **GO Evidence**: When retrieving GO terms, pay attention to the `EVIDENCE` column (e.g., IDA, IEA, TAS) to understand the quality of the annotation.
- **GO2ALLEGS**: Use `org.Mm.egGO2ALLEGS` if you want to find all genes associated with a GO term *including* its child nodes in the ontology.
- **Database Connection**: Use `org.Mm.eg_dbconn()` to get a DBI connection if you need to perform direct SQL queries on the underlying SQLite database.

## Reference documentation
- [org.Mm.eg.db](./references/reference_manual.md)