---
name: bioconductor-brendadb
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/brendaDb.html
---

# bioconductor-brendadb

## Overview
The `brendaDb` package provides a streamlined interface for the BRENDA (BRaunschweig ENzyme DAtabase). It allows users to parse the large BRENDA text file into a structured R format, perform targeted queries for enzyme kinetics, nomenclature, and properties, and integrate this data into bioinformatics workflows.

## Installation
```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("brendaDb")
library(brendaDb)
```

## Core Workflow

### 1. Data Acquisition and Loading
BRENDA data is distributed as a large text file. You can download it manually or via the package.
```r
# Download the database file (requires internet)
brenda_file <- DownloadBrenda()

# Read the file into a tibble
# Note: This is memory-intensive; consider saving the result as an .rds file
df <- ReadBrenda(brenda_file)
```

### 2. Mapping IDs to EC Numbers
Since BRENDA is organized by Enzyme Commission (EC) numbers, use `ID2Enzyme` to find the correct EC for gene symbols or common names.
```r
# Map gene symbols or names to EC numbers
mapping <- ID2Enzyme(df, ids = c("ADH4", "pyruvate dehydrogenase"))
# Result contains EC, Recommended Name, and Synonyms
```

### 3. Querying the Database
Use `QueryBrenda` to extract specific information. You can filter by EC number, organism, and specific data fields.
```r
# Show available fields (e.g., KM_VALUE, PH_OPTIMUM, TEMPERATURE_RANGE)
ShowFields(df)

# Targeted query for human Alcohol Dehydrogenase
res <- QueryBrenda(df, 
                   EC = "1.1.1.1", 
                   organisms = "Homo sapiens",
                   fields = c("PROTEIN", "KM_VALUE", "PH_OPTIMUM"))
```

### 4. Extracting Results to Tables
Query results are returned as nested `brenda.entry` objects. Use `ExtractField` to flatten them into tidy tibbles for analysis.
```r
# Extract pH optimum values into a flat table
ph_table <- ExtractField(res, field = "parameters$ph.optimum")

# Extract KM values
km_table <- ExtractField(res, field = "parameters$km.value")
```

## Tips and Performance
- **Caching**: `ReadBrenda` is slow. After the first run, save the object using `saveRDS(df, "brenda.rds")` and reload it with `readRDS()` in future sessions.
- **Parallelization**: `QueryBrenda` supports multi-core processing via the `n.core` parameter. While it defaults to all cores, using 2-4 cores often provides the best balance between speed and overhead.
- **Commentary**: Many fields include a `commentary` column. In these strings, `#ID#` refers to specific protein entries and `<ID>` refers to literature references.

## Reference documentation
- [brendaDb Vignette (Rmd)](./references/brendaDb.Rmd)
- [brendaDb Vignette (Markdown)](./references/brendaDb.md)