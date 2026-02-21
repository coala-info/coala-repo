---
name: bioconductor-hu35ksuba.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu35ksuba.db.html
---

# bioconductor-hu35ksuba.db

name: bioconductor-hu35ksuba.db
description: Provides annotation data for the Affymetrix Human Genome Hu35K Set A (hu35ksuba) platform. Use this skill to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbol, RefSeq, Ensembl, GO, KEGG) and genomic locations.

## Overview

The `hu35ksuba.db` package is a Bioconductor annotation data package for the Affymetrix Hu35K Set A array. It provides an SQLite-based interface to map probe set IDs to genomic, functional, and publication-related metadata.

## Core Workflows

### Loading the Package
```r
library(hu35ksuba.db)
```

### Using the select() Interface
The recommended way to interact with this package is via the `select()` function from the `AnnotationDbi` package.

```r
# List available keys (probe IDs)
probes <- keys(hu35ksuba.db)

# List available columns (types of data)
columns(hu35ksuba.db)

# Map specific probes to Gene Symbols and Entrez IDs
select(hu35ksuba.db, 
       keys = probes[1:5], 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mappings

*   **Gene Symbols and Names**: Map probes to official gene symbols (`SYMBOL`) or full names (`GENENAME`).
*   **External Accessions**: Map to `REFSEQ`, `ENSEMBL`, `UNIPROT`, or `ACCNUM` (GenBank accession).
*   **Functional Annotation**: Map to `GO` (Gene Ontology) terms or `PATH` (KEGG pathway) identifiers.
*   **Genomic Location**: Map to `CHR` (Chromosome), `CHRLOC` (Start position), or `MAP` (Cytoband).

### Using the Bimap Interface (Legacy)
While `select()` is preferred, the package provides "Bimap" objects for direct mapping.

```r
# Map probes to Entrez IDs
x <- hu35ksubaENTREZID
mapped_probes <- mappedkeys(x)
as.list(x[mapped_probes][1:5])

# Map Gene Symbols to Probes (Reverse Map)
y <- hu35ksubaALIAS2PROBE
as.list(y["TP53"])
```

### Database Connection and Metadata
To inspect the underlying database or schema:

```r
# Get database connection
conn <- hu35ksuba_dbconn()

# Show database schema
hu35ksuba_dbschema()

# Get organism information
hu35ksubaORGANISM
```

## Tips
*   **Multiple Mappings**: Some probes may map to multiple identifiers (e.g., multiple GO terms or Entrez IDs). `select()` will return a data frame with one row per mapping.
*   **Alias Mapping**: Use `hu35ksubaALIAS2PROBE` to find probes associated with common gene aliases that might not be the official symbol.
*   **GO Evidence**: When mapping to GO terms, the `EVIDENCE` column indicates the type of experimental support (e.g., IDA, IEA, TAS).

## Reference documentation

- [hu35ksuba.db Reference Manual](./references/reference_manual.md)