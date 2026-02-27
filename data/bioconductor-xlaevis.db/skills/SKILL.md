---
name: bioconductor-xlaevis.db
description: This package provides comprehensive biological annotations and database mappings for Xenopus laevis probe identifiers. Use when user asks to map probe IDs to gene symbols, retrieve Entrez or UniProt identifiers, or perform functional annotation using Gene Ontology and KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/xlaevis.db.html
---


# bioconductor-xlaevis.db

## Overview

The `xlaevis.db` package is a Bioconductor annotation hub for *Xenopus laevis*. It provides a comprehensive mapping between manufacturer-specific probe identifiers and various biological databases. It is primarily used in transcriptomics and functional genomics workflows to annotate experimental results.

## Core Workflows

### Loading the Package
```R
library(xlaevis.db)
```

### Using the select() Interface
The recommended way to interact with the database is via the `AnnotationDbi` interface.

```R
# View available columns
columns(xlaevis.db)

# View available key types (usually PROBEID)
keytypes(xlaevis.db)

# Retrieve specific annotations for a set of probes
probes <- c("12345_at", "67890_at") # Example probe IDs
select(xlaevis.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols and Names**: Map probes to official gene symbols or descriptive names.
    *   `xlaevisSYMBOL`: Maps to gene abbreviations.
    *   `xlaevisGENENAME`: Maps to full gene names.
*   **External Database IDs**:
    *   `xlaevisENTREZID`: Maps to NCBI Entrez Gene identifiers.
    *   `xlaevisACCNUM`: Maps to GenBank accession numbers.
    *   `xlaevisUNIPROT`: Maps to UniProt accession numbers.
    *   `xlaevisREFSEQ`: Maps to RefSeq identifiers.
*   **Functional Annotation**:
    *   `xlaevisGO`: Maps to Gene Ontology (GO) identifiers (includes Evidence and Ontology type).
    *   `xlaevisPATH`: Maps to KEGG pathway identifiers.
    *   `xlaevisENZYME`: Maps to Enzyme Commission (EC) numbers.
*   **Literature and Location**:
    *   `xlaevisPMID`: Maps to PubMed identifiers.
    *   `xlaevisCHR`: Maps to chromosomal locations.

### Legacy Bimap Interface
While `select()` is preferred, you can access mappings as list-like objects:

```R
# Convert a mapping to a list
sym_list <- as.list(xlaevisSYMBOL)

# Get symbols for specific probes
sym_list[c("12345_at", "67890_at")]

# Reverse mapping (e.g., GO to Probes)
go_to_probes <- as.list(xlaevisGO2PROBE)
```

## Database Information
To inspect the underlying SQLite database:
*   `xlaevis_dbconn()`: Get the DBI connection object.
*   `xlaevis_dbfile()`: Get the path to the SQLite file.
*   `xlaevis_dbschema()`: View the database schema.

## Tips
*   **Multiple Mappings**: Some probes may map to multiple identifiers (e.g., multiple GO terms). `select()` will return a data frame with one row per mapping, potentially resulting in more rows than input keys.
*   **NA Values**: If a probe cannot be mapped to a specific resource, `NA` is returned.
*   **Organism Info**: Use `xlaevisORGANISM` to programmatically confirm the species.

## Reference documentation
- [xlaevis.db Reference Manual](./references/reference_manual.md)