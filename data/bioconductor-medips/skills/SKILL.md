---
name: bioconductor-medips
description: MEDIPS analyzes genome-wide sequencing data from DNA enrichment experiments like MeDIP-seq, ChIP-seq, and MBD-seq. Use when user asks to calculate genome-wide signal densities, perform differential coverage analysis, conduct saturation analysis, or normalize MeDIP-seq data.
homepage: https://bioconductor.org/packages/release/bioc/html/MEDIPS.html
---

# bioconductor-medips

name: bioconductor-medips
description: Analysis of genome-wide sequencing data from DNA enrichment experiments (MeDIP-seq, ChIP-seq, MBD-seq). Use this skill for calculating genome-wide signal densities, performing differential coverage analysis between conditions, saturation analysis, CpG enrichment quality controls, and normalizing MeDIP-seq data using relative methylation scores (rms).

## Overview
MEDIPS is a Bioconductor package designed for the analysis of DNA enrichment sequencing data. While originally developed for Methylated DNA Immunoprecipitation (MeDIP-seq), it is highly effective for any quantitative sequencing data (ChIP-seq, CMS-seq) where signal density and differential coverage are of interest. It handles the workflow from BAM/BED files to differential analysis, quality control, and visualization export.

## Core Workflow

### 1. Data Import and Set Creation
MEDIPS uses "MEDIPS SETs" to store coverage information. You must have the appropriate `BSgenome` package installed for your organism.

```R
library(MEDIPS)
library(BSgenome.Hsapiens.UCSC.hg19)

# Define parameters
BSgenome <- "BSgenome.Hsapiens.UCSC.hg19"
uniq <- 1e-3 # p-value for max allowed stacked reads
extend <- 300 # extend reads to 300nt
ws <- 100 # window size

# Create a MEDIPS SET
mset <- MEDIPS.createSet(file = "sample.bam", 
                         BSgenome = BSgenome, 
                         extend = extend, 
                         uniq = uniq, 
                         window_size = ws, 
                         chr.select = "chr22")
```

### 2. Quality Control
Before analysis, evaluate the library saturation and CpG enrichment (for MeDIP/MBD).

*   **Saturation Analysis**: Determines if sequencing depth is sufficient.
    `sr <- MEDIPS.saturation(file = "sample.bam", BSgenome = BSgenome, ...)`
    `MEDIPS.plotSaturation(sr)`
*   **CpG Enrichment**: Checks for successful immunoprecipitation.
    `er <- MEDIPS.CpGenrich(file = "sample.bam", BSgenome = BSgenome, ...)`

### 3. Coupling Vectors
For MeDIP-seq normalization (rms), you must calculate the local density of the genomic pattern (usually "CG").

```R
CS <- MEDIPS.couplingVector(pattern = "CG", refObj = mset)
```

### 4. Differential Coverage Analysis
Compare two groups of replicates. MEDIPS supports `edgeR` (recommended) or `ttest`.

```R
# MSet1 and MSet2 are lists of MEDIPS SETs
result.table <- MEDIPS.meth(MSet1 = group1_list, 
                            MSet2 = group2_list, 
                            CSet = CS, 
                            ISet1 = input1_list, # Optional Input/Control
                            ISet2 = input2_list, 
                            diff.method = "edgeR", 
                            p.adj = "bonferroni",
                            MeDIP = TRUE)
```

### 5. Selecting and Merging Results
Filter the result table for significant windows and merge adjacent windows into regions.

```R
# Select significant windows
sig.windows <- MEDIPS.selectSig(results = result.table, p.value = 0.1, adj = TRUE)

# Merge adjacent windows into regions
sig.regions <- MEDIPS.mergeFrames(frames = sig.windows, distance = 1)
```

## Key Functions Reference
*   `MEDIPS.createSet()`: Imports BAM/BED files into R.
*   `MEDIPS.meth()`: Main function for coverage calculation and differential testing.
*   `MEDIPS.selectROIs()`: Extracts data for specific regions of interest (e.g., promoters).
*   `MEDIPS.exportWIG()`: Exports coverage (counts, rpkm, or rms) to Wiggle format for genome browsers.
*   `MEDIPS.addCNV()`: Incorporates Copy Number Variation data from Input samples to correct IP signals.

## Tips for Success
*   **Window Size**: Smaller windows (e.g., 50-100bp) provide higher resolution but require more memory and sequencing depth.
*   **Input Data**: Always use Input/Control samples when comparing conditions with different genomic backgrounds (e.g., cancer vs. normal) to account for CNVs.
*   **Memory**: For large genomes, use `chr.select` to process one chromosome at a time if RAM is limited.
*   **Normalization**: Use `rms` (Relative Methylation Score) for MeDIP-seq to correct for CpG density bias; use `rpkm` for standard ChIP-seq.

## Reference documentation
- [MEDIPS](./references/MEDIPS.md)