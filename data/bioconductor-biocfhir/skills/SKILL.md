---
name: bioconductor-biocfhir
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocFHIR.html
---

# bioconductor-biocfhir

## Overview

BiocFHIR provides infrastructure for handling FHIR R4 JSON data within the Bioconductor ecosystem. It simplifies the complex, nested structure of FHIR "Bundles" by flattening them into tabular data frames or representing them as network graphs. This package is particularly useful for clinical informatics workflows where patient records (often simulated via Synthea) need to be converted into structured formats for statistical analysis or visualization.

## Core Workflows

### 1. Ingesting FHIR Bundles
The primary entry point is `process_fhir_bundle()`, which takes a path to a FHIR JSON file and returns a list of data frames organized by resource type.

```r
library(BiocFHIR)

# Path to a FHIR JSON file
json_file <- system.file("json/some_patient.json", package="BiocFHIR")

# Initial decomposition
bundle <- process_fhir_bundle(json_file)
# Returns a list of data.frames (e.g., bundle$Patient, bundle$Observation)
```

### 2. Transforming Resources to Tables
Raw decomposed bundles are often sparse or contain nested lists. Use specific `process_*` functions to extract high-value fields into clean tables.

```r
# Extract clinical conditions
conditions_tab <- process_Condition(bundle$Condition)

# Extract observations (e.g., vitals, lab results)
observations_tab <- process_Observation(bundle$Observation)

# Extract patient demographics
patient_tab <- process_Patient(bundle$Patient)
```

Available processing functions include:
- `process_Condition()`
- `process_Observation()`
- `process_Patient()`
- `process_AllergyIntolerance()`
- `process_Encounter()`
- `process_Procedure()`
- `process_MedicationRequest()`

### 3. Working with Multiple Documents
To analyze a cohort, iterate over multiple JSON files and combine the results defensively (as not all bundles contain all resource types).

```r
# Generate a test set of 50 JSON files
files <- make_test_json_set()

# Process all and extract Conditions
all_bundles <- lapply(files, process_fhir_bundle)
has_cond <- sapply(all_bundles, function(x) length(x$Condition) > 0)
combined_conditions <- do.call(rbind, lapply(all_bundles[has_cond], function(x) process_Condition(x$Condition)))
```

### 4. Graph-Based Analysis and Visualization
BiocFHIR can represent the relationships between patients, conditions, and procedures as graphs.

```r
# Create a graph relating patients to conditions
# 'allin' is a provided dataset of 50 processed bundles
data(allin)
g <- make_condition_graph(allin)

# Add procedures to the graph
g <- add_procedures(g, allin)

# Interactive visualization (requires visNetwork)
ig <- build_proccond_igraph(allin)
display_proccond_igraph(ig)
```

### 5. Direct JSON Querying (Advanced)
For fields not covered by standard `process_*` functions, use `rjsoncons` for JMESPATH queries.

```r
library(rjsoncons)
library(jsonlite)

# Extract all patient addresses from a list of bundles
myl <- lapply(files[1:5], jsonlite::fromJSON)
addresses <- jmespath(myl, "[*].entry[0].resource.address") |> jsonlite::fromJSON()
```

## Tips and Best Practices
- **Schema Awareness**: Use `FHIR_retention_schemas()` to see which fields are currently extracted by the `process_*` functions.
- **Sparse Data**: FHIR data frames are inherently sparse. Always check for the existence of a resource type (e.g., `length(bundle$Condition) > 0`) before attempting to process it.
- **Patient Names**: Use `getHumanName(bundle$Patient)` to extract a readable string from the complex FHIR name structure.

## Reference documentation
- [Upper level FHIR concepts](./references/A_upper.md)
- [Handling FHIR documents with BiocFHIR](./references/B_handling.md)
- [BiocFHIR -- infrastructure for parsing and analyzing FHIR data](./references/BiocFHIR.md)
- [Transforming FHIR documents to tables with BiocFHIR](./references/C_tables.md)
- [Linking information between FHIR resources](./references/D_linking.md)