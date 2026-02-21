---
name: pauvre
description: pauvre is a specialized suite of plotting tools designed for the unique characteristics of long-read sequencing data (Oxford Nanopore and PacBio).
homepage: https://github.com/conchoecia/gloTK
---

# pauvre

## Overview
pauvre is a specialized suite of plotting tools designed for the unique characteristics of long-read sequencing data (Oxford Nanopore and PacBio). While general-purpose tools often struggle with the scale and error profiles of long reads, pauvre provides high-utility visualizations that correlate read length with quality scores. It is most effective for quality control (QC) and comparative analysis of sequencing runs.

## Installation
The tool is primarily distributed via Bioconda:
```bash
conda install -c bioconda pauvre
```

## Common CLI Patterns

### Generating Marginal Histograms (marginplot)
The most common use case is creating a "marginplot," which shows a 2D heatmap of read length vs. quality, with 1D histograms on the margins.

```bash
# Basic marginplot from a FASTQ file
pauvre marginplot --fastq input.fastq --plotname output_prefix

# Filtering by quality or length during plotting
pauvre marginplot --fastq input.fastq --min_length 500 --min_quality 7
```

### Visualizing Length Distributions (redwood)
The `redwood` command is used to create circularized or "redwood" style plots of read lengths, which are useful for seeing the distribution of very long reads.

```bash
pauvre redwood --fastq input.fastq --plotname redwood_output
```

### Comparative Plotting
You can compare multiple sequencing runs on a single plot by providing multiple inputs.

```bash
pauvre marginplot --fastq run1.fastq run2.fastq --plotname comparison_plot
```

## Expert Tips
- **Input Formats**: While FASTQ is the standard input, ensure your files are decompressed or that you are using a version that supports `.gz` if the CLI environment allows.
- **Resource Management**: Long-read datasets can be massive. If the tool hangs, consider subsampling your FASTQ file before plotting, as the visual representation of the distribution usually stabilizes after a few hundred thousand reads.
- **Plot Customization**: Use the `--plotname` flag consistently to organize outputs, as the tool generates multiple files (e.g., .png, .pdf, and stats summaries) for each run.
- **Quality Scores**: pauvre typically uses the standard Phred scale. If your data uses a different encoding, verify the quality score distribution in the resulting stats file.

## Reference documentation
- [pauvre - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pauvre_overview.md)