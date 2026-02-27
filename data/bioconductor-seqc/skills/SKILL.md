---
name: bioconductor-seqc
description: This tool provides access to benchmark RNA-seq datasets and TaqMan RT-PCR gold-standard values from the Sequencing Quality Control project. Use when user asks to load SEQC benchmark datasets, access RNA-seq read counts or junction tables across different sequencing platforms, or retrieve TaqMan validation data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/seqc.html
---


# bioconductor-seqc

name: bioconductor-seqc
description: Access and analyze RNA-seq data from the Sequencing Quality Control (SEQC) project. Use this skill to load benchmark datasets including read count tables (AceView/RefSeq), exon-exon junction tables, and TaqMan RT-PCR gold-standard intensity values across multiple sequencing platforms (Illumina, SOLiD, Roche 454) and sites.

## Overview

The `seqc` package is an experiment data package containing benchmark datasets from the SEQC (MAQC-III) project. It provides standardized RNA-seq read counts and junction data for six reference samples (A-F) sequenced across 12 sites using different technologies. This data is primarily used for assessing the accuracy, reproducibility, and performance of RNA-seq analysis pipelines.

## Data Structure and Samples

The package contains data for six specific samples:
- **Sample A**: Agilent’s Universal Human Reference RNA (UHRR) + ERCC Spike-in Mix 1.
- **Sample B**: Life Technologies’ Human Brain Reference RNA (HBRR) + ERCC Spike-in Mix 2.
- **Sample C**: Mixture of 75% Sample A and 25% Sample B.
- **Sample D**: Mixture of 25% Sample A and 75% Sample B.
- **Sample E**: Pure ERCC Spike-in Mix 1.
- **Sample F**: Pure ERCC Spike-in Mix 2.

## Loading and Exploring Data

Load the library to make the data frames available in the global environment.

```r
library(seqc)

# List all datasets provided by the package
data(package="seqc")

# View sample metadata
data(seqc.samples)
head(seqc.samples)
```

## Working with Gene Expression Tables

Gene count tables follow the naming convention: `(PLATFORM)_(ANNOTATION)_gene_(SITE)`.
- **Platforms**: `ILM` (Illumina), `LIF` (SOLiD), `ROC` (Roche 454).
- **Annotations**: `aceview` or `refseq`.
- **Sites**: e.g., `AGR`, `BGI`, `CNL`, `COH`, `MAY`, `NVS`, `LIV`, `NWU`, `PSU`, `SQW`, `MGP`, `NYU`.

```r
# Example: Load Illumina RefSeq counts from the BGI site
data(ILM_refseq_gene_BGI)

# Explore the structure
# Columns include: EntrezID, Symbol, GeneLength, IsERCC, and sample columns
head(ILM_refseq_gene_BGI[, 1:10])

# Identify ERCC spike-ins
ercc_counts <- ILM_refseq_gene_BGI[ILM_refseq_gene_BGI$IsERCC, ]
```

## Working with Junction Tables

Junction tables follow the naming convention: `(PLATFORM)_junction_(SITE)_(SAMPLE)`.
These tables contain: `Chromosome`, `Location1` (last base of exon 1), `Location2` (first base of exon 2), and `nSupportingReads`.

```r
# Example: Load Illumina junctions for Sample B at the AGR site
data(ILM_junction_AGR_B)
head(ILM_junction_AGR_B)
```

## Using TaqMan RT-PCR Reference Data

For validation of RNA-seq results, use the `taqman` dataset which contains gold-standard RT-PCR intensity values for 1044 genes across samples A, B, C, and D.

```r
data(taqman)

# Columns include EntrezID, Symbol, and (Sample)_(Replicate)_value/detection
# 'P' in detection columns indicates 'Present'
head(taqman)
```

## Tips for Analysis

- **Column Naming**: Column names in gene tables typically follow `Sample_Replicate_Lane_FlowCell`. For example, `B_4_L02_FlowCell2` is the 4th replicate of Sample B, Lane 2, FlowCell 2.
- **Normalization**: These are raw counts. Before performing Differential Expression (DE) analysis or comparing across platforms, apply appropriate normalization (e.g., TMM, DESeq size factors).
- **Cross-Platform Comparison**: Use the `EntrezID` or `Symbol` columns to merge data frames from different platforms or sites for reproducibility studies.

## Reference documentation

- [RNA-seq Data Employed in The Sequencing Quality Control (SEQC) Project](./references/seqc.md)