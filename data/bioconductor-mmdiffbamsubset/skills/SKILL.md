---
name: bioconductor-mmdiffbamsubset
description: This package provides a subset of ChIP-Seq BAM and peak files from the Cfp1 experiment for testing differential peak analysis. Use when user asks to load example mouse H3K4me3 data, access toy datasets for MMDiff2, or retrieve sample BAM and peak files for genomic analysis workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MMDiffBamSubset.html
---

# bioconductor-mmdiffbamsubset

name: bioconductor-mmdiffbamsubset
description: Access and use the MMDiffBamSubset experimental data package. Use this skill when a user needs to load example ChIP-Seq BAM files and peak files from the Cfp1 experiment (Mus musculus H3K4me3) for testing differential peak analysis, specifically with the MMDiff or MMDiff2 packages.

# bioconductor-mmdiffbamsubset

## Overview
The `MMDiffBamSubset` package is a Bioconductor ExperimentData package providing a subset of BAM and peak files from a ChIP-Seq experiment (Cfp1) in mouse embryonic stem cells. It is primarily used as a toy dataset for demonstrating differential ChIP-Seq analysis workflows. The data includes Wild Type (WT), Null (Cfp1 -/-), and Rescue (Resc) conditions, along with an Input control.

## Loading the Data
To use the data, first load the library. The package provides utility functions that return the full system paths to the included files.

```r
library(MMDiffBamSubset)

# Get path to the Sample Sheet (CSV)
sample_sheet <- Cfp1.Exp()

# Get paths to BAM files
wt_bam <- WT.AB2()
null_bam <- Null.AB2()
resc_bam <- Resc.AB2()
input_bam <- Input()

# Get paths to MACS peak files (XLS format)
wt_peaks <- WT.AB2.Peaks()
null_peaks <- Null.AB2.Peaks()
resc_peaks <- Resc.AB2.Peaks()
```

## Typical Workflow
This package is almost always used in conjunction with `MMDiff2` or other genomic analysis tools to practice data loading and differential testing.

### 1. Inspecting the Sample Sheet
The sample sheet contains metadata required for experimental design.
```r
csv_path <- Cfp1.Exp()
exp_metadata <- read.csv(csv_path)
head(exp_metadata)
```

### 2. Using with MMDiff2
A common use case is passing these paths into a `DBA` object or an `MMDiff` analysis pipeline:
```r
# Example: Creating a list of BAM files for analysis
bam_files <- c(WT.AB2(), Null.AB2(), Resc.AB2())
peak_files <- c(WT.AB2.Peaks(), Null.AB2.Peaks(), Resc.AB2.Peaks())

# These paths can then be used in functions like MMDiff2::getCounts
```

## Data Details
- **Organism**: *Mus musculus* (Mouse)
- **Genome Build**: NCBI37/mm9
- **Region**: Subset of chromosome 1 (chr1:3,000,000 to 75,000,000)
- **Experiment**: ChIP-Seq targeting H3K4me3 to assess the role of Cfp1 in histone modification.
- **File Formats**: BAM (alignments) and XLS (MACS peak calls).

## Reference documentation
- [MMDiffBamSubset Reference Manual](./references/reference_manual.md)