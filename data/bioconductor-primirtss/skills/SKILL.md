---
name: bioconductor-primirtss
description: This tool identifies human miRNA transcriptional start sites by integrating multi-omic data such as ChIP-seq, DHS, and expression profiles. Use when user asks to predict cell-specific miRNA TSSs, merge genomic peak data, or visualize the genomic context of miRNA precursors.
homepage: https://bioconductor.org/packages/release/bioc/html/primirTSS.html
---


# bioconductor-primirtss

name: bioconductor-primirtss
description: Identify human miRNA transcriptional start sites (TSSs) using the primirTSS R package. Use this skill when you need to predict cell-specific miRNA TSSs by integrating H3K4me3 ChIP-seq, Pol II ChIP-seq, DNase I hypersensitive sites (DHS), and expression profiles.

# bioconductor-primirtss

## Overview
The `primirTSS` package provides a computational framework for identifying human miRNA transcriptional start sites (TSSs). Because miRNA TSSs are cell-specific and often located within or near other genes, the package uses a multi-omic integration approach. It combines histone modification data (H3K4me3), RNA Polymerase II (Pol II) peaks, and DHS data with miRNA and protein-coding gene expression profiles to improve prediction accuracy and reduce false positives.

## Prerequisites
- **Java JDK**: A Java SE Development Kit (JDK) must be installed on the system as the core prediction engine (Eponine) relies on a Java environment.
- **Genome**: The package is designed for human miRNA TSS identification.

## Core Workflow

### 1. Data Preprocessing
Before prediction, peak data from ChIP-seq experiments must be formatted as `GRanges` objects and processed.

```r
library(primirTSS)
library(GenomicRanges)

# Merge adjacent peaks of the same type (e.g., H3K4me3)
# n is the distance threshold for merging
peak_merged <- peak_merge(h3k4me3_granges, n = 250)

# Join two different peak types (e.g., H3K4me3 and Pol II)
# This creates the bed_merged input for the main function
bed_merged <- peak_join(h3k4me3_merged, pol2_merged)
```

### 2. Predicting TSSs
The `find_tss` function is the primary interface. It supports different levels of evidence depending on data availability.

**Scenario A: No miRNA expression data available**
Use DHS data and protein-coding gene data to filter candidates.
```r
results <- find_tss(
  bed_merged, 
  ignore_DHS_check = FALSE, 
  DHS = dhs_granges, 
  expressed_gene = "all", # or a vector of Ensembl IDs
  seek_tf = FALSE
)
```

**Scenario B: miRNA expression data available**
Focus on specific miRNAs and skip the DHS check.
```r
results <- find_tss(
  bed_merged, 
  expressed_mir = c("hsa-mir-5697"), 
  ignore_DHS_check = TRUE,
  expressed_gene = "all"
)
```

### 3. Analyzing Results
The output is a list containing two main components:
- `tss_df`: A tibble containing predicted TSS coordinates, miRNA context (intra/inter), and TSS type.
- `log`: Logs for miRNAs that failed at specific steps (e.g., `eponine_score_log`, `DHS_check_log`).

**TSS Types:**
- `host_TSS`: miRNA shares a TSS with a protein-coding gene (intra-genic).
- `intra_TSS`: miRNA has its own TSS within a protein-coding gene.
- `overlap_inter_TSS`: miRNA overlaps with a gene but is inter-genic.
- `inter_inter_TSS`: miRNA is in a purely inter-genic region.

### 4. Visualization
To visualize the genomic context of a prediction for a single miRNA:
```r
plot_primiRNA(
  expressed_mir = "hsa-mir-5697", 
  bed_merged = bed_merged,
  ignore_DHS_check = TRUE
)
```
This generates a multi-track plot showing the TSS, genome coordinates, pri-miRNA, closest gene, Eponine score, and conservation score.

## Interactive Interface
For users preferring a GUI, the package includes a Shiny application:
```r
run_primirTSSapp()
```

## Reference documentation
- [primirTSS Vignette (Rmd)](./references/primirTSS.Rmd)
- [primirTSS Vignette (Markdown)](./references/primirTSS.md)