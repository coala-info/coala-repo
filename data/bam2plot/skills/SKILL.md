---
name: bam2plot
description: The bam2plot tool visualizes sequencing depth and coverage by transforming BAM or FastQ files into PNG or SVG plots. Use when user asks to visualize genomic coverage, identify sequencing gaps, analyze GC content, or inspect alignment quality.
homepage: https://github.com/willros/bam2plot
---


# bam2plot

## Overview
The `bam2plot` tool is a specialized utility for bioinformaticians to visualize sequencing depth and coverage. It transforms alignment data (BAM) or raw reads (FastQ) into interpretable PNG or SVG plots. It is designed to handle large-scale genomic data efficiently by leveraging `mosdepth` for coverage calculation and `polars` for data processing. Use this skill when you need to inspect the quality of an alignment, identify gaps in sequencing, or analyze the GC distribution of a reference genome.

## Command Line Usage

### Plotting from BAM Files
The `from_bam` subcommand is the primary method for visualizing existing alignments.

```bash
# Basic coverage plot for a BAM file
bam2plot from_bam --bam input.bam --outpath ./plots --sort_and_index

# Generate cumulative plots and highlight regions below 5x coverage
bam2plot from_bam -b input.bam -o ./output -t 5 --highlight --cum_plot
```

**Key Parameters:**
- `-w, --whitelist`: Provide a list of specific chromosomes/references to plot (e.g., "chr1 chr2").
- `-r, --rolling_window`: Adjust the smoothness of the plot. Larger values reduce noise.
- `-z, --zoom`: Focus on a specific genomic range. Format: `-z='start end'`.
- `-n, --number_of_refs`: Limit the number of chromosomes plotted to the top N references.

### Plotting from Raw Reads
The `from_reads` subcommand automates the alignment process before plotting.

```bash
# Align reads to a reference and plot coverage with GC content
bam2plot from_reads -r1 forward.fastq.gz -r2 reverse.fastq.gz -ref genome.fasta -o ./results --guci
```

### GC Content Analysis
The `guci` subcommand plots the GC content of a reference FASTA independently of alignment data.

```bash
bam2plot guci -ref genome.fasta -w 100 -o ./gc_plots -p both
```

## Best Practices and Expert Tips

### Performance Optimization
- **Pre-processing**: Use the `-s` (`--sort_and_index`) flag if your BAM file is not already prepared. If it is already sorted and indexed, use `-i` (`--index`) or omit these flags to save time.
- **Window Selection**: For large genomes (e.g., human), increase the `--rolling_window` (default is often too granular) to 500 or 1000 to produce cleaner, more readable plots.

### Visualization Strategy
- **Format Selection**: Use `-p svg` for publication-quality figures that require scaling, or `-p both` if you need quick previews (PNG) alongside vector graphics.
- **Low Coverage Identification**: Always set a `--threshold` and use the `--highlight` flag when performing quality control. This visually flags "problem areas" where sequencing depth fails to meet your project's requirements.
- **Cumulative Plots**: Use the `-c` flag to get a global view of coverage distribution across all chromosomes, which is helpful for detecting large-scale biases or aneuploidy.

### Troubleshooting
- **Dependencies**: Ensure `mosdepth` is installed in your environment, as `bam2plot` relies on it for high-speed coverage calculations.
- **Memory Management**: If processing many chromosomes, use `--whitelist` or `--number_of_refs` to prevent the tool from generating hundreds of unnecessary image files.

## Reference documentation
- [bam2plot GitHub README](./references/github_com_willros_bam2plot.md)
- [Bioconda bam2plot Overview](./references/anaconda_org_channels_bioconda_packages_bam2plot_overview.md)