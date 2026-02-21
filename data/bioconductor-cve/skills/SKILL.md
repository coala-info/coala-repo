---
name: bioconductor-cve
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/CVE.html
---

# bioconductor-cve

name: bioconductor-cve
description: Interactive variant prioritisation in precision oncology using the CVE (Cancer Variant Explorer) R package. Use this skill to annotate variants via Oncotator, launch the CVE Shiny application for variant exploration, and utilize the melanoma co-expression network extension (WGCNAmelanoma) for pathway context.

## Overview
The `CVE` package provides a Shiny-based interactive framework for prioritizing cancer variants. It leverages Oncotator output (which integrates data from 14 resources) to help researchers identify relevant germline and somatic variants, assess DNA repair gene involvement, and evaluate druggability via the Drug Gene Interaction Database (DGIdb). A key feature is the ability to explore variants within a tumor-specific pathway context using co-expression modules.

## Core Workflows

### 1. Variant Annotation
If you have raw variant coordinates but not an Oncotator MAF file, use `get.oncotator.anno` to retrieve annotations.

```r
library(CVE)

# Define variants: chr, start, end, reference_allele, observed_allele
variants <- data.frame(
  chr = c("10", "10"),
  start = c("100894110", "100985376"),
  end = c("100894110", "100985376"),
  ref_allele = c("T", "C"),
  obs_allele = c("G", "A")
)

# Retrieve annotation from Oncotator
annotated_vars <- get.oncotator.anno(variants)
```

### 2. Launching the Explorer
The primary interface is the Shiny app. It accepts dataframes or lists of Oncotator output files.

```r
# For a single patient (e.g., using built-in colorectal cancer case)
data(crcCase)
openCVE(crcCase, sample_names = "CRC_Patient_01")

# For a cohort with an extension (e.g., melanoma WGCNA)
data(melanomaCase)
openCVE(melanomaCase, sample_names = "Melanoma_Cohort", extension = "WGCNAmelanoma")
```

### 3. Using Extensions
The `WGCNAmelanoma` extension provides functional context for variants in melanoma. It uses several internal datasets (Gene Significance `GS_` and Module Significance `MS_`) to correlate variants with clinical features like:
*   Survival (`GS_survival`, `MS_survival`)
*   UV signature (`GS_UV`, `MS_UV`)
*   Vemurafenib resistance (`GS_Vem`, `MS_vem`)
*   Lymphocyte score (`GS_lscore`, `MS_lscore`)

## Data Structures
*   **Input**: CVE expects a dataframe (or list of dataframes) formatted as Oncotator MAF files.
*   **Sample Names**: Always provide a character vector for `sample_names` matching the number of files/dataframes in `x`.
*   **WGCNA Data**: The package includes pre-calculated modules for the top 5000 most variant genes in TCGA RNAseq data (`genes_WGCNA`, `modules`, `MM`).

## Tips
*   **Oncotator Dependency**: CVE is designed specifically around the Oncotator annotation schema. Ensure your input columns match the expected MAF format.
*   **Interactive Prioritization**: Once the app is open, use the sidebar filters to narrow down variants based on functional prediction scores or presence in specific cancer gene lists.
*   **Druggability**: Use the DGIdb integration within the Shiny UI to find potential drug-gene interactions for your prioritized variants.

## Reference documentation
- [Cancer Variant Explorer Reference Manual](./references/reference_manual.md)