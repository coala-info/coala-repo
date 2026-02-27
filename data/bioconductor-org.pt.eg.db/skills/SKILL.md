---
name: bioconductor-org.pt.eg.db
description: This Bioconductor package provides genome-wide annotations for Chimpanzee by mapping Entrez Gene identifiers to various biological identifiers and functional data. Use when user asks to map gene symbols to Entrez or Ensembl IDs, retrieve Gene Ontology terms and KEGG pathways, or find genomic locations for Chimpanzee genes.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Pt.eg.db.html
---


# bioconductor-org.pt.eg.db

## Overview

The `org.Pt.eg.db` package is a Bioconductor organism-level annotation package for *Pan troglodytes* (Chimpanzee). It provides a central hub for mapping Entrez Gene identifiers to various other biological identifiers and annotations. The primary interface for interacting with this data is the `select()` method from the `AnnotationDbi` package, though "Bimap" objects are also available for specific mappings.

## Core Workflows

### 1. Discovery and Inspection
Before querying, identify what data types (columns) and identifier types (keys) are available.

```r
library(org.Pt.eg.db)

# List available annotation types
columns(org.Pt.eg.db)

# List available key types (types of IDs you can use as input)
keytypes(org.Pt.eg.db)

# Get the organism name
org.Pt.egORGANISM
```

### 2. Mapping Identifiers using select()
The `select()` function is the recommended way to retrieve data. It requires the database object, the input keys, the desired columns, and the type of the input keys.

```r
# Example: Map Gene Symbols to Entrez IDs and Ensembl IDs
genes <- c("PANTR", "SREBF1", "APOE")
select(org.Pt.eg.db, 
       keys = genes, 
       columns = c("ENTREZID", "ENSEMBL", "GENENAME"), 
       keytype = "SYMBOL")
```

### 3. Functional Annotation
Retrieve Gene Ontology (GO) terms or KEGG pathways for specific genes.

```r
# Get GO terms for a set of Entrez IDs
select(org.Pt.eg.db, 
       keys = c("450123", "450124"), 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "ENTREZID")

# Get KEGG Pathway IDs
select(org.Pt.eg.db, 
       keys = "APOE", 
       columns = "PATH", 
       keytype = "SYMBOL")
```

### 4. Genomic Locations
Find where genes are located on the Chimpanzee genome.

```r
# Get chromosome and start position
select(org.Pt.eg.db, 
       keys = "SREBF1", 
       columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
       keytype = "SYMBOL")

# Get chromosome lengths
tt <- org.Pt.egCHRLENGTHS
tt["1"] # Length of chromosome 1
```

## Key Mapping Objects (Bimaps)

While `select()` is preferred, specific Bimap objects can be used for quick lookups or list conversions:

- `org.Pt.egSYMBOL`: Entrez ID to Official Gene Symbol.
- `org.Pt.egALIAS2EG`: Common aliases to Entrez ID.
- `org.Pt.egENSEMBL`: Entrez ID to Ensembl Gene ID.
- `org.Pt.egUNIPROT`: Entrez ID to Uniprot Accession.
- `org.Pt.egREFSEQ`: Entrez ID to RefSeq ID.
- `org.Pt.egGO`: Entrez ID to Gene Ontology.
- `org.Pt.egPATH`: Entrez ID to KEGG Pathway.

Example of Bimap usage:
```r
# Convert Symbol to Entrez ID list
sym_to_eg <- as.list(org.Pt.egSYMBOL2EG)
sym_to_eg[["APOE"]]
```

## Tips and Best Practices
- **Redundancy**: Gene symbols can be redundant. When mapping from `ALIAS`, verify results by mapping back to `ENTREZID` or `SYMBOL`.
- **Evidence Codes**: When retrieving GO annotations, use the `EVIDENCE` column to filter by the quality of the annotation (e.g., IDA for direct assay, IEA for electronic annotation).
- **Database Connection**: Use `org.Pt.eg_dbconn()` to get a DBI connection if you need to perform direct SQL queries on the underlying SQLite database. Do not call `dbDisconnect()` on this object.

## Reference documentation
- [org.Pt.eg.db Reference Manual](./references/reference_manual.md)