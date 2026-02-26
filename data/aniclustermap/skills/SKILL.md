---
name: aniclustermap
description: ANIclustermap performs all-vs-all Average Nucleotide Identity calculations and generates clustered heatmaps and dendrograms for microbial genome comparison. Use when user asks to calculate ANI between genomes, generate a genomic clustermap, or perform hierarchical clustering of microbial sequences.
homepage: https://github.com/moshi4/ANIclustermap/
---


# aniclustermap

## Overview

The `aniclustermap` tool is a specialized bioinformatics utility designed to streamline the comparative analysis of microbial genomes. It acts as a wrapper that integrates ANI calculation engines (fastANI or skani) with statistical clustering (UPGMA) and visualization libraries (Seaborn). 

This skill allows you to process a directory of genome files to produce three primary outputs:
1. A visual clustermap (PNG/SVG) showing genomic relationships.
2. A clustered ANI matrix (TSV) for downstream statistical analysis.
3. A Newick format dendrogram (NWK) representing the hierarchical clustering.

## Installation and Requirements

The tool requires Python 3.9+ and either `fastANI` or `skani` installed in the environment path.

```bash
# Installation via Bioconda
conda install -c conda-forge -c bioconda aniclustermap
```

## Core CLI Usage

### Basic Command
To run an all-vs-all comparison with default settings:
```bash
ANIclustermap -i ./genome_directory -o ./output_results
```

### Performance Optimization
For large datasets, switch the calculation engine to `skani` and specify thread counts:
```bash
ANIclustermap -i ./genomes -o ./results --mode skani --thread_num 16
```

### Visual Customization for Publication
To create high-resolution, annotated figures suitable for papers:
```bash
ANIclustermap -i ./genomes -o ./results \
    --fig_width 15 --fig_height 12 \
    --annotation --annotation_fmt .2f \
    --cmap_colors "white,orange,red" \
    --cmap_ranges 80,90,95,99,100
```

## Expert Tips and Best Practices

- **Handling "No Similarity"**: If `fastANI` detects no similarity between genomes, the tool outputs `NA`, which is automatically converted to `0.0` for clustering. In the resulting map, these areas are typically filled in gray.
- **Incremental Runs**: The tool reuses previous ANI calculation results found in the output directory. If you have updated your genome files or want a fresh calculation, use the `--overwrite` flag.
- **Color Mapping**: Use `--cmap_gamma` to adjust color intensity. A gamma < 1.0 (e.g., 0.5) makes the color transitions more sensitive at higher ANI values, which is useful for differentiating closely related strains.
- **Discrete vs. Continuous Scales**: For taxonomic clarity, use `--cmap_ranges` (e.g., `70,80,90,95,100`) to create a discrete color scale that aligns with established species boundaries (typically 95-96% ANI).
- **Input Formats**: The tool accepts `.fa`, `.fna`, `.fasta`, and their gzipped versions (`.gz`). Ensure all files in the input directory are valid fasta files to avoid processing errors.

## Reference documentation
- [ANIclustermap Overview and Usage](./references/github_com_moshi4_ANIclustermap.md)
- [Bioconda Package Summary](./references/anaconda_org_channels_bioconda_packages_aniclustermap_overview.md)