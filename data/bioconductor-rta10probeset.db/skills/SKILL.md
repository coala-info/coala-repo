---
name: bioconductor-rta10probeset.db
description: This package provides annotation data for the Rat Toxicology Array 1.0 to map manufacturer probe identifiers to biological metadata. Use when user asks to map probe IDs to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations for rat toxicology microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rta10probeset.db.html
---

# bioconductor-rta10probeset.db

name: bioconductor-rta10probeset.db
description: Annotation data for the Rat Toxicology Array 1.0 (rta10probeset). Use when mapping manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Symbols, GO terms, KEGG pathways, and chromosomal locations in R.

# bioconductor-rta10probeset.db

## Overview
The `rta10probeset.db` package is a Bioconductor annotation data package for the Rat Toxicology Array 1.0. It provides an SQLite-based interface to map manufacturer probe identifiers to various genomic and functional annotations. This package is essential for downstream analysis of microarray data, allowing researchers to translate probe-level results into biological insights.

## Core Workflows

### Loading the Package
```r
library(rta10probeset.db)
```

### Using the select() Interface
The recommended way to interact with this package is via the `AnnotationDbi` select interface.

```r
# View available columns (types of data)
columns(rta10probeset.db)

# View available keytypes (what you can search by)
keytypes(rta10probeset.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1367401_at", "1367402_at")
select(rta10probeset.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Legacy Bimap Interface
While `select()` is preferred, you can still use the older Bimap interface for specific mappings.

```r
# Get the probe identifiers that are mapped to an Entrez Gene ID
x <- rta10probesetENTREZID
mapped_probes <- mappedkeys(x)

# Convert to a list to see mappings
as.list(x[mapped_probes][1:5])
```

## Key Mapping Objects

*   **Gene Identifiers**:
    *   `rta10probesetENTREZID`: Maps probes to Entrez Gene identifiers.
    *   `rta10probesetSYMBOL`: Maps probes to official gene symbols.
    *   `rta10probesetGENENAME`: Maps probes to full gene names.
    *   `rta10probesetENSEMBL`: Maps probes to Ensembl gene accessions.
    *   `rta10probesetUNIPROT`: Maps probes to Uniprot accessions.
*   **Functional Annotation**:
    *   `rta10probesetGO`: Maps probes to Gene Ontology (GO) terms (includes Evidence and Ontology type).
    *   `rta10probesetPATH`: Maps probes to KEGG pathway identifiers.
    *   `rta10probesetENZYME`: Maps probes to Enzyme Commission (EC) numbers.
*   **Positional Information**:
    *   `rta10probesetCHR`: Maps probes to chromosomes.
    *   `rta10probesetCHRLOC`: Maps probes to starting chromosomal coordinates.
    *   `rta10probesetCHRLENGTHS`: Provides lengths of chromosomes.
*   **Literature**:
    *   `rta10probesetPMID`: Maps probes to PubMed identifiers.

## Database Information
To inspect the underlying database schema or connection:

```r
# Get database connection
conn <- rta10probeset_dbconn()

# Show database schema
rta10probeset_dbschema()

# Get number of rows in the probes table
library(DBI)
dbGetQuery(conn, "SELECT COUNT(*) FROM probes")
```

## Tips
*   **Reverse Mappings**: Many objects have reverse maps (e.g., `rta10probesetSYMBOL2PROBE` or `rta10probesetGO2PROBE`).
*   **GO Evidence Codes**: When using GO mappings, pay attention to the evidence codes (e.g., IDA, IEA, TAS) to understand the quality of the annotation.
*   **Multiple Mappings**: Some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.

## Reference documentation
- [rta10probeset.db Reference Manual](./references/reference_manual.md)