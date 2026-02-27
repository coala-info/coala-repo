---
name: bioconductor-moex10stprobeset.db
description: This package provides annotation data for the Affymetrix Mouse Exon 1.0 ST Probeset platform. Use when user asks to map manufacturer probe identifiers to biological metadata, retrieve gene symbols, or access functional annotations like GO terms and KEGG pathways for Mus musculus.
homepage: https://bioconductor.org/packages/release/data/annotation/html/moex10stprobeset.db.html
---


# bioconductor-moex10stprobeset.db

name: bioconductor-moex10stprobeset.db
description: Provides annotation data for the Affymetrix Mouse Exon 1.0 ST Probeset platform. Use this skill to map manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, and KEGG pathways for Mus musculus.

# bioconductor-moex10stprobeset.db

## Overview

The `moex10stprobeset.db` package is a Bioconductor annotation data package for the Affymetrix Mouse Exon 1.0 ST Probeset array. It provides a comprehensive set of SQLite-based mappings between manufacturer probe identifiers and various genomic databases. This skill guides the use of the `AnnotationDbi` interface to query these mappings.

## Core Workflows

### Loading the Package
```r
library(moex10stprobeset.db)
```

### Using the select() Interface
The recommended way to interact with this package is through the `select()`, `keys()`, `columns()`, and `keytypes()` functions from the `AnnotationDbi` package.

```r
# List available columns to retrieve
columns(moex10stprobeset.db)

# List available keytypes (usually 'PROBEID')
keytypes(moex10stprobeset.db)

# Retrieve specific annotations for a set of probes
probes <- c("4000001", "4000002", "4000003")
select(moex10stprobeset.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols and Names**: Map probes to official gene symbols using `SYMBOL` or full names using `GENENAME`.
*   **Accession Numbers**: Map to Entrez Gene IDs (`ENTREZID`), RefSeq (`REFSEQ`), Ensembl (`ENSEMBL`), or Uniprot (`UNIPROT`).
*   **Chromosomal Location**: Use `CHR` for chromosome number, `CHRLOC` for start positions, and `CHRLENGTHS` for chromosome lengths.
*   **Functional Annotation**: Map to Gene Ontology (`GO`) or KEGG pathways (`PATH`).

### Using the Bimap Interface (Legacy)
While `select()` is preferred, you can still use the Bimap interface for specific list-based operations.

```r
# Map probes to Gene Symbols
x <- moex10stprobesetSYMBOL
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes])

# Map Gene Aliases back to Probes
alias_map <- as.list(moex10stprobesetALIAS2PROBE)
```

### Database Connection and Metadata
To inspect the underlying database or schema:
```r
# Get database connection
conn <- moex10stprobeset_dbconn()

# View database schema
moex10stprobeset_dbschema()

# Get organism information
moex10stprobesetORGANISM
```

## Tips and Best Practices
*   **Handling Multiple Matches**: Some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per match, which may result in more rows than input keys.
*   **GO Evidence Codes**: When querying `GO` terms, the output includes evidence codes (e.g., IDA, TAS, IEA). Filter these if you only want experimentally validated annotations.
*   **Package Updates**: This package is updated biannually by Bioconductor; ensure you are using the version corresponding to your Bioconductor release for the most accurate mappings.

## Reference documentation
- [reference_manual.md](./references/reference_manual.md)