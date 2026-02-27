---
name: bioconductor-rariant
description: This tool identifies single nucleotide variants by comparing mismatch frequencies between test and control sequencing samples using statistical confidence intervals and Fisher's Exact Tests. Use when user asks to detect somatic mutations, identify shifts in non-consensus base call frequencies, or assess variant evidence between matched BAM files.
homepage: https://bioconductor.org/packages/3.6/bioc/html/Rariant.html
---


# bioconductor-rariant

name: bioconductor-rariant
description: Identification and assessment of single nucleotide variants (SNVs) through shifts in non-consensus base call frequencies. Use this skill when analyzing sequencing data (BAM files) to detect variants between matched samples (e.g., tumor vs. normal) using binomial distribution mismatch rates and confidence intervals.

## Overview

The `Rariant` package provides a statistical framework for identifying SNVs by comparing the mismatch frequencies between a test and a control sample. Unlike simple threshold-based callers, it uses confidence intervals (Agresti-Caffo or Newcombe-Hybrid-Score) and Fisher's Exact Tests to provide quantitative assessments of variant presence or absence. It is particularly useful for somatic mutation detection and characterizing low-frequency variants.

## Core Workflow

### 1. Variant Calling with rariant()
The primary interface for identifying shifts in variant frequencies.

```r
library(Rariant)
library(GenomicRanges)

# Define regions of interest
roi <- GRanges("1", IRanges(start = 115258439, end = 115259089))

# Call variants comparing test and control BAMs
vars <- rariant(test = "path/to/test.bam", 
                control = "path/to/control.bam", 
                region = roi,
                beta = 0.95,           # Confidence level
                criteria = "both")     # Use both FET and Confidence Intervals
```

### 2. Assessing Evidence
Classify variants into categories (absent, present, dontknow) based on frequency shifts.

```r
# Determine evidence based on null (0) and expected shift (e.g., 0.5)
vars_ev <- yesNoMaybe(vars, null = 0, one = 0.5)

# Visualize the evidence
evidenceHeatmap(vars_ev)
```

### 3. Visualization
Rariant integrates with `ggplot2` and `ggbio` for visualizing confidence intervals and mismatch rates.

```r
# Plot confidence intervals for the frequency shifts
plotConfidenceIntervals(vars)

# Plot the abundance shift between samples
plotAbundanceShift(vars)

# Create a mismatch plot (tally) directly from BAM files
library(BSgenome.Hsapiens.UCSC.hg19)
ref <- BSgenome.Hsapiens.UCSC.hg19
tallyPlot(file = c("control.bam", "test.bam"), region = roi, ref = ref)
```

### 4. Interactive Inspection
Use the Shiny-based interface to explore results.

```r
rariantInspect(vars)
```

## Statistical Utilities

- **Confidence Intervals**: Use `acCi()` (Agresti-Caffo) or `nhsCi()` (Newcombe-Hybrid-Score) for vectorized CI calculation.
- **Testing**: Use `feTest()` (Fisher's Exact), `nmTest()` (Miettinen-Nurminen), or `scoreTest()` for proportion testing.
- **Multiple Testing**: Adjust confidence levels using `ciAdjustLevel()` to control for false discovery rates.

## Tips for Success

- **Consensus Sequence**: By default, `rariant` determines the consensus from the control sample. To use a specific reference, pass a `BSgenome` object to the `consensus` argument.
- **Filtering**: Use `select = FALSE` in `rariant()` if you need to assess the *absence* of a variant at specific sites (returns all positions in the region).
- **Quality Control**: Adjust `minQual` (base quality) and `nCycles` (trimming read ends) to reduce noise from sequencing artifacts.

## Reference documentation

- [Rariant Reference Manual](./references/reference_manual.md)