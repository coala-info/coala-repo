---
name: ngsplotdb-ngsplotdb-hg19
description: This tool provides the hg19 genome database and annotations for visualizing next-generation sequencing data within the NGSplot framework. Use when user asks to generate profile plots, create heatmaps for human genomic data, or visualize enrichment at functional regions like gene bodies and transcription start sites using the hg19 assembly.
homepage: https://github.com/shenlab-sinai/ngsplot
---


# ngsplotdb-ngsplotdb-hg19

## Overview
This skill facilitates the use of the hg19 genome database within the NGSplot framework. NGSplot is a visualization tool designed for high-efficiency mining and visualization of next-generation sequencing (NGS) samples at functional genomic regions. The hg19 database package provides the necessary genomic coordinates and annotations (gene bodies, exons, CGIs, and optionally enhancers/DHS) required to generate profile plots and heatmaps for human data mapped to the GRCh37/hg19 assembly.

## Installation and Setup
The hg19 database is typically installed via conda or manually managed using the `ngsplotdb.py` utility.

```bash
# Install via bioconda
conda install bioconda::ngsplotdb-ngsplotdb-hg19

# Verify installed genomes
ngsplotdb.py list
```

## Core CLI Patterns
The primary command for generating plots is `ngs.plot.r`. When using this skill, always specify `hg19` as the genome.

### Basic Enrichment Plot
To plot a single BAM file against all gene bodies in hg19:
```bash
ngs.plot.r -G hg19 -R genebody -C input.bam -O output_prefix -T "Sample Title"
```

### Using a Configuration File
For multiple samples or complex comparisons, use a configuration file (tab-delimited: `bam_file<tab>region_file<tab>title`).
```bash
ngs.plot.r -G hg19 -R tss -C config.txt -O multi_sample_plot
```

### Common Region Types (-R)
The hg19 database supports several predefined functional regions:
- `genebody`: Profiles across the entire gene length.
- `tss`: Transcription Start Sites (default window is +/- 2kb).
- `tes`: Transcription End Sites.
- `exon`: Profiles across all exons.
- `cgi`: CpG Islands.
- `enhancer`: Requires the extension package; profiles across known enhancers.
- `dhs`: Requires the extension package; profiles across DNase I hypersensitive sites.

## Expert Tips and Best Practices
- **Fragment Size**: For ChIP-seq, use the `-L` option to specify the expected fragment length to improve the accuracy of the enrichment profile.
- **Standardization**: Use `-SC global` to make the Y-axis scales comparable across different plots if you are running multiple commands.
- **Custom Regions**: If you have specific hg19 coordinates not covered by the standard database, use `-R bed` and provide your own BED file via the `-E` option.
- **Performance**: For large datasets (e.g., 50GB+ BAM files), NGSplot is memory-efficient but benefits from multiple CPU cores. Use `-P` to specify the number of processors (e.g., `-P 4`).
- **Gene Lists**: You can limit the plot to a specific subset of hg19 genes by providing a text file with gene symbols or IDs to the `-E` option when `-R` is set to a standard region like `genebody`.

## Reference documentation
- [NGSplot GitHub Overview](./references/github_com_shenlab-sinai_ngsplot.md)
- [Bioconda hg19 Database Overview](./references/anaconda_org_channels_bioconda_packages_ngsplotdb-ngsplotdb-hg19_overview.md)
- [NGSplot Wiki Home](./references/github_com_shenlab-sinai_ngsplot_wiki.md)