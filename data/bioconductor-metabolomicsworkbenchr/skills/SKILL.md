---
name: bioconductor-metabolomicsworkbenchr
description: This package provides an R interface to the Metabolomics Workbench REST API for searching and retrieving metabolomics study data, metabolite information, and chemical structures. Use when user asks to search metabolomics repositories, retrieve study metadata, download compound information, or import metabolomics data into Bioconductor objects like SummarizedExperiment and MultiAssayExperiment.
homepage: https://bioconductor.org/packages/release/bioc/html/metabolomicsWorkbenchR.html
---


# bioconductor-metabolomicsworkbenchr

## Overview

The `metabolomicsWorkbenchR` package provides an R interface to the Metabolomics Workbench REST API. It allows users to search a repository of over 1000 metabolomics studies, including raw and processed data, as well as metabolite and compound information. The package is particularly useful for bioinformaticians needing to programmatically retrieve metabolomics data and convert it into standard Bioconductor data structures.

## Core Workflow: Running Queries

The primary function is `do_query()`, which requires four arguments:
1.  `context`: The database category (e.g., "study", "compound", "refmet", "gene", "protein").
2.  `input_item`: The field to search within the context (e.g., "study_id", "study_title", "regno").
3.  `input_value`: The specific value or keyword to search for.
4.  `output_item`: The desired data format or specific information to return.

### Discovery and Metadata
To find valid parameters for a query:
```r
library(metabolomicsWorkbenchR)

# List all available contexts
names(metabolomicsWorkbenchR::context)

# List valid inputs and outputs for a specific context (e.g., "study")
context_inputs('study')
context_outputs('study')

# Search for studies by keyword
diabetes_studies <- do_query(
    context = 'study',
    input_item = 'study_title',
    input_value = 'Diabetes',
    output_item = 'summary'
)
```

### Retrieving Biological Entities
You can retrieve chemical structures (as images) or exact matches for compounds and genes:
```r
# Get compound info by registration number
compound_info <- do_query(
    context = 'compound',
    input_item = 'regno',
    input_value = '11',
    output_item = 'compound_exact'
)

# Get molecular structure image
img <- do_query(
    context = 'compound',
    input_item = 'regno',
    input_value = '11',
    output_item = 'png'
)
grid::grid.raster(img)
```

## Importing Data into Bioconductor Objects

One of the most powerful features is the ability to return data directly as S4 objects for analysis.

### SummarizedExperiment and MultiAssayExperiment
Use these for targeted or multi-assay studies:
```r
# Import a specific study as a SummarizedExperiment
se <- do_query(
    context = 'study',
    input_item = 'study_id',
    input_value = 'ST000001',
    output_item = 'SummarizedExperiment'
)

# Import a study with multiple assays (e.g., pos/neg modes)
mae <- do_query(
    context = 'study',
    input_item = 'study_id',
    input_value = 'ST000009',
    output_item = 'MultiAssayExperiment'
)
```

### Untargeted Data
Untargeted studies often require an `analysis_id` rather than a `study_id`.
```r
# Find untargeted studies first
untarg_list <- do_query(
    context = 'study',
    input_item = 'ignored',
    input_value = 'ignored',
    output_item = 'untarg_studies'
)

# Retrieve untargeted data as a DatasetExperiment (compatible with structToolbox)
de <- do_query(
    context = 'study',
    input_item = 'analysis_id',
    input_value = 'AN000025',
    output_item = 'untarg_DatasetExperiment'
)
```

## Tips and Special Cases
- **Partial vs. Exact Matching**: Use `output_item` suffixes like `_exact` or `_partial` (e.g., `gene_partial`) to control search stringency.
- **The "ignored" Input**: When requesting a list of all untargeted studies (`untarg_studies`), both `input_item` and `input_value` must be set to the string `"ignored"`.
- **Integration**: Data retrieved as `DatasetExperiment` is designed for immediate use with the `structToolbox` package for quality filtering, normalization, and multivariate analysis (PCA/PLS-DA).

## Reference documentation
- [Introduction to metabolomicsWorkbenchR](./references/Introduction_to_metabolomicsWorkbenchR.md)
- [Example using structToolbox](./references/example_using_structToolbox.md)