---
name: bioconductor-xcir
description: This tool performs statistical modeling of X-chromosome inactivation (XCI) using allele-specific RNA-Seq data. Use when user asks to estimate X-chromosome skewing, identify genes that escape inactivation, or analyze allele-specific expression from X-linked SNPs.
homepage: https://bioconductor.org/packages/3.10/bioc/html/XCIR.html
---

# bioconductor-xcir

name: bioconductor-xcir
description: Statistical modeling for X-chromosome inactivation (XCI) analysis. Use this skill to estimate X-chromosome skewing (mosaicism) and identify genes that escape XCI from allele-specific RNA-Seq counts.

# bioconductor-xcir

## Overview
The `XCIR` package provides a statistical framework to analyze X-chromosome inactivation using allele-specific expression (ASE) data. It implements beta-binomial mixture models to estimate the fraction of inactivation for each parental X chromosome (skewing) and performs hypothesis testing to identify X-linked genes that escape silencing.

## Core Workflow

### 1. Data Input and Pre-processing
Load allele-specific counts from VCF files or data frames. The package requires columns for sample ID, chromosome, position, and allelic depths (AD).

```r
library(XCIR)
library(data.table)

# Read from VCF
vcf_path <- system.file("extdata/AD_example.vcf", package = "XCIR")
vcf_data <- readVCF4(vcf_path)

# Annotate SNPs with Gene information (defaults to hg38)
# Use release argument for other versions (e.g., release = 37)
anno_data <- annotateX(vcf_data, mirror = "useast")
```

### 2. Gene-Level Summarization
Aggregate SNP-level data into gene-level counts.
- If phasing is known: Sum all SNPs within a gene.
- If phasing is unknown: Use the most highly expressed SNP per gene.

```r
# Phased data (highest_expr = TRUE sums counts)
genic_data <- getGenicDP(anno_data, highest_expr = TRUE)

# Unphased data (highest_expr = FALSE picks top SNP)
genic_data <- getGenicDP(anno_data, highest_expr = FALSE)
```

### 3. Modeling Skewing and Escape
The `betaBinomXI` function is the primary tool for estimation and inference. It requires a set of "training genes" (known XCI genes) to estimate the subject-level skewing parameter ($f$).

```r
# Load training genes (known to be silenced)
xcig <- readLines(system.file("extdata/xcig_vignette.txt", package = "XCIR"))

# Fit model
# model = "BB": Simple Beta-Binomial
# model = "MM": Mixture model (handles sequencing errors/outliers)
# model = "AUTO": AIC-based model selection (Recommended)
results <- betaBinomXI(genic_data, xciGenes = xcig, model = "AUTO")

# Annotate escape status based on p-value
results[, status := ifelse(p_value < 0.05, "E", "S")]
```

### 4. Result Interpretation and Quality Control
Use helper functions to summarize subject-level parameters or gene-level consensus across a cohort.

```r
# Subject-level summary (skewing estimate 'f' and model used)
subject_summary <- sample_clean(results)

# Gene-level consensus across the dataset
# Categorizes as Silenced (S), Variable Escape (VE), or Escape (E)
gene_status <- getXCIstate(results)

# Visual QC for a specific sample
plotQC(results[sample == "sample_id"], xcig = xcig)
```

## Key Functions
- `readVCF4()`: Extracts AD (Allelic Depth) fields from VCF files.
- `annotateX()`: Maps X-linked SNPs to genes using biomaRt.
- `getGenicDP()`: Collapses SNP counts to gene counts.
- `betaBinomXI()`: Main modeling function for skewing and escape testing.
- `getXCIstate()`: Summarizes escape frequency across multiple samples.

## Reference documentation
- [Introduction to XCIR](./references/xcir_intro.md)
- [XCIR Rmd Source](./references/xcir_intro.Rmd)