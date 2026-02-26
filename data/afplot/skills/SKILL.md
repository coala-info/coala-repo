---
name: afplot
description: afplot extracts and plots allele frequencies from VCF files to visualize variant data through histograms, scatter plots, and distance-to-theoretical-frequency plots. Use when user asks to plot allele frequencies, visualize VCF data for specific genomic regions, or generate whole-genome allele frequency distributions.
homepage: https://github.com/sndrtj/afplot
---


# afplot

## Overview
afplot is a command-line utility designed to extract and plot allele frequencies from VCF files. It transforms raw variant data into interpretable visualizations, including histograms with kernel density estimates, scatter plots along genomic coordinates, and distance-to-theoretical-frequency plots. The tool is particularly effective for diploid organisms and supports comparative analysis by allowing multiple VCF files to be grouped and plotted together.

## Core Subcommands and Modes
afplot operates using two primary subcommands, each supporting three visualization modes.

### Subcommands
- `regions`: Generates plots for specific genomic coordinates or regions defined in a BED file. Output is typically a directory of images.
- `whole-genome`: Creates a single image representing the entire genome (one plot per chromosome).

### Plotting Modes
- `histogram`: Creates a histogram of allele frequencies with an overlaid kernel density plot.
- `scatter`: Plots allele frequencies along the length of the region or chromosome.
- `distance`: Plots the distance to theoretical allele frequencies (0.0, 0.5, 1.0). This mode is specifically intended for autosomes in diploid organisms.

## Usage Patterns and Examples

### Prerequisites
- VCF files must be indexed with `tabix`.
- VCF headers must contain contig definitions.
- The `FORMAT` field must contain an `AD` (Allele Depth) column, with the reference allele depth listed first.

### Region-Specific Plotting
To plot a single region with a histogram:
```bash
afplot regions histogram -v input.vcf.gz -o output_dir -R chr1:1000000-2000000
```

To plot multiple regions defined in a BED file:
```bash
afplot regions scatter -v input.vcf.gz -o output_dir -L regions.bed
```

### Whole-Genome Plotting
To generate a whole-genome histogram for a specific sample:
```bash
afplot whole-genome histogram -v input.vcf.gz -l sample_label -s sample_name -o output_plot.png
```

### Comparative Analysis
You can plot multiple VCF files simultaneously. Use identical labels to group samples together:
```bash
afplot whole-genome histogram \
  -v file1.vcf.gz -l Group1 -s Sample1 \
  -v file2.vcf.gz -l Group1 -s Sample2 \
  -v file3.vcf.gz -l Group2 -s Sample3 \
  -o comparison_plot.png
```

## Expert Tips and Best Practices

### Filtering Noise
VCF files often contain many small, unplaced, or decoy contigs that clutter whole-genome plots. Use the `-e` flag with a regular expression to exclude them:
```bash
# Exclude all contigs containing "gl" or "random"
afplot whole-genome histogram -v input.vcf.gz -e '.*gl.*|.*random.*' -o clean_plot.png
```

### Color Coding
By default, afplot colors variants based on call type (`hom_alt`, `het`, `hom_ref`). However, when multiple VCF files are supplied, the tool automatically switches to coloring by the label provided via the `-l` flag.

### Headless Environments
If running on a server without a display, ensure you are using version 0.2.1 or later, as it defaults to the `agg` backend for Matplotlib to prevent crashes.

### Data Requirements
Only one sample per VCF file can be plotted at a time. If your VCF contains multiple samples, specify the target sample using the `-s` flag.

## Reference documentation
- [afplot - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_afplot_overview.md)
- [GitHub - sndrtj/afplot: Plot allele frequencies in VCF files](./references/github_com_sndrtj_afplot.md)