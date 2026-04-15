---
name: bioconductor-mpedbarray.db
description: This package provides comprehensive annotation data for mapping mpedbarray platform probe identifiers to biological metadata for mouse genomic data. Use when user asks to map probe IDs to gene symbols, Entrez IDs, GO terms, Ensembl IDs, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mpedbarray.db.html
---

# bioconductor-mpedbarray.db

name: bioconductor-mpedbarray.db
description: Comprehensive annotation data for the mpedbarray platform. Use when mapping manufacturer probe identifiers to biological metadata including Gene Symbols, Entrez IDs, GO terms, Ensembl IDs, and chromosomal locations. Supports both the modern select() interface and legacy Bimap objects for Mus musculus (mouse) genomic data.

# bioconductor-mpedbarray.db

## Overview

The `mpedbarray.db` package is a Bioconductor annotation data package for the mpedbarray platform. It provides a stable environment for mapping manufacturer-specific probe identifiers to various gene-centric identifiers and biological annotations. This package is primarily used in bioinformatics workflows to interpret the results of microarray experiments.

## Core Workflows

### Using the select() Interface

The modern and preferred way to interact with `mpedbarray.db` is through the `AnnotationDbi` interface. This allows for SQL-like queries to retrieve multiple types of data simultaneously.

```r
library(mpedbarray.db)

# List all available annotation types (columns)
columns(mpedbarray.db)

# List the first few probe identifiers (keys)
head(keys(mpedbarray.db))

# Retrieve specific annotations for a set of probes
probes <- c("1", "2", "3") # Replace with actual probe IDs
select(mpedbarray.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Using Legacy Bimap Objects

While `select()` is preferred, the package provides specific Bimap objects for direct mapping. These are useful for quick list conversions or when working with older scripts.

*   `mpedbarraySYMBOL`: Map probes to Gene Symbols.
*   `mpedbarrayENTREZID`: Map probes to Entrez Gene identifiers.
*   `mpedbarrayGO`: Map probes to Gene Ontology (GO) terms (includes Evidence and Ontology codes).
*   `mpedbarrayPATH`: Map probes to KEGG pathway identifiers.
*   `mpedbarrayACCNUM`: Map probes to GenBank accession numbers.
*   `mpedbarrayCHR`: Map probes to chromosomes.

Example of Bimap usage:
```r
# Convert a Bimap to a list for lookup
sym_list <- as.list(mpedbarraySYMBOL)
# Access a specific probe
sym_list[["1"]]
```

### Genomic Locations and Sequences

The package includes specific mappings for physical locations on the mouse genome (typically mm10/GRCm38):

*   `mpedbarrayCHRLOC`: Starting positions of genes.
*   `mpedbarrayCHRLOCEND`: Ending positions of genes.
*   `mpedbarrayCHRLENGTHS`: Lengths of all chromosomes in base pairs.

### Cross-Database Mappings

For integration with other databases, use these specific objects:
*   `mpedbarrayENSEMBL`: Ensembl gene accession numbers.
*   `mpedbarrayUNIPROT`: UniProt accession numbers.
*   `mpedbarrayMGI`: Mouse Genome Informatics (MGI) accession numbers.
*   `mpedbarrayREFSEQ`: RefSeq identifiers.

## Tips and Best Practices

*   **Reverse Mappings**: Many Bimaps have reverse counterparts (e.g., `mpedbarraySYMBOL2PROBE`) to find probes associated with a specific gene symbol.
*   **GO Evidence Codes**: When using `mpedbarrayGO`, filter by the `Evidence` element (e.g., IDA, TAS, IEA) to control the quality of functional annotations.
*   **Database Connection**: Use `mpedbarray_dbconn()` to get a direct DBI connection to the underlying SQLite database for custom SQL queries.
*   **Package Dependencies**: Ensure `AnnotationDbi` is loaded to use the `select()`, `keys()`, and `columns()` functions.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)