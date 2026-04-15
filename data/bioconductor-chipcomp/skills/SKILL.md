---
name: bioconductor-chipcomp
description: ChIPComp performs quantitative comparison of multiple ChIP-seq datasets using a linear model framework that incorporates control sequencing data. Use when user asks to perform differential binding site analysis, integrate control or input data into ChIP-seq comparisons, or identify differential transcription factor binding and histone modifications between conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/ChIPComp.html
---

# bioconductor-chipcomp

name: bioconductor-chipcomp
description: Quantitative comparison of multiple ChIP-seq datasets using a linear model framework that incorporates control sequencing data. Use this skill when performing differential binding site (DBS) analysis between two treatment conditions where replicates and control (input) data are available.

## Overview

ChIPComp is a Bioconductor package designed for differential binding analysis of transcription factor binding or histone modifications. Its primary strength is the formal integration of control/input sequencing data into a linear model to improve the specificity and sensitivity of detecting differential sites.

The workflow involves:
1. Defining experimental configuration and design.
2. Merging peaks from different conditions into a common set.
3. Counting reads for both ChIP and control samples.
4. Performing hypothesis testing to identify differential binding.

## Core Workflow

### 1. Experimental Configuration
You must provide information about the ChIP-seq samples, including file paths for IP reads, control reads, and peak sets.

**Option A: Using a CSV file**
```r
library(ChIPComp)
# conf.csv should contain columns: SampleID, condition, factor, ipReads, ctReads, peaks
confs <- makeConf("path/to/conf.csv")
conf <- confs$conf
design <- confs$design
```

**Option B: Manual Data Frame Creation**
```r
conf <- data.frame(
  SampleID = 1:4,
  condition = factor(c("Cond1", "Cond1", "Cond2", "Cond2")),
  factor = factor(rep("H3K27ac", 4)),
  ipReads = c("s1_ip.bed", "s2_ip.bed", "s3_ip.bed", "s4_ip.bed"),
  ctReads = c("s1_ct.bed", "s2_ct.bed", "s3_ct.bed", "s4_ct.bed"),
  peaks = c("s1_p.bed", "s2_p.bed", "s3_p.bed", "s4_p.bed")
)

# Create design matrix (e.g., comparing conditions)
design <- as.data.frame(model.matrix(~condition, conf))
```

### 2. Creating the Count Set
The `makeCountSet` function merges peaks and calculates read counts.
- **filetype**: "bed" or "bam".
- **species**: Required if filetype is "bed" (e.g., "hg19", "mm9").
- **binsize**: Size for smoothing control counts (default 1000).

```r
countSet <- makeCountSet(conf, design, filetype = "bam", binsize = 1000)
```

### 3. Quality Control
Visualize the correlation between ChIP samples and their corresponding control samples to ensure data quality.
```r
plot(countSet)
```

### 4. Differential Binding Analysis
Run the main `ChIPComp` function to fit the model and perform Wald tests.
```r
countSet <- ChIPComp(countSet)

# View top differential sites
print(countSet)

# Extract results as a data frame
results <- as.data.frame(countSet)
```

## Key Functions and Parameters

- `makeConf(file)`: Parses a configuration CSV and generates the design matrix automatically.
- `makeCountSet(conf, design, ...)`: Merges peaks across all replicates and conditions. It records whether a merged site was originally a "common peak" (found in both conditions) or unique.
- `ChIPComp(countSet)`: Performs the statistical testing. It calculates both a p-value (Wald test) and a posterior probability (`prob.post`) of being differential.
- `print(countSet)`: Displays the genomic coordinates, raw counts for IP and Control (ct) for each replicate, and statistical significance.

## Tips for Success
- **Replicates**: ChIPComp requires replicates for each treatment condition to estimate variability.
- **Control Data**: Ensure control (input) files are provided for every IP sample, as the model relies on these to adjust for local background bias.
- **Peak Files**: The package expects peaks called by external software (like MACS2). These peaks are merged internally to create the testing regions.

## Reference documentation
- [ChIPComp](./references/ChIPComp.md)