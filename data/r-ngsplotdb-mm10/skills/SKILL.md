---
name: r-ngsplotdb-mm10
description: This R package provides genomic databases and annotation tables for visualizing next-generation sequencing data specifically for the mouse mm10 genome. Use when user asks to generate average profiles, create heatmaps of genomic enrichment, or visualize NGS data at functional regions like TSS and enhancers for Mus musculus.
homepage: https://cran.r-project.org/web/packages/ngsplotdb-mm10/index.html
---


# r-ngsplotdb-mm10

name: r-ngsplotdb-mm10
description: Specialized R package for visualizing next-generation sequencing (NGS) data (ChIP-seq, RNA-seq) specifically for the Mus musculus (mouse) mm10 genome. Use this skill when you need to generate average profiles or heatmaps of genomic enrichment at functional regions like TSS, TES, gene bodies, or enhancers for mouse data.

## Overview

The `ngsplotdb-mm10` package provides the necessary genomic database and annotation tables for the `ngsplot` system to work with the mouse (mm10) genome. It allows for the quick mining and visualization of NGS samples at functional genomic regions by integrating Ensembl and RefSeq databases.

## Installation

To install the package and its dependencies within R:

```R
install.packages("ngsplotdb-mm10")
# Ensure core ngsplot dependencies are also installed
install.packages(c("doMC", "caTools", "utils"))
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("BSgenome", "Rsamtools", "ShortRead"))
```

## Workflows

### Single Sample Plotting
To visualize enrichment for a single BAM file at a specific genomic region:

```R
# Example: Plotting TSS enrichment for a mouse ChIP-seq sample
# Note: In R, these are typically invoked via system calls to the underlying scripts
system("ngs.plot.r -G mm10 -R tss -C your_sample.bam -O output_prefix -T 'H3K4me3 TSS' -L 3000")
```

### Multi-sample Comparison
To compare multiple samples or gene lists, create a configuration file (tab-delimited):

```text
# config.txt
sample1.bam    high_expressed_genes.txt    "High"
sample1.bam    low_expressed_genes.txt     "Low"
```

Then run:
```R
system("ngs.plot.r -G mm10 -R genebody -C config.txt -O comparison_output")
```

### Replotting and Fine-tuning
Use `replot.r` to adjust visual parameters (colors, scales, clustering) without re-calculating coverage:

```R
# Generate a heatmap with K-means clustering
system("replot.r heatmap -I output_prefix.zip -O new_heatmap -GO km -KNC 5")
```

## Key Parameters for mm10

- **-R (Regions)**: `tss`, `tes`, `genebody`, `exon`, `cgi`, `enhancer`, `dhs`, or `bed`.
- **-F (Further Info)**: Refines annotations. Examples:
  - `-F protein_coding`: Focus on coding genes.
  - `-F enhancer,liver`: Select liver-specific enhancers (mouse tissue specific).
  - `-F rnaseq`: Use RNA-seq mode for coverage calculation.
- **-D (Database)**: `ensembl` (default) or `refseq`.
- **-GO (Gene Order)**: `total` (enrichment), `hc` (hierarchical clustering), `km` (k-means), or `none`.

## Tips for Mouse Data
- **Enhancers**: The mm10 database includes tissue-specific enhancer data. Use the `-F` flag with descriptors like `boneMarrow`, `cerebellum`, `cortex`, `heart`, `liver`, `mESC`, etc.
- **Fragment Length**: For ChIP-seq, set `-FL` to your library's average fragment length (default 150) for more accurate physical coverage.
- **Normalization**: Use `-AL bin` for gene bodies to normalize varying gene lengths into equal bins.

## Reference documentation
- [ProgramArguments101](./references/ProgramArguments101.md)
- [README](./references/README.md)
- [SupportedGenomes](./references/SupportedGenomes.md)
- [UseFurtherInfo](./references/UseFurtherInfo.md)
- [home_page](./references/home_page.md)
- [wiki](./references/wiki.md)