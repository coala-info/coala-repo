---
name: bioconductor-cnvgsadata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/cnvGSAdata.html
---

# bioconductor-cnvgsadata

name: bioconductor-cnvgsadata
description: Access and utilize the demonstration datasets for the cnvGSA (Copy Number Variation Gene-Set Analysis) R package. Use this skill when a user needs to run the cnvGSA vignette, test CNV enrichment workflows, or requires example files for rare CNV data, phenotypes, and gene-set GMT files.

## Overview

The `cnvGSAdata` package is a specialized data-only experiment package for Bioconductor. It provides the necessary input objects, raw text files, and pre-computed results required to demonstrate the `cnvGSA` package workflow. The data is modeled after the Pinto et al. (2014) Autism Spectrum Disorder (ASD) study.

## Data Access and Usage

The package contains two types of data: pre-built R objects (loaded via `data()`) and raw external files (accessed via `system.file()`).

### Loading Pre-built R Objects

These objects are ready for use with `cnvGSA` functions like `cnvGSAlogRegTest()`.

```r
library(cnvGSAdata)

# Load pre-built input object (class CnvGSAInput)
data("cnvGSA_input_example")
# Access the object: cnvGSA.in

# Load pre-built output object (class CnvGSAOutput)
data("cnvGSA_output_example")
# Access the object: cnvGSA.out

# Load gene-set data
data("gs_data_example")
# Access objects: gs_all.ls, gsid2name.chv
```

### Accessing Raw External Files

Use these files to practice data import and preprocessing steps.

| File Name | Description | Format |
|-----------|-------------|--------|
| `cnv_AGP_demo.txt` | Rare CNV data | GVF-like (Tab-delimited) |
| `ph_AGP_demo.txt` | Phenotype/Covariate data | Tab-delimited |
| `enrGMT_AGP_demo.gmt` | Gene-set definitions | GMT format |
| `gene_ID_demo.txt` | Entrez ID mapping | Tab-delimited |
| `kl_gene_AGP_demo.txt` | Genes of interest | Tab-delimited |
| `kl_loci_AGP_demo.txt` | Known loci | Tab-delimited |

**Example: Reading a raw file**
```r
# Get the path to the CNV data file
cnv_path <- system.file("extdata", "cnv_AGP_demo.txt", package="cnvGSAdata")

# Read into R
cnv_df <- read.table(cnv_path, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
```

## Workflow Integration

1. **Testing cnvGSA**: Use `cnvGSA.in` from `cnvGSA_input_example` to test the primary regression functions in the `cnvGSA` package without needing to format your own data first.
2. **Result Inspection**: Load `cnvGSA_output_example` to inspect the structure of `res.ls` (regression results) and `gsTables.ls` (gene-set tables) to understand what the analysis produces.
3. **Format Reference**: Use the raw `.txt` files in `extdata` as templates for formatting your own CNV and phenotype files for compatibility with the `cnvGSA` pipeline.

## Reference documentation

- [cnvGSAdata Reference Manual](./references/reference_manual.md)