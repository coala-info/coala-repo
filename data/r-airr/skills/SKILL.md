---
name: r-airr
description: The r-airr package provides tools to read, write, and validate Adaptive Immune Receptor Repertoire (AIRR) data according to community standards. Use when user asks to read or write Rearrangement TSV files, handle AIRR Data Model YAML/JSON files, or validate data structures for schema compliance.
homepage: https://cloud.r-project.org/web/packages/airr/index.html
---

# r-airr

name: r-airr
description: Expert guidance for the airr R package to read, write, and validate Adaptive Immune Receptor Repertoire (AIRR) data. Use this skill when working with AIRR-seq data structures, including Rearrangement TSV files and AIRR Data Model (Repertoire, GermlineSet) YAML/JSON files, ensuring compliance with AIRR Community standards.

## Overview
The `airr` package is the R reference implementation for the AIRR Data Representation Standards. It provides a standardized way to handle high-throughput sequencing data of B-cell and T-cell receptors, ensuring interoperability between different analysis tools and repositories.

## Installation
```r
install.packages("airr")
```

## Core Workflows

### Reading Data
The package distinguishes between tabular Rearrangement data and nested Data Models.

**Rearrangements (TSV):**
Use `read_rearrangement()` for V(D)J alignment annotations.
```r
library(airr)
# base="1" (default) for R-style 1-based closed intervals
# base="0" for Python-style 0-based half-open intervals
data <- read_rearrangement("path/to/file.tsv")
```

**Data Models (YAML/JSON):**
Use `read_airr()` for Repertoire, GermlineSet, or GenotypeSet metadata.
```r
# Automatically detects format (YAML or JSON)
repertoire <- read_airr("repertoire.yaml")
germline <- read_airr("germline.json")
```

### Writing Data
Ensure data is saved in the standardized AIRR format for compatibility with other tools.

```r
# Write Rearrangements
write_rearrangement(data, "output.tsv")

# Write Data Models (specify format)
write_airr(repertoire, "output.yaml", format="yaml")
write_airr(germline, "output.json", format="json")
```

### Validation
Validation ensures that the data structure and field names conform to the AIRR schema.

```r
# Validate a data.frame of rearrangements
is_valid <- validate_rearrangement(data)

# Validate an AIRR Data Model list
is_valid_rep <- validate_airr(repertoire)

# Validate individual records within a model
validate_airr(germline, each=TRUE)
```

## Key Functions Reference
- `read_rearrangement()`: Reads AIRR TSV files into a data.frame.
- `write_rearrangement()`: Writes a data.frame to AIRR TSV format.
- `read_airr()`: Reads AIRR YAML/JSON data models into nested lists.
- `write_airr()`: Writes AIRR data models to YAML/JSON.
- `validate_rearrangement()`: Checks if a data.frame meets Rearrangement schema requirements.
- `validate_airr()`: Checks if a list object meets AIRR Data Model schema requirements.

## Tips for Success
- **Coordinate Systems**: Always check if your input data is 0-based or 1-based. Use the `base` argument in `read_rearrangement` to normalize to R's 1-based system.
- **Schema Compliance**: Run `validate_rearrangement` before exporting data to ensure it will be readable by other AIRR-compliant software (like Change-O or Immcantation).
- **Data Structures**: `read_rearrangement` returns a `data.frame` (or `tibble`), while `read_airr` returns a nested `list` structure.

## Reference documentation
- [AIRR Data Representation Reference Library Usage](./references/Usage-Vignette.Rmd)