---
name: bioconductor-repitools
description: Bioconductor-repitools provides a suite of tools for the analysis and visualization of epigenomic data, specifically focusing on enrichment-based DNA methylation and ChIP-seq assays. Use when user asks to perform GC-bias correction, calculate CpG density, generate coverage profiles around genomic features, or estimate absolute methylation levels from MeDIP-seq and MBD-seq data.
homepage: https://bioconductor.org/packages/release/bioc/html/Repitools.html
---


# bioconductor-repitools

name: bioconductor-repitools
description: Epigenomic data analysis including ChIP-chip, ChIP-seq, and DNA methylation arrays (MeDIP-seq, MBD-seq). Use this skill when performing quality control, normalization, visualization, and enrichment analysis for DNA methylation and hydroxymethylation data in R.

# bioconductor-repitools

## Overview
Repitools is a comprehensive suite for analyzing epigenomic data. It specializes in processing enrichment-based DNA methylation assays (like MeDIP and MBDcap) and ChIP-seq data. Key capabilities include calculating enrichment scores, generating coverage profiles around genomic features, performing GC-bias correction, and visualizing spatial distributions of epigenetic marks.

## Core Workflows

### 1. Data Import and Preprocessing
Repitools works primarily with `GRanges` objects and BAM files.
```r
library(Repitools)
library(BSgenome.Hsapiens.UCSC.hg19)

# Create a GenomeDataList from BAM files
path <- "path/to/bam/files"
files <- list.files(path, pattern = "\\.bam$")
gdList <- GenomeDataList(files)
```

### 2. Quality Control and GC Bias
Enrichment-based methods are sensitive to GC content. Repitools provides tools to assess and correct this.
```r
# Calculate GC content for genomic bins
bins <- genomeBlocks(Hsapiens, chrs = "chr1", width = 500)
gc <- gcContentCalc(bins, organism = Hsapiens)

# Check for GC bias in enrichment
# counts: matrix of read counts per bin
# bias: result of gcContentCalc
gcBiasPlot(counts, gc)
```

### 3. Feature Aggregation (Profile Plots)
To visualize the distribution of marks around TSS or other features:
```r
# Create a lookup table of coverage around features
# features: GRanges of TSS or regions
# reads: GRanges or BAM file path
anno <- featureScores(reads, features, up = 2000, down = 2000, freq = 100)

# Plot the average profile
plotScores(anno, main = "Methylation Profile around TSS")
```

### 4. DNA Methylation Analysis (MeDIP/MBD)
For estimating absolute methylation levels from enrichment data:
```r
# 1. Calculate CpG density
cpg_dens <- cpgDensityCalc(bins, organism = Hsapiens)

# 2. Normalize using the MEDIPS-like or Bayesian approach
# absoluteMethylation uses a calibration curve or sampling
meth_est <- absoluteMethylation(counts, cpg_dens)
```

### 5. Summarizing Regions
Summarize enrichment across specific genomic intervals:
```r
# Calculate counts in specific regions
region_counts <- annotationBlocksCounts(reads, regions)

# Calculate enrichment relative to genomic background
scores <- enrichmentScore(reads, regions)
```

## Key Functions Reference
- `featureScores()`: Generates matrices of scores centered on genomic features.
- `gcContentCalc()`: Calculates G+C proportion for genomic intervals.
- `cpgDensityCalc()`: Calculates CpG density (observed/expected or count).
- `blocksStats()`: Performs statistical tests on defined genomic blocks.
- `mappabilityCalc()`: Calculates the mappability of genomic regions.
- `profilePlots()`: High-level function for plotting multiple coverage profiles.

## Tips for Success
- **Genome Consistency**: Ensure the `BSgenome` object used for GC/CpG calculations exactly matches the assembly used for alignment (e.g., hg19 vs. hg38).
- **Memory Management**: When working with large BAM files, use `GRanges` or `Rsamtools` to subset data before passing to Repitools functions if memory is limited.
- **GC Correction**: Always perform `gcBiasPlot` before downstream differential analysis to determine if normalization is required.

## Reference documentation
- [Repitools Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/Repitools.html)