---
name: afplot
description: afplot visualizes allele frequency distributions from VCF files to identify genomic patterns such as sample contamination, deletions, or loss of heterozygosity. Use when user asks to plot allele frequencies, detect sample contamination, identify genomic deletions, or generate whole-genome allele frequency visualizations.
homepage: https://github.com/sndrtj/afplot
metadata:
  docker_image: "quay.io/biocontainers/afplot:0.2.1--py36h24bf2e0_1"
---

# afplot

## Overview
The `afplot` tool is a specialized bioinformatics utility designed to visualize allele frequency (AF) distributions. It is particularly useful for identifying patterns in sequencing data, such as detecting sample contamination, verifying diploidy, or spotting large-scale genomic deletions and duplications. It operates by extracting depth information from the `AD` (Allele Depth) field in VCF files and supports both targeted region plotting and automated whole-genome visualization.

## Core Subcommands
- `regions`: Generates plots for specific genomic coordinates or regions defined in a BED file.
- `whole-genome`: Generates a separate image for every chromosome/contig found in the VCF header.

## Plotting Modes
Each subcommand supports three distinct visualization modes:
- `histogram`: Displays AF distribution with a kernel density estimate (KDE). Ideal for checking overall sample quality and expected peaks (e.g., 0.5 for heterozygotes).
- `scatter`: Plots AF values along the genomic position. Useful for identifying localized loss of heterozygosity (LOH).
- `distance`: Plots the distance from the observed AF to the nearest theoretical diploid AF (0.0, 0.5, or 1.0). This is specifically for autosomes of diploid organisms.

## CLI Patterns and Best Practices

### Targeted Region Analysis
To plot a specific locus (e.g., a suspected deletion), use the `regions` subcommand.
```bash
afplot regions histogram -v input.vcf.gz -o output_dir -R chr1:1000000-2000000
```

### Processing BED Files
When analyzing multiple specific targets, provide a BED file. `afplot` will create a directory of plots.
```bash
afplot regions scatter -v input.vcf.gz -o output_dir -L targets.bed
```

### Whole-Genome Visualization
For a global view of the sample, use `whole-genome`. You must specify a label and sample name.
```bash
afplot whole-genome histogram -v input.vcf.gz -l sample_id -s sample_name -o genome_af.png
```

### Multi-Sample Comparison
You can overlay multiple VCFs in a single whole-genome plot by repeating the `-v`, `-l`, and `-s` flags. Samples with the same label will be grouped/colored together.
```bash
afplot whole-genome histogram \
  -v control.vcf.gz -l control -s sample1 \
  -v tumor.vcf.gz -l tumor -s sample2 \
  -o comparison.png
```

### Filtering Contigs
VCF headers often contain many small unplaced scaffolds that clutter whole-genome plots. Use the `-e` flag with a regex to exclude them.
```bash
# Exclude all contigs containing "random" or "Un"
afplot whole-genome histogram -v input.vcf.gz -e '.*random.*|.*Un.*' -o filtered_plot.png
```

## Expert Tips
- **Input Requirements**: Ensure your VCF is compressed with `bgzip` and indexed with `tabix`. The tool requires the `AD` format field to calculate frequencies (Reference Depth / Total Depth).
- **Headless Environments**: `afplot` (v0.2.1+) uses the Matplotlib `agg` backend by default, making it safe for use in SSH sessions or automated pipelines without an X11 display.
- **Diploid Assumption**: The `distance` mode is mathematically tuned for diploid organisms. Using it on polyploid samples or sex chromosomes in males may yield misleading results.



## Subcommands

| Command | Description |
|---------|-------------|
| afplot regions | Create plots for regions of interest for one VCF. Plots will be colored on call type (het/hom_alt/hom_ref). Your VCF file MUST contain an AD column in the FORMAT field, have contig names and lengths in the header, and be indexed with tabix. |
| afplot whole-genome | Create whole-genome plots for one or multiple VCFs. If only one VCF is supplied, plots will be colored on call type (het/hom_ref/hom_alt). If multiple VCF files are supplied, plots will be colored per file/label. Only one sample per VCF file can be plotted. |

## Reference documentation
- [afplot GitHub Repository](./references/github_com_sndrtj_afplot_blob_master_README.md)