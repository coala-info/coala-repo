---
name: bioconductor-partheenmetadata.db
description: This tool provides annotation data for mapping PartheenMetaData platform probe identifiers to various biological identifiers and genomic metadata. Use when user asks to map probe IDs to gene symbols, retrieve functional annotations like GO terms or KEGG pathways, or perform identifier conversions for the PartheenMetaData microarray platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/PartheenMetaData.db.html
---

# bioconductor-partheenmetadata.db

name: bioconductor-partheenmetadata.db
description: Use this skill to access and query the PartheenMetaData.db Bioconductor annotation package. This is essential for mapping manufacturer-specific identifiers from the PartheenMetaData platform to various biological identifiers like Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and Ensembl IDs. Use this skill when you need to annotate probe-level data or perform identifier conversions for this specific microarray platform.

# bioconductor-partheenmetadata.db

## Overview

PartheenMetaData.db is a Bioconductor annotation data package that provides a comprehensive mapping between manufacturer identifiers (probes) for the PartheenMetaData platform and various public database identifiers. It is built as an `AnnotationDb` object, allowing for efficient querying of genomic metadata including chromosomal locations, gene symbols, and functional annotations.

## Core Workflows

### Loading the Package

To begin using the annotation data, load the library in R:

```r
library(PartheenMetaData.db)
```

### Modern Interface: select()

The recommended way to interact with this package is through the `select()` interface from the `AnnotationDbi` package.

1.  **Discover available data types:**
    ```r
    columns(PartheenMetaData.db)
    ```

2.  **Discover valid key types (usually PROBEID):**
    ```r
    keytypes(PartheenMetaData.db)
    ```

3.  **Perform a query:**
    Map a set of probe IDs to Gene Symbols and Entrez IDs.
    ```r
    probes <- c("probe_id_1", "probe_id_2") # Replace with actual IDs
    select(PartheenMetaData.db, 
           keys = probes, 
           columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
           keytype = "PROBEID")
    ```

### Legacy Bimap Interface

While `select()` is preferred, you can also use the "Bimap" objects for direct mapping.

*   **Map Probes to Symbols:**
    ```r
    # Convert to list
    probe_to_symbol <- as.list(PartheenMetaDataSYMBOL)
    # Access specific probe
    symbol <- probe_to_symbol[["your_probe_id"]]
    ```

*   **Reverse Mapping (e.g., Symbols to Probes):**
    ```r
    symbol_to_probe <- as.list(PartheenMetaDataALIAS2PROBE)
    ```

### Common Annotation Mappings

*   **Functional Annotation:** Use `PartheenMetaDataGO` for Gene Ontology terms and `PartheenMetaDataPATH` for KEGG pathway identifiers.
*   **Genomic Location:** Use `PartheenMetaDataCHR` (chromosomes), `PartheenMetaDataCHRLOC` (start positions), and `PartheenMetaDataMAP` (cytobands).
*   **External Database IDs:** Use `PartheenMetaDataENSEMBL`, `PartheenMetaDataUNIPROT`, `PartheenMetaDataREFSEQ`, and `PartheenMetaDataENTREZID`.
*   **Literature:** Use `PartheenMetaDataPMID` to find PubMed identifiers associated with specific probes.

### Database Information

To get metadata about the underlying database (e.g., source URLs, date stamps):

```r
PartheenMetaData_dbInfo()
# Or get the schema
PartheenMetaData_dbschema()
```

## Tips and Best Practices

*   **Handling Multiple Matches:** Some probes may map to multiple identifiers (e.g., multiple GO terms). The `select()` function returns a data.frame where these are represented as multiple rows.
*   **Filtering Mapped Keys:** Use `mappedkeys(x)` to identify which keys in a Bimap actually have associated data to avoid `NA` values.
*   **Organism Context:** This package is typically used for Human (Homo sapiens) data, often based on hg19/GRCh37 coordinates (check `PartheenMetaDataORGANISM`).

## Reference documentation

- [PartheenMetaData.db Reference Manual](./references/reference_manual.md)