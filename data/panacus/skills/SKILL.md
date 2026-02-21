---
name: panacus
description: Panacus is a high-performance tool designed for the statistical analysis of pangenome graphs.
homepage: https://github.com/marschall-lab/panacus
---

# panacus

## Overview

Panacus is a high-performance tool designed for the statistical analysis of pangenome graphs. It transforms complex GFA (Graphical Fragment Assembly) files into actionable data by computing metrics like pangenome growth (core vs. accessory genome estimation), node coverage distributions, and similarity between paths. This skill should be used when you need to quantify the complexity of a pangenome or prepare visualizations of graph-based genomic data.

## Installation and Environment

Panacus is primarily distributed via Bioconda. Ensure the environment has the necessary Python dependencies if you intend to use the visualization scripts.

```bash
# Install via mamba or conda
mamba install -c conda-forge -c bioconda panacus

# Required for panacus-visualize
pip install matplotlib numpy pandas scikit-learn scipy seaborn
```

## Core CLI Usage and Patterns

Panacus operates on "blunt" GFA files. This means nodes must not overlap; every link (L line) must point from the end of one segment (S) to the start of another.

### Generating Statistics

While the tool supports a report-based workflow, you can invoke specific analysis subcommands directly to generate tab-separated values (TSV) for downstream processing.

- **Coverage Histograms**: Use `panacus hist` to calculate how many base pairs or nodes are covered by a specific number of paths.
- **Pangenome Growth**: Use `panacus growth` to estimate how the total number of discovered nodes or base pairs increases as more paths (genomes) are added to the analysis.
- **Path Similarity**: Use `panacus similarity` to compute the intersection/union metrics between different paths in the graph.

### Visualization

The `panacus-visualize` script (often found in the `bin` directory of the installation or the `scripts` folder of the source) takes the output of panacus commands to generate plots.

- **Common Workflow**:
  1. Run a specific analysis (e.g., `growth`) and redirect to a file.
  2. Pipe or point `panacus-visualize` to that file to generate a PNG or PDF.

### Technical Constraints

- **GFA Format**: Supports GFA 1.0. It specifically recognizes `P` (Path) and `W` (Walk) lines.
- **Graph Topology**: If your graph contains overlaps (CIGAR strings in L lines other than `0M`), you must "blunt" the graph using tools like `vg` or `gfatools` before running panacus.

## Expert Tips

- **Count Types**: When running analyses, pay attention to the count type. You can often toggle between counting `Nodes` (useful for graph topology) and `Bp` (base pairs, useful for biological genome size estimation).
- **Quorum and Coverage**: For growth statistics, use quorum parameters to define what constitutes "core" (e.g., present in 90% of paths) versus "unique" content.
- **Large Graphs**: Panacus is optimized for speed and memory efficiency, making it suitable for large-scale pangenomes (e.g., hundreds of human haplotypes) that other tools might struggle to process.

## Reference documentation

- [GitHub Repository](./references/github_com_codialab_panacus.md)
- [Panacus Wiki](./references/github_com_codialab_panacus_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_panacus_overview.md)