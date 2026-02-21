---
name: syny
description: SYNY is a bioinformatics pipeline used to investigate gene organization similarity (synteny) between genomes.
homepage: https://github.com/PombertLab/SYNY
---

# syny

## Overview
SYNY is a bioinformatics pipeline used to investigate gene organization similarity (synteny) between genomes. It identifies conserved pairs of protein-coding genes using DIAMOND homology searches or infers collinearity from pairwise genome alignments using minimap2 or MashMap3. Use this skill to assist with genome annotation improvement, ortholog/paralog differentiation, and evolutionary distance analysis through the visualization of genome reorganization events.

## Installation and Setup
The preferred method for installing SYNY and its dependencies is via Conda:

```bash
conda create -n syny
conda activate syny
conda install syny -c conda-forge -c bioconda
```

## Command Line Usage
The primary entry point for the pipeline is the `run_syny.pl` script.

### Basic Execution
To run the pipeline on a set of GenBank files:
```bash
run_syny.pl -a *.gbff.gz -o output_directory
```

### Common Workflow Patterns
1. **Homology-based Synteny**: Reconstructs protein clusters from gene pairs identified via DIAMOND.
2. **Alignment-based Synteny**: Uses `minimap2` or `MashMap3` for pairwise genome alignments.
3. **Visualization**: Generates multiple plot types to represent collinearity:
   - **Circos plots**: Circular representation of genomic links.
   - **Dotplots**: Traditional 2D alignment visualizations.
   - **Heatmaps**: Standardized metrics of similarity.
   - **Linemaps**: Linear comparisons between chromosomes.

### Expert Tips
- **Input Formats**: SYNY works best with GenBank (`.gbff`) files but can also handle GFF3 annotations if they are properly sorted by start positions.
- **Memory Management**: For large genomes or high-density comparisons, ensure sufficient RAM is allocated for the DIAMOND homology search phase.
- **Customization**: Use the `Utils/` directory scripts for specific file conversions or subsetting data before running the main pipeline.
- **Large Chromosomes**: Recent updates (v1.3.2) include fixes for handling chromosomes larger than 1Gb.

## Reference documentation
- [SYNY GitHub Repository](./references/github_com_PombertLab_SYNY.md)
- [Bioconda SYNY Package](./references/anaconda_org_channels_bioconda_packages_syny_overview.md)