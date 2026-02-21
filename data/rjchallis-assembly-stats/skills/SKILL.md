---
name: rjchallis-assembly-stats
description: The `rjchallis-assembly-stats` tool provides a specialized workflow for assessing the quality of genome assemblies.
homepage: https://github.com/rjchallis/assembly-stats
---

# rjchallis-assembly-stats

## Overview

The `rjchallis-assembly-stats` tool provides a specialized workflow for assessing the quality of genome assemblies. It transforms raw FASTA sequences into a structured JSON format that captures essential assembly metrics, including scaffold/contig length distributions, base composition (GC/AT/N percentages), and connectivity statistics. This data is primarily intended for use with the tool's JavaScript-based circular "snail plots," which allow for a scale-independent, at-a-glance comparison of different assembly versions or organisms.

## Installation

The tool is most easily installed via Bioconda:

```bash
conda install bioconda::rjchallis-assembly-stats
```

## Core CLI Usage

The primary interface consists of Perl scripts that process FASTA files into the required JSON format.

### Generating Assembly Statistics

To generate the standard JSON output for an assembly:

```bash
perl asm2stats.pl genome_assembly.fa > output.assembly-stats.json
```

### Optimized Processing for Large Assemblies

For assemblies with millions of contigs, use the `minmaxgc` variant. This script pre-bins the data to improve the performance of the downstream visualization:

```bash
perl asm2stats.minmaxgc.pl genome_assembly.fa > output.assembly-stats.json
```

## Visualization Components

The generated JSON file is designed to be loaded into the `assembly-stats.html` viewer. The resulting "snail plot" visualizes the following:

- **Longest Scaffold**: Represented by the inner radius of the circular plot.
- **N50 and N90**: Indicated by dark and light orange arcs, respectively.
- **Scaffold Distribution**: Grey segments indicate the cumulative percentage of the assembly contained within scaffolds of specific lengths.
- **Base Composition**: The outer circumferential axis shows GC content (dark blue), AT content (light blue), and Ns (grey).
- **Scaffold Count**: Plotted in purple originating from the center, with white scale lines indicating orders of magnitude.

## Best Practices

- **Pre-binning**: Always prefer `asm2stats.minmaxgc.pl` for large or highly fragmented assemblies to avoid browser-side performance issues during visualization.
- **Naming Conventions**: When using the provided `assembly-stats.html` example, ensure your JSON filenames follow the pattern `<assembly-name>.assembly-stats.json` for automatic discovery.
- **Comparison**: To compare multiple assemblies, generate individual JSON files for each and load them into the cumulative distribution plot view to see differences in N50 and total span on a shared axis.

## Reference documentation

- [GitHub Repository Overview](./references/github_com_rjchallis_assembly-stats.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_rjchallis-assembly-stats_overview.md)