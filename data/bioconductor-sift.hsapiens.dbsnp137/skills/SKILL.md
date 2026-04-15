---
name: bioconductor-sift.hsapiens.dbsnp137
description: This tool provides pre-computed SIFT and PROVEAN scores for human coding variants in dbSNP build 137. Use when user asks to predict the functional impact of non-synonymous SNPs, retrieve SIFT or PROVEAN scores for human variants, or filter sequence variants based on predicted protein damage.
homepage: https://bioconductor.org/packages/release/data/annotation/html/SIFT.Hsapiens.dbSNP137.html
---

# bioconductor-sift.hsapiens.dbsnp137

name: bioconductor-sift.hsapiens.dbsnp137
description: Access pre-computed SIFT and PROVEAN scores for Homo sapiens dbSNP build 137. Use this skill when you need to predict the functional impact (deleterious/damaging vs. neutral/tolerated) of non-synonymous SNPs or indels in human proteins using the SIFT.Hsapiens.dbSNP137 Bioconductor annotation package.

## Overview

The `SIFT.Hsapiens.dbSNP137` package provides a static database of PROVEAN (Protein Variation Effect Analyzer) and SIFT (Sorting Intolerant From Tolerant) predictions for human coding variants found in dbSNP build 137. While SIFT is no longer actively maintained, its scores are provided alongside PROVEAN scores. This package is primarily used to filter sequence variants to identify those likely to affect protein function.

## Basic Usage

### Loading the Package
The package loads a `PROVEANDb` object named `SIFT.Hsapiens.dbSNP137`.

```r
library(SIFT.Hsapiens.dbSNP137)
# The object is now available in the global environment
SIFT.Hsapiens.dbSNP137
```

### Exploring the Database
Use standard AnnotationDbi-style methods to explore the available data.

```r
# View metadata (data source, versions, etc.)
metadata(SIFT.Hsapiens.dbSNP137)

# List available columns for retrieval
columns(SIFT.Hsapiens.dbSNP137)

# Get all available keys (NCBI dbSNP IDs)
dbsnp_ids <- keys(SIFT.Hsapiens.dbSNP137)
head(dbsnp_ids)
```

### Querying Scores
Use the `select()` function to retrieve predictions for specific dbSNP IDs.

```r
# Query specific IDs for specific columns
ids <- c("rs2843152", "rs104894357")
cols <- c("VARIANT", "PROVEANPRED", "SIFTPRED", "SIFTSCORE")

results <- select(SIFT.Hsapiens.dbSNP137, keys = ids, columns = cols)
```

## Data Interpretation

### SIFT Scores
- **SIFTSCORE**: Ranges from 0 to 1.
- **SIFTPRED**: 
  - `damaging`: Score <= 0.05
  - `tolerated`: Score > 0.05

### PROVEAN Scores
- **PROVEANSCORE**: Numerical score representing the impact.
- **PROVEANPRED**:
  - `deleterious`: Score <= -2.5
  - `neutral`: Score > -2.5

## Key Columns Reference
- **DBSNPID**: NCBI dbSNP ID (the primary key).
- **VARIANT**: Chromosome, position, and alleles.
- **PROTEINID**: Ensembl protein ID.
- **POS**: Position of the affected amino acid residue.
- **RESIDUEREF / RESIDUEALT**: Reference and variant amino acids.
- **SIFTMEDIAN**: Measures the diversity of sequences used for the SIFT prediction.

## Workflow: Filtering for Deleterious Variants
A common workflow involves retrieving scores for a list of variants and filtering for those predicted as "damaging" by SIFT or "deleterious" by PROVEAN.

```r
# Example: Get all info for a set of SNPs and filter
my_keys <- keys(SIFT.Hsapiens.dbSNP137)[1:50]
res <- select(SIFT.Hsapiens.dbSNP137, keys = my_keys, 
              columns = c("SIFTPRED", "PROVEANPRED", "SIFTSCORE"))

# Filter for variants where both algorithms agree on a functional impact
deleterious_variants <- res[res$SIFTPRED == "damaging" & 
                            res$PROVEANPRED == "deleterious", ]
```

## Reference documentation
- [SIFT.Hsapiens.dbSNP137 Reference Manual](./references/reference_manual.md)