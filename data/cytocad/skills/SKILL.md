---
name: cytocad
description: "CytoCAD detects large-scale genomic copy-number gains and losses from low-depth whole-genome sequencing data. Use when user asks to identify copy-number variations, analyze read coverage for genomic anomalies, or generate chromosome ideograms from BAM files."
homepage: https://github.com/cytham/cytocad
---


# cytocad

## Overview

CytoCAD (Coverage Anomaly Detection) is a specialized bioinformatics tool for detecting large-scale genomic copy-number gains and losses. It is optimized for low-depth (~8X) whole-genome sequencing data, particularly long-read data from platforms like Oxford Nanopore. The tool automates the workflow of analyzing read coverage per chromosome to identify change points and produces both a BED file of CNV regions and a visual SVG ideogram.

## CLI Usage and Patterns

The basic command structure for CytoCAD requires an input BAM file and a target directory for output files.

### Basic Execution
```bash
cytocad [Options] sample.bam working_dir
```

### Primary Outputs
- `${sample}.CNV.bed`: A BED file containing the coordinates of detected chromosome regions with CNVs.
- `${sample}.ideo.svg`: A chromosome ideogram (generated via `tagore`) where Red indicates gains and Blue indicates losses.

## Expert Tips and Best Practices

### Adjusting Detection Sensitivity
The default minimum size for a detectable CNV is approximately 500 kb. You can fine-tune the sensitivity of the detection by adjusting the `interval` and `rolling` parameters.
- **Formula**: `minimum detectable size ≈ interval * rolling`
- Decrease these values to detect smaller variations, though this may increase noise in low-depth data.

### Environment Requirements
CytoCAD relies on several external binaries. Ensure the following are installed and available in your system `PATH`:
- `samtools` (>= 1.3.0)
- `bedtools` (>= 2.26.0)
- `rsvg-convert` (>= 2.40.13, often found in the `librsvg2-bin` package on Linux)

### Data Compatibility
- **Sequencing Depth**: While tested at ~8X, the tool is specifically designed for "low-depth" scenarios where traditional CNV callers might struggle.
- **Structural Variations**: CytoCAD is strictly for copy-number variations (gains/losses). It does not detect balanced structural variations like inversions or translocations.
- **Phasing**: Note that CytoCAD does not currently support the phasing of CNVs for homologous chromosome pairs.

### Visual Interpretation
When reviewing the SVG output:
- **Red Regions**: Represent genomic gains (duplications/multiplications).
- **Blue Regions**: Represent genomic losses (deletions).
- **Ideogram Layout**: While the `tagore` output may look like sister chromatids, they represent homologous chromosome pairs.

## Reference documentation
- [cytocad - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_cytocad_overview.md)
- [cytham/cytocad: Large copy-number variation detector using low-depth whole-genome sequencing data](./references/github_com_cytham_cytocad.md)