---
name: shiba
description: Shiba is a computational framework designed to systematically identify differential RNA splicing across bulk, single-cell, and long-read sequencing platforms. Use when user asks to quantify alternative mRNA splicing events, analyze single-cell RNA-seq data for differential splicing, process long-read RNA-seq data, or perform lightweight splicing analysis.
homepage: https://github.com/Sika-Zheng-Lab/Shiba
---


# shiba

## Overview

Shiba is a versatile computational framework designed to systematically identify differential RNA splicing across various sequencing platforms. It streamlines a complex four-step workflow—transcript assembly (via StringTie), event identification, read counting (via RegTools and featureCounts), and statistical testing (Fisher's exact test)—into a manageable pipeline. 

Use this skill when you need to:
- Quantify alternative mRNA splicing events from bulk RNA-seq.
- Analyze single-cell RNA-seq data for differential splicing (scShiba).
- Process long-read RNA-seq data for splicing analysis.
- Execute lightweight splicing analysis with minimal dependencies (MameShiba).

## Command Line Usage

Shiba is primarily executed via Python scripts that ingest a configuration file. Ensure your environment is activated (`conda activate shiba`) before running these commands.

### Bulk RNA-seq Analysis (Standard)
The standard pipeline performs the full four-step process.
```bash
shiba.py -p [threads] config.yaml
```

### Lightweight Analysis (MameShiba)
Use the `--mame` flag for a faster, lightweight version that requires fewer dependencies. This is ideal if you only need to perform splicing analysis without the full assembly overhead.
```bash
shiba.py --mame -p [threads] config.yaml
```

### Single-Cell Analysis (scShiba)
For single-cell datasets, use the dedicated `scshiba.py` entry point.
```bash
scshiba.py -p [threads] config.yaml
```

### Snakemake Workflows
Shiba provides Snakemake wrappers for reproducible and scalable execution.
```bash
# For bulk RNA-seq
snakemake -s snakeshiba.smk --configfile config.yaml --cores [threads] --use-singularity

# For single-cell RNA-seq
snakemake -s snakescshiba.smk --configfile config.yaml --cores [threads] --use-singularity
```

## Best Practices and Expert Tips

### Performance Optimization
- **Threading**: Always specify the `-p` (or `--cores` in Snakemake) parameter to match your available CPU resources, as transcript assembly and read counting are computationally intensive.
- **Memory Management**: When running the full pipeline on large datasets, ensure the machine has sufficient RAM for StringTie assembly and featureCounts.

### Data Compatibility
- **Long-Read Support**: Shiba supports long-read RNA-seq data. Ensure your input files and configuration reflect the specific requirements for long-read alignments.
- **Excel Outputs**: If you require results in Excel format, you must manually install `styleframe` (e.g., `pip install styleframe==4.1`), as it is an optional dependency.

### Visualization
- After identifying DSEs, use the companion tool `shiba2sashimi` to generate sashimi plots for visual verification of splicing events.

## Reference documentation
- [Shiba GitHub Repository](./references/github_com_Sika-Zheng-Lab_Shiba.md)
- [Shiba Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_shiba_overview.md)