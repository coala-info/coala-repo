---
name: acdc
description: acdc performs automated contamination detection and quality control for single-cell genome data using sequence composition analysis and clustering. Use when user asks to detect contaminants in genomic assemblies, estimate confidence in single-cell data, or visualize species separation in a sample.
homepage: https://github.com/mlux86/acdc
---


# acdc

## Overview
The acdc (automated contamination detection and confidence estimation) tool is a specialized utility for the quality control of single-cell genome data. It leverages tetramer frequency profiles combined with dimensionality reduction (t-SNE) and sophisticated clustering to separate target genomic material from contaminants. By analyzing the sequence composition, it can automatically detect the number of species present and provide a confidence score for the results, which are presented in an interactive HTML5 visualization.

## Installation and Setup
The most efficient way to deploy acdc is via Bioconda:
```bash
conda install bioconda::acdc
```
For advanced features, ensure the following are in your `$PATH`:
- **Kraken**: For database-driven taxonomic classification.
- **RNAmmer**: For 16S rRNA region highlighting and extraction.

## Common CLI Patterns

### Basic Contamination Analysis
To analyze a single FASTA file with default settings:
```bash
acdc -i input_assembly.fasta -o output_directory
```

### Batch Processing
If you have multiple assemblies, list their paths in a text file (one per line) and run:
```bash
acdc -I list_of_fastas.txt
```

### Enhancing Results with Taxonomy
To improve detection accuracy using a Kraken database:
```bash
acdc -i input.fasta -K /path/to/kraken_db
```

### Automated Contaminant Filtering
You can provide external taxonomy annotations (e.g., from BLAST) to automatically flag contaminants. The taxonomy file should be tab-separated: `contig_name [TAB] taxonomy`.
```bash
# Use -x for the annotation file and -X for a regex matching the target species
acdc -i input.fasta -x annotations.txt -X "Target_Genus_.*"
```

## Expert Tips and Best Practices

- **Deterministic Results**: By default, t-SNE can produce slightly different visualizations across runs. Use the `-s` parameter with a specific seed value to ensure reproducible clustering and layouts.
- **Visualization**: The tool generates an `index.html` in the output directory. This is the primary way to inspect results; it allows for interactive exploration of clusters and direct download of 16S sequences if RNAmmer was used.
- **Contig Length**: Tetramer profiling is most effective on contigs of sufficient length. Very short contigs may cluster poorly or appear as noise; consider filtering your assembly by length before running acdc if the visualization is overly cluttered.
- **Memory Management**: For very large assemblies or batch modes, ensure your environment has sufficient RAM for the t-SNE dimensionality reduction step, which is computationally intensive.

## Reference documentation
- [acdc GitHub Repository](./references/github_com_mlux86_acdc.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_acdc_overview.md)