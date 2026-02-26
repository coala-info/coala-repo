---
name: r-ngsplotdb-hg38
description: This package provides the hg38 human genome database and functional annotations for the ngsplot visualization system. Use when user asks to create average profiles, generate heatmaps of sequencing read distributions, or visualize genomic enrichment across hg38 features like TSS and gene bodies.
homepage: https://cran.r-project.org/web/packages/ngsplotdb-hg38/index.html
---


# r-ngsplotdb-hg38

## Overview
The `ngsplotdb-hg38` package provides the essential genomic database for the `ngsplot` system, specifically tailored for the human genome assembly hg38. It allows for the rapid mining and visualization of NGS data by integrating functional genomic annotations. It is primarily used to create high-quality average profiles and heatmaps that show how sequencing reads (from BAM files) are distributed across specific genomic features.

## Installation
To use this database within R, ensure the core `ngsplot` package and this database are installed:

```R
# Install the hg38 database package
install.packages("ngsplotdb-hg38")

# Required dependencies for the ngsplot workflow
install.packages(c("doMC", "caTools", "utils"))
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("BSgenome", "Rsamtools", "ShortRead"))
```

## Core Workflow

The primary entry point for visualization is the `ngs.plot.r` function (often called via system command or R wrapper).

### 1. Basic Plotting
To plot enrichment around the Transcription Start Site (TSS) for a single BAM file:

```R
# Example: Plotting H3K4me3 enrichment at TSS for hg38
# -G: Genome (hg38)
# -R: Region (tss, tes, genebody, exon, cgi, enhancer, dhs, or bed)
# -C: Path to indexed BAM file
# -O: Output prefix
# -FL: Fragment length (e.g., 300 for ChIP-seq)
system("ngs.plot.r -G hg38 -R tss -C sample.bam -O output_prefix -FL 300")
```

### 2. Multi-plot Configuration
To compare multiple samples or gene lists, create a configuration file (tab-delimited):

```text
# config.txt
# BAM_File             Gene_List_or_-1    Title
sample1.bam            -1                 "Sample 1"
sample2.bam            -1                 "Sample 2"
```

Then run:
```R
system("ngs.plot.r -G hg38 -R genebody -C config.txt -O multi_sample_plot")
```

### 3. Refining Annotations (-F option)
Use the `-F` flag to filter the database by gene type, cell line, or tissue:
- `-F protein_coding` (Default)
- `-F lincRNA`
- `-F K562` (For DHS/Enhancer regions)
- `-F rnaseq` (Optimized for RNA-seq coverage)

## Key Parameters

| Argument | Description | Notes |
| :--- | :--- | :--- |
| `-G` | Genome ID | Use `hg38` for this package. |
| `-R` | Genomic Region | `tss`, `tes`, `genebody`, `exon`, `cgi`, `enhancer`, `dhs`, `bed`. |
| `-L` | Flanking Region | Size in bp (Default: 2000 for TSS/TES). |
| `-GO` | Gene Order | Algorithm for heatmap ranking: `total`, `hc` (cluster), `km` (k-means), `none`. |
| `-CO` | Color | Heatmap colors (e.g., `yellow:white:royalblue`). |
| `-SS` | Strand Specific | `both`, `same`, `opposite`. |

## Tips for Success
- **Indexing**: All BAM files must be indexed (`.bai` files present).
- **Fragment Length**: For ChIP-seq, always set `-FL` to your library's average fragment length to ensure accurate physical coverage calculation.
- **RNA-seq**: When plotting RNA-seq, use `-F rnaseq` to account for splicing and transcript-specific coverage.
- **Memory**: For large datasets, use `-P` to specify the number of CPU cores to speed up calculation.

## Reference documentation
- [Program Arguments Guide](./references/ProgramArguments101.md)
- [Package README](./references/README.md)
- [Supported Genomes List](./references/SupportedGenomes.md)
- [Using Further Information (-F)](./references/UseFurtherInfo.md)
- [Home Page Reference](./references/home_page.md)