---
name: shorttracks
description: ShortTracks converts small RNA-seq alignments into normalized, strand-specific BigWig coverage tracks optimized for genome browser visualization. Use when user asks to transform BAM files into RPM-normalized tracks, separate small RNA reads by length or read group, or generate multi-wiggle files for JBrowse2.
homepage: https://github.com/MikeAxtell/ShortTracks
metadata:
  docker_image: "quay.io/biocontainers/shorttracks:1.3--hdfd78af_0"
---

# shorttracks

## Overview
ShortTracks is a specialized utility designed to transform small RNA-seq alignments into biologically meaningful coverage tracks. Unlike general-purpose BAM-to-BigWig converters, it understands the specific requirements of small RNA analysis, such as the need to separate reads by length and strand. It automatically calculates normalization (Reads Per Million) and produces BigWig files optimized for visualization in tools like JBrowse2. It is compatible with both standard "verbose" BAM files and the "condensed" BAM format produced by ShortStack.

## Installation
The tool is available via Bioconda.
```bash
conda install bioconda::shorttracks
```
*Note: For Apple Silicon (M1/M2/M3) Macs, you must set the environment to `osx-64` as some dependencies are not yet native to ARM.*

## Command Line Usage

### Core Syntax
```bash
ShortTracks --bamfile [PATH_TO_BAM] [OPTIONS]
```

### Processing Modes
*   **simple (Default):** Processes the entire BAM file into a single track (or two if `--stranded` is used).
*   **readlength:** Splits output into four distinct size classes: 21nt, 22nt, 23-24nt, and "other". This is the standard for plant small RNA analysis.
*   **readgroup:** Generates separate tracks for each Read Group (`@RG`) tag found in the BAM header. This allows for fair comparison of multiple samples within one file.

### Common Patterns

**1. Standard Plant sRNA Profiling**
To generate strand-specific tracks for the major plant sRNA size classes:
```bash
ShortTracks --bamfile my_data.bam --mode readlength --stranded
```
This produces 8 BigWig files (4 size classes × 2 strands), all normalized to RPM relative to the total reads in the original BAM.

**2. Comparing Multiplexed Samples**
If your BAM contains multiple samples identified by Read Groups:
```bash
ShortTracks --bamfile multiplexed.bam --mode readgroup
```
The RPM calculation for each output file is based on the total reads *within that specific read group*, ensuring normalized values are comparable across samples.

## Expert Tips & Best Practices

*   **JBrowse2 Integration:** ShortTracks is specifically designed to work with the JBrowse2 `multi-wiggle` track feature. When loading the output:
    *   Use the `xyplot` renderer for overlapping views.
    *   Use the `multirowdensity` renderer for `readgroup` mode to quickly spot accumulation differences.
*   **Normalization Logic:** All outputs are normalized to Reads Per Million (RPM). In `readlength` mode, the denominator is the total number of reads in the original BAM file, not just the reads in that specific size class.
*   **BAM Compatibility:** If using ShortStack for alignment, you do not need to decompress or expand "condensed" BAMs; ShortTracks (v1.2+) handles them natively.
*   **Strand Orientation:** When using `--stranded`, the tool generates separate files for plus and minus strands. Ensure your genome browser is configured to display the minus strand (often shown as negative values) correctly for visualization.

## Reference documentation
- [ShortTracks GitHub Repository](./references/github_com_MikeAxtell_ShortTracks.md)
- [ShortTracks Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_shorttracks_overview.md)