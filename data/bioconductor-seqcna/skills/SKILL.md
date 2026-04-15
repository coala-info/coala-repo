---
name: bioconductor-seqcna
description: This tool performs copy number analysis on high-throughput sequencing cancer DNA data. Use when user asks to summarize reads from SAM or BAM files, normalize GC-content bias, perform genomic segmentation, or call copy number alterations.
homepage: https://bioconductor.org/packages/3.9/bioc/html/seqCNA.html
---

# bioconductor-seqcna

name: bioconductor-seqcna
description: Copy number analysis of high-throughput sequencing cancer DNA. Use this skill to process SAM/BAM files or summarized read counts to identify copy number alterations (CNAs). It supports filtering, GC-content normalization (seqnorm), segmentation (GLAD), and manual or automated copy number calling.

## Overview

The `seqCNA` package provides a user-friendly workflow for copy number analysis specifically designed for deep sequencing data from tumoural samples. It handles the entire pipeline from read summarization to final copy number calling, featuring a normalization method that accounts for the relationship between copy number and GC content.

## Core Workflow

### 1. Data Input and Summarization
If starting from alignment files (SAM/BAM), use `runSeqsumm`. For BAM files, ensure `samtools` is installed and accessible.

```r
library(seqCNA)

# Summarize reads from a SAM/BAM file into windows (e.g., 200Kbps)
# This creates 'seqsumm_out.txt' in the specified folder
runSeqsumm(file="path/to/sample.sam", folder="analysis_folder")

# Read the summarized data into a SeqCNAInfo object
# tumour.data can be a file path or a dataframe
rco = readSeqsumm(tumour.data="analysis_folder/seqsumm_out.txt")
```

### 2. Filtering
Apply filters to remove problematic genomic windows (e.g., extreme read counts, low mappability, or common CNVs).

```r
# trim.filter=1: automatically selects thresholds for high/low read counts
# mapq.filter=2: filters based on mean mapping quality
rco = applyFilters(rco, trim.filter=1, mapq.filter=2)
```

### 3. Normalization
The `runSeqnorm` function corrects for GC-content bias. It uses a preliminary segmentation to perform regressions, making it robust for tumoural data.

```r
# Performs normalization (can be parallelized)
rco = runSeqnorm(rco)
```

### 4. Segmentation
Smoothing the profile to identify significant copy number changes using the GLAD algorithm.

```r
rco = runGLAD(rco)
```

### 5. Copy Number Calling
Calling requires setting thresholds for the normalized ratios. Visual assessment is highly recommended to identify the baseline (e.g., CN2).

```r
# Plot the profile to determine thresholds visually
plotCNProfile(rco)

# Apply thresholds: e.g., thresholds every 0.8 units, starting with CN1
# applyThresholds(object, thresholds, lowest_cn)
rco = applyThresholds(rco, seq(-0.8, 4, by=0.8), 1)

# Plot again to see the final calls
plotCNProfile(rco)
```

## Data Inspection and Export

To review the results or export them for downstream analysis:

```r
# View summary of the analysis steps and window counts per CN state
summary(rco)

# Access the underlying data (chrom, window start, normalized, segmented, CN)
head(rco@output)

# Write results to a text file
writeCNProfile(rco, file="final_cna_results.txt")
```

## Tips for Success
- **Folder Organization**: Place each sample in a separate folder as the package generates intermediate analysis files there.
- **Matched Normals**: If a matched normal sample is available, provide it in `readSeqsumm(tumour.data=..., normal.data=...)`. Normalization will then be performed against the normal profile instead of GC content.
- **Window Size**: The default window size is often 200Kbps, but this can be adjusted in `runSeqsumm` depending on sequencing depth.
- **Genome Builds**: For mappability and CNV filters, specify the build (e.g., `build="hg19"`) in `readSeqsumm`.

## Reference documentation
- [seqCNA](./references/seqCNA.md)