---
name: bioconductor-mogene21stprobeset.db
description: This package provides comprehensive annotation data for the Affymetrix Mouse Gene 2.1 ST array. Use when user asks to map manufacturer probe identifiers to biological metadata, retrieve gene symbols or Entrez IDs, and link mouse transcriptomic data to GO terms or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mogene21stprobeset.db.html
---


# bioconductor-mogene21stprobeset.db

name: bioconductor-mogene21stprobeset.db
description: Comprehensive annotation data for the Affymetrix Mouse Gene 2.1 ST array. Use when mapping manufacturer probe identifiers to biological metadata like Entrez IDs, Gene Symbols, GO terms, and KEGG pathways for mouse transcriptomic data.

# bioconductor-mogene21stprobeset.db

## Overview

The `mogene21stprobeset.db` package is a Bioconductor annotation data package for the Affymetrix Mouse Gene 2.1 ST array. It provides mappings between manufacturer probe identifiers and various gene identifiers and functional annotations. This package is built using the `AnnotationDbi` framework, which supports both the modern `select()` interface and the legacy `Bimap` interface.

## Core Workflows

### Loading the Package

```r
library(mogene21stprobeset.db)
```

### Using the select() Interface

The `select()` function is the recommended way to query the database. It requires the database object, the keys (probe IDs), the columns you want to retrieve, and the keytype of the input keys.

```r
# List available columns
columns(mogene21stprobeset.db)

# List available keytypes
keytypes(mogene21stprobeset.db)

# Retrieve Gene Symbols and Entrez IDs for specific probes
probes <- c("16737477", "16737481", "16737485")
select(mogene21stprobeset.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Mapping to Functional Annotations

You can map probe IDs to Gene Ontology (GO) terms or KEGG pathways.

```r
# Map probes to GO terms
go_mappings <- select(mogene21stprobeset.db, 
                      keys = probes, 
                      columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                      keytype = "PROBEID")

# Map probes to KEGG pathways
path_mappings <- select(mogene21stprobeset.db, 
                        keys = probes, 
                        columns = "PATH", 
                        keytype = "PROBEID")
```

### Legacy Bimap Interface

While `select()` is preferred, you can still use the Bimap interface for quick lookups or to convert entire maps to lists.

```r
# Get Gene Symbols for probes
x <- mogene21stprobesetSYMBOL
mapped_probes <- mappedkeys(x)
symbol_list <- as.list(x[mapped_probes[1:5]])

# Reverse mapping: Find probes for a specific Gene Symbol
alias_map <- mogene21stprobesetALIAS2PROBE
probes_for_alias <- as.list(alias_map["Gnat1"])
```

### Database Metadata

To get information about the organism or the underlying data sources:

```r
# Get organism name
mogene21stprobesetORGANISM

# Get the parent organism package
mogene21stprobesetORGPKG

# Get database connection info
mogene21stprobeset_dbInfo()
```

## Tips and Best Practices

- **Probe IDs**: Ensure your input keys are character vectors, as probe identifiers are treated as strings.
- **One-to-Many Mappings**: Be aware that one probe ID may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
- **Filtering GO Terms**: When querying GO terms, use the `EVIDENCE` column to filter by the quality of the evidence (e.g., "TAS" for Traceable Author Statement).
- **Memory Management**: For very large queries, use `keys(mogene21stprobeset.db)` to retrieve all available probe IDs before subsetting.

## Reference documentation

- [mogene21stprobeset.db Reference Manual](./references/reference_manual.md)