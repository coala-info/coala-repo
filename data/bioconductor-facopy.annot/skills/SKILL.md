---
name: bioconductor-facopy.annot
description: This package provides genome annotations and reference copy number alteration frequency data for use with the facopy Bioconductor package. Use when user asks to access chromosome arm limits, retrieve genomic feature locations, or compare experimental results against reference cancer datasets like TCGA and NCI60.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/facopy.annot.html
---

# bioconductor-facopy.annot

name: bioconductor-facopy.annot
description: Provides genome annotation and copy number alteration (CNA) frequency data for use with the facopy package. Use when performing CNA association or enrichment analyses in R, specifically for accessing chromosome arm limits, genomic features (oncogenes, miRNAs), and reference CNA frequencies from TCGA, GSK, and NCI60 for hg18, hg19, and mm8.

## Overview
The `facopy.annot` package is a companion data package for the `facopy` Bioconductor package. It provides essential genomic annotations required for copy number alteration (CNA) association and enrichment studies. This includes chromosome arm boundaries, locations of genomic features (like oncogenes and tumor suppressors), and reference CNA frequencies from major cancer databases.

## Data Access and Usage
The package primarily functions as a repository of datasets. You access the data using the standard R `data()` function.

```R
# Load the package
library(facopy.annot)

# List available datasets in the package
data(package = "facopy.annot")

# Load a specific dataset (e.g., hg19 oncogenes)
data(hg19_feature_oncogene)
head(hg19_feature_oncogene)
```

## Dataset Categories

### 1. Chromosome Arm Limits
Provides upper limits (in base pairs) for p and q arms.
*   **Naming:** `[build]_armLimits`
*   **Examples:** `hg18_armLimits`, `hg19_armLimits`, `mm8_armLimits`

### 2. Genomic Features
Positional information (chromosome, start, end, arm) for specific gene sets.
*   **Naming:** `[build]_feature_[collection]`
*   **Collections:** `ensembl`, `mirnas`, `oncogene`, `tumorsupressor`, `cancergene`, `lincRNA`
*   **Examples:** `hg19_feature_mirnas`, `hg18_feature_oncogene`

### 3. CNA Frequencies
Reference amplification and deletion frequencies across different cancer types and databases.
*   **Naming:** `[build]_db_[database]_[dataset]`
*   **Databases:** `tcga` (The Cancer Genome Atlas), `gsk` (GlaxoSmithKline), `nci60`
*   **Examples:** `hg19_db_tcga_brca` (Breast Cancer), `hg19_db_gsk_lung` (Lung Cancer)

### 4. Pathway Annotations
Gene sets with symbol identifiers for enrichment analysis.
*   **Datasets:** `facopy_biocarta`, `facopy_kegg`, `facopy_reactome`, `facopy_msigdb`

## Typical Workflow
1.  **Identify Build:** Determine the genome build of your study (e.g., hg19).
2.  **Load Reference:** Load the corresponding arm limits or feature sets to define the genomic architecture for `facopy`.
3.  **Comparative Analysis:** Load a database frequency dataset (e.g., `hg19_db_tcga_gbm`) to compare your experimental CNA results against established cancer profiles.
4.  **Enrichment:** Use the pathway objects (`facopy_kegg`) to interpret the biological significance of identified alterations.

## Tips
*   **Naming Convention:** Most datasets follow the `[genome][build]_...` pattern. If you are working with hg19, ensure you are not accidentally loading hg18 data.
*   **Data Structure:** Most feature and frequency datasets are returned as `data.frame` objects containing `chr`, `pos_st` (start), `pos_en` (end), and `freq` or `feature` columns.

## Reference documentation
- [facopy.annot Reference Manual](./references/reference_manual.md)