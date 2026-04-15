---
name: gw
description: gw is a high-performance genome browser for visualizing sequencing alignments and variant calls in the terminal or via programmatic image generation. Use when user asks to visualize genomic regions, generate PNG or PDF snapshots of alignments, compare multiple BAM files, or annotate variants.
homepage: https://github.com/kcleal/gw
metadata:
  docker_image: "quay.io/biocontainers/gw:1.2.6--hff18be8_0"
---

# gw

## Overview
`gw` is a high-performance genome browser designed for speed and terminal-centric workflows. It provides a lightweight alternative to heavy GUI browsers, allowing for the immediate visualization of sequencing alignments and variant calls. Beyond interactive use, `gw` excels at programmatic image generation, enabling users to produce PNG or PDF snapshots of genomic regions directly from the CLI for reports or automated pipelines.

## Core CLI Patterns

### Basic Visualization
To view a specific genomic region, provide a reference genome (or index) and an alignment file:
```bash
gw hg38 -b sample.bam -r chr1:10000-20000
```

### Comparative Views
`gw` supports side-by-side and multi-track comparisons through flag repetition:
- **Multiple Regions**: `gw hg38 -b sample.bam -r chr1:1-20000 -r chr2:50000-60000`
- **Multiple Samples**: `gw hg38 -b s1.bam -b s2.bam -r chr1`
- **Wildcards**: `gw hg38 -b '*.bam' -r chr1`

### Variant Annotation
Load VCF/BCF files to view variants alongside alignments:
```bash
gw hg38 -b sample.bam -v variants.vcf
```
To save annotations (e.g., "Yes/No" labels) to a file:
```bash
gw hg38 -b sample.bam -v variants.vcf --labels Yes,No --out-labels labels.tsv
```

### Headless Image Generation
Use the `-n` flag to generate images without opening a window:
- **To Stdout (PNG)**: `gw hg38 -b sample.bam -r chr1:1-20000 -n > output.png`
- **To File (PDF)**: `gw hg38 -b sample.bam -r chr1:1-20000 -n --fmt pdf -f output.pdf`
- **Batch Parallel Plotting**: `gw hg38 -b sample.bam -n -t 24 --outdir plots_dir`

## Interactive Command Box
When in the interactive window, press `:` or `/` to access the command box:

| Command | Action |
| :--- | :--- |
| `help` | Open the help menu |
| `config` | Edit the `.gw.ini` configuration file |
| `mate` | Move view to the mate of the selected read |
| `mate add` | Add the mate's position as a new side-by-side view |
| `ylim <int>` | Set the maximum y-axis (depth) for the view |
| `find <QNAME>` | Highlight all reads matching a specific Query Name |
| `filter <expr>` | Filter reads (e.g., `filter mapq >= 30`) |
| `snapshot` | Save the current view as a PNG |

## Expert Tips
- **Reference Handling**: Ensure your reference genome is indexed. `gw` can use standard aliases like `hg38` or `t2t` if configured, or direct paths to `.fa` files.
- **Performance**: For large-scale plotting, always use the `-t` (threads) option to utilize multiple CPU cores.
- **Pipe Support**: `gw` can read VCF data from stdin using `-v -`, which is useful for piping results from tools like `bcftools`.
- **Navigation**: Use the `add` command in the interactive box (e.g., `add chrX:1-5000`) to dynamically expand your view without restarting the tool.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_kcleal_gw.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_gw_overview.md)