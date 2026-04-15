---
name: bioconductor-ctdata
description: This tool provides access to curated cancer-testis gene expression and methylation datasets from normal, fetal, and neoplastic samples. Use when user asks to retrieve CT gene lists, access GTEx or TCGA omics data, analyze single-cell testis expression, or examine methylation levels in cancer cell lines.
homepage: https://bioconductor.org/packages/release/bioc/html/CTdata.html
---

# bioconductor-ctdata

name: bioconductor-ctdata
description: Access and utilize curated cancer-testis (CT) gene expression and methylation datasets. Use this skill when needing to retrieve omics data (RNA-seq, scRNA-seq, methylation) for normal adult tissues, fetal cells, tumor cell lines (CCLE), or patient samples (TCGA) to characterize CT genes.

# bioconductor-ctdata

## Overview

`CTdata` is a Bioconductor data package that provides a collection of omics datasets specifically curated for the identification and characterization of Cancer-Testis (CT) genes. It serves as the data companion to the `CTexploreR` package. The data includes gene expression (bulk and single-cell) and methylation levels across normal, fetal, and neoplastic samples. All data are served via `ExperimentHub` for efficient caching and retrieval.

## Core Workflows

### 1. Data Discovery
To see a summary of all available datasets within the package:

```r
library(CTdata)
CTdata()
```

### 2. Retrieving Curated CT Gene Lists
The package provides a pre-defined list of CT genes based on specific stringency criteria:

```r
# Get the curated list of 280 CT and CTP genes
ct_genes <- CT_genes()

# Get characterization for all genes (approx 24,488)
all_genes_data <- all_genes()
```

### 3. Accessing Normal Tissue Data
These datasets are essential for defining the "Testis-specific" or "Germline-restricted" status of genes.

```r
# GTEx normal tissue expression (SummarizedExperiment)
gtex <- GTEX_data()

# Normal tissues with multimapping reads (crucial for CT gene families)
normal_multi <- normal_tissues_multimapping_data()

# Single-cell RNA-seq from adult testis
testis_sc <- testis_sce()

# Promoter methylation in normal tissues
met_tissues <- methylation_in_tissues()
mean_met_tissues <- mean_methylation_in_tissues()
```

### 4. Accessing Fetal and Embryonic Data
Useful for studying the developmental timing of CT gene expression.

```r
# Fetal germ cell scRNA-seq
fgc <- FGC_sce()

# Embryonic stem cell (hESC) expression and methylation
hesc_exp <- hESC_data()
hesc_met <- mean_methylation_in_hESC()

# Early embryo scRNA-seq (Petropoulos or Zhu datasets)
embryo_zhu <- embryo_sce_Zhu()
```

### 5. Accessing Tumor and Cell Line Data
Used to verify the "Cancer" component of CT genes.

```r
# TCGA expression (TPM) and methylation for multiple cancer types
tcga_exp <- TCGA_TPM()
tcga_met <- TCGA_methylation()

# CCLE cancer cell line expression
ccle_exp <- CCLE_data()

# Gene expression correlation matrix in CCLE
cor_mat <- CCLE_correlation_matrix()
```

### 6. Demethylation Studies
Data from cell lines treated with 5-Aza-2'-Deoxycytidine (DAC) to identify genes regulated by DNA methylation.

```r
# Expression in DAC-treated vs Control cells
dac_data <- DAC_treated_cells()
```

## Data Structures and Tips

- **SummarizedExperiment / SingleCellExperiment**: Most expression datasets are returned as these standard Bioconductor objects. Use `assay(se, "TPM")` or `counts(sce)` to access values.
- **Multimapping**: Many CT genes belong to highly homologous gene families. Use `normal_tissues_multimapping_data()` or `DAC_treated_cells_multimapping()` when standard pipelines (which often discard multi-mapped reads) fail to detect expression.
- **Caching**: Data is downloaded once via `ExperimentHub` and stored locally. If you encounter download issues, check your `BiocFileCache` settings.
- **Version Note**: For versions of `CTdata` prior to 1.5, some functions had different prefixes (e.g., `CT_methylation_in_tissues` instead of `methylation_in_tissues`).

## Reference documentation

- [Cancer Testis Datasets](./references/CTdata.Rmd)
- [Cancer Testis Datasets](./references/CTdata.md)