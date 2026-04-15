---
name: bioconductor-omicsmlrepor
description: This tool accesses and manipulates harmonized, ontology-standardized metadata for human microbiome and cancer genomics datasets. Use when user asks to retrieve metadata from curatedMetagenomicData or cBioPortal, perform ontology-aware filtering with synonyms and descendants, or reshape metadata for AI/ML-ready workflows.
homepage: https://bioconductor.org/packages/release/bioc/html/OmicsMLRepoR.html
---

# bioconductor-omicsmlrepor

name: bioconductor-omicsmlrepor
description: Expert assistance for the OmicsMLRepoR Bioconductor package. Use this skill to access, search, and manipulate harmonized and ontology-standardized metadata for human microbiome (curatedMetagenomicData) and cancer genomics (cBioPortalData) datasets. This skill is essential for performing robust, ontology-aware filtering (synonyms, case-insensitivity, and descendant searching) and preparing AI/ML-ready omics datasets.

# bioconductor-omicsmlrepor

## Overview

OmicsMLRepoR provides access to harmonized and ontology-standardized metadata for major Bioconductor data resources. Its primary purpose is to improve the "AI/ML-readiness" of omics data by resolving redundancies and incorporating formal ontologies. It allows users to perform robust searches that account for synonyms and hierarchical relationships (descendants) in metadata fields like disease, body site, and treatment.

## Core Workflows

### 1. Loading Metadata
Use `getMetadata()` to retrieve the harmonized tables. Currently supported sources are "cMD" (curatedMetagenomicData) and "cBioPortal".

```r
library(OmicsMLRepoR)

# Load human microbiome metadata
cmd_meta <- getMetadata("cMD")

# Load cancer genomics metadata
cbio_meta <- getMetadata("cBioPortal")
```

### 2. Ontology-Aware Filtering
The `tree_filter()` function is the core tool for robust searching. Unlike standard `dplyr::filter()`, it is case-insensitive, includes synonyms, and can include descendant terms in the ontology tree.

```r
# Search for "Colorectal Carcinoma" (includes "CRC", "Colorectal Cancer", etc.)
crc_data <- cmd_meta %>% 
  tree_filter(disease, "Colorectal Carcinoma")

# Search for broad categories (includes all descendants of "Intestinal Disorder")
intestinal_studies <- cmd_meta %>% 
  tree_filter(disease, "Intestinal Disorder")

# Logical combinations (OR, AND, NOT)
multi_search <- cmd_meta %>% 
  tree_filter(disease, c("migraine", "diabetes"), "OR")
```

### 3. Reshaping Metadata
Some metadata columns contain multiple attributes delimited by `<;>`. Use these functions to transform the data shape:

*   `getWideMetaTb()`: Expands delimited columns into a wide format.
*   `getLongMetaTb()`: Flattens delimited columns into a long format (one row per attribute).
*   `getShortMetaTb()`: Collapses long-format data back into a summarized version.

```r
# Expand biomarker column
wide_biomarkers <- getWideMetaTb(cmd_meta, "biomarker")

# Flatten treatment names for easier filtering
long_treatments <- cbio_meta %>% 
  getLongMetaTb("treatment_name", "<;>")
```

### 4. Downloading Omics Data
Once metadata is filtered, use the IDs to retrieve the actual omics measurements.

**For curatedMetagenomicData:**
```r
# Filter metadata then return relative abundance data
cmd_data <- cmd_meta %>%
    tree_filter(disease, "Type 2 Diabetes Mellitus") %>%
    filter(sex == "Female") %>%
    returnSamples("relative_abundance", rownames = "short")
```

**For cBioPortalData:**
```r
# Filter for specific treatments and download via cBioPortal API
library(cBioPortalData)
cbio_api <- cBioPortal()

# Example: Get samples for a specific study identified in metadata
study_samples <- cbio_meta %>% 
  filter(studyId == "acc_tcga") %>% 
  pull(sampleId)

data_obj <- cBioPortalData(
    api = cbio_api,
    studyId = "acc_tcga",
    sampleIds = study_samples,
    by = "hugoGeneSymbol"
)
```

## Tips for Success
*   **Ontology Columns:** `tree_filter` works on attributes mapped to ontologies. You can identify these by looking for columns ending in `_ontology_term_id`.
*   **Combining with dplyr:** `tree_filter` returns a data frame/tibble, so it can be piped directly into `filter()`, `select()`, or `mutate()`.
*   **Case Insensitivity:** You do not need to worry about capitalization when using `tree_filter()`.

## Reference documentation
- [Quickstart](./references/Quickstart.Rmd)