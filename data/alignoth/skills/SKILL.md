---
name: alignoth
description: Alignoth generates high-quality genomic alignment visualizations from BAM files as interactive HTML or Vega-Lite specifications. Use when user asks to visualize genomic regions, highlight specific variants or intervals, create interactive alignment plots, or generate static images of read alignments.
homepage: https://github.com/koesterlab/alignoth
metadata:
  docker_image: "quay.io/biocontainers/alignoth:1.4.6--h1520f10_0"
---

# alignoth

## Overview
Alignoth is a specialized tool for generating high-quality alignment visualizations from BAM files. It produces Vega-Lite specifications, which can be rendered as interactive HTML pages or converted into static image formats. This skill provides the necessary command-line patterns to visualize genomic regions, highlight specific variants or intervals, and manage output formats for bioinformatics analysis.

## Core Usage Patterns

### Basic Alignment Plot
To generate a standard alignment plot for a specific genomic region:
```bash
alignoth -b input.bam -r reference.fasta -g chr1:1000-2000 > plot.vl.json
```

### Interactive HTML Output
To create a self-contained interactive visualization that can be opened in a web browser:
```bash
alignoth -b input.bam -r reference.fasta -g chr1:1000-2000 --html > plot.html
```
*Tip: Use `--no-embed-js` to reduce file size if you have an active internet connection to load dependencies.*

### Visualizing Around a Specific Position
Instead of a range, you can center the plot on a specific base (defaults to +/- 500bp):
```bash
alignoth -b input.bam -r reference.fasta -a chr1:1500 > plot.vl.json
```

### Highlighting Variants and Regions
You can overlay specific genomic features onto the alignment:
- **Manual Highlight**: `-h "label:1000-1100"`
- **VCF Integration**: `-v variants.vcf` (highlights variants from the VCF)
- **BED Integration**: `-b regions.bed` (highlights regions from the BED file)

### Static Image Generation
Alignoth outputs Vega-Lite JSON by default. To generate PDFs or PNGs, pipe the output to the Vega-Lite CLI tools:
```bash
alignoth -b input.bam -r reference.fasta -g chr1:1000-2000 | vl2vg | vg2pdf > plot.pdf
```

## Advanced Configuration

| Option | Description |
| :--- | :--- |
| `-d <int>` | **Max Read Depth**: Limits the number of read rows shown (default: 500). |
| `-w <int>` | **Max Width**: Sets the maximum pixel width of the plot (default: 1024). |
| `-p` | **Plot All**: Forces plotting of all reads (use only for small regions/low depth). |
| `-x <tag>` | **Aux Tag**: Displays the content of a specific BAM auxiliary tag in the tooltip. |
| `--mismatch-display-min-percent <int>` | Minimum mismatch percentage to show in the coverage track (default: 1). |

## Expert Tips
- **Interactive Wizard**: Running `alignoth` without any arguments launches an interactive mode that guides you through file selection and region definition.
- **Data Extraction**: Use the `-o <directory>` flag to split the output into separate files for read data, reference data, and the Vega-Lite specification. This is useful for custom downstream visualization.
- **Tooltip Customization**: Use the `-x` flag multiple times to include various BAM tags (e.g., `HP`, `PS`, `MQ`) in the interactive tooltips for deeper read inspection.

## Reference documentation
- [Alignoth GitHub README](./references/github_com_alignoth_alignoth.md)