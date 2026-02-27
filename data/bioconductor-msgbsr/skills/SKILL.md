---
name: bioconductor-msgbsr
description: This package analyzes Methylation Sensitive Genotyping by Sequencing (MS-GBS) data to identify differentially methylated sites. Use when user asks to import read counts from BAM files, verify restriction enzyme cut sites, perform differential methylation analysis, or visualize genomic distributions of methylation data.
homepage: https://bioconductor.org/packages/release/bioc/html/msgbsR.html
---


# bioconductor-msgbsr

name: bioconductor-msgbsr
description: Analysis of Methylation Sensitive Genotyping by Sequencing (MS-GBS) data. Use when analyzing BAM files from MS-GBS experiments to identify differentially methylated sites, verify restriction enzyme cut sites, and visualize read counts or genomic distributions.

# bioconductor-msgbsr

## Overview
The `msgbsR` package is designed for the analysis of Methylation Sensitive Genotyping by Sequencing (MS-GBS) data. It allows users to import read counts from BAM files, verify that the reads correspond to correct restriction enzyme (RE) cut sites (e.g., MspI), perform differential methylation analysis using an edgeR-based wrapper, and visualize results through count plots and circos plots.

## Workflow

### 1. Data Import
The pipeline begins with sorted and indexed BAM files. Use `rawCounts` to generate a `RangedSummarizedExperiment` object.

```r
library(msgbsR)
library(GenomicRanges)
library(SummarizedExperiment)

# Import data from a directory of BAM files
se <- rawCounts(bamFilepath = "path/to/bam_directory", threads = 1)

# Add sample metadata
colData(se) <- DataFrame(Group = c("Control", "Control", "Experimental", "Experimental"),
                         row.names = colnames(assay(se)))
```

### 2. Verification of Cut Sites
To ensure data quality, verify that the reads align with the expected restriction enzyme recognition sequence.

**Note:** You must adjust the cut site coordinates to cover the recognition sequence based on the strand. For MspI (C/CGG):

```r
cutSites <- rowRanges(se)

# Adjust positions to overlap the recognition site
start(cutSites) <- ifelse(test = strand(cutSites) == '+', 
                          yes = end(cutSites) + 2, no = end(cutSites) + 1)
end(cutSites) <- ifelse(test = strand(cutSites) == '+', 
                        yes = start(cutSites) - 1, no = start(cutSites) - 2)

# Check against a BSgenome or fasta file
library(BSgenome.Rnorvegicus.UCSC.rn6)
correctCuts <- checkCuts(cutSites = cutSites, genome = "rn6", seq = "CCGG")

# Filter the SummarizedExperiment to keep only correct sites
se <- subsetByOverlaps(se, correctCuts)
```

### 3. Visualization of Read Counts
Visualize the distribution of total reads versus the number of unique cut sites per sample to identify outliers or group-wise biases.

```r
plotCounts(se = se, cateogory = "Group")
```

### 4. Differential Methylation Analysis
`msgbsR` provides a wrapper for `edgeR` to identify differentially methylated sites.

```r
top <- diffMeth(se = se, 
                cateogory = "Group", 
                condition1 = "Control", 
                condition2 = "Experimental",
                cpmThreshold = 1, 
                thresholdSamples = 1)

# Filter for significant sites
sig_sites <- top[top$FDR < 0.05, ]
```

### 5. Genomic Visualization
Use `plotCircos` to visualize the genomic distribution of differentially methylated sites.

```r
# Define chromosome lengths (example for Rat chr20)
ratChr <- seqlengths(BSgenome.Rnorvegicus.UCSC.rn6)["chr20"]

# Extract significant sites as GRanges
my_cuts <- GRanges(top$site[which(top$FDR < 0.05)])

# Generate plot
plotCircos(cutSites = my_cuts, 
           seqlengths = ratChr,
           cutSite.colour = "red", 
           seqlengths.colour = "blue")
```

## Tips
- **BAM Requirements:** Ensure BAM files are both sorted and indexed (.bai files must be present in the same directory).
- **Strand Specificity:** The adjustment of cut sites is critical for `checkCuts()`. If using an enzyme other than MspI, the offset values (+2, +1, etc.) must be modified to match that enzyme's specific cleavage pattern.
- **Memory:** For large datasets, use the `threads` parameter in `rawCounts` to speed up processing.

## Reference documentation
- [msgbsR Vignette](./references/msgbsR_Vignette.md)