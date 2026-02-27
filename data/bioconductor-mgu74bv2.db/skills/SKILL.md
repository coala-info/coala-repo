---
name: bioconductor-mgu74bv2.db
description: This package provides SQLite-based annotation data for the Affymetrix Murine Genome U74v2 array. Use when user asks to map probe set IDs to gene symbols, Entrez IDs, Gene Ontology terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74bv2.db.html
---


# bioconductor-mgu74bv2.db

## Overview

The `mgu74bv2.db` package is a Bioconductor annotation data package for the Affymetrix Murine Genome U74v2 array. It provides an SQLite-based interface to map probe set IDs to genomic, functional, and publication-related information. The primary way to interact with this package is through the `AnnotationDbi` interface (`select()`, `keys()`, `columns()`) or via legacy Bimap objects.

## Core Workflows

### Loading the Package
```r
library(mgu74bv2.db)
```

### Using the Select Interface
The `select()` function is the recommended method for retrieving data.

```r
# List available columns (types of data)
columns(mgu74bv2.db)

# List available keytypes (usually PROBEID)
keytypes(mgu74bv2.db)

# Retrieve specific annotations for a set of probes
probes <- c("92201_at", "92202_at", "92203_at")
results <- select(mgu74bv2.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols and Names**: Map probes to official gene symbols (`SYMBOL`) or descriptive names (`GENENAME`).
*   **Entrez IDs**: Map probes to NCBI Entrez Gene identifiers (`ENTREZID`).
*   **Gene Ontology (GO)**: Retrieve GO terms and evidence codes (`GO`).
*   **Pathways**: Map probes to KEGG pathway identifiers (`PATH`).
*   **Chromosomal Location**: Find the chromosome (`CHR`) or specific base pair start/end positions (`CHRLOC`, `CHRLOCEND`).
*   **External Accessions**: Map to RefSeq (`REFSEQ`), Ensembl (`ENSEMBL`), Uniprot (`UNIPROT`), or MGI (`MGI`) identifiers.

### Using the Bimap Interface (Legacy)
While `select()` is preferred, Bimap objects allow for list-like access.

```r
# Convert a map to a list
symbol_list <- as.list(mgu74bv2SYMBOL)

# Get probes for a specific symbol (Reverse Map)
alias_to_probe <- as.list(mgu74bv2ALIAS2PROBE)
probes_for_gene <- alias_to_probe[["Akt1"]]
```

### Database Metadata
You can inspect the underlying database schema and connection information:
```r
mgu74bv2_dbschema()
mgu74bv2_dbInfo()
```

## Tips and Best Practices
*   **Multiple Mappings**: Some probes map to multiple genes or GO terms. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
*   **Evidence Codes**: When retrieving GO terms, pay attention to the `EVIDENCE` column to understand the quality of the annotation (e.g., IDA = Inferred from Direct Assay, IEA = Inferred from Electronic Annotation).
*   **Package Updates**: This package is updated biannually by Bioconductor; ensure you are using the version corresponding to your Bioconductor release for the most current mappings.

## Reference documentation
- [mgu74bv2.db Reference Manual](./references/reference_manual.md)