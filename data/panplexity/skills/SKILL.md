---
name: panplexity
description: panplexity is a high-performance Rust tool designed to detect repetitive or low-information regions within pangenome graphs.
homepage: https://github.com/AndreaGuarracino/panplexity
---

# panplexity

## Overview
panplexity is a high-performance Rust tool designed to detect repetitive or low-information regions within pangenome graphs. It calculates complexity scores across windows of the graph and identifies regions that fall below a specific threshold. This is particularly useful for cleaning up pangenome visualizations, masking problematic nodes for downstream analysis, or performing comparative genomics on graph structures.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::panplexity
```

## Core Workflows

### Identifying Low-Complexity Regions
To find regions and output them in a standard genomic format (BED), use the default linguistic complexity calculation:
```bash
panplexity -i input.gfa -b regions.bed
```

### Preparing for Visualization
To color-code low-complexity regions for visualization in Bandage:
```bash
panplexity -i input.gfa -c bandage_colors.csv
```

### Annotating GFA Files
To produce a new GFA file where low-complexity nodes are tagged with `LC:i:1` and `CL:z:red`:
```bash
panplexity -i input.gfa -o annotated_output.gfa
```

## Advanced Configuration

### Complexity Metrics
- **Linguistic Complexity (Default)**: Measures the richness of the vocabulary in a sequence window.
- **Shannon Entropy**: Measures the information density. Trigger this using:
  ```bash
  panplexity -i input.gfa --complexity entropy -o output.gfa
  ```

### Threshold Tuning
By default, panplexity uses an "auto" threshold based on the Interquartile Range (IQR).
- **Stricter Filtering**: Increase the `--iqr-multiplier` (default is 1.5). A value of 3.0 will only flag extreme outliers.
- **Manual Threshold**: Use `-t` with a specific value (e.g., 0.9) to override the automatic calculation.

### Performance
For large pangenomes, utilize the multi-threading capability:
```bash
panplexity -i input.gfa --threads 16 -b regions.bed
```

## Output Formats Reference
- **GFA (`-o`)**: Original graph with added tags on low-complexity nodes.
- **BED (`-b`)**: Columns: `chrom`, `start`, `end`, `complexity_score`.
- **CSV (`-c`)**: `Node,Colour` format compatible with Bandage.
- **Mask (`-m`)**: A boolean mask (0 for low-complexity, 1 for normal) for every node.
- **Weights (`--weights`)**: The raw complexity weight calculated for every node.

## Reference documentation
- [Panplexity GitHub Repository](./references/github_com_AndreaGuarracino_panplexity.md)
- [Bioconda Panplexity Overview](./references/anaconda_org_channels_bioconda_packages_panplexity_overview.md)