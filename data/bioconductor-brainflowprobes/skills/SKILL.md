---
name: bioconductor-brainflowprobes
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.11/bioc/html/brainflowprobes.html
---

# bioconductor-brainflowprobes

## Overview
The `brainflowprobes` package facilitates the design of target probe sequences for the BrainFlow method (based on Invitrogen PrimeFlow® RNA technology). It is specifically optimized for targeting RNA in nuclei isolated from human postmortem brain tissue. The package provides tools to annotate candidate sequences, check for uniform expression across regions, and validate targets against external datasets including fetal/adult fractions, degradation time-courses, and single-cell data.

## Core Workflow

### 1. Installation and Loading
```R
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("brainflowprobes")
library("brainflowprobes")
```
*Note: This package is currently compatible only with hg19 coordinates.*

### 2. Annotating Candidate Regions
Use `region_info()` to get gene names, exon numbers, and the genomic sequence required for custom probe synthesis.
```R
# Input: hg19 coordinates as "chr:start-end:strand"
# SEQ = TRUE returns the actual DNA sequence for ordering
info <- region_info("chr2:162279880-162282378:+", CSV = TRUE, SEQ = TRUE)
```

### 3. Visualizing Expression Coverage
`plot_coverage()` helps identify if a region is uniformly expressed. Non-uniform expression suggests the region should be trimmed for better probe performance.
```R
# Generates a PDF showing coverage across nuclear/cytoplasmic and adult/fetal samples
plot_coverage("chr2:162280900-162282378:+", PDF = "coverage.pdf")
```

### 4. Comprehensive Parameter Assessment
The `four_panels()` function provides a snapshot of four critical metrics:
1.  **Separation**: Nuclear vs. Cytoplasmic expression.
2.  **Degradation**: Stability of the RNA sequence over time at room temperature.
3.  **Sorted**: Expression in NeuN+ (neurons) vs. NeuN- (non-neurons) nuclei.
4.  **Single Cells**: Specificity across different brain cell types.

```R
# Pre-computing coverage is recommended for speed if running multiple times
cov_data <- brainflowprobes_cov("chr2:162280900-162282378:+")

four_panels("chr2:162280900-162282378:+", 
            COVERAGE = cov_data, 
            PDF = "diagnostic_panels.pdf")
```

### 5. Handling Splice Junctions
If your target spans multiple exons, provide a vector of coordinates and set `JUNCTIONS = TRUE` to average coverage across the spliced sequence.
```R
exons <- c("chr8:57353587-57354496:-", "chr8:57358375-57358515:-")
four_panels(exons, JUNCTIONS = TRUE, PDF = "spliced_target.pdf")
```

## Key Considerations
- **Sequence Length**: Targets should be at least 1kb of contiguous sequence.
- **OS Limitations**: `plot_coverage()` and `four_panels()` require Mac or Linux due to BigWig track dependencies. Windows users should use `region_info()` for annotation and sequence extraction.
- **Probe Ordering**: When ordering via ThermoFisher, use the sequence from `region_info()`, select 'Prime Flow' chemistry, and 'RNA' as the target. Alexa Fluor 647 is recommended for highest sensitivity.

## Reference documentation
- [brainflowprobes user guide](./references/brainflowprobes-vignette.md)