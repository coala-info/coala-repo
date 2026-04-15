---
name: bioconductor-panelcn.mops
description: bioconductor-panelcn.mops detects copy number variations in targeted next-generation sequencing panel data by comparing test samples against a pool of control samples. Use when user asks to identify exon-level copy number variations, normalize read counts for panel data, or visualize genomic regions of interest.
homepage: https://bioconductor.org/packages/release/bioc/html/panelcn.mops.html
---

# bioconductor-panelcn.mops

## Overview

The `panelcn.mops` package is a specialized version of the `cn.mops` algorithm tailored for targeted Next-Generation Sequencing (NGS) panel data. It is designed to detect copy number variations (CNVs) in small regions of interest (ROIs), such as individual exons, by comparing test samples against a pool of control samples. It accounts for the high variability in read counts typical of panel data through normalization and quality control metrics.

## Core Workflow

### 1. Prepare Count Windows
Define the genomic regions (ROIs) from a BED file. The 4th column of the BED file must start with the Gene Name, followed by optional information separated by dots (e.g., `ATM.E1`).

```R
library(panelcn.mops)
bed_path <- "path/to/your_panel.bed"
countWindows <- getWindows(bed_path)
```

*Tip: If ROIs are very large, use `splitROIs(bed_path, "split.bed")` to break them into smaller bins (default 100bp) for higher resolution.*

### 2. Extract Read Counts
Generate read counts from BAM files using the defined windows.

```R
bam_files <- c("sample1.bam", "sample2.bam", "control1.bam", "control2.bam")
# read.width should match the typical read length of your library
data_counts <- countBamListInGRanges(countWindows = countWindows, 
                                     bam.files = bam_files, 
                                     read.width = 150)
```

### 3. Run CNV Detection
Combine test and control samples into a single GRanges object and run the algorithm.

```R
# Identify which columns are test samples (e.g., first 2)
test_indices <- 1:2
selectedGenes <- c("ATM", "BRCA1", "BRCA2")

resultlist <- runPanelcnMops(XandCB = data_counts,
                             testiv = test_indices,
                             countWindows = countWindows,
                             selectedGenes = selectedGenes)
```

### 4. Interpret and Visualize Results
Generate a result table and visualize specific genes.

```R
# Create a summary table for a specific test sample (e.g., the first one)
sample_names <- colnames(elementMetadata(data_counts))
res_table <- createResultTable(resultlist = resultlist, 
                               XandCB = data_counts,
                               countWindows = countWindows, 
                               selectedGenes = selectedGenes, 
                               sampleNames = sample_names)

# View the table for the first test sample
head(res_table[[1]])

# Plot boxplots of normalized read counts for a gene
plotBoxplot(result = resultlist[[1]], 
            sampleName = sample_names[1],
            countWindows = countWindows, 
            selectedGenes = selectedGenes, 
            showGene = 1)
```

## Key Parameters and Quality Control

### Adjusting Sensitivity
The `I` parameter in `runPanelcnMops` defines the expected fold changes for copy number classes (CN0, CN1, CN2, CN3, CN4). 
- Default: `c(0.025, 0.57, 1, 1.46, 2)`
- To increase sensitivity for deletions: Increase the value for CN1 (e.g., from 0.57 to 0.65).
- To increase sensitivity for duplications: Decrease the value for CN3 (e.g., from 1.46 to 1.35).

### Quality Metrics
The `createResultTable` output includes a `lowQual` column:
- **ROI Quality**: ROIs are flagged if they show high variation across samples or if the median read count is below the threshold (default 30).
- **Sample Quality**: Samples are flagged if their median read count is significantly lower than the cohort median (threshold < 0.55x).

### Sex Chromosome Analysis
By default, X-chromosomal ROIs are removed (`sex = "mixed"`). To analyze Chromosome X, ensure all samples in the batch have the same sex and set the `sex` parameter in `runPanelcnMops` to `"male"` or `"female"`. Note: In all-male runs, `CN2` in the output represents the normal `CN1` state.

## Reference documentation
- [panelcn.mops - CNV detection tool for targeted NGS panel data](./references/panelcn.mops.md)