---
name: bioconductor-hubmapr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/HuBMAPR.html
---

# bioconductor-hubmapr

name: bioconductor-hubmapr
description: Explore and retrieve data from the Human BioMolecular Atlas Program (HuBMAP) portal using the HuBMAPR R package. Use this skill to search for datasets, samples, donors, collections, and publications, retrieve metadata, trace provenance, and identify file transfer URLs (Globus/dbGaP) for single-cell and spatial biology data.

# bioconductor-hubmapr

## Overview

The `HuBMAPR` package provides an R interface to the Human BioMolecular Atlas Program (HuBMAP) data portal. It allows users to programmatically explore a global bio-molecular atlas of the human body at cellular resolution. The package interacts with HuBMAP's Search, Entity, and Ontology APIs to return data as tidy `tibble` objects, facilitating integration with `dplyr` and other Bioconductor workflows.

## Core Workflow

### 1. Data Discovery
Retrieve high-level summaries of the five main entity categories. These functions return tibbles containing primary identifiers (UUID and HuBMAP ID) and key metadata.

```r
library(HuBMAPR)

# List all available entities
ds <- datasets()
samp <- samples()
don <- donors()
coll <- collections()
pub <- publications()

# View default columns for an entity
datasets_default_columns(as = "character")

# List available organs and abbreviations
organ_list <- organ()
```

### 2. Detailed Entity Retrieval
Use a specific `uuid` to get full record details or metadata.

```r
# Get all available fields for a specific dataset
details <- dataset_detail("your_uuid_here")

# Retrieve specific metadata (Key-Value pairs)
ds_meta <- dataset_metadata("your_uuid_here")
samp_meta <- sample_metadata("your_uuid_here")
don_meta <- donor_metadata("your_uuid_here")
```

### 3. Relationship and Provenance Mapping
HuBMAP data is hierarchical. Use these functions to navigate ancestors (provenance) or descendants (derived data).

```r
# Trace lineage from sample/dataset back to donor
prov <- uuid_provenance("your_uuid_here")

# Find datasets derived from a specific sample
derived_ds <- sample_derived(uuid = "your_uuid_here", entity_type = "Dataset")

# Get datasets associated with a collection or publication
coll_data <- collection_data("collection_uuid")
pub_data <- publication_data("pub_uuid", entity_type = "Dataset")
```

### 4. File Transfer Information
Identify how to access the raw data files associated with a dataset.

```r
# Check access status and get Globus/dbGaP URLs
bulk_data_transfer("dataset_uuid")
```

## Usage Tips

*   **Identifiers**: Always prefer `uuid` (32-digit hex) for function arguments, though `hubmap_id` (e.g., HBM...) is more human-readable in tables.
*   **Caching**: The package uses temporary storage to cache API responses. This significantly speeds up repeated calls to `datasets()` or `samples()`.
*   **Data Wrangling**: Since outputs are tibbles, use `dplyr::filter()` on columns like `organ`, `dataset_type`, or `last_modified_timestamp` to narrow down searches.
*   **List Columns**: Functions like `dataset_detail()` often return list-columns. Use `tidyr::unnest()` or `dplyr::glimpse()` to explore these complex structures.

## Reference documentation

- [Explore Human BioMolecular Atlas Program Data Portal](./references/hubmapr_vignettes.Rmd)
- [Explore Human BioMolecular Atlas Program Data Portal (Markdown)](./references/hubmapr_vignettes.md)