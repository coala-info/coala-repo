---
name: bioconductor-sesamedata
description: This tool provides annotation data and processing functions for analyzing Illumina Infinium DNA methylation array data. Use when user asks to process IDAT files, calculate quality control metrics, infer sample metadata like sex or ethnicity, perform differential methylation analysis, or work with non-human methylation arrays.
homepage: https://bioconductor.org/packages/release/data/experiment/html/sesameData.html
---

# bioconductor-sesamedata

name: bioconductor-sesamedata
description: Comprehensive DNA methylation analysis using the SeSAMe and sesameData packages. Use when Claude needs to process Illumina Infinium BeadChip data (EPIC, HM450, MM285, Mammal40) for: (1) Preprocessing IDAT files to beta values, (2) Quality control and metric calculation, (3) Sample metadata inference (sex, age, ethnicity), (4) Differential methylation analysis (DML/DMR), or (5) Working with non-human (mouse, mammal) arrays.

# bioconductor-sesamedata

## Overview
The `sesameData` package provides essential annotation data and example datasets for the `sesame` R package. Together, they offer a suite of tools for analyzing Illumina Infinium DNA methylation arrays. The workflow typically involves reading raw IDAT files, applying specialized preprocessing (background subtraction, dye bias correction), and performing downstream statistical modeling or biological inference.

## Core Workflow: IDAT to Beta Values
The `openSesame` function is the primary entry point for end-to-end processing.

```r
library(sesame)
library(sesameData)

# CRITICAL: Run once per installation to cache annotations
sesameDataCache()

# Process a directory of IDATs
idat_dir <- "path/to/idat_folder"
betas <- openSesame(idat_dir)

# Custom preprocessing (e.g., for EPIC array)
# Q: QualityMask, C: ChannelInference, D: DyeBias, P: pOOBAH, B: Background (Noob)
betas <- openSesame(idat_dir, prep = "QCDPB")
```

## Quality Control
Calculate and rank quality metrics to identify problematic samples.

```r
# Calculate stats for a SigDF object
sdf <- sesameDataGet('EPIC.1.SigDF')
qc <- sesameQC_calcStats(sdf, funs = c("detection", "intensity"))

# Print QC summary
print(qc)

# Rank against public datasets
sesameQC_rankStats(qc, platform = "EPIC")

# Get specific metric
frac_dt <- sesameQC_getStats(qc, "frac_dt")
```

## Metadata Inference
Infer biological properties from the methylation data to validate sample integrity.

```r
# Sex and Karyotype inference
inferSex(sdf)
inferSexKaryotypes(sdf)

# Ethnicity inference (Human)
inferEthnicity(sdf)

# Age prediction (Epigenetic Clock)
# Requires downloading specific model RDS files
betas <- getBetas(sdf)
# predictAge(betas, model) 

# Cell count deconvolution (Leukocyte fraction)
estimateLeukocyte(betas)
```

## Differential Methylation (DML/DMR)
Model methylation variation against predictors (age, sex, tissue).

```r
library(SummarizedExperiment)
se <- sesameDataGet("MM285.10.SE.tissue")

# 1. Check levels to ensure enough data per group
se_ok <- checkLevels(assay(se), colData(se)$sex)
se <- se[se_ok,]

# 2. Fit Linear Model (DML)
smry <- DML(se, ~tissue + sex)

# 3. Extract test results
test_results <- summaryExtractTest(smry)

# 4. Identify Regions (DMR)
merged_dmr <- DMR(se, smry, "sexMale")
```

## Working with Non-Human Arrays (MM285, Mammal40)
Specialized functions for species and strain inference.

```r
# Species inference for Mammal40
sdf <- sesameDataGet("Mammal40.1.SigDF")
inferSpecies(sdf, return.species = TRUE)

# Mouse strain inference for MM285
sdf_mouse <- sesameDataGet("MM285.1.SigDF")
inferStrain(sdf_mouse, return.strain = TRUE)

# Recommended prep code for Mouse: "TQCDPB" (T: Strain inference)
betas_mouse <- openSesame(idat_dir, prep = "TQCDPB")
```

## Data Retrieval and Manifests
Accessing genomic coordinates and probe information.

```r
# Get manifest as GRanges
gr <- sesameData_getManifestGRanges("EPIC")

# Get probes by gene or region
probes <- sesameData_getProbesByGene("DNMT3A", "EPIC", promoter = TRUE)

# Annotate custom probe lists
input_probes <- c("cg14620903", "cg22464003")
regs <- sesameData_getTxnGRanges("hg38", merge2gene = TRUE)
sesameData_annoProbes(input_probes, regs, column = "gene_name")
```

## Reference documentation
- [KnowYourCG (Enrichment Analysis)](./references/KYCG.Rmd)
- [Quality Control](./references/QC.Rmd)
- [Sample Metadata Inference](./references/inferences.Rmd)
- [Differential Methylation Modeling](./references/modeling.Rmd)
- [Non-human Array Processing](./references/nonhuman.Rmd)
- [Basic Usage & Preprocessing](./references/sesame.Rmd)
- [sesameData User Guide](./references/sesameData.md)