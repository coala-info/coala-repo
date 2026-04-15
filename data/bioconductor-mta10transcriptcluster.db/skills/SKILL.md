---
name: bioconductor-mta10transcriptcluster.db
description: This package provides Bioconductor annotation data for the Affymetrix Mouse Transcriptome Array 1.0. Use when user asks to map manufacturer probe identifiers to biological annotations, retrieve gene symbols, or link mouse transcriptomics data to Entrez Gene IDs and GO terms.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mta10transcriptcluster.db.html
---

# bioconductor-mta10transcriptcluster.db

name: bioconductor-mta10transcriptcluster.db
description: Bioconductor annotation data for the Affymetrix Mouse Transcriptome Array 1.0 (MTA-1.0). Use this skill to map manufacturer probe identifiers to various biological annotations (Entrez Gene IDs, Symbols, GO terms, KEGG pathways, etc.) for mouse transcriptomics data.

## Overview

The `mta10transcriptcluster.db` package is an annotation database for the Affymetrix Mouse Transcriptome Array 1.0. It provides a mapping between the manufacturer's transcript cluster identifiers and various genomic metadata. This package is built using the `AnnotationDbi` framework, which allows for efficient querying of biological relationships.

## Core Workflows

### Loading the Package
```R
library(mta10transcriptcluster.db)
```

### Querying with the select() Interface
The recommended way to interact with this package is using the `select()`, `keys()`, and `columns()` functions from the `AnnotationDbi` package.

```R
# List available annotation types (columns)
columns(mta10transcriptcluster.db)

# List the first few manufacturer identifiers (keys)
head(keys(mta10transcriptcluster.db))

# Map specific probe IDs to Gene Symbols and Entrez IDs
probes <- c("17210873", "17210877", "17210881")
select(mta10transcriptcluster.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Annotation Mappings

*   **Gene Symbols**: Map probe IDs to official gene symbols using the `SYMBOL` column.
*   **Entrez Gene IDs**: Map to NCBI Entrez Gene identifiers using the `ENTREZID` column.
*   **Gene Ontology (GO)**: Retrieve GO terms and evidence codes using the `GO` column.
*   **KEGG Pathways**: Map probes to metabolic and signaling pathways using the `PATH` column.
*   **Chromosomal Location**: Find the start and end positions of genes using `CHRLOC` and `CHRLOCEND`.
*   **External Accessions**: Map to RefSeq (`REFSEQ`), Ensembl (`ENSEMBL`), and Uniprot (`UNIPROT`).

### Using the Bimap Interface (Legacy)
While `select()` is preferred, you can still use the older Bimap interface for specific list-based operations.

```R
# Convert the SYMBOL map to a list
sym_list <- as.list(mta10transcriptclusterSYMBOL)
# Get symbols for the first 5 probes
sym_list[1:5]

# Reverse mapping: Find probes associated with a specific Gene Symbol
alias_map <- as.list(mta10transcriptclusterALIAS2PROBE)
alias_map[["Tp53"]]
```

## Database Information
To inspect the underlying database connection and schema:
```R
# Get database metadata
mta10transcriptcluster_dbInfo()

# View the SQL schema
mta10transcriptcluster_dbschema()

# Get the path to the SQLite file
mta10transcriptcluster_dbfile()
```

## Tips for Success
*   **Keytypes**: When using `select()`, the default `keytype` is `PROBEID`. If you are starting with a different identifier (like a Gene Symbol), specify `keytype = "SYMBOL"`.
*   **One-to-Many Mappings**: Some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
*   **Organism**: This package is specifically for *Mus musculus* (Mouse). Ensure your data matches this species.

## Reference documentation
- [reference_manual.md](./references/reference_manual.md)