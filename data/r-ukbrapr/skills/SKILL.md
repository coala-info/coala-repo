---
name: r-ukbrapr
description: R package ukbrapr (documentation from project home).
homepage: https://cran.r-project.org/web/packages/ukbrapr/index.html
---

# r-ukbrapr

## Overview

The `ukbrapR` package streamlines workflows within the UK Biobank Research Analysis Platform (RAP). It provides high-level wrappers for phenotype extraction, diagnostic ascertainment across multiple coding vocabularies (ICD10, Read2, CTV3, etc.), and genetic data processing using tools like `bgenix` and `plink` directly within the RAP RStudio environment.

## Installation

```r
# Install from GitHub within the RAP Posit Workbench
remotes::install_github("lcpilling/ukbrapR")
```

## Diagnostic Ascertainment

Ascertaining conditions involves a three-step workflow using exported text files, which is more cost-effective than Spark-based queries.

### 1. Export Tables
Run once per project to save raw medical records to RAP persistent storage.
```r
ukbrapR::export_tables()
```

### 2. Get Diagnoses
Provide a data frame with `vocab_id` and `code`. Supported vocabularies: `ICD10`, `ICD9`, `Read2`, `CTV3`, `OPCS3`, `OPCS4`, `ukb_cancer`, `ukb_noncancer`.
```r
codes_df <- data.frame(
  condition = "ckd",
  vocab_id = c("ICD10", "ICD10"),
  code = c("N18.3", "N18.4")
)

diagnosis_list <- get_diagnoses(codes_df)
```

### 3. Determine Date of First Diagnosis
Combine sources into a single phenotype data frame.
```r
# Returns eid, date of first diagnosis (df), source (src), and binary indicators (bin)
diagnosis_df <- get_df(diagnosis_list, prefix = "ckd")

# For multiple conditions at once
diagnosis_df <- get_df(diagnosis_list, group_by = "condition")
```

## Genetic Variants

### Extract Genotypes
Extract variants from imputed BGEN files (Build 37) or DRAGEN WGS files (Build 38).
```r
# From imputed data (default)
varlist <- data.frame(rsid = c("rs1800562"), chr = 6)
genotypes <- extract_variants(varlist)

# From DRAGEN WGS (requires Build 38 positions)
varlist_b38 <- data.frame(chr = 6, pos = 26092913)
genotypes_wgs <- extract_variants(varlist_b38, source = "dragen")
```

### Create Polygenic Scores (PGS)
Calculates weighted allele scores using `plink`.
```r
weights <- data.frame(
  rsid = "rs2642438", chr = 1, pos = 220796686, 
  effect_allele = "A", other_allele = "G", beta = -0.177
)

pgs_df <- create_pgs(in_file = weights, pgs_name = "my_score")
```

## Utility Functions

### Labeling Fields
Convert integer-coded categorical fields into labeled factors using the UKB encoding schema.
```r
# Label a single field
ukb <- label_ukb_field(ukb_df, field = "p20116_i0")

# Label all UKB-formatted fields in a data frame
ukb <- label_ukb_fields(ukb_df)
```

### RAP File Management
Move files between the R session worker and RAP project storage.
```r
upload_to_rap("local_file.csv")
download_from_rap("project_file.csv")
```

### Spark Integration
If working in a Spark cluster (less recommended due to cost), pull phenotypes directly:
```r
ukb <- get_rap_phenos(c("eid", "p31", "p21003_i0"))
```

## Reference documentation
- [Ascertain diagnoses](./references/ascertain_diagnoses.html.md)
- [Home page](./references/home_page.md)
- [Label fields](./references/label_fields.html.md)
- [Spark functions](./references/spark_functions.html.md)