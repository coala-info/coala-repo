---
name: bioconductor-somascan.db
description: This tool provides biological annotations and identifier mapping for SomaLogic SomaScan proteomic assay data. Use when user asks to map SomaScan SeqIds to gene symbols, Entrez IDs, or UniProt IDs, filter probes by menu version, or add protein target names to data frames.
homepage: https://bioconductor.org/packages/release/data/annotation/html/SomaScan.db.html
---

# bioconductor-somascan.db

name: bioconductor-somascan.db
description: Provides biological annotations for SomaLogic SomaScan assay data. Use this skill to map SomaScan SeqIds (Probe IDs) to gene symbols, Entrez IDs, UniProt IDs, and biological pathways (GO, KEGG). It supports menu-specific filtering (e.g., 5k, 7k, v4.0, v4.1) and adding protein target full names to data frames.

# bioconductor-somascan.db

## Overview
The `SomaScan.db` package is a Bioconductor annotation resource for SomaLogic's proteomic platform. It functions as a SQLite-based mapping between SomaScan-specific identifiers (`SeqIds`, referred to as `PROBEID` in the database) and standard biological identifiers. It follows the standard `AnnotationDbi` interface, making it compatible with common R workflows for genomic and proteomic data annotation.

## Core Workflows

### 1. Initialization and Metadata
Load the library to expose the `SomaScan.db` object.
```r
library(SomaScan.db)

# View database metadata
SomaScan.db

# Get species information
species(SomaScan.db)
taxonomyId(SomaScan.db)
```

### 2. Querying the Database
Use the five standard `AnnotationDbi` methods: `keys()`, `keytypes()`, `columns()`, `select()`, and `mapIds()`.

#### Listing Available Keys and Columns
```r
# List available key types (e.g., PROBEID, SYMBOL, UNIPROT)
keytypes(SomaScan.db)

# List available annotation columns
columns(SomaScan.db)

# Retrieve all SeqIds (PROBEIDs)
all_seqids <- keys(SomaScan.db, keytype = "PROBEID")
```

#### Using `select` for Data Frames
`select` returns a data frame and is best for multi-column retrieval.
```r
# Map SeqIds to Gene Symbols and Entrez IDs
my_keys <- c("10000-28", "10001-7")
res <- select(SomaScan.db, 
              keys = my_keys, 
              columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
              keytype = "PROBEID")
```

#### Using `mapIds` for Vectors
`mapIds` returns a named vector. Use `multiVals` to handle 1:many mappings.
```r
# Get a simple mapping of SeqId to Symbol
syms <- mapIds(SomaScan.db, 
               keys = my_keys, 
               column = "SYMBOL", 
               keytype = "PROBEID", 
               multiVals = "first")
```

### 3. Menu-Specific Filtering
SomaScan menus change over time (e.g., 5k/v4.0, 7k/v4.1, 11k/v5.0). You can filter queries by menu version.
```r
# Retrieve only IDs present in the 5k menu
menu_5k <- select(SomaScan.db, 
                  keys = keys(SomaScan.db), 
                  columns = "PROBEID", 
                  menu = "5k")

# Access the somascan_menu list object directly
names(somascan_menu)
v4_ids <- somascan_menu$v4.0
```

### 4. Adding Protein Target Names
The package includes a specific utility to append the "Target Full Name" (descriptive protein name) to an existing data frame.
```r
# The data frame must contain a 'PROBEID' column
annotated_df <- addTargetFullName(res)
```

### 5. Advanced Mapping (Reverse Lookups)
You can search for SeqIds using gene aliases or symbols.
```r
# Find SeqIds associated with a gene alias
select(SomaScan.db, 
       keys = "CASC4", 
       keytype = "ALIAS", 
       columns = c("SYMBOL", "PROBEID"))
```

## Tips and Best Practices
- **PROBEID**: In this package, `PROBEID` is the internal name for SomaScan `SeqIds`.
- **1:Many Mappings**: Annotations like GO terms or KEGG pathways often have multiple entries per SeqId. Requesting these alongside 1:1 mappings (like SYMBOL) will "balloon" the resulting data frame. Query GO/PATH columns separately.
- **Regex Searching**: Use the `pattern` argument in `keys()` or `match = TRUE` in `select()` to find gene families (e.g., `keys(SomaScan.db, keytype="SYMBOL", pattern="IL17")`).
- **Integration**: Combine `SomaScan.db` with `GO.db` or `KEGGREST` for detailed pathway descriptions, as `SomaScan.db` only stores the IDs.

## Reference documentation
- [Introduction to SomaScan.db](./references/SomaScan-db.md)
- [Advanced Exploration of the SomaScan Menu](./references/advanced_usage_examples.md)
- [Example ADAT Workflow](./references/example_adat_workflow.md)