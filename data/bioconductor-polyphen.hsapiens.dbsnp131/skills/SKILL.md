---
name: bioconductor-polyphen.hsapiens.dbsnp131
description: This package provides PolyPhen-2 functional impact predictions for human missense SNPs from dbSNP build 131. Use when user asks to retrieve functional impact scores, map rsIDs to amino acid substitutions, or query classifier probabilities for variants in the hg19/GRCh37 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/PolyPhen.Hsapiens.dbSNP131.html
---

# bioconductor-polyphen.hsapiens.dbsnp131

name: bioconductor-polyphen.hsapiens.dbsnp131
description: Access and query PolyPhen-2 predictions for human dbSNP build 131. Use this skill when you need to retrieve functional impact scores, amino acid substitutions, and classifier probabilities (HumDiv/HumVar) for specific rsIDs in the hg19/GRCh37 assembly.

# bioconductor-polyphen.hsapiens.dbsnp131

## Overview

The `PolyPhen.Hsapiens.dbSNP131` package is a specialized annotation database containing PolyPhen-2 (Polymorphism Phenotyping v2) predictions for approximately 110,940 human missense SNPs from dbSNP build 131. It allows researchers to map rsIDs to predicted damaging effects based on sequence homology and structural analysis.

## Core Workflow

### 1. Loading the Database
The database is loaded as a `PolyPhenDb` object.

```r
library(PolyPhen.Hsapiens.dbSNP131)
# The object is automatically available as PolyPhen.Hsapiens.dbSNP131
db <- PolyPhen.Hsapiens.dbSNP131
```

### 2. Inspecting Available Data
Use standard AnnotationDbi-style methods to explore the database schema.

```r
# View metadata (version, source, etc.)
metadata(db)

# List available columns (features like AA1, AA2, PPH2PROB)
columns(db)

# View the first few rsID keys
head(keys(db))
```

### 3. Querying Predictions
The `select` function is the primary interface for retrieving data. You must provide rsIDs as keys.

```r
rsids <- c("rs2142947", "rs3026284")

# Retrieve basic amino acid changes and predictions
select(db, keys = rsids, cols = c("AA1", "AA2", "PREDICTION"))

# Retrieve PolyPhen-2 specific scores and probabilities
# PPH2CLASS: Prediction category
# PPH2PROB: Probability score
select(db, keys = rsids, cols = c("PPH2CLASS", "PPH2PROB", "PPH2FPR"))
```

### 4. Handling Duplicate rsIDs
Some SNPs are reported under multiple rsIDs. Use `duplicateRSID` to check if an rsID has synonyms in the database.

```r
# Check for duplicates
duplicateRSID(db, c("rs71225486", "rs1063796"))
```

## Key Columns Reference

- **AA1 / AA2**: Reference and variant amino acids.
- **PREDICTION**: Qualitative impact (e.g., "probably damaging", "possibly damaging", "benign", or "unknown").
- **PPH2PROB**: The probability that a mutation is damaging (0 to 1).
- **PPH2CLASS**: The classifier result.
- **IDPMAX / IDPSNP / IDQMIN**: Internal substitution and identity scores used by the PolyPhen-2 algorithm.

## Usage Tips

- **Assembly Note**: This package is specific to dbSNP 131, which corresponds to the **hg19/GRCh37** human genome assembly.
- **Missing Predictions**: If a prediction is "unknown" or `NA`, it is usually due to an insufficient number of sequence homologs (`Nobs` column) or the site falling within a gapped alignment region.
- **Filtering**: Use `cols(db)` to see the full list of over 50 available features, including structural parameters like B-factors and H-bonds.

## Reference documentation

- [PolyPhen.Hsapiens.dbSNP131](./references/reference_manual.md)