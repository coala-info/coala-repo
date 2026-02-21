---
name: bioconductor-hpar
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/hpar.html
---

# bioconductor-hpar

name: bioconductor-hpar
description: Interface to the Human Protein Atlas (HPA) for exploring the human proteome. Use this skill to query protein expression data in normal and cancer tissues, subcellular localization, and RNA-seq data from HPA, GTEx, and FANTOM5. Ideal for retrieving protein-level evidence, tissue specificity, and opening HPA web pages for specific Ensembl gene IDs.

## Overview
The `hpar` package provides an R interface to the Human Protein Atlas (HPA). It allows users to programmatically access datasets containing protein expression profiles across various tissues, cell lines, and subcellular compartments. Data is retrieved via the `ExperimentHub` infrastructure and returned as standard R `data.frames`.

## Core Workflows

### Loading the Package
```r
library("hpar")
# Displays version and HPA release info (e.g., HPA version 21.1)
```

### Discovering Available Data
Use `allHparData()` to see a table of all available datasets, their titles, and descriptions.
```r
hpa_datasets <- allHparData()
```

### Retrieving Specific Datasets
Datasets are loaded using specific accessor functions. The first call will download and cache the data via `ExperimentHub`.

*   **Normal Tissue Expression:** `hpaNormalTissue()`
*   **Cancer/Pathology Data:** `hpaCancer()`
*   **Subcellular Localization:** `hpaSubcellularLoc()`
*   **RNA Expression (Consensus):** `rnaConsensusTissue()`
*   **RNA Expression (Cell Lines):** `rnaGeneCellLine()`
*   **Secretome Data:** `hpaSecretome()`

### Querying by Gene
Most datasets use Ensembl Gene IDs (e.g., `ENSG00000000003`). You can filter the data frames using standard `dplyr` or base R.

```r
library(dplyr)
id <- "ENSG00000000003"

# Get subcellular location for a specific gene
subcell <- hpaSubcellularLoc() %>% filter(Gene == id)

# Get normal tissue staining levels
norm_tissue <- hpaNormalTissue() %>% filter(Gene == id)
```

### Web Interface
To open the detailed HPA project page for a specific gene in your default browser:
```r
browseHPA("ENSG00000000003")
```

## Data Interpretation Tips
*   **Reliability:** Pay attention to the `Reliability` column (e.g., "Approved", "Supported", "Enhanced"). It indicates the confidence of the antibody-based staining.
*   **Expression Levels:** The `Level` column in tissue data typically ranges from "Not detected" to "High".
*   **RNA Units:** RNA datasets provide values in `nTPM` (normalized Transcripts Per Million) for cross-source comparability.
*   **Versions:** Functions like `hpaNormalTissue16.1()` allow access to older HPA releases if reproducibility with previous studies is required.

## Release Information
To check the metadata of the HPA data currently being used:
*   `getHpaVersion()`: HPA release version.
*   `getHpaDate()`: Release date.
*   `getHpaEnsembl()`: Ensembl build version used for mapping.

## Reference documentation
- [Human Protein Atlas in R](./references/hpar.md)