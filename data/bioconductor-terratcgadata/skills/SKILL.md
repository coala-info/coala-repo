---
name: bioconductor-terratcgadata
description: The terraTCGAdata package integrates TCGA data from the Terra platform into the Bioconductor ecosystem by assembling clinical and assay data into MultiAssayExperiment objects. Use when user asks to browse TCGA cohorts, retrieve clinical or assay data from Terra workspaces, or create integrated MultiAssayExperiment objects for downstream analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/terraTCGAdata.html
---

# bioconductor-terratcgadata

## Overview

The `terraTCGAdata` package facilitates the integration of TCGA data hosted on the Terra platform into the Bioconductor ecosystem. It specifically targets workspaces using the `OpenAccess_V1-0` data model. The package allows users to browse available cohorts, identify specific clinical and assay data columns, and automatically assemble them into a `MultiAssayExperiment` for downstream analysis.

## Prerequisites

- **GCloud SDK**: A valid Google Cloud SDK installation is required.
- **Authentication**: You must be authenticated to Google Cloud/Terra to access the data.
- **Packages**: Requires `AnVIL` and `terraTCGAdata`.

```r
library(AnVIL)
library(terraTCGAdata)

# Check for gcloud installation
# Note: gcloud_exists() may be deprecated in favor of GCPtools::gcloud_exists()
AnVIL::gcloud_exists()
```

## Typical Workflow

### 1. Workspace Selection
Identify and set the target TCGA workspace.

```r
# List available TCGA workspaces
selectTCGAworkspace()

# Set a specific workspace for the session
terraTCGAworkspace("TCGA_COAD_OpenAccess_V1-0_DATA")

# Verify current setting
getOption("terraTCGAdata.workspace")
```

### 2. Data Discovery
Before downloading, explore the available clinical and assay columns within the workspace.

```r
# List clinical data columns
ct <- getClinicalTable()
names(ct)

# List assay data columns (e.g., RNA-seq, RPPA, Mutation)
at <- getAssayTable()
names(at)

# Summarize sample types (e.g., Primary Tumor vs Solid Tissue Normal)
sampleTypesTable()
```

### 3. Data Retrieval
You can retrieve specific components or the entire integrated experiment.

**Retrieve Clinical Data:**
```r
clin <- getClinical(
    columnName = "clin__bio__nationwidechildrens_org__Level_1__biospecimen__clin",
    participants = TRUE
)
```

**Retrieve Specific Assay Data:**
```r
# Retrieve a subset of data (e.g., first 4 samples)
prot_data <- getAssayData(
    assayName = "protein_exp__mda_rppa_core__mdanderson_org__Level_3__protein_normalization__data",
    sampleCode = c("01", "10"), # 01=Primary Tumor, 10=Blood Derived Normal
    sampleIdx = 1:4
)
```

### 4. Creating a MultiAssayExperiment
The primary function `terraTCGAdata` automates the retrieval and assembly of multiple assays and clinical data into a single object.

```r
mae <- terraTCGAdata(
    clinicalName = "clin__bio__nationwidechildrens_org__Level_1__biospecimen__clin",
    assays = c(
        "protein_exp__mda_rppa_core__mdanderson_org__Level_3__protein_normalization__data",
        "rnaseqv2__illuminahiseq_rnaseqv2__unc_edu__Level_3__RSEM_genes_normalized__data"
    ),
    sampleCode = NULL, # NULL includes all available sample types
    sampleIdx = 1:10   # Useful for testing small subsets
)
```

## Tips and Best Practices

- **Workspace Compatibility**: This package is designed for `OpenAccess_V1-0` workspaces. hg38/GDC harmonized data on Terra often uses a different data model and may not be compatible with these specific functions.
- **Sample Codes**: Use `sampleCode` to filter by tissue type (e.g., `"01"` for Primary Solid Tumor, `"11"` for Solid Tissue Normal).
- **Memory Management**: TCGA datasets are large. Use the `sampleIdx` argument to test your code on a small number of participants before attempting a full download.
- **Package-wide Options**: Setting `terraTCGAworkspace()` once at the start of your script removes the need to pass the `workspace` argument to every subsequent function call.

## Reference documentation

- [terraTCGAdata Introduction](./references/terraTCGAdata.md)