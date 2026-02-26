---
name: bioconductor-intansv
description: This R package integrates, annotates, and visualizes structural variation predictions from multiple NGS-based programs. Use when user asks to read predictions from various SV callers, merge results into a consensus set, annotate SV effects on genomic features, or visualize SV distributions across the genome.
homepage: https://bioconductor.org/packages/release/bioc/html/intansv.html
---


# bioconductor-intansv

name: bioconductor-intansv
description: Structural variation (SV) integration, annotation, and visualization using the intansv R package. Use when needing to read predictions from multiple SV callers (BreakDancer, Pindel, CNVnator, DELLY, Lumpy, softSearch, SVseq2), merge them into a consensus set, annotate SV effects on genomic features, and visualize SV distributions across the genome or in specific regions.

# bioconductor-intansv

## Overview

The `intansv` package provides a unified framework for handling structural variations (SVs) predicted by various NGS-based programs. Its primary strength lies in integrating results from different methods to improve reliability, annotating the functional impact of SVs on genes, and providing high-level visualizations of SV distribution.

## Core Workflow

### 1. Reading SV Predictions
`intansv` provides specific functions to parse and filter output from popular SV callers.

```r
library(intansv)

# Read BreakDancer (Deletions and Inversions)
breakdancer <- readBreakDancer("path/to/breakdancer.sv")

# Read CNVnator (Deletions and Duplications)
# Provide directory containing chromosome-specific output files
cnvnator <- readCnvnator("path/to/cnvnator_dir")

# Read DELLY (Deletions, Inversions, Duplications)
delly <- readDelly("path/to/delly.vcf")

# Read Pindel (Deletions, Inversions, Tandem Duplications)
# Directory must contain files with suffixes _D, _INV, _TD
pindel <- readPindel("path/to/pindel_dir")

# Read Lumpy
lumpy <- readLumpy("path/to/lumpy.vcf")

# Read softSearch
softSearch <- readSoftSearch("path/to/softsearch.txt")

# Read SVseq2 (Deletions)
# Directory must contain files with .del suffix
svseq <- readSvseq("path/to/svseq2_dir")
```

### 2. Integrating Results
To increase confidence in SV calls, use `methodsMerge` to find overlaps between different programs.

```r
# Merge multiple objects
sv_all <- methodsMerge(breakdancer, pindel, cnvnator, delly, svseq)

# The result is a list with components: $del, $dup, $inv
# Each data frame includes a 'methods' column showing which tools called the SV
```

To integrate custom data or other programs, provide a data frame with columns: `chromosome`, `pos1`, `pos2`, `size`, `type`, and `methods`.

### 3. Annotation
Annotate SVs with genomic features (genes, exons, etc.). The annotation file should be a 6-column text file: `chr`, `tag`, `start`, `end`, `strand`, `ID`.

```r
# Load annotation
anno_data <- read.table("annotation.txt", header=TRUE, as.is=TRUE)

# Annotate each SV type in the list
library(plyr)
sv_annotated <- llply(sv_all, svAnnotation, genomeAnnotation=anno_data)
```

### 4. Visualization
`intansv` offers two main plotting functions based on `ggbio` and `ggplot2`.

```r
# Genomic distribution (Circular barplot)
# Requires a genome file with chromosome lengths
genome_info <- read.table("genome_size.txt", header=TRUE)
plotChromosome(genome_info, sv_all, windowSize=1000000)

# Specific region visualization
# Shows genes and SVs in a linear/circular track
plotRegion(sv_all, anno_data, "chr05", 1, 200000)
```

## Tips and Best Practices
- **Directory Inputs**: For `readCnvnator`, `readPindel`, and `readSvseq`, ensure the input directory contains only the relevant output files for that specific tool to avoid parsing errors.
- **SV Types**: The package focuses on three main types: deletions (`del`), duplications (`dup`), and inversions (`inv`).
- **Filtering**: The `read*` functions automatically perform basic quality filtering and resolve overlapping predictions from the same tool.
- **Annotation Format**: Ensure your annotation data frame matches the expected 6-column format exactly, as `svAnnotation` is sensitive to column order and naming.

## Reference documentation
- [intansvOverview](./references/intansvOverview.md)