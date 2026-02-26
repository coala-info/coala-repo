---
name: prooverlap
description: ProOvErlap quantifies and statistically validates spatial relationships and overlaps between genomic features using non-parametric randomization tests. Use when user asks to test overlap enrichment, analyze spatial proximity between features, perform strand-specific genomic analysis, or generate statistical visualizations of genomic localization.
homepage: https://github.com/ngualand/ProOvErlap
---


# prooverlap

## Overview

ProOvErlap is a specialized bioinformatics tool designed to quantify and statistically validate the spatial relationships between genomic features. Unlike standard intersection tools that merely report overlaps, ProOvErlap employs non-parametric randomization tests to determine if the observed patterns—either direct overlaps or spatial proximity—are statistically significant compared to a background distribution. It provides a streamlined workflow from raw BED files to publication-quality visualizations, including density plots and heatmaps of genomic localization.

## Installation and Environment

Install via Bioconda or pip:

```bash
# Via Conda
conda install bioconda::prooverlap

# Via Pip
pip install prooverlap
```

**Note**: The tool requires both Python and R environments. Ensure R libraries such as `tidyverse`, `GenomicRanges`, and `ggplot2` are installed, as ProOvErlap calls external R scripts for visualization and specific genomic calculations.

## Core CLI Patterns

### 1. Testing Overlap Enrichment (Intersect Mode)
Use this mode to determine if your input regions overlap with target regions more than expected by chance.

```bash
prooverlap --mode intersect \
  --input input_features.bed \
  --targets target_features.bed \
  --background background_regions.bed \
  --randomization 1000 \
  --outfile results.tsv \
  --outdir analysis_plots/
```

### 2. Testing Spatial Proximity (Closest Mode)
Use this mode to analyze the distance between features. To focus strictly on proximity rather than overlap, use the `--exclude_ov` flag.

```bash
prooverlap --mode closest \
  --exclude_ov \
  --input enhancers.bed \
  --targets promoters.bed \
  --randomization 500 \
  --outfile proximity_results.tsv \
  --outdir proximity_plots/
```

### 3. Strand-Specific Analysis
For features where orientation matters (e.g., RNA-seq peaks or TSS), specify the orientation test.

```bash
prooverlap --mode intersect \
  --input in.bed \
  --targets target.bed \
  --orientation concordant,discordant \
  --outfile results.tsv \
  --outdir plots/
```

## Expert Tips and Best Practices

- **BED Format Requirements**: Ensure your BED files contain at least 6 columns. Even if scores or names are not relevant to your specific analysis, placeholders are required. The 5th column (score) is strictly required when using `--RankTest`.
- **Background Selection**: The statistical power of the randomization test depends heavily on the background file. It should ideally be a superset of the regions from which your input features were derived. If a background file is unavailable, use the `--generate_bg` flag to create random intervals.
- **Performance**: For high-resolution analysis or large datasets, increase the `--thread` count to parallelize the randomization process.
- **Overlap Sensitivity**: Adjust `--ov_fraction` (default is 1bp) to define the minimum fraction of the input feature that must overlap with the target to be counted.
- **Visualization**: Use the `--GenomicLocalization` flag to trigger the generation of heatmaps. This requires a GTF or BED file defining genomic regions (e.g., exons, introns, intergenic) via the `--gtf` or `--bed` parameters.
- **Rank Analysis**: If your features have associated intensities (e.g., peak heights), use `--RankTest` to determine if higher-scoring features show stronger overlap/proximity patterns.

## Reference documentation
- [ProOvErlap GitHub Repository](./references/github_com_ngualand_ProOvErlap.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_prooverlap_overview.md)