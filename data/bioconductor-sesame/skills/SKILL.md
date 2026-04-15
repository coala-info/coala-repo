---
name: bioconductor-sesame
description: Bioconductor-sesame provides a comprehensive suite of tools for processing and analyzing Illumina Infinium DNA methylation data across various mammalian platforms. Use when user asks to process IDAT files into beta values, perform quality control, conduct differential methylation analysis, or infer sample metadata like sex, age, and ethnicity.
homepage: https://bioconductor.org/packages/release/bioc/html/sesame.html
---

# bioconductor-sesame

name: bioconductor-sesame
description: Comprehensive DNA methylation analysis for Illumina BeadChip arrays (EPICv2, EPIC, HM450, HM27, MM285, Mammal40). Use this skill for: (1) Processing IDAT files to beta values using the openSesame pipeline, (2) Quality control (QC) and signal detection analysis, (3) Differential methylation analysis (DML/DMR) using linear models, (4) Sample metadata inference (sex, age, ethnicity, strain), and (5) CpG enrichment analysis (KnowYourCG).

# bioconductor-sesame

## Overview
The `sesame` package provides a suite of tools for analyzing Illumina Infinium DNA methylation data. It is designed to be platform-agnostic and supports human, mouse, and various mammalian arrays. The package excels at automated preprocessing, quality control, and biological inference from methylation signals.

## Core Workflow: openSesame
The `openSesame` function is the primary entry point for converting raw IDAT files into a beta value matrix.

```r
library(sesame)
sesameDataCache() # Required once per installation

# Process a directory of IDATs
idat_dir <- "path/to/idat_folder"
betas <- openSesame(idat_dir)

# Custom preprocessing using prep codes
# Q: Quality mask, C: Channel inference, D: Dye bias, P: pOOBAH detection, B: Background subtraction
betas <- openSesame(idat_dir, prep = "QCDPB")
```

### Recommended Prep Codes
| Platform | Organism | Prep Code |
| :--- | :--- | :--- |
| EPIC/HM450 | Human | "QCDPB" |
| MM285 | Mouse | "TQCDPB" (T for strain inference) |
| Mammal40 | Human | "HCDPB" |
| Any | Non-human | Add "S" (e.g., "SQCDPB") |

## Quality Control
Use `sesameQC_calcStats` to evaluate sample quality.

```r
# Calculate QC stats on a SigDF object
sdf <- openSesame(idat_dir, func = NULL)[[1]]
qc <- sesameQC_calcStats(sdf)
qc

# Extract specific metrics
sesameQC_getStats(qc, "frac_dt") # Fraction of probes detected

# Rank against public datasets
sesameQC_rankStats(qc, platform = "EPIC")
```

## Differential Methylation (DML/DMR)
`sesame` uses a linear model framework for differential methylation.

```r
library(SummarizedExperiment)
# se is a SummarizedExperiment with beta values in assay() and metadata in colData()

# 1. Model Loci (DML)
smry <- DML(se, ~ tissue + sex)
test_result <- summaryExtractTest(smry)

# 2. Find Regions (DMR)
# Pick a contrast from dmContrasts(smry)
merged_regions <- DMR(se, smry, "sexMale")
```

## Sample Inference
Infer biological properties directly from the methylation data.

```r
# Sex and Ethnicity
inferSex(sdf)
inferEthnicity(sdf)

# Mouse Strain (for MM285)
inferStrain(sdf, return.strain = TRUE)

# Epigenetic Age (requires model file)
# model <- readRDS("path/to/clock_model.rds")
# predictAge(betas, model)
```

## CpG Enrichment (KnowYourCG)
Test if a set of CpGs is enriched for specific biological features.

```r
# query is a character vector of probe IDs
results <- testEnrichment(query, platform = "MM285")

# Visualize results
KYCG_plotEnrichAll(results)
KYCG_plotLollipop(results, label = "dbname")
```

## Tips
- **Caching**: Always run `sesameDataCache()` after installation or updates to ensure annotation data is available.
- **SigDF**: The `SigDF` object is the internal data structure for signal intensities. Use `func = NULL` in `openSesame` to return a list of `SigDF` objects instead of beta values.
- **Parallelization**: Use `BPPARAM = BiocParallel::MulticoreParam(n)` in `openSesame` or `DML` to speed up processing.

## Reference documentation
- [KnowYourCG](./references/KYCG.Rmd)
- [Quality Control](./references/QC.Rmd)
- [Quality Control (Markdown)](./references/QC.md)
- [Sample Metadata Inference](./references/inferences.Rmd)
- [Sample Metadata Inference (Markdown)](./references/inferences.md)
- [Modeling](./references/modeling.Rmd)
- [Modeling (Markdown)](./references/modeling.md)
- [Working with Non-human Array](./references/nonhuman.Rmd)
- [Working with Non-human Array (Markdown)](./references/nonhuman.md)
- [Basic Usage & Preprocessing](./references/sesame.Rmd)
- [Basic Usage & Preprocessing (Markdown)](./references/sesame.md)