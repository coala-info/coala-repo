---
name: bioconductor-jazaerimetadata.db
description: This tool provides comprehensive annotation data and mappings for the JazaeriMetaData platform. Use when user asks to map manufacturer probe identifiers to biological annotations such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/JazaeriMetaData.db.html
---

# bioconductor-jazaerimetadata.db

name: bioconductor-jazaerimetadata.db
description: Provides detailed annotation data for the JazaeriMetaData platform. Use this skill to map manufacturer identifiers (probes) to various biological annotations including Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, chromosomal locations, and PubMed references.

# bioconductor-jazaerimetadata.db

## Overview

The `JazaeriMetaData.db` package is a Bioconductor annotation data package that provides comprehensive mappings for the JazaeriMetaData platform. It is built upon the `AnnotationDbi` framework, allowing users to query biological metadata using a standardized interface. The package facilitates the translation between manufacturer-specific probe identifiers and various public database identifiers (GenBank, Ensembl, Entrez, etc.) and functional annotations (GO, KEGG).

## Core Workflows

### Loading the Package
```R
library(JazaeriMetaData.db)
```

### Using the select() Interface
The recommended way to interact with this package is via the `select()`, `keys()`, `columns()`, and `keytypes()` functions from the `AnnotationDbi` package.

```R
# List available columns (types of data you can retrieve)
columns(JazaeriMetaData.db)

# List available keytypes (types of identifiers you can use as input)
keytypes(JazaeriMetaData.db)

# Retrieve specific annotations for a set of probe IDs
probes <- c("1001_at", "1002_f_at") # Example probe IDs
select(JazaeriMetaData.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols and Names**: Map probes to official gene symbols (`SYMBOL`) or full gene names (`GENENAME`).
*   **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLOCEND` to find the chromosome and base pair start/end positions.
*   **Functional Annotation**: 
    *   `GO`: Retrieve Gene Ontology identifiers, evidence codes, and ontologies (BP, CC, MF).
    *   `PATH`: Map to KEGG pathway identifiers.
*   **External Database Cross-references**:
    *   `ENSEMBL`: Ensembl gene accessions.
    *   `UNIPROT`: UniProt protein accessions.
    *   `REFSEQ`: RefSeq identifiers.
    *   `ACCNUM`: GenBank accession numbers.

### Legacy Bimap Interface
While `select()` is preferred, the package supports the older Bimap interface for specific list-based operations.

```R
# Convert a map to a list to see all mappings for a specific attribute
symbol_list <- as.list(JazaeriMetaDataSYMBOL)
# Get symbols for the first 5 probes
symbol_list[1:5]

# Reverse mapping (e.g., find probes for a specific GO term)
go_to_probes <- as.list(JazaeriMetaDataGO2PROBE)
```

### Database Connection and Metadata
To inspect the underlying SQLite database or check version information:
```R
# Get database metadata
JazaeriMetaData_dbInfo()

# Get the database schema
JazaeriMetaData_dbschema()

# Get the organism for which this package was built
JazaeriMetaDataORGANISM
```

## Tips and Best Practices
*   **NA Values**: Mappings that cannot be resolved will return `NA`. Always check for `NA` results when processing large batches of probes.
*   **One-to-Many Mappings**: Some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with multiple rows for these cases.
*   **GO Evidence Codes**: When using `GO` annotations, pay attention to the `EVIDENCE` column to understand the quality of the association (e.g., `IDA` for direct assay vs. `IEA` for electronic annotation).

## Reference documentation
- [JazaeriMetaData.db Reference Manual](./references/reference_manual.md)