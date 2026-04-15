---
name: bioconductor-easierdata
description: The easierData package provides essential datasets and model parameters required for predicting immune checkpoint inhibitor response. Use when user asks to retrieve bladder cancer datasets, access optimized model coefficients, or load curated gene signatures for immune response scoring.
homepage: https://bioconductor.org/packages/release/data/experiment/html/easierData.html
---

# bioconductor-easierdata

## Overview

The `easierData` package is a data-only Bioconductor experiment data package. It provides the essential data structures required by the `easier` package for predicting immune checkpoint inhibitor (ICI) response. It includes a large-scale bladder cancer dataset (Mariathasan 2018) and several internal objects such as optimized model parameters, TCGA pan-cancer expression statistics, and curated gene signatures for immune response scores (e.g., CYT, TLS, IFNy).

## Data Access Workflow

### 1. Listing Available Data
You can view all available datasets in the package using the `list_easierData()` function, which returns a table of ExperimentHub IDs and titles.

```r
library(easierData)
list_easierData()
```

### 2. Retrieving Data
There are two primary ways to retrieve data: using specific convenience functions (recommended) or via `ExperimentHub`.

**Using Convenience Functions:**
The package provides dedicated getters for each resource.
```r
# Load the exemplary bladder cancer dataset
se <- get_Mariathasan2018_PDL1_treatment()

# Load model parameters for ICI response prediction
models <- get_opt_models()

# Load gene signatures for immune response
signatures <- get_scores_signature_genes()
```

**Using ExperimentHub:**
```r
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "easierData")
data_obj <- eh[["EH6677"]] # Example for Mariathasan dataset
```

## Key Data Objects

| Object Name | Description | Format |
| :--- | :--- | :--- |
| `Mariathasan2018_PDL1_treatment` | Bladder cancer dataset (192 samples) with counts/TPM and metadata (BOR, TMB). | `SummarizedExperiment` |
| `opt_models` | Cancer-specific model coefficients for quantitative descriptors. | `list` of matrices |
| `TCGA_mean_pancancer` | Mean TPM expression per gene across TCGA for normalization. | `numeric` vector |
| `scores_signature_genes` | Curated signatures (CYT, TLS, IFNy, IMPRES, etc.). | `list` of character vectors |
| `intercell_networks` | Cancer-specific intercellular communication networks. | `list` |
| `HGNC_annotation` | Approved gene symbol annotations. | `data.frame` |

## Usage Tips

- **SummarizedExperiment:** When loading the Mariathasan dataset, use `assay(se, "tpm")` or `assay(se, "counts")` to access expression data, and `colData(se)` to access patient clinical metadata like Best Overall Response (BOR).
- **Normalization:** If you are performing your own analysis using the `easier` workflow, ensure you use `get_TCGA_mean_pancancer()` and `get_TCGA_sd_pancancer()` to standardize your input TPM data to match the training distribution of the models.
- **Gene Symbols:** Use `get_HGNC_annotation()` to verify or map gene symbols if your input data uses aliases, as the models are sensitive to gene naming.

## Reference documentation
- [easierData](./references/easierData.md)