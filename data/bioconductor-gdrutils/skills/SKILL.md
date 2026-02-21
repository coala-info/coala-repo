---
name: bioconductor-gdrutils
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/gDRutils.html
---

# bioconductor-gdrutils

## Overview
`gDRutils` is a utility package within the gDR platform designed to handle the infrastructure of drug response data. It provides standardized methods for interacting with `MultiAssayExperiment` and `SummarizedExperiment` objects, managing environment-wide identifiers (e.g., drug names, concentrations), and converting complex nested data into user-friendly flat formats (data.tables).

## Data Manipulation and Extraction

### MAEpply
Use `MAEpply` as a functional programming tool (similar to `lapply`) to apply functions across all experiments within a `MultiAssayExperiment` object.
```r
# Apply a function to each experiment
MAEpply(mae, dim)

# Extract and unify rowData across all experiments
MAEpply(mae, rowData, unify = TRUE)
```

### Converting Assays to Data Tables
To perform downstream analysis or visualization, convert nested assays into flat `data.table` objects.
```r
# From a MultiAssayExperiment
dt_metrics <- convert_mae_assay_to_dt(mae, "Metrics")

# From a SummarizedExperiment
se <- mae[[1]]
dt_se <- convert_se_assay_to_dt(se, "Metrics")
```

## Managing gDR Identifiers

gDR relies on specific keys for drugs, cell lines, and concentrations. You can inspect or modify these globally.

### Environment Identifiers
```r
# View all current identifiers
get_env_identifiers()

# Get a specific identifier
get_env_identifiers("concentration")

# Update an identifier (e.g., if your input uses 'Dose' instead of 'Concentration')
set_env_identifier("concentration", "Dose")

# Reset to defaults
reset_env_identifiers()
```

### Validating Identifiers
Ensure that a dataset contains the required columns mapped to the correct gDR identifiers.
```r
validated_ids <- validate_identifiers(
  dt, 
  req_ids = c("barcode", "duration", "template", "cellline")
)
```

## Data Validation
Before processing or after manual modifications, validate the structure of gDR objects to ensure compatibility with the pipeline.
```r
# Validate a full MultiAssayExperiment
validate_MAE(mae)

# Validate a single SummarizedExperiment
validate_SE(se)
```

## Prettifying for Reporting
Transform technical column names and assay names into human-readable formats, suitable for plots or tables.

### Prettifying Column Names
```r
raw_names <- c("CellLineName", "Tissue", "Concentration_2")
clean_names <- prettify_flat_metrics(raw_names, human_readable = TRUE)
# Result: "Cell Line Name", "Tissue", "Concentration 2"
```

### Prettifying Assay Names
```r
# Get standard prettified names for assays
get_assay_names()

# For combo-specific assays
get_combo_assay_names()
```

## Reference documentation
- [gDRutils Vignette (Rmd)](./references/gDRutils.Rmd)
- [gDRutils Vignette (Markdown)](./references/gDRutils.md)