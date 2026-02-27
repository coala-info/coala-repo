---
name: bioconductor-plethy
description: This tool imports, stores, and analyzes Buxco plethysmography data using an SQLite database framework. Use when user asks to parse Buxco CSV files, query respiratory phenotypes, or add experimental annotations to plethysmography datasets.
homepage: https://bioconductor.org/packages/3.5/bioc/html/plethy.html
---


# bioconductor-plethy

name: bioconductor-plethy
description: Specialized workflow for importing, storing, and analyzing Buxco plethysmography data using the plethy R package. Use this skill when you need to parse Buxco CSV files into SQLite databases, query respiratory phenotypes (like Penh, TVb, f), or add experimental annotations to plethysmography datasets.

# bioconductor-plethy

## Overview

The `plethy` package provides a framework for managing large-scale plethysmography data. It solves the problem of handling voluminous Buxco Finepointe outputs by importing them into a structured SQLite database. This allows for efficient memory management, as data is queried in subsets rather than loaded entirely into R's RAM.

## Core Workflow

### 1. Database Creation and Parsing
The primary entry point is parsing a raw Buxco CSV file into a new SQLite database.

```r
library(plethy)

# Define paths
csv_file <- "path/to/Buxco_Data.csv"
db_path <- "plethy_data.db"

# Parse file into database
# chunk.size limits memory usage during import
parse.buxco(file.name = csv_file, 
            db.name = db_path, 
            chunk.size = 500, 
            verbose = FALSE)
```

### 2. Accessing the Database
Once the database is created, use a `BuxcoDB` object to interact with it.

```r
# Create the interface object
bux.db <- makeBuxcoDB(db.name = db_path)

# Explore available metadata
samples(bux.db)    # List animal/subject IDs
variables(bux.db)  # List measured parameters (e.g., "f", "Penh", "TVb")
tables(bux.db)     # List internal database tables
```

### 3. Adding Annotations
Buxco files often contain "Acclimation" (ACC) and "Experimental" (EXP) phases. You can label these and calculate time offsets without modifying the raw data.

```r
# Infer days past first measurement
addAnnotation(bux.db, query = day.infer.query, index = FALSE)

# Label measurement types (ACC vs EXP)
addAnnotation(bux.db, query = break.type.query, index = TRUE)

# Check available annotation columns and their levels
annoCols(bux.db)
annoLevels(bux.db)
```

### 4. Data Retrieval
Retrieve specific subsets of data for statistical analysis or plotting.

```r
# Retrieve specific variables for specific samples
data_sub <- retrieveData(bux.db, 
                         samples = c("Mouse1", "Mouse2"), 
                         variables = "Penh")

# Retrieve data with annotation constraints
# Note: Annotation columns are passed as named arguments
exp_data <- retrieveData(bux.db, 
                         variables = "f", 
                         Break_type_label = "EXP",
                         Days = 0)
```

## Common Variables
Buxco data typically includes:
- `f`: Frequency (breaths/min)
- `TVb`: Tidal volume
- `MVb`: Minute volume
- `Penh`: Enhanced pause (bronchoconstriction index)
- `Ti` / `Te`: Inspiratory / Expiratory time

## Tips for Efficiency
- **Memory Management**: Always use `retrieveData` with specific `samples` or `variables` arguments. Calling `retrieveData(bux.db)` with no arguments attempts to load the entire database into R, which may cause crashes on large datasets.
- **Indexing**: Set `index = TRUE` in the final `addAnnotation` call to speed up subsequent queries.
- **Finepointe Export**: Ensure Buxco files are exported from Finepointe as .csv or .txt. If the file contains non-standard headers (e.g., gas analysis), manually trim those header lines before running `parse.buxco`.

## Reference documentation
- [plethy vignette](./references/plethy.md)