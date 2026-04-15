---
name: bioconductor-teqc
description: This tool performs quality control for target enrichment sequencing experiments by assessing capture specificity, enrichment, and coverage uniformity. Use when user asks to evaluate NGS capture success, calculate on-target read fractions, generate coverage statistics, or create automated HTML quality control reports for exome or targeted panels.
homepage: https://bioconductor.org/packages/release/bioc/html/TEQC.html
---

# bioconductor-teqc

name: bioconductor-teqc
description: Quality control for target enrichment (capture) sequencing experiments. Use this skill to assess capture specificity, enrichment, coverage uniformity, and read duplication in NGS data (Exome or targeted panels). It supports loading BED/BAM files, calculating on-target fractions, generating coverage statistics, and creating automated HTML reports for single or multiple samples.

# bioconductor-teqc

## Overview

The `TEQC` package provides quality control functionalities for target enrichment experiments (e.g., exome sequencing or custom panels). It evaluates whether the capture was successful by measuring specificity (reads on target), sensitivity (target bases covered), enrichment, coverage uniformity, and reproducibility across replicates. It utilizes `GenomicRanges` for efficient data handling.

## Core Workflow

### 1. Automated Reporting
The fastest way to perform a standard QC analysis is using the automated HTML report generator.

```R
library(TEQC)

# Single sample report
TEQCreport(
  sampleName = "Sample1",
  targetsName = "Exome_v7",
  referenceName = "hg38",
  destDir = "QC_report",
  reads = get.reads("reads.bam", filetype = "bam"),
  targets = get.targets("targets.bed"),
  genome = "hg38"
)

# Multi-sample summary report
multiTEQCreport(
  singleReportDirs = c("report1", "report2"),
  samplenames = c("SampleA", "SampleB"),
  destDir = "multi_report"
)
```

### 2. Data Loading
`TEQC` requires two main inputs: the genomic positions of the targets and the aligned reads.

*   **Targets:** Use `get.targets()`. Overlapping or adjacent targets are automatically merged.
*   **Reads:** Use `get.reads()`. Supports BED or BAM files. For BAM, it uses `ShortRead` for fast processing.
*   **Coordinate Note:** By default, `TEQC` assumes 0-based start/1-based end (UCSC style) and shifts starts by +1. Set `zerobased = FALSE` if your input is already 1-based.

```R
targets <- get.targets("targets.bed", chrcol=1, startcol=2, endcol=3)
reads <- get.reads("aligned.bam", filetype="bam")
```

### 3. Specificity and Enrichment
Specificity measures the fraction of reads that overlap with target regions.

```R
# Fraction of genome targeted
ft <- fraction.target(targets, genome = "hg38")

# Fraction of reads on target
fr <- fraction.reads.target(reads, targets)

# Enrichment calculation
enrichment <- fr / ft
```

### 4. Coverage Analysis
Coverage statistics are calculated per base and per target.

```R
# Calculate coverage
# perTarget=T adds avgCoverage and coverageSD to the targets object
# perBase=T returns RleLists of coverage for all/targeted bases
vars <- coverage.target(reads, targets, perTarget=TRUE, perBase=TRUE)

# Sensitivity: fraction of target bases with at least k coverage
covered.k(vars$coverageTarget, k=c(1, 5, 10, 30))

# Visualizations
coverage.hist(vars$coverageTarget, covthreshold=10)
coverage.uniformity(vars)
```

### 5. Paired-End Data
For paired-end data, it is often better to perform statistics on read pairs (fragments) rather than single reads.

```R
# Merge reads into pairs
readpairs <- reads2pairs(reads)

# Plot insert size distribution
insert.size.hist(readpairs)

# Use readpairs in specificity functions
fr_pairs <- fraction.reads.target(readpairs, targets)
```

### 6. Duplicate Analysis
Distinguish between "real" duplication (expected in high-coverage targets) and PCR artifacts.

```R
# Barplot showing multiplicity of on-target vs off-target reads
duplicates.barplot(reads, targets)

# Collapse duplicates (keep unique positions)
reads.unique <- unique(reads)
```

## Tips for Efficient Usage
*   **BAM over BED:** Always use BAM files for `get.reads` as it is significantly faster and memory-efficient.
*   **Offsets:** Use the `Offset` parameter in `fraction.reads.target` or `coverage.plot` to include flanking regions (e.g., `Offset=100`).
*   **GC Bias:** Use `coverage.GC` to check if capture efficiency is biased by the GC content of the hybridization probes (baits).
*   **Wiggle Files:** Export coverage tracks for genome browsers using `make.wigfiles(vars$coverageAll)`.

## Reference documentation
- [TEQC: Target Enrichment Quality Control](./references/TEQC.md)