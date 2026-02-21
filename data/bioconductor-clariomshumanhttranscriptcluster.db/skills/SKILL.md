---
name: bioconductor-clariomshumanhttranscriptcluster.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/clariomshumanhttranscriptcluster.db.html
---

# bioconductor-clariomshumanhttranscriptcluster.db

## Overview

The `clariomshumanhttranscriptcluster.db` package is a Bioconductor annotation data package for the Clariom S Human HT Transcript Cluster array. It provides a comprehensive set of mappings between manufacturer-specific probe identifiers and various biological identifiers, including Entrez Gene IDs, Gene Symbols, Chromosomal locations, and functional annotations like KEGG pathways and Gene Ontology (GO) terms.

The package uses an SQLite database backend and is primarily accessed through the `AnnotationDbi` interface.

## Core Workflow

### 1. Loading the Package
```R
library(clariomshumanhttranscriptcluster.db)
```

### 2. Exploring Available Data
Use the standard `AnnotationDbi` methods to see what information can be retrieved.
```R
# List all available annotation types (columns)
columns(clariomshumanhttranscriptcluster.db)

# List available key types (usually PROBEID)
keytypes(clariomshumanhttranscriptcluster.db)

# Get a sample of probe identifiers
head(keys(clariomshumanhttranscriptcluster.db, keytype="PROBEID"))
```

### 3. Mapping Identifiers using select()
The `select()` function is the recommended way to retrieve data.
```R
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("16650001", "16650007", "16650009")
results <- select(clariomshumanhttranscriptcluster.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### 4. Functional Annotation (GO and KEGG)
Retrieve Gene Ontology terms or KEGG pathways for specific probes.
```R
# Get GO terms for probes
go_annots <- select(clariomshumanhttranscriptcluster.db, 
                    keys = probes, 
                    columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                    keytype = "PROBEID")

# Get KEGG pathways
kegg_annots <- select(clariomshumanhttranscriptcluster.db, 
                      keys = probes, 
                      columns = "PATH", 
                      keytype = "PROBEID")
```

## Legacy Bimap Interface

While `select()` is preferred, you can still use the older Bimap interface for specific tasks like converting an entire map to a list.

```R
# Convert the SYMBOL map to a list
symbol_list <- as.list(clariomshumanhttranscriptclusterSYMBOL)

# Get probes mapped to a specific chromosome
chr1_probes <- as.list(clariomshumanhttranscriptclusterCHR)
chr1_probes <- names(chr1_probes)[chr1_probes == "1"]
```

## Database Connection and Metadata
You can access the underlying SQLite connection or view package metadata.
```R
# Get database metadata
clariomshumanhttranscriptcluster_dbInfo()

# Get the organism name
clariomshumanhttranscriptclusterORGANISM
```

## Tips
- **Multiple Mappings**: Some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
- **Alias Mapping**: Use `clariomshumanhttranscriptclusterALIAS2PROBE` if you need to map common gene aliases back to the manufacturer probe IDs.
- **Filtering**: When using `select()`, you can filter by any available column as a `keytype`.

## Reference documentation
- [Title](./references/reference_manual.md)