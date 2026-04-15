---
name: kernel_density_plots
description: This tool generates kernel density estimates and closest-neighbor histograms from aligned SNP sequences to visualize genetic distances and population structure. Use when user asks to visualize genetic diversity, identify population stratification, detect outbreak clusters, or analyze transmission patterns using SNP distance distributions.
homepage: https://github.com/kapurlab/kernel_density_plots
metadata:
  docker_image: "quay.io/biocontainers/kernel_density_plots:0.1--pyhdfd78af_0"
---

# kernel_density_plots

## Overview

The `kernel_density_plots` tool is a specialized Python utility for genomic epidemiology and population genetics. It transforms aligned SNP sequences into visual and statistical representations of genetic distance. By calculating pairwise distances across a dataset, it produces kernel density estimates that reveal population stratification (e.g., lineages or clades) and closest-neighbor histograms that are critical for outbreak detection and transmission analysis. This tool is particularly effective when integrated into workflows involving `vSNP3` or other phylogenetic pipelines.

## Installation and Setup

The tool is available via Bioconda. It is recommended to run it within a dedicated environment:

```bash
conda create -n kernel_density_plots kernel_density_plots
conda activate kernel_density_plots
```

## Command Line Usage

The primary script is `kernel_plot.py`. It requires an aligned FASTA file as input.

### Basic Analysis
Run a standard analysis with default parameters (bin size of 10):
```bash
kernel_plot.py -f alignment.fasta
```

### Customizing Output and Resolution
For specific studies, such as high-resolution outbreak investigations, adjust the bin size and provide a lineage identifier for organized output:
```bash
kernel_plot.py -f alignment.fasta --lineage "Outbreak_Alpha" --bin-size 5 --output-dir ./results
```

### Key Arguments
- `-f, --fasta`: Path to the aligned SNP FASTA file (Required).
- `--lineage`: A string used as a prefix for all output files and plot titles.
- `--bin-size`: Integer defining the histogram bin width (Default: 10). Use smaller values for datasets with very low SNP diversity.
- `--output-dir`: Directory where results will be saved.

## Interpreting Results

### Kernel Density Plots (`*_density_plot.pdf`)
- **Unimodal (Single Peak)**: Indicates a homogeneous population or a recent clonal expansion.
- **Bimodal/Multimodal (Multiple Peaks)**: Suggests a structured population with distinct genetic subgroups or lineages.
- **Peak Separation**: The distance between peaks represents the genetic boundary between different clusters.

### Closest Neighbor Histograms (`*_closest_neighbor.pdf`)
- **Peaks at 0-10 SNPs**: Often indicative of recent transmission events or outbreak clusters.
- **Intermediate/High Distances**: Represents background population diversity or genetically distinct "singleton" strains.
- **Threshold Setting**: Use the distribution of closest neighbors to establish epidemiological cutoffs for defining related cases.

## Expert Tips and Best Practices

1. **Data Quality**: Ensure your FASTA alignment is high-quality. Recombination or poor reference selection can artificially inflate distances and create misleading peaks in the density plot.
2. **Bin Size Optimization**: If your closest neighbor plot shows all data in a single bar at 0, decrease the `--bin-size` (e.g., to 1 or 2) to see the fine-scale distribution of SNP distances within an outbreak.
3. **Statistical Validation**: Do not rely solely on the PDFs. Review `*_density_stats.txt` and `*_neighbor_stats.txt` for the median, mean, and variance values to support your visual interpretations.
4. **Root Sequences**: The tool generates a `*_no_root_*.tab` matrix. If your alignment includes a distant outgroup or reference "root" that skews the density plot, use the data files that exclude the root for a clearer view of the ingroup diversity.

## Reference documentation
- [Kernel Density Plot Tool Overview](./references/github_com_kapurlab_kernel_density_plots.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_kernel_density_plots_overview.md)