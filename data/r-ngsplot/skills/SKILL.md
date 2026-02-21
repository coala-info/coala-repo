---
name: r-ngsplot
description: R package ngsplot (documentation from project home).
homepage: https://cran.r-project.org/web/packages/ngsplot/index.html
---

# r-ngsplot

name: r-ngsplot
description: Quick mining and visualization of Next-Generation Sequencing (NGS) data (ChIP-seq, RNA-seq) by integrating genomic databases. Use this skill to generate average profiles and heatmaps for genomic regions like TSS, gene bodies, enhancers, and exons using BAM files.

# r-ngsplot

## Overview
The `ngsplot` package provides a streamlined workflow for visualizing NGS data enrichment across functional genomic elements. It integrates a large database of functional elements (TSS, TES, genebody, exon, CGI, enhancer, DHS) for multiple genomes, allowing users to create publication-quality average profiles and heatmaps with minimal configuration.

## Installation
To install the required R dependencies and the package:
```R
install.packages("doMC", dep=T)
install.packages("caTools", dep=T)
install.packages("utils", dep=T)
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("BSgenome", "Rsamtools", "ShortRead"))
# Note: ngsplot is typically installed via source or system-level installation 
# as it relies on bundled database scripts.
```

## Core Workflows

### 1. Basic Plotting (ngs.plot.r)
The primary function for generating plots. It requires a genome, a region, and a BAM file.

```R
# Example: Plotting H3K4me3 enrichment at TSS for hg19
# Command-line style call often used via system() or Rscript
# ngs.plot.r -G hg19 -R tss -C input.bam -O output_prefix -L 3000 -FL 300
```

**Mandatory Arguments:**
- `-G`: Genome name (e.g., `hg19`, `mm10`, `sacCer3`).
- `-R`: Genomic region (`tss`, `tes`, `genebody`, `exon`, `cgi`, `enhancer`, `dhs`, or `bed`).
- `-C`: Path to an indexed BAM file or a configuration file.
- `-O`: Output name prefix.

### 2. Multiplot Configuration
To plot multiple samples or specific gene lists together, create a tab-delimited configuration file:
```text
# config.txt
# BAM_File           Gene_List_or_-1    Title
sample1.bam          high_exp.txt       "High"
sample1.bam          low_exp.txt        "Low"
```
Run using: `ngs.plot.r -G hg19 -R genebody -C config.txt -O multiplot_out`

### 3. Refining Regions (-F option)
Use the `-F` descriptor string to filter the database:
- **Gene Type:** `protein_coding`, `lincRNA`, `miRNA`.
- **Cell Line:** `K562`, `H1hesc`, `Hepg2`.
- **RNA-seq mode:** Use `-F rnaseq` to handle transcript-specific coverage.

### 4. Replotting (replot.r)
Modify visual parameters (colors, scales, smoothing) without re-calculating coverage from BAM files.
```R
# replot.r prof -I result.zip -O new_plot -SE 0 -MW 5
```

## Key Parameters
- `-L`: Flanking region size in bp.
- `-FL`: Fragment length (default 150). Set to library insert size for ChIP-seq.
- `-GO`: Gene order for heatmaps (`total`, `hc` (hierarchical), `km` (k-means), `none`).
- `-CO`: Color scheme (e.g., `yellow:white:royalblue` for bam-pairs).
- `-SP`: Random sampling rate (0-1] to speed up previewing.

## Reference documentation
- [Program Arguments 101](./references/ProgramArguments101.md)
- [README](./references/README.md)
- [Supported Genomes](./references/SupportedGenomes.md)
- [Use Further Info (Filtering)](./references/UseFurtherInfo.md)
- [Home Page](./references/home_page.md)
- [Wiki Index](./references/wiki.md)