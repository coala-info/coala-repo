---
name: cryptkeeper
description: CryptKeeper is a negative design tool that identifies burdensome open reading frames and unintentional regulatory elements in DNA sequences. Use when user asks to identify cryptic ribosome binding sites, predict unintentional promoters or terminators, analyze plasmid stability, or visualize sequence-based expression burden.
homepage: https://github.com/barricklab/cryptkeeper
metadata:
  docker_image: "quay.io/biocontainers/cryptkeeper:1.0.1--pyhdfd78af_0"
---

# cryptkeeper

## Overview
CryptKeeper is a negative design tool that identifies burdensome open reading frames (ORFs) and other unintentional regulatory elements. By calculating ribosome binding site (RBS) strength and integrating promoter and terminator predictions, it helps researchers understand why certain DNA constructs may be unstable or fail to express correctly. It produces both raw data (CSV) and interactive Bokeh plots for visualization.

## Command Line Usage

### Basic Analysis
Run a standard analysis on a linear DNA sequence:
```bash
cryptkeeper -i input.fasta -o output_prefix
```

### Analyzing Plasmids (Circular DNA)
For plasmids or circular genomes, use the `-c` flag. This ensures that regulatory elements spanning the sequence origin (the wrap-around point) are correctly identified.
```bash
cryptkeeper -i plasmid.fasta -o output_prefix -c
```
*Note: Circular mode increases runtime as it extends the sequence to check for wrap-around features.*

### Performance Optimization
Use multi-threading for faster processing of large sequences or complex libraries:
```bash
cryptkeeper -i sequence.fasta -o output_prefix -j 8
```

### Visualization and Plotting
If you have already run the pipeline and only need to regenerate or adjust the interactive Bokeh plot, use the plot-only mode:
```bash
cryptkeeper -p -o existing_output_prefix
```

To adjust the Y-axis scale (burden intensity) for better visual clarity in the plot:
```bash
cryptkeeper -i input.fasta -o output_prefix -t 500
```

## Expert Tips and Best Practices

- **RBS Sensitivity**: The default RBS score cutoff is 2.0. If you are seeing too much "noise" in your burden plots, increase this value using `--rbs-score-cutoff`. Conversely, lower it if you suspect very weak cryptic initiation sites are causing issues.
- **Input Metadata**: While the CLI takes a FASTA file (`-i`), the underlying logic can utilize GenBank annotations if available in the environment or provided via the Python API. For the CLI, ensure your FASTA headers are descriptive, or use the `-n` flag to specify a sample name for the output files.
- **Interpreting Results**:
    - **Outer Tracks**: Display predicted RBS strength vs. position (the "burden").
    - **Inner Tracks**: Green (promoters), Red (rho-dependent terminators), Purple (rho-independent terminators).
    - **Innermost Track**: Existing annotations (if a GenBank file was processed).
- **Output Formats**: The tool generates CSV files for downstream statistical analysis and a Bokeh plot using the SVG backend, which is ideal for high-quality figure assembly in publications.

## Reference documentation
- [Tool for visualizing unintentional bacterial gene expression from a DNA sequence](./references/github_com_barricklab_cryptkeeper.md)
- [cryptkeeper - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_cryptkeeper_overview.md)