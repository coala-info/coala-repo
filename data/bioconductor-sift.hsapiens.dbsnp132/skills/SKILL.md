---
name: bioconductor-sift.hsapiens.dbsnp132
description: This tool provides SIFT functional predictions for human non-synonymous variants based on dbSNP build 132. Use when user asks to predict the effect of amino acid substitutions on protein function, retrieve SIFT scores for specific rsIDs, or identify deleterious variants in human genomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/SIFT.Hsapiens.dbSNP132.html
---


# bioconductor-sift.hsapiens.dbsnp132

name: bioconductor-sift.hsapiens.dbsnp132
description: Access and query SIFT (Sorting Intolerant From Tolerant) predictions for Homo sapiens dbSNP build 132. Use this skill when you need to predict the effects of coding non-synonymous variants on protein function using the SIFT algorithm for specific rsIDs.

## Overview

The `SIFT.Hsapiens.dbSNP132` package is an annotation database containing SIFT predictions for approximately 437,544 human SNPs from dbSNP build 132. SIFT scores help determine whether an amino acid substitution is likely to affect protein function based on sequence homology and the physical properties of amino acids.

## Basic Usage

### Loading the Package
```r
library(SIFT.Hsapiens.dbSNP132)
```

### Exploring Metadata and Columns
To understand the database version and available data fields:
```r
# View package metadata
metadata(SIFT.Hsapiens.dbSNP132)

# List available columns for selection
cols(SIFT.Hsapiens.dbSNP132)

# View the first few available keys (rsIDs)
head(keys(SIFT.Hsapiens.dbSNP132))
```

### Querying Predictions
Use the `select` function to retrieve SIFT predictions for specific rsIDs.

```r
# Define target rsIDs
rsids <- c("rs17970171", "rs2142947", "rs3026284")

# Select specific columns (e.g., RSID, METHOD, PREDICTION, SCORE)
subst <- c("RSID", "METHOD", "PREDICTION", "SCORE")
res <- select(SIFT.Hsapiens.dbSNP132, keys = rsids, cols = subst)

# View results
print(res)
```

## Interpreting Results

- **SCORE**: SIFT scores range from 0 to 1. 
- **PREDICTION**: 
    - **DELETERIOUS**: Scores less than or equal to 0.05. The substitution is predicted to affect protein function.
    - **TOLERATED**: Scores greater than 0.05. The substitution is predicted to be benign.
- **METHOD**: Indicates the specific SIFT algorithm version or parameters used (e.g., PSI-BLAST).

## Workflow Tips

1. **Key Format**: Ensure keys are provided as character vectors of rsIDs (e.g., "rs" followed by numbers).
2. **Column Descriptions**: Detailed descriptions of the data columns can be found using the R help system: `?SIFTDbColumns`.
3. **Integration**: This package is often used in conjunction with `VariantAnnotation` to predict the functional impact of variants identified in VCF files, provided the variants map to dbSNP 132.

## Reference documentation

- [SIFT.Hsapiens.dbSNP132 Reference Manual](./references/reference_manual.md)