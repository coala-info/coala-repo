---
name: bioconductor-octad.db
description: This package provides access to the Open Cancer TherApeutic Discovery database containing cancer patient gene expression profiles, compound data, and sample metadata. Use when user asks to retrieve cancer tissue expression profiles, access sample phenotype information, or load reference data for the OCTAD drug repurposing pipeline.
homepage: https://bioconductor.org/packages/release/data/experiment/html/octad.db.html
---


# bioconductor-octad.db

name: bioconductor-octad.db
description: Access and utilize the Open Cancer TherApeutic Discovery (OCTAD) database. Use this skill when you need to retrieve cancer patient gene expression profiles, sample metadata, or reference data required for the OCTAD drug repurposing pipeline.

# bioconductor-octad.db

## Overview

The `octad.db` package serves as the essential data repository for the OCTAD (Open Cancer TherApeutic Discovery) ecosystem. It provides access to a massive collection of processed data, including expression profiles for over 19,000 patient tissue samples across 50 cancer types and profiles for over 12,000 compounds. This package is a prerequisite for running the drug reversal potency scoring and in silico validation workflows found in the main `octad` package.

## Core Workflows

### Loading the Database
To begin using the database, load the library. It relies on `ExperimentHub` to manage and cache large datasets.

```r
library(octad.db)
```

### Retrieving Sample Metadata
The primary entry point for the OCTAD pipeline is selecting specific samples based on clinical or molecular features. The metadata (phenotype data) is stored as an ExperimentHub resource.

```r
# Load the data frame containing all samples in the OCTAD database
phenoDF <- get_ExperimentHub_data("EH7274")

# Explore available cancer types and sample sources
head(phenoDF)
table(phenoDF$cancer)
table(phenoDF$sample.type) # e.g., 'normal' vs 'primary'
```

### Data Structure
The `phenoDF` object contains critical columns for filtering:
- `sample.id`: Unique identifier for the tissue sample.
- `sample.type`: Classification (e.g., normal, primary, metastatic).
- `cancer`: The specific cancer type or "normal".
- `biopsy.site`: Anatomical location of the sample.
- `data.source`: Origin of the data (e.g., TCGA, GTEx).

### Accessing Example Results
The package provides example datasets representing outputs from the main `octad` analytical functions (`diffExp` and `runsRGES`). These are useful for testing downstream visualization or validation scripts without running the full pipeline.

```r
# Load example differential expression results
data("res_example", package='octad.db')

# Load example sRGES (Summarized Reversal Gene Expression Score) results
data("sRGES_example", package='octad.db')
```

## Usage Tips
- **Dependency**: Remember that `octad.db` provides the *data*, while the `octad` package provides the *functions* for deep-learning based reference selection and drug scoring.
- **Caching**: The first time you call `get_ExperimentHub_data`, the data will be downloaded. Subsequent calls will load from your local BiocFileCache, significantly speeding up the process.
- **Filtering**: Always filter `phenoDF` to define your "case" and "control" groups before proceeding to differential expression analysis in the main `octad` package.

## Reference documentation

- [Open Cancer TherApeutic Discovery (OCTAD) database](./references/octad.db.md)