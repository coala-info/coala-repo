---
name: bioconductor-rta10transcriptcluster.db
description: This package provides annotation data for the Affymetrix Rat Transcriptome Array 1.0 platform. Use when user asks to map rat transcript cluster identifiers to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rta10transcriptcluster.db.html
---

# bioconductor-rta10transcriptcluster.db

name: bioconductor-rta10transcriptcluster.db
description: Annotation data for the Rat Transcriptome Array 1.0 (RTA 1.0) platform. Use this skill to map manufacturer probe identifiers to various biological annotations such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations for Rattus norvegicus.

# bioconductor-rta10transcriptcluster.db

## Overview

The `rta10transcriptcluster.db` package is a Bioconductor annotation data package for the Affymetrix Rat Transcriptome Array 1.0. It provides a SQLite-based interface to map manufacturer-specific transcript cluster identifiers to genomic and functional metadata. This package is essential for downstream analysis of microarray data, allowing researchers to translate probe-level results into biological insights.

## Core Workflows

### Loading the Package and Exploring Columns

To begin, load the library and inspect the available annotation types (columns).

```R
library(rta10transcriptcluster.db)

# List all available mapping categories
columns(rta10transcriptcluster.db)

# List available key types (usually PROBEID)
keytypes(rta10transcriptcluster.db)
```

### Using the select() Interface

The `select()` function is the recommended method for retrieving data. It requires the database object, the keys (probe IDs), the columns you want to retrieve, and the keytype.

```R
# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("17000001", "17000002", "17000003")
results <- select(rta10transcriptcluster.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Functional Annotation (GO and KEGG)

You can map probes to Gene Ontology (GO) terms or KEGG pathways for pathway analysis.

```R
# Map probes to GO terms with evidence codes
go_mappings <- select(rta10transcriptcluster.db, 
                      keys = probes, 
                      columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                      keytype = "PROBEID")

# Map probes to KEGG pathways
path_mappings <- select(rta10transcriptcluster.db, 
                        keys = probes, 
                        columns = "PATH", 
                        keytype = "PROBEID")
```

### Genomic Location and Accessions

Retrieve chromosomal coordinates or external database accessions (RefSeq, Ensembl, Uniprot).

```R
# Get chromosomal location
loc_data <- select(rta10transcriptcluster.db, 
                   keys = probes, 
                   columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
                   keytype = "PROBEID")

# Map to RefSeq and Ensembl
accessions <- select(rta10transcriptcluster.db, 
                     keys = probes, 
                     columns = c("REFSEQ", "ENSEMBL"), 
                     keytype = "PROBEID")
```

### Legacy Bimap Interface

While `select()` is preferred, you can still use the older Bimap interface for specific list-based operations.

```R
# Convert a specific map to a list
sym_list <- as.list(rta10transcriptclusterSYMBOL)

# Get symbols for the first 5 probes
sym_list[1:5]
```

## Tips and Best Practices

- **One-to-Many Mappings**: Be aware that some probes map to multiple GO terms or Entrez IDs. The `select()` function will return a data frame with multiple rows for a single probe in these cases.
- **Organism Verification**: Use `rta10transcriptclusterORGANISM` to confirm the target species (Rattus norvegicus).
- **Database Connection**: If you need to perform direct SQL queries, use `rta10transcriptcluster_dbconn()` to get the connection object, but never call `dbDisconnect()` on it.
- **Reverse Mappings**: For maps like `rta10transcriptclusterGO2PROBE`, you can find all probes associated with a specific biological category.

## Reference documentation

- [rta10transcriptcluster.db Reference Manual](./references/reference_manual.md)