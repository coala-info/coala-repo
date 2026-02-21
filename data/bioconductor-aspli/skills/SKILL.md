---
name: bioconductor-aspli
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ASpli.html
---

# bioconductor-aspli

name: bioconductor-aspli
description: Analysis of alternative splicing (AS) using RNA-seq data. Use this skill to parse genome annotations into subgenic bins, count read overlaps, calculate inclusion indices (PSI, PIR, PJU), and perform differential splicing analysis using a GLM framework (edgeR-based). Suitable for pairwise comparisons, complex factorial designs, and paired experimental designs.

# bioconductor-aspli

## Overview

ASpli is an integrative R package designed to analyze alternative splicing (AS) by combining bin-based signals with junction inclusion indices. It decomposes genome annotations into "bins" (maximal sub-genic features) and uses a generalized linear model (GLM) framework to detect differential usage. It supports both annotation-dependent and annotation-independent (novel junction) discovery.

## Core Workflow

### 1. Genome Binning
The first step is to convert a `TxDb` object into subgenic features.

```R
library(ASpli)
library(GenomicFeatures)

# Create TxDb from GTF
txdb <- txdbmaker::makeTxDbFromGFF("genes.gtf")

# Extract features (bins, junctions, genes)
features <- binGenome(txdb)

# Optional: Add gene symbols
# symbols <- data.frame(row.names = genes(txdb), symbol = c(...))
# features <- binGenome(txdb, geneSymbols = symbols)
```

### 2. Read Counting
Define a `targets` data frame containing BAM paths and experimental factors.

```R
targets <- data.frame(
  row.names = c("S1", "S2", "S3", "S4"),
  bam = c("s1.bam", "s2.bam", "s3.bam", "s4.bam"),
  genotype = c("WT", "WT", "KO", "KO"),
  stringsAsFactors = FALSE
)

# Count reads against features
gbcounts <- gbCounts(
  features = features, 
  targets = targets, 
  minReadLength = 100, 
  libType = "PE", 
  strandMode = 1
)
```

### 3. Junction Analysis and Inclusion Indices
Calculate PSI (Percent Spliced In), PIR (Percent of Intron Retention), and PJU (Percent Junction Usage).

```R
# Summarize junctions and calculate indices
asd <- jCounts(
  counts = gbcounts, 
  features = features, 
  minReadLength = 100,
  threshold = 5 # Min reads supporting junction
)

# Access indices
pir_table <- irPIR(asd)
psi_table <- esPSI(asd)
```

### 4. Differential Usage (DU) Reports
ASpli uses `edgeR` logic to test for differential bin and junction usage.

```R
# Bin-based differential usage
# contrast: -1 for control, 1 for treatment
gb_report <- gbDUreport(gbcounts, contrast = c(-1, 1))

# Junction-based differential usage
jdu_report <- jDUreport(asd, contrast = c(-1, 1))
```

### 5. Integration and Export
Consolidate signals into a single report and export to interactive HTML.

```R
# Integrate bin and junction signals
sr <- splicingReport(gb_report, jdu_report, counts = gbcounts)

# Region-specific summarization
is <- integrateSignals(sr, asd)

# Export to HTML (requires merged BAMs for coverage plots)
mBAMs <- data.frame(
  bam = c("WT_merged.bam", "KO_merged.bam"),
  condition = c("WT", "KO")
)

exportIntegratedSignals(
  is, 
  sr = sr, 
  output.dir = "ASpli_Results",
  counts = gbcounts, 
  features = features, 
  asd = asd, 
  mergedBams = mBAMs
)
```

## Advanced Usage

### Complex Designs
For factorial or paired designs, use the `formula` and `coef` arguments in `gbDUreport` and `jDUreport`.

```R
# Example: Paired design
form <- formula(~Subject + Treatment)
gb_paired <- gbDUreport(gbcounts, formula = form, coef = "Treatment")
```

### Uniformity Test
To filter false positive Intron Retention (IR) events caused by non-uniform coverage, enable the uniformity test in `jDUreport`.

```R
jdu <- jDUreport(asd, contrast = c(-1, 1), runUniformityTest = TRUE, mergedBams = mBAMs)
```

## Key Data Classes
- `ASpliFeatures`: Genomic coordinates for genes, bins, and junctions.
- `ASpliCounts`: Read counts and densities.
- `ASpliAS`: Junction inclusion indices (PSI, PIR, PJU).
- `ASpliDU`: Differential expression (genes) and usage (bins).
- `ASpliJDU`: Differential junction usage.
- `ASpliIntegratedSignals`: Final summarized splicing signals per region.

## Reference documentation
- [ASpli: An integrative R package for analysing alternative splicing using RNA-seq](./references/ASpli.md)