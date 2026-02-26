---
name: multiqc_sav
description: This tool integrates Illumina SAV data into MultiQC reports to visualize raw sequencing run metrics from InterOp binary files. Use when user asks to visualize sequencing run performance, include SAV plots in MultiQC reports, or monitor cluster density and quality scores.
homepage: http://multiqc.info
---


# multiqc_sav

## Overview
The `multiqc_sav` skill enables the integration of Illumina SAV data into standard MultiQC reports. While MultiQC typically handles log files from bioinformatics tools, this plugin allows users to visualize raw sequencing run metrics directly from the `InterOp` binary files produced by Illumina platforms (e.g., NovaSeq, MiSeq, NextSeq). Use this when you need a high-level summary of sequencing hardware performance alongside downstream primary analysis results.

## Usage Patterns and Best Practices

### Basic Execution
To include SAV plots in your MultiQC report, ensure the plugin is installed and point MultiQC to the directory containing the Illumina run folder (specifically the `InterOp` subfolder).

```bash
multiqc .
```
*Note: MultiQC automatically detects the SAV data if the plugin is installed and the InterOp files are present in the search path.*

### Targeted Search
If your directory structure is complex, you can explicitly point to the run folders to speed up the search:

```bash
multiqc /path/to/illumina_run_folder/
```

### Key Visualizations Provided
When this skill is active, the resulting MultiQC report will include:
- **Analysis Methods**: Summary of the run parameters.
- **Flow Cell Intensity**: Plots showing signal strength across tiles.
- **Cluster Density**: Visualization of clusters passing filter (PF) vs. raw density.
- **Quality Scores**: Distribution of Q-scores (e.g., % > Q30) over the course of the run.

### Troubleshooting
- **Missing Plots**: If SAV plots do not appear, verify that the `InterOp` directory contains the necessary `.bin` files (e.g., `ExtractionMetrics.bin`, `QualityMetrics.bin`).
- **Installation Check**: Confirm the plugin is recognized by running `multiqc --version`. It should be listed among the loaded plugins.

## Reference documentation
- [multiqc_sav Overview](./references/anaconda_org_channels_bioconda_packages_multiqc_sav_overview.md)
- [MultiQC General Documentation](./references/seqera_io_multiqc.md)