---
name: bioconductor-raids
description: This tool infers genetic ancestry from human molecular data including DNA and RNA sequences using synthetic data for parameter optimization. Use when user asks to infer genetic ancestry, analyze ancestry in cancer-derived sequences, or optimize ancestry inference parameters using synthetic data.
homepage: https://bioconductor.org/packages/release/bioc/html/RAIDS.html
---

# bioconductor-raids

name: bioconductor-raids
description: Robust Ancestry Inference using Data Synthesis (RAIDS). Use this skill to infer genetic ancestry from human molecular data (DNA/RNA) including whole genomes, exomes, targeted panels, and cancer-derived sequences. It supports profile-specific parameter optimization using synthetic data.

# bioconductor-raids

## Overview

The `RAIDS` package provides a robust framework for genetic ancestry inference. It is particularly effective for "noisy" or non-standard molecular data, such as cancer-derived sequences or targeted panels, where traditional methods might fail. It works by synthesizing data specific to the input profile's coverage to optimize inference parameters ($D$ for PCA dimensions and $k$ for nearest neighbors) and estimate accuracy.

## Core Workflow

The standard workflow involves setting up a reference, sampling donors for synthesis, and running the inference.

### 1. Setup and Reference Data
You need two GDS files: a Population Reference GDS (genotypes) and a SNV Annotation GDS (phase/block info).

```r
library(RAIDS)
library(SNPRelate)

# Define paths to reference files (e.g., 1000 Genomes hg38)
refGenotype <- "path/to/matGeno1000g.gds"
refAnnotation <- "path/to/matAnnot1000g.gds"
pathProfileGDS <- "path/to/output_gds_folder/"
```

### 2. Sample Reference for Synthesis
Select donor profiles from the reference to create synthetic samples for parameter optimization.

```r
set.seed(3043) # For reproducibility
# nbProfiles: recommended 30 per sub-continental population for real studies
dataRef <- select1KGPopForSynthetic(fileReferenceGDS = refGenotype, 
                                    nbProfiles = 2L)
```

### 3. Infer Ancestry
Use `inferAncestry()` for DNA (WGS, WXS, Panels) or `inferAncestryGeneAware()` for RNA.

```r
# Requires chromosome lengths (e.g., from BSgenome.Hsapiens.UCSC.hg38)
library(Seqinfo)
library(BSgenome.Hsapiens.UCSC.hg38)
genome <- BSgenome.Hsapiens.UCSC.hg38::Hsapiens
chrInfo <- seqlengths(genome)[1:25] # 1-22, X, Y, M

# Run inference from a VCF (must be gzipped, containing GT, AD, DP)
resOut <- inferAncestry(
    profileFile = "sample.vcf.gz",
    pathProfileGDS = pathProfileGDS,
    fileReferenceGDS = refGenotype,
    fileReferenceAnnotGDS = refAnnotation,
    chrInfo = chrInfo,
    syntheticRefDF = dataRef,
    genoSource = "VCF"
)
```

## Data Formats

### Input Sources (`genoSource`)
- **"VCF"**: Gzipped VCF with `GT`, `AD`, and `DP` fields.
- **"generic"**: Comma-separated table with columns: `Chromosome`, `Position`, `Ref`, `Alt`, `Count`, `File1R` (Ref count), `File1A` (Alt count).

### Output Structure
The result is a list containing:
- `Ancestry`: A data.frame with `sample.id`, `D` (optimal PCA dims), `K` (optimal neighbors), and `SuperPop` (inferred ancestry).
- `paraSample`: Optimization metrics (AUROC).
- `pcaSample`: PCA projection data.

## Visualization
Evaluate the performance of the synthetic data optimization:

```r
# Plot AUROC as a function of D and k
createAUROCGraph(dfAUROC = resOut$paraSample$dfAUROC, title = "Sample Ancestry Optimization")
```

## Tips for Success
- **Reference Files**: Reliable inference requires complete reference files (e.g., 1000 Genomes). Mini-reference files included in the package are for demonstration only.
- **RNA Data**: Always use `inferAncestryGeneAware()` for transcriptomic data to account for expression-related coverage biases.
- **Memory**: Processing large VCFs or GDS files can be memory-intensive; ensure the R session has sufficient allocation.

## Reference documentation

- [Population reference dataset GDS files](./references/Create_Reference_GDS_File.md)
- [Robust Ancestry Inference using Data Synthesis](./references/RAIDS.md)
- [Using wrapper functions](./references/Wrappers.md)