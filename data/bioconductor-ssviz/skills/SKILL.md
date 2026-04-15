---
name: bioconductor-ssviz
description: Bioconductor-ssviz is a specialized toolkit for the visualization and analysis of small RNA-seq data, particularly for miRNA and piRNA profiling. Use when user asks to analyze BAM files from small RNA sequencing, visualize read length distributions, calculate piRNA ping-pong signatures, or plot nucleotide frequency composition.
homepage: https://bioconductor.org/packages/release/bioc/html/ssviz.html
---

# bioconductor-ssviz

name: bioconductor-ssviz
description: Specialized toolkit for small RNA-seq visualization and analysis. Use this skill to analyze BAM files from small RNA sequencing experiments, specifically for profiling miRNAs and piRNAs. It supports visualizing read length distributions, genomic region density, piRNA ping-pong signatures (10nt overlaps), and nucleotide frequency composition (e.g., 5' Uridine bias).

# bioconductor-ssviz

## Overview
The `ssviz` package is a visual aid and analysis toolkit for small RNA sequencing (miRNA, piRNA, etc.). It is designed to work with BAM files and specifically accounts for the "collapsed" read naming convention (e.g., `readname-readcount`) common in small RNA workflows like the fastx-toolkit. It provides specialized functions for piRNA analysis, including ping-pong amplification signatures and nucleotide frequency plots.

## Installation and Loading
To use `ssviz`, ensure it is installed via BiocManager:

```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ssviz")

library(ssviz)
```

## Data Preparation
The package works with BAM files mapped to a genome or small RNA annotations.

### Reading BAM Files
Use `readBam` to load data into a DataFrame. This is a wrapper for `Rsamtools::scanBam`.
```R
bam_path <- "path/to/your/file.bam"
data_bam <- readBam(bam_path)
```

### Handling Read Counts
Small RNA reads are often collapsed to save space. `ssviz` expects the count to be part of the read name (e.g., `74300-21` where 21 is the count). Use `getCountMatrix` to extract these counts into a dedicated column.
```R
# Appends a 'counts' column to the DataFrame
data_counts <- getCountMatrix(data_bam)
```

## Visualization Workflows

### Plotting Read Distributions
Use `plotDistro` to visualize properties like read length (`qwidth`), which helps distinguish between miRNAs (18-24nt) and piRNAs (24-32nt).
```R
# Plotting a single sample
plotDistro(list(data_counts), type = "qwidth", samplenames = c("Control"), ncounts = counts[1])

# Comparing multiple samples
plotDistro(list(ctrl_counts, treat_counts), 
           type = "qwidth", 
           samplenames = c("Control", "Treatment"), 
           ncounts = counts)
```

### Plotting Region Density
To visualize read density over a specific genomic coordinate:
```R
region <- 'chr1:3015526-3080526'
plotRegion(list(data_counts), region = region)
```

## Specialized piRNA Analysis

### Ping-Pong Analysis
The ping-pong mechanism in piRNA biogenesis results in a characteristic 10nt overlap between sense and anti-sense piRNAs.
```R
# Calculate overlaps
pp_data <- pingpong(data_counts)

# Plot frequency of overlap
plotPP(list(pp_data), samplenames = c("Sample1"))
```

### Nucleotide Frequency
Primary piRNAs often show a 5' Uridine (U) bias. Use `ntfreq` to compute and plot nucleotide composition over a specific length (usually the first 10nt).
```R
# Compute frequency for the first 10 nucleotides
freq_data <- ntfreq(data_counts, ntlength = 10)

# Plot the composition
plotFreq(freq_data)
```

## Tips for Success
- **Normalization**: When comparing samples, ensure you provide the `ncounts` parameter to `plotDistro` to account for differences in library size or total mapped reads.
- **Naming Convention**: If your BAM files do not follow the `name-count` convention, `getCountMatrix` may not function as expected. Ensure pre-processing (like fastx-toolkit) is consistent with this requirement.
- **Data Objects**: Most functions return or operate on S4 DataFrames, making them compatible with other Bioconductor tools like `GenomicRanges`.

## Reference documentation
- [ssviz](./references/ssviz.md)