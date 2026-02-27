---
name: bioconductor-netdx.examples
description: This package provides companion multi-omic datasets and grouping information for the netDx patient classification framework. Use when user asks to run netDx vignettes, perform integrative patient classification, or access example datasets for kidney cancer, breast cancer, or medulloblastoma.
homepage: https://bioconductor.org/packages/3.11/data/experiment/html/netDx.examples.html
---


# bioconductor-netdx.examples

name: bioconductor-netdx.examples
description: Access and use companion data for the netDx Bioconductor package. Use this skill when you need to run netDx vignettes, perform integrative patient classification, or access example datasets for kidney cancer (KIRC), breast cancer (TCGA-BRCA), or medulloblastoma (MB).

## Overview

The `netDx.examples` package is a data-only experiment package designed to support the `netDx` software. It provides pre-processed multi-omic datasets (gene expression, copy number variations, clinical data) and grouping information required to demonstrate patient-level network integration and clinical outcome prediction.

## Data Loading and Usage

To use the datasets in this package, first load the library and then use the `data()` function to bring specific objects into the R environment.

### Breast Cancer (TCGA-BRCA)
The `TCGA_BRCA` dataset contains multi-omic data for breast cancer subtyping.
```r
library(netDx.examples)
data(TCGA_BRCA)

# This loads three objects:
head(pheno)    # Patient metadata (ID, Type, STATUS)
head(xpr)      # Gene expression matrix (727 genes x 40 patients)
head(cnv_GR)   # GenomicRanges object with patient CNVs
```

### Kidney Cancer (KIRC)
Used for survival analysis examples.
```r
data(KIRC_dat)   # List containing "clinical" and "rna" dataframes
data(KIRC_pheno) # Metadata with survival STATUS and covariates
data(KIRC_group) # List defining feature groupings for clinical and RNA data

# Accessing specific components
rna_data <- KIRC_dat$rna
clinical_groups <- KIRC_group$clinical
```

### Medulloblastoma (MB)
Used for tumor subtype classification.
```r
data(MBlastoma)

# This loads:
head(MB.pheno)     # Gene expression values
head(MB.xpr)       # Patient ID and tumor subtype (STATUS)
head(MB.xpr_names) # Vector of gene symbols
```

### General Utility Data
```r
data(genes) # Small subsample of human gene definitions (RefSeq ID, chrom, TSS, etc.)
```

## Typical Workflow with netDx

1. **Initialize**: Load `netDx` and `netDx.examples`.
2. **Prepare Input**: Use `TCGA_BRCA` or `KIRC_dat` to define the input matrices for different "layers" (e.g., Proteomics, RNA-seq).
3. **Define Groups**: Use `KIRC_group` to tell `netDx` which features belong to which biological pathways or clinical categories.
4. **Run netDx**: Pass these example objects into the `buildPredictor()` or `makeNetwork()` functions in the main `netDx` package.

## Tips
- The `TCGA_BRCA` data is a subset; it is ideal for testing code logic before running on full TCGA datasets.
- Ensure `GenomicRanges` is loaded if you plan to manipulate `cnv_GR`.
- Most datasets use a `STATUS` column in the pheno data to define the prediction target for `netDx`.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)