---
name: bioconductor-hugene20stprobeset.db
description: This package provides annotation data for the Affymetrix Human Gene 2.0 ST Probeset platform. Use when user asks to map probe identifiers to gene symbols, retrieve Entrez Gene IDs, or access genomic metadata like GO terms and KEGG pathways for this specific microarray.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hugene20stprobeset.db.html
---

# bioconductor-hugene20stprobeset.db

name: bioconductor-hugene20stprobeset.db
description: An annotation data package for the Affymetrix Human Gene 2.0 ST Probeset platform. Use this skill when you need to map manufacturer probe identifiers to various biological identifiers (Entrez Gene IDs, Symbols, GO terms, KEGG pathways, etc.) or retrieve genomic metadata for this specific microarray platform.

# bioconductor-hugene20stprobeset.db

## Overview

The `hugene20stprobeset.db` package is a Bioconductor annotation data package that provides comprehensive mappings for the Affymetrix Human Gene 2.0 ST Probeset platform. It is built upon the `AnnotationDbi` framework, allowing users to query genomic information using either the modern `select()` interface or the legacy `Bimap` interface.

## Core Workflows

### Loading the Package

```r
library(hugene20stprobeset.db)
```

### Using the select() Interface

The `select()` function is the recommended method for retrieving data. It requires four arguments: the database object, the keys (input IDs), the columns (desired information), and the keytype (type of input IDs).

```r
# List available columns
columns(hugene20stprobeset.db)

# List available keytypes
keytypes(hugene20stprobeset.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("16737474", "16906321", "17054006")
select(hugene20stprobeset.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

- **Gene Symbols**: Map probe IDs to official gene symbols using `SYMBOL`.
- **Entrez Gene IDs**: Map to NCBI Entrez Gene identifiers using `ENTREZID`.
- **GO Terms**: Retrieve Gene Ontology categories (BP, CC, MF) and evidence codes using `GO`.
- **KEGG Pathways**: Map probes to KEGG pathway identifiers using `PATH`.
- **Chromosomal Location**: Find start/end positions and chromosome assignments using `CHR`, `CHRLOC`, and `CHRLOCEND`.
- **External Accessions**: Map to RefSeq (`REFSEQ`), Ensembl (`ENSEMBL`), or Uniprot (`UNIPROT`).

### Using the Bimap Interface (Legacy)

While `select()` is preferred, specific mappings can be accessed directly as Bimap objects for quick lookups or list conversions.

```r
# Convert a specific map to a list
sym_list <- as.list(hugene20stprobesetSYMBOL)

# Get probe IDs for a specific gene symbol (reverse map)
alias_to_probe <- as.list(hugene20stprobesetALIAS2PROBE)
my_probes <- alias_to_probe[["TP53"]]
```

### Database Metadata and Connection

To inspect the underlying SQLite database or check data versions:

```r
# Get database metadata
hugene20stprobeset_dbInfo()

# Get the database schema
hugene20stprobeset_dbschema()

# Get the number of mapped keys for all tables
# Note: hugene20stprobesetMAPCOUNTS is deprecated; use mappedkeys() instead
mapped_probes <- mappedkeys(hugene20stprobesetSYMBOL)
length(mapped_probes)
```

## Tips and Best Practices

- **Vectorized Queries**: Always pass a vector of keys to `select()` rather than looping for better performance.
- **Handling 1-to-Many**: Be aware that one probe ID may map to multiple GO terms or Entrez IDs. The `select()` function will return a data.frame with multiple rows for these cases.
- **Organism Package**: This package depends on `org.Hs.eg.db` for gene-centric data. Ensure your Bioconductor environment is up to date to maintain consistency between probe-to-gene and gene-to-annotation mappings.
- **Accession Formats**: When querying `REFSEQ`, remember the prefixes: `NM_` (mRNA), `NP_` (protein), `NG_` (genomic region).

## Reference documentation

- [hugene20stprobeset.db Reference Manual](./references/reference_manual.md)