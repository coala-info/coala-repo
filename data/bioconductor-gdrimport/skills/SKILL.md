---
name: bioconductor-gdrimport
description: The bioconductor-gdrimport package imports, validates, and prepares raw drug response data for the gDR ecosystem. Use when user asks to load drug response manifests and results, convert between gDR MultiAssayExperiment and PharmacoGx PharmacoSet objects, or process PRISM datasets into gDR-compatible formats.
homepage: https://bioconductor.org/packages/release/bioc/html/gDRimport.html
---


# bioconductor-gdrimport

name: bioconductor-gdrimport
description: Expert guidance for using the gDRimport R package to import, validate, and prepare raw drug response data. Use this skill when you need to load drug response manifests, templates, or results (Tecan, D300, EnVision), convert between gDR MultiAssayExperiment (MAE) objects and PharmacoGx PharmacoSet (PSet) objects, or process PRISM dataset levels into gDR-compatible formats.

# bioconductor-gdrimport

## Overview
The `gDRimport` package is a core component of the gDR suite, designed to streamline the "onboarding" of raw dose-response data into the gDR ecosystem. It provides robust tools for loading experimental metadata (manifests and templates) and raw instrument readouts, validating their consistency, and merging them into a unified format for downstream analysis. Additionally, it facilitates interoperability with the `PharmacoGx` package and provides specialized importers for PRISM datasets.

## Core Workflows

### 1. Standard Data Loading
The primary entry point for most users is the `load_data()` function, which orchestrates the loading of the three essential components: the manifest, the templates, and the raw results.

```r
library(gDRimport)

# Load all data components at once
l_tbl <- load_data(
  manifest_file = "path/to/manifest.xlsx",
  template_file = "path/to/templates.xlsx",
  results_file = "path/to/results.xlsx"
)

# Alternatively, load components individually
manifest <- load_manifest("path/to/manifest.xlsx")
templates <- load_templates("path/to/templates.xlsx")
results <- load_results("path/to/results.xlsx")
```

### 2. Converting PharmacoSet to gDR Input
To use gDR's processing pipeline on curated datasets from `PharmacoGx`, use `convert_pset_to_df()`.

```r
library(PharmacoGx)

# Load a PSet
pset <- getPSet("Tavor_2020")

# Convert to data.table for gDRcore pipeline
dt <- convert_pset_to_df(pharmacoset = pset)

# Proceed to gDRcore processing
# se <- gDRcore::runDrugResponseProcessingPipeline(dt)
```

### 3. Converting gDR MAE to PharmacoSet
If you have processed data in a gDR `MultiAssayExperiment` and need to export it to a `PharmacoSet` for pharmacogenomic analysis:

```r
# mae is a gDR-generated MultiAssayExperiment
pset <- convert_MAE_to_PSet(mae, pset_name = "MyStudyName")

# Access the TreatmentResponseExperiment within the PSet
tre <- treatmentResponse(pset)
```

### 4. Processing PRISM Data
`gDRimport` supports both LEVEL5 (unified) and LEVEL6 (split) PRISM data formats.

```r
# LEVEL 5: Single file containing drugs, cell lines, and viability
convert_LEVEL5_prism_to_gDR_input("path/to/prism_level5.csv")

# LEVEL 6: Three separate files
convert_LEVEL6_prism_to_gDR_input(
  prism_data_path = "viability.csv",
  cell_line_data_path = "cell_lines.csv",
  treatment_data_path = "treatments.csv"
)
```

## Key Functions and Tips
- **Validation**: `load_data` performs internal validation to ensure that the identifiers in the manifest match those in the templates and results.
- **Instrument Support**: The package includes specific logic for handling outputs from Tecan, D300, and EnVision scanners.
- **Test Data**: Use `get_test_data()`, `get_test_Tecan_data()`, `get_test_D300_data()`, or `get_test_EnVision_data()` to explore expected file structures.
- **Subsetting**: When converting from PSets, the resulting `data.table` can be very large. It is often efficient to subset by `Clid` (Cell Line ID) or `DrugName` before running the full gDR pipeline.

## Reference documentation
- [Converting a gDR-generated MultiAssayExperiment object into a PharmacoSet](./references/ConvertingMAEtoPharmacoSet.md)
- [Converting PharmacoSet Drug Response Data into gDR object](./references/ConvertingPharmacoSetToGDR.md)
- [gDRimport Overview and Use Cases](./references/gDRimport.md)