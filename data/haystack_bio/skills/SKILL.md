---
name: haystack_bio
description: `haystack_bio` is a specialized bioinformatics suite designed to uncover the mechanistic links between chromatin states and gene regulation.
homepage: https://github.com/rfarouni/haystack_bio
---

# haystack_bio

## Overview

`haystack_bio` is a specialized bioinformatics suite designed to uncover the mechanistic links between chromatin states and gene regulation. It excels at identifying highly variable genomic regions (hotspots) across different biological conditions and pinpointing the transcription factors likely driving these changes. By combining signal tracks with motif analysis and expression data, it provides a comprehensive view of cellular identity and plasticity.

## Installation and Environment

The tool is implemented in Python 2.7. It is highly recommended to use a dedicated Conda environment to manage its legacy dependencies.

```bash
# Create a Python 2.7 environment
conda create -n haystack_env python=2.7
conda activate haystack_env

# Install via Bioconda
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
conda install haystack_bio
```

## Core CLI Modules

### 1. Genome Management
Before running analyses, you must download the required reference genome data.
```bash
# Download a specific genome (e.g., hg19, hg38, mm9, mm10)
haystack_download_genome hg19
```
*Note: Genomes are stored by default in your miniconda site-packages directory under `haystack/haystack_data/genomes`.*

### 2. Hotspot Analysis (`haystack_hotspots`)
Identifies regions of high epigenetic variability across multiple samples.
- Use this to find "hotspots" where chromatin accessibility or histone modifications differ significantly between cell types.
- Input: Typically aligned data (BAM) or signal tracks (BigWig).
- Check available options: `haystack_hotspots -h`

### 3. Motif Analysis (`haystack_motifs`)
Analyzes enriched transcription factor motifs within the identified variable regions.
- Provides p-values, q-values, motif logos, and average profiles.
- Use this to identify potential regulators mediating cell-type-specific variation.

### 4. Pipeline Integration
The `haystack_pipeline.py` script can be used to run the full analysis workflow, integrating epigenetic signal variability with motif enrichment and gene expression data.

## Expert Tips and Best Practices

- **Verification**: Always run `haystack_run_test` after installation. This downloads a small subset of hg19 (Chr21) and verifies the full pipeline execution.
- **RNA-seq Integration**: If gene expression data is available, `haystack_bio` can calculate TF activity by correlating motif presence in specific regions with the expression of nearby genes, outputting specificity and effect z-scores.
- **Blacklist Regions**: While the `blacklist` argument is optional in newer versions (v0.5.2+), providing a genomic blacklist file is recommended to reduce noise from problematic genomic regions (e.g., centromeres or high-signal artifacts).
- **Parallel Processing**: Use the `n_processes` argument where available to speed up computationally intensive motif searches.
- **Storage**: Be aware that reference genomes and additional required files can exceed 800MB per build. Ensure your `$HOME` directory or conda path has sufficient space.

## Reference documentation
- [haystack_bio Overview](./references/anaconda_org_channels_bioconda_packages_haystack_bio_overview.md)
- [haystack_bio GitHub Repository](./references/github_com_rfarouni_haystack_bio.md)