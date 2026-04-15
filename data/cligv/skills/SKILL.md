---
name: cligv
description: cligv is a terminal-based interactive genome viewer for visualizing genomic regions, read alignments, and variants. Use when user asks to browse genomic regions, inspect read coverage, verify variants, or visualize BAM and VCF files in the command line.
homepage: https://github.com/jonasfreudig/cligv
metadata:
  docker_image: "quay.io/biocontainers/cligv:0.1.0--pyhdfd78af_0"
---

# cligv

## Overview
cligv (command line Interactive Genome Viewer) is a lightweight, fast alternative to traditional GUI genome browsers. It provides an interactive interface within the terminal to browse genomic regions, inspect read coverage, and verify variants. It is specifically optimized for bioinformaticians working in shell environments who require immediate visual feedback on sequence data and alignments.

## Command Line Interface

### Basic Syntax
The primary command is `cligv`, which requires at least a reference FASTA file.

```bash
cligv <reference.fasta> [options]
```

### Common Patterns
*   **View Reference Only**: `cligv reference.fasta`
*   **View Alignments**: `cligv reference.fasta -b alignments.bam`
*   **View Variants**: `cligv reference.fasta -v variants.vcf.gz`
*   **Jump to Region**: `cligv reference.fasta -r chr1:1000-2000`
*   **Full Integration**: `cligv reference.fasta -b alignments.bam -v variants.vcf.gz -r chrX:50000-51000`

### Optional Flags
*   `-b, --bam`: Path to the BAM file for read alignments.
*   `-v, --vcf`: Path to the VCF file for variant calls.
*   `-r, --region`: Initial genomic region to display (format: `chrom:start-end`).
*   `-t, --tag`: Color reads based on a specific BAM tag (e.g., `-t HP` for haplotype).
*   `--light-mode`: Use the light color theme instead of the default dark theme.

## Interactive Navigation
Once the viewer is open, use the following keyboard shortcuts to navigate the genome:

| Key | Action |
|-----|--------|
| **a** | Scroll left |
| **d** | Scroll right |
| **w** | Zoom in (narrower interval) |
| **s** | Zoom out (wider interval) |
| **g** | Go to a specific region (opens prompt) |
| **t** | Toggle between dark and light color modes |
| **q** | Quit the application |

## Expert Tips and Best Practices

### Data Preparation
*   **Indexing**: Ensure all input files are indexed. BAM files require a `.bai` index, and VCF files should be compressed with `bgzip` and indexed with `tabix` (`.tbi`).
*   **FASTA Index**: The reference FASTA should have a corresponding `.fai` index in the same directory.

### Visualization Optimization
*   **Tag-Based Coloring**: Use the `-t` flag to highlight specific read attributes. This is particularly useful for visualizing phased data (using the `HP` tag) or molecular identifiers.
*   **Region Specificity**: When dealing with large genomes, always start with the `-r` flag to jump directly to the locus of interest, avoiding unnecessary scrolling from the start of the first chromosome.
*   **Terminal Contrast**: If the color-coding is difficult to read, use the `t` key to switch themes. The "light-mode" is often better for terminals with white or light-gray backgrounds.

## Reference documentation
- [cligv GitHub Repository](./references/github_com_jonasfreudig_cligv.md)
- [cligv Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cligv_overview.md)